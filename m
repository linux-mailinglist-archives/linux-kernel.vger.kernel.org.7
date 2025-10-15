Return-Path: <linux-kernel+bounces-854559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8498BDEB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E86B2351D68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824A1EB195;
	Wed, 15 Oct 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vj17OglB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC601E521A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534291; cv=none; b=a4sDpWU08uVnE/PQ1DpKUvLpfytBT0kymXUO19wiX1aXtX57fnsp91ek9g5Tethc1FJvcQ5uXDKHhiCvvj6xD4fHsIf/p1FjppAU1ukCeLGDVbotT3p3ITGMYGMkX6tlCQFZr7zTd4TaCpYic3Z5xrLkrNXTiD2gPNvbS5VISBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534291; c=relaxed/simple;
	bh=F2O3ZJ71qMH0ICSS8tWDibzVAxjL34Ltr6haPBzh4tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHK6vl40jKxpbhNoy6tuyBi45vbm62DImWt1uKs4iB/ZiCFkRagtw5U4xuMp95QO45D2h2tKDQplVb5zEQ6cN/3Xx7MNnIAEXzCIpJEreinga5//080M++pBeJLugZrgewTG7ujkvwxC3Ved58p4KST3Z6S2fS7Jy0awskFHzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vj17OglB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAvedY010182
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bNq/k7frxt1cbgp5PvSrzLAku17t2q0t2kF
	clXsVJNY=; b=Vj17OglBzp5KHidDsIttYZvudc1FBUCo0APQYX6rRY+rDaUEoHF
	B7+cjUKOmNTGzU4kzHLjSnY92iqyKeZl7VmxoHn4+kPOyXXJ1E81pObLMJpdWQuz
	tsW1h2WeZvc3ENvQxRBpLZq7lOhxgOnUdzQoo5crPfwHi9t97YIFg/UXJT1WZCi1
	dfJdvxC0LqOYyB2jlowjksTS9bo7g/u+DY+VWpPT2j6+wxzeDjIULFBCorp2OOvy
	WFlx3MirWl07+R/VzovhHaq46Gjiuy5xzkgYfeZdJdkUKDsNh3KPXSTyoUvJjIQk
	FNvV295tDjm8r0JNf4OFkRU+TflgSnS+0Lw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c4ebe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-84a3a7ac082so2861708885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534287; x=1761139087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNq/k7frxt1cbgp5PvSrzLAku17t2q0t2kFclXsVJNY=;
        b=ZNFc+AFV6YMx3CrWg3PYrQ27CcqaUlgfiKFi8Jsi5LX9IuHl4tApv98Qti1gqUpVER
         EZoF+xt+vHdi6TGqdNkWLp0NdAyXobTkeb4u2rszsJSeNqky+fEzSGJJzZOdRz6IatcS
         fUdwDiTIW1frQYAUnNWCfTOtc9wJG6nZQQnOyN3TzlYWDtE0MkodNDyRplV6hCSc/XW1
         gwFKkSnXkM+IFMRrxZ15LsT/YlcVxvdpb8mCqLWW82IEXZ04P8cF8xjRjqMrkVDEhuyg
         rikgw1FroznEMfSwAvOp/kUToxeZc0M2440Ggi75Dmd4qvh8/9JWZAZu/dscsY9T5U0v
         uP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKjbkbUGf+7M1/fa/XiknuHWQnxnqrptKeTPm9MsXVy7v/FoeoTNpnMcKjC9EO42gempe24qSMaRZeSVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfZgg08qHwVvqPE3xtt+MNGILHdobx5lGLoSSfuXWCdRCUKoW
	D2JJHAJ1/5nHQzLfWc8S1Uf0y07zIQqI8YConAEW8szOOY3fTWkW8DytOKqAMlbAjHKu5qDW94T
	PdIa1l4WCZLFlzViHDvRFu6QuEwLiIK8U3JsIX40M8W0M47aqBLYdbo4aiV7WgcIS4EU=
X-Gm-Gg: ASbGncvEKy0f89wnY5ro4rMj2S4XjM5akJEeJjrIUW7rQEp0Cz6ijnrFpAjnsTfaTg6
	upp2MDNbuajDgGPpuJIRn82x3Csu7It5tPCdTJiMaUg9mT/sWFtS80IdtpNa9BQfwl2LP+rRHhR
	jFOrjvLt17HVuPdmMvxwJVcnYc0K53uzQiOV+PoI9U85DbyG17YP56AUnBlsovFFcicRsH3uorA
	mG+buO1/6/jGvaVjjhIhEVzIDr+159L+25gpuudpcs4+RgHs2frfIUiZGzFqAHj0I55nzsq8beD
	Lm1xdU6igizcXZYHidni4xw8wDxtmEMOQoTMcWV4b+/Lj+eMTa5mVw==
X-Received: by 2002:a05:622a:1823:b0:4e7:2645:3ce8 with SMTP id d75a77b69052e-4e726453eccmr133347991cf.54.1760534287425;
        Wed, 15 Oct 2025 06:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5GkTrLEf2eyVpfcrbf1++cpUyKY45rCxFJ14NSiwgVZcXo0rIHi5DxLkxdId8UkVGLsuHIQ==
X-Received: by 2002:a05:622a:1823:b0:4e7:2645:3ce8 with SMTP id d75a77b69052e-4e726453eccmr133347221cf.54.1760534286750;
        Wed, 15 Oct 2025 06:18:06 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/9] ASoC: qcom: q6dsp: fixes and updates
Date: Wed, 15 Oct 2025 14:17:30 +0100
Message-ID: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ujUTJrU5_EOBA5XKs2gMl7t5D9fiUUPV
X-Proofpoint-ORIG-GUID: ujUTJrU5_EOBA5XKs2gMl7t5D9fiUUPV
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef9f10 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VIej19u6sp1ej13Lf-MA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX4y2oIUC0OWX9
 Yz9hGVzk6yLX4Q0Uen4h4q27ebgcWV1e3VP6l7mlvEX20QDGwM+iMCaV3wENdrFHuXykFIPjZzY
 zfwMTlqZdXpSUJLFpH5aYte8P4NEQ5RLYELtEpeF9sGe6KzS+j85L0ewtkCZlLS2C8x1ZpQZMYz
 4a1qOYROK3RcVAPDHAEdTjtJ1R3IhDXzGLz5vREINFvCL4kBtVPxAFgaIZ7ktZziWYe5RChshtE
 FU5WyiJtAHQFdkw121i1eDdsIhENjXZc4q4W5Vp2iKuBchc+BCg3rGZOWjuSPBi327O2A7P6IY8
 /8RGKgCNZ7FCqJ5KEkJxbotpw9AQNtoLlQaZZ4ZcPijnZvJeOe+UvJj7Au08jJOHEX1U0h+s5bS
 KEyy96FwamEfFoBXDKeyB6FwZ37f1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

This patchset has 4 fixes and some enhancements to the Elite DSP driver
support.
Fixes includes 
	- setting correct flags for expected behaviour of appl_ptr
	- fix closing of copp instances
	- fix buffer alignment.
	- fix state checks before closing asm stream
Enhancements include:
	- adding q6asm_get_hw_pointer and ack callback support

There is another set of updates comming soon, which will add support
for early memory mapping and few more modules support in audioreach.

Srinivas Kandagatla (9):
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

 sound/soc/qcom/qdsp6/q6adm.c     | 146 +++++++++++++++----------------
 sound/soc/qcom/qdsp6/q6apm-dai.c |   2 +
 sound/soc/qcom/qdsp6/q6asm-dai.c |  64 +++++++++-----
 sound/soc/qcom/qdsp6/q6asm.c     |  17 ++++
 sound/soc/qcom/qdsp6/q6asm.h     |   1 +
 5 files changed, 134 insertions(+), 96 deletions(-)

-- 
2.51.0


