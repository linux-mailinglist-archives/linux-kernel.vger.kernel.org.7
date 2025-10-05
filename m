Return-Path: <linux-kernel+bounces-842346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003DBB98D5
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C783B82B6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1E288C30;
	Sun,  5 Oct 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg1//RrH"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B434BA5F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678456; cv=none; b=PnmDCpN7xkhLcaMBxtjIV9Pg6sOm59a7/w/gmQNGJHlIzLPOBifFKwkLQGWYbNaIak+xCfo6XTZGfbTx2WE1ThNEdknyl07b2By3xKe3GOGv/FidHn1sPXCxapP8GQUG2Ii3pvQZ+1Y3EAE0JXgn/0oOIEUAwlW0L9tz++GPoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678456; c=relaxed/simple;
	bh=iQzbIk/slWn5/cU1rgoZthfG/8WPBtURHYwSxxo4UCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6MXZLPDD/o7Rrs5RV6v/sEsY+cGMontP20p5KeRppWg5DU47PssQlZvFuq5HFLkbIGEYjQkzDICo5Z8270bRAFLuROs/xhXSVlyLOOvZ32OzQSuI6FcJoOvdKp1eEB0hGMtxGRAVOhsW17vftN7CE6Vz7KCrUxSP33OwdYEjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg1//RrH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-336b9473529so3935767a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759678454; x=1760283254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jq20lgfp4UGyan5UUuybwgG1UfvUvtqwvi+Sl755tg8=;
        b=Lg1//RrHGUqE2IXiXuFqhBdNP9O0Us/OZ5rouP1MTNKSLDn34AR/b1mWdCGPhcQATI
         d+U5a+6i+PAXdJBzxrYHBCn6EYX8JMpt0WMERP0bOFd7xnpeFJggDQSGz6HSRr2YgLSw
         tqLoSEhC6VpDznX1G6guLmdJGv5srZ5InOFC28an9K6nTbInjWfHQ7z3Lep7jSfmqqW1
         yJesposhqeVVWL241gEB2w5n7MLpA8YvnhfGozESPDEs4HM4KXpb/o8ucNPrze4g15QC
         2jHzrOW+clTYZmuLKQ8jmOiLxyrzumSQnNbMz9ObYLNwGVhRiFvZIfDs3yXVha1ySOYA
         DnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759678454; x=1760283254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq20lgfp4UGyan5UUuybwgG1UfvUvtqwvi+Sl755tg8=;
        b=qqe1DyF+UAMnUGycgD4qPhzFKXWwNFBId3UAyroqWKv+a/oI2+LkRseb5A8oFTCTZR
         5wg19BCW22UaEVy0CDMr+6Zdx09rSGTler93nKCTuE99AQFiqLnyEijSau0sgDDFgGJ+
         BYptdHXIPrM2qHWtQBznWQdTFfnuNWBgmfi9HgWyfMIJRuGvPpWuD6Gkoc7qbz1fQMNJ
         mLldG/PPWxi9f4JrzNx5enAkXzG7A1Ujhazs1+4FYguYyB1yRN/gp7V93G0Y2lr5UhYg
         pImn7bQMGRVd8x3y+YEPx6bRO1pRraY68R9ZeezGF/QigMVKce/WcTZudGEbIZePzsdJ
         qpFw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZZP6Dwy0kH7xoVKEbbkwtU4YBeVAh9Q8mYPMmxH+iFuCzO9ygc3SEkqLAe1e61ABCIMPbO9K4c2ADWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnOhZPJ2D9deub9rstJlB1mydgt2II4x8fIVhqQn2aYJWghrt
	H+70fopLA6DkN5gaoAOXISvotAc4+TsSlEVXToR+FTj6cAY2wfDMQimH
X-Gm-Gg: ASbGncv+E27YKKwvyZ7PWxcERH5c+dvs977hpPHKvuQ6+VfDgro9Pu8TOhd1qHuPoyl
	F6t3iv3mLay75wtdyfu60/mPcPNA7NsKlNd2NUb32b2fuLdWLx1PmapU9SmSjzjBTC+HNJZ9lbR
	1SQZqgks83nAvWujCEGVcamrxIWjK6UlpLIrNoXTJQmljTNrkLljTAi4YcbF0GRB1YzUfpBrcIH
	pMEgu+6lKdwHo7KX42mb+mT/EZAMLatB7WmJ8mhI2RU1zEIkswfkzRE4pDjvftZA0p+G/oeCtKj
	zws6Udhd49OlGHN7GeX8mZqDRMSSR08juAG+MmzbzbY0vlgRHbHYm4b+/uEYIHRuh89ZP3Ww54+
	kFvQOqTj+3McCBiNMaQQlls3yRk6aotQQQUorbvDm41+QdPMhncr2pkg=
X-Google-Smtp-Source: AGHT+IGnVudF+tfMNdkzzgHsLDgqv6dF4h9vKHcDlsWU+rTkf+wyR+VO4Q7ela5gq+4AWbEeTvyaGw==
X-Received: by 2002:a17:903:1a0d:b0:267:44e6:11d6 with SMTP id d9443c01a7336-28e99bab52emr119306445ad.6.1759678453456;
        Sun, 05 Oct 2025 08:34:13 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([58.187.66.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d9csm105555965ad.2.2025.10.05.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:34:12 -0700 (PDT)
From: Nam Tran <trannamatk@gmail.com>
To: lee@kernel.org
Cc: pavel@kernel.org,
	gregkh@linuxfoundation.org,
	rdunlap@infradead.org,
	christophe.jaillet@wanadoo.fr,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nam Tran <trannamatk@gmail.com>
Subject: [PATCH v15 0/3] led: add new LED driver for TI LP5812
Date: Sun,  5 Oct 2025 22:33:34 +0700
Message-Id: <20251005153337.94025-1-trannamatk@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds initial support for the TI LP5812,
a 4x3 matrix RGB LED driver with autonomous engine control.
This version provides a minimal, clean implementation focused
on core functionality only. The goal is to upstream a solid
foundation, with the expectation that additional features can
be added incrementally in future patches.

The driver integrates with the LED multicolor framework and
supports a set of basic sysfs interfaces for LED control and
chip management.

Signed-off-by: Nam Tran <trannamatk@gmail.com>
---
Changes in v15:
- Removed all custom sysfs attributes; driver now fully relies on standard LED multicolor class interfaces.
- Added new device tree property `ti,operation-mode` to configure direct, TCM, and mix scan modes.
- Dropped previous Reviewed-by tag from the binding patch due to property addition.
- Removed ABI documentation since no new sysfs entries are created.
- Updated lp5812.rst documentation accordingly.
- Link to v14: https://lore.kernel.org/linux-leds/20250907160944.149104-1-trannamatk@gmail.com/

Changes in v14:
- Replaced inline constants with proper macros for readability and maintainability.
- Refactored lp5812_read() and lp5812_write() to simplify logic and improve clarity.
- Updated lp5812_fault_clear() to use switch() instead of if/else chain.
- Refactored parse_drive_mode() for cleaner logic, removed string parsing of concatenated data.
- Updated activate_store() and led_current_store() to replace strsep()/kstrtoint() parsing with sscanf().
- Removed redundant comments and renamed variables for better clarity.
- Link to v13: https://lore.kernel.org/lkml/20250818012654.143058-1-trannamatk@gmail.com/

Changes in v13:
- Fixes build warnings reported by kernel test robot:
  - Inconsistent indent in lp5812_probe()
  - Uninitialized variable 'ret' in lp5812_multicolor_brightness()
- Drop of_match_ptr() and directly assign of_match_table, as the driver is DT-only.
- Link to v12: https://lore.kernel.org/lkml/20250728065814.120769-1-trannamatk@gmail.com/

Changes in v12:
- Reordered helper functions above lp5812_probe() for better structure.
- Clarified DT-only support by removing fallback paths and i2c_device_id table.
- Directly assign platform_data to the correct pointer instead of relying on
  string comparisons (LP5812_SC_LED, LP5812_MC_LED) and container_of() casting.
  This simplifies the logic and avoids unnecessary type checks.
- Removed redundant messages.
- Update ABI documentation to reflect reduced feature set.
- Link to v11: https://lore.kernel.org/lkml/20250714172355.84609-1-trannamatk@gmail.com/

Changes in v11:
- Drop autonomous animation and other advanced features; reduce driver to core functionality only.
- Simplify LED parsing to use a unified path.
- Clean up and streamline code
  - Use alphabetically ordered includes
  - Remove redundant comments
  - Fix style issues (e.g., comment capitalization, code placement)
- Update ABI documentation to reflect reduced feature set.
- Link to v10: https://lore.kernel.org/lkml/20250618183205.113344-1-trannamatk@gmail.com/

Changes in v10:
- Address feedback on v9 regarding missing Reviewed-by tag
- Added explanation: binding structure changed significantly to integrate
  with the standard leds-class-multicolor.yaml schema and support multi-led@
  nodes with nested led@ subnodes. This change introduced a new patternProperties
  hierarchy and removed the previous flat led@ layout used in the earlier versions.
  So the Reviewed-by tag was dropped out of caution.
- Address binding document feedback
  - Use consistent quotes
  - Replace 'max-cur' with the standard 'led-max-microamp'
  - Remove 'led-cur' property
  - Fix mixed indentation
- Updated core driver to align with the updated binding schema.
- Address core driver feedback
  - Use for_each_available_child_of_node_scoped() to simplify the code
  - Add a return checks for lp5812_write() and lp5812_read()
  - Remove unneeded trailing commas
  - Fix unsafe usage of stack-allocated strings
- Link to v9: https://lore.kernel.org/lkml/20250617154020.7785-1-trannamatk@gmail.com/

Changes in v9:
- Move driver back to drivers/leds/rgb/
- Integrate with LED multicolor framework
- Refactor and simplify custom sysfs handling
- Extend Device Tree binding to support multi-led@ nodes using leds-class-multicolor.yaml
- Update documentation to reflect the updated sysfs.
- Link to v8: https://lore.kernel.org/lkml/20250427082447.138359-1-trannamatk@gmail.com/

Changes in v8:
- Move driver to drivers/auxdisplay/ instead of drivers/leds/.
- Rename files from leds-lp5812.c/.h to lp5812.c/.h.
- Move ti,lp5812.yaml binding to auxdisplay/ directory,
  and update the title and $id to match new path.
- No functional changes to the binding itself (keep Reviewed-by).
- Update commit messages and patch titles to reflect the move.
- Link to v7: https://lore.kernel.org/linux-leds/20250422190121.46839-1-trannamatk@gmail.com/

Changes in v7:
- Mark `chip_leds_map` as const.
- Use consistent `ret` initialization.
- Simplify the function `set_mix_sel_led()`.
- Refactor `dev_config_show()` and `led_auto_animation_show()` to avoid temp buffer, malloc/free.
- Simplify the code and ensure consistent use of mutex lock/unlock in show/store functions.
- Remove `total_leds` and `total_aeu`.
- Link to v6: https://lore.kernel.org/linux-leds/20250419184333.56617-1-trannamatk@gmail.com/

Changes in v6:
- Add `vcc-supply` property to describe the LP5812 power supply.
- Remove `chan-name` property and entire LED subnodes, as they are not needed.
- Update LP5812 LED driver node to Raspberry Pi 4 B Device Tree, based on updated binding.
- Link to v5: https://lore.kernel.org/linux-leds/20250414145742.35713-1-trannamatk@gmail.com/

Changes in v5:
- Rebase on v6.15-rc2
- Removed unused functions (lp5812_dump_regs, lp5812_update_bit).
- Address Krzysztof's review comments
- Link to v4: https://lore.kernel.org/linux-leds/20250405183246.198568-1-trannamatk@gmail.com/
---

Nam Tran (3):
  dt-bindings: leds: add TI/National Semiconductor LP5812 LED Driver
  leds: add basic support for TI/National Semiconductor LP5812 LED
    Driver
  docs: leds: Document TI LP5812 LED driver

 .../devicetree/bindings/leds/ti,lp5812.yaml   | 290 +++++++
 Documentation/leds/index.rst                  |   1 +
 Documentation/leds/leds-lp5812.rst            |  50 ++
 MAINTAINERS                                   |  11 +
 drivers/leds/rgb/Kconfig                      |  13 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-lp5812.c                | 726 ++++++++++++++++++
 drivers/leds/rgb/leds-lp5812.h                | 197 +++++
 8 files changed, 1289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lp5812.yaml
 create mode 100644 Documentation/leds/leds-lp5812.rst
 create mode 100644 drivers/leds/rgb/leds-lp5812.c
 create mode 100644 drivers/leds/rgb/leds-lp5812.h


base-commit: 6093a688a07da07808f0122f9aa2a3eed250d853
-- 
2.25.1


