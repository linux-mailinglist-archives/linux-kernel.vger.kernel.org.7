Return-Path: <linux-kernel+bounces-879907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E1C245F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7763BAEB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111633769C;
	Fri, 31 Oct 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bm9RY5Yo"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962223EA9B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905382; cv=none; b=tDUa1Tv3Hn9UEMBYOaWorZPGB1F1dd47hmK1DIQuYC0gMKxuBH87lxKNmnIQfZ59h9YLUFsdyyk8Figl2mrqhqbeJI2nINjxfKz6cSs0hwUhwPsQVM0/S9sHkQKTuOaZZ5Am+UyrxwFu6cVolw2peXeozYKxVn2HRr+tF/eFhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905382; c=relaxed/simple;
	bh=F1EHhJs8hgy6Y6NwkgAxfcvk1/e0tRC0Em4InG2cP74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLM8uFOeFFV9gfwadMa5Bjuk1VcXG2ug5uF8gL5d6aCGqOn8azDlTKnxtkGctEoAT037pIA/JbdbjT6J6+4EHejnTw2VF7c7y2CTlQKSCy1LQqpSVNI/ZPeptxFircTNzNak9TU3DhK+LQl+rejliCRSyHKyx2QkT9f9Q2vSKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bm9RY5Yo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711810948aso15307935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761905377; x=1762510177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gLsyclWIg1Hbk8GCNQzeqbJp579/jQeUbknnNQhnaI=;
        b=bm9RY5YocjLHeAPnLvXWzfCtX3ZcUEDOVyfQWeEzBWWuZcT7r5ta6/Lvw+IoXozKz/
         +qAI1RTw6LUZSC145O/eUgpaud81lmTCAsCjmVcnJwQbiUZY+Px7H4xyS0cwHxKUJgJb
         jUaBIxn7EwlSv1LEYV6FKFbKBAUbEQwwVT8scVSANw5XGz6oqBbSrlt7AmqG35W8KDT0
         QyVbeFm0W7Aa6Dh3qyLlHygq0Osg465tgkZK6mcmpE6aOO7+p3gOcJJEOzfIa8nA1a7W
         jw9ya1lZlorh+qGmheh2GTV5IPAVzaoobWQGkjUjmU4JIXy+h1FojIkVn25GTnMDRy8Y
         8wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905377; x=1762510177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gLsyclWIg1Hbk8GCNQzeqbJp579/jQeUbknnNQhnaI=;
        b=pjY4wAw7tDGT8pARo0YBqUqfdLtQvsnkde9sgCKp+Qs7rWwrbRdzdCPPltltFFoR/Q
         GcwYYjDXRqcwMSbhr0hHFVQfEsBikHtX8c4o2U6U5aR15osGKBSg8wJUMbw8zNvg2x3s
         i1Y2ifXbtjTbZnEKoQWZocMq5OdqPiECr8VZJDK1U8bqhOL6leNHXc9WC3gep4hEH/XB
         QyXVfl5uEeeZQ9PpLIaogzlVFj3hLnZrCPu4kErv7GdEJfqTUQB3/rWlqVjYIyZGmWoh
         b9EgpXCVvtQ4Lax9SjtzgFpuiHe/PuJNsKpYysUfRamQOCKV5tKZwCFt9MSvs5FtG611
         a3Iw==
X-Gm-Message-State: AOJu0Yz/vLoE32dnTl32PIxSp1grYjvlijBYbnwkmtUSQvbqYs/+pzBc
	uyD53z+fpbswS+NvUmAJee63BTeb3O/UD8D9uy9sKmRi2oiAIKQP6QJrmssEcrrbW46Rc6XkX5A
	fjayd
X-Gm-Gg: ASbGncu6pIF8WuEBrpHubgXZdR3l7iO846rzDOBsXZVrFHXyYAdt9DvExaL2tByqOeT
	9tKiaAQbzYYVJRdYe8f4JDYpVcU0tQ9bDzv4vZhk4IOu/volYFG0IfJJQH0Vcmnpwny2EE/0kxg
	U3t2IBkKZog329SSsOD7twrDwHZUFzNN8dfdkDJT9UhdrXPhCFwSErsvEyo5Aa9yRiOtyvp9NNf
	+mKYpyBFQkCaRE196RvU1hDFRDEIeo2B9GJ62H3qAkJLuPzesjeg0jzC/eyjVXAHu9Z2FMsBef1
	aa2gxRlM1kh45yopDRL1d98R52u7ReVLF1ParJ7+O5mXmhuFyHeS91hYQDAZruhaB8fmM6GC2LM
	viPX0jQFUSukV5hH1sH6PEqEiRhKDwETyhUmnJeResQFFCetf5bXG4/m9c+YFM2YsM3Up1h7U24
	eN8sdMMqDeN3Q8OHP0Jwx+zGFGCmVXD2R+Qu4=
X-Google-Smtp-Source: AGHT+IFHb0AaSWW+DTXGcxSx3IxdrfeDMO0RYX9+22XPN4yMZ4YQ/BGd2RRqAhlylqD2wBta80eN9A==
X-Received: by 2002:a05:600c:a08e:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-477307c2ad7mr21989415e9.11.1761905376895;
        Fri, 31 Oct 2025 03:09:36 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm2839171f8f.22.2025.10.31.03.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:09:36 -0700 (PDT)
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
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/3] replace old wq(s), added WQ_PERCPU to alloc_workqueue
Date: Fri, 31 Oct 2025 11:09:20 +0100
Message-ID: <20251031100923.85721-1-marco.crivellari@suse.com>
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

2) [P 3] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (3):
  drm/i915: replace use of system_unbound_wq with system_dfl_wq
  drm/i915: replace use of system_wq with system_percpu_wq
  drm/i915: WQ_PERCPU added to alloc_workqueue users

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
2.51.0


