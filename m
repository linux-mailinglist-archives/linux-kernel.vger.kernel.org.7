Return-Path: <linux-kernel+bounces-877714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CBFC1ED68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 327774E75A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E102BE7DF;
	Thu, 30 Oct 2025 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGWwGWKH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E717BA6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810372; cv=none; b=d+EZ5FgEY4DOVruX1/WjbCuC4N31brr9gr7avp5N4w87Av+yAPrWKFM2FxEvCeDb42lzvvrYgyW6RJt95RYRGDHyXRg0VISFX1+UA6mF5WBvDUNiiy5XrZrkYaUq7dipk1D+PRMge5T4XTHJyM7B65+LD2P+rCrmDmCnerP+V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810372; c=relaxed/simple;
	bh=vuaUiNMEV0X8JMPwi/b8xI/210Cvx0C75+BaWdoEN40=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=un1BzfMXZMNZXtoNbOthaR9lsFREJyj1Nj35ykxamysQSuhw/VGUtqvTM0jy3dcHFK5LAur5rbkx+N+TToMiR2NOnscZ/29tDJp9WzbNWarXv3E88T0HuYPj2+JvGb/rtlTIw4Pa3ztug6uY8fcHOJ56UBfTxFzkbjWzBBq0skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGWwGWKH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761810370; x=1793346370;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vuaUiNMEV0X8JMPwi/b8xI/210Cvx0C75+BaWdoEN40=;
  b=eGWwGWKHFypux83chfF8rDkyKqW/6dwwJHWDM9ec+etCneSVESg4Zi+B
   hZRfvdrAiN6IPhYIhrRdyHehQqDGy0gwM/aSK2uOMy4ie2EhSw2DdnmkN
   dg65bRSm/vkdK35TioUwnArSty0fgtfcuhh6exyQ56Lwl6zl2tm9Q0Sk6
   0KOSvTOK8jOnKD3sFvbnaY2pBvab0tM2IkB8ma8wVnbILeUfTDwLMFAes
   xtvLWV9dE1xMVtIpPJo7FcQfJJgIcAJauPFqsVlIaQpCbbKclP4wbdX7D
   pvNhmBazEENtK22RYL92VNQ0d+Dn3V68EXDedn2q8Br7cww5cnEynLH+3
   g==;
X-CSE-ConnectionGUID: Xi1QJOZqTdingOx7w/ZEEA==
X-CSE-MsgGUID: r6QvTdREQ9qzNv3O/I3R1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63846143"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63846143"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:46:08 -0700
X-CSE-ConnectionGUID: PRRlbPuHS36EwSQFDrAsKg==
X-CSE-MsgGUID: y2+ZtTdDRayW7YURyIrzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190219305"
Received: from kwachows-mobl.ger.corp.intel.com (HELO [10.246.16.226]) ([10.246.16.226])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:46:06 -0700
Message-ID: <485ced4a-78bb-48a7-9494-b9705db9b650@linux.intel.com>
Date: Thu, 30 Oct 2025 08:46:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] accel/ivpu: replace use of system_unbound_wq with
 system_dfl_wq
From: Karol Wachowski <karol.wachowski@linux.intel.com>
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
 <f18e26c0-f4f3-4221-ba92-218698ec088e@linux.intel.com>
Content-Language: en-US
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <f18e26c0-f4f3-4221-ba92-218698ec088e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/2025 9:01 PM, Karol Wachowski wrote:
> On 10/29/2025 5:56 PM, Marco Crivellari wrote:
>> Currently if a user enqueue a work item using schedule_delayed_work() the
>> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
>> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
>> schedule_work() that is using system_wq and queue_work(), that makes use
>> again of WORK_CPU_UNBOUND.
>>
>> This lack of consistency cannot be addressed without refactoring the API.
>>
>> system_unbound_wq should be the default workqueue so as not to enforce
>> locality constraints for random work whenever it's not required.
>>
>> Adding system_dfl_wq to encourage its use when unbound work should be used.
>>
>> The old system_unbound_wq will be kept for a few release cycles.
>>
>> Suggested-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>> ---
>>  drivers/accel/ivpu/ivpu_pm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
>> index 475ddc94f1cf..ffa2ba7cafe2 100644
>> --- a/drivers/accel/ivpu/ivpu_pm.c
>> +++ b/drivers/accel/ivpu/ivpu_pm.c
>> @@ -186,7 +186,7 @@ void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
>>  	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
>>  		ivpu_hw_diagnose_failure(vdev);
>>  		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
>> -		queue_work(system_unbound_wq, &vdev->pm->recovery_work);
>> +		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
>>  	}
>>  }
> Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>>  
Pushed to drm-misc-next.
-Karol

