Return-Path: <linux-kernel+bounces-735101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3172B08AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1512316649C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ACD289367;
	Thu, 17 Jul 2025 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E2a9c3Dx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E732F29994E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748868; cv=none; b=d6fVzwS7PL0O01Y04e6eVV/Vo5IUboDus8iZFcaJF8AMFQ6e/JqpHSmh5NbbGrl2r09fsc72fUOEGiGDMFwdK33IPOFltdE1RisPKwe2OvfbD/M9to0XKLbXiFmOAHF4beH8qrVGenni5YzReRwbp1nX38N1x1B40bMSN0trx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748868; c=relaxed/simple;
	bh=vdDaCsgg+mzix/TDV9PNvSoi1uwYVW7Q+4PQrxVkON4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GJk8dTOvOGTaiNJ2CmDBZ1bDTTEoVOlmeO3sVuGhmATE7Ay5xk1AeG9qxzlXgf/9o9ljYn5eU156sSsm5XYbDuhJwiNmVgfKk0DZD6LLOv1JjfRYxoHB92eisaE85OKVn4HmkojeT4u7uyxGCGJPgU0sx+B2h9WD61RjDOZT/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E2a9c3Dx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4DDa3028129
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vvaPiIP/2YOcPvhpEWW2f9
	EDPwOJcKg1JiX/Z/YjNAc=; b=E2a9c3DxhrbauPaA4Fi3I27+5qlA6jTGqmzy9Y
	tA1Ok6fj32brzI51w6Tfpde3cyljiLXRywnOLHx4c9EBvDpiWFTjngZNdBNa1rDn
	eQxsNkRqdfuR3s+JbTWqyHyfYEoj8eYD/vE2Ui512W4XhG9ZUgbi4U+kpgJlOb77
	Ts0U7a5JUY4vaxfG2sDIRITkjF/ecep0x7sckyqVI2GX6N7KmUxta2B/jyyWrda6
	1yh1kSMA+Ztr6ZNDYdf1ZI8OPS/VjzqsEAGVT8vJM5WfW/H1hCqxg1U4Za2IHDt7
	G8JetY17EoNjeV540S0uWEm7GUsFKFP+X/bbpvru40SUkwkA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5yhf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:41:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-312df02acf5so2020493a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748865; x=1753353665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvaPiIP/2YOcPvhpEWW2f9EDPwOJcKg1JiX/Z/YjNAc=;
        b=dwe9O0iiNfzJDhAlHxAgnl9+YcXW08WsD2QRrjgCjCxgZ9s93xaHP07HUU00tvc1uV
         1LrTmkn+40GtBG/s6nsr4BHr0Mkgi9wbDeugEuM2o9NHhWqiSwkg1/IzsIM36+D5tafS
         I4OmvEhb7QkghbnOsFQ65u/EHYVNSEw9xyhL0oBw/qUaOX/GW3xfMefUDVSa6qLm7I5i
         YL7rXyspLqXGMkf4h1Xi32pgt0o62njkGTWqHGEr/iEz4WzuMhzHc8CzezXS9AEV5sjL
         UeeInHdHB3523pSh0snGnqqFckbEuPKzfwEWG6CPlDHqH4zL2PN2st9sKXz6TuDZ0T4+
         Xy3g==
X-Forwarded-Encrypted: i=1; AJvYcCUf6eCgAqL4b+X1Bg+EvkHfLiuRpp30qX9/VPdn7aYA3leJVayDkfpIs0tUY5ODY0puEjCQIA18QxtLn6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17ro9NH5x72FYVTFKCaYCaH1qNo6ixy+AhTBr63XVSKUMwk5P
	t+FFNtll7wKQZtn1PXjwkWln+UO2q1C0wCifmyr47MbUO3g/xcP8ZvYALgEkc/GKGdSUMLhDEDV
	2LDwX9z2oWTTnM7NFRyAE8D/8YT9SGdznGmuw0omQl8XWzP/8zGDUvExQfdjDFaH7vKI=
X-Gm-Gg: ASbGnctzxWQS9cegDAyQIXC8HCHkr2CbQVXN5epIyilVfgvlwLuR+ZQKoA+FaoykURq
	De/aHReslAzRy6+JErtaGWhyUV99K0TudSh516P+qIA/CiwdkFy9xqUz/RhejzuXgIle/zeg8/Q
	Q2xgvn/98uGQo61JJPZANgYDFvWiMdlhNY6Vx4R5UcwvG1NACBDn/j+3Tdsauv4/HCHuIapvZ1s
	H689Tyq24Z2OnFnT9SPf6OuRKLqc9rAKdRsu8z2MWunFmCSeKU4q7SMQi/dF8cIZmV7NC8zQcy0
	Q47FsPGMOe3YupccQwfX8MJ5uJ1Hmmksmfm7om0a4bPhNJHuZxj4FS21Tb1PS5SO9Y6MNPLeX5I
	=
X-Received: by 2002:a17:90b:33d0:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31caebbca7emr4133601a91.17.1752748865058;
        Thu, 17 Jul 2025 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpJjSWWYAeNvexRCsR/Tzdhod+tNeFiGrWUj8nUYOQzb9aCTR6+cAgW/5Olu4yII3KrmJuaA==
X-Received: by 2002:a17:90b:33d0:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31caebbca7emr4133563a91.17.1752748864513;
        Thu, 17 Jul 2025 03:41:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e61d2sm3035425a91.11.2025.07.17.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:41:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:10:57 +0530
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add missing clkreq
 pinctrl property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-clkreq-v1-1-5a82c7e8e891@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADjTeGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0Nz3eSc7KLUQl1LI2NzyxQDY0MLM0sloOKCotS0zAqwQdGxtbUAPtC
 B0lgAAAA=
X-Change-ID: 20250717-clkreq-92379d031869
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752748861; l=1142;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vdDaCsgg+mzix/TDV9PNvSoi1uwYVW7Q+4PQrxVkON4=;
 b=F2hokmab+sa2WThH6SS2y2DRkDfG2FoEB+aWtVHDN4HjIEW0LxF0hoy0kjVFER+SBnKAkRzKT
 KmgfsuYWo96B5dHY4IiueuxcQ85qPjmleYmINGLPSYl8s4jtLzbPLvX
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6878d342 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 941AFKbDFM6M3_tNcm2qwlWOEZGlPX96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5NCBTYWx0ZWRfX5JbbPGQinRis
 JEji3Dxl5nZbrFq6h3FPIXPciqOyFEiVL4rMT4oWaESS+iKtpN+PvbXIl4VtHLcsYi27v+FxGPR
 GLL/trIiOqxxlYGSwTAOneR12oxCTvXqsIijZjcAGtfbKbqBLqyVy818tQa5DjXsECuL/+8S9MY
 erF+TTTeQAzN4obpKMxedoX9hEZLZCWTTMB13pKxIcFPQKX717OIZEsPpmceLum3WGrqYauCOhN
 yLKLGUmlj8enruRRvSliMUzk+eHwcjkYgSYAD5xy/7oKakTIzJGS01IL0Yc3QSdYpXm6kXYLgSX
 Qlq6R4m9AIP/Ly1arJ0HDoq77rzWe3Mg+GXSSfRIYZady4ch3nKnfqtrxMEGmXjCsRAE2wEvtvw
 nvbqetf+Zpid0X2fiJdJrAi5OKAwsQlIV34oQATiYP4HdXpmogFTuofCouU6+oqIvlxcrU7k
X-Proofpoint-ORIG-GUID: 941AFKbDFM6M3_tNcm2qwlWOEZGlPX96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=870 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170094

Add the missing clkreq pinctrl entry to the PCIe1 node. This ensures proper
configuration of the CLKREQ# signal, which is needed for proper functioning
of PCIe ASPM.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d839835fa464a8d5682f00557f82e..8f15be63394658a6168175a5d2183a7a77e34426 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -811,7 +811,7 @@ &mdss_edp_phy {
 &pcie1 {
 	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
 
-	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
+	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>, <&pcie1_clkreq_n>;
 	pinctrl-names = "default";
 
 	iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,

---
base-commit: e2291551827fe5d2d3758c435c191d32b6d1350e
change-id: 20250717-clkreq-92379d031869

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


