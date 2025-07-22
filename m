Return-Path: <linux-kernel+bounces-740018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3342B0CEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE6B546007
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF4469D;
	Tue, 22 Jul 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b="j2KfzRxI"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD681179A7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753143607; cv=none; b=FkqNdHTrj4mv1DwDZhgWwNpDpaju1/ZSyzg6d4ximdAlf76EmCJ8lOqRDvvidJ3EP565+DnddUDH5r3epCFCIf61XO404xeEfRnQbJ+I1VragS1Z6ztkxlN3XHeHowDNterLtjgItxTVqR/MYdAWaxhfC9Bh9OS23f9U9mwIcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753143607; c=relaxed/simple;
	bh=Is5FjudkVNRbrCQd3kWlqZbM8oyDKrJUpPzRT8Dgzbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGsSDui0UlDwPaOxmuvPwdRI+9xu2ca17UGDctxyAIi2zBm/v3oqZHh7rkheoJj7AZ6/O4nnvMUoWPKA+WUImt0fp6lJ9U53jENNznFjDFhPHkyqLcfccdF+FyBgOhq6Zc9kvgA45zQ2dOr6FQ8IaCg1RgMJd6VM014qpctGweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com; spf=none smtp.mailfrom=immunant.com; dkim=pass (2048-bit key) header.d=immunant-com.20230601.gappssmtp.com header.i=@immunant-com.20230601.gappssmtp.com header.b=j2KfzRxI; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=immunant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=immunant.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8d713e64c5so4545350276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immunant-com.20230601.gappssmtp.com; s=20230601; t=1753143604; x=1753748404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfkBShQYqZzNM9BpYGzZaeeLyc06cdxi5vaNJkw+Xtk=;
        b=j2KfzRxIN+tYJ25vXJpX+zAuf9m0HujuGogxqS7RDD1z2ZnyT7nh2pJ8UAUAq//WbE
         4BsO00nL23LziDXOkkCDwGSusf3a+4hg4oMekdLnZ6uk4UNQziGQFbycmsIzSbiOiW5W
         BdK3ooBeUtKD1xjwlWTb2Y5mfIIliNk+H81XaBU5PwV6TCUk5i1Ke+dN01NNer5b/w+f
         JvkCY2fSVIqPAA9AuQR4hh0NQKyxLgbW4vUpJ9O/YnDA4RWaMty9+18p9vxu4l/kVTXY
         30PrmUKZcBOsCU6oJZy+/vZ31QSECvhphNEn7fIwwzqNexWuZiUnOWpF+ymKyt46KfpT
         pQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753143604; x=1753748404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfkBShQYqZzNM9BpYGzZaeeLyc06cdxi5vaNJkw+Xtk=;
        b=AGlh2TnmwSp3yPsfYXMbL2gFSsWShUFnsVJi2FKMLePzUDbH5d0M9Rg1hFHQ7l9oeu
         cfSsHMIE4dKoT1MzFIGtpk/C0OzFzKerNXODso0iDqAuZmndRNahUNKJlGqcnEfHmMwN
         cFTgGiWf6CulDHglV78N11ImwWlE+FOrkwPtDXHKWMnevN3ujS6d2jnAI74aidQZPJC8
         mDYqidU4ni9JhWFVWt8inx9FN3iMgzXsRMQjK3V9eEs3mQFaWZTiKSPI6SdCrP1LF0+M
         YFZXkJZyj62k21WNKZcc6CT8DpTWGrLV4ntxlMZUQJ6FpOnFdcUHa76aV7pD3xEbwR1G
         JB5A==
X-Forwarded-Encrypted: i=1; AJvYcCV9U1S499XrCW93ZyP6ClHkGzmLY4GFGF/6tAjUfvCF4R4bfg02Yh5mUkmUQuHVNYI1BsYdsGpts00xVK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFceZ2O303GivikqqatO0u9tJK4R9s2tX6K3vKMCwf/+wo8/j
	4AIaUQJU4cBKycU7PtPGs1phskEAf4WIZO6nrCkfBK1ZdMSgORkyTUHnEGLIoJo+xuk=
X-Gm-Gg: ASbGncs+7KpObo5qXKLEm2QqpqcsndjHbZSHWUHc2F8NUVkZljqwEEgASgE2fsxR3Yn
	ROnA8t29uIkSj+mdTpyL/14LFg+gCoHfeQfhEtL9mbWXzgCqUh5qvIDAVeef1cn9cNv+nKh+3Cn
	NkqrghrxVhHU/d6ZUCjUtl3tn7i5v/gk/D5NyxGlaQksE3XsK6LSQizCd9ECYrC+/mCi4IXZbUO
	0vxs7YVVb+DXPWfgd4HtHfFKSZLmW1NJ/joQE5hPBiBoz9igjEmDXmuODK3wwL2SHYZJVqthYJh
	zAGNr0o4NWR5ooZIrzSfbdmr0Kfp0xGyC9/sChm8xXcBM2yitNaErgMueQtnndQjuRrjCNVhOh4
	PB6uTxXHY3tdN8ZBPXQSbtNm4PYU=
X-Google-Smtp-Source: AGHT+IF9PP9Of97pBf/TTFLrE74utZsiyNln4ZN1vWt/7rWvIC6coXHB2XHenq6hbcE9b8QXOwrztg==
X-Received: by 2002:a05:6902:1541:b0:e82:17a1:5c15 with SMTP id 3f1490d57ef6-e8d7a3559fbmr17255356276.10.1753143603631;
        Mon, 21 Jul 2025 17:20:03 -0700 (PDT)
Received: from [10.87.48.44] ([12.9.190.2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc3a41asm2889567276.16.2025.07.21.17.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 17:20:03 -0700 (PDT)
Message-ID: <dd136db0-1ac7-4f75-b550-ccf7e14c032a@immunant.com>
Date: Mon, 21 Jul 2025 17:20:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] KVM: arm64: Use SMCCC 1.2 for FF-A initialization
 and in host handler
To: =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 perlarsen@google.com, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, ahomescu@google.com, armellel@google.com,
 ayrton@google.com, qperret@google.com, sebastianene@google.com,
 qwandor@google.com
References: <20250701-virtio-msg-ffa-v7-0-995afc3d385e@google.com>
 <20250701-virtio-msg-ffa-v7-2-995afc3d385e@google.com>
 <8634bdbgaz.wl-maz@kernel.org>
 <3b10fa81-bfdd-4325-a330-c79df2e21621@immunant.com>
 <aHpOClH1k-3NhI_y@willie-the-truck>
 <67cc6766-6493-4171-a6b1-2a105c3e6ff5@immunant.com>
 <CAMP5XgeUwDnf=PbySy6aoF_zc7dtxymDQZEp8DuRSOLg4WEnFQ@mail.gmail.com>
Content-Language: en-US
From: Per Larsen <perl@immunant.com>
In-Reply-To: <CAMP5XgeUwDnf=PbySy6aoF_zc7dtxymDQZEp8DuRSOLg4WEnFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/21/25 4:01 AM, Arve Hjønnevåg wrote:
> On Fri, Jul 18, 2025 at 10:54 PM Per Larsen <perl@immunant.com> wrote:
>>
>> On 7/18/25 6:37 AM, Will Deacon wrote:
>>> On Mon, Jul 07, 2025 at 05:06:23PM -0700, Per Larsen wrote:
>>>> On 7/3/25 5:38 AM, Marc Zyngier wrote:
>>>>> On Tue, 01 Jul 2025 23:06:35 +0100,
>>>>> Per Larsen via B4 Relay <devnull+perlarsen.google.com@kernel.org> wrote:
>>>>>> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
>>>>>> index 2c199d40811efb5bfae199c4a67d8ae3d9307357..65d241ba32403d014b43cc4ef4d5bf9693813809 100644
>>>>>> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
>>>>>> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
>>>>>> @@ -71,36 +71,68 @@ static u32 hyp_ffa_version;
>>>>>>     static bool has_version_negotiated;
>>>>>>     static hyp_spinlock_t version_lock;
>>>>>> -static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
>>>>>> +static void ffa_to_smccc_error(struct arm_smccc_1_2_regs *res, u64 ffa_errno)
>>>>>>     {
>>>>>> -  *res = (struct arm_smccc_res) {
>>>>>> +  *res = (struct arm_smccc_1_2_regs) {
>>>>>>                     .a0     = FFA_ERROR,
>>>>>>                     .a2     = ffa_errno,
>>>>>>             };
>>>>>>     }
>>>>>> -static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
>>>>>> +static void ffa_to_smccc_res_prop(struct arm_smccc_1_2_regs *res, int ret, u64 prop)
>>>>>>     {
>>>>>>             if (ret == FFA_RET_SUCCESS) {
>>>>>> -          *res = (struct arm_smccc_res) { .a0 = FFA_SUCCESS,
>>>>>> -                                          .a2 = prop };
>>>>>> +          *res = (struct arm_smccc_1_2_regs) { .a0 = FFA_SUCCESS,
>>>>>> +                                                .a2 = prop };
>>>>>>             } else {
>>>>>>                     ffa_to_smccc_error(res, ret);
>>>>>>             }
>>>>>>     }
>>>>>> -static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
>>>>>> +static void ffa_to_smccc_res(struct arm_smccc_1_2_regs *res, int ret)
>>>>>>     {
>>>>>>             ffa_to_smccc_res_prop(res, ret, 0);
>>>>>>     }
>>>>>>     static void ffa_set_retval(struct kvm_cpu_context *ctxt,
>>>>>> -                     struct arm_smccc_res *res)
>>>>>> +                     struct arm_smccc_1_2_regs *res)
>>>>>>     {
>>>>>> +  DECLARE_REG(u64, func_id, ctxt, 0);
>>>>>>             cpu_reg(ctxt, 0) = res->a0;
>>>>>>             cpu_reg(ctxt, 1) = res->a1;
>>>>>>             cpu_reg(ctxt, 2) = res->a2;
>>>>>>             cpu_reg(ctxt, 3) = res->a3;
>>>>>> +  cpu_reg(ctxt, 4) = res->a4;
>>>>>> +  cpu_reg(ctxt, 5) = res->a5;
>>>>>> +  cpu_reg(ctxt, 6) = res->a6;
>>>>>> +  cpu_reg(ctxt, 7) = res->a7;
>>>>>
>>>>>    From DEN0028G 2.6:
>>>>>
>>>>> <quote>
>>>>> Registers W4-W7 must be preserved unless they contain results, as
>>>>> specified in the function definition.
>>>>> </quote>
>>>>>
>>>>> On what grounds can you blindly change these registers?
>>>>   From DEN0077A 1.2 Section 11.2: Reserved parameter convention
>>>>
>>>> <quote>
>>>> Unused parameter registers in FF-A ABIs are reserved for future use by the
>>>> Framework.
>>>>
>>>> [...]
>>>>
>>>> The caller is expected to write zeroes to these registers. The callee
>>>> ignores the values in these registers.
>>>> </quote>
>>>>
>>>> My read is that, as long as we are writing zeroes into reserved registers
>>>> (which I believe we are), we comply with DEN0026G 2.6.>
>>>
>>> Right, the specs make this far more difficult to decipher than necessary
>>> but I think SMCCC defers to the definition of the specific call being
>>> made and then FF-A is basically saying that unused argument registers
>>> are always zeroed.
>>>
>>> Rather than have the EL2 proxy treat each call differently based on the
>>> used argument registers, we can rely on EL3 doing the right thing and
>>> blindly copy everything back, which is what you've done. So I think
>>> that's ok.
>>>
>>>>>> +
>>>>>> +  /*
>>>>>> +   * DEN0028C 2.6: SMC32/HVC32 call from aarch64 must preserve x8-x30.
>>>>>> +   *
>>>>>> +   * The most straightforward approach is to look at the function ID
>>>>>> +   * sent by the caller. However, the caller could send FFA_MSG_WAIT
>>>>>> +   * which is a 32-bit interface but the reply could very well be 64-bit
>>>>>> +   * such as FFA_FN64_MSG_SEND_DIRECT_REQ or FFA_MSG_SEND_DIRECT_REQ2.
>>>>>> +   *
>>>>>> +   * Instead, we could look at the function ID in the response (a0) but
>>>>>> +   * that doesn't work either as FFA_VERSION responses put the version
>>>>>> +   * number (or error code) in w0.
>>>>>> +   *
>>>>>> +   * Set x8-x17 iff response contains 64-bit function ID in a0.
>>>>>> +   */
>>>>>> +  if (func_id != FFA_VERSION && ARM_SMCCC_IS_64(res->a0)) {
>>>>>> +          cpu_reg(ctxt, 8) = res->a8;
>>>>>> +          cpu_reg(ctxt, 9) = res->a9;
>>>>>> +          cpu_reg(ctxt, 10) = res->a10;
>>>>>> +          cpu_reg(ctxt, 11) = res->a11;
>>>>>> +          cpu_reg(ctxt, 12) = res->a12;
>>>>>> +          cpu_reg(ctxt, 13) = res->a13;
>>>>>> +          cpu_reg(ctxt, 14) = res->a14;
>>>>>> +          cpu_reg(ctxt, 15) = res->a15;
>>>>>> +          cpu_reg(ctxt, 16) = res->a16;
>>>>>> +          cpu_reg(ctxt, 17) = res->a17;
>>>>>> +  }
>>>>>>     }
>>>>>
>>>>> I don't see how that can ever work.
>>>>>
>>>>> Irrespective of how FFA_MSG_WAIT actually works (and I couldn't find
>>>>> anything in the spec that supports the above), the requester will
>>>>> fully expect its registers to be preserved based on the initial
>>>>> function type, and that alone. No ifs, no buts.
>>>>>
>>>>> If what you describe can happen (please provide a convincing example),
>>>>> then the spec is doomed.
>>>>
>>>> DEN0077A 1.2 Section 8.2 (Runtime Model for FFA_RUN) and 8.3 (Runtime Model
>>>> for Direct request ABIs) contains Figures 8.1 and 8.2. Each figure shows
>>>> transitions between states "waiting", "blocked", "running", and "preempted".
>>>> Key to my understanding is that the waiting state in Figure 8.1 and Figure
>>>> 8.2 is the exact same state. This appears to be the case per Section 4.10.
>>>>
>>>> So we have to consider the ways to get in and out of the waiting state by
>>>> joining the state machines in Figures 8.1 and 8.2. Figure 8.1 has an edge
>>>> between "running" and "waiting" caused by FFA_MSG_WAIT. Figure 8.2 has an
>>>> edge between "waiting" and "running" caused by a "Direct request ABI".
>>>>
>>>> Direct request ABIs include FFA_MSG_SEND_DIRECT_REQ2 which is why the FF-A
>>>> 1.2 spec, in my read, permits the response to a 32-bit FFA_MSG_WAIT call can
>>>> be a 64-bit FFA_MSG_SEND_DIRECT_REQ2 reply.
>>>
>>> That seems bonkers to me and I agree with Marc's assessment above. The
>>> SMCCC is crystal clear that a caller using the SM32/HVC32 calling
>>> convention can rely on x8-x30 (as well as the stack pointers) being
>>> preserved. If FF-A has a problem with that then it needs to be fixed
>>> there and not bodged in Linux.
>> Ack. Patchset v8 addresses Marc's feedback by using the func_id detect
>> SMC64 instead.>
>>> Setting that aside, I'm still not sure I follow this part of your check:
>>>
>>>        if (... && ARM_SMCCC_IS_64(res->a0))
>>>
>>> won't res->a0 contain something like FFA_SUCCESS? The FFA spec states:
>>>
>>>     FFA_SUCCESS64, is used only if any result register encodes a 64-bit
>>>     parameter.
>>>
>>> which doesn't really seem related to whether or not the initial call
>>> was using SMC32 or SMC64. What am I missing?I agree that we cannot use res->a0 to distinguish SMC32/SMC64 for the
>> reason you stated.
> 
> I don't think using the function-id of the original call works
> correctly in this context though. If you look at
> drivers/firmware/arm_ffa/driver.c:ffa_msg_send_direct_req2 it has the
> same problem as the FFA_MSG_WAIT example in your comment. In the
> simple case it will use FFA_MSG_SEND_DIRECT_REQ2 for the call and
> FFA_MSG_SEND_DIRECT_RESP2 for the response, both 64 bit opcodes, and
> either approach here will have the same correct result. However if
> FFA_MSG_SEND_DIRECT_REQ2 responds with FFA_INTERRUPT or FFA_YIELD,
> then the driver will resume the call with FFA_RUN, a 32 bit opcode,
> and still expect a 64 bit FFA_MSG_SEND_DIRECT_RESP2 response with a
> full response in x4-17. If you use ARM_SMCCC_IS_64(func_id) here
> instead of ARM_SMCCC_IS_64(res->a0), then the part of response in
> x8-x17 will be lost.
> 
> The FF-A 1.3 ALP2 fixes this by adding a 64 bit FF-A run opcode, but
> at the current patchstack only adds ff-a 1.2 support and the linux
> ff-a driver does not yet support the new 1.3 ALP2 call flow either so
> I think the current v7 patch here is the best option for now.
> 
FFA_RUN is passed through to EL3 by kvm_host_ffa_handler so I'm not sure 
there is a code path where func_id == FFA_RUN in set_ffa_retval.


