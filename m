Return-Path: <linux-kernel+bounces-845121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83571BC397A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349D03B763E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F52F361E;
	Wed,  8 Oct 2025 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou5kE8Op"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B082F25F7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908681; cv=none; b=JpS8xkB7DOOOO7rRsOLXcayiygn7n4WERxVSVYIT7jlJFVtghay+7JbIIM8UuMEKU6mQw9XogKfw5j5Vm+HHqitQss8bhNcoxpMi3rnZxu/fAq4y2DL1PNndYnR7kPZKNQcm44LeG6mCCqjOnU4Urkb3Ewf9+WBGQ+kJ7erhgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908681; c=relaxed/simple;
	bh=0GRT6eQI3Cm8XV8zCUtY3dryPx2rZvFnN6HHzwrp62I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vveto3bOFrni9A4ssVuJQKp0u8qJUUnTIcnVyxDiZ3XeNjlo6ikwOiTfRP5jWPlubG9CrQjfIQuctGnghNRD94V/rTlpudsW9KtgudFo+1qtgSrTAOqvfHbJ/7EQlh7p5RSfvT6cZXf4QNhRgGqyQMss6DIOuRJXPvQ1xm0cnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou5kE8Op; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5906665139cso1801271e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908677; x=1760513477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQLFTxrIKtieldvIvL7WZTPqw42YlDTw8nNSn3fA0Wk=;
        b=Ou5kE8Ope2E6c8bomg7zZFu/Ti4f61E+DNr21xjfoMJQo+DIO36rI7uT5GK4ByEtFZ
         lmdYd42jKjxXeOwvPmm6k46Td+MJOfir2aVis+8FXxiGLkJlQPX4i/5Q4EsUdcoaaAy/
         54tYHuh9k6jFGN4sWLohq+TpgDMOXYsm/pjxzpH0bWHVVKNMvZkOXDszE3tUZJHedp6V
         w9N6WWSQUeJ56wqMDgRbAs/C5x4IUpmF6R2B62HcbqVhMcak26b6MBzdy16p01dnSbWb
         w2hnaRo4/VWUytrDzn9MXr6U7OTp0k2DKOgDfec0SahNMZAlR8hAcrRu+V7yxHBnbusC
         aR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908677; x=1760513477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQLFTxrIKtieldvIvL7WZTPqw42YlDTw8nNSn3fA0Wk=;
        b=OGrsMhUgqNaDJktjouEu5yijnk32tBGutHtvdRqYXKlqXQjHu6SAkfvVXT63BcQhZ1
         Ynawb0I4P2R4soiVz0D0o0hPmI2Ig7SNkVXRN9JxUngU3LjV2/94Tun9hEqT45uTC5+Q
         0HeUBq6xhDAtNKVpG5WEpLZMD55cl3yR9F4UhxG3W4ftXU7/0WEEALmLzm/gaSPfN6mG
         +WPwBZX6My5Oh5G4TIs+p5TxwCeN5XKtT8DSs1g8AY5y509zM/NX+igJHqSyX5LGgO7m
         k7yrsKu7bfRXV7LWWEw3n/mqxaalM9JQKLYLuKed5F8M+T9p2JBb1dY09r8cjLrSCzP/
         bMOA==
X-Forwarded-Encrypted: i=1; AJvYcCV15hDPOId/YSplLsXAxql/jkxsoBf6VDfoP2GGhek2a2PUrDh5U22hQaNu9oFA8pSCeTtyTZyUOqMk4dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxps0r3wzeCm82dLFKVE0KjUAG5PfFcmizFRxGSlXyeQfjhTrUh
	Vi+VeqKohMFRgMo73iUW+UMdv9EP2XrcC+D46OvH6UkOr4YKDKS7mOtl
X-Gm-Gg: ASbGncuMd78InByWoRB23RlsNQvn9TB2MOFoIwjedgq+mjSsbjY2Q1QLoclKtpwTJwj
	QM29uSpN6tlqieQWShPzsk/0AugqG3OU41odhJu8PREA+cSy+lEjQAjnRmmZPV7T+eW+pKFPxoo
	ba6DNqYsULLNPqJUYuEuYafq+JeEzQ1mhhKL/W2Eq2DKySGJVnmLTbSk9bKeEYpRw2byM7gP94U
	Zmt5fhlO/V31Zw6MjcW/89iFtCr34stYLfK3ynCXQHi9t1/fYkR9GnAPpUonZOXL/Qv8wt9yY/r
	ggENvSS4hc1ouOFvmUCYQVcP8ZG22f8EMQDF8OiPbDH+KQI0RPA63DG7n/s4Iqm9Bw2gO3B/+w5
	yUAre9yrHDOoZ9bs83oKzK5e2rFQ9yRAUbJ93+A==
X-Google-Smtp-Source: AGHT+IFpUSCjmqWlypk1jhB6DNeYarmmHYoM2rml86MGPw0PJqxvr54S+GMFfAgFpZaGYlwixjWo/A==
X-Received: by 2002:a05:6512:3045:b0:577:6e42:3718 with SMTP id 2adb3069b0e04-5906db0365bmr662412e87.7.1759908676756;
        Wed, 08 Oct 2025 00:31:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:16 -0700 (PDT)
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
Subject: [PATCH v4 02/24] clk: tegra: set CSUS as vi_sensor's gate for Tegra20, Tegra30 and Tegra114
Date: Wed,  8 Oct 2025 10:30:24 +0300
Message-ID: <20251008073046.23231-3-clamor95@gmail.com>
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

The CSUS clock is a clock gate for the output clock signal primarily
sourced from the VI_SENSOR clock. This clock signal is used as an input
MCLK clock for cameras.

Unlike later Tegra SoCs, the Tegra 20 can change its CSUS parent, which is
why csus_mux is added in a similar way to how CDEV1 and CDEV2 are handled.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/clk-tegra114.c |  7 ++++++-
 drivers/clk/tegra/clk-tegra20.c  | 20 +++++++++++++-------
 drivers/clk/tegra/clk-tegra30.c  |  7 ++++++-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 186b0b81c1ec..00282b0d3763 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -691,7 +691,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_tsec] = { .dt_id = TEGRA114_CLK_TSEC, .present = true },
 	[tegra_clk_xusb_host] = { .dt_id = TEGRA114_CLK_XUSB_HOST, .present = true },
 	[tegra_clk_msenc] = { .dt_id = TEGRA114_CLK_MSENC, .present = true },
-	[tegra_clk_csus] = { .dt_id = TEGRA114_CLK_CSUS, .present = true },
 	[tegra_clk_mselect] = { .dt_id = TEGRA114_CLK_MSELECT, .present = true },
 	[tegra_clk_tsensor] = { .dt_id = TEGRA114_CLK_TSENSOR, .present = true },
 	[tegra_clk_i2s3] = { .dt_id = TEGRA114_CLK_I2S3, .present = true },
@@ -1047,6 +1046,12 @@ static __init void tegra114_periph_clk_init(void __iomem *clk_base,
 					     0, 82, periph_clk_enb_refcnt);
 	clks[TEGRA114_CLK_DSIB] = clk;
 
+	/* csus */
+	clk = tegra_clk_register_periph_gate("csus", "vi_sensor", 0,
+					     clk_base, 0, TEGRA114_CLK_CSUS,
+					     periph_clk_enb_refcnt);
+	clks[TEGRA114_CLK_CSUS] = clk;
+
 	/* emc mux */
 	clk = clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
 			       ARRAY_SIZE(mux_pllmcp_clkm),
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 2c58ce25af75..d8d5afeb6f9b 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -530,7 +530,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_rtc] = { .dt_id = TEGRA20_CLK_RTC, .present = true },
 	[tegra_clk_timer] = { .dt_id = TEGRA20_CLK_TIMER, .present = true },
 	[tegra_clk_kbc] = { .dt_id = TEGRA20_CLK_KBC, .present = true },
-	[tegra_clk_csus] = { .dt_id = TEGRA20_CLK_CSUS, .present = true },
 	[tegra_clk_vcp] = { .dt_id = TEGRA20_CLK_VCP, .present = true },
 	[tegra_clk_bsea] = { .dt_id = TEGRA20_CLK_BSEA, .present = true },
 	[tegra_clk_bsev] = { .dt_id = TEGRA20_CLK_BSEV, .present = true },
@@ -834,6 +833,12 @@ static void __init tegra20_periph_clk_init(void)
 				    clk_base, 0, 93, periph_clk_enb_refcnt);
 	clks[TEGRA20_CLK_CDEV2] = clk;
 
+	/* csus */
+	clk = tegra_clk_register_periph_gate("csus", "csus_mux", 0,
+					     clk_base, 0, TEGRA20_CLK_CSUS,
+					     periph_clk_enb_refcnt);
+	clks[TEGRA20_CLK_CSUS] = clk;
+
 	for (i = 0; i < ARRAY_SIZE(tegra_periph_clk_list); i++) {
 		data = &tegra_periph_clk_list[i];
 		clk = tegra_clk_register_periph_data(clk_base, data);
@@ -1093,14 +1098,15 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 	hw = __clk_get_hw(clk);
 
 	/*
-	 * Tegra20 CDEV1 and CDEV2 clocks are a bit special case, their parent
-	 * clock is created by the pinctrl driver. It is possible for clk user
-	 * to request these clocks before pinctrl driver got probed and hence
-	 * user will get an orphaned clock. That might be undesirable because
-	 * user may expect parent clock to be enabled by the child.
+	 * Tegra20 CDEV1, CDEV2 and CSUS clocks are a bit special case, their
+	 * parent clock is created by the pinctrl driver. It is possible for
+	 * clk user to request these clocks before pinctrl driver got probed
+	 * and hence user will get an orphaned clock. That might be undesirable
+	 * because user may expect parent clock to be enabled by the child.
 	 */
 	if (clkspec->args[0] == TEGRA20_CLK_CDEV1 ||
-	    clkspec->args[0] == TEGRA20_CLK_CDEV2) {
+	    clkspec->args[0] == TEGRA20_CLK_CDEV2 ||
+	    clkspec->args[0] == TEGRA20_CLK_CSUS) {
 		parent_hw = clk_hw_get_parent(hw);
 		if (!parent_hw)
 			return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 82a8cb9545eb..ca367184e185 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -779,7 +779,6 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_rtc] = { .dt_id = TEGRA30_CLK_RTC, .present = true },
 	[tegra_clk_timer] = { .dt_id = TEGRA30_CLK_TIMER, .present = true },
 	[tegra_clk_kbc] = { .dt_id = TEGRA30_CLK_KBC, .present = true },
-	[tegra_clk_csus] = { .dt_id = TEGRA30_CLK_CSUS, .present = true },
 	[tegra_clk_vcp] = { .dt_id = TEGRA30_CLK_VCP, .present = true },
 	[tegra_clk_bsea] = { .dt_id = TEGRA30_CLK_BSEA, .present = true },
 	[tegra_clk_bsev] = { .dt_id = TEGRA30_CLK_BSEV, .present = true },
@@ -1008,6 +1007,12 @@ static void __init tegra30_periph_clk_init(void)
 				    0, 48, periph_clk_enb_refcnt);
 	clks[TEGRA30_CLK_DSIA] = clk;
 
+	/* csus */
+	clk = tegra_clk_register_periph_gate("csus", "vi_sensor", 0,
+					     clk_base, 0, TEGRA30_CLK_CSUS,
+					     periph_clk_enb_refcnt);
+	clks[TEGRA30_CLK_CSUS] = clk;
+
 	/* pcie */
 	clk = tegra_clk_register_periph_gate("pcie", "clk_m", 0, clk_base, 0,
 				    70, periph_clk_enb_refcnt);
-- 
2.48.1


