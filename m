Return-Path: <linux-kernel+bounces-768109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC79B25D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF08C62163E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122626C398;
	Thu, 14 Aug 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TygObaPa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B9255F31
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156153; cv=none; b=ogJ+0XT7hIprdPGJkBzoTOayLYef2Ri8AVuB29CVUF96dXw7/Pn2IjFfQcBixOIxomeYEpdQY8BrBROUWlCUqJqI5CR1dAOMBNeoiYnL3cp3OVDypXhizSolY7WLMYES9P5Z8u2RPpgnjQLlOHyAoh1C1xKkBDm23nF/G6df4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156153; c=relaxed/simple;
	bh=btgYT7isNyxSHT3vBtmVm8ZFwJQkF6zS599ztboiirE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZSClHnL6nHNRN+xzG0Oh2BpRRALuGHHr9qjRfgXn8vhLDSFmWuQJZBm+JRyfV6aF2Zwc3kIQCM3xuRqUrfsyMT7VZYczgx61kLi755VjnzVfkFuL8csqHTa4cZKfzOHI1noY+XxMzf/7SB6AUiAiV4cWkjv7OF+rkipuCuvjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TygObaPa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLwdh0002794
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjeDTlRvqKRVSDE2XA3jPNpD7W2lMMrCoAkGvvLiNPI=; b=TygObaPabM5k2Ffv
	CfZrgVnWwAL9bhiYVaNQ/McKao2NXDnJkM3bOzFcVPIUT/d0CfLbmOlNsPcIlrSw
	4mj5yDriPrv0+c71lY1LtTzSGFY8yWWs+QYXmQorRCZ7WhnBZQ87q4GaZ4gIuaXi
	0y7f8vzUJ9B3A8T3QtGQwOns/OKO9cpUSzgc+1UTjn0s/i9Mpt+TpAROPhZJkKG1
	c0LKdKuDqkMrQr8FOuuIlBWvHU6xTDQ6GMgAswHw4XE+2piCNnZlTmnz7YUSeTBV
	eZqHpSvF5NiittwUH0eCaz3DtXatroFaao0Co+lN3e+galEBKqywQWmYW6c3z0lD
	/wuc7Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdv6rsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b10ab0062aso14943491cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156150; x=1755760950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjeDTlRvqKRVSDE2XA3jPNpD7W2lMMrCoAkGvvLiNPI=;
        b=QQ5xFDcWONyVagRcj65oJNuuPyXqHyzjqDHnuxnHX9m8yvv1hRX2oU4fxwgAZCflD3
         aUsAVj58u5VT5LLMMZc7TEw16a8vMpaOFz1R+LjafP9/MvS0b7YbZ4/cYd8m+btu6o1o
         LoyClwhHw/P3L50xyYG+F3D36I+cOjkSkeG+unmt64zTbk5fbiWI10GKu1oV4D6GShiZ
         /aduOGVYa3+6zRkY4V1dLR48IH1E/X8MXLCUDt0ORtFxaZcc8Ty5cqurGwyDprsaB0z/
         eqIJjRc76YjfC6kjNy7J27DB73hstXne7GV2cyt5xoCnSutLTTYHtWdj4CAtCma0PcWp
         ez5g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8itiJZCPN1sXAcqz4QVpNbC5gN/zvUtQMCGVeuvSbCSBJlM/0LxAn6EUB4AGcyEPH2f3M7ljklgEGro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAnNw9dfc372cU68Mu0EG65ik4rpU0aMV/Du+E+x29g1oMJO8
	+fVfxWYkK/tI9blt3nI9eK7eHADFA0WIFg0RJH+pgbTc36AXjUPd8IaS+79gTBSjvXzzg5lFMK/
	z5a7EHw0XEgn2QX1bE84YVKUwlM+0b+HxPHByrqcjUjkeAJ++C2cO5tAUriySrxtOhVY=
X-Gm-Gg: ASbGncsKnuDPaDfB8POgwGI6DmrzWR6FZY+x/Kx7VxFRsuopzopSNCU7zMSjDHXfi82
	UyidiWOSTVQFaqHScniLvV4ReUM5Q6vdOSAEB2WbrfavWjVbCwUm0pjTXuByY9IenyABdIKpkMZ
	/qsQjcJC6KF7jIzjo/ZIegabtmKN5BpHbW7IINJMGU/ulFyOXhT+6CEgJ6mP32ub/TDwUihOWGQ
	vPk70Q0xlC4/3o7y1WIWbl1RsJnqApWgkelLdU55AQ0X27fugDoFB1y/ZnZ2bA2D5/5PPD17o23
	TKw2YcV3tSQF5CWnb1a00krh8EZJ5ZfNm8exgWukMnZxooa9+YRJfjMBkQVzzR1pjp5ckYaT6uo
	m1x3xGMyYAPdRP8GDzyNVGrGE9FH9Z3eSlviSPTzohfZ2GnUAKhWR
X-Received: by 2002:a05:622a:48f:b0:4ab:37bd:5aa7 with SMTP id d75a77b69052e-4b10ab1b12bmr23384941cf.24.1755156149599;
        Thu, 14 Aug 2025 00:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRvrkglzi1fVUqbShWj1Qq5gaJUsbufZ0ky3HjrRVHTsX7RFPTslpdjFRNw5jy+cv/Bih+qQ==
X-Received: by 2002:a05:622a:48f:b0:4ab:37bd:5aa7 with SMTP id d75a77b69052e-4b10ab1b12bmr23384781cf.24.1755156149171;
        Thu, 14 Aug 2025 00:22:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm5648258e87.3.2025.08.14.00.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 10:22:21 +0300
Subject: [PATCH 2/4] soc: qcom: ubwc: add more missing platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-more-ubwc-v1-2-d520f298220d@oss.qualcomm.com>
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=btgYT7isNyxSHT3vBtmVm8ZFwJQkF6zS599ztboiirE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonY6ucq0xjkspQWc5hMwEep4/eGUZEqCniAZTF
 k+59f9u2ymJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2OrgAKCRCLPIo+Aiko
 1fzeB/9oieIeCBGm4gLbZjhPLy/Xat5Ex0qygzGC2GJuQCqCNNAC7Yf3GtGNm/FGqHI4Whc7EqG
 XxxaovLv5V2AqbBQF5cCU4m1VDNXWghrOd1j5cpe3XWOjXcSpbyc94/GiFhXVluFv7XV/a/vswT
 RJFrLplVU33bdWcM2qXD+QMb5nOVQcg3ph1/A4V5UqVq6MBuraC8+TRUVvhjZfodYUNqOSgQ17u
 ndZNAObnJO5PG/0YUEhs+/n3VczgrPpTumTwjDL27lvarq1JL2nA8VeU0paqGbXd8UrvzTd/gY3
 KNJ6l/C7RCBV/+2B03kYIFJ/qURV24ekAAq252w4HHetKQT1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689d8eb6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=loNKmxCBzsa_v9sKRHcA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: BKwuykB1Dfz1bbqJUhkKoxdgFcOEgfx7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX9mL2rXTgu36u
 kMpV8b1danOpBTq02Rwa6KoO1MA5CKFW60ZEv09R/YzSWREb8dPrjNqOvkkteQZjAq7qVQJ3gLP
 GDAMfSQC2u56Fh/tepybPsKzKi6uimqHM74hinppQcYnK5vMXcbV5EoiOwl9aa6M6Kt4lsNLVDT
 bLsnzaTvYLEVqbBRFnJSdcoDxymzKIJLVn+eGZeoRhnFViqL3foa+B0yxWrlIA8qwWvBjs0Zz53
 sFmXOQRYC4PxStTBmWBWqxm82CBzxwUervSE7uMmSrNM/S4KzLIoi9YLFGNwteYq9bb+5knIlFW
 8YDu5qu96fLcb/qxL2KoqiCKaJ/VtlVHpNxgc9xV3vcOYi49xMDofi/FgtwMNlbVjFnMb1YVCbw
 fW8ecr8N
X-Proofpoint-GUID: BKwuykB1Dfz1bbqJUhkKoxdgFcOEgfx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Add UBWC configuration for SDA660 (modem-less variant of SDM660), SDM450
(similar to MSM8953), SDM632 (similar to MSM8953) and SM7325 (similar to
SC7280).

Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 5113c2902bf2ba3711bb14b35bbbb8a2b49b8cfe..8b23b4d4e3989a7170a9f44f3a5e466cffd70157 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -244,7 +244,10 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sc7280", .data = &sc7280_data, },
 	{ .compatible = "qcom,sc8180x", .data = &sc8180x_data, },
 	{ .compatible = "qcom,sc8280xp", .data = &sc8280xp_data, },
+	{ .compatible = "qcom,sda660", .data = &msm8937_data },
+	{ .compatible = "qcom,sdm450", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm630", .data = &msm8937_data },
+	{ .compatible = "qcom,sdm632", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm636", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
@@ -258,6 +261,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sm7125", .data = &sc7180_data },
 	{ .compatible = "qcom,sm7150", .data = &sm7150_data, },
 	{ .compatible = "qcom,sm7225", .data = &sm6350_data, },
+	{ .compatible = "qcom,sm7325", .data = &sc7280_data, },
 	{ .compatible = "qcom,sm8150", .data = &sm8150_data, },
 	{ .compatible = "qcom,sm8250", .data = &sm8250_data, },
 	{ .compatible = "qcom,sm8350", .data = &sm8350_data, },

-- 
2.47.2


