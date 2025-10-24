Return-Path: <linux-kernel+bounces-868629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB436C05A94
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4DD19A8018
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186CA31196F;
	Fri, 24 Oct 2025 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLgPo94p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F2306B0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302946; cv=none; b=nkIvtHULpNm470CIkBogEFbGR35uXgrOfMYPEA40hckB6QbglgAqR0Rh08MQiyCfLaD3RCw+5kQenyDBjOAte5dfBHdOpIFmGIQVU3pFl6IV3cvUaZRAyuEGmUpylyWdTZ5DFwtfm1R+Zf1NlJDPQ6+mYhfCqWmhiNSAE9gCXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302946; c=relaxed/simple;
	bh=X4Lx1AN9vYSZaPB0jdVLFEPdmXgK7gQn/GI7ZLbgs/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKh0TLiDWZ0DUpJlDhV5VxEKeHsW6hSwiJcqgUamHfLoY3Lvlcta1qD3jcEa6txXHDo4nYO0jAyx2cC721RZuU1MKuZNgB1wXy0DYidVVWd83oek54bjpAZXJsJVuMC31hDIHqSKXj1cwXMIJEKtNvHuWB9k3ah78TmPFdE6+gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLgPo94p; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761302944; x=1792838944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X4Lx1AN9vYSZaPB0jdVLFEPdmXgK7gQn/GI7ZLbgs/E=;
  b=nLgPo94pgkuU19K/8fHfZFYsfIswXhUPKJxUfARbC9bymE+z0LQ7FHps
   3LaPRZe6WmC4nsOyJbEAdnmHGNZa28x6Pnc1KhfXGe1Z2Lm79tfApIvLO
   AP0PvZnYB4OBXjbnZaskCjsVzLrRcheby1TkdfUlNOr7W/hnJNSY/Lpgs
   4IIWaDRtB6AgUTomNZ8STpsbMNdE6xAyT/Z8NBPyg/4b3W3A+1w167pqj
   kRbna51QJpwplqTp5cjZCYv5iDXfT34VOtBZdCFDcmjoBQHoOWAlYgsZ9
   RCMLClivFZu7RGRL4Lx+orgpUxocuQhD1jjzF7xlEF8F1VaUMo+is241H
   w==;
X-CSE-ConnectionGUID: qqy33tPfTBugHT9/BOiD+A==
X-CSE-MsgGUID: /KqO8laWQsSniASZjpkcZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63374439"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63374439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:49:04 -0700
X-CSE-ConnectionGUID: OcX6su+xR2uYN5Mf8fl0EQ==
X-CSE-MsgGUID: nWp/NyGvTCC6Oowq+T7s4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="184323445"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.246.16.157]) ([10.246.16.157])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 03:49:00 -0700
Message-ID: <dc2662f4-98b5-4fc8-9ed7-5e4a88168f9a@linux.intel.com>
Date: Fri, 24 Oct 2025 12:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/ivpu: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
References: <20251024095205.123123-1-marco.crivellari@suse.com>
 <20251024095205.123123-3-marco.crivellari@suse.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20251024095205.123123-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/2025 11:52 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistentcy cannot be addressed without refactoring the API.
>
> system_wq should be the per-cpu workqueue, yet in this name nothing makes
> that clear, so replace system_wq with system_percpu_wq.
>
> The old wq (system_wq) will be kept for a few release cycles.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/accel/ivpu/ivpu_hw_btrs.c | 2 +-
>  drivers/accel/ivpu/ivpu_ipc.c     | 2 +-
>  drivers/accel/ivpu/ivpu_job.c     | 2 +-
>  drivers/accel/ivpu/ivpu_mmu.c     | 2 +-
>  drivers/accel/ivpu/ivpu_pm.c      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.c b/drivers/accel/ivpu/ivpu_hw_btrs.c
> index afdb3b2aa72a..27a345f3befe 100644
> --- a/drivers/accel/ivpu/ivpu_hw_btrs.c
> +++ b/drivers/accel/ivpu/ivpu_hw_btrs.c
> @@ -673,7 +673,7 @@ bool ivpu_hw_btrs_irq_handler_lnl(struct ivpu_device *vdev, int irq)
>  
>  	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, SURV_ERR, status)) {
>  		ivpu_dbg(vdev, IRQ, "Survivability IRQ\n");
> -		queue_work(system_wq, &vdev->irq_dct_work);
> +		queue_work(system_percpu_wq, &vdev->irq_dct_work);
>  	}
>  
>  	if (REG_TEST_FLD(VPU_HW_BTRS_LNL_INTERRUPT_STAT, FREQ_CHANGE, status)) {
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index 5f00809d448a..1f13bf95b2b3 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -459,7 +459,7 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
>  		}
>  	}
>  
> -	queue_work(system_wq, &vdev->irq_ipc_work);
> +	queue_work(system_percpu_wq, &vdev->irq_ipc_work);
>  }
>  
>  void ivpu_ipc_irq_work_fn(struct work_struct *work)
> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
> index 060f1fc031d3..7a1f78b84b09 100644
> --- a/drivers/accel/ivpu/ivpu_job.c
> +++ b/drivers/accel/ivpu/ivpu_job.c
> @@ -574,7 +574,7 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
>  		 * status and ensure both are handled in the same way
>  		 */
>  		job->file_priv->has_mmu_faults = true;
> -		queue_work(system_wq, &vdev->context_abort_work);
> +		queue_work(system_percpu_wq, &vdev->context_abort_work);
>  		return 0;
>  	}
>  
> diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
> index 5ea010568faa..e1baf6b64935 100644
> --- a/drivers/accel/ivpu/ivpu_mmu.c
> +++ b/drivers/accel/ivpu/ivpu_mmu.c
> @@ -970,7 +970,7 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
>  		}
>  	}
>  
> -	queue_work(system_wq, &vdev->context_abort_work);
> +	queue_work(system_percpu_wq, &vdev->context_abort_work);
>  }
>  
>  void ivpu_mmu_evtq_dump(struct ivpu_device *vdev)
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index ffa2ba7cafe2..0cff8f808429 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -226,7 +226,7 @@ void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
>  	unsigned long timeout_ms = ivpu_tdr_timeout_ms ? ivpu_tdr_timeout_ms : vdev->timeout.tdr;
>  
>  	/* No-op if already queued */
> -	queue_delayed_work(system_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
> +	queue_delayed_work(system_percpu_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
Thanks for the patch. Please fix the checkpatch warning: 

WARNING: line length of 104 exceeds 100
columns                                                                           
#90: FILE:
drivers/accel/ivpu/ivpu_pm.c:229:                                                                              
+       queue_delayed_work(system_percpu_wq,
&vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));  
>  }
>  
>  void ivpu_stop_job_timeout_detection(struct ivpu_device *vdev)

Also there's a typo "consistentcy" -> "consistency" that can get fixed
with together with that warning.

Tested-by: Karol Wachowski <karol.wachowski@linux.intel.com>         



