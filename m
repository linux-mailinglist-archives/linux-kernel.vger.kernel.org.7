Return-Path: <linux-kernel+bounces-868325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81EC04E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7551A622B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA72F83A2;
	Fri, 24 Oct 2025 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP5q4gcC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C122F7AA0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292644; cv=none; b=Zc74FdNW+wd6B4UzxypwOMWxyuCb6FSNHar2Dmc0WJMKKj0FAC4YSJTUiN/rNP6APTQDsAXDxAMsNJSd9Fbzm0JNEQ6V59DFUCkIKud57SQAZXLQnlwTnuMhH7If0cqVNV+iP6HrzeYxh1tox9zAIOSNyOg9Gc1J0mUZ1KBmG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292644; c=relaxed/simple;
	bh=TJaSEjKE+CKYl2acjXXkTcFRDFXy50ypbA4mzY0NH34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rs/+qiFdB3ORlBXYp/SN263eInSuLpLxDjjCxB7yqtL+U8HGV/86mOaYZD85IVLgmBvI8hUvEHlt7nZOxQqA+K0ZSulqe0wZSdj8Z6gpze7acnNN328PQ9h1kkUL+KOQLX4rME3AchzskhgcEUUeBGS3gh6yQcciNR0v4wLGO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP5q4gcC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29490944023so575585ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292640; x=1761897440; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s87dYxMf5XJtMF4s03dPIhXUNwiwE7LkdwCFsT1npMU=;
        b=ZP5q4gcC3LSh6fJQQ85cMsl7bxppXPLHfNYddjsG0af6n4jP0Dc3q8Nfl/2viNFiYa
         O+Etl9RqCFto7gkF1eTpD/hgIsgqVghg5vevZWX991MuDhDI760Si2hxkDfwtUgJvaK3
         BqQsn/4/RY9bEcHl9aM9zaU8Po00rhKhus8ElAV06Dqu1tWePZdrCFbbSf4TBJMvT2Nj
         Rzo0IonbvFZQ/hzSXDXJmCU5aZSm/ZEcikjzIEQaELergGpW/b4LeODvZ+K7U+bLDHiw
         K+y61wf+q1UyHyfySZY4r3mKrKv3dKDm1FxVGkx1+ogDVLH7zsaP5ivJnncNCllelIO7
         2bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292640; x=1761897440;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s87dYxMf5XJtMF4s03dPIhXUNwiwE7LkdwCFsT1npMU=;
        b=op+KFxeW9HEcmZztitv5bJWynj++fgSPe+dsHtSx2P6KbpE/xKq7Ak36wGQ9pAWjXF
         6gLUyN2Jq3rY+tjN67vEMlBjmaeNLnHadL5QQAFva+WRyyf9SehGUgnyhB0qAvixhLhZ
         h3vN5oP/GHuInWCuXjpMEaNcODRa3SUEt3yRNzqJKcWaGqKBaueFJ0EdT6NI5PJxlkd6
         ZjKXr8w0VQU9eBtf1PBZ/608BHMFn+REucJHaRhxXxAKISrd9kV6wA7KIq27Y40TZKXz
         tb27K9ciuFEhh/kLoK6G3tpG5lRrKddXZqurBzCN7Ms8+sWRS6da6ly+Uiv8631hNdab
         hLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTYyKLsQgjzkHsIoh4/t43/LGpHR0Cpy1Ml5ggHPuG1HEKiBNvDLuMkghq3jrrnUeuhzY47MK1uZMVvkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtxBY6KVCwl0NTY2DDGBC+gZ2wyDa2cGV4dghNuh8nOJ6WrJg
	5o0FKDfUsfYtPN+bc+2JPc7ajAp4iI6j37XMzYf/3ehr4+7gNp7ZL7kX
X-Gm-Gg: ASbGncvesPtoxAMMn2jEEjWXmwRp5XRNHVKb1MSKP/3U8Zohuffl99yGAPi2vljmgk0
	A8ybMxc5WG6xa2unc71GEJhsD2SYUvwGn15Ys37qS5jyc4Idq2cEOf0Zjv8rcnt1s9i8zrb8KRb
	yBAN5SRClmbPLIr3HOkDQe1UVjH0aJm6VUY6oWsEli0csPxef7OPBcD9JqU1+ZIgmvzqmfI0qqp
	4WZbajTgBG42S+9No/hDEanBBn8CCZvxRUWYcBHZnJ+SVGdASEn4gmwcxCgIz5g1D97+kKtjW1K
	9mcrHiiKd4iBolH4ajgCj8OUDFID/m7TUy1HrOCc91ZCF70V1tC5oYzj21xm8vTNF3NondpzwPN
	eCS3i2G/9fuWV2P7gmO0f+MVVzQJ7EjGlinhO8djpMQa7NRPj7d1aKj9WrWd4G30dpSVo4cuOaA
	aFY5mQkM91RYypoQMKeSgn6RAxhKnu1wg=
X-Google-Smtp-Source: AGHT+IEdrf9PFaVdu2IVtpCx1gbcOMrajzzsslPU/SnB8ZKTCBPtAF+KqI/4qBnjQdn1ghA3PMmmeA==
X-Received: by 2002:a17:903:8c7:b0:26b:3aab:f6bf with SMTP id d9443c01a7336-290cc2f83fcmr355173915ad.42.1761292640576;
        Fri, 24 Oct 2025 00:57:20 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dfd045esm46608205ad.64.2025.10.24.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:57:20 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v5 0/3] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Date: Fri, 24 Oct 2025 07:57:07 +0000
Message-Id: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQx+2gC/13QwWoDIRDG8VcJnjtBR121p75H6MG6Y3agmw1rk
 JSw714TShM8fgO//2FuotDKVMT77iZWqlx4ObVh33YiTfF0JOCxbYESrbQqwIWhjFNiWOZ4hiB
 d9sZlZ7UUzZxXynx99A6fbU9cLsv688hXdb/+lVB3papAwRBsGohics5/HOfI3/u0zOJeqvjUQ
 fpeI0hwGND5II3H3Gv9r5VUqte66WC8o4wjWRt6bV51/4Nqms5jGnSM9CW9ftXbtv0CjbTk9mQ
 BAAA=
X-Change-ID: 20250519-ti-sdhci-omap-907f847f7530
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
property typo for a DTS file.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v5:
- Removed "ti,needs-special-reset", "ti,needs-special-hs-handling" and
  "cap-mmc-dual-data-rate" properties from sdhci node and YAML.
- Removed if conditon for the property "ti,needs-special-reset" from YAML.
- Link to v4: https://lore.kernel.org/r/20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com

Changes in v4:
- Removed type for the property pinctrl-names.
- Link to v3: https://lore.kernel.org/r/20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com

Changes in v3:
- Reverted the changes on removing ti,needs-special-reset, ti,needs-special-hs-handling
  cap-mmc-dual-data-rate from the DTS.
- Fixed a typo to resolve the errors identified by dtb_check.
- Changed commit message to justify the modified changes.
- Defined if-then statements for compatibles to add required properties.
- Removed "ti-hwmods" property from the YAML.
- Link to v2: https://lore.kernel.org/r/20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com

Changes in v2:
- Changed MAINTAINERS to "Kishon Vijay Abraham".
- Renamed the YAML file name to "ti,omap2430-sdhci.yaml" from
  "sdhci-omap.yaml".
- Dropped unnecessary or unused properties from DTS and made these
  changes as a seperate commit as there is no user of it.
- Removed previously defined properties like ti,needs-special-reset,
  ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the YAML.
- Changed the commit message to elaborate the reasons for modifications.
- Removed the pattern property for pinctrl and redefined it in a regular format.
- Modified the description of the property "clock-frequency".
- Changed the subject line for the binding patch.
- Link to v1: https://lore.kernel.org/r/20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com

---
Charan Pedumuru (3):
      arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      arm: dts: ti: omap: Drop unnecessary properties for SDHCI node
      dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
 .../devicetree/bindings/mmc/ti,omap2430-sdhci.yaml | 169 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts        |   2 +-
 .../ti/omap/am335x-sancloud-bbe-extended-wifi.dts  |   1 -
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi           |   2 -
 arch/arm/boot/dts/ti/omap/am33xx.dtsi              |   1 -
 arch/arm/boot/dts/ti/omap/am4372.dtsi              |   1 -
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi           |   2 -
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |   2 -
 arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts  |   1 -
 10 files changed, 170 insertions(+), 54 deletions(-)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250519-ti-sdhci-omap-907f847f7530

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>


