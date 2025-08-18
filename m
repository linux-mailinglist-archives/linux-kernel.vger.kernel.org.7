Return-Path: <linux-kernel+bounces-773609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB7B2A289
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA7217264F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4031B122;
	Mon, 18 Aug 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUsAMxUa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDA310640
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521462; cv=none; b=fRj53uDq2lxrU0HGhBpN659iWSRN5vOHhvSz7FE7rgGxRKsFwMBF6mx3wx6hMYxosYzPyPXbiLrCst+U3xFVmviwLvbx+8ZZqbkMLyGZnYWaWB4f9AKCROLHx5caqrggUs/+UVukRt0NX2HOEdu/mVAn8DclxNvMjYVaDlWrd0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521462; c=relaxed/simple;
	bh=lSfDSDJulBXzVJSH8kLsetVnz+LP1lpOSpV6/QKxUP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujhz02gWRA7qRaKVSe5HIgV7/YnbnT7lqoVj7UmjcAaSBtiYuIIbEzT+vDnaRjxkJDLd6MOl+QYL+w4XSLeagpWGfrjgLHhFtTzL0a/Yk/1MKMBKmwqwx3W+awIS2fOku4y7WKtw86Rarpdf6CQ2YaFlwpD3gULpahkJEMl3Irg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUsAMxUa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7Uiv8025668
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=99NPc/hNZh2Kb1E3FD5nne8SMDHWyt5h02m
	B6Lp5Gj8=; b=CUsAMxUa1mrg0ugsDD6FiipufqVXsZNxdLXPFO3Kcet8Sg06dSr
	PkLs07gh2JCyAqWL1LM38y2DKu/Y6ocQcis+/ZWB295+hWx+ZrDzjr76oEuBRMXk
	ffVSLOVxZqMI5rKjXGY3zWy+z+JIXPe59ZJJLhF/JFnJw+duZ5fMql7jlwqSvVLX
	brIEeSxkxk93ZxlbB0/9gF8/qMe94svI1UQ0CdR+95supZcCFSUQCBXB58jt1xzY
	Qi3HMAUH5oPqugju7HoOrbJ4WjRckrfG5yqzf2mAU1XWdhTEK6uREre0QS0T2jFF
	mAqqNw7LyxcsWB6+EBdUAw9YUo5sey/AGcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunrxwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:50:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86499748cso1381374085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521458; x=1756126258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99NPc/hNZh2Kb1E3FD5nne8SMDHWyt5h02mB6Lp5Gj8=;
        b=FXFAPXgkSaGMiGs+PosBjxzttZh2/vm/X6Qe8XV3ChtTfbC+ERQNlb9qxRv+bN2ceg
         MEVZA1akKtsi1ZPpaMgNBfw/oul8DBknA4mexslRju+INoruFvbmvhZEoLowvzzr00Tz
         /EDED9/FqFSsCeR5E6zJYu1bqmL+tQC7ToSBCYs+fNtdjgxOTiEYZeg8aOjOivc35Hz+
         hWCBdopGw7uVOqOOlYdn2Bxne/9mYY11e8zkseAd1CoEiA+8fXJxy95hTFJiNgLKIvA8
         /DfbbKwA21ldg+S2ylsBT7+AWM2NJ3N34JXbqbXHmcgjKpBHBFD7wBUa9CaTcm0Jambc
         bjng==
X-Forwarded-Encrypted: i=1; AJvYcCXrCDXFcNxY6YEc575e9SxoKrRf/Dq2+yMHDTunN3mFy0Gq8awqVjNRGHWbGxxPAy3o7yavfo5YgPfM9nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/ZS49VBmYAzjGcmbMSj4pgdKyZ8K0ua9cyBkGD0FegI1sGag
	v48BZRi3LyalfsmK8ow+R/tp2veqDp6rVY/AMIhmW2vt/CojFsscQ16EI/BLUwIkHixgXu3vN1u
	2IFeFrX5dU2hcxSrbBiRv4Y/dzkredT9NBlWq2s+0oqfX6gY9BMLntPHpgNSTpL3ZxaE=
X-Gm-Gg: ASbGncu9fwlS6l+TrwK2v9K5dUBPxaB8CQiBS2B4VHlWk8U6flSblkaXruT0ITBwaxK
	4Rp/51122PG9FoSnNJjc0LxmJPqBf5BjqysvypNndJCwqJ6By6AlKhr3/tBq4DcPNNpk6m2EnGJ
	IlMok2HrQXmpVTqr5Or6cDnZ+ArM5VMTsAFYCFPeZhfaeX71ZNC+/+n1L2LzLXop1sz2OLML+RA
	Fbm1qYPG3upKBJ6PY4FsgHQ0XhPgDoKNtlTQqnU/STtR3qr+FYtxn9A0QlbhDCfvdyDB4ohQX3Y
	iCQl3UlTQISgfL1MZD4z7yL1tF3QBLpxFreuczuCQwXt/TRlcF81sg==
X-Received: by 2002:a05:6214:20c4:b0:709:3768:445d with SMTP id 6a1803df08f44-70b97d69158mr174285636d6.11.1755521457658;
        Mon, 18 Aug 2025 05:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEehzsI6ttyklkU4OQIHPZGVa/k7IHY5zvv9A809GRerz5FOGA67mbOXfqroqTaT/rLzJkQwQ==
X-Received: by 2002:a05:6214:20c4:b0:709:3768:445d with SMTP id 6a1803df08f44-70b97d69158mr174285246d6.11.1755521457127;
        Mon, 18 Aug 2025 05:50:57 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:50:56 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 0/6] ASoC: qcom: audioreach: cleanup and calibration
Date: Mon, 18 Aug 2025 13:50:49 +0100
Message-ID: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FbknIHHBNsK9s1VDEL2SBDBbuhZcSuyI
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a321b2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=NU7b6h4jXCN-HWJItUMA:9
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXx+c6Wb25my7e
 iIaPSUAPViYVkMmflmHu+kvYXUCKxAmWh3sbctFAPCQ8zSPKUXjH0DfAU7IOn97dQZahIfKczrt
 tXS/bI/MnUS2kPhpxbNM0bUbQVv1pQKskrslw99khCw1tdJiZ+uf1LiA+QDkxwpptw4+Ps4DOe6
 j82mtvOD8vPmhqkBZOUivRrsgP6xTJWddEBkJo5mu7T2bAwIUfe+YMAekxu6M/xP3skp+fgpmb5
 YLDx1itkBoKVMPY8rdBqtEJj+Hc1kro/OycifsQ3wFhOjSEp+m3PsHyZiRtXTnHgfe4XPevPI0m
 UZyud/gSo9S2gw6N3zXPUZ83PqZnLz9ZFlA2ImAica+G2OgCVgHRdNvynqE2HV0VyVjoTfC0wY0
 nBJyC9km
X-Proofpoint-ORIG-GUID: FbknIHHBNsK9s1VDEL2SBDBbuhZcSuyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

This patchset:
 - cleans up some of the audioreach tokens which are unused
 - adds missing documentation 
 - add support for static calibration support which is required for ECNS
   an speaker protection support.

Tested this with Single Mic ECNS on SM8450 platform.

thanks,
Srini

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

 include/uapi/sound/snd_ar_tokens.h | 18 +++++++++++--
 sound/soc/qcom/qdsp6/audioreach.c  | 27 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h  | 18 ++++++-------
 sound/soc/qcom/qdsp6/topology.c    | 41 +++++++++++++++++++++++-------
 4 files changed, 84 insertions(+), 20 deletions(-)

-- 
2.50.0


