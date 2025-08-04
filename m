Return-Path: <linux-kernel+bounces-755691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F835B1AA7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF5176765
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899723ABAF;
	Mon,  4 Aug 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1I2kJOX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C3218AA0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343803; cv=none; b=JaobhtmtbI5Ie3j07TZcnTGDt5uyrLfVmUufFcUUD8Y6Fx6BEX7pqu1nMrZxgmxaV5az0ZVlV8McZIs9nt+3awgt6LgmnqR/p/tyDA+axmFIIM55f3lBu16to28pt6CCt2VZWq2fdHaGFk4cg6taPT3CZ36R4Oy0IAKZx7tPGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343803; c=relaxed/simple;
	bh=Clo23ghhSm2S7QltgVOxt609m/8rT+3RDFaZP5pLYcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qriofjYeAGFnfYdStYg10L3HCIKOKEWxTINrxRHFtTZnqXjIMIvXvy3E1wqSw9Z4f+EKk8TPEyuw3s+yZzV8Cwb1gdqjIwNVC1h7vqWeUu2hdqZem2W7wV/f+O/WqHLAu3uH6u64xRvD5zUqvSjfIiEMcOtEvRnp3FjotEKYz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1I2kJOX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574HXUSZ013637
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 21:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Es8yYGkoaL9WsWMGWRUXzp1VH7ftdQ84HcS
	owvwXJBw=; b=U1I2kJOXu5Ur4+sTw5Sjtrk6MaCayoLLEJ7Y3QgF2BJtdTpyCSy
	1ibQv0Xan7sDVGeT5SdNiPJfB9RfP82+zQ/K9kDoHoXQGb8fS9s1DFhAfx/kd7Fe
	KyWn42hhOhM4+kZcA23Ky7/8+f3sYt+Mk0ZdOWAZz6dqS+Oh3PTBDlhoYCuPzyH+
	f49Lgr7QfXcZf8FLh4GrwMeWeknEt6yzoZctsFOi8HsP4nc1D1/N6L2YJ0zc3uId
	gVTOQG4nijVeiO4XrLNcpJhoq523VzB+QZqXEPAYbP1HU+lfhL/hppHEdsuWkC9D
	1dkCL0sQDAUSfSDhwcRjeeuSOt7vy5yLtGg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489bek6b36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 21:43:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fd8c99dbfso38138045ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 14:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343800; x=1754948600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Es8yYGkoaL9WsWMGWRUXzp1VH7ftdQ84HcSowvwXJBw=;
        b=YLWkfeZex5xhwvThGQKQnABy/cQlr1Gb5KLb5+oMXPGWLuyQLvSm/Re8XTdm4jNaj8
         HTS2QJmsJxVCAYUq4AJmwCtesEZz409BqtNwG2eVku7chFQyURcx9FWEDOrh6WxXYfNt
         X2AARxgeu98/9zhFtiZy3hh45bcOQHRgk7xJzQwYenG/gywxoyETKbHOyB+jiiwnmo1j
         Lqf2O5hVbYeK925i+M4JRifVvRLkgS+4V84ksgj6lYC6D/yKiVKGuheYzJfMZObbpi5s
         wXF0xbIuZTGlTgCvMSMoBfagNxMCbvnablTqIUZuoX89d1jPHnAcNelTHqXw6V0QKo49
         Iqpg==
X-Forwarded-Encrypted: i=1; AJvYcCVkFaAdvL8s+imGDeS3DJ5PmDnSYIXSn+BxUJP/XWYLsWGB9mNeAVbIf3F2PyGtwtQF5B6UxMeNtFjVWM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmtg+/fnkDecc5kU6vEKD634nwErMbL4v7c1LCoPLI/gdyczlx
	z/Z3zFCPMFSs+vqSYCjkd+dbYsuMeGJ2qIM+yUe+BBay176Se9/T1ULsVXrJs1ke5JjZbZwvN9B
	8PmDBnkToD24md00Bd8gpk03+Be9sief0+PqgOsDIeYB6eb6VadDa6wQOlpLvluSJL2g=
X-Gm-Gg: ASbGncuYBKZqNWSYNHzEmi/1t7g3nAkAwJVyPB8mPu7S1QYbrkZMoYZv/hy7iHPpQfS
	2WuQQSl9HFf48PxCPohfDu4TuXkwAjf+/uZryG1ptHvxFcAN/HYq2TrRWgp521ch68063lPMsTS
	w69VUbKcqMGW7lMGjJnn0nlroLSnzmBooxu6+qOv+56og1Izt1CpTi/3vwLmxBz6D8kvTBLBvA+
	DiEBh+i5VrdzcaTHvyqtxKHP1xg9X7EnlgVAm2U/AYu3330sAnkW/ClqD08YrxSSxnGyT9PXRPy
	R6v1Q/REUhFp6NQhCXRhGeyiBTvJhrrlcmHBdWKWLgE41Qhn2z8=
X-Received: by 2002:a17:902:db03:b0:240:a559:be6a with SMTP id d9443c01a7336-24246ffc07fmr168919775ad.34.1754343799949;
        Mon, 04 Aug 2025 14:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMENcFBVOU5CPFNiVaukbmJxZDsOzIZHTpJidiDWnGmFiPem5d1xxZ1nYXWM9QrZ0SYd5T+A==
X-Received: by 2002:a17:902:db03:b0:240:a559:be6a with SMTP id d9443c01a7336-24246ffc07fmr168919345ad.34.1754343799505;
        Mon, 04 Aug 2025 14:43:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cfdsm116217775ad.101.2025.08.04.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 14:43:19 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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
Subject: [PATCH RESEND 0/2] drm/gpuvm+msm: Handle in-place remaps
Date: Mon,  4 Aug 2025 14:43:14 -0700
Message-ID: <20250804214317.658704-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=68912978 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=r9eiMqSCUvIwoLEqkV8A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMiBTYWx0ZWRfX8DgWzTjNIrrf
 rKUNrjsuvD7fxbY8tBinNIz6Zg8Qdl97V4Zmp3yrzRFYAWcIxTSG0AmnJtp+r2DJ7hZCI32966l
 NJVEmorOAarYuE5gUlXf1lqesEONF8mNvJ+ZUhb61km3xQS1SdYtH9sLAE/S7sAEmwN4lWH27Qs
 Ap41RqrN+WxvnjHW5NqeKggrkSFX7A2qhzoGM2DhOTSsG33yEVa7qbpBEPg8u67hPukkJ6PBljd
 zxfpP/2tFjlWeNyFyZiPdar/Yj8G/Cjmzn9MBzZMGgl5Ef7/5Iyhp1SVFQl9z2tcg8m6LPVxMo/
 XHY9vlJM/DRKdWGrFRhPzYAaWyHtUPzzLE2GlmZRoV/JXrvMS+nwbn/qXcQdNOQ0UWRmenjg7YP
 crezx+HBhQtdAWKuHIRQNn8FIUpf7gcr69niHosk/52RBL4OsQjIBX0jQOqgDRwU0zaVAadP
X-Proofpoint-ORIG-GUID: tfc6HnWxxna23IGhfFNjrUQZN18VyjnD
X-Proofpoint-GUID: tfc6HnWxxna23IGhfFNjrUQZN18VyjnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=750 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040132

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


