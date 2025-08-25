Return-Path: <linux-kernel+bounces-784962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3F4B343F4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BBE1A844CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF7306D3D;
	Mon, 25 Aug 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zo2r49nt"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1442302CB3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132037; cv=none; b=QSEw15JIGBxqYZcgwY9Zu/Wc2DL4lCLJW8bQ50L8EkOb+DMNYq3kpSWu7mvdp8BrtuuaMWVgR7+TMLhVAIvo6GGG0frsbmFxSu1hLZ1KVPPRi19eYCH/lDVSkGCRYBbFEgskErq1oWi6PLII7iw8okONExZHMjRipYEJwF5Zw6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132037; c=relaxed/simple;
	bh=Y56X7oQHuKA4lo20ZsgXO5l4gyfh+4L+P05X7w+y73Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0i7dChfBOFJaT0wk6f+yKG9oo1kHDunlPMuA5CG2eoqVSVfcugzpY+GC2Yo91ePkfoGmWe4KFrTPPEG/7l+uKyuRL4WeHipsps40jhIhKMaCKR/TaSJd83IT2luqtXwCBJknYpw0hcqkZ5zTB5h/PK/0V7FzvQG85LfhU0buoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zo2r49nt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c84aea9d32so649502f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132032; x=1756736832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euKCmjTtqFHDoU6LHakJngU3/m3WiWXa94SHMvLwXS4=;
        b=Zo2r49ntVGfSFLvlXBHgE/hLX4KkpF7bWJpNISHZWyPv6b6qyvs/qO0tsFOuZEt6dv
         qQDL6fj7pRh5kxpIP8n5aZWuCrntP1mxXWzcWyPJXxU3UBACBuXPuFZp1SFFJYC0MMn4
         ntaIVAsbGOWTMKOQ7CYRRoSp/YWHeNO2aXbGN2rpDelP8JW+CoD8SFneP41Jnc8XXV+Y
         x7vTGDv4P+YBbBDEBhKG4FQJBMs18om0SQZKSs1EzWG/YmuDRFLJ21nxeJJomb5uDSnN
         bM364AT2r/NNE+hxjRvDGMx5u7kKOsQaaG5rPxK9luHaaRZ1X2iVexE0AsymfKEUlufL
         tmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132032; x=1756736832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euKCmjTtqFHDoU6LHakJngU3/m3WiWXa94SHMvLwXS4=;
        b=cGatHqvuvPj7t2eqjCNP/d0wm1rj/6XVu/EoUMr7BQGU8JN/QPtOrAi0Sfis+fYZ8+
         JIVBvA3eCugv3Ki6P4CyQg8+R3v3+4neyrsTZrmiZXN7fl7jORPLLTz3v/Hu5QbZM7j8
         SJLjnt9p2nTA3REKiZdmoHhzdvL8h7TkDuxiDUwhQKTLxa+4rxL+0Z1tvSbhdoEbZRlj
         780pKesAU9SK03Jfz+C//A52dSYgD6rS1X+PLqm3b1BOgvvmYq+aTsbb+DkPwwlh5/IL
         vs/KN6fEPX0SXklnUthfN2zPCfPqSzP6RJJgjdbjWq7kEufkhV9k7O2EnhMXLsdbKB3M
         A3hw==
X-Forwarded-Encrypted: i=1; AJvYcCUJAp/WtsBZ8taEIz4L6m1x+b34wwBt+VtK9E/Ui0UPCP4S+KyF1yVmeGUBjHmcZGmz9x1p7tsNIw8cdgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44/jk50ywiHmN4TFn0xU9fjz+E11UC0zML6MBSQzCRSQJ55v6
	mUtmkNr593VO82SycbORn4eMAY5VUrSxvqcyZNwaNJFUcf04Jx3oWv3YX0/m9f/iKhE=
X-Gm-Gg: ASbGncvnCnf3WCRrB+iDwnxBx+Zhm8fC4drHawzaQj3t8EK6BkztFsU2e+hu9BEQWlR
	inDXI/zafqmD4WdMlBlMR1eVIOptG3yBf+rspF+QL3aKz5WdgGmEcSZqBMFKk1SROhizERdkC7f
	SB0nLhykIsxPwxH40m3MjxTyfuY3bvY0xDfkcltQiGpREpLjH+FX0Qcj6d99fLmduFtKd1XXqN6
	m5h7BWDitn1njUmpsaX7T9RWkU8B9XS6XCvUcSB8lCnffGnUZ5pM98InXGW2MQthnLf3ZNuCS4+
	FeSczRh7hnpT71gWq1P63N835Sc6LVtntpA3haOGJFDMGTlPTzZgMW6X6PcsdmLbYbTeort/0b9
	9a8wwKDAlkSUdtXQ4A8uIcpBcO4Cis7eWpxb+
X-Google-Smtp-Source: AGHT+IHzf1zBMogo6qwNYmdim+KUSN44hRz+cqBwGOk4IKKU5b5IVPiFT1z370fUAp1wSCO64WjI8Q==
X-Received: by 2002:a5d:5d0a:0:b0:3b7:792c:e8d9 with SMTP id ffacd0b85a97d-3c5daf023eamr10484620f8f.14.1756132032010;
        Mon, 25 Aug 2025 07:27:12 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:11 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:33 +0200
Subject: [PATCH v2 08/12] clk: amlogic: introduce a common pclk definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-8-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10129; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=Y56X7oQHuKA4lo20ZsgXO5l4gyfh+4L+P05X7w+y73Q=;
 b=kA0DAAoB5vwPHDfy2oUByyZiAGiscrSg+dyaK5A9W6G75hRGdsahgRm0IWxHdlVu6XUqS05L2
 YkCMwQAAQoAHRYhBPThWa4Y8/VtXxu3G+b8Dxw38tqFBQJorHK0AAoJEOb8Dxw38tqFUfAP/00z
 URL2EFIIxTrVtSV8q0c1qew6G9U3/f7ug8TWr3aww8AIbXna9bL0bI3ZZsGE+NBNygyFS1cU5Ci
 /l8SouTRGvRqGiIFgdO2cxKyserGsTNsI37O4fzaS2oCrpWZAFu2HbKiDMO06n4PCJzNkG7Db5F
 W8TkUSV35yriuAdzITs4thtIPG9wgqxdox3PlEcEbuW+CCsDPztuesf1di8ZfXs2fYeWHr+JdRF
 eDcWEUisLEQ4zb/kYQyasnDLgKmcAKfGwTVQtsHZjDKl7SkN7twuC55IbT8Cv+OV932F8Vta1n6
 XzO1BVkwXO/zx5axgByF3NjX+gQW9TmXCxLF8riPt8cCKwUaVvOQGST/16Q5839+vEkkrIugEL3
 MSDpZJmC/mDYM1w/5yglgWwnpzyX2mvr+v/QO9q4SV8k6ElpwEmxIg2LKJO+3skK50mxRn9nmmj
 MV+nRJ8P1mZCNOqA3s3EXBcFKVeNE6TxTGb2a/nmUUHNCacmDq5Qq9IRYy88uElt7vuTVbC8ipL
 zo/+xSZ9mZHQRjoig1Hnz247XfteEnd52uryqPPkhTwtXcSXsexa2b6ZSTpFVzm9xHvHOg0bkWK
 R/ca5uwteWQ/ZGL/vzYyJ9q8xDe556e04lv4AidECCb4Nelr8zFmWawAnmVifVVgymwcPZ5xv3d
 gLksK
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

All Amlogic peripheral clocks are more or less the same. The only thing
that differs is the parent data.

Adapt the common pclk definition so it takes clk_parent_data and can be
used by all controllers.

Reviewed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/a1-peripherals.c   |  4 +++-
 drivers/clk/meson/axg.c              |  4 +++-
 drivers/clk/meson/g12a.c             |  6 ++++--
 drivers/clk/meson/gxbb.c             | 26 +++++++++++++++++---------
 drivers/clk/meson/meson-clkc-utils.h | 12 ++++++------
 drivers/clk/meson/meson8b.c          | 31 ++++++++++++++++++-------------
 drivers/clk/meson/s4-peripherals.c   |  4 +++-
 7 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index a7bd3822df18f5e043e58e2d7bbcaa24345ea404..5e0d58c01405c1925a5c25ee6d0a547fd2e69911 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -1840,8 +1840,10 @@ static struct clk_regmap a1_cecb_32k_out = {
 	},
 };
 
+static const struct clk_parent_data a1_pclk_parents = { .hw = &a1_sys.hw };
+
 #define A1_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(a1_##_name, _reg, _bit, &a1_sys.hw, _flags)
+	MESON_PCLK(a1_##_name, _reg, _bit, &a1_pclk_parents, _flags)
 
 /*
  * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index fd9a7a362a1be1d8a584f855f454daa354ae2ade..0a25c649ef1d4847fad1ebb7bc4bd8c16c83d4d0 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -1915,8 +1915,10 @@ static struct clk_regmap axg_gen_clk = {
 	},
 };
 
+static const struct clk_parent_data axg_pclk_parents = { .hw = &axg_clk81.hw };
+
 #define AXG_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(axg_##_name, _reg, _bit, &axg_clk81.hw, _flags)
+	MESON_PCLK(axg_##_name, _reg, _bit, &axg_pclk_parents, _flags)
 
 /*
  * Everything Else (EE) domain gates
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index bfa8815647aee9f8c0b373a36b8b9ae5380c759e..348aff4fae68bf3f856e70de5fa4f687e3d8144f 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -4384,11 +4384,13 @@ static struct clk_regmap sm1_nna_core_clk = {
 	},
 };
 
+static const struct clk_parent_data g12a_pclk_parents = { .hw = &g12a_clk81.hw };
+
 #define G12A_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(_name, _reg, _bit, &g12a_clk81.hw, _flags)
+	MESON_PCLK(_name, _reg, _bit, &g12a_pclk_parents, _flags)
 
 #define G12A_PCLK_RO(_name, _reg, _bit, _flags) \
-	MESON_PCLK_RO(_name, _reg, _bit, &g12a_clk81.hw, _flags)
+	MESON_PCLK_RO(_name, _reg, _bit, &g12a_pclk_parents, _flags)
 
 /*
  * Everything Else (EE) domain gates
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ccc1490a092814c242e719d4c37c66c4b3e27f07..5a229c4ffae105bc112824f79af5785ff6c5a710 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2721,8 +2721,10 @@ static struct clk_regmap gxbb_gen_clk = {
 	},
 };
 
+static const struct clk_parent_data gxbb_pclk_parents = { .hw = &gxbb_clk81.hw };
+
 #define GXBB_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(_name, _reg, _bit, &gxbb_clk81.hw, _flags)
+	MESON_PCLK(_name, _reg, _bit, &gxbb_pclk_parents, _flags)
 
 /*
  * Everything Else (EE) domain gates
@@ -2817,14 +2819,20 @@ static GXBB_PCLK(gxbb_ao_iface,		HHI_GCLK_AO, 3, CLK_IGNORE_UNUSED);
 static GXBB_PCLK(gxbb_ao_i2c,		HHI_GCLK_AO, 4, CLK_IGNORE_UNUSED);
 
 /* AIU gates */
-static MESON_PCLK(gxbb_aiu_glue,	HHI_GCLK_MPEG1,  6, &gxbb_aiu.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_iec958,		HHI_GCLK_MPEG1,  7, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_i2s_out,		HHI_GCLK_MPEG1,  8, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_amclk,		HHI_GCLK_MPEG1,  9, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_aififo2,		HHI_GCLK_MPEG1, 10, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_mixer,		HHI_GCLK_MPEG1, 11, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_mixer_iface,	HHI_GCLK_MPEG1, 12, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
-static MESON_PCLK(gxbb_adc,		HHI_GCLK_MPEG1, 13, &gxbb_aiu_glue.hw, CLK_IGNORE_UNUSED);
+static const struct clk_parent_data gxbb_aiu_glue_parents = { .hw = &gxbb_aiu.hw };
+static MESON_PCLK(gxbb_aiu_glue, HHI_GCLK_MPEG1,  6, &gxbb_aiu_glue_parents, CLK_IGNORE_UNUSED);
+
+static const struct clk_parent_data gxbb_aiu_pclk_parents = { .hw = &gxbb_aiu_glue.hw };
+#define GXBB_AIU_PCLK(_name, _bit, _flags) \
+	MESON_PCLK(_name, HHI_GCLK_MPEG1, _bit, &gxbb_aiu_pclk_parents, _flags)
+
+static GXBB_AIU_PCLK(gxbb_iec958,	 7, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_i2s_out,	 8, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_amclk,	 9, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_aififo2,	10, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_mixer,	11, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_mixer_iface,	12, CLK_IGNORE_UNUSED);
+static GXBB_AIU_PCLK(gxbb_adc,		13, CLK_IGNORE_UNUSED);
 
 /* Array of all clocks provided by this provider */
 
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index 03e38992c4c73ff4ee24f0fa99b7c34134376992..95d9f85f7ca22f63a16f8665d6f7a250b21bfdb8 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -27,7 +27,7 @@ struct meson_clkc_data {
 int meson_clkc_syscon_probe(struct platform_device *pdev);
 int meson_clkc_mmio_probe(struct platform_device *pdev);
 
-#define __MESON_PCLK(_name, _reg, _bit, _ops, _pname, _flags)		\
+#define __MESON_PCLK(_name, _reg, _bit, _ops, _pdata, _flags)		\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data) {			\
 		.offset = (_reg),					\
@@ -36,16 +36,16 @@ struct clk_regmap _name = {						\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name,						\
 		.ops = _ops,						\
-		.parent_hws = (const struct clk_hw *[]) { _pname },	\
+		.parent_data = (_pdata),				\
 		.num_parents = 1,					\
 		.flags = (_flags),					\
 	},								\
 }
 
-#define MESON_PCLK(_name, _reg, _bit, _pname, _flags)			\
-	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pname, _flags)
+#define MESON_PCLK(_name, _reg, _bit, _pdata, _flags)			\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pdata, _flags)
 
-#define MESON_PCLK_RO(_name, _reg, _bit, _pname, _flags)		\
-	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname, _flags)
+#define MESON_PCLK_RO(_name, _reg, _bit, _pdata, _flags)		\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pdata, _flags)
 
 #endif
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a16ebbbf664cdd56b2c74db4f88a8d0a22d2ddc3..95d0b9cbd90404ee1c7ec551a2748665b4ef9ccd 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2701,8 +2701,10 @@ static struct clk_regmap meson8b_cts_i958 = {
 	},
 };
 
+static const struct clk_parent_data meson8b_pclk_parents = { .hw = &meson8b_clk81.hw };
+
 #define MESON8B_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(_name, _reg, _bit, &meson8b_clk81.hw, _flags)
+	MESON_PCLK(_name, _reg, _bit, &meson8b_pclk_parents, _flags)
 
 /*
  * Everything Else (EE) domain gates
@@ -2785,18 +2787,21 @@ static MESON8B_PCLK(meson8b_vclk2_other,	HHI_GCLK_OTHER, 26, CLK_IGNORE_UNUSED);
 static MESON8B_PCLK(meson8b_edp,		HHI_GCLK_OTHER, 31, CLK_IGNORE_UNUSED);
 
 /* AIU gates */
-static MESON_PCLK(meson8b_aiu_glue, HHI_GCLK_MPEG1, 6, &meson8b_aiu.hw, CLK_IGNORE_UNUSED);
-
-#define MESON_AIU_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(_name, _reg, _bit, &meson8b_aiu_glue.hw, _flags)
-
-static MESON_AIU_PCLK(meson8b_iec958,		HHI_GCLK_MPEG1,  7, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_i2s_out,		HHI_GCLK_MPEG1,  8, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_amclk,		HHI_GCLK_MPEG1,  9, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_aififo2,		HHI_GCLK_MPEG1, 10, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_mixer,		HHI_GCLK_MPEG1, 11, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_mixer_iface,	HHI_GCLK_MPEG1, 12, CLK_IGNORE_UNUSED);
-static MESON_AIU_PCLK(meson8b_adc,		HHI_GCLK_MPEG1, 13, CLK_IGNORE_UNUSED);
+static const struct clk_parent_data meson8b_aiu_glue_parents = { .hw = &meson8b_aiu.hw };
+static MESON_PCLK(meson8b_aiu_glue, HHI_GCLK_MPEG1, 6,
+		  &meson8b_aiu_glue_parents, CLK_IGNORE_UNUSED);
+
+static const struct clk_parent_data meson8b_aiu_pclk_parents = { .hw = &meson8b_aiu_glue.hw };
+#define MESON8B_AIU_PCLK(_name, _bit, _flags) \
+	MESON_PCLK(_name, HHI_GCLK_MPEG1, _bit, &meson8b_aiu_pclk_parents, _flags)
+
+static MESON8B_AIU_PCLK(meson8b_iec958,		  7, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_i2s_out,	  8, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_amclk,		  9, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_aififo2,	 10, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_mixer,		 11, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_mixer_iface,	 12, CLK_IGNORE_UNUSED);
+static MESON8B_AIU_PCLK(meson8b_adc,		 13, CLK_IGNORE_UNUSED);
 
 /* Always On (AO) domain gates */
 
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 23b51d84d8de40aa540dbc6dd5db9fb627e579de..3e048e645b080f9e5982ef908e3f9c43578a0b5f 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -3165,8 +3165,10 @@ static struct clk_regmap s4_gen_clk = {
 	},
 };
 
+static const struct clk_parent_data s4_pclk_parents = { .hw = &s4_sys_clk.hw };
+
 #define S4_PCLK(_name, _reg, _bit, _flags) \
-	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw, _flags)
+	MESON_PCLK(_name, _reg, _bit, &s4_pclk_parents, _flags)
 
 /*
  * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons

-- 
2.47.2


