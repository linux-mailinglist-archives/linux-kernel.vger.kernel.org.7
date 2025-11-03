Return-Path: <linux-kernel+bounces-883287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB25C2CF80
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1282918876C5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF063148BE;
	Mon,  3 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X4VCLeDY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803D236435
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185483; cv=none; b=tFrm63Z5H+qJMZpqoKNiG4P0Og1/BoYs9iYL7w9+4KnOzGOlTJlZu2nGFSS/ksQCpaEAUKpOgbniOS0ojvpGGUQjL1bBTBGY0P+7FHQJty6HR9c8cvHczB7cHMlRrqwp0jP1brJ+ji+M8/BC0spfaiN9qjIFIExS5PxQwmFcArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185483; c=relaxed/simple;
	bh=ASaFrKSeGmeEjuoYeebcZL1Wax3Z/nOy99EM8zAWgVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcNLmNmnrccv4+2oVFbrmZLgFi2vTusKT+PLlP1SJjPDHWtoUB58ufefZW8gRN90362yOcVNaUd85zPMy94pmRcOY1Lf8a/pRVwAsaAO8V55KSQ/iVhJltC6vk/jbaBijNnYCiRQQKHjPz0vMS/VoukLLQ2D+GoZp8rk+1a57Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X4VCLeDY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4774f41628bso5494695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762185479; x=1762790279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ848GCsaR34084rjUbaciLlgRfV9nM886kentzS7Vc=;
        b=X4VCLeDYnKsXNv+7DKDOnlQo4XxTSGTIBmPl6wgjDdKeh7bnizlK5FpehKGUi84JrS
         ouUErh9pHCNbrmQoWOWi1K1br5r3qkPF8f1JT73Kg+99hzQAOqRUnMCXibgh/GwOh63V
         7xfJdkmbSFG+Scoc2TdFeRI8ujFSOQf2og2AQz9jY4kbcOPcNZpyPeAS/cGDhaOfiV88
         wZS0WeO1Vl2YHD6sB3ZCYCZAIWnNR5+UGufgGCgifQbaxzywUUmxPHOsAOrZ8cKqgAey
         y2XuAp0EQHGxS6tqJ6DxcymKS7UPKmhL/i/kmXL5TK5kmMc+5A1awFrjmLYiY7zss5Ny
         ArFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185479; x=1762790279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ848GCsaR34084rjUbaciLlgRfV9nM886kentzS7Vc=;
        b=D2T+UJxM3FGblO8lkumjQGpefBzeNHrinWuBoLaWweolqbSpPCFi6Yx9CYgd4smgWh
         2HP/DU5oFrAGYz/qpplQJe6RblTIyL1EGbXP1/+PUqbmP6UMakioU3+T7EZvVHX/2gNb
         975PghWxtbpVW1L7ACsSjUwnuIvRgdkTAScKpdW/XdxkEfo0tDGkgKzCwFbDD+d/9d/v
         VFHc5bDSF4AoYCR2j5gn8VKLi8LMvJlxQdEjOc7MhEcwUT9IE1cAgGLS2C98/hoiHMDP
         V6HxKuuEU/UyMJwdqHz95CQAm361YPIzlH+fgZ0IkXHjU/C1NFn3Y2dDYfeGEhcrN7bQ
         DLlA==
X-Gm-Message-State: AOJu0YyHw6YWhYqc1kwpgeRHPFEzTnchqCaIHs+iC5c2vzRc02zNV1Kv
	ixZ2jetqjGRIBkp5YgGX34P8kq9Kz5iyXhmSXDeCs6geSNVjOUHu/s12Q+W5gGdJ7RCiBudIm4G
	IuHB1
X-Gm-Gg: ASbGncth2EDNIE4tvd59rqOCv89heprd9MmhB+8joibpXtSHsUXqsbxkwhj/JnhiDUl
	SS2QwPqzf6T5SXbezvO/N/FEeFKfffSBwTPLyqoFxEaFdoCnDWpxcrCiuTmyoxbon7ucvSDN15E
	j3InPK3Pt0NS673COfhzMkCH1twcJ56bfOW9vdq1LDa5i06GOVjgVVDPgPxJmrTPyRBxVBWEbSd
	TX4laz3dRFDY4v3xBI3M52kFl8v097BIU/Kg1MdrijSVwkhzEgHznTrrkfij87LJSEr2Ig/2E64
	YazXEWp7PEVzH8aIn0sOr4qLOCDr4dqwlGoSjlGbM2p9nNoOrWdzlH3g3OXa/u8cy14p6fJpYhd
	Ac+DGH2Y8vj3gNk+ysWAufwhaLIjA7xqkh+wScbDBiHrYLK8wSHIau/2lG0vfn8o8UPSCL0XHvO
	yIfZRV92u8x05msW4mL9IFss2k
X-Google-Smtp-Source: AGHT+IG0MryL1RJIOETIEmTPEWauV7sZJaCuGO8cgFoGm1FJGjaR8gh53wOAHm8YYcRtBRwlQhnRkQ==
X-Received: by 2002:a05:600c:5252:b0:475:d7fd:5c59 with SMTP id 5b1f17b1804b1-477262baf00mr153053775e9.16.1762185479365;
        Mon, 03 Nov 2025 07:57:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:57:59 -0800 (PST)
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
Subject: [PATCH v2 0/4] replace old wq(s), add WQ_PERCPU to alloc_workqueue
Date: Mon,  3 Nov 2025 16:57:36 +0100
Message-ID: <20251103155740.250398-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1-2]  Replace uses of system_wq and system_unbound_wq

    system_wq is a per-CPU workqueue, but his name is not clear.
    system_unbound_wq is to be used when locality is not required.

    Because these specific workloads have no benefits from a per-cpu wq,
    both have been replaced with system_dfl_wq.

2) [P 3] WQ_PERCPU added to alloc_workqueue (amdfk)
    This change make sure alloc_workqueue in amd/amdfkd is unbound,
    explicitly adding WQ_UNBOUND to the alloc_workqueue() user.

3) [P 4] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

---
Changes in v2:
- system_wq replaced with system_dfl_wq instead of system_percpu_wq, because
  a per-cpu workload is not strictly needed.

- use WQ_UNBOUND instead of WQ_PERCPU, because this workload will benefit
  from unbound work.

- commits log integrated with commits about recent Workqueue API changes.

- work rebased on v6.18-rc4


Marco Crivellari (4):
  drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: replace use of system_wq with system_dfl_wq
  amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
  drm/radeon: add WQ_PERCPU to alloc_workqueue users

 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
 drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.51.1


