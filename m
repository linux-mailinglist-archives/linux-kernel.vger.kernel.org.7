Return-Path: <linux-kernel+bounces-883377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6BC2D466
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DDF3BBD88
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA331960B;
	Mon,  3 Nov 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QpH8DyH0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850DE2DCF44
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188493; cv=none; b=UH60+/iNpsiIXpqQwgVCTSM2Uup0tmpa196+URJ9WTkJOEPV6tSkmJ6l58oYqiCsUpyMafom70ttphwpWii3uhV2BuWZ0/yNFwcAzMbWEf7nTP9I3S0wcQHPQQddCk8MMm2Bko4WZ/U8RASs8B781arbO6eyvTdE1poL11TqUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188493; c=relaxed/simple;
	bh=jBs8TInezGrqn7lBKsOpEL7ivihT00ZrAK/aortOSpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIQq+9sr8eyCISuB4YVVj5xHTa5uTgl/DdL2KUcTSe471TxEKcznk9/S+TEqJP19fODL0vJF0BBQzHgJa4GJ2Mf3jJP9VwYjh7A1x/8AgnINxBaYypU4RIAZW9Y8vNMelBbtfV7ZnBimICK17tBiWp9vryWzNCRoVr8KzemHnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QpH8DyH0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47721743fd0so24916685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762188489; x=1762793289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5sPGkrkFa+BIv4P90jHrJVfi2snemHJi/xGZTBOH3w=;
        b=QpH8DyH0AwR59+5nI6LKwecrBQa596Goa6+nKvbKNcx6VsQjhDBW8fvgI+NZShv5E2
         bKNNOaQGHCyzmhrVEzvMCOqomcvTuJDNVqcGQZGm4T10+Dyk/gs19rYRQANw8/bIpLL1
         E5EGsRN/aPN7hJM1/rzh9OFGpBaRI0latUj6AtipsutrYUyVDqLpRsRGGHYJlHR5WmMk
         mxitqiCd8YS84cGaQO9F7mXrnvCTQBAOohn3G+2nJEIr5n1q8VBq3VYyHDdYDz1AKNiv
         wtuX/cH8Y8CX0VY3b9qliEsleTJSio2oAuDihw5bs10u9LFML8GYaxQbJ7q2IP8gnDg5
         1O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188489; x=1762793289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5sPGkrkFa+BIv4P90jHrJVfi2snemHJi/xGZTBOH3w=;
        b=qbWFeE0WxF+xilLkInQoCsZlvY/fCCl4IxHcrHV3KjxiSDLpEuWqsd6WVbOFnhHTCc
         6a63MHqLrPSGhPmya5crpDhpoJEFQx1BuIg0EL63/Cs/EBt+9lgftIv60l0llP88hqiE
         wHlal/1eSZ3Uf0K3FRt94oBcLuGalCDKiigTtBaOIg4OL3/75t0iJVJD0OyBGf0EVPMQ
         QLYlpfSPoNLEf0vZQOTQ5JWAypxeA/36GTWRPGRio61r2F3i5+DYLxtl7hDzHmKZq9j7
         ps57qQOaPgIvIdT3K4CUQkNaUXAN9YpWdsmkxbHqK5WcbMGtHscqEtkuR1H6LckTeLSo
         T57g==
X-Gm-Message-State: AOJu0YyzAplS9M6kKYXS5bB/ahbXgDGfeVQOX2wXlrFnQWMN9+gi2Gkc
	hZFT5iYE+dEXbVf14tourPF5Wzx2NDwicXhpEPq6F54qL/i8U2Lw+GPMZd9E/JI1ZUp9nEiWtl2
	F5VsY
X-Gm-Gg: ASbGnct5+a8QQIY0Of/PrL/53J+Bpm66f02oOKVOTRCR4PqUBE5M2BPkYYaHSj4C/LT
	miAVVmVYy5Iih+kScYcEw2gLQk83Mb64L2Jnjw9CPiqZNJX5gBaYCI7MlpPAUsR1nyEt9zTKyI4
	vvrs+s0m4tFHKeCTBw9L/17LBxMD2d4jXEElFYrMq+H3wBW8t2sLZeux36TiduTMRNjEtV8Gdd3
	uKwkTLoarm+cADrfdDNR0m86bG6FP0keRQaiGDzX+4YmDC37m7nwCHqRnqibVnZkg2PSWF52BOq
	oX6NL0vv/brZWxzdaz59qbyyl3wW8RBjYfpjFoI85X6+6iCgFrGhkbaneZxiMB+/BSvGaiMHS28
	c4upoRpROy7l044z9CnVkpsHwKU548jM5PogswO62WB6peoLbzHWCrDr5dDR24tg9IXdcvdmtQM
	oVxCRspDZ5Gzs/2U0iz2dZtfu/
X-Google-Smtp-Source: AGHT+IHn+Z1e4sX03I15uydQaHtVImGCDSavhgeRz4F8FOoyRNKT0SkIDzFYOHn5zbcS1AudwJpIGg==
X-Received: by 2002:a05:600c:4e87:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-4773080fbfbmr118466665e9.17.1762188489181;
        Mon, 03 Nov 2025 08:48:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429d1061efasm9864899f8f.24.2025.11.03.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:08 -0800 (PST)
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
Subject: [PATCH v2 0/3] replace old wq(s), add WQ_PERCPU to alloc_workqueue
Date: Mon,  3 Nov 2025 17:47:57 +0100
Message-ID: <20251103164800.294729-1-marco.crivellari@suse.com>
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


