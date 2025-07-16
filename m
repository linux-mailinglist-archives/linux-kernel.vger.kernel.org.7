Return-Path: <linux-kernel+bounces-732683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF77B06AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DD6189F9EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2F13C695;
	Wed, 16 Jul 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivJzNZCW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D751311AC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626411; cv=none; b=VV+lAQ9jVN3SWleSzL2RU1WS7jfrrPI6ipO/RJQ1IUfCz0iKVbd3+6j3W+KURyCr40Ybg3mJRGFMoTuVLfLcec4vPbskqCo/z/9gEm1lkOkskOaoCNRKS2XKAXBxwqxADbgGQH4xmwfHxy7SiU6iRiu14v7d0hPVxYp8EqRehoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626411; c=relaxed/simple;
	bh=DmMC5bCJ9CWUiX4p10MCxK/dY96FoqUa8x52jrnCqLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIKZ/s+t6SG0joClnhUnepZS/HeuSiDoESsm2snLePc09FGVGLBi2QEsDyLUlPtZjs0Hbo7FhWf84mY4mMROSCP8PC8JVtDpW+pxcRTorQAiHhXxvp8KbPKe7q+BsswFXdwgnTHLWpBQKrxQYpRL+tY3fkOcPYSkyIgBZXvPAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivJzNZCW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDEeu025762
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GCF416+VOtu
	BXP/dynqOe3kMJwo5Rxbt8eiqcDIlK5I=; b=ivJzNZCWSFYVYHZkhoM1WbpWeAg
	zEExV7vyf094wYQwoPs8Y23OEIH/euhDNXJUwuRD/L2BtMdERS2ePlkbFawZJOvR
	yl8txOkn0kLGSrH2ovYu5nxaNLhM282ySKONsxGXmUN/adfrlf02e4j5qX7PfRhS
	uDNJIpjtsYPnW/jPS44QantUn7qbsvBicao3ZL3kzrQbDqoaDO02Li3p9Qu67ECE
	v/ipWlUnhnHtQdCPZWOYL/1gt5F+s8NVYo4/Yv8K8/jHqu3RmZVFDJwsGl38FurX
	BmtugrM6zQA+kIwYhZ123GKAiUeMwZ+AUXafeHB5gcNxPymoBlz6UjqusSw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy1s9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23536f7c2d7so96845795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752626408; x=1753231208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCF416+VOtuBXP/dynqOe3kMJwo5Rxbt8eiqcDIlK5I=;
        b=rpjXuisKvcKP3Ggu1dlrGcljKImpJR4alD7yAVbGINvzzZtTDwrFfsLj1nYSzAlmPK
         DqNSrPyKgishap2YEUQJZViumbN8Qk8KRQA/j5kYXz2LF/LmiAOFlbjXQwPKV4tphFXx
         /NTEuT72ZqsFf/fx4mTb3Bpgk0ThVpBL0u1nykD65lE21qHX4oA9L8yU7fpTck0RiSrd
         0owTc2Wmj8igqvzckqFsSqg1ywFnsQ8sD0pfhjp6nqnhLUE3phJnQZDHFRju81Cnds7t
         Mx0i8Mxq7EqN/g3k/YrfIBw4cY02DOWJaSaFwzax5KMpUJt2ktOkBPUd/2vnyCY+hb2X
         9Npw==
X-Forwarded-Encrypted: i=1; AJvYcCUSOwu9Wg2FCi3tYMKZz6IjxOGnZ2CZCRxPn4Vy/YUMKHsylna2HgFp0p+S5Cp/kNrUFRTwIka8DroKAWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmS2RuJfBdxGyESKVRX6ToJEp9bdEGjrmHw4MaHdTqNAnMlXf/
	30yXGaGxubaEy+oZSmYyRvqxkP+83NDAsHwFDcqR5sGtm+hFb9wiVT+ULuVZPpS206wnZdfDpJz
	nTDiPDgFQSf3+nCOGjwairHUudHl/5WwDI+2z729edtqrmKe9p8V9hAkNdUlX9RnGLW4=
X-Gm-Gg: ASbGncve8T9dmiNZNjQvJq+XF60qp5UgsgPTjY56WJfUl7V6ZNO2Y4QKRCVjmPpP+OZ
	1VrQjOzpapj+9w+fyunMfT403fRgC7y3w/biexyY57/f70tWIU8veiZ3lvdCqSDMWrPhdQ0+4BC
	p4bbGvg+bWUN7Hz8gpta+u0LfMGtvhvhhFjqEE5jLeLHwSROFVIASQG8X7HdJI+Sls95bFado3x
	tR+Y7pgB+jiBxb+1cLZNoeBsxUzibg0TXmR5Z342hTFNIWbCUiEh+8c1j3/d6WyzmGzRwNmdlzD
	7HczWuqvrzBpIf+XZ7v4Y4cJoUDBHG558MDTEEMHVzrFs4HSkNJ2e04wrYvGdPItxB+6i3mEJth
	2k5ILW626gVeyae9u1qYs9pAP1kw=
X-Received: by 2002:a17:902:ef45:b0:223:619e:71da with SMTP id d9443c01a7336-23e2579d9e0mr11121665ad.49.1752626407747;
        Tue, 15 Jul 2025 17:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZqyh5zhn7aZGpW6wWxn9yXi7t+g6XSOjNdJRS6cnNteJ4YgcV0/RNZrkd+8/jUrZRoleGmg==
X-Received: by 2002:a17:902:ef45:b0:223:619e:71da with SMTP id d9443c01a7336-23e2579d9e0mr11121395ad.49.1752626407364;
        Tue, 15 Jul 2025 17:40:07 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm117015525ad.78.2025.07.15.17.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:40:06 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Add qcom,subsys-restart property
Date: Tue, 15 Jul 2025 17:40:03 -0700
Message-Id: <20250716004004.311001-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716004004.311001-1-anjelique.melendez@oss.qualcomm.com>
References: <20250716004004.311001-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAwMyBTYWx0ZWRfX32DZJPHJfk/z
 eN/uwtDH+H/A1WJEFJF1FjPrSMI+eOJKBnByYEzgvF2CfjpUnKtwAzFdkwQpGAFvFk9e94C+Rdc
 aSe+Sp3Zhb5QEGuHkIRVaJQnHNNJDp+/DLos5sbF0Rz16oSGoSCvympogjP7gGychKV6cG8yV/d
 Z5NxO/zjHUcGCmtxU1sDnajTo31wSMC7QqfDGcGRPGbdjyxDm0i/9mghnwXtWS9cd0odxYxQuvF
 B0MW9vkR5kDmjisDxudjcVGspfAS7OS5MQ6r8mWkHLzmEIPT1sG7wgBk3QsDGVDQ026oqk71C1Q
 OvjSFyiNbgHfduqcnh/wsfuJ716ii/XbTG0+pPEJVGKdmJAY6L7Ppzx0EMha3AAuMujDpekHecV
 fCpHvakjRTbwqQakURkFYsB1r7plOJ8vi4yWPR9S7ds+o48KZD/P7v+hXX5BWcdmVZr16nrj
X-Proofpoint-GUID: -xht8mjE2uLWkGoRQrRs1B4F0d-Qm7b5
X-Proofpoint-ORIG-GUID: -xht8mjE2uLWkGoRQrRs1B4F0d-Qm7b5
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6876f4e8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EnJsE7tHsB2WQhtf5zMA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160003

Add new "qcom,subsys-restart" property to enable subsystem restart (SSR)
notifications.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523..90011096894e 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -49,6 +49,10 @@ properties:
   '#size-cells':
     const: 0
 
+  qcom,subsys-restart:
+    description: If property is specified subsystem restart (SSR) notifications will be enabled.
+    type: boolean
+
   orientation-gpios:
     description: Array of input gpios for the Type-C connector orientation indication.
       The GPIO indication is used to detect the orientation of the Type-C connector.
-- 
2.34.1


