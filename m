Return-Path: <linux-kernel+bounces-896979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE3DC51B62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1381B4F7755
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075130DEC7;
	Wed, 12 Nov 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhDK3/RB"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A330B50B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943361; cv=none; b=a+dkZSvK3L64g7ao0tZJ0tjE8Cw8Osj99HC/2IQVsQYWv/H46JzwtSNU0U5tcrBN65UTncDgzKN+TA+ii5AAQYnu2E1iAH19y93KRORgWkHG9hc9VIKwwSmgYvh7VqVcHc4sEd9JAScOFVi2e59ZQ+5mlMfzYuMy5ctT5u7HX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943361; c=relaxed/simple;
	bh=kT5IA0GtAEQVfWhYH3L9qEziSnbAJtbqUptdjRPcgUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlaF7JGj3U0zn9FIXoPEMzxbAQWqk/ytzlj+bRrDGZf+ACbQCMH8sOjVaXqvN9uO/7EPPis/7sh4GEjyjv30myESZngnb62EHSE6x/WXTQLns1s6+6VFvCJKpqNqtWi9qAJexxFgFne/nlgwCqLeYbEoU8RyvuFvdmMLSVaVbGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WhDK3/RB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2cff817aso98813f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762943357; x=1763548157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBavdG36JhZKmN/pedjw25qWHClEhA6t5bxsk6oa0rs=;
        b=WhDK3/RBVYDPnB9yUvRMIpmxuzu7NabzaXD6my13CRIPaKCeKN8jf9QQQ8JwtJKTch
         byw7aXhqu0CrspkxHTR4sEYidaXck3oZ4csuEo7ZUcQsWEO56MBMgbfcfVfiyWcjuf/p
         0S73GGOfHxWjyOmGSgq0gywSSbsliz/ffSu4qibE/PTXqZJb3tFkvUiF5ZMTL8tVvr0i
         IHulXuKEU88l4v+mpfht3ZPcSwrB+WV851G7UkUVrxscIf/AOGIiflvS1lMOZivNWrrg
         xK3qCcYbZMG+k7JTrctGLdQOKOnyli6UwqNDsQcT/KgjVxbLgkemoq4neqgm/RNqxLH0
         YJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943357; x=1763548157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBavdG36JhZKmN/pedjw25qWHClEhA6t5bxsk6oa0rs=;
        b=PKoh92d9J23QXmbKDHryeP9MQX7gURv9cMfjpbQCZlCZvhDp3xDrWz2hQvh+0qGmNh
         8QnVgNKltLmCW4AHO7QnFKjNNq0PN4BsAh140l+UZpyqlp9r9arzu8h0gfDkMfON9Kew
         6W1GCMp3bgLV/1XHUprqrbqUkbIcOZ8Ttg7iNIjuBqD2EN1aojODeyvmGutAlI8TMRyZ
         2ZIw7g7KLbnwkbbdtMFo7miyxNTuOjRKbrMu0n4N47Js/RjEZK5W6SB/yjKJU0hogeNQ
         TBfr639KKNpf03JzMftK/IPU7EkdXufOlMkd2pzXHUToEFok3QN0AG13aLz9P0vVSEI9
         0CMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzF1Cm11FrCYbcF4LI0caYRS1Xw97HMHNIfHuccENO5k9tcToRrlSas7iP4tcEkd1vLPI3IX+7lcF/6LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qgdpgMbQZr98HAFYEqpyn9GJI+NmmkraBcAoA6rkv10id/Px
	quk+7cnBjqoNDcQz4yBskMlwWst6JNX4mo6KPgD3ZQlzYUqH1uYFcyRU6fCAByCyyEY=
X-Gm-Gg: ASbGncun9oKk4Zg60C0WItAUaq8BYEVf3GOFLsmv35NvPZLU9l2ACXMedhvSIwyNgW8
	kWw/uWMNo4tT8lJQD5tXoG7HX5UwEUMvwqehIM2OwuEHTWyhtYz8fxD7t5YTfzFEQOk8d5EMOEy
	qvTIqsCLKBTLMNcqy6Nvk+KaiaDdVd55PcGPy5VdJbAhgwCShn7MS1GDnc+xcS47ar10LXJCVzC
	W4EzzvB5ydkoK/aMl1uStSGzzB0riviav0ed7XzGDKXnHhAK2aj7lXx7uzIZkg/kS1IqM0hBnuU
	F3ifCrf6SPECSA5e9bWyNcSQ2Jh6JrAlmPjgFKgDRSRmepXWmmu3rStkOFxbVrs0QunHdVTi6XU
	QlLLg1zMVdDILmcsUW6B4eD+Y4SSBFv8oaxX5ci/Otx3G4E78AyBeBQVqedzow7Uk5U5MB37MC1
	JclcljHRvD4sDytk2y
X-Google-Smtp-Source: AGHT+IFcsJyQX0vQHIxt0g6rxRaeK4KQcZ7ubS4Xn6BHNva6HYRONLKZdEpigTSHkx+N3rxTuPNAQA==
X-Received: by 2002:a05:6000:2888:b0:429:d4c2:caf3 with SMTP id ffacd0b85a97d-42b4bddfecfmr917139f8f.10.1762943356808;
        Wed, 12 Nov 2025 02:29:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b32ecf522sm22020001f8f.45.2025.11.12.02.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:29:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 11:28:51 +0100
Subject: [PATCH v2 06/11] firmware: qcom: scm: Simplify with
 of_machine_device_match()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-b4-of-match-matchine-data-v2-6-d46b72003fd6@linaro.org>
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
 linux-tegra@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kT5IA0GtAEQVfWhYH3L9qEziSnbAJtbqUptdjRPcgUw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFGFoaaq85XzS8Gm+QHLYdjGk6xAwN9M9CcUpd
 yKEYT6rj7WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRRhaAAKCRDBN2bmhouD
 10RbD/0QYyKGuzIytM2noX3te8ScA/nUleatTJOM6knZFKx9CzhpYG1nOZVLI10Q72t5HzseI+4
 Oi4wEKdkIUc6XVheTGBlr8XH/Ezs2NIXUugeMoQ28U1w20QF+5sOdKiBJ8lFGbqUkaW5ErSIVt/
 /3YLlicO6MacIZ4wG1GV3ODj0yi29Vwzsw8iQ6oINdD7te+YPp7eyFYr3u9hVy7D9m+AtgpqlhE
 1jwS8nFRrDTRBr3vIOIiXi6uTMdXTyROOufwqlETGtvxuy6WC0fZnONEg2PJ8qVsPQNOyCBh0Qe
 KuXhHY2766mkdS+jVh41HhZh7SIw5e2xVOU2um3CFI40O24+xT7NU210IHtd0D59Tlt7f8ahqeT
 gqgGRTtrIZEtR1EJqjwVRMIFU03xVQa0xRCSi0n0lLlN+IbtqaO6q7tuszNI5dmnr83xoxqPSmw
 +ADtjoptZfcndaqEjxeun09qQBsRMAEB6TRQESSXEFwnhpgJx5nYI/WyXlNdMqRoWjIPW9dVcVZ
 2tmiITlPOWGxzTM7M0qFmJKgZds1jse18mQQhDI4U8b1YwJ5dY51NFWt/lDicye1EK9A1LMjS2h
 EuQHxg4sJU6eEe4Iuvo3xH1mzT4yrfSHABnMOF76JT3JLeDs1x8Mp3J67S03B0BKK8z92LlIU4Y
 mvucL86lWwzH1vQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Replace open-coded getting root OF node and matching against it with
new of_machine_device_match() helper.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on the first OF patch.
---
 drivers/firmware/qcom/qcom_scm.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e777b7cb9b12..1a6f85e463e0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2018,21 +2018,6 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(void)
-{
-	struct device_node *np;
-	bool match;
-
-	np = of_find_node_by_path("/");
-	if (!np)
-		return false;
-
-	match = of_match_node(qcom_scm_qseecom_allowlist, np);
-	of_node_put(np);
-
-	return match;
-}
-
 static void qcom_scm_qseecom_free(void *data)
 {
 	struct platform_device *qseecom_dev = data;
@@ -2064,7 +2049,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed()) {
+	if (!of_machine_device_match(qcom_scm_qseecom_allowlist)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.48.1


