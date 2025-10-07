Return-Path: <linux-kernel+bounces-844254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C5BC162C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683EF3AB090
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065822DF154;
	Tue,  7 Oct 2025 12:40:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02302D9494;
	Tue,  7 Oct 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840831; cv=none; b=DLpLPpl4rXAMQ9FZ/N4x3KJPHdthT0+C3CIua7NcxSEZ7YYuC4NhR7H9pFRATi0YNdJnLaFZpXOirIVdn/OJW+KBsSMSTSX/7TsCAt5XE9KIdnBGN+I5vQMJYePDWNTk5skKHiccRBcKpMRshkJ1DWmZALRN0bnHTBPaO3JYv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840831; c=relaxed/simple;
	bh=f641r4J2AyZRWitszS0fbzxMAdMnCERCq43FF5E1Oac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5QRxkuQ81nvDfO7JbPlrl9/rKB2VzB5lcg4UMz0Y7/g+p5GUCChZhjbqvb+u0Eia4l9/bwb2GhULwQMujCWIie6vh4WGq/38n0CYmypxVfKsw7LWY67eelgDCY5QJ8mme0kaisXoaFkkfTNVpgHlMU0PjZJZU5OjpYCNW06oPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADBC1424;
	Tue,  7 Oct 2025 05:40:20 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78773F738;
	Tue,  7 Oct 2025 05:40:24 -0700 (PDT)
Message-ID: <7d13109d-28e6-46fa-898c-388fc9912710@arm.com>
Date: Tue, 7 Oct 2025 13:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
References: <20251006104652.630431579@infradead.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251006104652.630431579@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 11:46, Peter Zijlstra wrote:
> Hi,
> 
> So I had a poke at 'give @rf to pick_task() and fold balance_scx() into
> pick_task_scx()' option to see how terrible it was. Turns out, not terrible at
> all.
> 
> I've ran the sched_ext selftest and stress-ng --race-sched 0 thing with various
> scx_* thingies on.
> 
> These patches were done on top of the 'sched_change' patches posted just now:
> 
>   https://lkml.kernel.org/r/20251006104402.946760805@infradead.org
> 
> The combined set is also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup-pick
> 

FWIW I didn't run into any issues either running some scx scheduler + workload
combinations.

