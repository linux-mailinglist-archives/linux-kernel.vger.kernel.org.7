Return-Path: <linux-kernel+bounces-796685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12ECB405E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523065E42F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD1307491;
	Tue,  2 Sep 2025 13:54:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F35305E01
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821250; cv=none; b=jdw88bA7QX9Ixufi6pDWsOCmCWnhp1bz2y3lvzBrqK3KNkPaStKISRGGJszq3P8mn11WqMZ8AQJxawi/ZpUVbDqP7FRQLlXwc2p/L//jSzboPmsafZjC2OaWXYEL2N6Wk7gqRATGzR1LzE00NDrRVHk+agRjYb+yUSn5IRdygD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821250; c=relaxed/simple;
	bh=+yKgEeSpPgSQD8XWiY3BT7wZLG5ygRAQJKULvUeeiS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d49+5Kk092u60TgfTPXQ4E/huUIE6QXVG6gOSCFSTRX241EpOvlIakJ6xXOrlolBIFJi5nCk3smTIJ9zRJ9GPsVn9cutyrRozuJdKnCydGWTEBQVq8DpUXxhmrGcdyM+nokRlb0Zh5PZsnlFa7adcKbhX6QrgxF066UGfWOErEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F7A26BE;
	Tue,  2 Sep 2025 06:53:59 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012033F6A8;
	Tue,  2 Sep 2025 06:54:05 -0700 (PDT)
Message-ID: <9025e90b-3385-467b-ac24-1b1f60767ef9@arm.com>
Date: Tue, 2 Sep 2025 14:53:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] sched_ext: Harden scx_bpf_cpu_rq()
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
References: <20250902111143.2667154-1-christian.loehle@arm.com>
 <aLbb9ljZvAvghZa8@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aLbb9ljZvAvghZa8@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 12:58, Andrea Righi wrote:
> On Tue, Sep 02, 2025 at 12:11:40PM +0100, Christian Loehle wrote:
>> scx_bpf_cpu_rq() currently allows accessing struct rq fields without
>> holding the associated rq.
>> It is being used by scx_cosmos, scx_flash, scx_lavd, scx_layered, and
>> scx_tickless. Fortunately it is only ever used to fetch rq->curr.
>> So provide an alternative scx_bpf_remote_curr() that doesn't expose struct rq
>> and provide a hardened scx_bpf_cpu_rq_locked() by ensuring we hold the rq lock.
>> Add a deprecation warning to scx_bpf_cpu_rq() that mentions the two alternatives.
>>
>> This also simplifies scx code from:
>>
>> rq = scx_bpf_cpu_rq(cpu);
>> if (!rq)
>> 	return;
>> p = rq->curr
>> /* ... Do something with p */
>>
>> into:
>>
>> p = scx_bpf_remote_curr(cpu);
>> /* ... Do something with p */
> 
> This looks good to me.
> 
> We should probably add a __COMPAT_scx_bpf_remote_curr() macro, so that the
> BPF schedulers can be updated to use this new kfunc without breaking the
> compatibility with older kernels, but we can do this later, I'll send a
> follow-up patch. For now:
> 
> Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks!
I'd have the compat patch ready as well and would send it out in a bit.


