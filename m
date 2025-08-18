Return-Path: <linux-kernel+bounces-773454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E9B2A05C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247317AC661
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085731B119;
	Mon, 18 Aug 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8Fx/2qR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535931B101
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516505; cv=none; b=Vn5cwJnqK4P2Co0/IRJ5ahwp+t8B7/ZYIF/ekShtVB6BjPZi0U2Ac3d6CQLChbuy6hDWiY4gosT+vhvAjPa27FyfE6R+Xle0Ch5WtPCfHDGbFI2+fZWqgJ5e50RQ8KhloymybFnIqEexms4WgUoSr3IkfRlMLjWOdI01RcnIzuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516505; c=relaxed/simple;
	bh=4MkbI3+NYW9NAd/ICB7latFbcvx/s9tGCzhbUxJU/6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0/UBpQWSrhUlmZodu3SqjQD1u5nDPumn1aeWRY7pmehexlfihCpzCQX6p6EKk1w9tmVUWyRGRZPRAk+uP8R8n6S3D8G2q8AOmBb7Cw3+RoWF4cilgSxbxQxKbFXmBIpKCK8bCwx7iMtGI86CePP1CzrrGN+Ds3579LNecjpiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8Fx/2qR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7WiNa011483
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wPPPAuwBMBQ21V/IeDnUe25ncfknbEsC6+w
	xD1Rg/w4=; b=M8Fx/2qRblJLd0D6tYdjgF5jI+gOMhZ/8WIq6o/PCstYIAUzwkv
	ekcEUp4A9Cn0IQCXVYGlpNYSniHB4t4GWeWdVYZ/tQoAga+346wRRgdnaDMDlFD+
	Z8Ta4t5QJQehYvQx4LCbcc77gnIV9XPZFW6w+hR8wcy3CTPeEzd5BiGb4zjOFijn
	Sk6zSY3rru7vJDsMVdHaT9K62rLF0HbpAoMTY0H63d9TRgv406AtlauT3PsvUKNv
	zLu+QsviiDNS5rWhhxXe8WYdN2Bmc263U/nPRtICc5RqD3RKHOm1DLMMguq8FD6a
	XXief8ZYS7PtL66i+8DYwIHGc8XUff54+gg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfvdqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:28:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c5ac7aso109879771cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516501; x=1756121301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPPPAuwBMBQ21V/IeDnUe25ncfknbEsC6+wxD1Rg/w4=;
        b=NG//GIY7YXb0JVuVzqJXx/vEu/LCBHYbMzcBiL4haGalp6vGkeBZBkXyEKJb5I5Jeg
         KqxtSkg+t2cx5n+MKV333J34iR48qUE/gRVFNJC4fSn4Wc/Mb+NdN47RZ7LvUbO4wzJZ
         O85Lfxo9urNG9RKG+YoKcxKq3Yw5F/ghzjGHVlUnq8AofCFZAHKzNDOtuDO6Fudo8rjC
         J1jOMzg10E3j8RwPtK5x0gOSQRXHv+YowB/JrZmXUKlMgF5bF3d2M8EUYbsAz7+sy+7z
         HF6mCXybc78r+tqbN44/KzcXML1We1qEEGdtfL5Iw8twr4AVYqyCP9JH9GDeqmzkU/l4
         f6hg==
X-Forwarded-Encrypted: i=1; AJvYcCW8o9s83U9vJi9bmItmxkYC48+HXW9BBz8LjZDkrX1P/lwbcDAIbq8s0YPWZ2OiORYUY2kkqDEgN4+wkD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6ZjUwD+ua3u27QTm1X4BVAL/GFkMyF4gQ0J4GJmSd6yxyeme
	TYD63wAoedCGhJJOnjI4UX/+7Y+B6xprMmiinyOIyNMO+YAFMSsEOyk4MQBVszOyw6nrXQqYMZY
	gL5paTb4DEjWmzoY6zQawojDB3V0v5NnxjpHCXK5RRjFSJY7/cTyIWtzdCCZ+LEC/mQY=
X-Gm-Gg: ASbGnct9TA+T5bk8hBBM0E3hBArwfatn/fXnYU5y7Yjeo4jnBbCPK+YdDHvlFpLyK+Z
	aY9mU99Chy/L0I/VdRU7gbOWdoIkaHiS9r6GQv1povmXqTVAz7fzKPFj2Ok0gDkeb+QiAKGxdUa
	9FDrOjlHdEgDOnTDu5kDvtzsD/V7q203WG9RQ0Sb/ewNafn4Ju0V6bkyUfgm46Yt7sP9rQFIkWm
	XYsmaxP9p4k9x+CvP1b5fujDbWZ4S4t5uHbVxe2FeaMX0PSY6umVspotAlGhZHckeDxogvKst6k
	ieOv8kaadqxnb7MVVMk/VADrttbO2NiGihEQBkDdxK/qL6nC5Uv2Cw==
X-Received: by 2002:a05:6214:21ee:b0:70b:8a30:ecad with SMTP id 6a1803df08f44-70ba7a5e744mr136126416d6.7.1755516501501;
        Mon, 18 Aug 2025 04:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvYCLxBLKSYU4z3YHAZlz/ozcZEOMLGps7I8qvH7pSBWRbf9LiIs35N//2eK5MQoGG4Lv6Dg==
X-Received: by 2002:a05:6214:21ee:b0:70b:8a30:ecad with SMTP id 6a1803df08f44-70ba7a5e744mr136126076d6.7.1755516500911;
        Mon, 18 Aug 2025 04:28:20 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22321985sm127555275e9.17.2025.08.18.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:28:20 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/4] ASoC: qcom: audioreach: cleanup and statiic
Date: Mon, 18 Aug 2025 12:28:06 +0100
Message-ID: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 155bSPzcQmBFL6PIIky3rLffvazRSs8M
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a30e56 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IKPg2kH8tdNbmVK0Zg8A:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX9s5ynI8pzpNX
 /w3KkOgNyMPQgztlgsmv3QaHdf3PkkcthCSCopJR4HNUSFIJK3eltR0uIs29lRft24ow/384pQ6
 rzf3POr/jFaaIvUDsZayGT5LhwBCEkNXVXJ47+4fcJgN+hcX37eCgKDogT7sku7KSPC6xGmGKOJ
 9r2sncK3dHMJdo45bAK7j87C17PV/E7ZxpTzXRC3dgQKgyhfVna2aTBp87tp/IGaDJJCvPJzAUu
 WWgGJVk6Jg8Yc4pAxkpZnFc1sf6WsYP6KsxYNxhcSaXF0cqG7Px2SD/FDEXTkE5YTbXdfgxTwM5
 78Sadh1JKw/NWrm9YxiiaJgNsMbtjDP5ThmBH1G5pv/bHa4TK8YWxHxa0aYwKtqScGooBQAQloP
 qQ6hAFuC
X-Proofpoint-ORIG-GUID: 155bSPzcQmBFL6PIIky3rLffvazRSs8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This patchset:
 - cleans up some of the audioreach tokens which are unused
 - adds missing documention 
 - add support for static calibration support which is required for ECNS
   an speaker protection support.

Tested this with Single Mic ECNS on SM8450 platform.

thanks,
Srini

Srinivas Kandagatla (4):
  ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
  ASoC: qcom: audioreach: add documentation for i2s interface type
  ASoC: qcom: audioreach: add support for static calibration
  ASoC: qcom: audioreach: add support for SMECNS module

 include/uapi/sound/snd_ar_tokens.h | 18 +++++++++++--
 sound/soc/qcom/qdsp6/audioreach.c  | 27 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h  |  6 ++---
 sound/soc/qcom/qdsp6/topology.c    | 41 +++++++++++++++++++++++-------
 4 files changed, 78 insertions(+), 14 deletions(-)

-- 
2.50.0


