Return-Path: <linux-kernel+bounces-878617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48698C211A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8184E3418
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425B336EEC;
	Thu, 30 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b+Yaaw0P"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B283655E0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840626; cv=none; b=nCRoWiuHFb37p6Qaky9FatKYTMQGsxXdr9CW7/H1YO2fsmDV20RcdxDTi/kF15MZsfEl63ZsWUdTowxByDsPuXZtXyOS3zXhPGsn+S1ZgBJfcSk8PQuAdZjri+BtUHvgtRuuRzvqgxkUt/tXtniDJixmWWWGIgGOXDI+oItAyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840626; c=relaxed/simple;
	bh=z7VBJtE14TNIgDLFgxWtNdagkjAzwgX/iRuC3xIR9SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6hRetgUfbJFSuwUPIP9l6KBZZ/ZnKznfZfRllidlqLRLCxnIw1otGbxlCio1RK6Lz1w5B7BM4vyiHAbOeC7e+jISon/ctZfG0NM4lIQdK3UZ27767cBApclK9t545Sf5fE0xNbCIi0Z+a1NSOcMDQ60omrW6frRNOMLIIVe0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b+Yaaw0P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so9883425e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761840621; x=1762445421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8txnxFWEuSZEvyBpZsokJZwR4vlD1MJiynWZzM4iDc=;
        b=b+Yaaw0Pca4dmpAGCJ5jcNJw6UbascrMthnJBNbiIs6tD8GP7hwly63fyFFtEHVeso
         R2WM9p8YzeiN5HKhb14Td5hiobRLW+cT65ml1bHafecOkHrAs2Re/EpKFfKNyyytCaC7
         VcKrwB7f1jN8nC8+FnRNBqrT5kqw4AXIBOka0x7meLpee9MImxPvWlR60Lp9ul5nTU59
         GvdsfJwYW5re8w92QdzCjfXcDwO1zOJi9k1fYkcwIbHSYFkczGprSvIS64fo7WOrhxkx
         zKEHey4IVyL/VKjt1H1bLyJuflNlpUrSSHttzaxYUPPQCJhn6K3vf84TDwjMCelLphju
         WhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840621; x=1762445421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8txnxFWEuSZEvyBpZsokJZwR4vlD1MJiynWZzM4iDc=;
        b=KjJ17nM3dB6ZuUAxhK7MOJFe0/sGSzcVu7BwiJQeIxAlVtM7NWy4kL7cniZBdmLj7o
         1pz9eefk4eeIjXp2WiZ7USS6wd9vR8l/CEqNAa9XXJVVd6DdC6FfDIHwxTE/CaXSQlnV
         b9w5bI+cTQMlkCzmp+Nr+wdt0/NrZRADBL1QWnDFi0KR/V3sjKWEtI/7B84KPE0dWaza
         z/S1GmNxztKs5Ms/eF3owQf+mN8CyUFextHyxvrmmmta3vN3KkHA/nile2rgEx+K+QWW
         F7j11lalkmko4RR/opG3Jm+e0XAHQIENKRQk9R6p6FLBL9EJH7kEGJ9dC/CrtwPrDrMi
         iOIw==
X-Gm-Message-State: AOJu0YyIyy1OKW+hluygxcwLEkunxCJ2fg82/GgqLxoWBeP5eIvmmtNs
	TV94LcnZHXoQsis3NTIHu7M7MVoDy0Lbj02AOGd+kaHFRXLEmi/6naNx5S1NtL9JLYVvmwd5qZN
	oBXCn
X-Gm-Gg: ASbGncvaW6OZSZD+NtLhkp63vSK2D4K6jkchGnD/JHcYWLujPxULzvx/HlFpdpl3gCM
	XOWQOQoKf8vqwc+S1rbeB+8p6EjVFeq6w3DEh9FUl1LVgCCoH0JIsFG1+rBDJtx0KmADGoiboCy
	VnbmIka3kAPsBP1Y+LLRIkJr07ftg8e+Hd+TtqNmFDq0cTMTMyRZr7t9x7I70AqxRSEOR4qERpB
	AfxwRvRi2gPzUlhONMPVNARsShsjDJ5ct0KkOyL79anLOSOZJAKbaunQJw6g2titWdYFv6D4OkF
	9/FIkJ/p4zZKrEx7MWvbxxugeX6i5N7F2MFpdrjpbrPb9zkXJ6xz/MGAHmNtxNZ+fRG5PNpbR+R
	UoHu7i7ci61x04cE4TYlXu6ucwqs1a9fl5u0lwjNjjOEZrv39PUNfvMYIgNN9+w4D1gtUsg7ctY
	u42b7BizeRcJs10LA=
X-Google-Smtp-Source: AGHT+IFUABxe82sEBxNr7aGuyc63kqBiirRpp/f4wHw9QtuKLHHuTYMkkkGE04OiUmg1LArsF4Jd1A==
X-Received: by 2002:a05:600c:a345:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-477307c3595mr2031835e9.10.1761840620842;
        Thu, 30 Oct 2025 09:10:20 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:20 -0700 (PDT)
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
Subject: [PATCH 0/4] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Thu, 30 Oct 2025 17:10:07 +0100
Message-ID: <20251030161011.282924-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
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

	Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3-4] WQ_PERCPU added to alloc_workqueue()

	This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

Thanks!

Marco Crivellari (4):
  drm/amdgpu: replace use of system_unbound_wq with system_dfl_wq
  drm/amdgpu: replace use of system_wq with system_percpu_wq
  amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
  drm/radeon: WQ_PERCPU added to alloc_workqueue users

 drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 3 ++-
 drivers/gpu/drm/radeon/radeon_display.c    | 3 ++-
 5 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.51.0


