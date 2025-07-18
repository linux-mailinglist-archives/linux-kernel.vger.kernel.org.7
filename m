Return-Path: <linux-kernel+bounces-737143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31636B0A852
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0445A36C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826832E2658;
	Fri, 18 Jul 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="odUf99go"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF682951CE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855626; cv=none; b=kwvVEjMuPaYhqRSEKBjJNFwHiE9xGgkRJRTReSMgF/I29lMFW47XQLXiHP+/DUcx96X5TLPaIWwYLf4nnNAlVJGOJqf2dF15MIW90gT8fZdbSRYXcK6aVWT4WAE7AtZpJ0a4lsVRPEANFWvOLwyHbK/3eVEOskVsYVGsv88t3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855626; c=relaxed/simple;
	bh=hKwIxLX6Tkq5ssXYijoQYUEhL4IdWqUldpJvuIWYf1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHYnPZEjjyRSHHEfcReto5IehC13H6ldonv2BsrTSxXPZTd9gHpo+qoxTVyWb7lhZaJchEWwfV6GbDGN+ycWZMko5D6hFeFasq/wWKpUgAD5Khf3mFNCUyOly3MPF22GW/ndEChBPjIFRLpG6rtguc7zI5Pc5/HtsKXbTcUfs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=odUf99go; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ICL4oh029884
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bC86cQsWTQOgqMpG7vO8FaEN+Csh7UDonwPSnCbi+A=; b=odUf99go/JP/kCuV
	dDKnf240HKqwNgfq9OmBBOjUqazvW75E5X4uYiwv6GaO8+PKa3pj8csWZwiXETWz
	i+0FDTokvPYFYvEhdgR4xpYGqbzBO+G5E2pSoSxKhBHiRfmoL5XWhdDEWw4JUgRQ
	/ud24bNu6pYMJ3QnS/2dOeTuOikNsffmUG+erWVNGA8oRd8dwNu9DuVVaP0R31tC
	nxMcTXxXdZjaHEz9AbFDYamjACIXLws9w9kLPRvEtv70shYf9FwK4jvjyGqSdThP
	uElXPEQjCQ0Xutc2rW4nabKI626LWVSN6aMC7/QJse2oo48I0xfQSVfnbdkQYzlx
	nbnXjw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47x8x7s319-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:20:23 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-611051d18feso1822188eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855622; x=1753460422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bC86cQsWTQOgqMpG7vO8FaEN+Csh7UDonwPSnCbi+A=;
        b=CxYL2ws7DSihriDm+ew25Y0puSKx1y0NGGSiyoav0eYsYQpwcNiRsQzeara657ZivH
         sKbMggI/U3yO99vttSxdUSog1AY/Kz8olagVyaeiQLWBGx/rlXqu9S39Dde46eZsR1LU
         4OlFCzSGm63lDUFST7SUCCqx/r6uV185mApeg73cwwdbPJJ+vf5QGlK7hNDlvqPrD35D
         5qo2fl+NSc4TcjjcgYvgmjpAuZqT/4s3siL3gMDVoniAR8OzrRSutk6ZqkIE5O2g20s0
         GMw1EtmehupVbCInVYCNAJ6AMgmx59uM5ZKKVpDp8H2YpjSnB6cldLzR53scDfjgi75t
         BGfA==
X-Forwarded-Encrypted: i=1; AJvYcCVfoVIpu1WT0Esz+sG9J/QAjqfBF13ZblUlfxA//6arFj0wl8vowWuMDHgLUEMQYgyoAFKSL4xI9WGtk7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywme1+8sGV7PJfp36mtOysrm3pdz+oAPPOFIr5UohnMLRsqbPoa
	UlRCwRPxB9B8JtLUe4hI5ZFnOBpZIYsV3/rjm0GoLtp9fosXf8TPwOrXiVe4Lbn7NnrVQSdlQwa
	kdJyykwNTgjhrKca1fyiHYWCtgE09ucapaEZj2fYzMnfhhYpKqKkFP/0jSzpWBw55UoNlyZH4P8
	U=
X-Gm-Gg: ASbGncvH7OjC0CRoPd2iZKzcD2GLXkSTBo+REEaALiS5u/HIIoXxP47tkk7OCbj+MLj
	qfB7ubSJa7LbNsOdWagbYYbUR6IAl+qPqqdJtcj9Yxx6La93hPM8BHmp+HDm2KpSmUsqtmfzR2b
	jwaKk7anKgw4l0oa58rlPbehJaSlBRw5DJ0xI0bjiCnWLFnliGuwRPPEu4Lftjm/djbmoWH4JNj
	lhl60ratkIaHXOkv7uE8QdkdMjL7lNmtQSRpxLQOYzKxOqImvrzk3omyXz6RO+RvkW8BfJYjj/q
	CJ6W4f794J6QCXSvqbVaxdig3gy7m5ITK4/pYMAiebWqv5jntznzQhdfDBB1AmT7NbxG01se0Wy
	tl6aeVl2Fkw5SQlroCvKKCtWy9SIUvKzRrtPXMVOB5h8vVwbJPX3k
X-Received: by 2002:a05:6808:17a2:b0:406:67b7:8b62 with SMTP id 5614622812f47-41e4748ed00mr4553392b6e.38.1752855622105;
        Fri, 18 Jul 2025 09:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/xfyE4EqYZs5SJKoG8l9Wmr7yLZMHsyXm0BSNJgn7dGYympaLxySGid05XcsqJ+9QPL8dQ==
X-Received: by 2002:ae9:e302:0:b0:7e3:2db6:1163 with SMTP id af79cd13be357-7e34d9d2706mr818138485a.43.1752855230952;
        Fri, 18 Jul 2025 09:13:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:41 +0300
Subject: [PATCH 3/8] dt-bindings: power: qcom-rpmpd: add generic bindings
 for RPM power domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-3-eedca108e540@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5883;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hKwIxLX6Tkq5ssXYijoQYUEhL4IdWqUldpJvuIWYf1I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK3c1qXB/balMU/jlQcdeziArEdBNc7sKEd3
 ef4fwJs6OKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpytwAKCRCLPIo+Aiko
 1SkJB/0WeBKjARPPuXb1n5taQMhySYAUcfJX1gsRiO3aUC1ORivBGXl2bytDlYboU1K56NYeWO4
 /khQR9GtaaZJ2TqnHrpnqA6Dxegz+/T/hwUFiSbXthk5YD5Br2JNJFkDvEJ9sSlEIHpyOKtnm+I
 ehbjPIgKY17hLhIxW7/MbhYrl964elgrZn0ue1Fk5HLan1wthQJt2fXyKChkQs/vk0BSWPweCBz
 z1DC5N7U37sxpfozs3+tYb0jsOYRWaBG9/K+9LDelcJEgjD6+pf5w+U26qORa0ShOgYGuguAzVS
 Fw+fqhrBAPr30ShCCGpSRD35A8Pp1LSqNF1p3u6lpUCgrqpl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEyOCBTYWx0ZWRfX4CD0eN+CEr/m
 QK3Q19+j+ZN19B+KseO8yGSvFBTNT0pHSXUXeNF9gDXqFEuLRQwPsiegQ8eyCPzeW7ROFGJK02T
 N/IiH3OxSw17kUBh2UyDqHvZoc1GcDl5WHGnN8ubZsY+hNQZaTT0epPAbVN8fnjG6jjEVwxASXs
 c4TvYg5GM2jW/WX3l9BUaT046hSXtigG2f2AL6+5/NDUu50T1vuWK/uqLL7UAfPrLyHR2G2LHqC
 p4dSsjcYO5f0omtGCzwrn+b13mnagNP8KTAbX2Ac4GzyzpjkD7rQm9YVORnG/sBSfqtr0n9FMT5
 gfNHoYXMFjGHUY4UT7FmNNoBXO3ro1RO9TDFvVPXDeuKEb0599kr3FcUTHE8AEaLQqh5/sNiLIB
 vzib0S1JRs6jP6/+efLKOfLQZootlBM/9HjpYtcqJcyN1DwS/mLuXRHrNaXqCaXvDtcidHTl
X-Proofpoint-GUID: HevTeV3yDydD8VjRLSbvaqSrQPQEBGV0
X-Proofpoint-ORIG-GUID: HevTeV3yDydD8VjRLSbvaqSrQPQEBGV0
X-Authority-Analysis: v=2.4 cv=N9YpF39B c=1 sm=1 tr=0 ts=687a7447 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=AzVmNdOAsp2gS-V4oEsA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=878 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180128

Some of the Qualcomm RPM PD controllers use a common set of indices for
power domains. Add generic indices for Qualcomm RPM power domain
controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom-rpmpd.h | 121 +++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 65f7d5ecc3521cfbc45d6158bd6143ea09f47302..4371ac941f29d9657b6573f4934658f100726224 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -6,18 +6,37 @@
 
 #include <dt-bindings/power/qcom,rpmhpd.h>
 
+/* Generic RPM Power Domain Indexes */
+#define RPMPD_VDDCX		0
+#define RPMPD_VDDCX_AO		1
+/* VFC and VFL are mutually exclusive and can not be present on the same platform */
+#define RPMPD_VDDCX_VFC		2
+#define RPMPD_VDDCX_VFL		2
+#define RPMPD_VDDMX		3
+#define RPMPD_VDDMX_AO		4
+#define RPMPD_VDDMX_VFL		5
+#define RPMPD_SSCCX		6
+#define RPMPD_SSCCX_VFL		7
+#define RPMPD_SSCMX		8
+#define RPMPD_SSCMX_VFL		9
+
+/*
+ * Platform-specific power domain bindings. Don't add new entries here, use
+ * RPMPD_* above.
+ */
+
 /* MDM9607 Power Domains */
-#define MDM9607_VDDCX		0
-#define MDM9607_VDDCX_AO	1
-#define MDM9607_VDDCX_VFL	2
-#define MDM9607_VDDMX		3
-#define MDM9607_VDDMX_AO	4
-#define MDM9607_VDDMX_VFL	5
+#define MDM9607_VDDCX		RPMPD_VDDCX
+#define MDM9607_VDDCX_AO	RPMPD_VDDCX_AO
+#define MDM9607_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MDM9607_VDDMX		RPMPD_VDDMX
+#define MDM9607_VDDMX_AO	RPMPD_VDDMX_AO
+#define MDM9607_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* MSM8226 Power Domain Indexes */
-#define MSM8226_VDDCX		0
-#define MSM8226_VDDCX_AO	1
-#define MSM8226_VDDCX_VFC	2
+#define MSM8226_VDDCX		RPMPD_VDDCX
+#define MSM8226_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8226_VDDCX_VFC	RPMPD_VDDCX_VFC
 
 /* MSM8939 Power Domains */
 #define MSM8939_VDDMDCX		0
@@ -30,11 +49,11 @@
 #define MSM8939_VDDMX_AO	7
 
 /* MSM8916 Power Domain Indexes */
-#define MSM8916_VDDCX		0
-#define MSM8916_VDDCX_AO	1
-#define MSM8916_VDDCX_VFC	2
-#define MSM8916_VDDMX		3
-#define MSM8916_VDDMX_AO	4
+#define MSM8916_VDDCX		RPMPD_VDDCX
+#define MSM8916_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8916_VDDCX_VFC	RPMPD_VDDCX_VFC
+#define MSM8916_VDDMX		RPMPD_VDDMX
+#define MSM8916_VDDMX_AO	RPMPD_VDDMX_AO
 
 /* MSM8909 Power Domain Indexes */
 #define MSM8909_VDDCX		MSM8916_VDDCX
@@ -44,11 +63,11 @@
 #define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
 
 /* MSM8917 Power Domain Indexes */
-#define MSM8917_VDDCX		0
-#define MSM8917_VDDCX_AO	1
-#define MSM8917_VDDCX_VFL	2
-#define MSM8917_VDDMX		3
-#define MSM8917_VDDMX_AO	4
+#define MSM8917_VDDCX		RPMPD_VDDCX
+#define MSM8917_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8917_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8917_VDDMX		RPMPD_VDDMX
+#define MSM8917_VDDMX_AO	RPMPD_VDDMX_AO
 
 /* MSM8937 Power Domain Indexes */
 #define MSM8937_VDDCX		MSM8917_VDDCX
@@ -81,12 +100,12 @@
 #define MSM8974_VDDGFX_VFC	4
 
 /* MSM8976 Power Domain Indexes */
-#define MSM8976_VDDCX		0
-#define MSM8976_VDDCX_AO	1
-#define MSM8976_VDDCX_VFL	2
-#define MSM8976_VDDMX		3
-#define MSM8976_VDDMX_AO	4
-#define MSM8976_VDDMX_VFL	5
+#define MSM8976_VDDCX		RPMPD_VDDCX
+#define MSM8976_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8976_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8976_VDDMX		RPMPD_VDDMX
+#define MSM8976_VDDMX_AO	RPMPD_VDDMX_AO
+#define MSM8976_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* MSM8994 Power Domain Indexes */
 #define MSM8994_VDDCX		0
@@ -107,16 +126,16 @@
 #define MSM8996_VDDSSCX_VFC	6
 
 /* MSM8998 Power Domain Indexes */
-#define MSM8998_VDDCX		0
-#define MSM8998_VDDCX_AO	1
-#define MSM8998_VDDCX_VFL	2
-#define MSM8998_VDDMX		3
-#define MSM8998_VDDMX_AO	4
-#define MSM8998_VDDMX_VFL	5
-#define MSM8998_SSCCX		6
-#define MSM8998_SSCCX_VFL	7
-#define MSM8998_SSCMX		8
-#define MSM8998_SSCMX_VFL	9
+#define MSM8998_VDDCX		RPMPD_VDDCX
+#define MSM8998_VDDCX_AO	RPMPD_VDDCX_AO
+#define MSM8998_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define MSM8998_VDDMX		RPMPD_VDDMX
+#define MSM8998_VDDMX_AO	RPMPD_VDDMX_AO
+#define MSM8998_VDDMX_VFL	RPMPD_VDDMX_VFL
+#define MSM8998_SSCCX		RPMPD_SSCCX
+#define MSM8998_SSCCX_VFL	RPMPD_SSCCX_VFL
+#define MSM8998_SSCMX		RPMPD_SSCMX
+#define MSM8998_SSCMX_VFL	RPMPD_SSCMX_VFL
 
 /* QCM2290 Power Domains */
 #define QCM2290_VDDCX		0
@@ -138,16 +157,16 @@
 #define QCS404_LPIMX_VFL	6
 
 /* SDM660 Power Domains */
-#define SDM660_VDDCX		0
-#define SDM660_VDDCX_AO		1
-#define SDM660_VDDCX_VFL	2
-#define SDM660_VDDMX		3
-#define SDM660_VDDMX_AO		4
-#define SDM660_VDDMX_VFL	5
-#define SDM660_SSCCX		6
-#define SDM660_SSCCX_VFL	7
-#define SDM660_SSCMX		8
-#define SDM660_SSCMX_VFL	9
+#define SDM660_VDDCX		RPMPD_VDDCX
+#define SDM660_VDDCX_AO		RPMPD_VDDCX_AO
+#define SDM660_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define SDM660_VDDMX		RPMPD_VDDMX
+#define SDM660_VDDMX_AO		RPMPD_VDDMX_AO
+#define SDM660_VDDMX_VFL	RPMPD_VDDMX_VFL
+#define SDM660_SSCCX		RPMPD_SSCCX
+#define SDM660_SSCCX_VFL	RPMPD_SSCCX_VFL
+#define SDM660_SSCMX		RPMPD_SSCMX
+#define SDM660_SSCMX_VFL	RPMPD_SSCMX_VFL
 
 /* SM6115 Power Domains */
 #define SM6115_VDDCX		0
@@ -160,12 +179,12 @@
 #define SM6115_VDD_LPI_MX	7
 
 /* SM6125 Power Domains */
-#define SM6125_VDDCX		0
-#define SM6125_VDDCX_AO		1
-#define SM6125_VDDCX_VFL	2
-#define SM6125_VDDMX		3
-#define SM6125_VDDMX_AO		4
-#define SM6125_VDDMX_VFL	5
+#define SM6125_VDDCX		RPMPD_VDDCX
+#define SM6125_VDDCX_AO		RPMPD_VDDCX_AO
+#define SM6125_VDDCX_VFL	RPMPD_VDDCX_VFL
+#define SM6125_VDDMX		RPMPD_VDDMX
+#define SM6125_VDDMX_AO		RPMPD_VDDMX_AO
+#define SM6125_VDDMX_VFL	RPMPD_VDDMX_VFL
 
 /* SM6375 Power Domain Indexes */
 #define SM6375_VDDCX		0

-- 
2.39.5


