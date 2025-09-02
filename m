Return-Path: <linux-kernel+bounces-797056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735CB40B48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479803B3F83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7154342C92;
	Tue,  2 Sep 2025 16:56:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E5341ABA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832194; cv=none; b=IqvAWuR8eez91wLP9g+KdrT15vP1Ly8d5vxePaXXpBbnIRlENastQKzg3vgKl6O4nB2jb9WhxOr2oeS3lot2a1SIhKk8Pi7PZgJB7cEMY10WN13TlW0t+upZOpPCLmAFVASAdz+LJivBdGnFSw5TERMuDSzi7QdaYOVVJRtsCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832194; c=relaxed/simple;
	bh=VrVUYskoNxsEogVez72kB6K6V9e/1NCO8ZxTegVp+/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpY+a9sAmSfIQuYFbRXWdrKzd5lZGOXDt5ki1FH/qKiAceuj/4IwWdeE3wzEJ70TSTtOlFRYa3UKluM2ISF+2e6iJI+JzNxLnLdOAEPtWEuzRA9WazwpbFUunmLZdy+rUrOGOhVE8qLkTYAGEtdvHF47B+0i1fpBB5gv8I3ZYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFE326BE;
	Tue,  2 Sep 2025 09:56:23 -0700 (PDT)
Received: from [10.1.36.209] (unknown [10.1.36.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 893283F694;
	Tue,  2 Sep 2025 09:56:30 -0700 (PDT)
Message-ID: <06ca976e-03ff-4376-a29d-24993282dda0@arm.com>
Date: Tue, 2 Sep 2025 17:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] Don't broadcast TLBI if mm was only active on
 local CPU
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250829153510.2401161-1-ryan.roberts@arm.com>
 <aLcfvIfFb6xD-NXp@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aLcfvIfFb6xD-NXp@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 17:47, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 04:35:06PM +0100, Ryan Roberts wrote:
>> Beyond that, the next question is; does it actually improve performance?
>> stress-ng's --tlb-shootdown stressor suggests yes; as concurrency increases, we
>> do a much better job of sustaining the overall number of "tlb shootdowns per
>> second" after the change:
>>
>> +------------+--------------------------+--------------------------+--------------------------+
>> |            |     Baseline (v6.15)     |        tlbi local        |        Improvement       |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>> | nr_threads |     ops/sec |    ops/sec |     ops/sec |    ops/sec |     ops/sec |    ops/sec |
>> |            | (real time) | (cpu time) | (real time) | (cpu time) | (real time) | (cpu time) |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>> |          1 |        9109 |       2573 |        8903 |       3653 |         -2% |        42% |
>> |          4 |        8115 |       1299 |        9892 |       1059 |         22% |       -18% |
>> |          8 |        5119 |        477 |       11854 |       1265 |        132% |       165% |
>> |         16 |        4796 |        286 |       14176 |        821 |        196% |       187% |
>> |         32 |        1593 |         38 |       15328 |        474 |        862% |      1147% |
>> |         64 |        1486 |         19 |        8096 |        131 |        445% |       589% |
>> |        128 |        1315 |         16 |        8257 |        145 |        528% |       806% |
>> +------------+-------------+------------+-------------+------------+-------------+------------+
>>
>> But looking at real-world benchmarks, I haven't yet found anything where it
>> makes a huge difference; When compiling the kernel, it reduces kernel time by
>> ~2.2%, but overall wall time remains the same. I'd be interested in any
>> suggestions for workloads where this might prove valuable.
> 
> I suspect it's highly dependent on hardware and how it handles the DVM
> messages. There were some old proposals from Fujitsu:
> 
> https://lore.kernel.org/linux-arm-kernel/20190617143255.10462-1-indou.takao@jp.fujitsu.com/
> 
> Christoph Lameter (Ampere) also followed with some refactoring in this
> area to allow a boot-configurable way to do TLBI via IS ops or IPI:
> 
> https://lore.kernel.org/linux-arm-kernel/20231207035703.158053467@gentwo.org/
> 
> (for some reason, the patches did not make it to the list, I have them
> in my inbox if you are interested)
> 
> I don't remember any real-world workload, more like hand-crafted
> mprotect() loops.
> 
> Anyway, I think the approach in your series doesn't have downsides, it's
> fairly clean and addresses some low-hanging fruits. For multi-threaded
> workloads where a flush_tlb_mm() is cheaper than a series of per-page
> TLBIs, I think we can wait for that hardware to be phased out. The TLBI
> range operations should significantly reduce the DVM messages between
> CPUs.

I'll gather some more numbers and try to make a case for merging it then. I
don't really want to add complexity if there is no clear value.

Thanks for the review.

Thanks,
Ryan




