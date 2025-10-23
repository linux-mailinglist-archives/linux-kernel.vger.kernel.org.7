Return-Path: <linux-kernel+bounces-866212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25D7BFF2FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F75719C12D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7725F78F;
	Thu, 23 Oct 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OuEeMT2i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3562475CE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195474; cv=none; b=pI7OPSr3JGSY1/XAK5NND+D0ZtZmvYYmOjH4GIwYb3du/nzAqrilSQN39k4qgxdYT0y3ryWZ0iZeW1lZdjDHQMBNUfkK50ODchajGsLSPVYSooNMVPE1iriQ6oMJtrag42hiLvMGCjRV5cOMRjS9mynTVyEIHnHs095d7W5xpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195474; c=relaxed/simple;
	bh=eJ7Y5VSwo4ss1PtD516LDcXHrGyKt6PZu+aZj51XL9g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nJU43QE+B7McgSDYuI7Y33CBEHOkKld0iePfevHQZrUmcIjGIreB9GDX29TMDAWvW2tAyNTfc9/ZPS72HdZCDPv7TJ027B4TWb7QK3sShvADnmmWFLCsY3DAlQ4dXq1hX+v0Xvpx0jgerLUymT2SIvb/kNojy4PU+FC86dnEbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OuEeMT2i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MK0rCN026316
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4uQ/De1Ln8L8ulGWOV2no8
	d6dEvtTp0uEoplF7rP/UM=; b=OuEeMT2iLyj7zfZAcImMVQ8LdqeGeVUn+zB5ia
	Hw9EADA6ivalJEVi3qqDLMuG87KAJDQ2UwQLPVQNefWvwL6+Xrqg3zryKprXlmuV
	aCj/qTpIEz8KiEw4+T8cZonLSk9r8lqNclx/Fjtq4bOIApsIZAF5jdmCUb3j6DLb
	Ao7oAFGAbEP7m9qzbSHGNPc/xpbPalUzIMnPtlWNcHgfKqyMwOvlf71GY7lLcMxc
	tLx7XhRRk7Dv+QfNCBlfFX7TzJCrceHNHU5myBvhN7wfJ5MOCzD1EnL3lotqta2S
	SO7G/2qOfkGbJXK67o7uWoXSYns8fg6hxYwCEG++J1o8TzKQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8h42d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f610f7325so344539b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195470; x=1761800270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uQ/De1Ln8L8ulGWOV2no8d6dEvtTp0uEoplF7rP/UM=;
        b=D0Yfj3cfsya/LLgwnnvui6UciPFE4xZhX40lpNSpnTupTk17xJwAWwUe9lyekCoZUb
         ifRczf22gcN7P4YrFSpgy7/Cr+ignI6pyC2f85tsgPwg4nhNs1DkwN8h8BGs3Ic9dvJ3
         E1cPUYjxjJM014N1aXDQO/+w22CskbpcXogR1IJjXcMsEoFibWdwbxBjEu61Cv1GwfEw
         60LMFp4lqUKLK24TCP62cTvd0N3nMNow4NhDzNTIiyXJc10PM/OxK7RrLDJ3538DCxCF
         Ec27FNMiBlhjOkANcqI+1Gpz4WN1f1sl8o0SMueo/OqLygVLpdNno0hDoY52uSe7tOmn
         B0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWht8lVD8ma8bQKT60EoqImm1Fvfd+nVsbjWnKTGDTbDnWY6mY9ozIYiavajCiOxMiOxtFKsim5H5M+fQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpusAV6BJ5/ZMggKPmMGrek8PbzgZIRXzqI11BRPQxpFuj/s1f
	ah6Fbscqa+pAm3XGvCj8kFnsdz1JODI0eM1XP4ZSy2OV2z1vv7LSQaqmjYEDYKzZaZf9TS1Sr0h
	McWCxK/j0oh3QCh07LyF2WQ1jCWNb87hvIUpl23moOBPbfRRbIOyg916p0wcehI01aDc=
X-Gm-Gg: ASbGncvUcrNHbLZhdLhM/Me2K7Db4h6ASt3DBZLkuWxNEF/A5im6jFrRfTydLVARrpy
	AJlDEPbO0j6gXK1kWx6Ex8dgywX3fzrs/RqI3axJuDA+YViIXdU3htGeQV9/Ldi2R7+TF6ya2/e
	7Sy8a6BrmvExGhC4e2I5hg6shcqlx0CosdjsZy8Oxdz9PkEHsxgD7RRsg0XglPsFId3YXeKOErb
	ZhpQwlBxBYYo1JT9oPAu0xoAmVXicQmtR8lp5oMdFhTInbzzT16ZYU4DQZ5SndXlpGMqiloFQK1
	4o3JyvFnGQAB2uZlxXKurssB0buOt2bN1u9LY2Edjpnbhne0WZ7bTHwYr3EzJgrZFHl43MRz5v6
	wsvyFJyouHGopreSu2z5xMy4XIwH4+/HiIY2I0S+u6/KZIY3Apg==
X-Received: by 2002:a05:6a21:3086:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-334a8611cdfmr29242012637.34.1761195470324;
        Wed, 22 Oct 2025 21:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqZ8VAhBRbtmgIzX3pXjSZr1ekf3A32HB7rzY3mUQ56n1fbN01Nzd+vDSQoWVzK469z6n2Jw==
X-Received: by 2002:a05:6a21:3086:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-334a8611cdfmr29241979637.34.1761195469877;
        Wed, 22 Oct 2025 21:57:49 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm814289a12.7.2025.10.22.21.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:57:49 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add Qualcomm SM8850 socinfo
Date: Wed, 22 Oct 2025 21:57:35 -0700
Message-Id: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMC1+WgC/02OwY7CIBCGX6XhLGYYoYqnfY+NhwFGS9SiUJvdG
 N99ob3sheRPvvk+3qJwjlzEsXuLzHMsMY114KYTfqDxwjKGugUCGgWI8jo+ZEk+BukgWNoZYut
 JVP6R+Rx/Ftf3qW5HhaXLNPqhGdp1w4ZYppR/l+KsGrzIwaL+J5+VBHmmAMb6HnivvlIp2+eLb
 j7d79v6iNNnjWZ+vuq/p7W8ZhsUp2NHRNbvjAHXQ+jR2NAzHZxSe0OBD0GhRq01V9nnD+JSK2s
 MAQAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761195468; l=720;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=eJ7Y5VSwo4ss1PtD516LDcXHrGyKt6PZu+aZj51XL9g=;
 b=quWZ0dtJBw4mgDgA3O477qU7bj/rsWlXk1U7Q+0f5WO4RQGhEgAoHgfVXdBQyMJIvE3cg/STS
 IyfLyvYVdmlCCoHBCXg6TkNPUSi3s9HhYWEf+oun2NZrDAZ8anhgvCF
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: Ryz_oyI5t5dZFZZran72cdKHzbfO9S0R
X-Proofpoint-GUID: Ryz_oyI5t5dZFZZran72cdKHzbfO9S0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfXxRHpJ3BOhHKP
 EEBM+yrxUJz6CiLf1qCVNgf3Us3nDLpMt09nJsS4V+L47n5AyVYeLOPdlZQT7I4RhKtIIbGGwh/
 xD2E52Lq+0/4ZO5av733E8grNpTVmGxsnBsKb/JdVE1p1T2DrAgoLA2waLBtudku84wp70Mhu6Y
 xRqBidBMplYBzGakIvfe3Ron01iTKa5m2Raqk0wejqfHfp6UcQP6ykGEW+eQTOc8zSCIVK6j9mM
 50YgNv/JCcrhC02OWc0NBZHaRrJL02QPL1iYL5psIJlNi4Txo9q+L5Uv8FqrmrAXTh26GlsvJWW
 FgJvKHej0TXBkD6723Bu8RO8ggd7kkvspKFMhxgoPT98xNBlewIjsfyneoxeWKqAHf+Febgy5nC
 tJdRBF22OH3d+32GP0AJywKts6/M+A==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68f9b5cf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CTwZ_wOYRK3Eq8s6QOMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

Add socinfo for Qualcomm SM8850 SoC which represents the Kaanapali
platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- Add info "Kaanapali" in the commit msg. 
- Link to v1: https://lore.kernel.org/r/20250924-knp-socid-v1-0-fad059c60e71@oss.qualcomm.com

---
Jingyi Wang (2):
      dt-bindings: arm: qcom,ids: Add SoC ID for SM8850
      soc: qcom: socinfo: Add SM8850 SoC ID

 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251022-knp-socid-b0d9a35ae9ca

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


