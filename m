Return-Path: <linux-kernel+bounces-884543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB455C3064B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB0B4E22D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF532D2391;
	Tue,  4 Nov 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LR6Lbr2S"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EED7DA66
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250448; cv=none; b=FMXZpmCxLK03EMKHaql63wq5PviRh35fmNGHKQVEwzKbM+zcSnCkpHpz82YjSbMKfHcpxYjRwLv4i1SRmaDU2SzQSa7vNL276GxwNVC/w/aW4uE8KhmsbqU40T4cvX50Y4K3+gPAakVpqFoJs+qfoa1DS4+NmjWnPHWaKwEPtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250448; c=relaxed/simple;
	bh=UcXOGL+nG22Mlw9A/nNzhvNfbNXwuyZCD6UQhqy4CpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MY39IBZLchx80zUJAGGr3L+4V4q/8D+0uPop6EuH8A9DZYkXZ+hItTLVjBuVeD/8QtugAGCL17N8+sYUHYOQr7ZJM3ZcxArYw5wAQ7UuhCRkwVQS4W1CeynE8lDuXdPLiK6wg8iwzF7sZkpZid0NF2Ohf0409kdMj6afzw8h0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LR6Lbr2S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso49860575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762250445; x=1762855245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgopYyeNgZsrt2Y79WHTxulNc0VQoVCMlZy03CyU8+g=;
        b=LR6Lbr2SRdrRiUlR2FVKB0wXZMuHnopIn8y9LCxVY2dt/Earid4D5IKpFWfXm1Pv0u
         VbNTYpC/MgDEofNEVvaSPVQtkdcjl+hL12JV/bGIGNPUChrqrv4xdxwetmKtJ3DXI+kx
         2t72X+2nRuJg9OTBA9Pw21C6q6WcyHIVW3EuluH7200vwfC8Mb54z0uz6u506PdyAue9
         W+nQnVXKA2r+hDzdN7beKEuG9lZs64ADPYwgkisl9Pj8fRpULOBNI+qBfT+cro4sfXlZ
         v7mRgN//V78w18LKATUlUELYOjgcZTC04aUC5qy/nEsx7gllqCJDrx42ZuWB0oAYluRm
         Qk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250445; x=1762855245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgopYyeNgZsrt2Y79WHTxulNc0VQoVCMlZy03CyU8+g=;
        b=ZFMVDh9koYuZLF09gO2h8wPMtvOEZySonnXdG66kDIS27/OpbTztoObn/OY/GwpfY5
         qThz6FYjEplG8EfIHyVmp1XWrXizchob6GNd0MyqbGC8Zj7I+XBPcWtSztGKx0PWL/Fq
         PUYbrQH5qgCxM7bWjPjew/N/H76ygp5qvj1kI0mbsTccec2OlS/6KthxfJy1PjuGoLUs
         iGLbS36UM2B4F1/fDHdBpCxsC9DzJeVwGzluAzfgKN5P01CAX1ijuDsVsZqRfBldPO8J
         OFNTGGkgbChEyQpmXB5c/EdBLdzX5oOxMVCyUhBp/GUZ1M+dpMKEezzRMXLU7sp0O0UG
         g2Jw==
X-Gm-Message-State: AOJu0Yx+E7Ap45It01AC1vSVm5sdly9EVD2ZdSgFT6HEyQAzVvDlNYVF
	npkCQ2em8U7+6DU+2EQu28BwgT1+kBbrDGDsLGEzHHJPC2JwDpya8w3AP7DTFDXlXZW4m2lObZB
	YrrSH
X-Gm-Gg: ASbGnctBGv1SRqpQoEurGppzoGTP9Kuz2nXhliCyieBz/zIgISY3i2FLyJyHhtNva0M
	8uOghniwsshJqjG7vj6TVqFI2FBc2GlVvbZvjfRB51RooMu818y/pmOuGAQYmQRzaYSnHgydHc1
	FrgteNzi7qjZtj4Jg+IbP69hZyoXwtqmi+3CXg+5RO2ThIGGKdOZC+Cl7MYRe3EB5HvuCWUaPfE
	QCM4jnf6jq0kFVOFhUGdpGHc8fWoWzgGP6zbJKH1rFsgZJJwpxnXVJgjw1iEbpD5Q9vrddnqVy/
	fJBdWbMGz5rOoRnDR8MtrErebbElnNKf2CpAQ1Np59MV4G5FtDEV28wLWnfsiDleN8noY5aPsXj
	p1CV34EIyr4jXBkeinuAFQc8veJ80h6FZEG7sZZvqxMIEYrkr5TKfkd/8aIJ4tEluSJJFZ1yHBB
	7IVza0EfU1O2jJnd1ErdsRuvuz9fxZTwrJlrU=
X-Google-Smtp-Source: AGHT+IGWKsEYeVin7D/5J78w8s6rqhDLVOG5AJCCtqrz5PPQJufaU8hvNyFs/6YjSt6T2WJtHCvGgQ==
X-Received: by 2002:a05:600c:5252:b0:471:b5d:2db7 with SMTP id 5b1f17b1804b1-4773086e099mr128405005e9.24.1762250444571;
        Tue, 04 Nov 2025 02:00:44 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755942772sm14325865e9.5.2025.11.04.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:00:44 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v3 0/3] replace old wq(s), add WQ_PERCPU to alloc_workqueue
Date: Tue,  4 Nov 2025 11:00:29 +0100
Message-ID: <20251104100032.61525-1-marco.crivellari@suse.com>
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

    Because of that, system_wq has been replaced with system_percpu_wq, and
    system_unbound_wq has been replaced with system_dfl_wq.

2) [P 3] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!

---
Changes in 3:
- Improved commit logs

Changes in v2:
- fix typo in patch subject (add instead of added).

- in every patch is also present the specific commit hash about the
  workqueue API change.

- fixed commit log of P1 (removed "Adding system_dfl_wq...").

- P2: subject changed reflecting the effective change.

- rebased to v6.18-rc4.


Marco Crivellari (3):
  drm/i915: replace use of system_unbound_wq with system_dfl_wq
  drm/i915: replace use of system_wq with system_percpu_wq in the
    documentation
  drm/i915: add WQ_PERCPU to alloc_workqueue users

 drivers/gpu/drm/i915/display/intel_display_driver.c | 4 ++--
 drivers/gpu/drm/i915/display/intel_display_power.c  | 2 +-
 drivers/gpu/drm/i915/display/intel_tc.c             | 4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c        | 2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c              | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c           | 4 ++--
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c   | 6 +++---
 drivers/gpu/drm/i915/i915_active.c                  | 2 +-
 drivers/gpu/drm/i915/i915_driver.c                  | 5 +++--
 drivers/gpu/drm/i915/i915_drv.h                     | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence_work.c           | 2 +-
 drivers/gpu/drm/i915/i915_vma_resource.c            | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp.c                | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_irq.c            | 2 +-
 drivers/gpu/drm/i915/selftests/i915_sw_fence.c      | 2 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c    | 2 +-
 16 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.51.1


