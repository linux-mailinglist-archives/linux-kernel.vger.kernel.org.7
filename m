Return-Path: <linux-kernel+bounces-737137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D2B0A835
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3EC3AA8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA72E62AD;
	Fri, 18 Jul 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HddTm0sh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D76293B49
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855233; cv=none; b=kbiSQ/hmnyv5xsLZg2wKsEK/R08efQamW9b/vS/olrxlGipZrTDioUraznsMV+UanwLo78Go0pLyJo5N3HKEjNEwCL4MU6uqELtG8Q7E64eSEufl1nFtYlam3Py6s5FE3aU6SgprLAAY4R87T9njzgZgdfdI6a2bzQPBx/mjiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855233; c=relaxed/simple;
	bh=qbZsoJ4WpXYeEtPSlbOZ2i4uthnkxzqWJFYyR6RgjZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMKDmgnbsv21tm/3s3anNcnmfwesXc+vfycze5nCM4fe0DM7mxLjmYIUmg+53NX2tv2GknML/J+Kd1sDwkzvvtl6nnTwIytlEXpBxxlYPJjKIcMktwaqhZbFj1E4h7QUGEMEgyjLxeIyzSDj0dpgTpcE/jqLyuqjzy+yc37I4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HddTm0sh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I89gqZ008525
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x3jBTC4AynQ+yZKDFlQILcBO8zD5iMJ+Pqbi43VQy84=; b=HddTm0shYPQdh07y
	H1wHzpgPVDXBKe268xQ1R3/d2mQoUi+p78iYcBinNl7bdD1w7V0OAaZ+Lo+6PmLz
	rJpo3F0OSEEQVpHeGjAGNbJZPScHfSZQncRzbrfYj/bOW+5fvvggfhzB9+G3EgVy
	HO30MvyE+TumG19ORBp1OzdWGXyWyvgPL3iaX63W1b20QSWWMF8XH3r9tQZqfeR1
	8Gm56P1YcNuMreHMsPpbNzCtpfKiDfQxR+vM+NQdmJHcL9iPocSfADv6gBqgOdqr
	u8fk47Gm6pC4zvhmcrJdCMA3lWYlJFHfP81fghCj8+aHLBBeZWbesI4ICKxxAX65
	vbXqWA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbc80e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:13:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e06402c7daso324702885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855230; x=1753460030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3jBTC4AynQ+yZKDFlQILcBO8zD5iMJ+Pqbi43VQy84=;
        b=wwjVTpiWdVrrRZFoqPsGGUvNocSimgMxgQU7UIkrgHsT+VbAvFqo+BdRdcdsh5Lg+F
         X+qUHqlT30DrMWwivEoblOYnvunDo+WJgUaS/G/aJ1VYLX9JZ3rcry+yyCxPvk2stN/e
         bCYzQ1uhYrDFi5Sg1b7QJsTI5GlnD84wDBUOy/R+5fqPNgvG8IJ4YbNT+bUDxoOtSrS0
         c+3BDkKe9lS+C4xp7hQSTQowZYcfsdmLSt1OZa7llgcDazpvB1njBj3CZZApDeFfwRN7
         Vz5YWlZweXjF8FUebF1Fa90G6RWcVR+Q9RMh0z2FeD1FikbdF4xn5Zn5JZL9Zdyvsg2A
         UncA==
X-Forwarded-Encrypted: i=1; AJvYcCWMbG1URjN3YjeHcG4slDEfWndz1lPry0IQkp1RBCBCIbwdDHSqPcHErhcNNcev/wJnnQzhQzE15qUPveY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgqyneXKaobvdXYCHoetRnNaiQQ1ecpVoBWATn0noCGw2Frtl
	cwspd9ZfOj6dQdX5E6X6PHdPbTgAQv+JCb40Y/t3nW6Wtr3Uc7nJjb+c7IBXlh1HyNtKEOvcsrP
	Hmgs3EghDE/2yLuiTN50IE9YYmRrcsxN3OHTvCHil1FAfLAdyAvmJ0at9phMh4tv8HcU=
X-Gm-Gg: ASbGnct1h56wRKF7Iy24kB4udYCisHdS8WIxjz/vJUxlnsX+E82uAptYu/azCnu2248
	W4qQpRf1TG401WNyrFIqP8w8yuh9oMLKFZ8o9rtDW1RaqBuyw7vRQVTtalsP92ohgRt727oCr2E
	Obwx7banIa2HNawVD896qaox0dvg36grsZgExesx2kNung9jYk8o20HHnZtdHTXletlc8edLFOz
	DwOtk8fhRFfYiWGvHbyqECIhYsUW9AtQQcuyGNBU1GprgzC6xGimU1q8MOwHjJLm2OU67pQPDtG
	K4jwLc+kgGWHbe5Nn0JfBGL/HVoiiNlxaS6yxuALcloYPH9sZH1aw95z7VgK5mSMrPk44plZ/8w
	MVLozxKNxnIcNEYf4YDtC7jUmg2DjhSGxDtmf0n+VF14Zb17sU4Pm
X-Received: by 2002:a05:620a:3d12:b0:7e3:4413:e491 with SMTP id af79cd13be357-7e34413e869mr1399592685a.61.1752855229760;
        Fri, 18 Jul 2025 09:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1122fPka/53dNADi6RlnmEas+Pvvg3ROQ+ycEnr8z5NvdDUj9fS6sYKgHvTRJw+APk0QlKw==
X-Received: by 2002:a05:620a:3d12:b0:7e3:4413:e491 with SMTP id af79cd13be357-7e34413e869mr1399583185a.61.1752855228615;
        Fri, 18 Jul 2025 09:13:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:40 +0300
Subject: [PATCH 2/8] dt-bindings: power: qcom-rpmpd: sort out entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-2-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qbZsoJ4WpXYeEtPSlbOZ2i4uthnkxzqWJFYyR6RgjZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3i/jyVE0ZIoibzrTm/1+blpzp8ZkkyxXI2
 lmruymnYleJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1dOnB/0XkwyWN4V3SDZec6oX7fdy2JHxJX5yUxi76qD0OcjvKJWJJvITSPq2Q7t+y+MeO8LA9sg
 hn5CMYqiaTBJXjMuheKlOa+HWpcSULkC+kShj+tJvNoY4VT7wJyErAeDgQhnaLLiugCLMzLccNC
 6dNJYkdLUK+ec9H6iCPZwzQrZcP3fW3PwA4xWyW9CFdLyS8apwtEr86mOwWawdNrcSrU0wOG/Za
 n1YI4j2c/kG58xlATqK1bUDrkH5RpqTFWdR6OdgY274q+ufGHNQjuztmRJ/HahZOx8A/JDxCzF1
 vp9pEVyK11RiuKRQ90xAr6DFdxwAT6r/0mmTae4wrpDLtO0s
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: PPxMWNDEiJpHcflzHKn4viTFXRyuxBgQ
X-Proofpoint-ORIG-GUID: PPxMWNDEiJpHcflzHKn4viTFXRyuxBgQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyNiBTYWx0ZWRfX+ocbdlXJg2Fj
 rwHvy5ncplhEJZfz3WKtuGyc/j/ERBpr9EVI/CliBtFU/lVqgfL0HqlxjiWuoAoeUS6FBw8qA1A
 05F+n8LAggCwGWXCyiGJwwso1cEeop5/NjiuNvxuxFChruAMPxFA9F4zwdaEAnKHkEjesX5b3bg
 lgiFSbsFsH0SCpXQP+6OzC9IwVVhaQrjw28CDelE/f9QYRM0bhcCMp+2X6KHu/gMEmsXkJGDzXT
 R4K9TUlDABtyNTdbT6GB1CSohX4VE8uaSeoJsjez4Kb8RHHNPS/fkGs6atC0IKSc8q22hTlOLdz
 W1cl+xd4od0TVhEoQG5g0QKlakXq4R9RSNbN9y+bommffqE40tx6T0znZQTk1pBUyyUsyxj7A2B
 xxgkC2tkqRdKSR6pY9mYKLD6YyxV5toRFEO2Qpr3FJEiQ8ur+6PKXtPXlO0oLp2YHi29eT3A
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a72be cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=lzX941RX6UCYqbaESYMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=729
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180126

After removing RPMh PD indices, it becomes obvious that several entries
don't follow the alphabetic sorting order. Move them in order to keep
the file sorted.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index d303b3b37f18e0ff63929f3fe197151c5a3d3364..65f7d5ecc3521cfbc45d6158bd6143ea09f47302 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -6,18 +6,6 @@
 
 #include <dt-bindings/power/qcom,rpmhpd.h>
 
-/* SM6375 Power Domain Indexes */
-#define SM6375_VDDCX		0
-#define SM6375_VDDCX_AO	1
-#define SM6375_VDDCX_VFL	2
-#define SM6375_VDDMX		3
-#define SM6375_VDDMX_AO	4
-#define SM6375_VDDMX_VFL	5
-#define SM6375_VDDGX		6
-#define SM6375_VDDGX_AO	7
-#define SM6375_VDD_LPI_CX	8
-#define SM6375_VDD_LPI_MX	9
-
 /* MDM9607 Power Domains */
 #define MDM9607_VDDCX		0
 #define MDM9607_VDDCX_AO	1
@@ -130,6 +118,16 @@
 #define MSM8998_SSCMX		8
 #define MSM8998_SSCMX_VFL	9
 
+/* QCM2290 Power Domains */
+#define QCM2290_VDDCX		0
+#define QCM2290_VDDCX_AO	1
+#define QCM2290_VDDCX_VFL	2
+#define QCM2290_VDDMX		3
+#define QCM2290_VDDMX_AO	4
+#define QCM2290_VDDMX_VFL	5
+#define QCM2290_VDD_LPI_CX	6
+#define QCM2290_VDD_LPI_MX	7
+
 /* QCS404 Power Domains */
 #define QCS404_VDDMX		0
 #define QCS404_VDDMX_AO		1
@@ -169,15 +167,17 @@
 #define SM6125_VDDMX_AO		4
 #define SM6125_VDDMX_VFL	5
 
-/* QCM2290 Power Domains */
-#define QCM2290_VDDCX		0
-#define QCM2290_VDDCX_AO	1
-#define QCM2290_VDDCX_VFL	2
-#define QCM2290_VDDMX		3
-#define QCM2290_VDDMX_AO	4
-#define QCM2290_VDDMX_VFL	5
-#define QCM2290_VDD_LPI_CX	6
-#define QCM2290_VDD_LPI_MX	7
+/* SM6375 Power Domain Indexes */
+#define SM6375_VDDCX		0
+#define SM6375_VDDCX_AO	1
+#define SM6375_VDDCX_VFL	2
+#define SM6375_VDDMX		3
+#define SM6375_VDDMX_AO	4
+#define SM6375_VDDMX_VFL	5
+#define SM6375_VDDGX		6
+#define SM6375_VDDGX_AO	7
+#define SM6375_VDD_LPI_CX	8
+#define SM6375_VDD_LPI_MX	9
 
 /* RPM SMD Power Domain performance levels */
 #define RPM_SMD_LEVEL_RETENTION       16

-- 
2.39.5


