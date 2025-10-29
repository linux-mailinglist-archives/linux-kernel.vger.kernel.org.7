Return-Path: <linux-kernel+bounces-877071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29AC1D1F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A0B4271AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA380304BC9;
	Wed, 29 Oct 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLY/fsWW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEEA2F6187
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768151; cv=none; b=hVbf4x+FjopDpt9UQv8OGGzGKzTOEPnoceFdsaorWCqf9k2FiXV/j/dcu7J4AFs3LVJurHQJHH4UzzO2jETtcAsbioM2ZejDj3zGVesD7WrOMiWpqyp+mFrj8CGCR1ofzRFPYzFBg4tU+C3C4yodAHg+l2i54JC4x6UXsI3PpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768151; c=relaxed/simple;
	bh=2ZK4uGeXdJwOgsS9F07jxBmw5E1UYsyBrUyuQ1egEu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmFeD7B9Ly/XNOu+AfHdfsFfu76x4no4MxAxgi1bXKL1r8OTTTDQ55GCcp+TJlrQcYh0dQ95LHM56fK2JBV3oIqiUgb6AKGM4RrRGgsLxGtpa+oPuRxCd7k5Fcibnls79tmVzNiYHS0P7wJ1F1SqZN1qX9/Vt4on/6nHeGXLVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLY/fsWW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761768150; x=1793304150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZK4uGeXdJwOgsS9F07jxBmw5E1UYsyBrUyuQ1egEu4=;
  b=PLY/fsWWHy4kKqTlfNNB2xpPvvaznpCeoac8+Jq+VROmWutPd6TCNBg2
   CuyeaVsS9wsiTsriwnl8T1/eDMDtXduedZHWons1veQsC+FTwWvp9CoFh
   d0NQsIJdz9tna+Rj4eznO+YRWaPNErpIN+bwBx+5rDpU6jtJtI55ENe37
   9IpcntCds9Yf9MVsXsIB63rblS+20ujRWHS/+Q5pIFKA1irIACLTgFd6K
   ag/IgCUqov2Aebh7dLmkOOWgyD/jtzhU07zpRn4LRwwTlYHp88+M2KqJX
   b9fu+O8BCjyzY/I/MeBr4L3QCeQEsFZGGvF6yp8PDAZbgAjhvB0my/kLz
   w==;
X-CSE-ConnectionGUID: cUx+ulcWT12OEg3NyzOO2Q==
X-CSE-MsgGUID: 6A6UhF/3QLqqfj41xhWgYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74191620"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74191620"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:02:29 -0700
X-CSE-ConnectionGUID: TBZ2kTrTSeyFEU3sRpkVYg==
X-CSE-MsgGUID: V9uMWKJiTRW1w2hKMmjuyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185637770"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106]) ([10.94.253.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:02:26 -0700
Message-ID: <eafe034a-0c87-452e-b202-bd53fbdf12ac@linux.intel.com>
Date: Wed, 29 Oct 2025 21:02:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] accel/ivpu: replace use of system_wq with
 system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
References: <20251029165642.364488-1-marco.crivellari@suse.com>
 <20251029165642.364488-3-marco.crivellari@suse.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20251029165642.364488-3-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/2025 5:56 PM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
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
>  drivers/accel/ivpu/ivpu_pm.c      | 3 ++-
>  5 files changed, 6 insertions(+), 5 deletions(-)
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
> index ffa2ba7cafe2..9ecba05ce7db 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -226,7 +226,8 @@ void ivpu_start_job_timeout_detection(struct ivpu_device *vdev)
>  	unsigned long timeout_ms = ivpu_tdr_timeout_ms ? ivpu_tdr_timeout_ms : vdev->timeout.tdr;
>  
>  	/* No-op if already queued */
> -	queue_delayed_work(system_wq, &vdev->pm->job_timeout_work, msecs_to_jiffies(timeout_ms));
> +	queue_delayed_work(system_percpu_wq, &vdev->pm->job_timeout_work,
> +			   msecs_to_jiffies(timeout_ms));
>  }
>  
>  void ivpu_stop_job_timeout_detection(struct ivpu_device *vdev)
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>

