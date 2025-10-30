Return-Path: <linux-kernel+bounces-879136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5FBC225A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C81896A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64269329E51;
	Thu, 30 Oct 2025 20:53:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF22934D381
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857637; cv=none; b=NGxXQDkRlB13bo3faqJyUI2HKEqnbPabe52qE36rEdN93Npad1yYYyoFfFQxpg4Wmtszs7DTeb7xsbk41Ui2ZH719gpFOUV6kzQzokOFVNwp3ZdMumEPzpniZ7yTK3AwceI3nWFGQyhvaMEb08HomWGKGlVTFQTPOjpmd2SOPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857637; c=relaxed/simple;
	bh=4UUILT+XE/ynC6tQo7M7UBDDdRiufVw1/KI8YewZb/c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TJrESRSory0ElNGqCjKIdLXRvufarXX49x/mGaf0tTh9yWpq/d7UTiw/GiXcQD1j0qaattzrpIOGZzChfz+sq4W3RHDrxPob8bB4yhURKe4bfozEyn2VWkvfZKOglQOdBEzDFJr+A5bvdMRxnDZg1cxUMe1kjO2jwFvbIdLAnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D882C40;
	Thu, 30 Oct 2025 13:53:46 -0700 (PDT)
Received: from [10.57.85.174] (unknown [10.57.85.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026463F66E;
	Thu, 30 Oct 2025 13:53:51 -0700 (PDT)
Message-ID: <f6379aa6-459d-4205-96ea-9848e55d7f9c@arm.com>
Date: Thu, 30 Oct 2025 21:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Peter Zijlstra <peterz@infradead.org>,
 Adam Li <adamli@os.amperecomputing.com>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>, Chris Mason
 <clm@meta.com>, clm@fb.com, Vincent Guittot <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
 <2aa7380b-bebd-4bb9-8597-49e06d1dcc6d@os.amperecomputing.com>
 <20251030093013.GI4067720@noisy.programming.kicks-ass.net>
Content-Language: en-GB
In-Reply-To: <20251030093013.GI4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.10.25 10:30, Peter Zijlstra wrote:
> 
> Hi Adam,
> 
> On Thu, Oct 30, 2025 at 03:22:34PM +0800, Adam Li wrote:
> 
>> Commit 155213a2aed4 brings ~6% regression for SpecJBB critical-jOPS on
>> AmpereOne server. 
>>
>> Baseline: v6.17 kernel + patch. Compared with baseline:
>> NI_TARGET	+7%
>> NI_SPARE	-3%
>> NI_RUNNABLE	-4%
>> NI_RANDOM	-3%
>>
>> So NI_TARGET reverts the performance regression.
>> The other options brings more regression for SpecJBB.
> 
> Excellent, how does NI_TARGET+NI_RANDOM work for you? Like Chris, I
> found that the schbench workload was really suffering from doing too
> many idle balance attempts that weren't really working out.
> 
> NI_RANDOM reduces the number of newidle balances based on the success
> ratio. Eg. if you have successful balancing 25% of the time, it will do
> 1 in 4 balances and count a successful balance as 4 to keep the
> accounting straight.
> 
> So workloads with a high success rate will keep newidle balance calls
> frequent, while workloads with a low success rate (like schbench) will
> greatly reduce the number of calls.

Results with OLTP 'hammerdb - mysqld' on Arm64 VMs

				NOPM		P50 latency

6.18-rc3			baseline	baseline

6.18-rc3-revert-155213a2aed4	+12%		-8.5%

6.18-rc3 NI_TARGET		+12%		-8.2%

6.18-rc3 NI_SPARE		+-0%		+-0%

6.18-rc3 NI_RUNNABLE		-1%		+1%

6.18-rc3 NI_RANDOM	        -1%		+1%

Looks like only NI_TARGET reverts the regression here.




