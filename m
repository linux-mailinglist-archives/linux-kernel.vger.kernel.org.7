Return-Path: <linux-kernel+bounces-845120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2573BC3941
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E7C189322A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E542F2617;
	Wed,  8 Oct 2025 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjEkU1lj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B882BF3CF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908679; cv=none; b=sZM9RP1wxWolWKBmTu/kEKeMWVFvi5sOhMLOOK6deJ7DjI4XYUWxpQ/0cxNP6GW0v6SrvOKP94huP8fMSvy6Uy0aLUx89deai7S8kGBFo81mTgnFX5bAmteJLG/k987QbUYqJ5ktWHOzFIAN7gDPYpFFct6uTFU+NOYdp5TTY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908679; c=relaxed/simple;
	bh=Xtlv0T4/g1zHgGtcSEMBQYBsYKA6gFss+0qpYkk7s1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkM5mob5M2Pfo37JbZ7D8lytOAGBlL1mgw6sjNea8hqXZXGdFNkaw6/Gaw4ppXzQqKLJ1TQEf5SpbzVbwpHbO+TUJADmHl3rxzjYFqc01v3l1IiF8hTsbK9AmN1FDYTm2rINIz7ElgRfn+tReA2s+4AJTb7FeK9zwwZGcnl5KwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjEkU1lj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso2398170e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908675; x=1760513475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuOpi1X4QZYIfmoXv6VRwrkZ+36+Rr3x/0SmX/s0qO4=;
        b=mjEkU1ljzoPAd5xRdZag34mPgwvF8Q2NtMAG1qV19a5hFAf+YiZwvyXi7jRJoXLzxh
         bEzzsGAimhBESYTA7IITen3/4HTmceQKC06Xo29PgHlGGtrlhJBlg++DctAGKo+MyNHz
         EjJLyMOsJYMu1ZkbXHOCGGCfdUy2/4biGo/dQ8Dy9vQoYDr4ejQi2Qbc/QyCrj/ClpHF
         i2te2dx53EtOkHm/CvFDrM9UiphHML5SZ7Osxpyuzg2fUjhiKUcAufoT6ay3/vQ55CG3
         wp8XMry8EGMvtJbScit47AuRA2Rj1elgN6mp8AGk3rmKZR4MA4fNlLF3AA//1twyJ3bQ
         R4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908675; x=1760513475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuOpi1X4QZYIfmoXv6VRwrkZ+36+Rr3x/0SmX/s0qO4=;
        b=P3POZGUX//Qjnfv5YrpVgj9Sgex5li5mVcZI6MatycXfFppXUc+SkdTFOps5401w+9
         sfZz/lXHnus/m0HjbA1u2sUVjQJ8mAC6l3vHAmypR3eXgtXy2sfnlUskviA90xAaUC5v
         QHLWtZ+Qtlbw2O2FN0emJuWh8amDxG4gvfQjassduF9jov3nx2/o5f7H1fQ1+OkUP3r4
         q5AB8Vmk5nI9XESdELVHgJzkTwDrSq+D1moqAQtKgeva+8ZI9OSGdOVw3YKa3R8PjNHd
         /ZSMSRQqlw16k2UM30gPIpa3jisE32EoF4XKRZ2yZCsS9F51/21h12F4s1pEYMd4UB0c
         RHtA==
X-Forwarded-Encrypted: i=1; AJvYcCXTzoGMmDSdJzp0fbNak+/pgHJ8ROrU6p/fJpN7dExEorqgAL0lMVXpazllG3yyMvpdwTYzBpNDijAUMuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0nQ5k9L6I8daK6rVk7JoJ9TCdvnsPofZBs/O++wkrJcGycmP
	23DRP5tBWB2cfk4OOJ+5jNruOH/FURXjdTUBBCrLFbJi9Aug4b3w77x0
X-Gm-Gg: ASbGnctYFD7HAqW+5gqpsBQ4hd20cPobR5i6MPD8bYJFCG030XVjP9eO2cKEsgMJUGt
	uThcCuyDp34mM4Q441PWcmJ8r3DiOqh43KAHoLCUkPelznieL2D3D6oMlXhaAMvFswO+zz2JZSN
	29/VIWSPmSRrhTcgPqVcc+/YLdtkYroaiUEr8FsrYQgvFs++6+0n3aPDjWh9OVn55d0c/nS1T7o
	GTcze7B1u59AyiToH3jb00ibV0vG9zGvZdzQ8zrY9eW4BJQzfJ58HidZemJhqbytEDfhMZhrWds
	U54vtJpaQaxdbRnzjIkoB4iIugCJgjKFOclUxLiFf1El5VDkagoez/edyo66a1wMlkcpEv6FwUs
	CwR3pWIZZJDrziaSfHM8wexWb2dxO8oayeprdqg==
X-Google-Smtp-Source: AGHT+IH4w5wUowLiJI7hgdEtUtkCn/YDDLljjRvew5jTKIWe64MrO+dc17yhYkOKlcC57NaNakIcLQ==
X-Received: by 2002:a05:6512:4028:b0:57d:b8a1:832b with SMTP id 2adb3069b0e04-5906d89edbdmr712455e87.24.1759908675110;
        Wed, 08 Oct 2025 00:31:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 01/24] pinctrl: tegra20: register csus_mux clock
Date: Wed,  8 Oct 2025 10:30:23 +0300
Message-ID: <20251008073046.23231-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008073046.23231-1-clamor95@gmail.com>
References: <20251008073046.23231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add csus_mux for further use as the csus clock parent, similar to how the
cdev1 and cdev2 muxes are utilized. Additionally, constify the cdev parent
name lists to resolve checkpatch warnings.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra20.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra20.c b/drivers/pinctrl/tegra/pinctrl-tegra20.c
index 737fc2000f66..1a1758fd7def 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra20.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra20.c
@@ -2222,14 +2222,18 @@ static const struct tegra_pinctrl_soc_data tegra20_pinctrl = {
 	.drvtype_in_mux = false,
 };
 
-static const char *cdev1_parents[] = {
+static const char * const cdev1_parents[] = {
 	"dev1_osc_div", "pll_a_out0", "pll_m_out1", "audio",
 };
 
-static const char *cdev2_parents[] = {
+static const char * const cdev2_parents[] = {
 	"dev2_osc_div", "hclk", "pclk", "pll_p_out4",
 };
 
+static const char * const csus_parents[] = {
+	"pll_c_out1", "pll_p_out2", "pll_p_out3", "vi_sensor",
+};
+
 static void tegra20_pinctrl_register_clock_muxes(struct platform_device *pdev)
 {
 	struct tegra_pmx *pmx = platform_get_drvdata(pdev);
@@ -2239,6 +2243,9 @@ static void tegra20_pinctrl_register_clock_muxes(struct platform_device *pdev)
 
 	clk_register_mux(NULL, "cdev2_mux", cdev2_parents, 4, 0,
 			 pmx->regs[1] + 0x8, 4, 2, CLK_MUX_READ_ONLY, NULL);
+
+	clk_register_mux(NULL, "csus_mux", csus_parents, 4, 0,
+			 pmx->regs[1] + 0x8, 6, 2, CLK_MUX_READ_ONLY, NULL);
 }
 
 static int tegra20_pinctrl_probe(struct platform_device *pdev)
-- 
2.48.1


