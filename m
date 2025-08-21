Return-Path: <linux-kernel+bounces-778708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E9BB2E92D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C0117CE18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77DF9EC;
	Thu, 21 Aug 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aw5gBfz9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448F33F9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734677; cv=none; b=X+IeG+Zo/ExwFsFCz/be+GEEyf46NqLewmFM5gQyk5tLWtcHvOAOUFOhJ6W5c8j1hDweU6Kb2qRGlSC0967ViPBedo/9pYjApjZS8gY2GWAYxXGV8p+yR5Jg0pCpjm5Z0/bQ9RODaPOG7ROcHIN7MGBKmwW38ZYTlqh6/NhPMZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734677; c=relaxed/simple;
	bh=LL0VHvueeCC9BQFNhEFs/rbo80R0kdyDYeu2Vqvp7kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r11hQ1dMJRKaKrVP6uDu2443n1hy9NoszdP71Wmzjipj4l22yWu9kRTg1AHOavnxLZ0X2spW2fzDprzk+LuJuckQQ3RFq9K9cEetqstXJte4m52oRm2XbDu3AvCHaWk4ZhAW7ONoSj0NnBaNuam9sZZR9AWTFEaBaGHrtnaYobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aw5gBfz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KK6TxS028595
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=h/QHGAqsGwM2i5MHloplb39qjZWHbgGxp7s
	oSeiPiFw=; b=aw5gBfz9MKN9vJdrpHWypLK6QY5oMczoueFtm64ZjPpgTxdg/Sa
	GC02oGAioQJ/deR2sjjMx3Q0SjvzTjrYudj9s28UZhxeA0UzZb1RdJHIXqOm66yZ
	8wv1ogTsZtiDfIVrspslTr/gTY4frYeFm0QT5okVoaw9tpNucy2CdTELCTYF3i3O
	x09MuGSyYN/M8RtT7R0ewpcA++jSpGWU2sUtpnoNBA1VqWkH6HqIl6ms0FUfbawl
	QE0rnxmjUnMPU50orHI8/0XKkJ0sBxEqzbYxjr704ayXwbfWBS+tFhTZ6a2Fi3Qt
	wllcmo2m6huLXMt1Ujy5yFAbh87rCbMLN4Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52auae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-245fd2b644eso7479655ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734673; x=1756339473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/QHGAqsGwM2i5MHloplb39qjZWHbgGxp7soSeiPiFw=;
        b=heMlUkxuexB60BJ0X2Sxm3K6xrKT5/8zyiRTuY9CpqTlUm6FMJsYoU6MrzRYObD/1/
         UywlyciPW2MkiS8GXUYq7e4ueS+sUxZei4buTD30epfAp3uArDghw2DfuQgVDnQ2zWjb
         HMnehQvfOxTuFI9ism2JFyofdzR5X96nwGa2VIAXvEhaMS/6umQu22+0hR/ARETgrmhE
         ceuhwJxyzOrq+RA70F3X/NiOa5dj7lbXBT6SlbPfLlStkwvvaYl2nqmXratnsexWVtkz
         fB9/ez2I1hfFOW1ABxeV+VFQ9Zf1S7vpyEKN2AOWy383PvydG2HiNhzYFtpnP4sE4LYA
         06Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUyLS4eNumeWLDlMS7rNgiD2Uj+jomdgVmfHO1bZQbjvDjZP5MM+gI5b01AsFKY+QJl4IZY0KSBNij9Yfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhLugfmzMh/6jnBqRvTLT3KMIZS5+KyXVd+RDtpjeQfps3KIG
	bGL03tHxXQIrRm1gfxsbgBILwioaZiADv3bJNT9MBc1orn8qxglViubXz3OOHmY6ftVGKMs+iyM
	DjnOvtvDfNzwiTvao6Gsh4Zdiw2a2+TQIfgRwXA+1hwhB44DROp0YDVUIQY11Pag0NFQ=
X-Gm-Gg: ASbGncuoTmfMEWDnNb0C/yGiftKgisZHOha9RPaRshCCxt4Kx6hx6QEQ/mr9wuFe11L
	WmqohTRWkv66z7XBPNBC7dL2Gtcp8mlf7Eml+5JJ2AUsjHmFjqRbv/oe7ecUo4dH9murkXBLBFW
	hHXXXHHOzXizt/Cfzmc8lfc+dzndndSAo77Q/HV7RaCw8y20Ns1WnPpidRQVf8ZclBNGz6g0rpA
	942FNTi4XOAiUsaUWZlW+FAoc1cAId/neHtjAHoW6ZFCaLW/pQ4/O/P33gOB4BCYedy+kcXECS9
	358mhfHY/s/maLScMIfet5NjNTqeK31Gp42r4dXc0G1p5Zu/UjA=
X-Received: by 2002:a17:902:d2c1:b0:242:8a7:6a6c with SMTP id d9443c01a7336-245febed653mr8861325ad.17.1755734673255;
        Wed, 20 Aug 2025 17:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK/r8TYTWkV3tyt9AedzmAuktOgPzvmoS7TFw/w6QgXED/i2kMdkuCF/pyGNYjh6kI9D4WCw==
X-Received: by 2002:a17:902:d2c1:b0:242:8a7:6a6c with SMTP id d9443c01a7336-245febed653mr8860925ad.17.1755734672663;
        Wed, 20 Aug 2025 17:04:32 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c747esm37464835ad.83.2025.08.20.17.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:04:32 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/3] drm/msm: A few GEM/VM_BIND fixes
Date: Wed, 20 Aug 2025 17:04:24 -0700
Message-ID: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5rtoRl3GVV0G
 Rp7ySdo0oceaTPzRT78Z0EZ4zT9Co0NhUIRycujdQT1nOqAtb3BG2GxgOL1VPXu0HwW/ddNOPl6
 2tv7us+J5j+FlwajFLlOVS4XDPjGckRZIQmhlbMpAMGqMWV8FkYCIYYsnVhR9SzVTKIjGLAZyze
 QnVF9rcetohgqBirK+ePrF6M4nFv+8iZ+8lCq8c/yktXfPQnPQMnIVXFemCv52s7VcuZi1z+PB2
 05rWRnnEAyOVv8CiiqLR9++qyqgxrYQUULVNgSE/kkyDMZCrpbwrpVRE2NUWON3Rpz+niAve3Sn
 TLOO718Ce/WnuBSfvRTtZFP6mEYc2mxgLfLA2xWYLIO9cw3+BWAff7ppGsIX9/q9L8+3NsIzAch
 dlijSvdyrhtRLbZYX9N3IMk/l3rD1A==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a66292 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=7-57VTQsmsoFMMg7Vz0A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: ICuMW6yifV2T6WqmpRSyreNXhFJjI825
X-Proofpoint-GUID: ICuMW6yifV2T6WqmpRSyreNXhFJjI825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Fixes for a few issues found in vkd3d-proton testing.

Rob Clark (3):
  drm/msm: Fix obj leak in VM_BIND error path
  drm/msm: Fix missing VM_BIND offset/range validation
  drm/msm: Fix 32b size truncation

 drivers/gpu/drm/msm/msm_gem.c       | 21 ++++++++++---------
 drivers/gpu/drm/msm/msm_gem.h       |  6 +++---
 drivers/gpu/drm/msm/msm_gem_prime.c |  2 +-
 drivers/gpu/drm/msm/msm_gem_vma.c   | 31 +++++++++++++++++++++++------
 4 files changed, 39 insertions(+), 21 deletions(-)

-- 
2.50.1


