Return-Path: <linux-kernel+bounces-890106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F7C3F3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023583B36FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A901302145;
	Fri,  7 Nov 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpICSZeF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265E21578F;
	Fri,  7 Nov 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508654; cv=none; b=av4JjkhKqy0cdaMPbqvTBQKvTzOKYOyfF6Kfs3rNksV2D/hFgulEepxtcq2c+hVfdHSPUilpSGOAIQx2ibqvOa7FzaaCXOZ856KJ3CxRv/dyqYJo/35RXePnXrOisjYtOTMEvrfIlFu5kGHzcPmkIi6tNFZuKx3/9jkc401y5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508654; c=relaxed/simple;
	bh=pERkB0DkK+0Q8Vy6afgxQ22OOtk1gMRQeGB1CqGFCEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snkGDKPjcghtRCnGrl7naUVZgfiX8ITN8+VRNezyJzwpP2B7A/u7hROJ97GC4pOH8DwmDbTaHo+yGxNMEsDmMH40MIXFyihCaEXN71JMin9kIHf3nnt/2vVcWAlWUD599qFcTQY28yUZcU+RS9/DwLaDzrYhT9h0m6Gkvfua37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpICSZeF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762508653; x=1794044653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pERkB0DkK+0Q8Vy6afgxQ22OOtk1gMRQeGB1CqGFCEk=;
  b=VpICSZeFxc4givDQODrsds+VaYk34D6blRdbs4fdhHvBiZKo9Bk0weIx
   yki/aYc+R2A8p27K0o2ZOyxAz9ZFXPis86FIC89PfdU/69ReaZTJLNLpw
   NOEd76R4e6PpYkVYtG2aMkgFFtlwZ5DLVcoDDc4F9uxiV4y7CQ7WinS35
   L08NosAhKLqpz69lgFKXIzV5AVlJ4bOTMYvCV0v5NNJjt6AnzF9Suipzz
   DP4FPpgK4WUzY6xgvwRI5H2nNHBRTdDRYQcE4VfZ/JHKIeKhK0+1q3P39
   B9yf12u3ar1Frp4yEWdfnP42P1jhhy2KnEdRr3REdiCrOerbFDOOp/n0w
   Q==;
X-CSE-ConnectionGUID: DWqPH3HoTDatavmqIL81Rg==
X-CSE-MsgGUID: jt+Jd/B8R4WTm0Lqt9GqDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63668111"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="63668111"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 01:44:12 -0800
X-CSE-ConnectionGUID: 9524hwPvSvG65SYGBcBRnQ==
X-CSE-MsgGUID: qC07X42mRdyk5I+PvX63Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="187841587"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 07 Nov 2025 01:44:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0FD9D95; Fri, 07 Nov 2025 10:44:09 +0100 (CET)
Date: Fri, 7 Nov 2025 10:44:09 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH] thunderbolt: replace use of system_wq with
 system_percpu_wq
Message-ID: <20251107094409.GT2912318@black.igk.intel.com>
References: <20251105162736.320591-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105162736.320591-1-marco.crivellari@suse.com>

On Wed, Nov 05, 2025 at 05:27:36PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This patch continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Replace system_wq with system_percpu_wq, keeping the old behavior.
> The old wq (system_wq) will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied to thunderbolt.git/next, thanks!

