Return-Path: <linux-kernel+bounces-893104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B768EC46901
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909FF3A7B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FF30F93B;
	Mon, 10 Nov 2025 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+Ks6Cf2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02F30F930
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776728; cv=none; b=RzL1nTy+5O2zZ5iqA7bTvVXyddv6yyhkc6+3qVxDiBDzViGhnb/5fm/5XBW6PIfLc4lTtQCoZkiu+I/nTQGYOxHsgPMzkEfjkSoqRe7oP2Jp2nBm7gtZC55rEIy0Qop4wkY34inu+gyAp1SRGlpy66RCKmZH0PofY9a5ceMYi14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776728; c=relaxed/simple;
	bh=Gq1Qz9de0zDdr7Qza9fayAQEpXpfGWwvApSfAxEFrck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nJHW9hUWWf0+tg6dAAiqEq6yizqRaUcG3TzCM9RR+B69UTZO/eOsEjxToQlThM5nulnxKlbykL9Ujn/5kq4Fh75KO33Ld9wA3jZVmpKwA95G9AQKbmTN58OP3zO3TNjrT7w3v05+pb9h9Pyggx0NNwZtOyGdx2heuVqQ68b/i3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+Ks6Cf2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776726; x=1794312726;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Gq1Qz9de0zDdr7Qza9fayAQEpXpfGWwvApSfAxEFrck=;
  b=T+Ks6Cf2BTGN4iVGmESew/iCY6X7/CTMYK/f5Fp7OdxKdUPBKW5WORnk
   Nv0nXV66cldU5xpVhgKCPWtZxy5UuVjyGM+mJT4BjwDtwWfDO1FC2jpsV
   BumIvr6EoGn30Ru466p4LZaArLbyCK4W/a2KJxp7oMsew/6BP9wYwF8I+
   KiVCZGDb6iJ+MSwnFB2/xV6oaT4rPN4W1lPnKyOZj890F49iFn55k7nMK
   eVT1ZPFVr55JzTM27puiRhrdnHrT6OnXn66pahHqAV1FAyfI/56caPi+P
   1d2QAhLQ35l9AQfsk8row/6abakRf9yy6Fyp+Tgea6xvnT24WNLf0Uws1
   Q==;
X-CSE-ConnectionGUID: hvsU8+5KRAeOy0WFwcZNdw==
X-CSE-MsgGUID: lUDQ1HClQnimacm/A6cvwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68467717"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="68467717"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:12:05 -0800
X-CSE-ConnectionGUID: HH7CDWeHTiWebboaKijKWA==
X-CSE-MsgGUID: BnoiTsyASuSg/n0lzooiUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189379199"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:11:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>, Marco Crivellari
 <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko
 <mhocko@suse.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH v3 0/3] replace old wq(s), add WQ_PERCPU to alloc_workqueue
In-Reply-To: <34ozsv3e6ujs4rn6c2r4nrjcjifgazddy5jecwur6atfcop6vp@bunf3uyofmb4>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251104100032.61525-1-marco.crivellari@suse.com>
 <34ozsv3e6ujs4rn6c2r4nrjcjifgazddy5jecwur6atfcop6vp@bunf3uyofmb4>
Date: Mon, 10 Nov 2025 14:11:56 +0200
Message-ID: <aaac1c9b25d0fc2500e67d05948a22d77dcc72e7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 05 Nov 2025, Krzysztof Karas <krzysztof.karas@intel.com> wrote:
> Hi Marco,
>
> thanks for addressing my comments!
>
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> on the whole series.

The series absolutely must go through both i915 and xe CI before
merging. Krzysztof, can you please make follow through with that?

BR,
Jani.

>  
> Best Regards,
> Krzysztof
>
> On 2025-11-04 at 11:00:29 +0100, Marco Crivellari wrote:
>> Hi,
>> 
>> === Current situation: problems ===
>> 
>> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
>> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
>> 
>> This leads to different scenarios if a work item is scheduled on an
>> isolated CPU where "delay" value is 0 or greater then 0:
>>         schedule_delayed_work(, 0);
>> 
>> This will be handled by __queue_work() that will queue the work item on the
>> current local (isolated) CPU, while:
>> 
>>         schedule_delayed_work(, 1);
>> 
>> Will move the timer on an housekeeping CPU, and schedule the work there.
>> 
>> Currently if a user enqueue a work item using schedule_delayed_work() the
>> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
>> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
>> schedule_work() that is using system_wq and queue_work(), that makes use
>> again of WORK_CPU_UNBOUND.
>> 
>> This lack of consistency cannot be addressed without refactoring the API.
>> 
>> === Recent changes to the WQ API ===
>> 
>> The following, address the recent changes in the Workqueue API:
>> 
>> - commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>> - commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>> 
>> The old workqueues will be removed in a future release cycle.
>> 
>> === Introduced Changes by this series ===
>> 
>> 1) [P 1-2]  Replace uses of system_wq and system_unbound_wq
>> 
>>     system_wq is a per-CPU workqueue, but his name is not clear.
>>     system_unbound_wq is to be used when locality is not required.
>> 
>>     Because of that, system_wq has been replaced with system_percpu_wq, and
>>     system_unbound_wq has been replaced with system_dfl_wq.
>> 
>> 2) [P 3] WQ_PERCPU added to alloc_workqueue()
>> 
>>     This change adds a new WQ_PERCPU flag to explicitly request
>>     alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>> 
>> 
>> Thanks!
>> 
>> ---
>> Changes in 3:
>> - Improved commit logs
>> 
>> Changes in v2:
>> - fix typo in patch subject (add instead of added).
>> 
>> - in every patch is also present the specific commit hash about the
>>   workqueue API change.
>> 
>> - fixed commit log of P1 (removed "Adding system_dfl_wq...").
>> 
>> - P2: subject changed reflecting the effective change.
>> 
>> - rebased to v6.18-rc4.
>> 
>> 
>> Marco Crivellari (3):
>>   drm/i915: replace use of system_unbound_wq with system_dfl_wq
>>   drm/i915: replace use of system_wq with system_percpu_wq in the
>>     documentation
>>   drm/i915: add WQ_PERCPU to alloc_workqueue users
>> 
>>  drivers/gpu/drm/i915/display/intel_display_driver.c | 4 ++--
>>  drivers/gpu/drm/i915/display/intel_display_power.c  | 2 +-
>>  drivers/gpu/drm/i915/display/intel_tc.c             | 4 ++--
>>  drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c        | 2 +-
>>  drivers/gpu/drm/i915/gt/uc/intel_guc.c              | 4 ++--
>>  drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c           | 4 ++--
>>  drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c   | 6 +++---
>>  drivers/gpu/drm/i915/i915_active.c                  | 2 +-
>>  drivers/gpu/drm/i915/i915_driver.c                  | 5 +++--
>>  drivers/gpu/drm/i915/i915_drv.h                     | 2 +-
>>  drivers/gpu/drm/i915/i915_sw_fence_work.c           | 2 +-
>>  drivers/gpu/drm/i915/i915_vma_resource.c            | 2 +-
>>  drivers/gpu/drm/i915/pxp/intel_pxp.c                | 2 +-
>>  drivers/gpu/drm/i915/pxp/intel_pxp_irq.c            | 2 +-
>>  drivers/gpu/drm/i915/selftests/i915_sw_fence.c      | 2 +-
>>  drivers/gpu/drm/i915/selftests/mock_gem_device.c    | 2 +-
>>  16 files changed, 24 insertions(+), 23 deletions(-)
>> 
>> -- 
>> 2.51.1
>> 
>

-- 
Jani Nikula, Intel

