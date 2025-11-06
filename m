Return-Path: <linux-kernel+bounces-889280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13078C3D273
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E311352182
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082E3557E0;
	Thu,  6 Nov 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtEVGkns"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B33351FC3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762456096; cv=none; b=qxi2DAM6E1kxYJngfXHJ0y6e20d8w2HwhvnxGh46KyKyK4hs2XVR0yCWW4MlhyoNg4Aatd+6idPkmz9NWaoe8euKC8DTqqjG/5aAamhJOzvh8PSGwxaCX69u4BrE3e1cavlLSTe56SvqHsCSkJh2CBOyXI/eITl6LGFPRgh2zOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762456096; c=relaxed/simple;
	bh=O33tzwOMuFzj5je6ou6p3VavVz9CrO7CoaSioDAC7d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJgys0i8ACruRVI6fJ2Eeu8CzEcFa2D3rKJm9K1cWmLwXKJbPuWywyKW8Xou/0/yO018rdiXwUJmosvG2ryc9Ii+ca/iksTlm49rPcg/U8utlPHD2u3HWVJ0U/60xLQ3zdAo8LfwZiIfZbI0tRwPP6no0Eof05sxSnpWRlch3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EtEVGkns; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c82276592so17753466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762456090; x=1763060890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UC7o/Lm5tysqi1r/QiS1zppEaC6hX+4dTRHAwtxyreU=;
        b=EtEVGknsOFhCcSOEMc2+Slmr+7GwYUBA+JQOZ2iFjK4vC9Nwdn3PfUD3iWkslImcie
         lppg8/FSu5qmeVp4E670ra6wh9oOxqrW/yLR5NXgK54A273jBcCdfD6Fg/2uPXAduM4r
         E1Mn3jNUK9hNDMUVxDXe0q56gGdwGaKrbnzU2DpFvIWKUnV/IhZzJ9krccoCuSoyC4TN
         r/51yUb08M2h+SQRN9CYy6vor1DQ2hNnrBen2t/xmCCNLEXcNizC5DC68oRwLUDvSffa
         Oa/0GRUSaBXRSSJi9R2sfjdM9AnS7Bojp75SZvklkNDaBKJztt+qeY8aZ60GbLOKX/Ms
         +uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762456090; x=1763060890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UC7o/Lm5tysqi1r/QiS1zppEaC6hX+4dTRHAwtxyreU=;
        b=m4teoaiT/4f2MQzkOSwvuVPhkVzBTlCh9P1BxSP8I60GqNoP5soqQ4t0qoowAmns/8
         mWWSGkXniUETrkawvh4KTEkykT80QftoTJU2NvkriqFT9yyGm3yP0emwXA9PzfdTqMw8
         YOUXMmrXZVmUpsf4486nteo9hCUSJuqH8Afpc3XR5GoTjnXXFazELbYGxtiltq7otZQu
         Hv8uWn9fFMuzGp6JDIJk8vgncJYZkpoup9D4JkY/MdfheO8YoiZZptibO8+ODGbnx3um
         u/EuupxqnoZb8KoPmXNNNkGZKhVcgcQxqjkG0L0H8OVTMjzDxjsV+lKoaad0uwz6qYEb
         sdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDo9yDl4IHSdmdf0rq6bLUJWJe5pPrHclnT//sr1AXv7XsOR/ZrzE5E0PE0+/xCBiBDF9VpbG8/b2N99E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99PFAsI58h6X8Ws1a7BDWsVP1tzTdtM07d02gGA1xsLnlYjWl
	4GTzEJuu6gUxUML0RdmX+cNhfmTF7GHaenE2WrIHAk/e73tfX5zaomfh2PQnDPnL5oM=
X-Gm-Gg: ASbGnctNjwhsDPX+bA1oFwcwswMsfkkfqcSY0saOKuxa0YWW/LPKmTVy91RDT3T6buT
	zEFdc0ng1VySusuMezfHO5POnusxMkRojxWCr8SadebkMVxhI9yIfb6KQB9pxgvaMGmD2LhhSWh
	aJghLwbrVr+9WIyL/E6EonDODyZYhAqoqvFGWh791wP+2szL3+pWk+Qkxz5zz1fFke06vKuTgdM
	F4ocJFmQpa18Kz/EW5iQDvZm5k+LwGGJJJZvF2KQhmnq+S0O61yBjIw8IrHbx8m2f0HnJ7bGd8P
	Fp4MaYzEmZFKHVq+ErgR/ZAdZPcCqf5hlLKYn/VuvXzp2DCllSMVDnDcyQXEUn8DfP4Lvk2TsUj
	Pzrr88zbboMhamxYRlyrUVi6bfDYNR3ntzLnvx+k8zRQGnBeaMj8CyMAND1iScaWSN/IwlDCgYH
	C29yMygT4zSfcuZWBdFH8ql7QIeWM=
X-Google-Smtp-Source: AGHT+IH4u0visRizZo2d3rYJCHF6DFTUhu6yOMzJeaTU5w4S3ldRzQL6ooWntCfuedndsflKkieXmA==
X-Received: by 2002:a17:907:1c01:b0:b6a:382a:1516 with SMTP id a640c23a62f3a-b72c0d52bf6mr17951666b.5.1762456090174;
        Thu, 06 Nov 2025 11:08:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa2510esm26739566b.72.2025.11.06.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:08:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 20:07:08 +0100
Subject: [PATCH 01/13] of: Add wrappers to match root node with OF device
 ID tables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-b4-of-match-matchine-data-v1-1-d780ea1780c2@linaro.org>
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3693;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=O33tzwOMuFzj5je6ou6p3VavVz9CrO7CoaSioDAC7d0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDPIJjcqOIsRPKVtKm1n48qkLFTKl0iTeRLJML
 O0ig2VobJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzyCQAKCRDBN2bmhouD
 16upD/0ZvU0jba0Dx7VybPnYT2mGXlqQGiRbmnASkWMky8rIi6Sp8RSTLDhpclz2LmVx2skpz9v
 0r6fP/FAMEFShI7EOBA+3f2t6USlukHdnPVV5xooagFdsMEyVL6+LwbgBm0f51zE6VM/tdjSDvM
 lCVONspGTJH1L/sttThdI2ovYpqbZYDhIgRcyLipKeWZte4YfeSzgnv3mOsaZFNFZKNt1Y8jn5q
 lAnXZCY6RgamYZplen5FS1RlMwii6jqAT4iMGTBELYGQSe4sB6WFyV4jpa5ZvU6gKmSjgMPVrAa
 u+SHuX1DmTVBI+iqI+OHv0K5lS2PQIvbQOYEI1nVsSxLPQj3FZDmO2dIMvtZq/A1xk150fjigAN
 IXNMW7CdnSTV4oloo/K2XJKpIqVWKtkjEMeQz8y3d7z+i9ufMn+SvYkCQwhDWwr26gkfEIHxLRd
 GcS4JoNkEeK1NPDp1DJsvbGwTtKcfxX5AE/GI11SX5KqZmCOcZfsh3AxXQsI6q/r/HIoj0pWGr/
 aawjN/1UsCSiEDwm7T0yFZgc40VQp5wqrhuIZclvDr0ycCO6vt4LEFykBHRt5xA27HSsxSWVT35
 oEZvCZypUBmVZTUMfjm3P2tcxblSskFAWSXealeXfawQqRW3usvcwdwSGsJ4wz1RkezOFDOI08h
 PmOXu5HeggsWkCw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Several drivers duplicate same code for getting reference to the root
node, matching it against 'struct of_device_id' table and getting out
the match data from the table entry.

There is a of_machine_compatible_match() wrapper but it takes array of
strings, which is not suitable for many drivers since they want the
driver data associated with each compatible.

Add two wrappers, similar to existing of_device_get_match_data():
1. of_machine_device_match() doing only matching against 'struct
   of_device_id' and returning bool.
2. of_machine_get_match_data() doing the matching and returning
   associated driver data for found compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

All further patches depend on this.
---
 drivers/of/base.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 13 +++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7043acd971a0..0b65039ece53 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -434,6 +434,53 @@ bool of_machine_compatible_match(const char *const *compats)
 }
 EXPORT_SYMBOL(of_machine_compatible_match);
 
+/**
+ * of_machine_device_match - Test root of device tree against a of_device_id array
+ * @matches:	NULL terminated array of of_device_id match structures to search in
+ *
+ * Returns true if the root node has any of the given compatible values in its
+ * compatible property.
+ */
+bool of_machine_device_match(const struct of_device_id *matches)
+{
+	struct device_node *root;
+	const struct of_device_id *match = NULL;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		match = of_match_node(matches, root);
+		of_node_put(root);
+	}
+
+	return match != NULL;
+}
+EXPORT_SYMBOL(of_machine_device_match);
+
+/**
+ * of_machine_get_match_data - Tell if root of device tree has a matching of_match structure
+ * @matches:	NULL terminated array of of_device_id match structures to search in
+ *
+ * Returns data associated with matched entry or NULL
+ */
+const void *of_machine_get_match_data(const struct of_device_id *matches)
+{
+	const struct of_device_id *match;
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return NULL;
+
+	match = of_match_node(matches, root);
+	of_node_put(root);
+
+	if (!match)
+		return NULL;
+
+	return match->data;
+}
+EXPORT_SYMBOL(of_machine_get_match_data);
+
 static bool __of_device_is_status(const struct device_node *device,
 				  const char * const*strings)
 {
diff --git a/include/linux/of.h b/include/linux/of.h
index 121a288ca92d..01bb3affcd49 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -407,6 +407,8 @@ extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 bool of_machine_compatible_match(const char *const *compats);
+bool of_machine_device_match(const struct of_device_id *matches);
+const void *of_machine_get_match_data(const struct of_device_id *matches);
 
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
@@ -855,6 +857,17 @@ static inline bool of_machine_compatible_match(const char *const *compats)
 	return false;
 }
 
+static inline bool of_machine_device_match(const struct of_device_id *matches)
+{
+	return false;
+}
+
+static inline const void *
+of_machine_get_match_data(const struct of_device_id *matches)
+{
+	return NULL;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;

-- 
2.48.1


