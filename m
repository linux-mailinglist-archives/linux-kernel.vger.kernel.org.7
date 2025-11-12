Return-Path: <linux-kernel+bounces-896973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75227C51A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051DC1889B48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F59305967;
	Wed, 12 Nov 2025 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo7E/5Ce"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2F3043B5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943350; cv=none; b=I8gVBF2LVXI4NWwk71SNBqWfGStE5+yfdOPmoZ0ay1mPljG5O4LSDnaRH3gdf4ZuVL+SnaNu42bb1QP2v+Jz8g7XXLsGp5YYcBzYO0j9uUJdqd8oxObdN+0EoQt1Dx87YoT2mDwshX0N52W6pE4ShO0UudVu5Wjl54HWseaMnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943350; c=relaxed/simple;
	bh=97pN+hZe6aOdQXzqXH/jzMv6/WG6YtpXykn+P6/wWxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XUzvBXKWFYzQvvTY/9qaIDlpxpUHospc0g/wsK7huqUEWu9ix4Xe7so9LLc3HmEle+iA5KO6TKO9rwapWjwgzRQKZtywcpovrplSdrWZCybsY9ztCJbw+/fvBBaSnICUOvm6iRL8CceOJJCCImStDf9aXUXOysvA10JI6Lp01Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bo7E/5Ce; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429ebf2eb83so83123f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943347; x=1763548147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xtn1agn38vYYRSDmrX8xmfCfXiGeMgWG3lL/9kBn0bY=;
        b=Bo7E/5CeRlohjHNpd58+d9WIAT9YKMAa9+ZPv9UNTau/syi/2Uyll3sb4IQNDR/aLI
         pMIdz2Oky9rciPhrgVxzrsHxg0i5SLr3mkzmqBV/zYiJQMFvmisY8ad0WpCFm3D8wGWR
         qqlB7+hPNSd73I5WmfT9Y0bnSqlbf8ZY0yK4VIdYQHXetCFnU3ky7LrBcva9s7ka7P9y
         4EneKs90lgQ7XQSVUxNPAHHe3dvQaNPijWPuGxTbMU60v0jIGGf9q0KG/wvMweK3KJf2
         noQ2wkk6o6qMJUKbb5/X6FkWbxcO42mF1ZcFQ7KC6g8gb0I2rF4Uwajkib36fJIpG1zI
         oiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943347; x=1763548147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xtn1agn38vYYRSDmrX8xmfCfXiGeMgWG3lL/9kBn0bY=;
        b=wSG/ZC+BX3hVS1CtmmNDAbj1wqAWPpnEV+I8O1VysemN2eX7ALGfYKZxAKG7a5qsVX
         4jeYWR1lGq7NmgNzH1ZPAYiYZUT1aYjcvg+jGVTEL2P2AGtuJXr4zz7uC4KGlbJgR2ps
         O7TYOSgA8KeRdq5ZCJz7lC5qJ719XCgI8PRKStdFAvktDaxevdVSlLARSElMl3C9bGZR
         0Jiw2nq3mAmidtXWIT8CnfFlN33dEQboIRAyzf/P/p9aqcr/1ucy8ojbtrocLNZprD4V
         Bo8KWo/V8ax5ksuI9+8Z3r5rRuSXXQAgvMkhuOEX9/YCQridNYxRClQiWJlWPVQK9Upc
         nkOg==
X-Forwarded-Encrypted: i=1; AJvYcCXtWLw72+T9T7EoZfywoURdukiM5TXmXcT6VYgd1yBYGVe6v57j5/oduSqqAkad/VW9nngxKz0OzPyN1l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrX8DiC5etcaIkVXAqeEgIKBj+yY2Jrt7cCvNm82pn1gvrwDMk
	UBx7CtT2wqu/L+weU1m94/0D+gD0GS1jKMtV3PTI+LIWWngngUKmtNlUEQl1gGN/+ts=
X-Gm-Gg: ASbGnctfe3dyBjoZZcXnHR2ge8uvYq+KqxrSaYbzaFh/POBcSG9ZPMwU8gdx05KalP2
	61eKlR1g5fdb0QVq/dyKJFGwXbM1PkeWhDvAU2ZWeT0T/pnAy+3KY1qCz0/HDKgVkLAFW3l2wkD
	3vfrgPVD+OVeciVfaqVe/Kx+YNPmIno7fDS+MmywhccxQLwqDBWJYsPmRJ3HyOuwBuwswviXbie
	FJvkxXVDBZzs+EyWccs1xgg8cwfb/gGbENq4mM79FkrmkVDhWJAWMQmgQHRKeN9MZ7prfHGIC1F
	8ZFP3CpG2g00VZpRtfDD7/xKF6BuKB01f4+inxtgwNDYerFLw5ubGkBs02LQa2ETolf+RGU1N1U
	u0RLxZty9Pu48DGoZrKeyA3qMqGVv5OepwtRkK/khu+tkeSZFT9eNze9Df7capLaCvVpECifOdD
	2BxNhHoCTkmE9aD8Q+
X-Google-Smtp-Source: AGHT+IEqw4rhZRyDy+yPmdGyXuh1FmIzLY034EYTwmwGfWZRi5DR0a/TjWaTQc0ZSjDYk6R/6C4iqQ==
X-Received: by 2002:a05:6000:2087:b0:42b:2da3:ac30 with SMTP id ffacd0b85a97d-42b4bb875c4mr1198295f8f.2.1762943346620;
        Wed, 12 Nov 2025 02:29:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:46 +0100
Subject: [PATCH v2 01/11] of: Add wrappers to match root node with OF
 device ID tables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-1-d46b72003fd6@linaro.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3774;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=97pN+hZe6aOdQXzqXH/jzMv6/WG6YtpXykn+P6/wWxo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFkNYeOuoYzpykLoG20VsmMhHx83ITlx4eh3
 nQhR2/+8c+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhZAAKCRDBN2bmhouD
 1+WoD/0TKoeUAmx+UOxM0JybjWAMODukmdMBn6gauxFIVRlljF/oKwZMabgzYrNN21aWkVxl2Gx
 YzAxkQ/qwOh0Kdg86awylIZT+BceJmpZHLGj/zlXD7z1Kp2Ib/Kvukk1qf78AAs+4CkVn6XLbMm
 SfzvNCXZAFS/Wmwt570i9P1qKzGcXPrFmD4MBRBDKcQbzpnZXtKtATET5wD1DdrmwA6VvwTWg8L
 p0SrRLcNqaiA690mMfLZ7XlwD14yyWMuYn3NzN0WwFvYKWh2yqTxVxjNKzEoCRxn+6Lh6E//R1R
 UotKfqNNiO5iZadxiAimw/mkju2Kc5uaLsCPVtoLaIALM1ORhiyi23/oZKufSjy2XuBogIcXmzT
 fUnq0U1+Oeh5KRBAcI4FJ5EDuOL2QM3vVPw5CHBaTVxUvCg72PkhHxk2T41dJ0MliQNhFjNBVIM
 i0zNFwh00b3UiSNkrkGSas79QDK4rhMiYBsgfZUGYjST+qh/p6kM7ccxpbMz3tirdbvMsZxEufo
 M7xuNl4R9dMgRs7AKLfaIIsojl8PL6NpZNLEoFVh6RzLDTt1v687levEf1VfBoqiRy85HTPXUJr
 NsuSFe0RR2EjGM7CjvRbVfguXXSnUnV9PtpU259qszWKt0OBGoXxH4O/Co15e4lndqJuZVDKFX0
 WigE1E0XpsiiR1A==
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


