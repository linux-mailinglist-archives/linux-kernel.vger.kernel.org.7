Return-Path: <linux-kernel+bounces-739443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64204B0C656
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4381C3BE4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A41C6FFD;
	Mon, 21 Jul 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L+WMDxcw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171072A1C9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108261; cv=none; b=kK0YD7LfAiRObP3vZxzWS9HWk//Sdti6wqJJOgTq0hhGxwFXwMN0yEglpJ2kOEBbHE5dAxSxuS7dnCalUH3yxEByeby8KTCMl7LV6ovRs0V3kFJ5VnMPTwXh+t18M3Ep8V4lIPR0vLGl/a5eR3liwdSpPBg7yZwD5aN2ZGYgdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108261; c=relaxed/simple;
	bh=fZh+W/ZwxHCAw9UO9J/kStJAdZaEn8DxlAbvEqkaCIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RKw10ANjy7Ll0F70F9nk24FcjJmQlJlrK2WcCmCerC1gRO/0qpTmoIMQFWgvqt70H6lhNU37y5CZ8UbyVJA6mdkenh0IzrrQCaTJUMtfDh+k1H4MiLGQjZnZ1oLV47h6mJc+mkhb0lRSH7oQoyvgnvNk13zhd+iMalREzBQCJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L+WMDxcw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEK2R8025434
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fB17acm6tcauz9EWmhrWe24ExKFYj74gkCn
	0R6MI3YU=; b=L+WMDxcwc2/AOpU7X4q3PWQ6UfG2odLvmQgoQ5CBCefVM23hI2G
	nUg2FjsGEI4iE3ygzXqho+/6BRVqxyNjslqWbmHsggHzq5OA4ORsbXavHwfvLOXI
	yeiRURCZ7iJ7hcpVTLDqnhgAuSkFLq6Yh/yI2uZ989aru0v8XZG5zdkVkFP3bYn/
	n3C4hF0lNRKfbNdDDJRP3D3ZrhNx3z3UjiUVb7XHuEtiKyeYWA+0CkG4I01FPEJu
	TQzWEeJBP67MCQrbETx6qPr6ROieyfPqPzZ98wkJObN3Iyf8AfcM0cT+Xj2Tbinn
	is8TEITIYfGjLhu4tj+QBLYftbaKy1+Ik8Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vvyg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:30:58 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso3927328b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108258; x=1753713058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB17acm6tcauz9EWmhrWe24ExKFYj74gkCn0R6MI3YU=;
        b=tIJOgBRr2xozmMekKlxDdtIUyF0qW30ursg+ztZ434Dg376xAYhtRsgUmF4RVuDDWn
         dTmVfPrgd9D8pDYWNF+dAEZ2i7wUKyPEH/qDZ1wXzB3Jd7W574B7Ap1sam67KZMFJ9mM
         ng/HRb9kMFUycfAHV/QxCfgBDZCVpld6UT1se3ZdVmh8pnBh1HdCs9Zmks1R2YcW8UnQ
         AICGq6vq8ycgV5hpJOAcqP74+fT/dBadhISGW8w1j8EtLgAm7BEdiWzNmRiRxfCKtXxI
         5H5BDxrDtfHESXhb0YWoU/s9shJaNrySsIWxbiQRirPO7VBDvbMnshsaS7oZChlj2fqT
         3sEw==
X-Forwarded-Encrypted: i=1; AJvYcCUf33o7cMUI204dHN+BrfT04JzDqLvadoFTXZK3LSj7VS3/0GajpU4/s6Q5xIV98Sh19jGjmI1aKmuIpLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyicKUBy6fQbWMDYfQvZBpf8r4cSnfFxPDx30rFVAsCs7U21UUw
	g2rnbVgGhdD2jTpi9y274N0awDsc3r1CNI6n5Y6yuJAU4tXxdUkztmS40MEJbjP8jwA3vfnohhZ
	+LypwYRBP7bQOIt7gzTNsyOx15BmQKtOaHR87CoMuRQh9xbVn7AFdlVvle4O+gclQVRY=
X-Gm-Gg: ASbGncsQwinbloyo5txEeD+AY3fTPlv2skCSZGq1qgsclJxPdSqsGBLYhhO0YuefyTO
	gYTGsdEiY8u2hCamhv4llLCYIM8bRrMjVcvu1ogVTsXzaJpbHUpPmAwyT+aGvS4qpiaKEs2NxAm
	YPtIomKM7srCkZmYmKvWicBXs6ZzSPBQlHANZ8YNPV1oI9wHr0gML0wWK8ry82+uJgdqPYB7VSY
	Dc23pCLHEgjTNc2wAtTkLwfz9TN4Ul8vUInx/4NxYJs1UgvQKgL4QbSUwQ3NHwikIStK8nEKL/U
	e+TFiSCdXG8KldxvUoXDCeP+iYxwyWzyLou+CodSwZsRE09oNCZKoLTVvOMjX/uuBvsIL6OI9a9
	mOYqtcVn/Bdm9MPTa6qDMOczQcXHPE2H3tUK2CxWOPR2uiRmT7FVbrnqwn5kU
X-Received: by 2002:a05:6a00:3392:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-75722869545mr25840346b3a.6.1753108257990;
        Mon, 21 Jul 2025 07:30:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG6I7/YN/GntNBhpwxtH5G52Yy/1kSXDgvLDtnnNoxskhMPb+YeGocnDXdtpvZVJoL8l6lgg==
X-Received: by 2002:a05:6a00:3392:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-75722869545mr25840277b3a.6.1753108257287;
        Mon, 21 Jul 2025 07:30:57 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e1asm5750110b3a.74.2025.07.21.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:30:56 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Mon, 21 Jul 2025 20:00:35 +0530
Message-Id: <20250721143037.20983-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687e4f23 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=TVyXueylgh4vxAmsgxgA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: CkHvBwbY2xv-DragpyZrBMy8ydVzhJcm
X-Proofpoint-ORIG-GUID: CkHvBwbY2xv-DragpyZrBMy8ydVzhJcm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEyOSBTYWx0ZWRfX6ltrpeJXk6VK
 V2AAeCTxLfBxqQVCCl4uW3oK2LfFxfy7ncLGu/not7ipqbgYfNBXAR/ej7njD0cA+JkJF2M9bvs
 uQH60TBQo7F75Ij8t07qx/mbLafsSeYLFJ5bf7D9mjbcXZHR9f7HnuFiPsHsA/Jzk9On8pkoS2S
 4TGCrKRz3rvl4UHQQCTqYdsVBXKbQ+CGJtqeGDuWUb6a0ulmm3qerxejjxWNAuCWK1GUIxOAiOT
 jnKcr/dPNRsQwERkVjTJVwADyA0yQMcyjqSfJOc10Ij2ThCMLILiLQAfSseY6dQGeJqgg/JEEHx
 8p0WqoI8p3y50wfEBG92oIu9NSpEtEBhqXwy2WxdtHbsS4jF2m5H3wPZS2wjDAwI10uOU5e5orB
 S5V43crgNBONCJgELKlcH0JMTaapTHNMwV4Klrpp0mYSSRJuO2vn+a1JepOeEEdwEDcz6/dT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=888 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210129

Introduce Top Level Mode Multiplexer dt-binding and driver for
Qualcomm's next gen compute SoC - Glymur.

--
Changes in v2:
Fixed dt-bindings error from example node's reg propery
Fixed gpio-line-name maxItems
Driver UFS_RESET macro updated
Removed obsolete comment for pingroups
Updated ngpio to include ufs_reset pin

Pankaj Patil (2):
  dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
  pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    |  128 ++
 drivers/pinctrl/qcom/Kconfig.msm              |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c         | 1777 +++++++++++++++++
 4 files changed, 1916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-glymur.c

-- 
2.34.1


