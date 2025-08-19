Return-Path: <linux-kernel+bounces-775931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136BB2C686
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7A1BC13B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711920299E;
	Tue, 19 Aug 2025 14:01:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02B1B3937
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612084; cv=none; b=l776Qlitsp7va1bFSxQgdMyH71VsUKVjZm6X/JBwg7DhIwqkSXb0OtOZbE2WOrVRD6WAlMC3TauiF2VnobqlnmFMp+MTAZScZLNO7/SQLlizLvfb2Runs53hmZf3twKJ3tk/JrzOcSytv3LA0usJBegDQdDCT4VyUUa8DSx1pGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612084; c=relaxed/simple;
	bh=TcTeUqbkqLj9CCwqsz0MGU10GALiLuO+CUQJWQXxcic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evBTvEtxF0hCiHVcxhNF4PJVAbCz3OGMqvPS3lwK0b01Oq5MkVy111waebnKkj+Vz6LUXAYfFHyzlOhYRmhvS6I/u7CTynkuzlSJ5tLjMswT3f26M1aN/EO7OuQtfce0tnOuB9g/drLdt6+60sCiZ8smK+1x+1s2wVCRaTArx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05CE916A3;
	Tue, 19 Aug 2025 07:01:13 -0700 (PDT)
Received: from [10.154.68.1] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921323F63F;
	Tue, 19 Aug 2025 07:01:16 -0700 (PDT)
Message-ID: <7b3601d1-f39e-4691-84d1-8aa397e06535@arm.com>
Date: Tue, 19 Aug 2025 15:01:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/feec: Simplify the traversal of pd'cpus
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
 Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 vdonnefort@google.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org
References: <20250812093339.8895-1-xuewen.yan@unisoc.com>
 <cf7847e4-78a6-4286-baba-60ace0c3d507@arm.com>
 <CAB8ipk9BDzsTTcdRKc9R_Hc72cOY8YyUfrCoY3_9hPJ8D-Fg_Q@mail.gmail.com>
 <8a84e658-1c2d-4380-8979-e1cc5bf5768d@arm.com>
 <CAB8ipk8kf1+Vd94wQn1XnWPvWqP1szxAeUroos1iV6Z17vbxFg@mail.gmail.com>
 <e3861092-71d3-4f36-8013-d721f60c1392@arm.com>
 <CAB8ipk8W8Oj2vu14sGX0wncPpJRD=xL35U8QW1wou-CX+3H0KA@mail.gmail.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <CAB8ipk8W8Oj2vu14sGX0wncPpJRD=xL35U8QW1wou-CX+3H0KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19.08.25 03:02, Xuewen Yan wrote:
> On Mon, Aug 18, 2025 at 11:24 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 18.08.25 12:05, Xuewen Yan wrote:
>>> On Fri, Aug 15, 2025 at 9:01 PM Dietmar Eggemann
>>> <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 14.08.25 10:52, Xuewen Yan wrote:
>>>>> Hi Dietmar,
>>>>>
>>>>> On Thu, Aug 14, 2025 at 4:46 PM Dietmar Eggemann
>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>
>>>>>> On 12.08.25 10:33, Xuewen Yan wrote:

[...]

>> Looks like we do need also the sd cpumask here.
>>
>> Consider this tri-gear system:
>>
>> #  cat /sys/devices/system/cpu/cpu*/cpu_capacity
>> 160
>> 160
>> 160
>> 160
>> 498
>> 498
>> 1024
>> 1024
>>
>> and 2 exclusive cpusets cs1={0-1,4,6} and cs2={2-3,5,7}, so EAS is
>> possible in all 3 root_domains (/, /cs1, /cs2):
> 
> Isn't your CPU an ARM Dynamiq architecture?
> In my understanding, for Dynamiq arch, there is only one MC domain...
> Did I miss something?

Ah, should have mentioned that this is qemu. I used a dts file
(qemu-system-aarch64 ... -dtb foo.dtb) with individual
'next-level-cache' entries for the CPUs {0-3}, {4-5} and {6-7} so that's
why you see MC & PKG. Removing those gives you a system with only MC:

[  106.986828] CPU2 attaching sched-domain(s):
[  106.987846]  domain-0: span=2-3,5,7 level=MC
[  106.987941]   groups: 2:{ span=2 cap=159 }, 3:{ span=3 cap=154 }, 5:{
span=5 cap=495 }, 7:{ span=7 cap=991 }
[  106.988842] CPU3 attaching sched-domain(s):
[  106.989096]  domain-0: span=2-3,5,7 level=MC
[  106.989136]   groups: 3:{ span=3 cap=154 }, 5:{ span=5 cap=495 }, 7:{
span=7 cap=991 }, 2:{ span=2 cap=159 }
[  106.989679] CPU5 attaching sched-domain(s):
[  106.989692]  domain-0: span=2-3,5,7 level=MC
[  106.989773]   groups: 5:{ span=5 cap=495 }, 7:{ span=7 cap=991 }, 2:{
span=2 cap=159 }, 3:{ span=3 cap=154 }
[  106.990466] CPU7 attaching sched-domain(s):
[  106.990482]  domain-0: span=2-3,5,7 level=MC
[  106.990632]   groups: 7:{ span=7 cap=991 }, 2:{ span=2 cap=159 }, 3:{
span=3 cap=154 }, 5:{ span=5 cap=495 }
[  106.997604] root domain span: 2-3,5,7
[  106.998267] CPU0 attaching sched-domain(s):
[  106.998278]  domain-0: span=0-1,4,6 level=MC
[  106.998295]   groups: 0:{ span=0 cap=159 }, 1:{ span=1 cap=160 }, 4:{
span=4 cap=496 }, 6:{ span=6 cap=995 }
[  106.998584] CPU1 attaching sched-domain(s):
[  106.998592]  domain-0: span=0-1,4,6 level=MC
[  106.998604]   groups: 1:{ span=1 cap=160 }, 4:{ span=4 cap=496 }, 6:{
span=6 cap=995 }, 0:{ span=0 cap=159 }
[  106.999477] CPU4 attaching sched-domain(s):
[  106.999487]  domain-0: span=0-1,4,6 level=MC
[  106.999504]   groups: 4:{ span=4 cap=496 }, 6:{ span=6 cap=995 }, 0:{
span=0 cap=159 }, 1:{ span=1 cap=160 }
[  107.000070] CPU6 attaching sched-domain(s):
[  107.000082]  domain-0: span=0-1,4,6 level=MC
[  107.000095]   groups: 6:{ span=6 cap=995 }, 0:{ span=0 cap=159 }, 1:{
span=1 cap=160 }, 4:{ span=4 cap=496 }
[  107.000721] root domain span: 0-1,4,6
[  107.001152] root_domain 2-3,5,7: pd6:{ cpus=6-7 nr_pstate=4 } pd4:{
cpus=4-5 nr_pstate=4 } pd0:{ cpus=0-3 nr_pstate=4 }
[  107.001869] root_domain 0-1,4,6: pd6:{ cpus=6-7 nr_pstate=4 } pd4:{
cpus=4-5 nr_pstate=4 } pd0:{ cpus=0-3 nr_pstate=4 }

[...]

