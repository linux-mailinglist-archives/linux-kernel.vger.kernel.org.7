Return-Path: <linux-kernel+bounces-896769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB866C512E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48E7E4F2E92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994672FD684;
	Wed, 12 Nov 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pazlbgbR"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4567A2F7AC8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937323; cv=none; b=cEZpQhgDj7XbXK92SUDD6AfqwH96mWzf/OY2k7cELnKUbnFItlfi7HnM9O6jiA1TA9/Cj9jkWpzmdxldA4DsnxFRz3TkuH36gGpAb/vl7NollqTw4jgripnvu0pQvkk4rEg8+hHFtMzJgwg3S28A8l7OG7i0NMgMAjMd2N+FN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937323; c=relaxed/simple;
	bh=7druEga/Beb9/UD0KVweY5n8TbkTPFBJtmEG9o1IjOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/lNEuWCNfka/MoKQUDOKOUS+O8sITdpLYS4CzT7w99O8Q3Uy+ZXchK1SeGX7cJFMoNlhxxtDJp1/aZlus+6WNHb+M2Ctn7B6nHrC3WsmbxuXFDL/8h7eQYLAZXUFx1nkaMItAvIwjFYWG/cRQVPS7x/Q4u2rB3HZkZQsZedmfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pazlbgbR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso5008175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762937321; x=1763542121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN+9Nh7UEIyQdcOnN3rR32056vw2TRuOg5ceKeN42QM=;
        b=pazlbgbR9/+aZQK64aKYvXFzNxlhIUziC0Yn06ABFbMBR7O55OTH0+0J5kFfRxsQy6
         FyljLeHXWPcHLnTPAx36u5oXvorlGG5zIMzoHvGGVE5iDOaUhScPQFcDIeevqHtYEuqo
         Gqc8rn0UT/Z28S8fT6NSC2hlZ94GvhQ+jmM1ZA/2rumTQgLIaESRlMp58CMwAwKTv/tQ
         AwTsD09czVsNwmemsH4JHthmQhiQstDor7lmxT5xbdemRqZV538ERS+ubTafjn0iHriF
         hLUF61KXJnNVPsn2uPOGt2VT9V2zoEt5wtRnOxLwIzhmA8ZPRKxDa+6si7p2qyZn7I3f
         9/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937321; x=1763542121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qN+9Nh7UEIyQdcOnN3rR32056vw2TRuOg5ceKeN42QM=;
        b=MnVwGgKPEN911mtIngU57jyH/ctbDzp7qN94W8Tl6iaxzudvR8ca6wBKHVZe3JmLOj
         6j2Ly8DDrpOvHvRuCWg1DEm/36Ij8bviGOhZTApXMwu2lD82txITd9od4gY51INmIYND
         nQXHdhhYgwPPe1LWOJw36f/IdZuOAd63h+MdDhFpZ6G6EbFBGEOEfMtH3IBygzw4Suxr
         /iXTng2ZydJny/9yZrx4j7Rt6ZC4lgZDWoz7WNeZWbUpoPIrrOGt98wEbfZYae6B84iw
         WWaHjSJPVRILY2qFkUJt66xw3inKmdabteIsdDG2ahKc9BQ2iYuBLwexfJypxYGoMiZ3
         otRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVth8Gvb+iz6f6kkNzRA86PURf3XZzE2i+FRFmMTxks3dzQDxqMRWfXqROsYxUeDRuj7V2rt8MvXPxeIc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIPYs4gBdP6OtcuR+BXm1CzUv+ng4z7AOQOn8xVjHZ51uK/pR
	kmZhhED4ukYs64Zu3mHKdLB56WNqakdYSO1SbnCbeQ554EpKSi59ARJvGV03cHZxr58cniHl/Cm
	IFUwkgR3yPw==
X-Gm-Gg: ASbGncv/yfqKN/DNir1/wswyZqwbe8bkuGxTvey27dobZoiV8tfYdeehqJLdUvCWWGC
	kpTcJunBKB3eUg4bhzStjCyxltKeAm7vC/1nGiz5Yuz72DE+dYXoLo2x5crZlvlb4MomsO9fMCr
	aVE4P7zqgxFyt/SNDrsWmsNkNwb0pZEzrS85I6cb0djq/CQEnrMd7nAnLQC41Ud2kAc7Ud+B9mS
	RgCVPkiS9+uuWcjP/uBGbu0rTkgj4ukulHp1AL3EhBrx4khl91gBmbvWbNpN/liFcXOqGA35HFy
	fQMQQa6hKoCxhv2/YMYG7EJ/9+zi+m32fG3PntxZL9Vc9RVJUERUGjhFre8XBz/uIh8IvHsZtm/
	SJHatEho2+PodT9VZucXfDR0RI1sJ2V8tLANAb/gyzL57+zxlZjJ5NsthVq/aSrq6IR7Kjs0Dra
	NxUo8V2SCdAirdVj4ANAs8qqhnz7EszliqSMdDSNApGmwC+3i/iNYooxxf
X-Google-Smtp-Source: AGHT+IHnN70HcY6VqId76V2Fium0LoTjsjCOhICOnZah512u7vpBHuld1VklT35Nc8Jl0M9VCj6zfw==
X-Received: by 2002:a05:600c:5488:b0:475:dc5c:3a89 with SMTP id 5b1f17b1804b1-477870bdf2amr21149885e9.34.1762937320671;
        Wed, 12 Nov 2025 00:48:40 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm3732645e9.13.2025.11.12.00.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:48:39 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:48:20 +0000
Subject: [PATCH 1/4] soc: samsung: exynos-chipid: prepend exynos_ to a
 method's name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-chipid-trivial-v1-1-ec2dea03bd83@linaro.org>
References: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
In-Reply-To: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762937318; l=1239;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7druEga/Beb9/UD0KVweY5n8TbkTPFBJtmEG9o1IjOw=;
 b=N1mZw0ORtHrf96WaYt+Xj7F23BBnNpcHrGV8KfTAnUSHyfJr92KB7oKg0NxAi49zaCk5kHrph
 0efls+TZc5WA/It36WYBngiDFYhBUehpqOeChlNefq4Hizd3mAQWTWO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Avoid name space pollution and prepend exynos_ to
product_id_to_soc_id(). Add a blank line to make things readable.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index d3b4b5508e0c808ee9f7b0039073ef57915d60fc..cdab1d4326b9de5df477a0545839b7b8b402d55d 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -70,7 +70,7 @@ static const struct exynos_soc_id {
 	{ "EXYNOSAUTOV920", 0x0A920000 },
 };
 
-static const char *product_id_to_soc_id(unsigned int product_id)
+static const char *exynos_product_id_to_soc_id(unsigned int product_id)
 {
 	int i;
 
@@ -141,7 +141,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 						soc_info.revision);
 	if (!soc_dev_attr->revision)
 		return -ENOMEM;
-	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
+
+	soc_dev_attr->soc_id = exynos_product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;

-- 
2.51.2.1041.gc1ab5b90ca-goog


