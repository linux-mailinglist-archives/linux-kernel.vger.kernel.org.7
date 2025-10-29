Return-Path: <linux-kernel+bounces-877070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30340C1D1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95754260F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F530E0EF;
	Wed, 29 Oct 2025 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+/q/EKq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2324C076
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768117; cv=none; b=G00Breq/0HORtXnaH7An8bKwir2xIwcmN/GhAvBiSJZsZrd6NIX+sT8jwmw1XvjMWNVv6XilT7FGclz15EtREEB5hEDKkBJi+LmEyc4/rapVfgbt/HsLzEdLoeB1KyyVg4lCZC/2c+CWOtOfjLWuZkDGkSb6P/+ELqzzDKNlRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768117; c=relaxed/simple;
	bh=nZH8k01WM1ZD2QNw1i3V/qcFjBnvGzd/8+qBO/Q6O30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qs6/PZR4588R1bSNYKiKl/Ml5Y6H3efgvYObParfR7BFpp/9bnrSSF38xPbvW5xuKSe9irXsGN1gdk4+lKSuKdrJniiiRibyZy1LCpGR439yEbmEYhU9iZP5LtKVJE0+R8cyf/0Om78ESTndTcnGlXefPDMn1ZhVwrkL1VkUYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+/q/EKq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761768116; x=1793304116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nZH8k01WM1ZD2QNw1i3V/qcFjBnvGzd/8+qBO/Q6O30=;
  b=C+/q/EKqwgVh7KPQYHK9ntKClV1K4OPxQ8W/rg7JdMAkEFp7Ha7mfETv
   NtTOhsbiURjS9B8oaFtcZtu1GmOaj03/mJlms/PlvbZZMlmflQAH2M3c3
   sOmGZ1TiHOzAEQyYqX1airmV1L1AHowPpXd+4KTrZZq2yPOAuz9plvrkU
   OAE3BvuLbrC25jbOi8rw5YZpnZx7VsIgMzzHwGdcsvQJD8zcFQGzFgKSQ
   9GGDw99PxVYesBrRA/jgM8DVezaqXRCW9S60XAVbtqndJCzDMSptEj/pV
   hL1jh2rjJhhMiRO++jgbTlawFOjkwBw0g5Pq/VF08eZt99PwLbfaIT89K
   Q==;
X-CSE-ConnectionGUID: Brt7+d/vSACiXDeDJIEw2Q==
X-CSE-MsgGUID: M7uHIFqlQyOR/XcmBX/p1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63936878"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="63936878"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:01:55 -0700
X-CSE-ConnectionGUID: fF+KWoEfRmG05aLCyMW3hg==
X-CSE-MsgGUID: oeLCM16MQgy8fJPLkQg0NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="185637674"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.94.253.106]) ([10.94.253.106])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 13:01:52 -0700
Message-ID: <f18e26c0-f4f3-4221-ba92-218698ec088e@linux.intel.com>
Date: Wed, 29 Oct 2025 21:01:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] accel/ivpu: replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
References: <20251029165642.364488-1-marco.crivellari@suse.com>
 <20251029165642.364488-2-marco.crivellari@suse.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20251029165642.364488-2-marco.crivellari@suse.com>
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
> system_unbound_wq should be the default workqueue so as not to enforce
> locality constraints for random work whenever it's not required.
>
> Adding system_dfl_wq to encourage its use when unbound work should be used.
>
> The old system_unbound_wq will be kept for a few release cycles.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/accel/ivpu/ivpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
> index 475ddc94f1cf..ffa2ba7cafe2 100644
> --- a/drivers/accel/ivpu/ivpu_pm.c
> +++ b/drivers/accel/ivpu/ivpu_pm.c
> @@ -186,7 +186,7 @@ void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
>  	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
>  		ivpu_hw_diagnose_failure(vdev);
>  		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
> -		queue_work(system_unbound_wq, &vdev->pm->recovery_work);
> +		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
>  	}
>  }
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>  

