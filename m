Return-Path: <linux-kernel+bounces-772860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C0B2989A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D243AC7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6626AA83;
	Mon, 18 Aug 2025 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OxBisv9R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E6826A0AF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492108; cv=none; b=cA/s/+/rpFjqxu/y6B/bX7YMndfg5QehRALsyAwQUdrch9aO/k133FMUgMRBGykqV24tj0W1OkDHe3TIXvk7IIs+zPfdsr24bkTDTPGFlUHflMAXWlDOzzm5xVfr7ls78PYImznuKotlhnxkG9R45CgcUFatPXlhBjcbMGi5qNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492108; c=relaxed/simple;
	bh=VyAXqrL1J25SHXJIh8uQFCfLNfdmKv32ZEsR9r7oEic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYeo7M+0ro9ww8aKY77GTdCKTBTUFpC44aU8nMsL43j5kqO4B7gTYj7rBmYw0sn7Yi0PPK7BXR/HfmYvFKP50hAOmACZZTlVfvNkEHcfpNYwtjS5aJTH3O/0yR5J+6v7HEcjMb6hbfcnGnfMWHK1Ox62J/ofZXXBYq6ITh0ketY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OxBisv9R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMurFF012495
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Peq5jroX6bfA9ULfbqaeNxDwibXDATliD+d8eaom374=; b=OxBisv9RbLUOBWNt
	YMNAoAEvPQnt9qe5uJvuk9CY1kh2WdS+nAT1Ah9quVeuTyUZtn+BRVeCcyqiUEFQ
	DB743MR/HGOEnQ8nDsKUREOGYVJD/JRjNAmdNEXk5nOx2/HScARBVz/85Vy59Qxv
	baumhmnWe5+poL3u/t1e12Z6IBKUgEi9yUnU6tz2mHAH1iLUJWBKzjnY7ZUHaSRv
	p9GwfyszF7h7KkPf8behsqawawKftHvXSCC6jFZUSwGSOaY2rWaBPglMOdav16o+
	7LBSaePSBdHDz4Z4cJwaSNN6cPlkim0pm6ZtfMqg8X+lwMUN+yCrN5WVuHZlY0Oo
	aX7nDA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfbnbft3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:41:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458027f67so88452895ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755492105; x=1756096905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Peq5jroX6bfA9ULfbqaeNxDwibXDATliD+d8eaom374=;
        b=jJjn8kOIwXf4TaJySEoCf1l/zp9PX6rZD+SqXw4DvCE2JxX2mIjRHC0wHSQZMDPd9T
         9Ub6ujWPYjHSKlxt/S83v1YBmWjxdjZmtt66r86KnPXTCCt3/+TaSVV6c7UnvCw6FoF0
         T7oElb8+yCfCMTXcCDL7zq0baOXNuKwz/mn+jKTb1Q2SyOoG/V9g54T9W8hf8b0j0ut9
         zDXfprfbJtQZLeHEMeqI6SAvxigFgMmz29vm+hx0LK0r2WmEbWd9ISvBDzF4X0FJB52c
         ufKZ63KenD+DiLOFTFauk6o4FWjc2lWFPJQwDT7e2Q0Si9gSQCfQON/CVU780kov24Wc
         yF7g==
X-Forwarded-Encrypted: i=1; AJvYcCUhYXXpxqhL/aDR6LjWDD8AdnpWPvmvdTxVQspQyNC8MjWJlyqKAiQXHtweb14UDI4F7MKtb+s+iHzD6ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzii7cH9gZUePpb6/ZStq1UTwrhyLXrOUfSx95vNo3c2063AqKo
	e4LXBeC6sv9jpy/I+hGFh3U1tJxQlI08N6lkrFbT2uJr68ULqX8xbjaFXWcFj78MddgPBNyyluk
	JiPXYklfjcM9A7o/TgiQqfr6r1TsWzlScwuTs1zgzikHpA4mbzyB9asp0VMcEeI/VlDU=
X-Gm-Gg: ASbGncvpM9I2VBjTRyU1COYOdzO2D8BbSkr4ktmEP7TNcTIEve+e5i8DHupeDQ+cI2w
	knXvBgRMkbxFEGiz6Wj+BPOPpF9Kcry/VJtDw/hvlOjuPtAbOmxwwt+OPJ3ZWtmSv1s9nkg/U9l
	7mWOS3M6qsTxnkTfofDdEUwg2TojyzJIQ1NEPZO7RdjI+cjMaiimS7NayroNKhzard8XXOhxP1Y
	ojrVuNGDDsG50EvtA8hhnd/eZkwttlpycAWUYbNcN6GKYhVFkNGtWuV8Oztxr/VhXDYbTr6WHjW
	0nKuEFKrIi5TfzK3V6cixxesl91REtwWkZjCXoKJJGNdMdYaJ7fwEQZ7suHfaCQZGw/xVBUuhAb
	q2xJyfdIeh/LbLX5ioA/k6EAxwAjfGmKaMxIlCZzb12aPRTx6nTAcocww
X-Received: by 2002:a17:903:2d2:b0:244:65c8:c1f2 with SMTP id d9443c01a7336-2446d713833mr125854495ad.20.1755492104750;
        Sun, 17 Aug 2025 21:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJSbvnyIWPvgIJzJYpANNMRobaCFSmLvbGiHmUQDK/yFiIYbJT8OVIneejTGAw9DOE2vL8g==
X-Received: by 2002:a17:903:2d2:b0:244:65c8:c1f2 with SMTP id d9443c01a7336-2446d713833mr125854225ad.20.1755492104324;
        Sun, 17 Aug 2025 21:41:44 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53ba5fsm67547155ad.113.2025.08.17.21.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:41:44 -0700 (PDT)
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:41:24 +0800
Subject: [PATCH 2/2] arm64: defconfig: Modularize SX150X GPIO expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-modularize-sx150x-gpio-expander-v1-2-c2a027200fed@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755492094; l=758;
 i=fange.zhang@oss.qualcomm.com; s=20250714; h=from:subject:message-id;
 bh=VyAXqrL1J25SHXJIh8uQFCfLNfdmKv32ZEsR9r7oEic=;
 b=41yPYNLtiYTsrZuLq5hgyVMh5pdRS9C7Th5iCJHTQ/sJ5Rg0qNnCJ8QTPHbnAf7pkcMUFEIfP
 q9aTTFOyrmdB3BY07mhSKXGC4Vky5MwPmZ2DY9H+2AcuK2DtgPC0yy/
X-Developer-Key: i=fange.zhang@oss.qualcomm.com; a=ed25519;
 pk=tn190A7bjF3/EyH7AYy/eNzPoS9lwXGznYamlMv6TE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfXw7lu+zOufaS6
 yqs5En7hQkRPb2fAWiJUmXSrb+fZrOtQiGIS94VbUJMh7yEKwuks355LyhZMMkn4yNsbvMNNyR9
 629G9mr8I3bpWa1gn+avFWo7oOu98G52qjBBlGBLOf4/HsIm72ePF2bf2ABH3FduAMfw16+DaQS
 uRY1oVi18AT8GI1hp+hD2vrTgsPxprg9crofa+Fkqmq0AWbg4s2HUMnsrolMPWJXaueqZyfi17o
 5oCmyBL4sjmozYlfP7uXxHMlWSSSzoG21zcpQbKZ95ifAa6mgIziUfo95Z1Hid431EQFFVJFPaE
 50U9ElvkaPVo0kD8yyDmScdHnnQHFCFiyocBezdyBPj3N3/JraUlbRatJpV9BWr+uNVnupKyKbb
 2jJ0n0xq
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=68a2af09 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=DrVYGqsxnvAqSPjisG4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Ko6Y3leIRHXbN-1nWFfTWc24N6IevD3b
X-Proofpoint-ORIG-GUID: Ko6Y3leIRHXbN-1nWFfTWc24N6IevD3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160001

Modularize the SX150X GPIO expander which is equipped on the QCS615 Ride
board to allow the ANX7625 external bridge to function correctly.

Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 667c4859ecc3cda9b0a3dae7abdd8587fc4f8dbe..dce4450fa9fa58fab0556a6e84b899a3306b4db3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -598,6 +598,7 @@ CONFIG_PINCTRL_DA9062=m
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_RK805=m
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_PINCTRL_SX150X=m
 CONFIG_PINCTRL_OWL=y
 CONFIG_PINCTRL_S700=y
 CONFIG_PINCTRL_S900=y

-- 
2.34.1


