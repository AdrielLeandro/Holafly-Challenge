//
//  PokemonTypeTests.swift
//  HolaFly-ChallengeTests
//
//  Created by Adriel Pinzas on 27/04/24.
//

import XCTest
import SwiftUI
@testable import HolaFly_Challenge

final class PokemonTypeTests: XCTestCase {

    func testPokemonTypeColors() {
        XCTAssertEqual(PokemonType.steel.color, Color("Steel"))
        XCTAssertEqual(PokemonType.water.color, Color("Water"))
        XCTAssertEqual(PokemonType.bug.color, Color("Bug"))
        XCTAssertEqual(PokemonType.dragon.color, Color("Dragon"))
        XCTAssertEqual(PokemonType.electric.color, Color("Electric"))
        XCTAssertEqual(PokemonType.ghost.color, Color("Ghost"))
        XCTAssertEqual(PokemonType.fire.color, Color("Fire"))
        XCTAssertEqual(PokemonType.fairy.color, Color("Fairy"))
        XCTAssertEqual(PokemonType.ice.color, Color("Ice"))
        XCTAssertEqual(PokemonType.fighting.color, Color("Fighting"))
        XCTAssertEqual(PokemonType.normal.color, Color("Normal"))
        XCTAssertEqual(PokemonType.grass.color, Color("Grass"))
        XCTAssertEqual(PokemonType.psychic.color, Color("Psychic"))
        XCTAssertEqual(PokemonType.rock.color, Color("Rock"))
        XCTAssertEqual(PokemonType.dark.color, Color("Dark"))
        XCTAssertEqual(PokemonType.ground.color, Color("Ground"))
        XCTAssertEqual(PokemonType.poison.color, Color("Poison"))
        XCTAssertEqual(PokemonType.flying.color, Color("Flying"))
    }

    func testPokemonTypeIcons() {
        XCTAssertEqual(PokemonType.steel.icon, Image("IconSteel"))
        XCTAssertEqual(PokemonType.water.icon, Image("IconWater"))
        XCTAssertEqual(PokemonType.bug.icon, Image("IconBug"))
        XCTAssertEqual(PokemonType.dragon.icon, Image("IconDragon"))
        XCTAssertEqual(PokemonType.electric.icon, Image("IconElectric"))
        XCTAssertEqual(PokemonType.ghost.icon, Image("IconGhost"))
        XCTAssertEqual(PokemonType.fire.icon, Image("IconFire"))
        XCTAssertEqual(PokemonType.fairy.icon, Image("IconFairy"))
        XCTAssertEqual(PokemonType.ice.icon, Image("IconIce"))
        XCTAssertEqual(PokemonType.fighting.icon, Image("IconFighting"))
        XCTAssertEqual(PokemonType.normal.icon, Image("IconNormal"))
        XCTAssertEqual(PokemonType.grass.icon, Image("IconGrass"))
        XCTAssertEqual(PokemonType.psychic.icon, Image("IconPsychic"))
        XCTAssertEqual(PokemonType.rock.icon, Image("IconRock"))
        XCTAssertEqual(PokemonType.dark.icon, Image("IconDark"))
        XCTAssertEqual(PokemonType.ground.icon, Image("IconGround"))
        XCTAssertEqual(PokemonType.poison.icon, Image("IconPoison"))
        XCTAssertEqual(PokemonType.flying.icon, Image("IconFlying"))
    }
}
