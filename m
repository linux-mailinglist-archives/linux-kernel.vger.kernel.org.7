Return-Path: <linux-kernel+bounces-733800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE737B0791B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEB5178846
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409F26E700;
	Wed, 16 Jul 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShQTeKNX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D9223301
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678523; cv=none; b=UFRv0FoiYRqp7hiy10f7kypgLSts2/dkaRi1G5dtnRnLONYvKx46Q9J8MLrd4QUK9LrPDgtq4aeFh1lD2T9hu32UAfL226CmfJvGWwVozBHGAt5nRaLa1x7A3rmkDK/g5SUJscqV6Cjg5+Y4hjIBvYE0hBtvzRo0tzoWhXHwpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678523; c=relaxed/simple;
	bh=G1nVliCnmzaZKVIsXaaQHYG47ZKX9UcjtGfXLbv0qb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QxhU7hYzfIIhfl0O3qknX3UH3qtUjFtluEJHwVoVYGlAysJbFqtCVxGixxPvceMHJvNnDZo9hLVs9mjM4/Bvw81dmQ8zDltETCjD5yXqhf4BJ4T00GOFSOkyTTv506LBeC94GJVZZjFDW9S0camFomtFMcxWc3RD83unQ8ncRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShQTeKNX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDHm1M014528
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jF7y2iBjbtWTZClVXRgp0WACQ35CdQwsZ8I
	Ng6WcoeY=; b=ShQTeKNXcaiKrLYYTo3KDSqtHT1xLOqi9m/UGbMuOxg6h+w8D3D
	XIwL6+rS3SB+sHZyd8DJPp+lFtd38kkCqkcWFQOfF/wfxmFYjPqKYV2f1JILmBaV
	4kaqvB9FI0OxUjqSYtgz3/wikS5QjaDKTkCChTBGbORv2mpQ11JzkLckoOJtoobc
	DKbxW01W0BbccrGQvUUW085wITmjCMhnhXWW5mBN4eNjNNAtGWMX9h8kUJIR/KYH
	0F72iOsseBbVHIe2rLS7g6CVkF9pPvMOcxxNh2cgQz1iRwZ40srW84q+R4XxZTr2
	tWiRiskxjccoWL9VZIZIS5GdafeUM8ST+XQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dyqbrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748efefedb5so15071b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678520; x=1753283320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF7y2iBjbtWTZClVXRgp0WACQ35CdQwsZ8INg6WcoeY=;
        b=NNvilKzcJ649f0fxEDBu8idmHJbT6BxJbcUR2+8osvCDkNV4GHxZ1diqDzoYdXOM+C
         U8WQq4+wr/uVd9iWU/3/fTJSBoiXoACOotuqSaUGIE4m5A4bRrlxtR4bykVGO0dBFaoT
         KU7U5aOTdUsAoNgyhNamReMBGwUdNjrOzwdEM8tB70QFlVoK+XhuyTTdMkfDGlz6I4Mq
         V1FmajqBhE4BVaVuUcAGI6rJtMHuXdmkXTdFAG/J42OV67gsHOWIO9q7xnAK7rFEcC/N
         /3TvAKUy6fbZ8aij3j336FaLR13AUuLPjIXPX5LAUcO7Dz5jdHQZbHWWpFldxkM2OQuJ
         U7nw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vU58e8Qkyj07XkdIXwXgOBOwfohXWUKwbQon8u0MZPhggyqKGLMLghKAklYnDad5c9VgmScep9fLNpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YtcavymIZ6qEpFhSZP7p/zAT49krr40Ozr1ogkcMw2Piwq9X
	IJHLafZI2XgYqEdEHlLp+kpy6asLF+flv/+1v64pl51LeWfYYtAdAQ6cf9dKxacWrXaPXi8X62Z
	zclI6YJbXEQr7gF6LPMiVNanUg6Xi4SZ0DnCDohTGMltWnoowXE8Z0GTuaAPYLnI0vPU=
X-Gm-Gg: ASbGnctni9uoGfQ3jNMtwseeN8WoQrfhwuuSRaSipsnez5vD1EKTN2woyArVaS2PHAL
	ulhT8t6Vfi9q53VukvPydPX8TyB4jcdExTR/308Teo/j+9yV4zH2XLV0MdDRvKj2fD8cJvlYfJz
	sbaurcfn+A9M5uppxcCTwSMtI60RBEAg/pkT3h8cMseDPBPetOElsCvFeAZmtKzfcu+DPI8ifIq
	a6ph+wJjO+VU4K9h6l7s0ntI3btplY+Who9ZV5vRFeYD2FexfmMh9WnSK4qMUME7DKd5FuyocJd
	DZ3joK8QzJ1+na58IuQFk7JdvG6S+5qgkQIXGqAx+bVW1CyjB7CUe5UpHp9Tm73DiNebeu6u80O
	/NcB1by3w9Q0yKbyY5O6rdQqCTDksLHt0rTugPIS04TjtzgRBJuye4PrQsImM
X-Received: by 2002:a05:6a21:a49:b0:231:acae:1964 with SMTP id adf61e73a8af0-237d6619ce6mr5935022637.14.1752678519786;
        Wed, 16 Jul 2025 08:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTljLIiwrNjfitBK7JN+xDDjLzDEY+wWl8eWMhJi5ZOmlYuSdStPElcKVWfC4/fzhmq/TqVQ==
X-Received: by 2002:a05:6a21:a49:b0:231:acae:1964 with SMTP id adf61e73a8af0-237d6619ce6mr5934984637.14.1752678519318;
        Wed, 16 Jul 2025 08:08:39 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f56a9sm13713112a12.59.2025.07.16.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:08:38 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Wed, 16 Jul 2025 20:38:20 +0530
Message-Id: <20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FBtW-r8BxZT8FLoQqsiDRTpvy7Z5AeUl
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6877c078 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=5822FIV8dQAKtubfUrIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNiBTYWx0ZWRfXxiUUMIfNm1kh
 MyBRrHIUphMPpd98688yLG6uOC7PaQupsdOzoRPYMnS5TudiA5SZ6xSJr3G8K6OoraOYSpw2w/h
 s7i9frOcOHdMiLwII78SXWO1d5RTLCc/0hXL9+ZgRmgh9MmpmEFvBX1vzTTHtCULA2+NsuBREjO
 rsdp98BIWAci0giMMBbFPYdb2UEjG0WDLv0KraeYCgor7laPNTrD2ivA7IWYy8HAQz9gpa10pel
 EaVE1WmWcchhDkqTeef+8+gm2VlP67rbji3AqgUjmWFYXq8HXY1DAl2q0PQTbBnGzCPAlZRAvTA
 0BsOEMji9afW5+mFQ8P3nKXQiJSMPUqNOT5tDh5Um807thK3VxW3EpxqzX95zav1Oa58JtYZTZH
 KHpEW/niZU/Yg9cRnR/tL5dlwom6APQjpirQ4YpJ5nfFO1E7sThKj47erD/eVx68d+qXWiea
X-Proofpoint-GUID: FBtW-r8BxZT8FLoQqsiDRTpvy7Z5AeUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 mlxlogscore=803
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160136

Introduce Top Level Mode Multiplexer dt-binding and driver for Qualcomm
Glymur SoC.

Pankaj Patil (2):
  dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
  pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    |  167 +
 drivers/pinctrl/qcom/Kconfig.msm              |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c         | 3201 +++++++++++++++++
 4 files changed, 3379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-glymur.c

-- 
2.34.1


