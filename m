Return-Path: <linux-kernel+bounces-896983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E125C51AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA031884F31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8331283B;
	Wed, 12 Nov 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bce8dTMs"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC73101C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943369; cv=none; b=a9GqmoPNKba7hQkQ3rgPdVNaw+sVpmxR+Fiq/RlX8FgWXSgUT740DPfAM/CRdFWgKSHrAQb3ORySJ37gm7AuDOnXY0CdpI/uy+7aXKZ0YTrjTlcsIfSq/iWdlshfmIuJ26PQNKJghMiMK6f+5IVGnJGGkjbMHIVsxt11I4ZVeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943369; c=relaxed/simple;
	bh=+aH+JurCwg0QlJViwe8zNd/4id1AZbIUdYoRKokeM0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQC/cW6z/aiVAHbfzAEwwObZHZt1ihsqaUQSflKSESq+XA3Y8QQpdNfZEc2aVVY6hu4/F82JNrH5ny76Nd/mTidgjCEUeL3j4j1OT6OUt+4pPG/TWAAE9JXfWShloIV0jY7lGQqKKYcDf5lbJn4TnQFHartyVyZpc6JYBLS+bNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bce8dTMs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b32c5f285so82469f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943365; x=1763548165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voGjtCLXJQ103IvcxJUtlMcY692E9mTOAHZOEmcxLCA=;
        b=bce8dTMsSevt4KUrLpmTh2G5D9BYntLUb1kG8sgs9nQ2IEZpNiEE4J9B5YN8zJHQUd
         kIpUVU2h1L4rxop2hvPEo9cqQt5F6V7tdy+nye4oJmoYx7640jHy3F0/ljI4FdHF1l3m
         ciGjyvuW8fzUgjQ2DkdeH3a38h+YuSs3jQNKRfVnoFVyi4FnQ+oXfMFH/lRkdzpsDLDe
         cO4DXv4JBIVjUD31BMFP9V7Svl4871fSf+QIWRB0QMRSUFz5PLHtYL6XXr2pJGugaBGB
         pf7dtKEhZYwfmFojEGIsBvlE3JeCAdUAGzdBSN1zDiA6uKJpnCRhyb1JroRa32qven9z
         PUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943365; x=1763548165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=voGjtCLXJQ103IvcxJUtlMcY692E9mTOAHZOEmcxLCA=;
        b=TkjNwias2y1Bnb13iFBzDVPOco3vBkN/u5/KX3ydp8Y91WTfxhjA7UASvrD9Qf+EFE
         0G1pAMjqVN2+BZEj5ra5a0l8SNe6/0BHNWQFqhuVCVoh86qvJF+16ezrGJuHFcMYBJTU
         88c5FHAPlE0q2K1oAy1hZelfxvQNtbcVU8NXGg7JJxrGn4RFxBbzzJHodH8024RzqIkc
         6eVBPAhYv4Pz6+vJES4FH/njSOBt3hbciTM899kh2+wnoYA+Px+Z+Tg1Vd4WEL2GzLXo
         foAyvpTkBIGEKpIO0imj4QTexX+3ziIhisMo2LBsCMD5GIkBFIPZgjaGOBm38K2dBtaW
         6yNA==
X-Forwarded-Encrypted: i=1; AJvYcCWGoWzsCfxewSVkw24FCc7GD1glzCm1RvGpyvSbLX7v4hqeAXRbcUuJnSM5qrPNEwrT2Pp2cEb6SL8nTp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkpHWS4xqSVADKcDk/nVveK9IISbwdKE4aE/oe84GU98BdXFG
	Hm/FbTz0aKG/93BwIfJyMkq8lEDc/HFY0wedDeSrvJwTN+Xn32re7qEtosSkxs0FTVY=
X-Gm-Gg: ASbGncvvmfb7pt87uReFManb7ipDfmmsNf/xwzpAnqZwvUwFa1GW7iQADK8c9azwOQc
	bHlNCdC+8EFl08wwWJkUHZkCC/uN2tWcCBAY9WD6UjmIOgXiqAe/Ao56dauT86loLnDyitgGiyT
	W9vCbZwYNahd84R73uWMwPvWWWSirZPgAI1oDDBzA6Tbkmr5/sigyWbu+j77GTUR0bNyLlFsZwc
	fJddPrQSlSXjbWjBUiwR/eQocOmEoEz87yR8aP/ZnZbX7BniycYhEbxLuUBc+Vi1Ee0/zWuy7CT
	GRmufIoUYm+6uifZrZppNX/ZJhHjQnirA9aJym9Dn3r/+amTWg6sVMfIQvdWvfcgH18++7Tr5E1
	JOOqg6wJbHHU9HdhdyW5YY5jCSovF2nDHEw+bUwpuwCOmWDX4xT3vlYZMYQHPjk1LBSVIeYCKDe
	DV5E+Pr3TwPYnHEjsv
X-Google-Smtp-Source: AGHT+IGdm5CgPHDdcAc01ZcCVfqMCxIri45JYHWGmyw1iVsO8bQLTxdHdmxO4vG4a/Zk9xWBzcJSig==
X-Received: by 2002:a05:6000:420b:b0:42b:2c53:3ab9 with SMTP id ffacd0b85a97d-42b4bb89ce1mr1221439f8f.1.1762943364882;
        Wed, 12 Nov 2025 02:29:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:55 +0100
Subject: [PATCH v2 10/11] soc: qcom: ubwc: Simplify with
 of_machine_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-10-d46b72003fd6@linaro.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+aH+JurCwg0QlJViwe8zNd/4id1AZbIUdYoRKokeM0w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFs5hxrLTLU2yKQNGY4c8zsgmqPTtepwFjYk
 DaDIUKpHwWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhbAAKCRDBN2bmhouD
 1wCUD/4lLlPUHzwHx+sGWsRshk6kAv1NQf0XHRhnBKVMQaVXbw8aURXRR5kkE+7+piRRXT/q8An
 wsfuNNAfLqFXoJP3e5gtl7+ArLGrCnVXIPqRYedNyt74/hPMEIzY/sjsGIQfVI7BuN7oUWrev/J
 pk7i/cSVy1Jlp0za6XuyxoENwsBLMVKaRCvzkIcJh3q7QFCqCVMruU/9l0YzfNhJZOsJI2/Dzgc
 6m7bF4aFG0x2brLPOVhCQl6DXf1GAxawfT41GlR6qbainZiyh+sLWTkzPRMupMeo6P2Nqo5eQlB
 Kbd8hcPYnB/UExqQHa+a7X3yJDerdWlO6OKrD/unm7/tDtcuOVGuUEbQYYemwI5WIjTx7Y9Xl9m
 4y6iEFYcQ73bh6B8AlwB66Svt7++YvJoZRHeocf4hDFh6Q51mlJgkQ+OuCCYWjXCyPV/uzTGOa7
 Cr071sdb4yOaS1C/Kyotz0wi/1XMyolAx1A7SY2rQ4On2JCL29izxAJTWbp1q0ma8BGOTIU2SkG
 EUdWLUq6kY6JFNBNTHNAfsxtnvGaU9VzubyzUIlLAhUo4sqlqfeDegWPNaHSHKyb4c3Wn3a7pqR
 Jzp/MnBwhbOZcNRVcDcpZmtwe6Q72j5G/UHpzADGZogyXJ7EfofT9FLwxzGInOO/vrPacyh3Row
 dmk/KsH4kqnWzJA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node, matching against it and getting
the match data with new of_machine_get_match_data() helper.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first OF patch.
---
 drivers/soc/qcom/ubwc_config.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1c09796163b0..1c25aaf55e52 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -301,21 +301,15 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
 {
-	const struct of_device_id *match;
-	struct device_node *root;
+	const struct qcom_ubwc_cfg_data *data;
 
-	root = of_find_node_by_path("/");
-	if (!root)
-		return ERR_PTR(-ENODEV);
-
-	match = of_match_node(qcom_ubwc_configs, root);
-	of_node_put(root);
-	if (!match) {
+	data = of_machine_get_match_data(qcom_ubwc_configs);
+	if (!data) {
 		pr_err("Couldn't find UBWC config data for this platform!\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	return match->data;
+	return data;
 }
 EXPORT_SYMBOL_GPL(qcom_ubwc_config_get_data);
 

-- 
2.48.1


