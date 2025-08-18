Return-Path: <linux-kernel+bounces-772859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C7B29899
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2183AAF66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745B2676F4;
	Mon, 18 Aug 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="neZ+gXwx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC2267B9B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492105; cv=none; b=BSLLiUJzDL620Hq1Ky2Gk589rhtx0eJaEq4XxEMhKR0FnFyFjLVpRt0k5bo+n4Pc3y5/9MQM3vFOM0ZsdHQUzod4S5lwrO+BZnljJHvVzCAB2EIQwiUFQjJ28cO3GHxWEUkXlCUWv1sm2YSFb4wjYeee7cabcbWt8ddmKgn9gJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492105; c=relaxed/simple;
	bh=GGuWQsaFj5N1Asx+oiUdrjXtCKQPDaS7TzmDRzr00Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=USVGvSS5L/+N0ZhCzcMrniKUcvX+fXLts8SsOoL1GZ+wU3nm/4ScoAAZo4af6lUAKxt/BZOuZX/IckMz/2jvfqX20tK+73Wg4haC4vTjQ+bLj9DYwu5XDOmXvTAqhdl7fv7M09JlkFfX817OxOOJbpboD6J+LFxXJYnMvPDmjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=neZ+gXwx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HKN0ml020696
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U0xnmUoPbLe3vT3NMmzy6zQdJ0mJHLlIGC1PWoFjBq8=; b=neZ+gXwxh7DYoV3Q
	RwltZb/MFrqFAdRbBoJhw1q+d3H+1qtZB06Hhg9owEftks5nyuSqwwBTc6K8ZRHB
	UUEgboC5ZjnJ507kGkmVx2XiAdPOFb5/1coFKYii/0nfWT3S9phecWXdshQB5yVb
	PHqKFFy48yWYBvUDHa9RfiM6gEZ4bOwabPQeJj+I8KruCAZgCAI3mmVrJy/5n1in
	AcRcurrw/5tAVtwjVQRVu9mO2ZFloWMlLxsc9svEK/TeG4ntUTXgDP/oNoz29IqJ
	UZJwFnIOvJ5ViXaRMz56/QdExvMzuKMK+XngfH6dC1/PxDbYMbBtcZP3TYjS/iZm
	fEVaCg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagua1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f42254so90896075ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755492102; x=1756096902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0xnmUoPbLe3vT3NMmzy6zQdJ0mJHLlIGC1PWoFjBq8=;
        b=YzI265qQFa9fRY7U5Yz2Lh3edsmnwx+EX+97OnBK1rJhvQde8eGpMVtzOaNbJnqRg9
         As8pcBtOhAoRme7nPsKUIJrj1KGZg7r5uPXROtawVLnCqjiaGJhVlJNP29GuFPA4kuKB
         MVTuThFx+SQZe5rVwkJyKgHYwwHKrA5i1nRlbxA0gWuqMdH0ycAGbTmaBwZ7e/bNe3ad
         knEPxMcwYb8lKpqBi3JYerUTzLfpB6MMX/puACBKsb7lr+4DyxEnOXDdcYa8EB1VO86L
         bA+C9uMpV0AgeqSr/JE6byt278JYi47lui3sDO/3pyd7GZa0dKMVa1uHLDhGGlECmhNY
         pQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBxz4DA2wjRKyIlsV3YOS0MkXZ74pJlJdjJ+qmctqUXdRvVQAa4NGtw9mey5ZVOFky6Rs9nu2ibL8PBUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrYjer4thMK1HcqY7WNUBb6oj4BWn3lU38lMDoAlcvga6eD22
	lHQPX0wIRkd1Mov85mroMSwN6uq0d1KQSUrzGo4noawpCcGWS3HwA+k8t9DgjIyAbKecwch2Nke
	mqlKjkhI7m0+ibAJPIol2PImdEoFOTkqDZc/2Svtq2MHO4bkx/soYmxx5iuMeKXC+7Nc=
X-Gm-Gg: ASbGnctQGxeirlPGaN8nWYjCfz1PEgfxcUOIJ29cPbO0QiNEsYwJVgP0Wqcif6scARN
	UcDIAT8kMsAk6uKGIybd4K/jBUmZZXo3MUESQ2+FM7mKRN5e+yzJyJhTFBOZxfhBMytS0ZAJdo4
	FJr8uvmBTuhr9S+wVwZ3Txz3B+VF1nmjYrSsoxGzIkN5ak2bfp27SgctR6g8N/BTP6dp6OMHE4H
	sCjwSSw7NRlyanCkmpiFqzEjkJurpTJiVIyABre5CMNk9ej2iOF+Thv97YQFLTETrYNQIWjc3Gf
	7+Wguu1Xnzz981JaUlISFhrrNjvshqMZQBOarOqsIjRxtsj5qwkaJodkd4i6aFu0/6EBFHgSuN9
	QDW4DXd55FgnzQOwKZkEOoHDkzlNPGBfcd6r7R0ePXCzX8ugDqw3L3WtA
X-Received: by 2002:a17:902:da8d:b0:240:719c:65a7 with SMTP id d9443c01a7336-2446d6d32e0mr159087595ad.4.1755492101668;
        Sun, 17 Aug 2025 21:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2thLy29PrxJ70+GSafoj0wED9GTya2I7AqB3dNKWfIa9uz5OFViAwXFdIZoBJWmxi0q7J8g==
X-Received: by 2002:a17:902:da8d:b0:240:719c:65a7 with SMTP id d9443c01a7336-2446d6d32e0mr159087315ad.4.1755492101276;
        Sun, 17 Aug 2025 21:41:41 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53ba5fsm67547155ad.113.2025.08.17.21.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:41:40 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:41:23 +0800
Subject: [PATCH 1/2] pinctrl: sx150x: Make the driver tristate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-modularize-sx150x-gpio-expander-v1-1-c2a027200fed@oss.qualcomm.com>
References: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
In-Reply-To: <20250818-modularize-sx150x-gpio-expander-v1-0-c2a027200fed@oss.qualcomm.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fange Zhang <fange.zhang@oss.qualcomm.com>,
        dmitry.baryshkov@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        xiangxu.yin@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755492094; l=1605;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=GGuWQsaFj5N1Asx+oiUdrjXtCKQPDaS7TzmDRzr00Zs=;
 b=tZXVod/q1p8wOuV7N1MK2nF9TrizbNNHavYakcjr8j4B/K2tK9z69Df6o3cEVnvu+upE1qyfH
 qFNvcdEP8QBDEW8+HicRx+0yB7Asdqfme9BgIIM/a8FZQg8jTsMVlbJ
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a2af07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=jVJqA2H4-3kyb8ebEaEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: FCQliPn0G4vPxBFMxn-O2ZNYtnLqu-fT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX5X9wZMHvKsxT
 SH/ZiEWmMsXQOHP+mrXCO3Biw4zdUUgkf3hoT5weKSTUTw3UHdWpUypABlzSCLAGrhC/TT4yela
 6lK1jlWvV+NWAbtY1Jj9Exs6ESpTs8JpyoC/NBxXI5VEssF43245TzJcRTk1JiwT8gT8Hx2q6RI
 YL70iYck+R1V1fuH6WwR0QIjf1ccDrBpbr9f+2cruej1EAIEs+FPkyfWhkpoRfllluWdAs9RD05
 /NRu8sXNzswKbE5CoyAkJXT/HVylD1U7WBIVkMVL2XuvvDt8SprxSJX+I3YN+HrPUPsP2F3hLX7
 VHPKLyrDDp8wnGvBnkX0/QqFGO800rfy//KS4f9LfVOvVgFTqHy/QL4T8tO2N0dqMMLjVuWse47
 ucUuT3s4
X-Proofpoint-GUID: FCQliPn0G4vPxBFMxn-O2ZNYtnLqu-fT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

Set PINCTRL_SX150X config option as a tristate and add
MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate information.

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
 drivers/pinctrl/Kconfig          | 2 +-
 drivers/pinctrl/pinctrl-sx150x.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index ddd11668457ceded9861438768f89945f2307e31..3d06f02a3da549317a9364540d1b598051b926f4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -550,7 +550,7 @@ config PINCTRL_STMFX
 	  interrupt-controller.
 
 config PINCTRL_SX150X
-	bool "Semtech SX150x I2C GPIO expander pinctrl driver"
+	tristate "Semtech SX150x I2C GPIO expander pinctrl driver"
 	depends on I2C=y
 	select PINMUX
 	select PINCONF
diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
index 53cf8168b274c5310706512dcd3ba8d4d25f5049..b613568b42b73d1c1b220b641e292055e23f4de2 100644
--- a/drivers/pinctrl/pinctrl-sx150x.c
+++ b/drivers/pinctrl/pinctrl-sx150x.c
@@ -863,6 +863,7 @@ static const struct of_device_id sx150x_of_match[] = {
 	{ .compatible = "semtech,sx1509q", .data = &sx1509q_device_data },
 	{},
 };
+MODULE_DEVICE_TABLE(of, sx150x_of_match);
 
 static int sx150x_reset(struct sx150x_pinctrl *pctl)
 {
@@ -1266,3 +1267,6 @@ static int __init sx150x_init(void)
 	return i2c_add_driver(&sx150x_driver);
 }
 subsys_initcall(sx150x_init);
+
+MODULE_DESCRIPTION("Semtech SX150x I2C GPIO expander pinctrl driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


