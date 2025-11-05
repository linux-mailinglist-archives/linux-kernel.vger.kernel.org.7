Return-Path: <linux-kernel+bounces-886693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C41C364C3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BE514FFFB4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777F833554D;
	Wed,  5 Nov 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgrqITxk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CC33439B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355501; cv=none; b=NxRJ7RTu4Qddg/Q8E/AMrDFYYBvTnvTH7LyWyIcz/qM8NZZ3vGbZlR51mzUtgi7lK7dRVvY9ug5siRBZ9VI2tAbmBFaxEAgGvvFjX2MXB1rEebk0W1UbXpMpE62Bwjymvff+vBtU/2ut2yTQ3GEmMHzvAUrc7DuEf6IOUdwwk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355501; c=relaxed/simple;
	bh=0qo+vWB0qtgugO1nJ2JKIfx3JMLLUkEosDLmcmtN/qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9eifT9XNlaxNDcDjB1ceKJ8MfPLHK9WPjFbwgpah5ijBaooLXlIU4fJJ5w7Xxa37RjU75sih/fDstUzWaYtDW2jQrOVYrvbGqvu5/6Muxq1+5GCwE5eoTZV2zX03sfzys3t2wzpsIPcQ/qEH/koENhISZRivzPrJVwwejKXuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgrqITxk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762355498; x=1793891498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0qo+vWB0qtgugO1nJ2JKIfx3JMLLUkEosDLmcmtN/qo=;
  b=jgrqITxkQLA2AyxFlFJsiKizRYvQGNordT/jc+F8OrthmWQ62AkNLyXJ
   IdjdIZrF2vL2RXAEubPgECB7bte1d3VSwWULE4/b5L/bxr+owenBb7aCX
   sugFvA9CLc902d5fMzsMiVpuBH5KO/Pf7iY9UdDcAp18+cV730WejM5Mw
   yEo1LD5NR/iNTe12wfIRCLTIxU2dKun32W5YaLAnhAqRAANnFn4DO3wSz
   qWFAbztu0FFwAot7kAx3XtUCCIXBJVkaAQvbY8u+FdIPbLQflCyWzq/fp
   qxLy93HMATH2aAiSq8cjsw3M9xQyXGTSm7olScPwdPyI/23FYgSJSWOee
   A==;
X-CSE-ConnectionGUID: NFulHckFTxi9XJWJFaFQsA==
X-CSE-MsgGUID: k4y7uy9fSsCQFKTg1onkdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64386990"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64386990"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:11:38 -0800
X-CSE-ConnectionGUID: 4XzezfzRQX2OGZY2aIX8Qg==
X-CSE-MsgGUID: spJkg0RwTjGXt/kcm15YtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187146514"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:11:36 -0800
Message-ID: <fa8e402e-ce73-4093-9ece-780ccaaf36e0@intel.com>
Date: Wed, 5 Nov 2025 08:11:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvdimm: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20251105150826.248673-1-marco.crivellari@suse.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251105150826.248673-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 8:08 AM, Marco Crivellari wrote:
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
> Replace system_wq with system_percpu_wq, keeping the same old behavior.
> The old wq (system_wq) will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/nvdimm/security.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4adce8c38870..e41f6951ca0f 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -424,7 +424,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  		 * query.
>  		 */
>  		get_device(dev);
> -		queue_delayed_work(system_wq, &nvdimm->dwork, 0);
> +		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, 0);
>  	}
>  
>  	return rc;
> @@ -457,7 +457,7 @@ static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  
>  		/* setup delayed work again */
>  		tmo += 10;
> -		queue_delayed_work(system_wq, &nvdimm->dwork, tmo * HZ);
> +		queue_delayed_work(system_percpu_wq, &nvdimm->dwork, tmo * HZ);
>  		nvdimm->sec.overwrite_tmo = min(15U * 60U, tmo);
>  		return;
>  	}


