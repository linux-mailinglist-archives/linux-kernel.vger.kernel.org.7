Return-Path: <linux-kernel+bounces-897168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D56C522EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979A6189109B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F213176E6;
	Wed, 12 Nov 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewoG+OBj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A7318157;
	Wed, 12 Nov 2025 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948818; cv=none; b=gAp/uPsl+oTZ9SbLo0x2eKzuLNqNE29ofFgVZYgMF4WY8JXAhS6A/FLQxCYW9aE7S4HY0dFY8Exj878KXRNsSOkdYv8i03Nur8NK3kwLz8axCrPxKIU7bdwVaNQiNEXK/9SGyg7DpPOljcBIABMn3Kn1UKQ86kJDApnpBwjYEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948818; c=relaxed/simple;
	bh=yNMzDkiBvRPGvfsdeVuCxKro3faGtAIvfp93k/ztiy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6u/mqdzHEH0e0oefpm7Tq1BGS+vySu4rd3Y1UzvfTmU/pJgfDZVF1Fjr9nh1t74RHoG7f+z2Qpc6TqAMNUr8Ye6OCDRe51mExmcw2ZhNvFx7/rG2T/CsTppD4QMr0O5gC6kANuIx8yIK4wxVoCJjFBoroR0alcQr+cU9NBBH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewoG+OBj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762948817; x=1794484817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yNMzDkiBvRPGvfsdeVuCxKro3faGtAIvfp93k/ztiy0=;
  b=ewoG+OBjk0eO0Nqm8xuiO5oWOSIUdOX/ph9TaQDq9DSB0m8gIT4lkFGW
   U5H134DAMEXXs4X80G4tKCkF4Q1gVs95ROoS5L0BMipNXj0fb1MzezMud
   Hh3eNowmFCklTlCL7mQZ6vH1kSRXpAhuXlvMCw4aCJJOXmas/V/cM1CgL
   SQkCxxNxmFlCHuXy0TwG7i8DzWqUj91UjTvvGlv1H7XA8W3wwV1FJcJU0
   ujB08pTJwVRjPs4x1vggwqfTBSTelWBp/W7Z/s46cpKryBZluM88GHGND
   4H/ztbrbOQUdMjQwTk/XFFx/S2O49Mu3jCP9Gek/SttrKmAba3xQrGCft
   w==;
X-CSE-ConnectionGUID: oiM2oaz6QCmtUKwpyQekEA==
X-CSE-MsgGUID: 8T4qb9sjQ9WjbRar1S9/uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64018070"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64018070"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:00:16 -0800
X-CSE-ConnectionGUID: peze6xEmQFK/sBOoGFFjyQ==
X-CSE-MsgGUID: y8V6RQXLQf6HQwx21HrjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="226470407"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.225]) ([10.245.244.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 04:00:13 -0800
Message-ID: <2a80955c-2e89-4175-9688-6ca29538dd33@linux.intel.com>
Date: Wed, 12 Nov 2025 14:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci: replace use of system_wq with system_percpu_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20251106145428.250251-1-marco.crivellari@suse.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20251106145428.250251-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 16:54, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> Switch to using system_percpu_wq because system_wq is going away as part of
> a workqueue restructuring.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---

Thanks, added to queue
-Mathias   


