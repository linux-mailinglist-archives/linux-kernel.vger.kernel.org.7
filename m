Return-Path: <linux-kernel+bounces-824892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75AB8A629
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9477B6D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122631D73B;
	Fri, 19 Sep 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZYye9+P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995231A559
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296846; cv=none; b=GUc6KmZ0IPTUv799IiQFCrtKxtA7fBGVoMLNrYTDb98RWjYRzvjD4/jy4tqfSwbGtc09Ss4RImh2P2CBotzJ4beUQybIoX26NFXOVDMxj2ZDlCT7DYmhJfvYzsjMQshTvAS7ohcK34MO4ussb3tXXWFitXTobGxnKSVp4jWpTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296846; c=relaxed/simple;
	bh=Z6FgwU81RDmLwktIOUwsJhCbJ0jXwiGcGxLTvLDX+HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D6hNxO9fuJ1lQDtqRqvBysHuMHtB6Mju/dG7MGUvg8xL/l8eE2glZeEUhp9IkEhiAhcPyGocZL8xYZEg9k0bLCzMcZ+vk/pBBPEjCe/9EoU61cPG+/kIt9M5doyso4OpEdIf5Y842QUpuBTDbjXXoZUOFPjG6fJofDJAiwpDwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZYye9+P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JFHULv029741
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f5IZjZihMBMzwST8n68PWi
	/t6dztWGpRaZ8IqEGg2Po=; b=CZYye9+Pb49wLLIf6SMEQIT9aZQOEOP/MD1OI8
	wLzN7wH2GcH/kATEA6yHhYAhr0wRaOfPAy0ezGg2SlGNX0YsaQoe6n0bGL2d17IZ
	0DUdWjRqHRTgIJGupqooPG1EXW8jkv176yW6xCkTCWm4Rj9AuzkUIA2KQC1HMjPI
	3ZGz+jj15lsc8PvdiPdiivWSekzFU/UPHMDNuCQyowyJAmQPkVNZanqRiD6KJ9uN
	x1jvBIqtVj5nV3xdxA5wstfXBUvri70O7ZmQCsb8JODzAxK/Ft2n5VBmnDqT548u
	/KLxc7Y9QaNheipCxwW0WD78/5mT+ai+jrGKaHiNRpdCHufA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy12xg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:47:24 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77dff701fb8so1271885b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296842; x=1758901642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5IZjZihMBMzwST8n68PWi/t6dztWGpRaZ8IqEGg2Po=;
        b=LongLMr/hsXb2GMwLB/Rp8Prwn3IoiDDtV0wxSBqWffFLkk3OcP7EvDnD1Jkbkncwn
         VejG33XSg4uXzCzfJC5yy9IpwGnJXp0hDabm6c75lfB8wvrsM3IPrWjyrlDNvaVxlLRr
         Ah0khAAkOXzgcoJSsJDrgj2kyrlPWfeMcOccR+FRntJqkN50UpVIHGntFN0ectWMdh/a
         GRidIUFZV1zB4HgznadmWazbd7k4LEPMZE3GxGTBGrn7dVODOc3/KuMjLZFHQLZCXLF+
         dnlh1jqlInXps1QFm6HjLObzAjPKk87XPovUNSz6wte8jvFYtYKIJJF8I0hr8Zt8LpU1
         zBSw==
X-Forwarded-Encrypted: i=1; AJvYcCUvIgOkSA7TUxNd9S9ZqeW8AuRNcQPo9mjo3YKPLa0VEbbqkRPxauwo9bh1zF50TKa3ICDswc6pbf8qAqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxwWLBHFUJXWUwJHdR3QlU0bHyyX2Stqj5Ti1i1v73TMKlAO1
	hK6mU/WUIShFxR/b41fdaO67ldyWwGzHZ/NOAGOQCghw2m/W4oSUSFJvo+xFlgEfQymtyFU7GPb
	0VfjbrKbcbvpeC0XW597I3f0Hm2m1yt4J+cv7WWZ5CGz+m5R3Ewr4TtpEAMy0agzK9DY=
X-Gm-Gg: ASbGncveanfI13sQkfNtJwddUurEGhNukKiKni7VC6AZGSRiisYSA9K3QRyaYMBaWgz
	C1q85YDEzn1/Qd6+cghKRKuGN5tXWPR/TNRE7lCo3LAruN0zzW1C6p84k+tUk+lqkqyKxtq3m8h
	FoxxPqdN2pNABcOXf2MynUby05kN0hYPxbXRNef8tHGhG/jSUiWN8G4YB43GlUkGu1Nvm3Umj1S
	0BZrFgk+DqsusDQJAhgHjMKnREGHr0oFtwwcN0Lgde/uodCNku9FSVECQRtqasvSRLw5lp5FzgT
	U5h+jBBeUxn0AP6aFW6sdYSADr3aAs0OPw6S0wAe1KrZhrmOgEniiGrTrLdqdYHtUijHYUleRq0
	iFA==
X-Received: by 2002:a05:6a00:2196:b0:76e:885a:c338 with SMTP id d2e1a72fcca58-77e4ecc2cdbmr4401573b3a.30.1758296842142;
        Fri, 19 Sep 2025 08:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+yk51eby4vIViBz1hHHz/Jp2vtK0V7tofw4pUoeiMpPq8lWAssXvf2irjZp4uaYpxiu/Mcg==
X-Received: by 2002:a05:6a00:2196:b0:76e:885a:c338 with SMTP id d2e1a72fcca58-77e4ecc2cdbmr4401542b3a.30.1758296841539;
        Fri, 19 Sep 2025 08:47:21 -0700 (PDT)
Received: from hu-dikshita-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc2490dcsm5706653b3a.36.2025.09.19.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:47:20 -0700 (PDT)
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support for QC08C format in iris driver
Date: Fri, 19 Sep 2025 21:17:15 +0530
Message-Id: <20250919-video-iris-ubwc-enable-v1-0-000d11edafd8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAN7zWgC/x3MSQqAMBAF0atIr20w4nwVcRHjjzZIlAQHEO9uc
 PkWVQ8FeEGgLnnI45Qgm4tQaUJm0W4GyxRNeZaXWasaPmXCxuIl8DFehuH0uIKbGtpUtlBWFxT
 j3cPK/Y/74X0/yIW/jmgAAAA=
X-Change-ID: 20250918-video-iris-ubwc-enable-87eac6f41fa4
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758296838; l=2036;
 i=dikshita.agarwal@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=Z6FgwU81RDmLwktIOUwsJhCbJ0jXwiGcGxLTvLDX+HA=;
 b=g7ozL1iwLNp7t/Ze9vXUFdfksEfaCuT8urcXbUxwIAnFimMFl3f6j/5Py7IQgKajRVKsCefzh
 5MPCRF1eFTfB+OwebiAy1kq9f4V4WI4GqlHu3tRftWzA0enc/z01xVe
X-Developer-Key: i=dikshita.agarwal@oss.qualcomm.com; a=ed25519;
 pk=EEvKY6Ar1OI5SWf44FJ1Ebo1KuQEVbbf5UNPO+UHVhM=
X-Proofpoint-ORIG-GUID: unLmIF75JYWmF0gJDDuzrX4KkL8NOWct
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cd7b0c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8fPvZrEDet3th6y22BEA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: unLmIF75JYWmF0gJDDuzrX4KkL8NOWct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+h/OvVK4vl4k
 JCWxuD/vfFTJonObjjJCC//FH3hK3E23oiKl7g03WLaKto3kunA3UZ+bLSioYTuFEFGwDNXqeAl
 yvWsWhrOyBHDI2Qq/lUNjPdZ4UFwxQJpkpw4kUM395BzZQCqaW6cAzD3EkE5pQxOSc4aLzEQpRT
 Q9slh2GIanQvHME4YgXMk6HjdeFiVbnF6zzbOGmTPe7I4eteDMYi9cxa33mykHNLTeYxKWvYDlN
 0PPOhRUDDlqGIrr28Zs5jgYZ79Dn0iEyUr9wXxCi2QtSsr8BbVo3aP6v/qkr5/WEbUCyd3modQs
 wH0ulDiJKDS3stMoVLM9P4DNxeYGykE5cEwBX180BaCFvew9ykIkdK5UV4SLSnqR9fNqphXaBYv
 Rf/oM18+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Add support for the QC08C color format in both the encoder and decoder 
paths of the iris driver. The changes include:

- Adding QC08C format handling in the driver for both encoding and 
decoding.
- Updating format enumeration to properly return supported formats.
- Ensuring the correct HFI format is set for firmware communication.
-Making all related changes required for seamless integration of QC08C 
support.

The changes have been validated using v4l2-ctl, compliance, and GStreamer (GST) tests.
Both GST and v4l2-ctl tests were performed using the NV12 format, as 
these clients do not support the QCOM-specific QC08C format, and all 
tests passed successfully.

During v4l2-ctl testing, a regression was observed when using the NV12 
color format after adding QC08C support. A fix for this regression has 
also been posted [1].

[1]: https://lore.kernel.org/linux-media/20250918103235.4066441-1-dikshita.agarwal@oss.qualcomm.com/T/#u 

Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
---
Dikshita Agarwal (2):
      media: iris: Add support for QC08C format for decoder
      media: iris: Add support for QC08C format for encoder

 drivers/media/platform/qcom/iris/iris_buffer.c     | 17 ++++--
 .../platform/qcom/iris/iris_hfi_gen1_command.c     | 15 ++++--
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 21 +++++++-
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  7 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  1 +
 drivers/media/platform/qcom/iris/iris_utils.c      |  3 +-
 drivers/media/platform/qcom/iris/iris_vdec.c       | 61 ++++++++++++++++++----
 drivers/media/platform/qcom/iris/iris_venc.c       | 59 +++++++++++++++++----
 9 files changed, 152 insertions(+), 33 deletions(-)
---
base-commit: 40b7a19f321e65789612ebaca966472055dab48c
change-id: 20250918-video-iris-ubwc-enable-87eac6f41fa4

Best regards,
-- 
Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>


