Return-Path: <linux-kernel+bounces-735302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC9B08D83
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED8C1660EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1122D8DD9;
	Thu, 17 Jul 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SANBO05J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9572D8766
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756707; cv=none; b=qfQzq3O/rX4rvp1u9YEtkJTsg5YxzKhYQyMtaGLjIq0QFBoJEJiFz7jKdSB2UYXyy5ucxTwVX9zaEOh54TDTs2sFLJEscA1tKtDQinooQzXw8bqE0v4mxdY+5geo7GPmgZDHYpbNvwEmXmAJx339+qHm6XhYVPNZcCyegPJXarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756707; c=relaxed/simple;
	bh=ll23e7vvrw6W7sEgTKKvGDehsrW5/a17PywG9IJmlAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWyNFC2h1ABmh4Djd2of5y7UmXPimfcOPxQSjqlbyA2Nd0UP90c7jKAW0e5FKXKWYqHkKAEhXOIZob+opOqaAMiY2z0Isq47Al2Xp4vmE3Soq1+drAYyg3lMscrRuv0Gib3d1VeFOdY74tU0HU/Zb4NDk88bA1plMpj348HFlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SANBO05J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBDiha000592
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MGAoNkYeaggB4O1Bn34++luU0RAO4OsfhAeXBxHWJcg=; b=SANBO05Jdwp9okYE
	/xA9yO0qtCNtx1ONn0U7ywsHjELCn0UHT15vjBI8Ndxb1blAbh/4CJuToUB/jA2i
	GBgV4cLxWe63nHw+PKoZTlwoZ1SmO7nbnL7NdMpEfYrK+gVvpQYgtbb0uUj2v2ip
	OwxZ9jly3j01H7fCa/8Hr7UKh5AcZsQidKjb70UPGlCjmt/VDNQqupqcQ4SOWyBL
	lYlXhgaLpEcI5/ATB2N6dPZzwh7AKsqyQZBnzJtlyH6cpa4uI1sllc9IaZq7f9hE
	F/+v4xc9Bz4VSFs8gG1PzoPg2aipJHMUa4ur3KyTTDIqWCjTKXJ3gZELQGHtObB4
	E02inQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drtqhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab5d2f4f29so16378331cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756703; x=1753361503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGAoNkYeaggB4O1Bn34++luU0RAO4OsfhAeXBxHWJcg=;
        b=qekmtiUs+vzTKGXxt+nI5OkbFIA87RLhsxBgVVxlYQbmDs8ZBNSREU2hxgP+zyUkrv
         nilbBY7tLJ7IGmv12Y0S3s07mf75xwNNiEsQCRFHxi2Ieh6rM08xdQG+2oA84VyFBRji
         CcchCyAVZEBgXrhyiQod1fPrVuJ9SgnybRhc/5lu6eo1BlzFtZf9nITmLurZ+NYbGXsC
         QTXalkaMd8gz1ckbMSmPlDJNsvs5cAGOEx8h+C8MpmCmlPNaqFqxhW8mvJFkGgh6HklA
         aVyCYonfXHelTmVe+tIkSOWQ6XEVDDDlS1FdRFk4QVh8G58xJVvJi4VzjBT1XC1SR7G7
         vcSw==
X-Forwarded-Encrypted: i=1; AJvYcCVrfflubpGjmhB4ix5mILbtsuuX0zQHK0N6CBfygLk2ZYJ+6tu2natupRrDYweZqdd28lyq+df/vqZ6zi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8K1u60WNW4ZrcaLjDw3T/xnjOdAVjbMhbv2S1AevnpNBN4++u
	wWTSE0EVjXquVDDhFyMsv0AcpQoJKy9b3H3HF7X+7SepRDK71IhEWvS/LaOX3RZ8gBshQVlGVAN
	78THM5J5XYawyph/m01BFHs5EdNhmqZG98fMyzjh24gl+GamRF85rMnlswEh/NzNdtso=
X-Gm-Gg: ASbGnctHTeq3nwPerstNrfLnWB6EsBNUDElSPy0C4ZGISbbkgC5CJ7O8us//oTGcB76
	YJNWAE9aCKC903+L1eLsm7AMnYMYv0QfZjW5ST7MVtqIJWhngczZwe6Rt1BTv262zUReJN+UDus
	UGPj6TXxkgfw7oGiezSfArhj96/qVbWckLsOqtTBYjt/NdzSYzXHjUBo8tEOqz8dGXlUq6G4Pjv
	D099irhRhIT29d1BrKKMZfN51R7dbTfdFWs0XhfQtwG5N9WZSsloumcObcT/jjJxJmF6/huIv+J
	+yDSYEqol3E4Z6+XlVq3xuKYTIIlJ7VKPnF8Qz2GiCuwNNYDgEZZlCghP4zT8kVQ9O+30LhNUat
	szWCXGALb+R4oP37lynm7wwQNYHVIvVC59+CkuUylCZguCNoGjKGZ
X-Received: by 2002:a05:622a:288:b0:4ab:77c2:af0a with SMTP id d75a77b69052e-4aba3c48622mr40754441cf.3.1752756702946;
        Thu, 17 Jul 2025 05:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz8tfCOT4rLdERhgIRvgc1drkfg3DrbP6Hyvl5KeHje+NeiLMpfONSFlH6uJxI/xOdYs3OsQ==
X-Received: by 2002:a05:622a:288:b0:4ab:77c2:af0a with SMTP id d75a77b69052e-4aba3c48622mr40753951cf.3.1752756702381;
        Thu, 17 Jul 2025 05:51:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d08fesm3032872e87.126.2025.07.17.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:51:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 15:48:18 +0300
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250: stop using SoC-specific
 genpd indices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fix-rpmhpd-abi-v1-3-4c82e25e3280@oss.qualcomm.com>
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10234;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ll23e7vvrw6W7sEgTKKvGDehsrW5/a17PywG9IJmlAw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoePHYpdjayU4lcdjrA7iCjgXJn4BQFjxzryKrm
 ZOjDevPC02JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHjx2AAKCRCLPIo+Aiko
 1WRTCACAhHKRXRRaPkdJ8hq4oTGc802RQLfPdMwioicHybV8yb1/TSMC9WerpmjzKNaySOOC5xA
 mxViXobAhmn/P8uEvsNd1xVJ4djeIUMUSFUJMgygSXqggKKpZC6FY97lAAofJ67hfwq0YEEp5Qm
 Bb6KRkrfqg+daPk+95EfJN8pR9oCkxDuGK8k6hbpT147mZYybndXOUAaml+ds3Evvfv3Tzp4WAH
 WyaLhIxXwASJYW66e8CL2QAwbOGAK2cTKy5xzsDOI6ratzRT5f6XTC3tYJqzvbuKV7eA4YhX9Z4
 NWhqJnyQ2B84LGQhGfRd/aggN9uTuNhU0iymDBRIw4foDYxz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: VJ92UJxONBTdS4riNqtG7dJeJrOHs951
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=6878f1e0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Z9UKu4E7OKxfHwI3Q_UA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: VJ92UJxONBTdS4riNqtG7dJeJrOHs951
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMyBTYWx0ZWRfX9gdkWO9xGq8g
 41q5U/sQRR3/5bVab+avIBMUGt9bsQSG9rBXu0o7AZqrgKByVQc4XL2kcDDBrJHms7RRnMRVcRR
 xg+THnNblM5lESG0AKI5f2BzKhD7jqNPqQhaUB2fI4HbYS1wH/6iISgWgqFA922X305NE38Xd29
 wnR8eer0XfWwT01vbYSyeWducPk/qjpscxQSQXJyS3el8MoILROiqrO8n/iKlNSw8trJSJOBixv
 7ajNpop4OVyF7vhGzYI+giOfHXzP0i4W2fCq0CcwNOPLH/ChZdnXXO6CNfCp7m1qTvpmHzdAotI
 iSPksJiOjfAMzQhZRXUcMqTC1FWG9AIwnMunxQERyByi4CMR2B1DpkejyPz3D34KXWuEU7LFTeA
 ShHD5maleXBH5f1tHBU9ggDieROIsirj3FA//uWcOor3sq5qSyWLYF/axVe+hrPb11Hb8LZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=901 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170113

The SM8250 has switched to RPMHPD_* indices for RPMh power domains,
however commit 86a9264b6c56 ("arm64: dts: qcom: sm8250: Add
interconnects and power-domains to QUPs") brought some more old-style
indices. Convert all of them to use common RPMh PD indices.

Fixes: 86a9264b6c56 ("arm64: dts: qcom: sm8250: Add interconnects and power-domains to QUPs")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b0197602c677d49f7833f31d71f72436499bfe84..244339cfbed5c32708c282de18f5655535e2ff45 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1030,7 +1030,7 @@ i2c14: i2c@880000 {
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1075,7 +1075,7 @@ i2c15: i2c@884000 {
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1120,7 +1120,7 @@ i2c16: i2c@888000 {
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1165,7 +1165,7 @@ i2c17: i2c@88c000 {
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1227,7 +1227,7 @@ i2c18: i2c@890000 {
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1289,7 +1289,7 @@ i2c19: i2c@894000 {
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_2 0 &qup_virt SLAVE_QUP_CORE_2 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_2 0>,
 						<&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1370,7 +1370,7 @@ i2c0: i2c@980000 {
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1415,7 +1415,7 @@ i2c1: i2c@984000 {
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1460,7 +1460,7 @@ i2c2: i2c@988000 {
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1522,7 +1522,7 @@ i2c3: i2c@98c000 {
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1567,7 +1567,7 @@ i2c4: i2c@990000 {
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1612,7 +1612,7 @@ i2c5: i2c@994000 {
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1657,7 +1657,7 @@ i2c6: i2c@998000 {
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1719,7 +1719,7 @@ i2c7: i2c@99c000 {
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>,
 						<&aggre2_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1797,7 +1797,7 @@ i2c8: i2c@a80000 {
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1842,7 +1842,7 @@ i2c9: i2c@a84000 {
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1887,7 +1887,7 @@ i2c10: i2c@a88000 {
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1932,7 +1932,7 @@ i2c11: i2c@a8c000 {
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -1977,7 +1977,7 @@ i2c12: i2c@a90000 {
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -2039,7 +2039,7 @@ i2c13: i2c@a94000 {
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-				power-domains = <&rpmhpd SM8250_CX>;
+				power-domains = <&rpmhpd RPMHPD_CX>;
 				interconnects = <&qup_virt MASTER_QUP_CORE_1 0 &qup_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_1 0>,
 						<&aggre1_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI_CH0 0>;
@@ -4789,7 +4789,7 @@ mdss_dp: displayport-controller@ae90000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp_opp_table>;
-				power-domains = <&rpmhpd SM8250_MMCX>;
+				power-domains = <&rpmhpd RPMHPD_MMCX>;
 
 				status = "disabled";
 

-- 
2.39.5


