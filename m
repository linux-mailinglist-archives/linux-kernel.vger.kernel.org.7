Return-Path: <linux-kernel+bounces-858685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8782BEB6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA33B624CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDC2566E2;
	Fri, 17 Oct 2025 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiTm0Tj2"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74823A98E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731230; cv=none; b=Pe8Fpa1Gxw6uecvSmeuXuRzxP/MojgoY78+SxnMx3WFoszN/pDKqdVeE95fv6cgF2g6FR1nr23K2jobMMBvoCuKojRq9MZDoCFHRycpzYg8d4OpcNam+0RzY9gUiNTeVtHWayCyBJX7nFIj/C1mctmgh0mYYnV0amGp6a1JMsxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731230; c=relaxed/simple;
	bh=l9a8wUxnUFKjAxqJPfeNN/SOxfzcybhdFcIL4XU/Lq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzRUEHBXG7t9EaAci43T84QMrbqzoSHg6xrQ2WHrLFNl0+PoIiHRGNip/NmvoquWkIR7zV/E676ob/6BZ6SHlrcvTEYynSkN67MkAK+GXRI6P5vYiOcgMCFfuDGejohIl07pstzLRJLVE9cAdlkPnxZs0bEFFNbnvxyR62h1T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiTm0Tj2; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3612c38b902so21584811fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731226; x=1761336026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7XqOWl1cfsF52QRqm2uO00zKVuXynKW/bvPOkip0X0=;
        b=JiTm0Tj2DSi5R7TX7So6hieCFl7rQPQ4a/tGMVDgIfYP4OJ4JTae0EXFcE2wtaBWZ+
         mOMULhN6uWglZUdFceH9bih+nXYNOmfHsr2VCTh6kDjutf5V8G1RbCXQN20OPLXc6NQK
         3tj0J6u28plgIPQWk1yxZNMD4AByAJyaFkv98J/ym0KP0Hlu3cNl3wR26avUHYmRbhrj
         zH1LGsKOtBEDAxRCuxix0w8mAufqNaPqmL0KDzrsq8jcNmHscjOmn716IuOmtYYQcGMd
         2UkGyKUzt6GXGydvvDqlRMMipE4I7L0EqUkbvwEDeeeULlVzACsaa5XKQq/bHMlA0Lja
         O3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731226; x=1761336026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7XqOWl1cfsF52QRqm2uO00zKVuXynKW/bvPOkip0X0=;
        b=WSm9SjwsN9y9GRC52cmQLA3Xf/FcWb4QI+zT4QLZfRCxd2jhjQm8U9/9gZvmBQa/8/
         FD2vANpqrO/r92uLCfI3wpLnD/Ot59FBzypMh+4vSKDPHUyAk2FnY3SvxOWlI8CWDCVv
         /GJIz9fUAnKhnk7rRilpxmQIqK4yszCUr+hIPx0oX+WBJ5lCIiEaRgmY5AOdOtaEpwk8
         k7bS3T0QxLvdMlYlSKmsAPzMsS5CBcE7ZcMqqB7HMuzEMN7PIGJHGPDe3MyfjBFTA6ok
         K2Ml+Er88ExlI2dVnTujxiuYD1KByTssuwcEMPuo88duwR631/I2a/zusn+dh9TuyxLQ
         nUxg==
X-Forwarded-Encrypted: i=1; AJvYcCXKdkdFfIlPI0D7g+aN5dp89Gf6FxXUrcetmSJ/rRzpbDO+mwVs9E2wWUHHvpb7hbyHpqcBkQOP3HnYSvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKbhF4EdlKY7N13xoRVDGgmImGAHnOzODeVkgB9d02POASCwT8
	71JYs5LoXQGeuzJ5aArWQSfDNqYoimrPxnTm5K8/JPzo/rnphuLq9O7H
X-Gm-Gg: ASbGncvkbDFj8KBOwOol+y5h4mkXBxLvlFljLL/WGlLyFxijHuiN9C2RDG2C0AKHjoV
	i0BE342ZwSawuxYM3vcNr9AN3DjbjByRLPUGy5N0BuXPsnnXWNYzebx86mq7EyEN30Mgka/XGkd
	7HUSmxLBr+I15s79evSV201jpza8l9rw5neptgITbP/lpn8rnm8+pkZJu54VefWilUadWlMdC5u
	s2sRdF9/YEOQ7LyikrfVp2Gda+3sOuMtJLjQTVUBSokZBFeY7uePj53p2tqDFFMjmVfMWvPAEZM
	v1a8txAzF+HjV1tNxZCyKqyYzBfZmuJyJquhy9MbjwTd/zXX+EIrRA7NtcAs2az2YbPqILQdhQe
	nCNw6BDux9dwhzpdCOSkr74I70d+EtxGTI7jUlIRID0DZSl8jty2XGXWIg6F7Cpo1BfxwoJYjdu
	J7H/+3o6A3ua/g5GgHs1YnGDJiDYCorS0dQg8G+BPnf2RttO/2ilo=
X-Google-Smtp-Source: AGHT+IFrm/3xtNQT3MBQMvkncf7kZPyKKqAIptXvvBOXIh8nfNhykS0BMD1amwffzbPJvG3jZUH5AQ==
X-Received: by 2002:a2e:bc11:0:b0:36e:f1ae:d4bc with SMTP id 38308e7fff4ca-37797888c0cmr16609961fa.14.1760731226308;
        Fri, 17 Oct 2025 13:00:26 -0700 (PDT)
Received: from [192.168.1.244] (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921d99bsm1580861fa.22.2025.10.17.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:00:26 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Fri, 17 Oct 2025 19:58:36 +0000
Subject: [PATCH 2/6] drm/msm/dpu: Propagate error from
 dpu_assign_plane_resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-dpu-fixes-v1-2-40ce5993eeb6@gmail.com>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
In-Reply-To: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Kalyan Thota <quic_kalyant@quicinc.com>, 
 Vinod Polimera <quic_vpolimer@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.14.2

The dpu_plane_virtual_assign_resources function might fail if there is
no suitable SSPP(s) for the plane. This leaves sspp field in plane
state uninitialized and later leads to NULL dereference during commit:

Call trace:
 _dpu_crtc_blend_setup+0x194/0x620 [msm] (P)
 dpu_crtc_atomic_begin+0xe4/0x240 [msm]
 drm_atomic_helper_commit_planes+0x88/0x358
 msm_atomic_commit_tail+0x1b4/0x8b8 [msm]
 commit_tail+0xa8/0x1b0
 drm_atomic_helper_commit+0x180/0x1a0
 drm_atomic_commit+0x94/0xe0
 drm_mode_atomic_ioctl+0xa88/0xd60
 drm_ioctl_kernel+0xc4/0x138
 drm_ioctl+0x364/0x4f0
 __arm64_sys_ioctl+0xac/0x108
 invoke_syscall.constprop.0+0x48/0x100
 el0_svc_common.constprop.0+0x40/0xe8
 do_el0_svc+0x24/0x38
 el0_svc+0x30/0xe0
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x198/0x1a0

Fixes: 3ed12a3664b3 ("drm/msm/dpu: allow sharing SSPP between planes")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index f54cf0faa1c7c8c00eb68b8b45ca2fc776f7f62f..d198a65a2c5fef5fbdebc9c383a4b08bc71b8bf3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1278,7 +1278,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 							     state, plane_state,
 							     prev_adjacent_plane_state);
 		if (ret)
-			break;
+			return ret;
 
 		prev_adjacent_plane_state = plane_state;
 	}

-- 
2.51.0


