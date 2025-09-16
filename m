Return-Path: <linux-kernel+bounces-818622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014CB5942F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE68B483C80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2D3043A0;
	Tue, 16 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUi2RVSr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7D303A3D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019658; cv=none; b=pbJK+jqFrhG/PpsbU39tzoJ+HrLd810JCqHQsIEsWRi+HkyRyFs04NuYX71trpDbS/dc8nrNrjZf0x8oiQ2/xV7UaCE3FSQYL6PjP+bToYypq6rf1qBC72oNocVHhXUGaa548gY1oDmQnbBY9bAOc9+AyTks9PPWRgF5jkcHMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019658; c=relaxed/simple;
	bh=4P8QCd/n/ZqO2buNEe5zudr2yiiS2jbmzUv446VsYlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A09yxch0+ZBwZbtCGuZq1KA5lq2Bkk8qEyS2w1sBFKDRdapxMdszqagCBDKTfOisNHSdcNPCHQgZdzxEawfyWH/QaVQ3qnnVhrncWHYU2BaV/34Rc34KQeZvPzO9jEKOkiVdAaEUwLcUoFRej8d2pT/mgVJgFvCvr65zrcL6QJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUi2RVSr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9wQkW020237
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g92mvLPAHTfK0GHE2rBP5dPtjDIp5DrITeUuEUqxuV4=; b=nUi2RVSrUDeYEZBq
	srsbUBATxr6Pi6QLNsTFFb1wHt6GQ0aELaCORa78Cmn3RfIQXnSoAt9eKmu+OXXb
	4Fx0c4dSEcwW65jtU3ZiaFqV/NgeWkFvmTeabUnEgeT6vKGV6+VF++a17pB/BwRc
	y5q3m81SqdwIL96CFALQtBRuw1mnBKuQq8P4umKUSpeQwaOa/vXbqRcNv4hoTLNV
	HI3wAwTA1NY5NpZTPg59pwpsraaa/0PYgT5bZYAFtPldh6aAt9QSxW4Y9vNsdq7Z
	KqI5p/y6ljhDIPf+6xoNcKIow/V5KtHniDg7EFuAT1HYS05N8EiqyGNQbSGJiwyx
	OCyBYw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496h1sm2s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26076dd11d1so35895565ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019655; x=1758624455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g92mvLPAHTfK0GHE2rBP5dPtjDIp5DrITeUuEUqxuV4=;
        b=XKqKB+FsyOvw4LhezEfEpY7i4tPswjTXZGXibnkev8qB1fUMSFy8+INDjbpm3+cgu1
         5ly9oFlNZG0E5k2TWoTDqSnHYH6fXbF33wWVcREoTNxyKlFEAn6lqKn9sVxgdNn5AWvO
         iA8QTBUfjGtkId6R8Uyd3s6CCsBuxrq1s608ztFZ9XxhhqriOjKtnbJaVCqTvZ9VaYNn
         FAzHQoOeJNJ6HmpAQk01giI5DqhZh7Bymcu0X6ttz9F+91U9893st4LKRIIOBWANpJ2y
         lWE8rL+SDbpsIeMOIJikWhdMsKLk87bzUrWGjKYB6WGCBrC2EGvjIt9GAK1hH+qGsHYO
         r4lg==
X-Forwarded-Encrypted: i=1; AJvYcCUCwbS8IgSq4PNd+jVo1r9VuLQPtqT04VoXfLLi8+pB4m0XmZNhr2wOOg5YCMDfbNbFCC9m+lfi+VgXWnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlAE3boriR0jm8IxTAB3mm0jL8qw0S6qAOBUCNzpHhB8Mei2m
	CveB3jgUxNr5GW4Ulyt4mFMV+JfxGpVZ5mB612PQiL7/Ut588TCaEJuoGsg2yNE++hY1rD0vRTZ
	HluZq+cKQHUhgmLIWv+gi+NXC9iYXGKpRlz8J/ncu49eSzc83qmrS8so2dC9AfNZWNIY=
X-Gm-Gg: ASbGncuR7FA3ZBqdqE/t045OFasvZcVr2HUZiDOj+Ul454Y5ZXyfimHoPkxaxa6Y5m5
	WhTlR4kwHkK7aaSUejmk0E+BHh/Ky/p6RwaPyER0rwiakLoZOfXNZD6FTW8YFqmQ6hHiCSnqVW3
	jxJgYa+K5ul7xZHQA2UrCW6QVoO1oymD4FgdU+ebdS35D4urFi8Cz60mJypqaMnENC9FnTKC4nf
	Ienry6E045Q2Khaa9Me6tN2tpIfhbq40O+i3tit+/1IGgbiqzsqPa6GORYkPewoE87owPDuS5f1
	OqrHbHuG0QpElr3u59ZVAa3RSWzOpuo4Gp9hRHgwlV+WLsujOvqlaTtrKVx2zxN3u6NY
X-Received: by 2002:a17:903:440f:b0:267:e3af:ae38 with SMTP id d9443c01a7336-267e3afb733mr9406135ad.24.1758019654740;
        Tue, 16 Sep 2025 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbJG6nTE6O2cj/fl3n59kEcF7DRIKhZbTpZk6iIqHnX3yzWoLTDnuV/95CZtfeT5l+NDyoZA==
X-Received: by 2002:a17:903:440f:b0:267:e3af:ae38 with SMTP id d9443c01a7336-267e3afb733mr9405865ad.24.1758019654262;
        Tue, 16 Sep 2025 03:47:34 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267b2246d32sm33122355ad.143.2025.09.16.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:47:33 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 16:16:54 +0530
Subject: [PATCH v5 06/10] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v5-6-53d7d206669d@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758019616; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=4P8QCd/n/ZqO2buNEe5zudr2yiiS2jbmzUv446VsYlc=;
 b=9NtiX7RWLRnOJ7HMyisKjOM4oeKmHri0xKtCRW9AeoVxJ4IyFPdh+8hPymFtnppltKd5s01k/
 FCpNljGTwJuCaByTFF7Mso2ZLPd7YqcC2uz+gQDc0ZmzHtu1jQDcmj6
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: dE0smui5YHLrbj33yRUOmD16ORCJMKY5
X-Authority-Analysis: v=2.4 cv=A/1sP7WG c=1 sm=1 tr=0 ts=68c94048 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: dE0smui5YHLrbj33yRUOmD16ORCJMKY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5OCBTYWx0ZWRfX55T4afiAyrka
 ewUnCRAdhDXM7C2tUIE9K03WB+kRprNV9zviFfGVOv9267dR8I6cd0+yz+7J9E6EWMQYgnt1Swy
 DMm+vY6+ykAKgfjoOHUaD/yyUuKK5zSgoYPeBGXNjtZ2CKhXaJ8sbD3G3nRvfmaOO+uCWhDz4CP
 5tK9YZbvEMbwWvW3FlOhRfWWpwC0vZWRYsPEX5dW7/kF4mltB8FaeKahDF2PuudNdg3l2DVkWde
 iiYGwldyoJo11rtjgDnYqf5LUbswFVXkcymQ2FplpjfyEOcG7jxoB18N2ZV6SZNvsufgMxAyJXq
 nBL/EaTeLJnt/Uq/GsIIaTZZEwkIX3+9vv96fBIMkQbzi5EMKieZsBA6MFe5KX7L5Gv5T6s4r28
 7OzeJeBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150098

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 99400ff12cfd..d92c089eff39 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -477,6 +477,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


