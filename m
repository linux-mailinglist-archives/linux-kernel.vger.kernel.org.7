Return-Path: <linux-kernel+bounces-868636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7686EC05ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AC43B8F81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A163313529;
	Fri, 24 Oct 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V41pqSPV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DB313527
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303035; cv=none; b=Z9UtvxzAHJKxVSxzgAYlSZYn0mw2bfsA3V4Re4MJ9sSIG8MwnMrQ+2awEVcAgRBFF/bCrx4cwOIp5+UjfwdAlkRVl8Aaj8uzn7KecjYiiykSKl87z5TsGTAJCR4mz1LyFsu96qqPIKIXNafvdBcDxJNFT3BjoL5ci96SHH6Qb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303035; c=relaxed/simple;
	bh=qu/qZ84NtOyTE2o65+l21YiQTuV5u82Zwl1GWs6QyCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGH3bGOQVXkJjvhSXo4168DUWe2/fWmHIdlTry2FBpahf9fr/ZWCp1panLSkgK7b2V1mqbaKGh+WgrzipUd5UuubA+4fw67ADNdZ5I/7W3+RPvzwjaFnEZa5wIqBpXWnBGCb4X007KuFTIwBvE5M6UMQoxaGN8r9VCeLroBZ+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V41pqSPV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FKt2006164
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i/X+r8xYyGm
	fOqiALmId+62Iz9MHQaRcdFd88kOBYm4=; b=V41pqSPVKaXoXjtMlp0T1cYq4xz
	VXb5tk5ZvtqRmtMiHZ3hxVm9/+anfq+CS2hDGqmKfkYDctWuNVYdDYdaMNHj5mtG
	sEr95BZgVStmw6TQaQtBrPO5kp79QnHmtRfF6fHjRX9Xe6KOGGmwka4Go/1CefEC
	EGS1bSq0as+ZOOXsEP58OyVgW+b+LKYKu7gvWsLmGcyykWpIfYEzgb7kV+CCw9mg
	vU+g39laIzGrvDgZ2023l1kTiqHMrMwC9JtbDy+4Yg2wHO+ktfQaU4gn5oAmDT7+
	OxIkdEfwAGSqSjB15WnupD5l1SeswbGVcGApC/mVcpfc/OEVKx9GmwO8rLg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344bsp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290b13e3ac0so16882985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303033; x=1761907833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/X+r8xYyGmfOqiALmId+62Iz9MHQaRcdFd88kOBYm4=;
        b=rnEpOSxheDU7K3d/ImkHxfGkistwPhfYxR2aN56leNdbL1+qFWA2QeFZ3ljBy4cvdw
         bHr66VYCGMHE2yF4JE90xKZWbJovEYA5KnAQ4ck5ZyIbzoxgF1DAnKUzvlAyZc7uchSS
         Q0PiR0VfOBHElycQXxUoEbrYHdb3IxqqBalt0XB0rgzwLlxMdsO9fXFPqld4GzKgPxO5
         /CIGp2I9puZRfq5glAelNRtLeTaCsHewEBbEyI5/4JBxCh1qUkqYW4vui9NUcWmg/h2u
         f/vRdsv6dVK8QyF5o/dVj/ThXr5PfF9cjSYz+QLDGz+35vcRTf4MKrClwziRSE2DZQFP
         6Gww==
X-Forwarded-Encrypted: i=1; AJvYcCVfFvLgnBBuT6vHmt30dJPEOWhUDvHrufNcq6bDoeLtT3aC/JG/jpzHvzmpB7xPJzhCo66OShjh5XNd8XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DSH71esBL3QWK7Pm5ZusJu7p4/rlX3iI782hl6a0FJxIqaoO
	WK/ztpi/77pslZy/5TF9yBvfYMrPxIeM3gOOnrifWSzUpsPo11j1/mzFiLcuXQXvKq/1XGc+h9l
	NEX0L5l5uMw7x7baRKiqQQfFjCiONvTCCYfsFcLyQOJOvHpN4Wp5blyHDvpRTR2NwJxU=
X-Gm-Gg: ASbGnctSVjehagB65EfnnPPMHrIWK5dmqMjZuneuNnTMRylDdf4aHIkQMgzZWAGUalX
	hZGs3/povxYBVSWi904WNBlF86rHOoSHG77dla11ogAPnN9znILIDBkM3JVqKo1IbRYW1l4X67a
	l1ZiVsIRLgFZJiWqkM1JRwRGhKdHbE4DKMgaQsF8fsMtz3HwDMHdIHI1buRo7jV8nAplcPX65jT
	eERWRU8dKCGQ4jfakjLuyOnKc1yVVY3qBt/1kCF2sFyhNfgQ+FtHstFxgYbaXfzZoPoEB2r8Zg/
	GNoNY5Ok5LnN0OY0RVhcyCIiz6HfcXNHySVcNpVhpywd5IOv9MnK3sWk2SCQypM3tCfIo90c2VS
	bLUQy0W8Wm+KGbXoSWmTHHKggN9G1yBcYGaUL
X-Received: by 2002:a17:902:c942:b0:290:ad79:c613 with SMTP id d9443c01a7336-2948ba3eba5mr25935305ad.47.1761303032567;
        Fri, 24 Oct 2025 03:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtXYlwjMr6Gvf1ckzMeyuRRuHXM2bM6pczkChDOcs3/EJcn5nHuQCPbO1tRPn0r707vCS2zg==
X-Received: by 2002:a17:902:c942:b0:290:ad79:c613 with SMTP id d9443c01a7336-2948ba3eba5mr25935035ad.47.1761303032135;
        Fri, 24 Oct 2025 03:50:32 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm51236775ad.103.2025.10.24.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:50:31 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100: Add missing quirk for HS only USB controller
Date: Fri, 24 Oct 2025 16:20:18 +0530
Message-Id: <20251024105019.2220832-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mffpU6nc_Vcy7-0qeolbvfDUSPPS0qAG
X-Proofpoint-ORIG-GUID: mffpU6nc_Vcy7-0qeolbvfDUSPPS0qAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX/6yaWoCqsr4Q
 P9XuKqBEaMI3hCPKTy8ISH8BMFIyesjHsRoFHqKF42k5P+XS3vPhUFO3fdzA2DpGyXnbwIbdThh
 SWKWE6dTRr2pyhTWXfzgSvtIJwLP0jnRteYa41qd2QhCCiXyBaYxRe/C05dnoXxGT6PaScw1AG5
 XKqUV1m06tP4v5i361apeN6257V00GCQPqr6EanZf95NhnUCRIOg8QjQWJVRI1fbExqyDlYybra
 BlMwvvBCK7hUKK+HcugZW6SG3YmefQBuixTqxATR9HDfhpVv0PWi3CCHQQ4smw/Z0PLx29CJDcU
 MZ6Ln+wo/7nSCyAsWiZpbg8ArbBrezAhO3qpLrSHuD8wPht5LWpRjsnQ/E7zRcnMCL4cgKaMnxL
 hUoatLQ3kMSciHBm1dNiMqAsuuwQqA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68fb59f9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=iNHPuiuMtRvPBLkl12UA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

The PIPE clock is provided by the USB3 PHY, which is predictably not
connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
quirk to  HS only USB controller to disable pipe clock requirement.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 633b7402ae84..087465f028f5 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4949,6 +4949,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "usb-ddr",
 					     "apps-usb";
 
+			qcom,select-utmi-as-pipe-clk;
 			wakeup-source;
 
 			status = "disabled";
-- 
2.34.1


