Return-Path: <linux-kernel+bounces-680738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B9AD4916
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 05:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A24F3A5032
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 03:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2E225A47;
	Wed, 11 Jun 2025 03:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F35BS/br"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298C3C1F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610822; cv=none; b=hjW+5BQ1+FO1m3A8NswqGzGy7YbdPsmxJt4g4khSRQ4pa2HFEyiTynSuqD8oa3lNoc/Dm2QAUIIlzoQWjFuo0y/5a5UztD1j6X4FHJfcuDK5bBN9tPETgoNE9haszRjCOkiWWZD8IGrnaSag/zrvPwaZc4KB6YBeteWi0LpnnOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610822; c=relaxed/simple;
	bh=YwimPYQo5w5oj3euFTtVkBsrZNt3dvgUqWiiSoaOPQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KDN8zEUxOJZMcvifrnH0NQfpD+1GVE9ZvOf9xcVh7hvxI/o4i1u1wGt9N9/AIl4tEnu6rJJO08p06CRVbdUoVgxnhDrEFmrPm6K5uBfpdlMxYJBzoGaj8gQmuwuQjxsWy1yGT5qxl5C89YvFH68opwHOKS4O4sbD+97jX3gkCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F35BS/br; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIQ13P022396
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 03:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jk7S7lY42gg5pO/gSWtDrK8morqTLehUEY7
	fLQbfzbI=; b=F35BS/brsrmClxp4+G2rBV3XqdWLPv9bmzybXsfnjPCjzKsQdCW
	vRtFYLwgfgr/Crp69Tb2CBe7reir/Dej5V8PAZJv35QPs/HpYAGpp+rDe419aeYB
	COrZYxzNgCVcRgqQ8aIKWgJswlWUj5WL36KsitdhC2C40I1D0usaeg99zug1lX5e
	fstLBfHV3b9irojfEmvA+1ne3q/VjSu0gs3qJZs0DEHX2dVrjgyChbAhRb4ml7by
	1CUl4Rgm80Jj+XpWulkSKpZZO6mdEg/o0F+InzMzshusKCKoJwNMTawUYWBSPtbp
	ictmBzc/ciq5lh+NfRaibjAU8mg8rWcTr9g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpu64h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 03:00:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2ede156ec4so7421425a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 20:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749610819; x=1750215619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jk7S7lY42gg5pO/gSWtDrK8morqTLehUEY7fLQbfzbI=;
        b=fv//KKjKOoQixsYDS9ybSRe6Rdme9NaLt2d/gJIuKzX78h1foZnI17LuRyhmkrYNWQ
         WApo9wVhhSucimQ0HF7ALW/rPDVcXbTW4D/jgCbai+jiQJf4X7WuNRzN6Y+Q0szU6glN
         owYbTg8/jBGyu5Zdkua/l9wjI3g/DSPR69bQkc5NMGhUbFxg/rOHs4MTxd9kaohJYVwV
         LnMBeQFfhh3LioRRbGc+iCSgFBW1bxJsl3Uld+LQDas6qorU4RX2bGPGKt7NmBi4yxeh
         5gdZ5ba4f0/mO2BAxLij83dBRZM1DFfMD73Eerr3QeMdRLovl3j/pYo2Q6To7vrTJ8Qh
         cMAg==
X-Forwarded-Encrypted: i=1; AJvYcCVZA8zwqa+n+hXaoAPomocUQKvXPBYEiOhUUsbNg0u90/g4BS8+EUoPs6mIfsywegi/2zAOLkj5gS3c8G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcDIuptjrq9crxtVCIU6FZLO5Hbts+vWZh8d7fy1GNL+epNe3
	9UoRm58TvdGINNi2N7P8pd6VAMgCkytyLznEvoxRc1x6+7HCNWTo1AeqY+EQ6re7ogVosKjiWfy
	a/KIOYd2HA/fjhAd84bejjmoEiCTBVKLhh5AHGyl1LMokF7evDIdChct1PI+yEFs5rfKLzf+rWE
	ECDg==
X-Gm-Gg: ASbGnctotyI3rg/T9T1peFFvWuQN8vgmJhp2AL/kY+wEWdtK6L3eql5qGj09Tp4ToD8
	VRBZ/Q7/u+jnxhOIzqMJbtlPa2CYfWf74Wh4tbUNHAuFPa8qbnM/LiCcRqX7TMqS5YiaH+c4ybE
	dCHLb2fvpCvOgL9jtM/DdoMeZu6Tst/SMYD8sJS0AGqp1nMozqkfrLHHnXri0xVZUalbnBBWlB6
	cXfe0GPm/NLWrkO+pKB8hHLxHSqe+RR9AiuvNWBvXwdfLWbTxMlVMXxeWV1bi6aAiNeITzWHVqA
	rhljSQsxSBKNmatSb3Vi50t3C2uyrC9HrwDZvWUkvDjCKtlk0tlfUWy4MnAr/3z+DSDL5S/z/Mx
	euYE=
X-Received: by 2002:a05:6a21:8dc8:b0:215:e60b:3bcf with SMTP id adf61e73a8af0-21f890ec4e1mr1808018637.30.1749610819275;
        Tue, 10 Jun 2025 20:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm97iwcYG4U9+2Ei9ZjiYgSzh6GmTA1c+FFmow1NqLf2qf8IaBoa6JWs0uyzi5uM0TYpYH/g==
X-Received: by 2002:a17:902:ce0f:b0:234:f182:a754 with SMTP id d9443c01a7336-236426d657amr14845775ad.47.1749610807973;
        Tue, 10 Jun 2025 20:00:07 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603511b2bsm77273225ad.243.2025.06.10.20.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:00:07 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jie Gan <quic_jiegan@quicinc.com>
Cc: Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: qcs615: disable the CTI device of the camera block
Date: Wed, 11 Jun 2025 11:00:03 +0800
Message-Id: <20250611030003.3801-1-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=6848f144 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=95F7GRXi1wRhAKWngM4A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAyNSBTYWx0ZWRfX6yN4FfDSMSlq
 YNX353p3ZfFwjmjxhUsbguO2Nt23SDeCzfAUMYa8aCT2AW4T/Zt1Vhmf0tnOg32KWqncIPmXkow
 VbI/kKI6dq5B4150b4CRWSgosTHmVLGe04RF1FY4iE4fPLlVtGro8AjkBMVkVXMGyiR9vh1M1j3
 4pnZR7rtNvVNaze+RA1oGKdmle57GjypICZj8FhzbNuoeoEvsvwZcGgkDTt/cW+g9mEZ3RD4ee3
 psxhmuDFWciHv7dNVX33xpFxrBdv7D+EZyoSdiq4yqGSCdeLFcBF8ZgeHIzPkayFSQIum1fdRZq
 jXIej3j3cU/zVv530+B1g1xbQ5wiIv+Lr+pe9mG6XVAZcv8H/JTAXB4sVa1akfQk0M0bQSY47ok
 1cYcA9qRUeZqup4cTl/fB6VOnXXK+M9EOmoB916CPuTfW2R/Bf5VPlDuGu1QTGsRbKhGvUJH
X-Proofpoint-GUID: pd540IM8WtGartTmEorFo2HRPhIuSNMi
X-Proofpoint-ORIG-GUID: pd540IM8WtGartTmEorFo2HRPhIuSNMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=651 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110025

Disable the CTI device of the camera block to prevent potential NoC errors
during AMBA bus device matching.

The clocks for the Qualcomm Debug Subsystem (QDSS) are managed by aoss_qmp
through a mailbox. However, the camera block resides outside the AP domain,
meaning its QDSS clock cannot be controlled via aoss_qmp.

Fixes: bf469630552a ("arm64: dts: qcom: qcs615: Add coresight nodes")
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index bb8b6c3ebd03..fc2ab750f2cd 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -2461,6 +2461,9 @@ cti@6c13000 {
 
 			clocks = <&aoss_qmp>;
 			clock-names = "apb_pclk";
+
+			/* Not all required clocks can be enabled from the OS */
+			status = "fail";
 		};
 
 		cti@6c20000 {
-- 
2.34.1


