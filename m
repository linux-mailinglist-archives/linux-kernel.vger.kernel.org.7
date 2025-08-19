Return-Path: <linux-kernel+bounces-775272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B904B2BD60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B58B5207B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEC31B129;
	Tue, 19 Aug 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g80EQsmB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2026B74F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595620; cv=none; b=iKeOo4QZhSkGXbPy4+4s3jBZAXaX4P8/3CZVibHk7TKkyeZmXf4fwgK6mEhBdczIfSpuxfHSZb1DhfuHmdATbxQZVC2i3LxF0ytgQF6xE0Vf5xOdvPuvTz0mO+uLXJwVApH5XL98oXzqfm8neZWWBzzoOhqF6FVJsO4nVuEjq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595620; c=relaxed/simple;
	bh=6GscCOCmisZTiVBfFfxxVc0dHspdhAW8+DH/P55nLlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjWrkfVHJ16NcXnoRMZFc0Kj0OAIGAxdTVzKTEnHuu+ya3Hwg44VQG+Gyicr3NkdzeLZcO48Qu09gKSaufZpLFbH3O72Hku2CHeGtuZ5AMyQz0NmzD9ep07/RCxBUnz9kiAdBwWKNpAalKuyKh7qVEo74a7Kbom3+FXoxJSRULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g80EQsmB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90Ziw018043
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+YPBn86OFJA4z22/KeAbz4i2F1zro6Zj3rE
	nwMnF2qM=; b=g80EQsmB2URX2cRDs04qdDDphpiAhDj4V+eQLJWvJyGP8NO/T16
	aPSaymDcAvJF/2RjcYu6hCkH5FZ43L3yJAUGUMsB6tkOGOrqOvHpFvBzQ+gC7pGR
	9fe7hj4aB4yZ+LW82WGFB1snxw6NsiNgqJw1mAVIaxwv1xGijjHv+Xh0zpzcl69R
	U7boAIhmIfNy4ETFQ1v0PV6cXCmSIg8QNEY1fVZoWV70IBcPzIbcYFFrFWsX4ZAK
	pv5MqiQRwBUWoVz8MB9mFz8az1ZaQfEFQ9FDgz/qzF4fGTR+CXDF5pahqgZuGgFW
	jAOTTbWy33kjZ7HGQPs3wilIQvihKOh1E4g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagywth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:26:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f57f950so109909476d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595616; x=1756200416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YPBn86OFJA4z22/KeAbz4i2F1zro6Zj3rEnwMnF2qM=;
        b=MO6Gg1r13Txz5hqutVttZOpBveSfjY0+3f0XjLBbOhSHy9KC1OvC2cTd7tXRCmM8zU
         GI3+9ymqG/ADOjtSeqFrYa69vlo/EUX/O0/K+66tfHyDY+B8/8aCltFIyb9w3HA9xjgZ
         jyBCDBN2V/ccGToPyBi6jWqG8fkQBiHfi2Pa7mi38HiQagB37/5iRG8pt/thyplqBe5s
         Jm/UWsAyOgJ0EABFxnRCdiTiL2CBmqY9Jt2+zrG8lpuyUXeuoqRxEGa5UvTld+6h6Zk3
         b+5ST1Az+0H6vaKF/qqU9FXoXJf4w+5vfmYks1Kd3Guy5kYH0qTWc0bGhJFcW+S636hE
         XzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoVEdh1NG3LJnJ6XQ0f4LbWQfOR/TFRSmEg9TKsNY92isqZ/yRfN1COYx39Gq3zHmD0h1sh+nrZs+Y8rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTzGuNLtn9xg4rX43BVr1Al7MA0raJG4WySRdh8zdPhI4DVqW
	fIHRZPNdD79ZCluyW4B6Iz29eeRk/+NDIud3SXD3b+pW/HMsvtsoF8U5TpxJhfY/OX1pFSDcdh6
	6GzYyqu03yg7MbN4htDBCrHV3j8SufM4hntYDMrNyGJxvHOp9RxRq/ticXL5WeIj9ILY=
X-Gm-Gg: ASbGncvcIBvjqS8lwiFDCW6S5Bq5IzODSd6MSGiDQ9Pa9aBrt9gsDXJnWP4QNWsVLhH
	SMkDA3T1JdkmFhiLQLYOpRCrMpufqwO3eJBRPBu1yDjLURkN7rFIK3WOJlH/zrwDJlOlMqD5K93
	P8hrH/UCFvfxTYJARkzQerZM6VXXn7woQqgz4eWTfrJpN9nNlw5IfmPbzGQ9SD9FzjTkL95taAz
	7sY6pfGKzF5c70yCPTxZHMsuBvDbBDFS2hOd76StIJJl/BtXEHHbmkwDiS5NqZXwauTzeuK7/to
	uwVLYelELmZHTTdvqIph84XFZfljzg9fdWTMmichfuEkQ/JKpk3n8Q==
X-Received: by 2002:a05:6214:cc5:b0:709:22e8:af63 with SMTP id 6a1803df08f44-70c35d3b192mr16724876d6.43.1755595615715;
        Tue, 19 Aug 2025 02:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0MfiMsbVwzC+4oeXG9E0aKt6J0XkgKUpLg/D1cp1Zaqk5taa60r7RFcbnnFW1iR4JFSX58g==
X-Received: by 2002:a05:6214:cc5:b0:709:22e8:af63 with SMTP id 6a1803df08f44-70c35d3b192mr16724756d6.43.1755595615291;
        Tue, 19 Aug 2025 02:26:55 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077788df7sm2942284f8f.48.2025.08.19.02.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:26:54 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 0/6] ASoC: qcom: audioreach: cleanup and calibration
Date: Tue, 19 Aug 2025 10:26:46 +0100
Message-ID: <20250819092652.1291164-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a44360 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NU7b6h4jXCN-HWJItUMA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: qjI6GWuwhMBwMQVOQECm01KmzmY9Qhwn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfXzJakgQ1vAtus
 4IOPffsXJoVltgLiZqdeyyiLuEVGcRPEmowpR8P/4PC+EONJhlJHC17hj2yYmdvU9wz2CX2EHYZ
 RWBlIJ1cF+P/Jy71gDpKNNMKpqSmD0q7v0CBxgIrjyiUcCYuZsIS8WFxw2O77TYihow3I4kuvMV
 gaO8gXG4VNeuyQNxFxlLeJDBAwpr90uz955VYYV4xuNawoFkQ3EJUdp5Ix3zS6gvDMCgVo9dAUe
 Fdbpl6oNdxShl+26wgTHee9PsTrgByeJylY6IdDDT16dic47WcLzT9jG93y0TU5JgoOcekVHdHP
 E2betwRi9Hcan9qoU28l2WFx0w+muU9HG0KJXsTQZPL8HqA3Y32MOmECmSSXwZzZnxbNmQvQI24
 VtwJy/1p
X-Proofpoint-GUID: qjI6GWuwhMBwMQVOQECm01KmzmY9Qhwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This patchset:
 - cleans up some of the audioreach tokens which are unused
 - adds missing documentation 
 - add support for static calibration support which is required for ECNS
   an speaker protection support.

Tested this with Single Mic ECNS on SM8450 platform.

thanks,
Srini

Changes since v3:
	- added missing linux/types.h in uapi header

Changes since v2:
	- fixed some fixup rebase mess.

Changes since v1:
	- fixed typos in I2S_INTF_TYPE
	- sorted module defines based on ids.

Srinivas Kandagatla (6):
  ASoC: qcom: audioreach: deprecate AR_TKN_U32_MODULE_[IN/OUT]_PORTS
  ASoC: qcom: audioreach: add documentation for i2s interface type
  ASoC: qcom: audioreach: add support for static calibration
  ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
  ASoC: qcom: audioreach: sort modules based on hex ids
  ASoC: qcom: audioreach: add support for SMECNS module

 include/uapi/sound/snd_ar_tokens.h | 20 +++++++++++++--
 sound/soc/qcom/qdsp6/audioreach.c  | 27 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h  | 18 ++++++-------
 sound/soc/qcom/qdsp6/topology.c    | 41 +++++++++++++++++++++++-------
 4 files changed, 86 insertions(+), 20 deletions(-)

-- 
2.50.0


