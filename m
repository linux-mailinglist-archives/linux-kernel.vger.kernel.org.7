Return-Path: <linux-kernel+bounces-754212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A0B18FC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC1CAA0F99
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E32259CB1;
	Sat,  2 Aug 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="M/124paJ"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A574257436
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754162764; cv=none; b=c9ARqdHY0FdnjF1pikYg8d2Hs6mBy6uuCjB9WokqtOl5WDYeKxud5YvvXiiEahrM/SAt6cX0AIqY6bihjXzgTiQ+Jyq26jdCIgHl6exHQfkpictfTGnc3PX+Sw5PUh3g+MKy2zywl17SLBIb0knwLUaRyg9BTLrBYbgBE1avQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754162764; c=relaxed/simple;
	bh=iYFZqe0FJwNf+ajNL5XFSo87/W08KOgeD3yFN7dsGdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFe6PUp7dvWs8XkaFSU2B6lgGhoMOtN1Pwvr60QGTcSQJRYexEFtF67uDn2iDpGLDHOKnMYb5ko7SQ4VCC7KGgUjur0nvR4zknOQlyspJE2pWFSad3kQYe7AoCmli/vH6KyuNvLrOb11szJAnNSKISpK0aV4NVEqZ9q5DZ37cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=M/124paJ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so2148645a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1754162762; x=1754767562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=patF50HxwBAOhfbawHD1F2SI7QSAZ2zNgVR0o2+WGJc=;
        b=M/124paJs2TXny55r22AHXDQEBNhQ7aLHOiOLwwFIuNDZB1HXVrkl/VIoTu7yVmTB2
         Cf7w1wRZR3Sqc5J3NQCJ5GC2qOgBkre96G29/FjJOcZ1DFagf6PRMBdRJ3F/4P7MyRR6
         nH5sQ0I4TO9fBe+QQq5pyJA4NZoCL90lCnuBHAz9Xs0oxNNCFAgqcqK+VxgkKrvIVQ7A
         juYDOge1GQH7fov0wKhn7HiC0OCmISjMPngn1cr8U1BQ5GDvM4KvXIOsdauORL/ZrK/z
         8JDZmvY7HKWkYT52q2KDGNmBWIAXAA5OHKxbZXmXBjsn8EZcfgm4AwXa8acTNwMBOf6m
         vgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754162762; x=1754767562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=patF50HxwBAOhfbawHD1F2SI7QSAZ2zNgVR0o2+WGJc=;
        b=kt5htu5vsXW/rXaUDR3SDdaZnMrx+MMUOpeCn7LLCoX2AryZX/oHQDrDoLuGgzpZ29
         KLVNvDNTDjmuNYJ0fHnHeGJ2WaQHO7wY0f+Go+LmHmHJhGvXs/W0hSmSPpQQoeKSR2np
         ZlhEypba+bn0OP+U00hGVO5UHYNNX3No1SbLz+RHwHixlT0HFVPisD6SnbQcWINpR+8p
         bVNtQx1jMXWdrFhciPvRAvMWpl89tHjuT1EJ611GDBMkKI+muB/Nvne3kPgRm230NeWz
         3wuQZ5Ivd7rwScT1EO1nvBwwmVFhk5FcpsSVU3/7CCgJhKBzsKuWh65+faO5+T0Qcr6M
         ZCOw==
X-Forwarded-Encrypted: i=1; AJvYcCWoIVbJVldZJJzJ6En9y+tCuFkKv993wk6dEbvSF3MID9xVmRNNnlC1bNcTHKzhJDT/hSK3B3bj+3u0rQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgjj65Ma3IXVQvklxsFQ1rZAuIgkhaY1WspJx0e1t8DIujl3c
	qk0mxGX8uYa5RTB2PJLJ8NH1eYadIogGMPpjAVHjadjBsbytoUk7tuWT6pObtm8jU48F2tUiFlH
	JoTgM74Y=
X-Gm-Gg: ASbGnctxiL7PrDs6CoeR6uB91EzjOhCr5I7tiVy1OXUR+6VapGBpFl3i33MaE6gK8zM
	e+HdFAKxdqqLOoVBhaEbouAM8yMAmWlwXDSOTTkdZc/UE+3DZMP99YhPpNfSnUwjjTZRUzzXa/C
	h0Ci6d1ImKcRt7GZe4i3C2w6wY+TCqyCQPb7Z2BAEJ6/B6weZvKNMHxDNpH5IHhwgZ3Lwx+yuNS
	dNmoxlPK4UCSwHYgTI6co0zUbGg7RN0a12Ac6j4IOt3IdkI70nUjWFkG5V3I5NdlneGQZgtNoAT
	fOTNC52dLGmsYVbRpafyYAfpaaiwn/C5lL+Rz1+FF57kKfbecB9HHzewnmi3gHcHVdC6ofySEuT
	Rp/NlOH4u4Gjg+W0ZSBoKMzaRz8bzIwkNFC0=
X-Google-Smtp-Source: AGHT+IEUNY6RAxyfm2o8WI4OeBc0W8xJUgXWURl0s22NPmAoZ1ZpBLFdr2EyazqR3HO82uxLuqL2Qw==
X-Received: by 2002:a17:90b:53c5:b0:31e:f397:b5b4 with SMTP id 98e67ed59e1d1-3211629df4cmr5741060a91.22.1754162762276;
        Sat, 02 Aug 2025 12:26:02 -0700 (PDT)
Received: from mystery-machine.local ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6bb8sm7887583a91.4.2025.08.02.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 12:26:01 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Sat, 02 Aug 2025 13:25:46 -0600
Subject: [PATCH 1/2] accel/rocket: Fix Rockchip NPU compilation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250802-fix-rockchip-npu-build-v1-1-fb0f0dacb3fe@brighamcampbell.com>
References: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
In-Reply-To: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Brigham Campbell <me@brighamcampbell.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=iYFZqe0FJwNf+ajNL5XFSo87/W08KOgeD3yFN7dsGdc=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ0ZfmpvMtp8XL+wJKPaa55a2Y/8OLnU1fccyu3VHF0hFN
 cWcyPreUcrCIMbFICumyKJya5b6xcnWjw5G8E+AmcPKBDKEgYtTACYycSbDP72cuKMr9q5a/+7Y
 umopowoTD94pHJ/elRnqHa14MbHQ/C3DXwHzdV/2T5oWmCJykrmf/SEbh+R8rRXTmVs2bfRR2aN
 8iwsA
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Replace DRM_GPU_SCHED_STAT_NOMINAL with GPU_DRM_SCHED_STAT_RESET, in
accordance with commit 0a5dc1b67ef5 ("drm/sched: Rename
DRM_GPU_SCHED_STAT_NOMINAL to DRM_GPU_SCHED_STAT_RESET")

Pass extra parameter to drm_sched_job_init, as required by commit
2956554823ce ("drm/sched: Store the drm client_id in drm_sched_fence")

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
 drivers/accel/rocket/rocket_job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e731da15ebffca12e74035d2739a666a8e02d747..5d4afd69230623215e3105da7153d2d010636d52 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -390,7 +390,7 @@ static enum drm_gpu_sched_stat rocket_job_timedout(struct drm_sched_job *sched_j
 	atomic_set(&core->reset.pending, 1);
 	rocket_reset(core, sched_job);
 
-	return DRM_GPU_SCHED_STAT_NOMINAL;
+	return DRM_GPU_SCHED_STAT_RESET;
 }
 
 static void rocket_reset_work(struct work_struct *work)
@@ -552,7 +552,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 
 	ret = drm_sched_job_init(&rjob->base,
 				 &file_priv->sched_entity,
-				 1, NULL);
+				 1, NULL, file->client_id);
 	if (ret)
 		goto out_put_job;
 

-- 
2.50.1


