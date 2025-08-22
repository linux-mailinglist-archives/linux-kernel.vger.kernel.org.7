Return-Path: <linux-kernel+bounces-781710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F2B315BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B946E622516
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B062F6569;
	Fri, 22 Aug 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iD/8nneb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB6222581
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859773; cv=none; b=t2PvM2t3n6cL1Dz3mCbuw0FZwjMoOqeSkItXHkSrvlgl0Ozg1mnLypDGqhd27tKZraYujFQ/k78UV9/X6dJUmnv2JwaNxh000GISBnSQHwF3tjHiRqMagwRcNQPKBr0w0Vc2RBuGUYe0XzbG81G6OnaYwMO4+NYOYK2MVk8KVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859773; c=relaxed/simple;
	bh=5fIDqUXD7VH3UjC4CJNLxMKxI+lpq+RhyAKwbCwSPLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvDv/0OPpmHAXaqa2bOfohFUTanPhTFjvcTdNo+e72Q2IArK8Sbgd3lBjN82ZynIwe8B2q+to7lyv9DQh0fAGVj3F4wga7gHhGqAV3WQ3RJttne/r4UvEnuq8Cj01W4Du1NtScdF+fuz3ThD81cnYOyhsp+G6S+YZHiMY7mjg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iD/8nneb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8USO7021815
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qRbHDqa0iBJlBes/7NLPxU6bvmCGkVDi6QR
	TTiOXynE=; b=iD/8nnebEC5S0WNQySDbG9AZFvsvYK2nGds3/Gs4DFdrOLuWiNb
	eJje1PbS0MePv70TEFRpK9NTHsEgUy6B0dZxaEqkZ2Sf0Y8YP3VFyqMBQ0DDFggu
	9+4DVr24khC7+E7l7tJlENBn8dWZ91ZLDw7FlZqvXOeK42DcJC8FrNQ7lf9ZLcPw
	wsabwiUBv7PCk1R8WLQRU+upl3FI+scpfCq4Uw/+tscY7PrOSs4faXo4cxnz04uS
	5Jn9CW7eBa2qvdQRqg4feIwXStcxvkHRIaj0sL0uIlnrOs0Yq1xM7KTDvWLRqWUS
	iobEc7KS5mVc5dcnPFh1d40Xf55KaKkwOjw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a8yjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:49:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70d7c7e972fso25293036d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859770; x=1756464570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRbHDqa0iBJlBes/7NLPxU6bvmCGkVDi6QRTTiOXynE=;
        b=CvogLTIuLkSU8Lw28Oy77DN8WBdb5OZy7aDkNqo0oU9fNj1TAHRkg2myBv9WvKTgxc
         1NXJsdvZEsGfrr93ccCAjgi//GhGEQTRgXX88rVNdop6dEu4aRbqqT0D6/t5EQU1RF39
         eDEIvFZ8TS1A+H/WqZ9cZJ4z0lR1XgsBh5fwZ5OwcijHly182eMwzg9iV4kQScYXrTX+
         2jmIi2Y3dOV+fVILPEp/0+gXAe5eo7y/W/Xo5LAKDpo2/0d8BzpKMhyCwI5agl/jDO4l
         Qx2emSH0JrG5L7QRfdaAkkhiLJdbFsr9Zc+3Yh73FbxxuJal2qlZBOWFVu2M0N/3nfob
         odlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw0i0r7cr0WhhWqRvS7fxN+lKmYQQGkRDDohGpBZolKw85khpM/fwy0am2nE1aayVz3pjz8xsYnEMEeXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxbHO0+uEHYxRdK0ceD6wHjTvUPbF1HGSapP+0xQiGcgFx+US
	ReeDct+miqwnFiTIcKgDt+0k9cTh3wuxVmCzrHtU2aqxzrapSr0sbByCEk46G3hNaYmqWQ3oQLf
	6tZCyHRrsrNym+Sv9zXgsKDgDdPrOSDUG8g3OokW7Hvwqcqvbm7c9FVUC4S4hmfY0VIc=
X-Gm-Gg: ASbGncszHC+LuAhHTsmpC8acgg+myqgeXXEOmUkdb7DizytJoDxstt3OT7Yt9pYKRgN
	EzE6Fp5vnF7EHVW1oAp9y0VKQBavAMPa04GN4GUc4fs/dO2gWM7VE+FaD5RdlNLQHxwYMbQIH0N
	n8CndAWkUbxJ8Q1LCB+E+D8hrb0LKh6B60+oquMlS9JCCI18Z/Nxsy/W5BGSXtmTlPHDjAGKVa/
	E7TYiN4Tkgud4SRzhXJkrf/sW3XfWwXx+nL8dbWl7S7mN+VL+5aQ5WOMVHV0OTLfEPqgkKGvnRy
	7aKP/zgh4nb0J4D9uie1oY2eEVzVajQB1vbPeebqvQizdLtKxkL2YQ==
X-Received: by 2002:a05:6214:2a4b:b0:70b:a4d2:3687 with SMTP id 6a1803df08f44-70d972c386amr32858306d6.21.1755859770300;
        Fri, 22 Aug 2025 03:49:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFbCYwBV0hsfVBII7n6usWQ+8TYKIMX2RYMa4Bcpz9aak8ip2JM33O0NwdgVIs7Yh1wuYysw==
X-Received: by 2002:a05:6214:2a4b:b0:70b:a4d2:3687 with SMTP id 6a1803df08f44-70d972c386amr32857996d6.21.1755859769774;
        Fri, 22 Aug 2025 03:49:29 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50e4249bsm31367155e9.25.2025.08.22.03.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:49:29 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        neil.armstrong@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 0/8] ASoC: codecs: wcd93xxx: remove code duplication
Date: Fri, 22 Aug 2025 11:49:19 +0100
Message-ID: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a84b3c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=OLL_FvSJAAAA:8 a=DXjLId-kC2nHtiOjzpQA:9 a=sPFwb3Qtu_UA:10
 a=kl_IBrakYWIA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-ORIG-GUID: cBFCuKycbBZHZ_F3qgp_Hw_W4cHty8fT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXwLRoLpQ3prZI
 tCR4eKE/2QQVk2Yqv1KbLmJaZbIQFphIr4wcOQJkjmddBihMb3CMx/l/w1BpjiwSX3qmUEdveHh
 9TrVXGFEb48x3MzLhkEUFyLeNxRcgNSa9M1IH8C9fV6ccTLGp8i0ri6DJIM0xgZrgUy15f7yDP2
 9WDnywLIZPUWcbrjr9boMgUmn+Gd+91O91RNRuRBybdUrpRaAJwsuAqVeQoLkv6oGsnP5j3Cl2E
 xM6mw29lqsYlBhCzN2cGzOSX039Sn9ocs7A+iGqW79KNHFzsBjpCLxxLlPXccHHz9wZIJV/kLsj
 MvRFGkdcnLP114U4mYdR+SeJP7exVHXVLrO4Y7EEs7I5T0O4fXJnR5shai8+Ga1gVHmTXttNPlD
 XEZt6ghRpnCOcMB8atBE60GLQAKDmg==
X-Proofpoint-GUID: cBFCuKycbBZHZ_F3qgp_Hw_W4cHty8fT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

All the Qualcomm WCD codecs and WCD based codecs have lots of code in
common, resulting in lot of duplicate code.
This series is an attempt to clean some of this by moving the common
code to wcd-common library.

Currently I have done cleanups for 4 codecs wcd934x, wcd937x, wcd938x
and wcd939x, however any new Qualcomm codecs can avoid this duplication
by using the wcd-common library.

There is still lot of code that is duplicate, but this is just a
starting point for such cleanups.

This patch depends on the other cleanup patch series 
("[PATCH v2 0/4] ASoC: codecs: wcd937x/8x/9x: cleanup") that was sent few weeks
back: https://www.spinics.net/linux/fedora/linux-sound/msg25202.html

Am happy to merge both of them if it makes it things easy.

I have tested this on T14s, any testing is appreciated.

Changes since v1:
	- add new patches to remove usage of dev_get_regmap
	- add fix to wcd937x for comp soundwire ports

Srinivas Kandagatla (8):
  ASoC: codecs: wcd937x: set the comp soundwire port correctly
  ASoC: codecs: wcd: add common helper for wcd codecs
  ASoC: codecs: wcd-common: move WCD_SDW_CH to common
  ASoC: codecs: wcd-common: move component ops to common
  ASoC: codecs: wcd939x: get regmap directly
  ASoC: codecs: wcd-common: move status_update callback to common
  ASoC: codecs: wcd938x: get regmap directly
  ASoC: codecs: wcd937x: get regmap directly

 sound/soc/codecs/Kconfig       |   8 ++
 sound/soc/codecs/Makefile      |   2 +
 sound/soc/codecs/wcd-common.c  | 139 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/wcd-common.h  |  46 +++++++++++
 sound/soc/codecs/wcd934x.c     |  82 ++++++-------------
 sound/soc/codecs/wcd937x-sdw.c |  61 ++-------------
 sound/soc/codecs/wcd937x.c     |  81 +++++--------------
 sound/soc/codecs/wcd937x.h     |  22 ++----
 sound/soc/codecs/wcd938x-sdw.c |  65 ++-------------
 sound/soc/codecs/wcd938x.c     |  91 +++++----------------
 sound/soc/codecs/wcd938x.h     |  14 +---
 sound/soc/codecs/wcd939x-sdw.c |  84 ++------------------
 sound/soc/codecs/wcd939x.c     |  97 +++++------------------
 sound/soc/codecs/wcd939x.h     |  20 +----
 14 files changed, 307 insertions(+), 505 deletions(-)
 create mode 100644 sound/soc/codecs/wcd-common.c
 create mode 100644 sound/soc/codecs/wcd-common.h

-- 
2.50.0


