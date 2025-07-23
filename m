Return-Path: <linux-kernel+bounces-743248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEDB0FC85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C6C16C3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8427056E;
	Wed, 23 Jul 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BKX9qAAC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C81E7C08
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308745; cv=none; b=RcgZvT1O82p/Mq/NvG5zHi9c1tmTDZWyknUFh+SM5sIN0Q2k/ypU8XqMyy9FM01lp3Luw482EMhOfOVVPSmxyR/JPHzwLPaavlQ45WGw6lYZRu5Dbj2R12DR9Uw4Toz6WqlXHMYRGzwcKwaz/izeYM/ejD5AjITREtF7aTIijUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308745; c=relaxed/simple;
	bh=Clo23ghhSm2S7QltgVOxt609m/8rT+3RDFaZP5pLYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3qisKD7RqpPQHF8fRPYqbI5HRSJ55ap9xWFHpx7Ptlm/904nVP0u+DoNC+FCHcpcsL0c7E8RQu+zLejX4iGepA5fRn+okk9blmTIH7cDwCfgDInxKpU9xYF7VWJ3BIj4uQAtcEsZBhNCcZ8lDgngG9OuFeFc/PrLZlpYgm6pfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BKX9qAAC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGxBbB004853
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Es8yYGkoaL9WsWMGWRUXzp1VH7ftdQ84HcS
	owvwXJBw=; b=BKX9qAACOypq9Ag3a8Xu0cg0OGsi6d8peARGUYNgHeyAeVeMLC6
	/d5xKbC77jzx63L3x8nsw1HKEHHaiMNzoptPWhtADvfZ2+VS9FNxn3e969zHmbrx
	ZwwpDowpS/xwL1f+JeqfdOX3wphq+JUArvuO5wMHQGR59Wb1FTf27Y2F55dxi9PW
	E5TqDpnUrfo+rEwAVKUbMwmHFzqxOY8yDh6ZVQj6Qv9yyjPxHbZu52Jj49o3w9PE
	0OmYQxXFjwj20Gjpo5/3v/CyLdzceHWam08SQwgiv98y/jpvKh/pOmr2ssoL55ol
	n6Rd5jrXEgHQv6Mgdz9VAhQHCn7hZHYJVFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w7tve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:12:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so298036a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753308742; x=1753913542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Es8yYGkoaL9WsWMGWRUXzp1VH7ftdQ84HcSowvwXJBw=;
        b=MKhRqB0GaEXxllVqOAr6b2jIU3XPffdcJ2c/BAtUkH/0dwvlPPWY3aQc6WePLU0Z6d
         ZY7HqcChUIlYkDxZbBwxIn42ki6TbD2V8QN8vDilca6fhVsOiygz3Yltw68dmo6nOeGf
         BW5au+2g/0PC2y84J1MT54HY2UMflxSb5fSeVgHToeazh8xijeto8ubzZQ6ODnhXqvaD
         dX4jUm+vM5e/6sUDNF6w2e7jOYl9G5GrhNKTTh67IJ5PAX/ZGQnBAJwcwFktdUg0Qtd2
         ek9tyBKXXRdCXsSphx5PsvpMaxrdjAggbHvlhaCSTlUpgdVCbjtv5mvooHAtGAprgKG5
         GRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHow7R++L1mRd4uA7liVy9cpAtcBugVXU2BKaL7ilE6s1M6wrEzmXJY6N6fmqSQPYz+NV2kOn1pqD4xsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0TeoT5smd23xj8+WCogk9rGjR0syRwJeDeN9dYp6X84Og+rk
	L734hGw68fRsPd6aksJ7lSy1kVFARtHskBlzGv6ZWtyg6yCb7Csb64DIJHklbR3rg+32qtjFjXc
	PqQ8ObZJTFLZ0Pa9MovDL5NLUR96T1IbcV8oDUnegNWuEi2LqkXiPCqNGm/iw2aNcJaE=
X-Gm-Gg: ASbGncsyr38G0tZye0dVjqojZlZ/BTDkFvbEEJA2hx8zyuYXCfDqLgxNN5SlRnbRsfg
	hFrKbo3Kr/Nt1FFuOP7yxkKqqq7qbS8xz9GjcHeRgcO5S8WQfQRPoxLRHvnkwvKIO8E+V0jaTdK
	eQsztgg4h2O2d/YgH6IHJHJ2bTIulYVw751x469YL7kS9ZxE/AgNv93cU5l3Up2RGlRl5lHYe0c
	TAJ0YMxMeuhvIP/d0vCbuGVaPeLJFuEv1WGZTYS0GSGJvSH65se9tG1sglnu/pXh0w6SaaLOyBm
	mC2tnD2NQh95yAHcGZULOI/FhZcrj+hOK87Ic39yEb95VgV17nM=
X-Received: by 2002:a17:90b:3d4c:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-31e507c451bmr5990906a91.22.1753308742098;
        Wed, 23 Jul 2025 15:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzd56I31a4tiJMX9/aFKEr6IuO0MhOWD335Z5swX27LPpZumR9v/x7YlbWBlBa4lwLXzCKwQ==
X-Received: by 2002:a17:90b:3d4c:b0:313:f6fa:5bca with SMTP id 98e67ed59e1d1-31e507c451bmr5990882a91.22.1753308741676;
        Wed, 23 Jul 2025 15:12:21 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e639f6c1esm72938a91.14.2025.07.23.15.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 15:12:21 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Danilo Krummrich <dakr@redhat.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org (open list),
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maxime Ripard <mripard@kernel.org>,
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS),
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm/gpuvm+msm: Handle in-place remaps
Date: Wed, 23 Jul 2025 15:12:10 -0700
Message-ID: <20250723221213.36325-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=68815e47 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=r9eiMqSCUvIwoLEqkV8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MCBTYWx0ZWRfX/nUXHu9UpWH5
 4iN3ISruvHWXx64bWpzOTpsZiMXCg0UJ0CmaxPIyEMs+JVbEzcU9vWVFYNj9nVkoZj0ATGHn5cS
 8wFstmUBTVlozmOORivFYUZjkFBW2tPDPIiLKe/R3x2F96vxVjdNR+Z4hyFgQIUD47ssy+3Opn3
 nfdBqqT4H9ifATnC79NdjLUWco1GGyuRZU4Jb9PLJdx7khgHdg6ezeyedhOHo2hqAawP20nV7AL
 eGVfTPShQrmaARCOlTY/t7gLAhwDio0of0ACulHgX5DCNQdBHBETD7lAZwsgrtQLna/Gey1O5mW
 9egq3UVySF3xykHgmnER65q0XqfNoawJDshl8zbaAP3Ku4aDh6QVvDG6/r4JGauksVRo3iO7pGt
 XdK+xmhM9N9lnsJypIxoHIW11Q/ZUOV3MfvBsXSnY6OC1oQAzqVvACBNsVK9+dz+L4F3mjip
X-Proofpoint-ORIG-GUID: IAoL8rLUF8YEIaLltY4aWlj9keAT2huA
X-Proofpoint-GUID: IAoL8rLUF8YEIaLltY4aWlj9keAT2huA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=753 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230190

turnip+msm uses a DUMP flag on the gpuva to indicate VA ranges to dump
(ie. for devcoredump).  In most cases (internal BOs like shader
instructions) this is known at the time the BO is MAPd, and the DUMP
flag can be set at the same time as the BO is initially bound into the
VM.  But for descriptor buffers, this isn't known until VkBuffer is
bound to the already mapped VkDeviceMemory, requiring an atomic remap
to set the flag.

The problem is that drmvm turns this into discreet unmap and remap
steps.  So there is a window where the VA is not mapped, which can
race with cmdstream exec (SUBMIT).

This series attempts to avoid that by turning an exact-remap into a
remap op instead, where the driver can handle the special case since
it can see both the unmap and map steps at the same time.

Rob Clark (2):
  drm/gpuvm: Send in-place re-maps to the driver as remap
  drm/msm: Handle in-place remaps

 drivers/gpu/drm/drm_gpuvm.c            | 21 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gem_vma.c      | 17 +++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_uvmm.c |  3 ++-
 3 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.50.1


