Return-Path: <linux-kernel+bounces-878909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BBC21BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D77D4F03CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7B36CDFA;
	Thu, 30 Oct 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwezAW8C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AsBMJLCI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFE36CA82
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848423; cv=none; b=Z19cYtO/Z5u2P1DZwZOT6Su3RRhykzVnh9ipZfacKMRIG5PdmChwmI8HtG7ZlM2367aEnJFNZo7jzwhZW1VvSJxAy2TbK4VKfpg7aGxP08PlvBJHn4aqM+TPlTdj0b/jp0S2ewhtf3EwWbqL+QP/pjVUzAQ9gx0UnlSQTK4t5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848423; c=relaxed/simple;
	bh=O3zsqMWJzGuULuopyok7e97sOQQTNwEYCCnnTinaKZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ea9aLm54QfptYWy5yaQHjnimZ677meD85mHyB/OctKtgyK3EdosTnIypQyZjsTZyVrxQAqMl90S78V2K16R58FHTXbIyza/ftLE0WMKJOVwfKrJiD/pC8EyfEBYtBoqdDnqdMEvlA3Vp+LwFER8VeZ329/gZUGYqlIcw1ooewic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwezAW8C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AsBMJLCI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UFHMUt102840
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+NzvBLOWcvPqnstM3D5d7GCb11dmM+NQ69MqVR9iVIo=; b=NwezAW8CzNdegjyW
	bTS4PtVmQjMle7v5yuJQ83SfGGSbp39W45fxWW883w7i5arZon3seImbIs51/aBK
	sJrFyWyvIBWjyughKepW1Ydr0ycGU0h359AacODpdzPSit9NkY56ow4l1UoJ15gR
	Ej7Y6f3X9DCqGwm+UMomn4blNasXdN5NBOj7SMgy8OQLBL+T+2nq0Yu0U6VN8AMr
	qcqODhQoT9xtRJ/jO1NNMpXfgZqjc3LbXM/bbPMK2ASm3gecNQH7J3/n15imAyys
	kh7gJNplawqMZ8EB7FEcZpM+oaldZR0raA3SzZTqeEu9Sit7EROgcScQj82EXeoN
	+fY/8A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdghtg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8916e8d4aso59312061cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848420; x=1762453220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NzvBLOWcvPqnstM3D5d7GCb11dmM+NQ69MqVR9iVIo=;
        b=AsBMJLCI4m8FuOcT5n2gZdyMwQ8P0HIU/rL4lQRQxwKPYAq3hRzTxpqikUmxPYRd7c
         +LhqVkWXgNPR+xPfiCYUOLvD9FMXSB+nvWQHKypwYZiFngiuzB8rzpeF+OUei4D4qQkk
         m30Tkbiypic+3owDwfBOWakvy4xYOtd5fuDggx1sl049dzZQnFFYdDdZTtl5kQzn6A+t
         7coLkflfZomKOZDQ2f2CtFdx+rQ/ZclS2rq6+p9hlQGvhOdbLr0Q8g6xXIwkaBSU+98S
         Ko6p+KQ73ZYOy7u8ozEmZtc5SjBV+fKCmeWNP7/R3h8+0e3HAJhKMajb5onKxp06N4jm
         6yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848420; x=1762453220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NzvBLOWcvPqnstM3D5d7GCb11dmM+NQ69MqVR9iVIo=;
        b=v3+GbbyyNo5HH5QHf0J4FvTVXwPWdV9RqKwXSwS1ay4/bQ2j22KOwiAoWyIm1XPmRa
         Eh3oDKJgf8fCvbfRASq7SlP2ax1qttDYbjidJCl8Fo/FfS37EGI+RjQOra29Ji+sUaMJ
         O1vvxWQuP2DyGykqGCgIrE1THncHqaa3eydGUgqT4Hfhm8wM5bj5aAVN31DGTcy4vi+K
         QHaX9e53nnDDpBf5zOJcZkPZ1n22lUg6iSPwyimLTSeKCyhdH7SdSv7mOOfrVy9A56xJ
         t1Ypy72Usk+6B+tnNEnHFouXjz/QXMiBPDff9bG62KI+U1aCQAParoHdQRN6p7LQp0I/
         TbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfMpcE7x35RakQH3zeqXys6Nmm+SjiOyPlM4ZTzvXMN3068j6SJ1nf6v5N8l4VyhX2aKvS4A9WOI6fv9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WS5LD+nL28xtzER5Oi6T6GxdCX+Qm+9sDYjj0RZq7wwpzqqS
	jHpxKQj48lSTe0PtN1IwQk6md1crdz8taohhpQRrFRneQ5v34UzFRheuwnC8ChLeaWDsuRr4aG8
	5XOO963IJ59RXNBZ7R19RJdA/ihKaS72RSTPdjn4wI4eBpyxFeTObDtIEUXljum2LeS10q+PUGz
	Y=
X-Gm-Gg: ASbGncuhNIgvy65S5bV0OL+dBjIXVc00T+XAoZxQJDo2a1gdxNYJxFyX0gcOrtUuMoo
	85QYwHJbRl1zDgO0ilGNGaRiZeyQ578rM9MY1gJuv1ZsQs8juuvTYxMQkgsSBq1Aq48vNwx/DhC
	khHDOR0EFFsGPgm61Wi1Tj7MZN6ccUPQY+MwYi6Umihe+49oL7fuyIYkiujHWW9F/njMKC+tahF
	QnysQXMGtF7lm8OKm3TR4stwpK/AkKw5PT+8TlFEHZgAQTv6g23wbaPmdOMkLIsak8/EZJz78ki
	Qu89+AyiXnqQyy2qa2d+X8581fZZd9+eJbGtPEOvWSoeUSw30upYjnTb2knqbuhEfM358YgUjLc
	bKFomdjZud8f2fL9l7AmCPHNt9HfD7MGHv9KOQIMsh3/dhm9KXFLl4GIfXk7csCWDJ9Le+aCpAU
	xa+/NSpHVkK90Q
X-Received: by 2002:a05:622a:1456:b0:4ec:462e:23b4 with SMTP id d75a77b69052e-4ed310a02c0mr7595281cf.75.1761848420231;
        Thu, 30 Oct 2025 11:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdxkyXb0uGWv8KMJtRVs6WVDLh+jIIF3Oldvv0hhQ3QpXWIMAJ3FwLu42W9NQkouYa7lZbqw==
X-Received: by 2002:a05:622a:1456:b0:4ec:462e:23b4 with SMTP id d75a77b69052e-4ed310a02c0mr7594941cf.75.1761848419753;
        Thu, 30 Oct 2025 11:20:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a15c5436dsm3843171fa.33.2025.10.30.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:20:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 20:20:13 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: rename qcm2290 to agatti
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-rename-dts-2-v1-1-80c0b81c4d77@oss.qualcomm.com>
References: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
In-Reply-To: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=O3zsqMWJzGuULuopyok7e97sOQQTNwEYCCnnTinaKZo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpA6xeVtEIHnIE8AH6d6S1DtZpdsBvUap5u4Yvk
 pGwbeHvcLGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQOsXgAKCRCLPIo+Aiko
 1X6kB/91wYlURqXwTnvVpZRjpNc48yO2iusLumRTeF56iQ5jCspfSXoeLCIH43Qr+20Fjgt2OHp
 /mdHTd1hOrWf5yEhBJKgEz+8Q3OWkb5IVPJAcjsjP60XR1YOjfYS5CimLONRZtUKDXmbqEW9bJf
 JTRpblmw6cY6OIeyg0izCMKgTi5SqRkBmgh0MdIbns2oUWz+CBOlbv94IQFPFgZMaK+OPE34eSZ
 /6wfVG8IvLQiAcpXo3rZc6q2m36ie8WqDtUzrVPraPW/Uf7nhiWS6rK14Au9WjE4HYnJBxgjYt2
 lc0U5KYivXXHfuTS77TjNz2MMQALj7vDUGk0jFMR85+RsGqu
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfXyPn/GQ68sGDc
 n9Bgq8cDUNpWFBhjvExb7hLEZWJ/Zx4cF6qmqUzfEjgt7MaFjsd2A8irAzHKZUs0TXpEicludZR
 pgwCTfv1V4sKbBZ/VZoY1yoprVLF27VozYm0oaDfRBYCUaxRNNq9gvxHuYq0qHbfB4h+FWAanCH
 aqj3iQ86vExQtQDPZEnmLa5SATTAhZA6oNkmAZ6kQepvXz1Meh8rb7PUoqd376Ib0zOkkC8mmj2
 TeDtPQSkIqKHkbRI4nmEvYc2ap2CwjAHN5cy4HM0eLWb9K9bOglx3VGqHPDmI7+etVBin8bTcdJ
 9nn4Xg6W6Z6CtGKz7u4qCqSZdJkEhI0gUYvshCNqdEpV+fOYEm50FItyCuk34L/Io2UYS7qzURZ
 apNM+j3o7Q6n43vMnaYNgVGknkFNLQ==
X-Proofpoint-GUID: NFdPl7S4RxuH0bE-6wo_DcgUnBY54CVc
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6903ac65 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=s93T1VwQXw7az0q5Bg8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: NFdPl7S4RxuH0bE-6wo_DcgUnBY54CVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300152

QCM2290 and QRB2210 are two names for the same die, collectively known
as 'agatti'. Follow the example of other platforms and rename QCM2290 to
agatti.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/{qcm2290.dtsi => agatti.dtsi} | 0
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts               | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/qcom/qcm2290.dtsi
rename to arch/arm64/boot/dts/qcom/agatti.dtsi
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 43af25d17aa8314354b1ecb8617510cdd6c857a3..bd4436d2b0b0f1f5f8c2e4cb05bd328f32f27e0c 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -7,7 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
-#include "qcm2290.dtsi"
+#include "agatti.dtsi"
 #include "pm4125.dtsi"
 
 / {

-- 
2.47.3


