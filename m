Return-Path: <linux-kernel+bounces-607009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057ECA8B6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589D11903998
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674F221549;
	Wed, 16 Apr 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s0bh0Bpd"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25C31FE471
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799727; cv=none; b=TNIqkPo1vvSVxidHbvD1W9P6TWVzXZEVEanIQh5cL4ilLHOygh29UWlfH97wcka14IT5Jss57EJiCrp9nxzczKo4+fx2uIMsjfd6rhLDwS4OAUnla9VgSuN75JcT3th3LR/vj+QVVDqCGUj5LnIeK1RErUdZytZeCSsG7oECiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799727; c=relaxed/simple;
	bh=A625GxETBQiWpns00F3hsYBYUdJKWiduJkv9pWDvB/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfUMbOaR5M3IAdC9gT89YFE4si/2FRB9mHHgjIjcCjLTwa3ULxr7gC7KzVxb6zQgVjF7WdLSK1YCu6O8lbkhAMxbvvAdzoLsgivJYiz8XTrFf3m55DpOmf6Jt/pw41OfAgO5DxBnYCDzl/ZsJ84r4A9Vrc+L2kgoGRSV8h8UG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s0bh0Bpd; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <507eb775-d7df-4dd2-a7d1-626d5a51c1de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744799721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QspB9LX1pO0MySulBBzyvthxCUpy5u5bLOXGfquKjvw=;
	b=s0bh0BpdqAM+iGHgvIf3IzcUJS78f0G04cHOeJi94ZVwIsZJCLZP9fWn5BNi0K/tg5daHp
	gmDF2pfUHsfK0eJaIBfl8Ku8nXUQUj3xyhIHZKcVbmLii90p5QZqOzjA/kWS655dLP17Hb
	pujMWZJp6skk71jr3evkml5qT0RbzRI=
Date: Wed, 16 Apr 2025 11:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
 <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev>
 <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
 <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev>
 <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
 <39839bcb-90e9-4886-913d-311c75c92ad8@linux.dev>
 <CAMuE1bHsPeaokc-_qR4Ai8o=b3Qpbosv6MiR5_XufyRTtE4QFQ@mail.gmail.com>
 <44b67f86-ed27-49e8-9e15-917fa2b75a60@linux.dev>
 <CAMuE1bFk=LFTWfu8RFJeSoPtjO8ieJDdEHhHpKYr4QxqB-7BBg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMuE1bFk=LFTWfu8RFJeSoPtjO8ieJDdEHhHpKYr4QxqB-7BBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/04/2025 07:33, Sagi Maimon wrote:
> On Mon, Apr 14, 2025 at 4:55 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 14/04/2025 14:43, Sagi Maimon wrote:
>>> On Mon, Apr 14, 2025 at 4:01 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 14/04/2025 12:38, Sagi Maimon wrote:
>>>>> On Mon, Apr 14, 2025 at 2:09 PM Vadim Fedorenko
>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>
>>>>>> On 14/04/2025 11:56, Sagi Maimon wrote:
>>>>>>> On Mon, Apr 14, 2025 at 12:37 PM Vadim Fedorenko
>>>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>>>
>>>>>>>> On 14/04/2025 09:54, Sagi Maimon wrote:
>>>>>>>>> Sysfs signal show operations can invoke _signal_summary_show before
>>>>>>>>> signal_out array elements are initialized, causing a NULL pointer
>>>>>>>>> dereference. Add NULL checks for signal_out elements to prevent kernel
>>>>>>>>> crashes.
>>>>>>>>>
>>>>>>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysfs nodes")
>>>>>>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>>>>>>>>> ---
>>>>>>>>>       drivers/ptp/ptp_ocp.c | 3 +++
>>>>>>>>>       1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>>>>>>>> index 7945c6be1f7c..4c7893539cec 100644
>>>>>>>>> --- a/drivers/ptp/ptp_ocp.c
>>>>>>>>> +++ b/drivers/ptp/ptp_ocp.c
>>>>>>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>>>>>>>>>           bool on;
>>>>>>>>>           u32 val;
>>>>>>>>>
>>>>>>>>> +     if (!bp->signal_out[nr])
>>>>>>>>> +             return;
>>>>>>>>> +
>>>>>>>>>           on = signal->running;
>>>>>>>>>           sprintf(label, "GEN%d", nr + 1);
>>>>>>>>>           seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
>>>>>>>>
>>>>>>>> That's not correct, the dereference of bp->signal_out[nr] happens before
>>>>>>>> the check. But I just wonder how can that even happen?
>>>>>>>>
>>>>>>> The scenario (our case): on ptp_ocp_adva_board_init we
>>>>>>> initiate only signals 0 and 1 so 2 and 3 are NULL.
>>>>>>> Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_summary_show
>>>>>>> when calling signal 2 or 3  the dereference occurs.
>>>>>>> can you please explain: " the dereference of bp->signal_out[nr] happens before
>>>>>>> the check", where exactly? do you mean in those lines:
>>>>>>> struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
>>>>>>        ^^^
>>>>>> yes, this is the line which dereferences the pointer.
>>>>>>
>>>>>> but in case you have only 2 pins to configure, why the driver exposes 4
>>>>>> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
>>>>>>
>>>>> I can (and will) expose only 2 sma in adva_timecard_attrs, but still
>>>>> ptp_ocp_summary_show runs
>>>>> on all 4 signals and not only on the on that exposed, is it not a bug?
>>>>
>>>> Yeah, it's a bug, but different one, and we have to fix it other way.
>>>>
>>> Do you want to instruct me how to fix it , or will you fix it?
>>
>> well, the original device structure was not designed to have the amount
>> of SMAs less than 4. We have to introduce another field to store actual
>> amount of SMAs to work with, and adjust the code to check the value. The
>> best solution would be to keep maximum amount of 4 SMAs in the structure
>> but create a helper which will init new field and will have
>> BUILD_BUG_ON() to prevent having more SMAs than fixed size array for
>> them. That will solve your problem, but I will need to check it on the
>> HW we run.
>>
> just to be clear you will write the fix and test it on your HW, so you
> don't want me to write the fix?

Well, it would be great if you can write the code which will make SMA
functions flexible to the amount of pin the HW has. All our HW has fixed
amount of 4 pins that's why the driver was coded with constants. Now
your hardware has slightly different amount of pins, so it needs
adjustments to the driver to work properly. I just want to be sure that
any adjustments will not break my HW - that's what I meant saying I'll
test it.

>>>>>>> struct ptp_ocp_signal *signal = &bp->signal[nr];
>>>>>>>> I believe the proper fix is to move ptp_ocp_attr_group_add() closer to
>>>>>>>> the end of ptp_ocp_adva_board_init() like it's done for other boards.
>>>>>>>>
>>>>>>>> --
>>>>>>>> pw-bot: cr
>>>>>>
>>>>
>>


