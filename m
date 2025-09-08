Return-Path: <linux-kernel+bounces-805294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCCB48691
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF277A9D22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CDA2ED85F;
	Mon,  8 Sep 2025 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dp2bUuWz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A92ECD10
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319628; cv=none; b=Iern80RGmlzXUxCAKAM10IbSLAaSd3NlsM/5s1UfQge2qQkTNu/HHG/hkH36/As0T07Xg2LQdpYjDXU+Fu9uzwTxH+H0BK8UYCcm9PvpyFx3AQ+Rfn90K+ZWu54qy8JJOKhrFsIUbblBoJqwTuO24c5ahZ5RVbNG8WoJsTUXB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319628; c=relaxed/simple;
	bh=gBYL50YC1XDuPqvactY/HGpJkmgy7jZJJarlpKpBrwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezctrC5GIi9YZgLJsgmBUNIFc5VnXHk6gjwVROlcKYVrWb6DVp19hBA5btysjSDm6WIVO61NLc6Rgimwom6uXQU1c7iW8a6o46G4qLc04xtVIVz7wia4u9ccQfveEp88qGhkIFJeIS4QYXSam76tIvxUDJ5mC4wJpilsgux/0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dp2bUuWz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NGXFD029227
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=; b=dp2bUuWzeLYrMdh3
	xBGmajAhoW0wE4g8Na55zjrnR0MxuhNvRtVBKb7HT60GyeWypyzIXqWzCETHwNJP
	LQTrd+8rpAXv0xWsVDtj9rHhGtrkjObQ+nXR68gRQkPCqtW7imJJZm2wH7/ZYZfH
	ZLJWoBW5UH6vsMawubGjxvbWrP9Y0zflvY4zcM+LPldfP4hxm7pQweAfJAkhZ7dp
	UYv+ixev0xAf+gkgdSiVy5HtxYh2/HOwfmLVk8qgahhPqwteYy9vZXNGzOlHcTBJ
	WVIkS4xFy3mBQ3klei3zIhNDK061p2RPCjoPgfJq3QS+hmrYBEx1hsq3ew02rcld
	1dftYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1vbtmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24c9304b7bcso44765915ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319625; x=1757924425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=;
        b=dZCpQdZE44VbRuojr0FXMMvcRDTnWGpj3qIoY9UYp6r2uuTaE+Evpq0jghXFyvf46k
         UocSmt2g7hcVEKulr8rmtqBcJzbU7rSV/m3uZFAQX8a2eeVmo/QTX+NHSIjF2CRmvuZV
         isllyxO83Sue7fBCQdSYqiK4DB8NtOfpUKpZgFYU3Z/DdmQsJ2hEehgvs4t3+XaeGxWW
         PkyzgKSM9+2L5XTJIc7fGbq6CL1d027JZVBjkHH0x40Rzn75KWQL5HQcU3EW5KK71tZr
         +jr5NtOgCVsk4osyzxqRxYi80w/eCcxgcit5HrLLcae+2mgcantqIsKNNXluSWxek0WA
         sBDg==
X-Forwarded-Encrypted: i=1; AJvYcCXMQai6DVbYo+q1QGo6kd8mLOJ6qLFfKeK0LeP4H8tss1uBoiHk4RrxO8IPJNTHsbCRK+eOBHixYgQoM5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCIXvHi7wnp3Z6MIkViHLXKz9yg8eKf6OVBl6Nr2I8QIwOhJb
	iVK/80W4gvZgzbr07N5slgVgGx82Gpc5wdvujkUf1IrJujhWzG5/fE95piQECpF9lJcTVfOBtat
	4U1mxfxZ7S4HQ/rn8XLaywhAke42C0CwdlEdZl3Xn2hPmQhj75SXtN88C7elQ02awSLs=
X-Gm-Gg: ASbGncutjz80HizWQjhcayiO+ZsOVabDZNbTzQGkNMMjP7PlC2mrXoCO5dyXbFJH9hm
	T0wKPvoQ8ZghE8w6k5z0XiZZrp7sEYtBPxWa8Bn91bKLCpbXRSGY03sKnXqmzTcWvqdZfU4BDJT
	hhGSGwLuH08zoj12d2KCrh8xje0Z4dqVhFjT501kpNj9o+qCBA91xp94uDzQhlUUwTzbR6NlBY8
	eSH2powzj6HX9GWtaWZ8d2OnqizjvFgyt8lpa8jLC0V2fiDBGyd8ZVGJRp9WR2bNzwTbkbL6Qw5
	10YAufOh9jeW+6SU5odOxrDbjfJoaqrLesHSYkxg87ZiYAEXJSZzJ9DidkwG64KlSe0Q
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464925ad.11.1757319625020;
        Mon, 08 Sep 2025 01:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4jVT7W/OifKwAmzHX3E8eS5lp8cqvuFI63Bk1zsxQR6CJi6eIpk7aZvqHkSYv1XuC0Cg1Gg==
X-Received: by 2002:a17:902:ec8a:b0:24b:74da:627a with SMTP id d9443c01a7336-2516f050096mr115464595ad.11.1757319624524;
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:53 +0530
Subject: [PATCH v4 03/14] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-3-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=X+CejMSc/iURyNBdtIHd2b0fknWkLUOZo2knn9rM+7I=;
 b=69UvAQaEZdQB4XITcnpWuh+ii9MjUlEFC6sUkQg/714wq+9n+m5oVmf3MHBWmDuQcPwQo4Fth
 if7W+CtGUV3ARrm2yusKZrv0XAub0o85QCtRf1dtyki0QStCLYQAh07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: MshJrjhVTx2sPDykeDHUfDB0VSyTrSiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfXyN/nNCu1kXo7
 CEM+uDrasue/BQF/2zEtkRVv5UEP0JXDSTr5vHTcVX+l/OuC3zkz/ijvQjduHVK37PAwbRYI38P
 mBvWPgLoTpr8fFVdiJ+TNRWiKYufPZu0NGQQtwQrSOE8sEm1Dh9WsDEoMrN7uReEtEGSarZbMY7
 OmIbr31qiCtU+8RA+4sOuF4j3WJROvUosaU/p7DZsW81ZiuNKMkUPqfLrdTtEDjWNTZhW3oXLTT
 AeC3ZnXM6iYxtPkm3/pWGFiNmrNYlAwDNmo6CUbGiFjRWChvj9MfI8YmBa+Z/z0hl+2q37UDir9
 Y2a16V4GpnL/ilO53y40M14IfTl6mwFg4Rg/H7EsYKAZcVhsn5wPpLnlqNfbA8GLLRl/ndLIuhg
 RNzLd5th
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68be91ca cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: MshJrjhVTx2sPDykeDHUfDB0VSyTrSiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
DMA and peripheral communication on the Lemans EVK platform.

qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.
qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..56aaad39bb59 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,18 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };
@@ -323,10 +335,18 @@ &mdss0_dp1_phy {
 	status = "okay";
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


