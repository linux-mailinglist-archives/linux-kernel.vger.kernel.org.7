Return-Path: <linux-kernel+bounces-864341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA25BFA8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED8533540A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C402F9D89;
	Wed, 22 Oct 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDWD32yb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179D02F9DA0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118145; cv=none; b=EuR3KtKfh2gnMn0hJXO23x22e4hA+Ympt0tAaVM7iVezwFCwBVxWITntXRh5bg/Zy82/srHZnllGeerHbe+1pcy8t48dOFRR/xXn4zNGMxe42eOsjk5OdGuWBMSI8IRC48pFxWKIWpz49qIwU3HUMJ64W7dv6PREIt0vnF4oCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118145; c=relaxed/simple;
	bh=7XsJROAyaxSz6LryDkWxrJ3XX6JFt8eLkapu5AOerUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUpEpXC77tVa4I3hy8Zrg3axhmjNfhfSnJkgRjVVEBqQ9FwecEhv0jwvqL5Rry1AY5d8nqTciD9Hmt2TXhH9uQAgb2v4AHOBF71YA0CXp38Z8zACGhYnDy2pSfjUNc8+d5DNr/HMmZK1Bzf3hH6DPE1FUbPKFcLiF5+EHSxM0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDWD32yb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M27XqG000307
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ha5WsXGio4cpfRMOdsHnU8o9EmohdZHNryE2Em1psBs=; b=dDWD32yb3W7MKOP+
	2G2YLaAVOC39NXwnTgmxbTYG00qZOvjmjIU8WcO/ClQUVdgDAlEqOtC5ju0Lu0mW
	Z0ErqiNREmO3yYSGLEkSKV5hb1RWzASskByAQIYONUT6oL7weYMwa5FWzl4h8tXI
	SMlf+vwegXKVdkYx7eZZWe+wUd8vkd685qoCDHt+ACk4INy0w8kql260BeSNrQwf
	6HLShbpEtWtpQ7M+a0A6qy3gHlCvXCfIXLdKA1h6cbNxmDAayMQR+zHBBkkLWCtI
	m8nLzwzzooe099VqvXRmF/o08bItT2VKi+q2sk7vD/vM8kdVQXkmG/W3iHwJBRfK
	n1Qa4w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w99xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:29:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso12841887a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118141; x=1761722941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ha5WsXGio4cpfRMOdsHnU8o9EmohdZHNryE2Em1psBs=;
        b=TAbufUmU01OuWwrp0GHVgtCg43rGW/fEXr0fAf2Dk+CIKFZrJDLLlS+ghBPrLxjYsm
         JqPg00vM6BeVZLlPV5KPrzWR5FHck4u3q2kAqNFs3PCOi497p7X9jXajgyz16by13+Rq
         Qk6YThA8lltt+bbVCezl4xWGS4jWEyJ6UoRZXngqh+c/AlJm3iNA9j1BmtqVdZey7tR/
         j9v9KAYLeV7lXg+z3VwYvWPsRBOY6MCVWiBhwc4ftpdvyjkq4/vDh8UpAT3qsoB9wgq/
         p6VBRCP2TMKYFPg0fx2UybnGBvBmfgzF55Jc/i3BXs1tGBiyZA9nMMFB+BcD/E/gI5PG
         J+cg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9tJWInPnvL89NLLYUaNnjGObmTIHNb4AYYRXF8Ng4sOd9mMHKgDb5Kovn/9ImKD6o0Y0nsapCyoRF7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxuzrNaRX0xFCZZhPgeyOaB3jAJu+jBZdOaKK7PXkfxAYJ9nT
	0vZ48MHX0R7amwy9etCRD0cijzClljoz0lzpP5uTUA8wrsI/aBR8hjELc9jbe07jaIhh8BrEZX0
	enuPJtPnAbBjOf69mmqEEjQJSquj7zO4DlrE9tGAxq5rwy8HtCh/j1G6eurbnEo9rmEM=
X-Gm-Gg: ASbGnctzg21wRrEPozuuNXHNT51SBRFvC42F+3rUsRjjgsMBDDajbgFxb4JJefc/BLG
	AU10ACCrPM4ZxOnRhIcG2AydK7c6Q7rT+oL02VWcnK3mSk0iMyyGAxCOK7FqfVM4SI4cYIKZq0Z
	iYeCWKdPmLCYk/6wPmjq2qXNHleda23yY3zU2jg+Ku6ecih4n+eDlY90sikfz5npjfJdLBlhaBs
	w0lQg0Rm+D9UwY47iIs85qbdP+IfqZaacEbZlZkHJdu/O0KKhwLyssw0nbzjJE8+SYAnJVSPRWg
	gMH68PNNvGBscQfjWvR1Vc1woW1aZs/598XKIp3TCjrk3gLIQCsXXdKE7cCq093D2JfV7gWp/Mv
	0vbVV63BrvO6DRX1FeuE/iMPeV5Frp+CdCzItSqoKln6Aqk5MMw==
X-Received: by 2002:a17:90b:5111:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-33bcf940e76mr22669725a91.37.1761118141315;
        Wed, 22 Oct 2025 00:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUfeXBmWDXCej2nYFRsJmx+4Jj/dO0rVNI1Pl96X46GrmC1MJSjneWKucPte49g/Bv2jKP6g==
X-Received: by 2002:a17:90b:5111:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-33bcf940e76mr22669691a91.37.1761118140856;
        Wed, 22 Oct 2025 00:29:00 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff4498d0sm1687342a91.11.2025.10.22.00.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:29:00 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 00:28:43 -0700
Subject: [PATCH v2 3/4] dt-bindings: firmware: qcom,scm: Document SCM on
 Kaanapali SOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-soc-binding-v2-3-3cd3f390f3e2@oss.qualcomm.com>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
In-Reply-To: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Eugen Hristev <eugen.hristev@linaro.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761118135; l=1086;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=7XsJROAyaxSz6LryDkWxrJ3XX6JFt8eLkapu5AOerUA=;
 b=Igh3jwg5L9I4sMtXDmWtsC3p4humSItibIXUryu6n41T3gHKWjYaIPtGmALwwfV5doPDblK6q
 uwOP2Ujos34AKxigZErDEsQdZtM1WOAyKY7FkPAZdMuccCPpTxKLVHo
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: zalFjYjgB43gIq4ElFmi_whjbSSji2tv
X-Proofpoint-GUID: zalFjYjgB43gIq4ElFmi_whjbSSji2tv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX+jK1fCfio4hF
 mGVwQHI+KkTOfbxKfrGnk35+T4d9qO7VXxcb9Wfv1Od0pcT/P3/RjfXdwsiXzr9qostGd30Sxn6
 Ns8+EZUYamCH7a0j2V9GnXqMsscntdEXiIJppTFgHGkCaLl4j1kePRrGl0RwADDevb/N8naBj4d
 hYsHOBH+fAf2FWlILDnEByziXDGHLcyEDAvIahsAToifbS5Ns9s7TqSCgYapo0TTn+dT3lTZea2
 iD9TNeLLjojFRIszMAuSDXxHLEavR00+y0UU7Iz3OBCNRKHdKqHhN+3cXaQbJAGPeCbX5/tiB6b
 PIOrHNrT3R9gIEBMcGZv1A/t5ayt1An8YKX+cGKyRhizH80ndxbcWVjpAz0Sdd4GSNZ3RQwAanr
 JZWSBpBmOreuBiMTETcXM8nnQyyvbQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f887be cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ffYJIid-Q94gFHaen9MA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

Document scm compatible for the Qualcomm Kaanapali SoC.

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index ef97faac7e47..340b754e6322 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,scm-ipq806x
           - qcom,scm-ipq8074
           - qcom,scm-ipq9574
+          - qcom,scm-kaanapali
           - qcom,scm-mdm9607
           - qcom,scm-milos
           - qcom,scm-msm8226
@@ -202,6 +203,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,scm-kaanapali
                 - qcom,scm-milos
                 - qcom,scm-sm8450
                 - qcom,scm-sm8550

-- 
2.25.1


