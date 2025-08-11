Return-Path: <linux-kernel+bounces-761953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12859B2005B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137CB1898D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF222DA763;
	Mon, 11 Aug 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpktz2VG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620952DA749;
	Mon, 11 Aug 2025 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897539; cv=none; b=ClIKrmU2LKSqRQoN/p0Bz63v+l7QwuW0t56Vp6FKTs5ydPn8Aj0Ms4XTYDTXvs+kTrI+JwCJEHkYTCOFnY0+jzN3pL1NhNdYkIzICPzf/mfjNoivaJWboVDrxWF61svr4Bwtqsia2kBiYQh1/nCBfUX0oH9FVx0Yme2KrUTdCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897539; c=relaxed/simple;
	bh=oFZ75lZuyiQqjqpbDkCREZvA3cjEzUpuIBH1uakv9io=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB+VQ7sC65DbZQ51nSDIsUZluS4WNcHI5W6SRbqmhJeEVJVtBJh6gVAz45i/c4AHsK7jEPU+yA9d2owU2QIlrXbmNqPs4b/TLHCRc4Or+quwAczE9zLogssuhpA70l7Ci7jc8+vqOkCTxpxrEaNCgO/aY5DMD0QM5AEo88S1XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpktz2VG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-242d3ba2b44so10122585ad.3;
        Mon, 11 Aug 2025 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897538; x=1755502338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx0HUPagVnZ+U8BFdJ9INMhdQD62bMvRUffwK7m8W24=;
        b=Wpktz2VGqjlD6nGo2/bX7HG1ED9R25INl+Wl2BmiYP0ixod16hZNIGqEgxvz9O7OO7
         QtGnUkLrVf4kqs3PJfl9Pj1ObJuJgqS1QApKVBQizcxnTWm+0296alnOuCDp6n4DAzV1
         R1RW+QaHf5zvmR1WyFkztxOcxd3J96xF0PTrApw6BexJkIUdkzqmR5jihLT8UMonoN0g
         1DudQzkw1aqNzpKBfqLKIYdcC2cPKDZGw/osndse1y7VnKI6sch35wTcy4RvDbyKHR5W
         7AAbP6Ac7tAmthX0ILsv+nic3IpOBhE3EcItLCJMEIP0Qi2PP3T2uYu2xtVe9G037CkU
         rf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897538; x=1755502338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx0HUPagVnZ+U8BFdJ9INMhdQD62bMvRUffwK7m8W24=;
        b=xBChI4MFdcOBEQ5GP1ktxoJn7to8wal+YkpAKtCNCiWQw1qnol7xiTcQef8fzygvbI
         S37+EdXwS6eu2GiQLEeFpnDjN/rK96sedkYH33Nc/HSjzP1Jvp7kwJjvQoAkPUvFHnw0
         amohH6So20CDmrL5E9SuLlaNsZSRrAPZTAaWZMKFHdS0NaGlbq90bFTnAifDxTcVJYLT
         lEo41Ljg57jzgmBEQbGa/xqvzR2T5l4Zxwn3AreScXOe+SMhCLurCK24Xc7Pdy5ZY513
         Wc6el0GJTubHdwFZqaH0sqz513pbOr98i+jdqV7UUU7nKpbmbWDd6OrA/lBTPF6dHbpz
         2hlA==
X-Forwarded-Encrypted: i=1; AJvYcCWKwipm7hEqIQuhIczolvbnHY1hDjFaV560uUOROYy/XiTAOA8twwa94J2u2z1D7zImF6qCOvzUzMln4rnk@vger.kernel.org, AJvYcCX2jNuWlb/JLDkxrlsVZfCmuh7Ndlgkw3S5rWjbcJze6oB8+M90WRp/+r8Fz6E7NyFa6Y7d04ZEbtx0@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmRMkkhFnUkWJQOPIZONnMh9HpfNZsjiO6oRFTZo/riY+Q3Em
	TCAaVkEpvWh7FG31dzfE4BZ27gTS4B3qQ0c8NYGMnzdUr5/ZpLxrQQ8Nk2Mm+Ybz
X-Gm-Gg: ASbGncvO9uRLew27k+bwjmncd3aSaRQtsILjjlKhzaKwD1lGOnspWx2LAjT7mIYOirw
	yJVOSn/zmmkDndJKu483opuIZwTTjJSKmHEFnl7CiQGHmm+yJL+uWnxWp6cQAlk1wKTW5/StVB/
	MKxu4AE4hDKc2EcDZ30NawM+ejqRYO+JnBvAKUjM2mSSm0CYTXw1sVdHosLHm5hxVu6A740kLh/
	oHtaodW3vCVJOpsRqkwd+C2/KL9A9mqlSzFX/Z2brZ8z9I/CvL5GhQl1AmJNBMym/uodesxo0Ev
	XH3ADCZDCbiHtKBmof695SyoljTIeWV5oBxTW1OJ+U+07pbNbJ7LCU2Y0ozJhrHYAo1tWXHr8DR
	9vZlW5dRI5hKTmCsnz+iJlPdhYqsayLGkwLnPQRqZ6M1B6HyuLdaksNrlJcKqWSCEJDMia+mtue
	b4JVCrV+19pee0vQ45xqgowOC6kXz4
X-Google-Smtp-Source: AGHT+IHw5o+Jkau6vl+zzP8wniWy1wnCha+yKhslleKKvxim75ReWEWO0PXV/5b8z7D2bbPKCN7MKw==
X-Received: by 2002:a17:902:ebc6:b0:242:9bbc:3644 with SMTP id d9443c01a7336-242c225a177mr160057395ad.54.1754897537580;
        Mon, 11 Aug 2025 00:32:17 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:17 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: harma: revise gpio name
Date: Mon, 11 Aug 2025 15:32:07 +0800
Message-ID: <20250811073208.787063-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
References: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update GPIO label definitions in the device tree to reflect the correct
power and control signal names. This includes:

- Rename "fcb0-activate" to "fcb1-activate" and "fcb2-activate"
- Add labels for:
  - power-p3v3-standby
  - power-p1v8-good
  - power-pvdd33-s5
  - power-pvdd18-s5
  - power-asic-good
- Replace unnamed GPIOs with appropriate labels such as:
  - irq-pvddcore0-ocp-alert
  - irq-pvddcore1-ocp-alert
  - smi-control-n, nmi-control-n, etc.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 741d2d9b6d03..2622954d0ce3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -234,7 +234,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb1-activate",
+		"","fcb2-activate",
 		"","";
 	};
 };
@@ -308,7 +308,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb0-activate",
+		"","fcb1-activate",
 		"","";
 	};
 };
@@ -698,14 +698,14 @@ &sgpiom0 {
 	"","",
 	/*A4-A7 line 8-15*/
 	"","power-config-asic-module-enable",
-	"","power-config-asic-power-good",
-	"","power-config-pdb-power-good",
+	"power-p3v3-standby","power-config-asic-power-good",
+	"power-p1v8-good","power-config-pdb-power-good",
 	"presence-cpu","smi-control-n",
 	/*B0-B3 line 16-23*/
 	"","nmi-control-n",
-	"","nmi-control-sync-flood-n",
-	"","",
+	"power-pvdd33-s5","nmi-control-sync-flood-n",
 	"","",
+	"power-pvdd18-s5","",
 	/*B4-B7 line 24-31*/
 	"","FM_CPU_SP5R1",
 	"reset-cause-rsmrst","FM_CPU_SP5R2",
@@ -749,7 +749,7 @@ &sgpiom0 {
 	/*F4-F7 line 88-95*/
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
-	"","uart-control-buffer-select",
+	"power-asic-good","uart-control-buffer-select",
 	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
@@ -809,7 +809,10 @@ &sgpiom0 {
 	/*N4-N7 line 216-223*/
 	"","","","","","","","",
 	/*O0-O3 line 224-231*/
-	"","","","","","","","",
+	"","",
+	"irq-pvddcore0-ocp-alert","",
+	"irq-pvddcore1-ocp-alert","",
+	"","",
 	/*O4-O7 line 232-239*/
 	"","","","","","","","",
 	/*P0-P3 line 240-247*/
-- 
2.25.1


