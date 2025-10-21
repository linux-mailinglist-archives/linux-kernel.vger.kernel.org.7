Return-Path: <linux-kernel+bounces-863320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C0BF78B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E48188543F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CBE3446B5;
	Tue, 21 Oct 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of9pNhp3"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FD328633
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062378; cv=none; b=VVA2QEJSjDvV+3MaxzdzmKFYuu22xmwWZuOU1pRyxGUYp4p7v80S5KeAQ//KnvGnoWdHiG8wCt0v5h5XUjoSXxY43T5we9QO6D1HmbI3PIzpZII7Dd3VVOUEb9cCBH039UiG3RnYkdkecKWW4ZDILD9UYZidTczzxGXzht4JBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062378; c=relaxed/simple;
	bh=HY4tmLumu95tnZO0PIKEWZ3nWyj5KlbUgjh5Ls7YHk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/2iiPnBb2L+BIgHRJdjF9WSHUu7l6VfvKfNQ4TqoyvIPBvaj3n11/9FcQk4RAmupqZ4OzbkSYP7hj73G1gtDjcOwdX9azu6SHvQQWKoCnJY6iVK9Ycg/EH8p3NWv50jzew2TTiP2NEYoD8en2ZEa0+7IY6GlHweS0Tr42I4oaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of9pNhp3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso5321634b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062376; x=1761667176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxvY0zACXGHCFvKyeyfV8ZRkEVH8a6vlxZ7eEqgahjc=;
        b=Of9pNhp38cas/U5Dwev06HaXfDmlOII7PgUMrAUCPDizZbSLImI/PliJFlt6icatVP
         wBlIZSmTX8mwyTi7dUFLvJKI1Ezi0+bUL7VEE/6+/0GO8UFIQ/eN2m3HX8AuXaa1QVLc
         0QzIalCu+VgRg0rg5Lnf0p0Nz4RKyVo08EWA38lr6s6VOEFMp77qkxoNsKl/4o7WRR0m
         ZNnTDZjbmaqiunrlXz9Yl8he6SMWv650cDfL642hxUtqeGAF65Ng3Orv9Co5VCq7Cjmk
         0mShyWLcoPtZtYjzGxQJr26jG0gLVYQQW9HedFHXhJngfEolaO/1bRRB8Nhzykr/a3Hw
         c3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062376; x=1761667176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxvY0zACXGHCFvKyeyfV8ZRkEVH8a6vlxZ7eEqgahjc=;
        b=QayJFEr9+iHNNGPw4of1rhCXFfNorqziZnv4CP4K+LT0FfpehKqatxaidZCgV1M40M
         6+opdtkkMdb5F2M9bvcp1TbtcMGpKdVHr5hXfRmRdGs0/TiqgY26FeeKMc/aR+tAvElu
         uDyRn5vSabZulA3rVKP1bdQEa48Z23d3WCGRBHyeoZjKwmlIAq880us5kW4OhLAdrQIG
         T57Zqp4uI9hhXJK0moxoZ2UXT5nJ0/Wq5d87vTswozNoIhiN0OaybfhZtrPwMXlu1a2S
         lUI79bFou6sxKKb8oFby1v2i6LyNFRnIE/XTOqNnAMRjTAdj8IIjugEcTMPK1hyQVHDq
         k8zA==
X-Forwarded-Encrypted: i=1; AJvYcCVxNIYtq1LxTfuQ/eVZfnM7DHdatDTIxj/gbkw6H9RtSSpRzLM/FrNFN47N3tRfKglo26hBOC17Snxmr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PKlPtliwkq4ObTIbTNCKxV3wFmp6hVQJqyMngk4ef7rmybKr
	Wz2aWl1UM/DH4lTa4n3AJpM4r2jUaZqqkATkAS5y5iEa1gYfMX5Ji4f5
X-Gm-Gg: ASbGncumKt8q5WmtI52gOwSYc15GOBjBg0TJC5W9B+/bHS/1j23jT/qBhrabennjwZV
	QWoAFmX/Y2Zh2840m28ygu9wcOKQ5c8EFEcrvKyVKyApnQux3JXchL6xMdzqE80sl8NjWrVzNGa
	6tnwRqXcs9ZCuVD9aa3cEwHyekfb/wnEcU2Hz7fU0al5mCtOlxhdbyaed3Xiui7XPR20pJpcWy4
	AIimBjgQRk0wmfhsrKIpXlv4A3VGVIGzjzkcmf+XmexU9QUpdKfoxMWcNLtbj8to//IrJfnBbJG
	Qc1mJR+6uRuX9fmTz/Q7Kr9HF2ZusvRv88VXeeVUMYMgxER1FlperCMBh0F30Sd1vMVSk3BSWGg
	nbeOS+rkqm1yf2WP3Q73ma0B7KnBmJdCmgA76SxY7wPKqzfqVPbyofn/PlK9vl7ovjzLldUjrvD
	s1kODLQmtLmbbPrQnwPQTy3g==
X-Google-Smtp-Source: AGHT+IFhUOHgURXgjIUJKEgyJevDB1W3rgBXc5OSEt2LXmyI7xcqGgDAfzABEQH8LSRe15j7wdHHFQ==
X-Received: by 2002:a05:6a00:998:b0:781:1b5a:959b with SMTP id d2e1a72fcca58-7a220d315e6mr19933953b3a.30.1761062375385;
        Tue, 21 Oct 2025 08:59:35 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([42.118.149.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff184basm11793032b3a.15.2025.10.21.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:59:34 -0700 (PDT)
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
Subject: [PATCH v17 0/3] leds: add new LED driver for TI LP5812
Date: Tue, 21 Oct 2025 22:59:24 +0700
Message-Id: <20251021155927.140929-1-trannamatk@gmail.com>
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
Changes in v17:
- Dropped direct_mode from ti,scan-mode property.
- Updated logic so that omitting ti,scan-mode now implies direct-drive mode by default.
- Refactor lp5812_parse_led_channel() to simplify function arguments.
- Mark lp5812_cfg as const since it contains only static configuration data.
- Link to v16: https://lore.kernel.org/linux-leds/20251013173551.108205-1-trannamatk@gmail.com/

Changes in v16:
- Renamed property 'ti,operation-mode' to 'ti,scan-mode'.
- Simplified allowed values using regex pattern instead of long enum list.
- Updated description accordingly and noted 'direct_mode' as default.
- Updated core driver to match the binding change.
- Link to v15: https://lore.kernel.org/linux-leds/20251005153337.94025-1-trannamatk@gmail.com/

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

 .../devicetree/bindings/leds/ti,lp5812.yaml   | 246 ++++++
 Documentation/leds/index.rst                  |   1 +
 Documentation/leds/leds-lp5812.rst            |  50 ++
 MAINTAINERS                                   |  11 +
 drivers/leds/rgb/Kconfig                      |  13 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-lp5812.c                | 730 ++++++++++++++++++
 drivers/leds/rgb/leds-lp5812.h                | 197 +++++
 8 files changed, 1249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lp5812.yaml
 create mode 100644 Documentation/leds/leds-lp5812.rst
 create mode 100644 drivers/leds/rgb/leds-lp5812.c
 create mode 100644 drivers/leds/rgb/leds-lp5812.h


base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
-- 
2.25.1


