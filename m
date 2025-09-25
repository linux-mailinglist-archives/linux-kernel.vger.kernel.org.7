Return-Path: <linux-kernel+bounces-832750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB65BA03E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0831895C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327F2E62D0;
	Thu, 25 Sep 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKEfCl7A"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F12E8B8F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813441; cv=none; b=YiV5pnoJ1qC4z0cBLq5xkSjSDyALkaNNmrhzDFwbs94sEc1hu7+fLUYml69F0L6mEatUVawVLBJF8Nod6asIOHWchZJ0gQuuc0S8/ImwGbv0wE+BFyxs3ueqJ5EYaV4VWU82n/zkNkdZl8IghXg1PqmkDjWU5ZstpQEmhTd1PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813441; c=relaxed/simple;
	bh=FZOaPk/XiWFhkp3zMB+0dvCF3erehg3z6+zK/HzLAY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBrsFSxcazQt5sIr+9f/9/8vT+sLxJDhhzQ9KIVA+T5NDe7P+m0h+a2gCKAfgOIuR8GpGJzwIfEuPjMFms2LS4ysb2wqiDIvsRzQKNoimBNqtsK7CR6p9yk85eDfjNFAK7pqgbpmRBfgMc8kirJ7p4NHp7oNG/o5ysXHZx8Xf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKEfCl7A; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1343768e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813437; x=1759418237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg0HJx9UF6cc43KSohy1sFUTcyD1/BLQvc4mTLXMxcE=;
        b=fKEfCl7AVmJHQqhbtbf0R4rOqSa4No3ujMoQQUO4+qZ6MnivJ0ps65I9HNv38/87eC
         lB+ITMbyBYmBuupoEKppIyNcezWWfZsqDIz54H+0Psl3L+OGm5KbZLfLpRrNxBj9IgdY
         MOwGYtPbuT9wBz9E3iJl67ufMRzeWfRE3WCyRHXXndMipQNphpcuv8ip34fMD46Cw+i2
         aEu4m+FcrjFbrnUEjm+8VuHonMRs1JRZfh5PVolg/zh/IAyJrIT9wDUYXfU6C578Q3gJ
         fmoiimzEow/g7wz/tVP5OLh4ZTTbz6PGhRfq/drTYD0a2X+hxLurRH+WTSlm8BeYUsj+
         taKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813437; x=1759418237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg0HJx9UF6cc43KSohy1sFUTcyD1/BLQvc4mTLXMxcE=;
        b=TrtKQUNhs1yH+qfUWG5LlskyF0Vz1Y9UdfGFx+fAGMhv1wqrXwXNcPnhdILnfKOAKm
         6GTpqiYYg6FI977tQ/q+Awz7BXBnROr02+vlFZ6osJAN1xa6pVWfLJbVcigqvYck7xHt
         ENcqT4MmWX5k6hgNfnYMIABA2AoZuzCogBEChcIsckigEn43/kvyY80nxb/DqltdpYb2
         5U36wfc4jEt8KkuDRSYk4ttr4sYAFk/9LvotZ/+2uUzawCWU/bpm7gL6n/a/0E3Zl0/j
         y4fdkR5o3/E3zSqiVPpUhlojvdeOH2uVNPJlRWNtExH3CS5/qkkgHZTnU/ixvbQF/J70
         /Mqw==
X-Forwarded-Encrypted: i=1; AJvYcCX+vUXSvNmRs8xd31lmSfA/kdkiYbmULpKQp8SgBEK0KLVmckvd+/1VX5fUpm65ztFOLrcQYaRHxjjRfMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJuFO4RnsgrCXfovuSwpRznsudzdlAxo2t/mTGEGHw2Qf5Zxq
	w1F66RESulLPTPwnYPXJ4ci8NhvyW3tAQ6Wdc+MkgTwb0v7AHvl3WgAk
X-Gm-Gg: ASbGncvvYvQVE41zmQw9avulnpu0kdz1zB5MaahaRaJRKHCvvnkAhvpLoHw7aa3NZrn
	9QReceQKqJUWbq8UGC5OWbvxNUPV0oGnQ/VvbRX0Crbc5cKzjuqmRtUtSmo3kQ+cu+sVffUHYzF
	NGYy4kLMYGd+VUY5qcvrX1czlcp068t7+ZpJr7Tx4+kdAF20ev7smz2saxyRDnPH2JNSR7Lk0GC
	DzVFXkdp+B32PyFTf9jU11F2B6WB687bskv9O/AJAev9VesIAgV9crZYjJSETVq9KnD46EtplCt
	50YnAvCZQcZx6NfSfaz6ikaGzCPiCkjCR2vlz80KYkh/OfcveS+yEkiCcqFGrT1YxZYpU0nudcc
	mBRTHj9ddmi3GBfp0eU54Thai
X-Google-Smtp-Source: AGHT+IE0utS+jecb/LkEfFuQRpDoO+zVGhi+NkEAr1FLNmKoWaS6Wce1hEkVKYRO90wTwE672u05Dg==
X-Received: by 2002:a05:6512:3e11:b0:57a:de0d:d9ce with SMTP id 2adb3069b0e04-582d2f273a4mr1035976e87.44.1758813436654;
        Thu, 25 Sep 2025 08:17:16 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430496sm870084e87.27.2025.09.25.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:17:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [PATCH v3 03/22] clk: tegra30: add CSI pad clock gates
Date: Thu, 25 Sep 2025 18:16:29 +0300
Message-ID: <20250925151648.79510-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250925151648.79510-1-clamor95@gmail.com>
References: <20250925151648.79510-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tegra30 has CSI pad bits in both PLLD and PLLD2 clocks that are required
for the correct work of the CSI block. Add CSI pad A and pad B clock gates
with PLLD/PLLD2 parents, respectively. Add a plld2 spinlock, like one plld
uses, to prevent simultaneous access since both the PLLDx and CSIx_PAD
clocks use the same registers

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/clk/tegra/clk-tegra30.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index ca738bc64615..61fe527ee6c1 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -154,6 +154,7 @@ static unsigned long input_freq;
 
 static DEFINE_SPINLOCK(cml_lock);
 static DEFINE_SPINLOCK(pll_d_lock);
+static DEFINE_SPINLOCK(pll_d2_lock);
 
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
@@ -859,7 +860,7 @@ static void __init tegra30_pll_init(void)
 
 	/* PLLD2 */
 	clk = tegra_clk_register_pll("pll_d2", "pll_ref", clk_base, pmc_base, 0,
-			    &pll_d2_params, NULL);
+			    &pll_d2_params, &pll_d2_lock);
 	clks[TEGRA30_CLK_PLL_D2] = clk;
 
 	/* PLLD2_OUT0 */
@@ -1008,6 +1009,16 @@ static void __init tegra30_periph_clk_init(void)
 				    0, 48, periph_clk_enb_refcnt);
 	clks[TEGRA30_CLK_DSIA] = clk;
 
+	/* csia_pad */
+	clk = clk_register_gate(NULL, "csia_pad", "pll_d", CLK_SET_RATE_PARENT,
+				clk_base + PLLD_BASE, 26, 0, &pll_d_lock);
+	clks[TEGRA30_CLK_CSIA_PAD] = clk;
+
+	/* csib_pad */
+	clk = clk_register_gate(NULL, "csib_pad", "pll_d2", CLK_SET_RATE_PARENT,
+				clk_base + PLLD2_BASE, 26, 0, &pll_d2_lock);
+	clks[TEGRA30_CLK_CSIB_PAD] = clk;
+
 	/* csus */
 	clk = tegra_clk_register_periph_gate("csus", "vi_sensor", 0,
 					     clk_base, 0, TEGRA30_CLK_CSUS,
-- 
2.48.1


