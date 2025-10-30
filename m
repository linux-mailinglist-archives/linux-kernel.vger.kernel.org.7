Return-Path: <linux-kernel+bounces-878619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C901C211B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F3C4202B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA857365D48;
	Thu, 30 Oct 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FzI9ENtF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E23655FE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840627; cv=none; b=QBgk/alxZC0lc+eAaQM0zsz7HU3dX0+5oHuJWCCJxyBxdPWXlRulBmWtzH9dlzFRDoefU/VB4RQC4jWBmQNfUtY50byntd5ta7T1nzq7f42mSn4xlieGpC+aedwr6CImSTcT1DFE+ti9G3f2JZfmGQrMoiTd42ghXk5U1VqE1RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840627; c=relaxed/simple;
	bh=H4IwhcwbBrf3+paFzmD/85/Pn963V60WpXXajyPuM7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggFqfW5NIVSklJIGF8TzxbeiIPhCVUlGUnJu0ZIL6xEvdT15zekpeJvaiYJhD4fR6rQLlU0N20kgnAmgy0SVWuFh4YJ0iona2HMlBg7iRnv8fejJObTze0oYwvrie8jn/kg0zZak8drsmsllcGBfl84+OKcQlwa5enSO9hF29RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FzI9ENtF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso14574985e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761840623; x=1762445423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i47abyZfZz1bsH2DYwFEj9nyP4hs0s7U+jv9iT3E+I=;
        b=FzI9ENtFFNX9cfyHHTU/In6xKrq2LD888CWrLTRsYqerRFYltIGEG/CfqEMlzzOB9g
         0Z7RPha89b+ZLQo2O5qc0H38fuXOuRZG6ARJ2JzKFResnidZv9155guI3lv2eYn9SXVD
         Ky76bBSOAlraLemvxFr/DadNi8a12d6R0liFhnRSp6dcq6zJ9op8RycvSUxLNZAjaOcI
         rQ0aiQ1ONnE5exB2vbJ7e+YuyIkrwAM9GI8flynnCvRNeIxqSCOUKJNX4qhOxUO0yLw7
         tyRsIrZAIIYeRS8TN06Krl1N+ZwXDgdBRwGLYL9OlAiCILW/oClZAXFRlchpe5EXBGjB
         KtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840623; x=1762445423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i47abyZfZz1bsH2DYwFEj9nyP4hs0s7U+jv9iT3E+I=;
        b=bReQWR0ckGWZUg68dKJhjSiagJZwBOvs7BmKvIQltHqsrHF0OedFrJynLiv7g6qPhw
         a+XGVQ3li4itCznGo0wOZ8ucBsCsUppEIxpPdOroIzzI3OpU6i2fCfAxFBzNdQhBPyj2
         5p67R0ah6f7hjG8KC9ApOL8QiMEwCLxrPNdx3azPcSSKYQDKk5+Uikt2TIVUIBjg6US9
         GzryXC0Rwq2OANQok8Zp7oEotikvOCehdkcb1uMt8VMt3GnLYxjx8rCbJKkBhOFTOyYj
         rA9hW8kWpPnoQmuaISSgKDkW9BEcBBm1TnYovfvkTJ3+Kz3TfM8UnoDgNlj4c6hrPE16
         BcHg==
X-Gm-Message-State: AOJu0Yzz0e8FmJ7bIwtnxhuJDVeUqmOu4+jwY210svNtzhydvtglQ6iF
	4j+EUB5TEtutGW965y7hgdmDzanaMI4DgZI8HOJlzDZ20pPQqvgnjWmYf4h/bf5oX59BFj/TGyA
	fxWAu
X-Gm-Gg: ASbGncu+N1C/3+fdZyIzpSxW/Sq4M/ZCWGHO6RnN7UUVQCiJPT1BiUJvanPrRQS8Owo
	woR2upmHvGuMBex43hQYHbYOp/F+81Mi1ewYz3hwaD6MPpPOcBPSCQZprLSQfbK0XAbAQe/Kz1c
	rT49y4bF7A2ySe9aQEO7jQl2jZhddzmb1fvrx14I3NaxZNLbKGkxiUUlMQfJ0dD7dzHO0jx8+yT
	uEArOwaiCAUrKJtm7fEvpBZWXBbqLJgdw6idnFSGyXPkp2lmfVPTNeCTMcKbTlPECvI8WW74kOU
	cvHk7/sHDo2GKP/Ckw9vwbxGI8Fe0mKP570wc0TjrRm0jzZ8Siv/ftfivMaWKKTjUXHUOTWH+Zy
	KXWs86HbSD+R1CfzM7azcEmscNbn2hy6UcxNAhxXelW2hogdgjC3fW5OwS4THnj5rmtuzaz71nr
	wE9GE0BVMuNaSPVeE=
X-Google-Smtp-Source: AGHT+IGAga75c6sY1Q+McZyix+GUEVEkjmtz7d93ls2cdpw2dE67igG9rZbHtTGqPlGirMSJ37N0Bg==
X-Received: by 2002:a05:600c:8b30:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-4773086d57cmr2259475e9.26.1761840622930;
        Thu, 30 Oct 2025 09:10:22 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:22 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/4] drm/amdgpu: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 17:10:09 +0100
Message-ID: <20251030161011.282924-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030161011.282924-1-marco.crivellari@suse.com>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8c4d79f6c14f..2f8160702f9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4798,7 +4798,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 		/* must succeed. */
 		amdgpu_ras_resume(adev);
-		queue_delayed_work(system_wq, &adev->delayed_init_work,
+		queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
@@ -5328,7 +5328,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto exit;
 
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
+	queue_delayed_work(system_percpu_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.51.0


