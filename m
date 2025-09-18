Return-Path: <linux-kernel+bounces-753035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB25B17DF7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DB18892EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85071F463C;
	Fri,  1 Aug 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tlGvfOWP"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B64AE55B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035308; cv=none; b=IZeLmBKk5cPOIO2Mp63tPXtU20tl5gzxF4OeHEo97M9FO6qlOafegJM8IBQjppQqO9jQpM9XY+qQCFhqpW0VJqddttCcEOehxSUlrDukc+JSX2/hB7SHmtQvzW6TEj+pWBh77yAxcVXUwVQQm0Crr3rgAjbaVMTBgNUP7cURHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035308; c=relaxed/simple;
	bh=mkLz6sF2YbUhMHPRX3bgJEeL2CsP//jaoIhrndVAEzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmF3AlJNleU/ESJcsSp7aDnGDuPOn6jYvNRGMTPa2H31O0dhxMtZmFUYL8nvvqzDn047+BHoulv/xBXhPfAVuY1tUgJiefmovABUI/K62lJ2top97b2HK0UVWu5FzLl3EQiAx6x78Vaw1Kr/2e0ehaingAb/RPC/NNotY4lNpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tlGvfOWP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea6bf206-6a68-496e-a941-4423973ef4ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754035293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XH5a2VQAaaQ4ZI3DoGHt/qvwcnbj045BwWW5pl2b3M=;
	b=tlGvfOWP21kSoCXQKImOlhOGKD2x1g4VfQdo2eONBhh5YEnNrfL3+R5Q3wEPpKl+ieKovZ
	Nkkc04era8z9viThVlAOAkILZ8eFIFj1jMElYCY1z3Yvfl4x0kjm0v61HSAqk74PF/gOAx
	23s1e5cDQTFRdTCPGrH166R1Lh5wt2M=
Date: Fri, 1 Aug 2025 16:00:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] KVM: arm64: Dump instruction on hyp panic
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-2-smostafa@google.com>
 <4a807c89-d57b-463a-9166-836301ee9947@linux.dev>
 <CAFgf54q3KVOZ0Tji+dpnvnPCbvpN4z1Yhm5jfpEmDPhndo6bXA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <CAFgf54q3KVOZ0Tji+dpnvnPCbvpN4z1Yhm5jfpEmDPhndo6bXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Mostafa,

On 2025/7/31 21:05, Mostafa Saleh wrote:
> Hi Kunwu,
>
> On Thu, Jul 31, 2025 at 1:59 PM Kunwu Chan <kunwu.chan@linux.dev> wrote:
>> Hi Mostafa,
>> On 2025/7/18 07:47, Mostafa Saleh wrote:
>>
>> ... ....
>>
>>> +     /* Dump the faulting instruction */
>>> +     if (!is_protected_kvm_enabled() ||
>>> +         IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
>>> +             dump_instr(panic_addr + kaslr_offset());
>>> +
>> This part seem like unnecessary, cause it'll be remove in patch 2(Only
>> the comment left).
>>
> Yes, the idea is that the first patch adds that only for CONFIG_NVHE_EL2_DEBUG
> while the second does that for all configs, I split it this way as
> doing that with stage-2
> requires intrusive changes, so at least this patch can be picked
> separately if needed.
>
>>>        /*
>>>         * Hyp has panicked and we're going to handle that by panicking the
>>>         * kernel. The kernel offset will be revealed in the panic so we're
>> Another confusion is that no similar wording to what you mentioned in
>> the cover—specifically "Cannot dump pKVM nVHE stacktrace:
>> !CONFIG_PROTECTED_NVHE_STACKTRACE"—has been found in the code.
>>
> I am not sure I follow, this has nothing to do with
> "CONFIG_PROTECTED_NVHE_STACKTRACE"
> This series added the print for for instructions as:
> [   12.016044] Code: a8c17bfd d50323bf d65f03c0 d503245f (d4210000)
>
> All other prints are from already existing code.

Got it—I see what happened now. Turns out the confusion was caused

  by my CONFIG_PROTECTED_NVHE_STACKTRACE being enabled.

After turning that off and testing Patch 1 standalone, everything works 
exactly as you described.

The test results:

1: disable CONFIG_NVHE_EL2_DEBUG

--> "kvm [5375]: Hyp Offset: 0xfffec95693400000"

2: enable CONFIG_NVHE_EL2_DEBUG

--> "[ 684.715883][ T5525] Code: d51d991f d51d9901 d5159001 00000000 
(d4210000)

                   [ 684.715974][ T5525] kvm [5525]: Hyp Offset: 
0xfffe992b13400000"

3: without this patch :

--> "kvm [5497]: Hyp Offset: 0xfffedd4993400000"

Thanks for the clarification—really appreciate your help!

>
> Thanks,
> Mostafa


Feel free to add :

Tested-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Kunwu Chan <chentao@kylinos.cn>


-- 
Thanks,
        Kunwu Chan.


