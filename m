Return-Path: <linux-kernel+bounces-781975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF5B3197D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3918D172135
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D012FE597;
	Fri, 22 Aug 2025 13:24:21 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A693043A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869060; cv=none; b=dhu3WF1RghuL8oWK3DdKzPE+5NruOH6nWNg9LKdTV8Jb8pd/f3hUOFU75jIFUXtRbeThUgBoApxzX3cHLksJfkEKmIOGURUYxHP5vk6lkVEAsxaCkU/y8MXxDURqgf3Fr1CDQGBReoFnPuivgJWFBlKAs8DYZ3PkSw6XayktNaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869060; c=relaxed/simple;
	bh=isJP0LwpNltVD4ln3oiGLB/8LCrIVyDtABbKd8g4b8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RkHDTHppV7QIBypWixm4t97FrZ3kekcHuzXNsCi8sEfknY5plVYAZj3ts+ScD40qQ5oG+8YkMlTKsgBsvFiEb1ppW3YMA0IC7dGy/oJg8rnC+cng4ZPREfQTo0T/enHPAuGJHgYarPoXyGsuQkIuqPxIM/ilLCObO5qmiJu74AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@watter.com>
Subject: [PATCH v8 0/5] iio: mcp9600: Features and improvements
Date: Fri, 22 Aug 2025 09:23:49 -0400
Message-Id: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVvqGgC/32NQQ6CMBBFr2K6dgyC0sGV9zAshjqVJlDItKCGc
 Hcr7l2+//PyFhVYHAd12S1KeHbBDT4B7nfKtOQfDO6eWOVZfs7wWME0hihMPfzuAAYrsljqU2F
 JJa2hwNAIedMm0U9dl8ZR2LrX1rnViVsX4iDvLTvr7/qnMGvIAJGKgkijLen6pBhZDmboVb2u6
 wcmeszDxgAAAA==
X-Change-ID: 20250819-upstream-changes-c89af86743fa
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Andy Shevchenko <abdy@kernel.org>
X-Migadu-Flow: FLOW_OUT

ChangeLog:
v7 -> v8:
  - Style changes in dt-bindings example
  - Simplify some return value checks
  - Move assignment to where it's checked
  - Speeling

v6 -> v7:
  - Separate out the mcp9600 IIR series into its own series as there is
    a lot of conversation around implementation (removed related
    comments from this changelog).

v5 -> v6:
  - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
  - Correct some constraints in dt-bindings
  - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
  - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
  - Cleanup tabs that were converted to spaces
  - Split thermocouple-type default to separate patch

v4 -> v5:
  - None

v3 -> v4:
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Allow fallback compatible in dt-bindings for mcp9601.
  - Based on feedback from Jonathan Cameron <jic23@kernel.org>
    * Be explicit in patch description for fixed width changes.
    * Check chip_info for NULL to quiet warnings from kernel-test-robot
    * Remove "and similar" for long description of MCP9600.
  - Set default 3 for thermocouple in dt-binding
  - Rework open/short circuit in dt-bindings

v2 -> v3:
  - Improve changelogs in each patch
  - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
    * Set register offsets to fixed width
    * Fix typos
    * Future-proof Kconfig changes
    * Convert to using chip_info paradigm
    * Verbiage: dt -> firmware description
    * Use proper specifiers and drop castings
    * Fix register offset to be fixed-width
    * u8 for cfg var
    * Fix % type for u32 to be %u
    * Make blank lines consistent between case statements

v1 -> v2:
  - Break into individual patches

v1:
  - Initial patch to enable IIR and thermocouple-type
  - Recognize mcp9601

Signed-off-by: Ben Collins <bcollins@watter.com>
---
- Link to v7: https://lore.kernel.org/r/20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com

---
Ben Collins (5):
      dt-bindings: iio: mcp9600: Set default 3 for thermocouple-type
      dt-bindings: iio: mcp9600: Add microchip,mcp9601 and add constraints
      iio: mcp9600: White space and fixed width cleanup
      iio: mcp9600: Recognize chip id for mcp9601
      iio: mcp9600: Add support for thermocouple-type

 .../iio/temperature/microchip,mcp9600.yaml         |  57 +++++++-
 drivers/iio/temperature/Kconfig                    |   8 +-
 drivers/iio/temperature/mcp9600.c                  | 151 +++++++++++++++++----
 3 files changed, 187 insertions(+), 29 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-upstream-changes-c89af86743fa

Best regards,
-- 
Ben Collins <bcollins@watter.com>


