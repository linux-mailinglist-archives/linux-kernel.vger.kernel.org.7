Return-Path: <linux-kernel+bounces-770756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ECFB27E93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1781D06199
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F182FD7D6;
	Fri, 15 Aug 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lF2Jxu1v"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD42FD1B7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254596; cv=none; b=uNM98pGzrE8UeoNo2vJD2NXh5yliPpe1J56WBShaGM7i5bF1hyHNhjmewxsyozf1jY18b0RgQXfB+bqtpyBqNzedzVDicFXzPfeTzcyej9mGHmWV/deT61qC8u1w9PWvXxk+jFcOvFwUrb+ZLcUY509e4twrejZ0Dx0/LrtHvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254596; c=relaxed/simple;
	bh=aHgRVOVEEbUpUYfTqQ3JTY79i86lBVa8+boitQShH9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf/+BlGo95+Y4VoiX/wPbjXgw5zbHbOJwMsvGYopU1KDd264l+GbXTxLR6uyGPeom1fPB5n4n5XyRkq/nSvaa7OwbBpV2nnVOoB2rWLYE77UwFjzp6pC682AMjgfysCgqqS8yLi9le4oTer0eWwcGFZEz5LSejhBc1xPs6bvXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lF2Jxu1v; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e41669d6so1473900f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755254593; x=1755859393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aHgRVOVEEbUpUYfTqQ3JTY79i86lBVa8+boitQShH9M=;
        b=lF2Jxu1vIudVresoKuzEKLfNCqo28xntve+b4Hy9noTrppZBqszbReKryf3WPeKb7x
         7l0TSCl+81vneSDmGTSK+RW7pCFtWl3CfcL9R0aeMVW5LEOHkRpMxvpKMGo+0AgnsUOJ
         aPIspcIDF1rmrXwWXrVdJ/RkMjoXPFo1Loal4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254593; x=1755859393;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHgRVOVEEbUpUYfTqQ3JTY79i86lBVa8+boitQShH9M=;
        b=lDZjtd4VFZMv+RnphIentks9hj9YRblaV2rkffOQCmiBrpWur5fOQcNSkIt9J+PQh2
         ednFLSI8R9jTIpDjyLWs/QBVepBHMdxShqOEPKFUFYUXmqOSerpW5GFAu/9MWewekxx9
         ycR3SEqUuW1kclRNrhOpll/fQ52+5WHA6ImHifD07gzULCDt+JHfpkWmExsI4BLJit1V
         H8BASK4nOi+N88gtZI1t7j5ZtjusWx8F0+OM8y52k8BAkiOCu39/Ug5smZ9eY40IC6Uc
         b8/kGPhb9hmDUyr+jPYN1dnMePlmFcXt69CeaaNQY3g17sS8lWRy9xXo/AHhFz2MO7Aw
         nhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRQ/gF5YxBUk2hiOS8XVeztoRx3oLgUm6DkN7B0IfJnyKp6z/7Ix3RvSy7O1AbWtlcB+FPQjhI966nxOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArWXLBCRgbBBAROjDkIJ4FoyN9AHJ3mNev99F9brq9vp6BcP+
	NlnSyUW66qNWDsUat8KFBu+sq12v1YYcHDhSHR4d8rRZ985G9Fu6E9U61URCUfi/+sk=
X-Gm-Gg: ASbGncsUaeaIBk5EX8K4vIC1mfFigo0Ml3RS24h2NF7eNso18+aSUoVb7swkQCTQCw1
	gEwcDOjlug9k6DAD+4Hd2i84mrbLcVZ3b4PAvkTxg6L/hi3dkKVRPlir1is/+nqnpldQTxJOHhC
	3t1oRV69LHstjBiO6+w37P+syz+wFbi5Y9e2G5Uz1q38UegMnBy0lUpgUfkfj0qkeYegpPpzLbp
	nMT+VB83TINpG6A8Ilvz0jXhrGissqJeuTdVbFRNtvF9Eq88cQsjtSPaMpOdpXT72GGVxGWKugP
	pIScK3H4FFBIQuw8R64/0qmdhA9lEQHyW3Dfpk73fJIDi5dqfwebBPOCCbKzpxe3oHFyWSlWEQq
	iH8OrXn4htMYM1iDVwjaz3zYCvL+gpBJuAG2eJPy2nZjYFCml9/YNYFFU6y4QjLwIfxM+
X-Google-Smtp-Source: AGHT+IHS9AQzYKV+kqPLxVPHc/Rr8eCsKdGC3CZteNUXsvtjAEbagpVpAhD5+Ouufuk51mmw4c+jjg==
X-Received: by 2002:a05:6000:2404:b0:3b9:14f2:7ed7 with SMTP id ffacd0b85a97d-3bb66e16fd6mr1137992f8f.15.1755254592548;
        Fri, 15 Aug 2025 03:43:12 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758d1csm1528562f8f.8.2025.08.15.03.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 03:43:12 -0700 (PDT)
Message-ID: <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>
Date: Fri, 15 Aug 2025 11:43:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 samitolvanen@google.com, nathan@kernel.org, alexei.starovoitov@gmail.com,
 mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
 <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/08/2025 11:30 am, Peter Zijlstra wrote:
> On Fri, Aug 15, 2025 at 12:28:39PM +0200, Peter Zijlstra wrote:
>> On Fri, Aug 15, 2025 at 09:49:39AM +0200, Peter Zijlstra wrote:
>>> On Thu, Aug 14, 2025 at 06:27:44PM -0700, H. Peter Anvin wrote:
>>>> On 2025-08-14 04:17, Peter Zijlstra wrote:
>>>>> Hi!
>>>>>
>>>>> A while ago FineIBT started using the instruction 0xEA to generate #UD.
>>>>> All existing parts will generate #UD in 64bit mode on that instruction.
>>>>>
>>>>> However; Intel/AMD have not blessed using this instruction, it is on
>>>>> their 'reserved' list for future use.
>>>>>
>>>>> Peter Anvin worked the committees and got use of 0xD6 blessed, and it
>>>>> will be called UDB (per the next SDM or so).
>>>>>
>>>>> Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
>>>>> had to switch the hash register to EAX in order to free up some bytes.
>>>>>
>>>>> Per the x86_64 ABI, EAX is used to pass the number of vector registers
>>>>> for varargs -- something that should not happen in the kernel. More so,
>>>>> we build with -mskip-rax-setup, which should leave EAX completely unused
>>>>> in the calling convention.
>>>>>
>>>>> The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
>>>>> combinations (non exhaustive so far).
>>>>>
>>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Looks good to me (and using %eax will save one byte per call site as
>>>> well), but as per our IRC discussion, *my understanding* is that the
>>>> best possible performance (least branch predictor impact across
>>>> implementations) is to use a forward branch with a 2E prefix (jcc,pn in
>>>> GAS syntax) rather than a reverse branch, if space allows.
>>> Oh right. I did see that comment on IRC and them promptly forgot about
>>> it again :/ I'll have a poke. Scott, do you agree? You being responsible
>>> for the backward jump and such.
>> On top of the other, to show the delta.
>>
>> If we want a fwd branch, we can stick the D6 in the endbr poison nop.
>> That frees up more bytes again, but also that matches what I already did
>> for the bhi1 case, so less special cases is more better.
>>
>> I've had to use cs prefixed jcc.d32, because our older toolchains don't
>> like the ,pn notation.
> And then I forgot to move that cs prefix around in the bhi1 case...
> fixed that.

Dare I ask what ,pn notation is?  It's not only the older toolchains
that don't know it :)

~Andrew


