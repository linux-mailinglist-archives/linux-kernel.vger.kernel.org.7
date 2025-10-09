Return-Path: <linux-kernel+bounces-846952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E89BC9812
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45AE64E3E39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC852EA75E;
	Thu,  9 Oct 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ra/Uwyv4"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D72EA735
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020153; cv=none; b=CuqHsswQF/7HTg88jZtQXxXE7tw9Hm6CqVNcUJeAKmyiQk7NY28h/hhJ2A0KIfkh0TjpCN71le8SNPeK4CWvf14ELy8HhppNDh1e9d7E/4ZG+H1fFn9QJNSxMVjIt2N+dgvwGzFXEU8si96ceh6nZcLn9Fez9Th3akFO6DXKLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020153; c=relaxed/simple;
	bh=BCl1ontoWZnnzdVPnVVb0Y2fD9gL1hxYXO2q7XDxO3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjKB5M4owBJARCkDFveLgS02bPqe/FJJrQL+aCKnsrv5V/3xAc5mJ7FGlo0LM3dP0WOlcgxmKgaV61ihQ2dGnkdCFx5mb68xheJUX88YllQ6mQ/cg3UJSk3+/ZNTTidwHe8jaGphfvAyEnwRTNeNovzadc7EJvpKNtE3gJLjHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ra/Uwyv4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-794e300e20dso847063b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760020151; x=1760624951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO39l+3H/cimVJEwYeBUO5A8m+o/iSXMsMF0/1QnCj0=;
        b=Ra/Uwyv4cUTafbyyzn/KpLS+qYqiDiLzHqv7EFFkz6dIExTbNS4+VnnXXTn/PMJL+I
         3XVO3IqHhUu7tEahiPtgtBu8vxA0hc/vU8ciElsIIB+H5TM7o6bJTDFYOfpVWOOcRtXO
         QKhWuOQm6DjTm2fkJ01g+YxWxshNphI8JITH4QQ0UWjQamU1ogR+Z+21urh7UMcMfTlh
         K6L92oEAYzMJA+er2VhhO5XasDr9dufyk6eCG+N34s9r1boNBYJK1JXMWzw+ncjI+PyW
         7SERWEoyE6vfZSyK+kUm/9e+Kjh6gCv6cq3BESmNdB/sI3YpkkdSjZMfiBNzrnlyoMfG
         6FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020151; x=1760624951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO39l+3H/cimVJEwYeBUO5A8m+o/iSXMsMF0/1QnCj0=;
        b=ljWSgfdNlv7db0vUeMzByma65hG602vEbj4LHOaxp8o3SqJ4NGmpCVecvxgsFMXP0C
         rtypdRf69+WWpFeaETYJHFQa8ueSPoCU6RaFF6ZX8MG0c40XOSboAVRXrXcpar5nUNzR
         Hl+fzOEBExeYJRtUfG6wq4dLvrDfooPTghmpsxhA2ndSgYcuUmy55eWl0Hyq0q+QF09t
         0II0X/hTsgh1fPEqQatrFWkSGuF0nHvEWMmZVIRG1Ks+cvxtXzv/pk836b5A4ueRJT4C
         lS0MjIlQ+ySq9ogZrfwjK2e75lUxtzBM/h8DKCF0tEY+23QOCNLE8V7v3aZUgExlpU+b
         HWfA==
X-Forwarded-Encrypted: i=1; AJvYcCXD5m3UHv7kBuoFuW6qvxCe9cR1w1ICCHb5CHRPIoMw92erLWd+9d7tDCJ2I2qV0kkO7NUYk9TO4zn7DpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+DE/6EkNqYDihmw1ZGmCultqXKwKC5PqIVv3tiTzLA0LVokK
	OD+wkALvq1iCPhrABB00BQwwnqDI3zPnXbMkO2lmQ1BHzP1oM811w5SS
X-Gm-Gg: ASbGncsFO/VYqJ/FIEu8WBHDFYVWYJ4CYOSbFUZ3BPbDrcMh6tqkz9MEOL4dB1l9A2c
	UzcYrAekJfaHcLqDAa/BskOdCKKsAlA36cvIsuujaBmbocsB1Ft/aCLEWmlriZwep9zCN0XH+Ta
	tP+2PmAclV25IWlc/OzsMq1LEbeV0ru9A69mzFbjzF7j9V/3I5N23Fk08ZeKj1O6DviHjYVpzIh
	gt3pRA4vQ0KQWZDNDKmiKzezZCvH7Nai0KPd+nG4lelGadtxz167/LC7gRnJ5iPI4/w43RhCgYF
	Z2Q1Jihrc3Rz8L8Kxxww4PX4iq0E5EA45oGoqwzEVjtDWnXRokghcQ95LHR/P/aSCwh8ea7iPez
	YZFoc8hhdM5LK+YnKVsEifPTs/OQ+PD/vsKOuS86UQ5ai2ra9XxkhwAk8S9Jx/a8nAXy8Vw==
X-Google-Smtp-Source: AGHT+IH6tdsz1JSStBaDScTgcTNwiAhssqlTJekTpERVbhels1+0vllNevg6v5ObumZOOtNmm8jVFg==
X-Received: by 2002:a05:6a21:3383:b0:2b5:9c2:c584 with SMTP id adf61e73a8af0-32d96ec1209mr16308533637.26.1760020150365;
        Thu, 09 Oct 2025 07:29:10 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm18778647a12.18.2025.10.09.07.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:29:09 -0700 (PDT)
Message-ID: <5766a834-3b21-47b0-8793-2673c25ab6b0@gmail.com>
Date: Thu, 9 Oct 2025 22:29:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/10/9 04:08, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Oct 2025 at 21:34, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Wed, 2025-10-08 at 19:08 +0200, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Wed, Oct 8, 2025 at 7:41 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2025/10/7 14:14, Menglong Dong wrote:
>>>>>> On 2025/10/2 10:03, Alexei Starovoitov wrote:
>>>>>>> On Fri, Sep 26, 2025 at 11:12 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Introduce the function bpf_prog_report_probe_violation(), which is used
>>>>>>>> to report the memory probe fault to the user by the BPF stderr.
>>>>>>>>
>>>>>>>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
>>>>>
>>>>> [...]
>>>>>
>>>>>>>
>>>>>>> Interesting idea, but the above message is not helpful.
>>>>>>> Users cannot decipher a fault_ip within a bpf prog.
>>>>>>> It's just a random number.
>>>>>>
>>>>>> Yeah, I have noticed this too. What useful is the
>>>>>> bpf_stream_dump_stack(), which will print the code
>>>>>> line that trigger the fault.
>>>>>>
>>>>>>> But stepping back... just faults are common in tracing.
>>>>>>> If we start printing them we will just fill the stream to the max,
>>>>>>> but users won't know that the message is there, since no one
>>>>>>
>>>>>> You are right, we definitely can't output this message
>>>>>> to STDERR directly. We can add an extra flag for it, as you
>>>>>> said below.
>>>>>>
>>>>>> Or, maybe we can introduce a enum stream_type, and
>>>>>> the users can subscribe what kind of messages they
>>>>>> want to receive.
>>>>>>
>>>>>>> expects it. arena and lock errors are rare and arena faults
>>>>>>> were specifically requested by folks who develop progs that use arena.
>>>>>>> This one is different. These faults have been around for a long time
>>>>>>> and I don't recall people asking for more verbosity.
>>>>>>> We can add them with an extra flag specified at prog load time,
>>>>>>> but even then. Doesn't feel that useful.
>>>>>>
>>>>>> Generally speaking, users can do invalid checking before
>>>>>> they do the memory reading, such as NULL checking. And
>>>>>> the pointer in function arguments that we hook is initialized
>>>>>> in most case. So the fault is someting that can be prevented.
>>>>>>
>>>>>> I have a BPF tools which is writed for 4.X kernel and kprobe
>>>>>> based BPF is used. Now I'm planing to migrate it to 6.X kernel
>>>>>> and replace bpf_probe_read_kernel() with bpf_core_cast() to
>>>>>> obtain better performance. Then I find that I can't check if the
>>>>>> memory reading is success, which can lead to potential risk.
>>>>>> So my tool will be happy to get such fault event :)
>>>>>>
>>>>>> Leon suggested to add a global errno for each BPF programs,
>>>>>> and I haven't dig deeply on this idea yet.
>>>>>>
>>>>>
>>>>> Yeah, as we discussed, a global errno would be a much more lightweight
>>>>> approach for handling such faults.
>>>>>
>>>>> The idea would look like this:
>>>>>
>>>>> DEFINE_PER_CPU(int, bpf_errno);
>>>>>
>>>>> __bpf_kfunc void bpf_errno_clear(void);
>>>>> __bpf_kfunc void bpf_errno_set(int errno);
>>>>> __bpf_kfunc int bpf_errno_get(void);
>>>>>
>>>>> When a fault occurs, the kernel can simply call
>>>>> 'bpf_errno_set(-EFAULT);'.
>>>>>
>>>>> If users want to detect whether a fault happened, they can do:
>>>>>
>>>>> bpf_errno_clear();
>>>>> header = READ_ONCE(skb->network_header);
>>>>> if (header == 0 && bpf_errno_get() == -EFAULT)
>>>>>         /* handle fault */;
>>>>>
>>>>> This way, users can identify faults immediately and handle them gracefully.
>>>>>
>>>>> Furthermore, these kfuncs can be inlined by the verifier, so there would
>>>>> be no runtime function call overhead.
>>>>
>>>> Interesting idea, but errno as-is doesn't quite fit,
>>>> since we only have 2 (or 3 ?) cases without explicit error return:
>>>> probe_read_kernel above, arena read, arena write.
>>>> I guess we can add may_goto to this set as well.
>>>> But in all these cases we'll struggle to find an appropriate errno code,
>>>> so it probably should be a custom enum and not called "errno".
>>>
>>> Yeah, agreed that this would be useful, particularly in this case. I'm
>>> wondering how we'll end up implementing this.
>>> Sounds like it needs to be tied to the program's invocation, so it
>>> cannot be per-cpu per-program, since they nest. Most likely should be
>>> backed by run_ctx, but that is unavailable in all program types. Next
>>> best thing that comes to mind is reserving some space in the stack
>>> frame at a known offset in each subprog that invokes this helper, and
>>> use that to signal (by finding the program's bp and writing to the
>>> stack), the downside being it likely becomes yet-another arch-specific
>>> thing. Any other better ideas?
>>
>> Another option is to lower probe_read to a BPF_PROBE_MEM instruction
>> and generate a special kind of exception handler, that would set r0 to
>> -EFAULT. (We don't do this already, right? Don't see anything like that
>> in verifier.c or x86/../bpf_jit_comp.c).
>>
>> This would avoid any user-visible changes and address performance
>> concern. Not so convenient for a chain of dereferences a->b->c->d,
>> though.
> 
> Since we're piling on ideas, one of the other things that I think
> could be useful in general (and maybe should be done orthogonally to
> bpf_errno)
> is making some empty nop function and making it not traceable reliably
> across arches and invoke it in the bpf exception handler.

No new traceable function is needed, since ex_handler_bpf itself can
already be traced via fentry.

If users really want to detect whether a fault occurred, they could
attach a program to ex_handler_bpf and record fault events into a map.
However, this approach would be too heavyweight just to check for a
simple fault condition.

Thanks,
Leon

> Then if we expose prog_stream_dump_stack() as a kfunc (should be
> trivial), the user can write anything to stderr that is relevant to
> get more information on the fault.
> 
> It is then up to the user to decide the rate of messages for such
> faults etc. and get more information if needed.


