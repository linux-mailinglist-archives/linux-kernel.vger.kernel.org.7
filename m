Return-Path: <linux-kernel+bounces-801284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8748FB44321
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA15158487C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B2302CA3;
	Thu,  4 Sep 2025 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wb8Y91Wz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71B2F549A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003980; cv=none; b=Z991xSk3qkpZlyNHakpio3Zk5Wjy3HGPMagtslUwaCRN6Y4pOGhDeuWWhSHd9so5WI8mMOnJTD0PBUPUI+AYU9TwG8SKYh6V9AOBE6UXQXmSA8VumvNeKcRjnEzmTMT1n4dTNxeRERBAb0U7flfDDQqfN+0Sx7WRB/ofkr5V9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003980; c=relaxed/simple;
	bh=gBYL50YC1XDuPqvactY/HGpJkmgy7jZJJarlpKpBrwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpuXtybIS6GiixZ2vbf29HKXRzgmP5kFQ6lA+HXpMWLId1w16u91muuWqCei/VQnwgmXgizbDC43nbkXj5C+zckbOrc/Op7ladCB7X+Ik2XCZrv0IIKCIMX8PKBQi8yoS5lkrH1k3N/CeC8KkmHqYim7nKjfCRwP3MIrjT2I/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wb8Y91Wz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X9Gm007616
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=; b=Wb8Y91Wz94F4B2Zp
	pzL+R7MzK4O+WyNMjkd0Iq8BrlPc43xcrjGpakz8ULnOpxsW11Xnn8+fL4o2bZum
	+oAbiSeNx9ZdYLSErohC8p4rS1zBmUOW50rqnqN2ljwMbYuLMRQauUv4sOCbr7lo
	Ck1S9ksmYtfd+xe7QE2xrua+xEDLB4YuQChScON1Rt0loZEhKA3HNP6RB4cFmVv2
	oi/JDm2CxpAirEeSnzTfyrX1wr5VxithPduSxRxTneLe52SCpVO4bWFur5jNnBJU
	deCaQck/c1puOkpeePgCbcm7OakVDn5q9Yai6SVdea0ynrgaG0LslpsT7XnStjYj
	T0RtFw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura903wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:39:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32b58dd475eso1303976a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003975; x=1757608775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF2ixXvd+CAVz8mNHLTt0wOko08EhUec7UB+gMTdRyM=;
        b=P9l5s/st61TsDYXhVH/eoVEhNTvQyacZlfmalIVkJzsS/Ry9/Nt7KOu/BBzdDMIuBV
         h+9baMd2rGMwd3duZJqDoMbRyGSvI/jE3x4pgbKapF3yV/wQ9bnzKNO4xNPjmF93RQpE
         xFAsVrYYgeUTMFfPqhmvMcdXs44pSsN/oH9ejIoqUsQwmneOCv8+ecPhvMfxEumb3SeY
         maitqP8zE7inlI59V9QOsWupBN4msA67UH5NnqMVgJOvUa+d7tYD4Na1J+XiUWuTpbkG
         bDs5hcAXZduWKD3fAdSyEdvI0n887vlgMFy8mwB9nG408KNUaEfyN3lbrOFVcWU9EIVk
         cXVA==
X-Forwarded-Encrypted: i=1; AJvYcCXLQHTi5DxUIP6PyN7N973xSl6bFVVEmmtqRa5/WrUNlEl9d1guxpKqmWk/ZSGkPzBdu1JaXGVTF9jbLyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpgu8kqfZ/Eisyvg4PrySpwsHf2m/9hSapZRiaQc0kQTV3zXU3
	aBmF9eFWLhwaRbyjlLj3F23FB4VCi3Ids5EQXXrW41ADpycWaVzGQbXs/SHC7sp18hJ8WnWitCR
	WCbSQbuUnOX8DMHo/xvc8xcBbslhMto8Pz3HSKiU50xnC+eIsChSQJMmcKxDYcZl+SUs=
X-Gm-Gg: ASbGncvzSYWqOMCqolSvetweSOK+Lzqm6ZU4l6SaGT86kLlWD79wsVHLZMZMq/AXNjF
	3MHZLVi4VaCS6rbjddCzVKQIDfq726efLALMZqIPpJYkKZ3ErwuOgjrmlWM9D5P7Jyn8uw09LEl
	5pLvhxmqZTifxY715uz3E1sIdpvIj29IWjJB7BxFw2ZUilHvMwk2piDQkG1i+N9BNTNtSQQO4tm
	yWyXBvtD7LPbiRvOjsybtdU8S0zbOzAjWiK8sk0NR7fGjUkD4Yq68IeQdu/kLE/1V7DJ2E2OimG
	ReO1jJL7vHT9CqVu5rvxUGr1QTZMxLM8rodUZIUbpOwlpJ9bbqysiPIr2hRuuoPm8T7Z
X-Received: by 2002:a17:90b:4a91:b0:32b:6ac0:863f with SMTP id 98e67ed59e1d1-32b6ac08933mr8239247a91.18.1757003975496;
        Thu, 04 Sep 2025 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE7nofFV+wfimTfWOGY7Z6T0ProffuK3bldt1eocUGgRt88vfTcLxAfprbv1of4R3zm4TMTg==
X-Received: by 2002:a17:90b:4a91:b0:32b:6ac0:863f with SMTP id 98e67ed59e1d1-32b6ac08933mr8239202a91.18.1757003975016;
        Thu, 04 Sep 2025 09:39:35 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:34 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:08:59 +0530
Subject: [PATCH v3 03/14] arm64: dts: qcom: lemans-evk: Enable GPI DMA and
 QUPv3 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-3-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1269;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=X+CejMSc/iURyNBdtIHd2b0fknWkLUOZo2knn9rM+7I=;
 b=B0ZC3gu+mtOedmT0tGm0gYiwIQI00Jep2hD+NjWSt7AaI3xEHGf7l6shbcaOVXZE5sHn6N6JY
 d0/KRtj88nOCc9VKZN67PTINy3iNSYFysTRiSSUhvbVD0jX0zygqbBM
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: pBK37ekTrSGDly59q8XsFDOVfaVFvxJf
X-Proofpoint-GUID: pBK37ekTrSGDly59q8XsFDOVfaVFvxJf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXyZynhzwAkDjj
 gcS3qWs5Z+fF7JfZlcQUUwCpqCEkAtxUFsYQdrEKccSZCa9TPvp5dwDAYr4+89fd8muPC7B4p4r
 1eYNKp9viTUO/u9gBiVIDareZ4tFb19Opb9IEJMhvfVRTEBBiEBc8CAGD0ftIDdPg3+1+QjSRar
 TLktAhsLTVyS0NM5yHQ5jtKVuTjWVv2Rx/uMSXbQrWPcjl1oQa0BV33LmASr5me7NmdXgEZKJrm
 WmoQitmagRNLaqgQq3lGpkYq8WzOK2k1fJw38sHVcpDGmhWLWIuzxOKvmEyf3YbuuLA2V+56Gsq
 86BRYCjXERjKzfL09JAW+qJaVVocGOF2b5YzchhzAISTGfhzD82aPYgNwloK/V5Im6/6146l4wO
 Kl50vgf6
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b9c0c8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hGGMonP7TOO80wKNN9QA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

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


