Return-Path: <linux-kernel+bounces-883289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2721C2CF91
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1934188F047
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B3314B8E;
	Mon,  3 Nov 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XUq6rQOl"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87C313E28
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185486; cv=none; b=fNHKxms25E4RdiQZOTG5bET28XT+7evigu12pcLnUo09oINbiGuO8HZUc2lv3P4+1Ki+3skW1DS48+uKPqxwJnwp+HKLlholE9H2aXfRabWIoZeRnplo2EixUoIg4lvuQSpr9Fc8g2Fbd0TN2Mg8kuuQk+NN9QsE1fL635lD68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185486; c=relaxed/simple;
	bh=1ZTm/k5KUQWFYWWgkgQZ2OohMJ1gz99M7wrF8ca2uls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO8MY12vGYrimvY+BZ3aUeoQ7cZQvzpBR80Q3wGb2Zcmk3fvxWNVKVQmrLk1HEbCuJhFtQ2pPcx8tg5lQ6nF4zr2v+3N+pgabv1gvEWuyOvXqTZruJi9M4hPi1BEm7M4InLjXANfLubsyT8ko5AK+dQBXVZ9leV7lmtzaCcBHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XUq6rQOl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so2929300f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762185481; x=1762790281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k4OPahllBy6sUVh2DoEGWIyKwEqM+wN18o+bKA/lCY=;
        b=XUq6rQOlzfYfo4g49rUi8Oi+uN3E0CVOJxC+zI3/7WncWNJ7vKaXppq50MtXGw5fV6
         roPLeDFJnc8Aawm9ZjD4o79tgnYwcvxA4FytnaQlvADdtHv7GV5KwWUSuYUDxba9viRH
         UpDqnT3fKOmKOtPSj+tLGcvLRIAoTzaDZ1fQY6lew7Kb9WjWXGN4UAKnC0BzkY4bKtOm
         4iymNske/OdpEZrg5ca0sR2Wa3tGvnyeCBrOwMSiMJ4ONdv0kZwoCunFBHSFOyvv/Pcn
         s+nDcjRyLX7JqJgmfiIwmPc1i83AaOVs2kiq/AH94xkPdwVE417KlvJbzxp+wYxpu0GG
         +kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185481; x=1762790281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k4OPahllBy6sUVh2DoEGWIyKwEqM+wN18o+bKA/lCY=;
        b=EnDtpOq3TC/uXPvWw9fw164fckQUtouQGP3N0Dsjwp5/hdprmj0Ni2n1L9dEE1iAIi
         K1VRvZUXrOGy/cUOnoSXIvJSEPh8Q2Xq1tjChytJpDVjyeK1deuGGKWkHjlD4iaB2hI5
         MVi0AJYDuPzAZ9qSs2hb+unoGekISjySexnlzHS9iHWx62Am45s4JIA1NHNOjq+iMtU3
         21F6GGIGy4CgRq7NC1x/ZHyNr9751kbiXDI6+ij9zYrMGyS4ddmSbCvTKQCOgunm8NIe
         D415e4Q84ctTrr13LM1d8bkAA01VU9746/CK0C0iVQ2DFgpstjStWMKFMq/x/ndqEi+d
         Sauw==
X-Gm-Message-State: AOJu0YyFEz64SodJ6bt1Miw6oYTusJbU3j13Ug87Rrm//7ZEZiLVYgj5
	KWqT8oEAN22mbd67TtyNQDitR2ON24oDS/EQzeIS0McLzkFe+GmWFpb0G5MGMK2ydhdW4+vsAZn
	6PhU6
X-Gm-Gg: ASbGncsS7erGA991K4ffAVoHRkhTCWy/9GlWCJwCH2bkhyUOKv8fsrCfOwdga8TlkE3
	rO1nmWso1sL82f4KghuqPD/uRz1Ae5ey3NzjRd/WdUpFC+z6VbT8VO0xTWVa2NT2m4rOKlwGRZc
	kkXifnwcW/CaCoyAxEICipkv93ftfrE029ajYXfL+hmHrBjRXzFIbReDw6PAluogwvM23JbBe/G
	aiPQP8I5EGJfqPsRrSORrZ7WhoJhE50W2BsYtV0egoF/1QwHBGfC6ck/foLsxweukuTVYhUtHQA
	PufPqzOC4fj3vVQc1ZEUHTzCLf2uuSBMm85A/4OGFojqwQlVBKbtig3lTVZqyzYmn84PYfw55PN
	4ia0tArSa60tFk0NQEORTa0jR4MeYLY2kqVqSTWDxVeei28ShGhmaBX/9ewfRSMS+OChQyZCj1y
	oQxEN6/9Fbz0hH2tyVe5K7Gr4Rnoquk8VoJVLcjM25TohirQ==
X-Google-Smtp-Source: AGHT+IEsAP1CwoepaQ2zRH4SCp73+KKlXjJIFyjaJAoEgcOUpETiFrS5vxDtmgLOOrIYEIDu1LsKXg==
X-Received: by 2002:a5d:5d13:0:b0:429:c4bb:fbcb with SMTP id ffacd0b85a97d-429c4bbfef1mr8526566f8f.28.1762185481404;
        Mon, 03 Nov 2025 07:58:01 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:58:01 -0800 (PST)
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
	Christian Konig <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philip Yang <yangp@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu: replace use of system_wq with system_dfl_wq
Date: Mon,  3 Nov 2025 16:57:38 +0100
Message-ID: <20251103155740.250398-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103155740.250398-1-marco.crivellari@suse.com>
References: <20251103155740.250398-1-marco.crivellari@suse.com>
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

system_wq is the per-cpu workqueue, replaced by system_percpu_wq. This
specific workload does not benefit from a per-cpu workqueue, so use the
new unbound workqueue instead (system_dfl_wq).

The above change introduced in the Workqueue API has been introduced by:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 041ee35684ed..fc61802444b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4805,7 +4805,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 		/* must succeed. */
 		amdgpu_ras_resume(adev);
-		queue_delayed_work(system_wq, &adev->delayed_init_work,
+		queue_delayed_work(system_dfl_wq, &adev->delayed_init_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 	}
 
@@ -5335,7 +5335,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	if (r)
 		goto exit;
 
-	queue_delayed_work(system_wq, &adev->delayed_init_work,
+	queue_delayed_work(system_dfl_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 exit:
 	if (amdgpu_sriov_vf(adev)) {
-- 
2.51.1


