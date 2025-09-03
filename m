Return-Path: <linux-kernel+bounces-799079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FFDB426BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F64E1BC0F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374C32C0280;
	Wed,  3 Sep 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RB7AFb+7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916C2C027C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916495; cv=none; b=gFSyQFor9jMECdy18uRcaMeDrTenYcAFS2HtoaBp5G6BlyR4ykIn9to7aJyKA314cPKH4iwnb1kGDNQGDpsOObyMIXapCGba1IRjkJDC92LWaHvbT4y70xDszPQd54iWzk8DX7atjEbCqKnjn5xmRUKm5C8o8v+Zjf6i4jBvoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916495; c=relaxed/simple;
	bh=/XwMelsvPfhSAzYSXbnvREe89vnzYupUA97HM80CZ6I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vz3VP0hqsKGE9vvRtJ3/AkF3kbnmPSY29/8+o9ABCmfUXauETRXG615eQ9UZjjvh5jmsk7bmubGZJIHowlvK7uaUgc6w61xSFD5Of0Rz44Jn7iLMUaoyYz/ScDjhRDpuzU6X2ckMmlDuepJlaVTWqCNqkQDJ7vGiJ22VFrBTNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RB7AFb+7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dx6Ga005564
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 16:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k5PbzKZOkp35m85qtYoHNE
	OjuNKM4TE//0ab2p+wC74=; b=RB7AFb+7LbvDDF1voH7I2W1laS3P2jqYWnIE7W
	8rQYLQt7vRH2EINIy3MfozVT/sFv2WoVFXLN6i0c/N97HYFM/L3LBuI+tPyIOoV/
	xnbTkF5GnqOml7xioQkbdPnH9WSJv4o8FQWyMq97odfxAXkq15Nyjp24Xmb8n4lh
	RiGbcOuSKa17Cc5WE8b48lkNyI6iDKZOodqP/sGM6HDcHVXUpCB1D8MYMsZrOEgX
	FjVFFZHcYEu99hEJjPh8trmavSdqDU317czk+/vbZzcQziqgYi0c2GHA5KmOwzXA
	RDxBVtW/pWsGNr/3K8QaVamP7zUv+144XzxTOAJwiC+CpsdA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjmate-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 16:21:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2f78511e6so1975071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916492; x=1757521292;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5PbzKZOkp35m85qtYoHNEOjuNKM4TE//0ab2p+wC74=;
        b=ndto86qxLTgmyC0wcVgyZJ+hFjIMHYDPCMaCyE8K3fpbC37wjBw677QCJKPEBPGEkt
         eoaE3qxdbzZ4LqFBs8gmmgWcGT5zBK+IgRfFlMmEuN0AV0l0HCYy1r3h4pj70tD3g7Tv
         Fc4sWTwjWHIOdPA+k2xuIOvRyGuoXNtlrFxjsSbKOzmzfJ3I9wELcLxF9hVirurjvH/c
         ynOwyUO7058PmIxbja0HP0N0bd7hSgbNcYu8n5MUnGhGILI3mcl4mLN5cHQGVWi3qR6B
         V9AZMQ0bMvJgQeVgPqq8TOvsP/OTEt4KGswQ7fHCGrjczUBLSP4dkTkdWUO0qUdrHTBP
         TChA==
X-Forwarded-Encrypted: i=1; AJvYcCUJq1D5axOHOYhTlFYg+1zZR6FuZ7fFnUYUzYrKqn5Y2/INA3Yp2TdCcfZtCtYki+NPor9sanMtBW+Ftk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNc75JjUGXTtxzc+7wy4pOcJma0xAENaOEqPpel0MkOBnoyzRU
	Q5Reh2pK4DfIkOUkrqsLxKumdfFbgq5deRWrbfBZLV8P/i5dDNEHZESBUAZgA4ZE7X2+Tx7R7D2
	YC2blAMc+T9/MyQ2shJ8sRmQatNunyWA0+CA03mM/8IQU/nAjhu68W0s2POK/JfGHyAg=
X-Gm-Gg: ASbGncvn+B58KLp5u+11Epa55AYoTVUV6APNI6TGSW9eZlIovGC5uDfNIlzCg68AGDs
	lNUlZfHBB5BjNc4XSf9mgsVdm7/+gUW/LD9zEXH5EKm3Jk0d60hG4reQSD89Obt1J8YdZPGTvbF
	Xcfl2uyZm+8urJ9TkyNMd/F3VShkrMo20yTJzo9fi8Ud5kN61f8u05UFtBe/mo330zs2KbZUUVw
	wmGQtCwNBNE03N+bJrOdFdZpI2X94usA37cz8V2WkUXOR/g4RnGWK4A1paRXu9H5xqOkn8ipYfu
	rj4KtDCve85QsaT2ninWpwTM/oN9qGwhZLhbPhWkjE/X90DPhee0u0AM69KvFJHTdQEWbrcwsAm
	hN1a94RmAqvTMsZsZrnmFCiuAmtownf1rI5oMi7DR+WD0C/pyO4aP
X-Received: by 2002:a05:622a:4c11:b0:4b2:b4b4:45bd with SMTP id d75a77b69052e-4b31da1da15mr230359121cf.46.1756916491461;
        Wed, 03 Sep 2025 09:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQO7Zb5ZFNUQGI5ekX44Q869rZqXPADpX+cP+v9JUz45/SAjx8a4XcPwHseb4bb02T+4/USg==
X-Received: by 2002:a05:622a:4c11:b0:4b2:b4b4:45bd with SMTP id d75a77b69052e-4b31da1da15mr230358571cf.46.1756916490747;
        Wed, 03 Sep 2025 09:21:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc24fsm608343e87.104.2025.09.03.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:21:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/bridge: write full Audio InfoFrame
Date: Wed, 03 Sep 2025 19:21:27 +0300
Message-Id: <20250903-adv7511-audio-infoframe-v1-0-05b24459b9a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdruGgC/x3MSwqFMAxA0a1Ixi+QVsTPVuQNok01A1tpUQRx7
 xaHZ3DvDVmSSoahuiHJqVljKDC/CuaVwyKorhgs2YZ6qpHd2TbGIB9OI2rw0SfeBLupZTt7ok4
 YSr0n8Xp95/H/PC9t4sQhaQAAAA==
X-Change-ID: 20250903-adv7511-audio-infoframe-8b7a2cf008ea
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=781;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/XwMelsvPfhSAzYSXbnvREe89vnzYupUA97HM80CZ6I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouGsJCBhmvT20e+NZ95QqZUUSF9nsimFh4Qm3F
 MHVzpoCI9aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLhrCQAKCRCLPIo+Aiko
 1TiZCACwylNH7Dw8MUT/MDJqht90uDrF13oB7ek+2lO1gt7AxdkaQopYKuenyYr2qWUwSXNHaKu
 njka5hANot6pmbfH3LTxwNpQK74RNF0fSePQ2AeaVgC6XN6iUBc5UNlx81QDtw5PrBAxKStMNiQ
 jBYxgT4QVdKz4tbSla+mTX7sXYveChsBigoWad5TQ99Jv9mNLXuQRWnHNdF4FLRiVl7hpG7RuO3
 SU0DMkx62nNEeU52tVhkKDNo4JItmdmgAwt325qIK6MHF7PuAw8rrlt5UsgSI4FNphfGATFj0ku
 elL7u6Lx7VcodIifRg7cDaw/5DkOYVve5TWSK68jF1/hENas
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b86b0c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VSjBEmWnoc6TdXOD9pAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: R2rwdXlx_LREV9vZiftgvhBSyoGBl-rq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX8UaHGIJatk7S
 9b7VEVHIorR4fYAErzgWNPQl7ut599rsonoCuzM+GsfKrxkzCeujVRC6UwwZGCNmliQ/I7s+CpJ
 R2eQmzljbAF2/I/sYQSDXNwA4AUhis3G/Ngku8zHysMAKyOoIuct/5aMHKKJVWIyB0To/XUPJ7E
 QUFyuSqtFl008jvPS5+mW0h4y01Y9JLhEjF5kbd2yCV4Y9pL3AOWzyRt/ikr6K8IoH0mqN/11TT
 OI9VIMVA5UBBj+7UzEw4+hp99hJEN46R28NMKT+wWtJEsHG9DdgfE4wGLhcNcHmvNnkbvlVd1vT
 Q9FEdZ1myE2SDiuhlKj+7YC8rHXIAVvBOuyyg8Ieb9k/jAoZqqktSPy5rse86J8sitFp8NV/W9X
 YnJJyd7d
X-Proofpoint-ORIG-GUID: R2rwdXlx_LREV9vZiftgvhBSyoGBl-rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Instead of writing the first byte of the infoframe (and hoping that the
rest is default / zeroes) write the full Audio InfoFrame using
drm_atomic_helper_connector_hdmi_update_audio_infoframe().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/bridge: adv7511: use update latch for AVI infoframes
      drm/bridge: write full Audio InfoFrame

 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 23 +++++-------------
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c   | 33 ++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 19 deletions(-)
---
base-commit: 36e626877e1d2b833bd453ec69044d7cad32f54d
change-id: 20250903-adv7511-audio-infoframe-8b7a2cf008ea

Best regards,
-- 
With best wishes
Dmitry


