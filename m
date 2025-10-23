Return-Path: <linux-kernel+bounces-866692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57CC0073B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC1F19C41B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82327FB2B;
	Thu, 23 Oct 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9pPd7dj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFD30217F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215158; cv=none; b=dpYc+TW6wmvxP5gYIhcCew1aMMVDnRkWziJ3tLM0TMoz4hC2sxrkRk3qunpG2wqw3gbf7zD5Gs4T+/rHRU/MbFEaKCBf1+BLYFBUvf5D77zvokUYe4Fx/KCSJpVD+gIoBBoY2KywefbVALAngO4ikcURzfjUJ3gtH0xOubQjXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215158; c=relaxed/simple;
	bh=MuNDVGw863t1MIYdxFnFeXldKN/aMHxbss5HGe8ElnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0zX3KceVh+Pjj5C7cey+U/XwZMyCc8OKKaufWLD6mm5MXBTI6WLTq6ZcsQXzw3AdFIwVSPJcLGXnwiBpl40e+FQK/cwDcXSzqi8Szd2QGw2aejMG/nS5pfyQBX1hG3OBVesFu0HLTCdsMc7bGSCFxn3Dc3PTR3mC27ZRApTdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n9pPd7dj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6mdLV030315
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=e6NuyEZl5rpUsxOevTTxhTo/WEHtJ7ZXG7h
	onHAVIWs=; b=n9pPd7dj/zaPBPQEhf1k+FZ+bs3OybuJ8u5pi8eFhXU3AC/AFcT
	m3lx3uwM2F7uUyZDMr/Fm0pJtGLCPxmZVNGBjDWPHGC2E4jY7K/5sOVY5KLgl9B6
	9oCkonKq5KVc0wZla5GrDNkoaPyTJk2GOJsmiw75WRV/X7zIisZav3lni9QPtEpP
	kZMKydpGwKXd4y2dywN03oXCs24AVBvrqqPf4m54o3lHZ4PYKrYVv38Sh0hJzRP0
	WQFKDgsRQ/gjHxukNFdugADbj+ULKS7NPnMJWYY22u4zNAq1lpjMaqhYFtSFLgPr
	kZ22M4EMKerOrwruHd5JyYR7vqVxB7YLMww==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge80jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:25:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88a5e70a7so20390941cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215155; x=1761819955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6NuyEZl5rpUsxOevTTxhTo/WEHtJ7ZXG7honHAVIWs=;
        b=Zo066sFXJGNVhf2RfB6YoQ+NLKYPCF3i69gsCnZJ7BcthALmi+4xZmCnKj3jzUV7nc
         s6SDyb01dxpGI5hVaVI3W8966+1CiJBWLyf/IwVlTzNj+USsu3Oz/OtYLNXGyj5jSGAW
         oxeBJMZW9agENBTH6+b6jf/gFX66FuHeiysgjNCaazGpbRQx9vTgjG/fte0m99kFKv4W
         cmmDxMy+MQfe/gFZeUXLzYQ9q1BJU4AmHkUoKxcBfr9EuKwnvGDkrolvmSbXCmjzKk/q
         6nl0RS000lDIxbbTe4N48QbFsDsWxMC/n1/NGDS418ke1kQPi/MMMUcaThRlvlsm9hMR
         3sBw==
X-Forwarded-Encrypted: i=1; AJvYcCXoVELaOD2iGJV/UzPxHmjq24+qEnHiC4TGGfSWBl4iWUiKSOaU4Loki00xFkn344B6pUV8htYGgwWa7bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuFIJPFf8sOEGXoZKTiFo0TfX4c7eRRgdkqiVsbMQdW+In+Za
	IPU4Lp6Rv3Z0iL37FOMrfiGcGdN1YrGunsiOxkLC3i8Wa7eZOfp+3bOTFFQZDGgzIGoD+O8m2Ii
	1GdW7OuQ/EGhwAYe21up/d8oJ38IGQJacLQcOeNT19KgYjLdPqRigcLLqvdsJx6a9t3o=
X-Gm-Gg: ASbGncsOUU2gRJ3jsyqSgTpxHkawv5GixbcC6rc5I6UM7RwGDJqgONGa/S58Gm+bvN5
	KbuYGR+X/wYodTNzBbVrzypsxBSeclx1xyhrab1zC6TlY0FyDAy3XEkJL/lTBVGYFsSOd6ANECF
	wC9CJ411Ydtfl3vFxNnoPaXZVsV3yQokmP7B3gMOstQ1wceWgNR07pArr74j7reiL871u45k+/n
	dA/Xwd8x0YaVlhAdsRvYJK8rMEJegPxBklhgwd0uUmoCbGjIoKBhUaquFj7yFwnhCd7Lvxo+Dgc
	z5vmrNkRFRkjuQb6OLPRy1/ZNU2aDVZ3Dm5tW++u8oSm1RCHXGgNLB235JEbDyn/m7mystFK5sV
	FrWR9Uf4jCbPF
X-Received: by 2002:a05:622a:3d1:b0:4b7:aa1a:eb1b with SMTP id d75a77b69052e-4eb784a0e0emr61010981cf.2.1761215154726;
        Thu, 23 Oct 2025 03:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ+fBPIYF+HXBjwQ3mpEIhl8FmKoONb/emdfB+NWGfyifEI1oSIA/Fyjaxd3+5zqRuhDPVpw==
X-Received: by 2002:a05:622a:3d1:b0:4b7:aa1a:eb1b with SMTP id d75a77b69052e-4eb784a0e0emr61010711cf.2.1761215154168;
        Thu, 23 Oct 2025 03:25:54 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm92220685e9.3.2025.10.23.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:25:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 00/20] ASoC: qcom: q6dsp: fixes and updates
Date: Thu, 23 Oct 2025 11:24:24 +0100
Message-ID: <20251023102444.88158-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX5fp4HBgE7mZt
 FHwBPNSGDmz8qlcOgmPDVmfuKvrDyfcNadOOc4zCkhkSuuStsSpe9/ehO5P2ivG4ANzEHqredkM
 Jws0zax1hvWT0G9fbVbWC7B3aFlJypfYU/9gXv6jA/9Z190LQFGIExHu+Tb7gCFXrEviXS73+eY
 1E7PGGNe3RulzMWZfHER0aqZIZyZ0PhQdBdCdzsaPypc2SojV1GYvDNUsVSunhV3cWxKlkpwCPb
 LFabUR9wHnV6Wno1UnY980ln2CQLUSM1tTFxPw+abYsVI4XFm4x7O6tsq4LxrA92jEqTLKBFh1Y
 gHigSysSJIChJ6ROUit0k0p5b21bQQhBR6t5McmbT+7ExuyqhDKBIFql+R4Y2oCK6JO0uPC3Aiq
 nIbx7Z57IPzNWRtI2QDbRGsC76/fKQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fa02b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OLL_FvSJAAAA:8
 a=ywnRGdmwFc_i4B4SztQA:9 a=jdvOL2tdKL0A:10 a=UsU4ZBEK-5wA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: k5yHflJKI1tfWvLkHmlom4uIA2guV-he
X-Proofpoint-ORIG-GUID: k5yHflJKI1tfWvLkHmlom4uIA2guV-he
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

This patchset has 4 fixes and some enhancements to the Elite DSP driver
support.
Fixes includes 
	- setting correct flags for expected behaviour of appl_ptr
	- fix closing of copp instances
	- fix buffer alignment.
	- fix state checks before closing asm stream
Enhancements include:
	- adding q6asm_get_hw_pointer and ack callback support
	- simplify code via __free(kfree) mechanism.
	- use spinlock guards
	- few cleanups discovered during doing above 2.

There is another set of updates comming soon, which will add support
for early memory mapping and few more modules support in audioreach.

Changes since v1:
	- updated commit logs as suggested 
	- merged "[PATCH 00/12] ASoC: qcom: q6dsp: few cleanups"
	 https://www.spinics.net/lists/kernel/msg5884053.html series
into this series as its going to be merge conflict, and to ease
applying patches.
	- dropped patches that are applied, added tested-by on patches
	  tested.
	- rebased on next-20251023

Tested on RB3, RB5, X13s, T14s.

Srinivas Kandagatla (20):
  ASoC: qcom: q6apm-dai: set flags to reflect correct operation of
    appl_ptr
  ASoC: qcom: q6adm: the the copp device only during last instance
  ASoC: qcom: qdsp6: q6asm-dai: set 10 ms period and buffer alignment.
  ASoC: qcom: q6asm-dai: perform correct state check before closing
  ASoC: qcom: q6asm: handle the responses after closing
  ASoC: qcom: q6asm-dai: schedule all available frames to avoid dsp
    under-runs
  ASoC: qcom: q6asm: add q6asm_get_hw_pointer
  ASoC: qcom: q6asm-dai: use q6asm_get_hw_pointer
  ASoC: qcom: q6asm: set runtime correctly for each stream
  ASoc: qcom: audioreach: remove unused variables
  ASoc: qcom: audioreach: Use automatic cleanup of kfree()
  ASoc: qcom: q6adm: Use automatic cleanup of kfree()
  ASoc: qcom: q6afe: Use automatic cleanup of kfree()
  ASoc: qcom: q6apm: Use automatic cleanup of kfree()
  ASoc: qcom: q6prm: Use automatic cleanup of kfree()
  ASoc: qcom: q6asm: Use automatic cleanup of kfree()
  ASoC: qcom: q6afe: Use guard() for spin locks
  ASoC: qcom: q6apm-dai: Use guard() for spin locks
  ASoC: qcom: q6asm-dai: Use guard() for spin locks
  ASoC: qcom: q6asm: Use guard() for spin locks

 sound/soc/qcom/qdsp6/audioreach.c | 234 +++++++++---------------------
 sound/soc/qcom/qdsp6/q6adm.c      | 179 ++++++++++-------------
 sound/soc/qcom/qdsp6/q6afe.c      |  49 ++-----
 sound/soc/qcom/qdsp6/q6apm-dai.c  |  25 +---
 sound/soc/qcom/qdsp6/q6apm.c      |  57 +++-----
 sound/soc/qcom/qdsp6/q6asm-dai.c  |  87 ++++++-----
 sound/soc/qcom/qdsp6/q6asm.c      | 203 ++++++++------------------
 sound/soc/qcom/qdsp6/q6asm.h      |   1 +
 sound/soc/qcom/qdsp6/q6prm.c      |  27 +---
 9 files changed, 302 insertions(+), 560 deletions(-)

-- 
2.51.0


