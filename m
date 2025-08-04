Return-Path: <linux-kernel+bounces-755488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1178B1A6ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203BF7A13A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E57A21883F;
	Mon,  4 Aug 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFeNpLQB"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2C262FE5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323218; cv=none; b=WJKVb/J07NLM6LmT0UyADLK5Y/DdAVsB9aUBshy6yz0djzkYZ3yNUNQZOe/unvIfo4JpYk9pkNbFGKZ872JzEO7tQn4Vh4qubTyeCaSavTni+a0uLipErob+8Yx+HkPVOs3ieQSlr2FOajB9kAoBH+XmKTFey2LYFj4dlA6o5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323218; c=relaxed/simple;
	bh=sO30oNJNat2gEn/DA4kZKK55EVzR2yM7U8PKO9ntHlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZbvLLmE35bDumicgroWoytngLKvZZnnMtnQY3OxIBz954Q15zSUTn8i0+olqtuuICC/v6M6nSlIGd02pYNZfLPflWNHIe3+IYHD72U0cPFmRbUwFOQRjH6tqaUDa0SG89fR+HI8sojvX0TYrEyn1N+zE5yY6VxhBZlT07SG8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFeNpLQB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78a034f17so3064288f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754323215; x=1754928015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83y9HCM1NErNHhoDJvLNstKn3l9elWApgqOnhqoLDjY=;
        b=CFeNpLQBfQy/dHPdDA+f04e7ncarAxq2rRPp/w8gqPMiZqYLzovam0CFUYVSavmMMm
         7RdVNhM1eD0/f5x6MymYgCyPVGAKpUGH6poEhckfFreY3VvP0nHaw/lHX/Ny7RY6OfFu
         K4C9h/B4qrWmval+pY372oHX+vWoBbnFFCynriEJwmUq8oDcb/LPwrj/sfAkskJL73Yc
         NZsIcoI0ZlOW55HNfnkth+J61Xh/ejeOdcpEGzl9zIhj9X0vhKQmx5LTERE7gtmBNiZ3
         +gdsz2xNi5+OOZu/TyxoU96rZfWrZxe/F5Jloki1IBCXxps9KhWFd+sA2sGX//NFTpCp
         vMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323215; x=1754928015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83y9HCM1NErNHhoDJvLNstKn3l9elWApgqOnhqoLDjY=;
        b=D9FKe3X7i+D8MtCbjbHZmKrtIIAs4p5wf8eHrmpTYfY/ZD9uIoXg+G7zw9X82xiw+D
         LOidK0YvxdYjGX7/rG2F7ly6kUHG/s3vyoZ1C4iYc8Yyl3SliGw0Ty4ESBETc0nn1Ojk
         VzFrTNKoScSuztOmwqDZcToISFnc4NjlxBsa7QKcIPijco3SELAK/p00+Pp0JBoRyUno
         FJqQmJ4B4s9PohlMAz7i8qInd/pqIgrMd/T2qDIIDUIGVBU6BBMDht0WUl6oo0MOBHzV
         IN2DMAYoQAZQkRvxfTNCBElIQ8s24UxSeDUoKUvalhoWCnXKsyd8RhX2VcwVTSIOh2ci
         gAsg==
X-Forwarded-Encrypted: i=1; AJvYcCX88jMzKFM1BzdLGaim6EFkNn1Ib1fgKcopR+yteuUuBH274KbQiAJ6/3CryLSlVzDLBQ9BlR3Yi9Yehvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEKCfEb4IzClaoR/c3DjAeL/WYKaJtVxYx4N0nhnCocIXVV2Uk
	pv2RAdLQJRaM5cTVhOLqPp+MswhJu7lxgooy6TMvhldZ2o3UpjOL0wCy71K25AcQj0k=
X-Gm-Gg: ASbGncsnHWYCAQzxdEUnV+0deQihL+Hfc4Hr9R1PQEu+0ViZk8ih6WWDptE7/NtXeY7
	oTGxZULvNmqO6+0E1K3eyUwfgkhc5KRJ+f9oFxr+V9GGwhYoVkIhcdmETh4R1Vh4dDtJV8ae0dG
	TABujyfYQBvtEqJ+htSdGkin0DMFAL8yaoM85+MjuSLV7JjYbAkyxR0Oqb7U+WaHGn0g+G+1C/y
	LMrcFANJz4Rm5wSzFFDbP9qOuijHcI8FK4uCK0OuDa+Rkkdzl0JtYn5+nxivnqvHUgOF+wfIvkx
	1DspMox/LQFK1tv/fkoir2/btma/XfJoSw1L01xExY9H+saeiEjZI4Uj0ELAdTn3KE7tfMI0zt0
	myI5hyTBDvynNgVhNpx5bTygY849zvVLUelq14w==
X-Google-Smtp-Source: AGHT+IEauvx9FJ2JC6u71NHBH4w0cTSo3NvU8GY9XFshSKS1MeESuBlXTRuD0jWRGjF7fGT+6taYMQ==
X-Received: by 2002:a05:6000:188f:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b8d946afacmr6958510f8f.6.1754323214722;
        Mon, 04 Aug 2025 09:00:14 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm1848019f8f.19.2025.08.04.09.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 09:00:14 -0700 (PDT)
Message-ID: <a492ccbf-6442-44dc-82c8-d2c8b1d5c56b@linaro.org>
Date: Mon, 4 Aug 2025 17:00:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf: arm_spe: Add support for SPE VM interface
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <aIzA632hiAldjJQQ@raptor>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aIzA632hiAldjJQQ@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2025 2:28 pm, Alexandru Elisei wrote:
> Hi,
> 
> On Tue, Jul 01, 2025 at 04:31:56PM +0100, James Clark wrote:
>> SPE can be used from within a guest as long as the driver adheres to the
>> new VM interface spec [1]. Because the driver should behave correctly
>> whether it's running in a guest or not, the first patches are marked as
>> a fix. Furthermore, in future versions of the architecture the PE will
>> be allowed to behave in the same way.
>>
>> The last patch adds new behavior to make it easier for guests to be
>> able to reserve large buffers. It's not strictly necessary, so it's not
>> marked as a fix.
> 
> I had a look at the patches, and they all look ok to me, so for the series:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> I also tested the series by hacking SPE virtualization support in KVM:
> 
> - without these changes, the SPE driver gets into an infinite loop because it
>    clears PMBSR_EL1.S before clearing PMBLIMITR_EL.E, and the hypervisor is
>    allowed to ignore the write to PMBSR_EL1.
> 
> - with these changes, that doesn't happen.
> 
> - ran perf for about a day in a loop in a virtual machine and didn't notice
>    anything out of the ordinary.
> 
> - ran perf for about a day in a loop on baremetal and similary everything looked
>    alright.
> 
> - checked that the SPE driver correctly decodes the maximum buffer size for
>    sizes 4M, 2M (2M is right at the boundary between the two encoding schemes)
>    and 1M; that's also correctly reflected in
>    /sys/devices/platform/<spe>/arm_spe_0/caps/max_buffer_size.
> 
> - checked that perf is not allowed to use a buffer larger than the maximum.
> 
> - checked that the SPE driver correctly detects a buffer size management event.
> 
> So:
> 
> Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> While testing I noticed two things:
> 
> 1. When perf tries to use a buffer larger than the maximum, the error is EINVAL
> (22):
> 
> # cat /sys/devices/platform/spe/arm_spe_0/caps/max_buff_size
> 4194304
> # perf record -ae arm_spe// -m,16M -- sleep 10
> failed to mmap with 22 (Invalid argument)
> 
> (used 16M as the buffer size because what the driver ends up programming is half
> that).
> 
> I would have expected to get back ENOMEM (12), that seems less ambiguous to me.
> I had to hack the driver to print an error message to dmesg when the max buffer
> size is exceed to make sure that's why I was seeing the error message in perf,
> and it wasn't because of something else. I get that that's because .setup_aux()
> can only return NULL on error, but feels like there's room for improvement here.
> 

We could add an error code, rb_alloc_aux() already returns one and that 
calls setup_aux(). But the scenarios would be either EINVAL or ENOMEM 
and wouldn't give the user the exact reason ("need > 2 pages", "need 
even number of pages", etc). So I'm not sure it would be enough of an 
improvement over returning NULL to be worth it.

However I will add a warning into Perf if the user asks for more than 
caps/max_buffer_size. That would be a useful message and Perf can do it 
itself so it doesn't need to be in the driver changes.

> 2. A hypervisor is allowed to inject a buffer size event even though the buffer
> set by the guest is smaller than the maximum advertised. For example, this can
> happen if there isn't enough memory to pin the buffer, or if the limit on pinned
> memory is exceeded in the hypervisor (implementation specific behaviour, not
> mandated in DEN0154, of course).
> 
> In this situation, when the SPE driver gets a buffer size management event
> injected by the hypervisor, there is no way for the driver to communicate it to
> the perf instance, and the profiled process continues executing even though
> profiling has stopped.
> 
> That's not different from what happens today with buffer management events, but
> unlike the other events, which aren't under the control of userspace, the buffer
> size event is potentially recoverable if userspace restarts perf with a smaller
> buffer.
> 
> Do you think there's something that can be done to improve this situation?
> 
> Thanks,
> Alex
> 

It doesn't look like there's currently anything that can stop an event 
or signal to Perf that the event has gone bad.

We could add something like "__u32 error" to struct 
perf_event_mmap_page. But I'm not sure what you'd do with it. If Perf is 
the parent of the process you wouldn't want to kill it in case anything 
bad happens. So you're left with leaving it running anyway. If it's just 
an error message that you want then there's already one in dmesg for 
buffer management errors, and that string is a lot better than a single 
code. Unless these new codes were detailed PMU specific ones? Actually 
it's a whole page so why not make it a string...

It's not a case of the samples ending randomly somewhere though, you'll 
either get all of them or none of them. So it will be quite obvious to 
the user that something has gone wrong. Secondly I think the scenario of 
not being able to pin memory when asking for less than the limit would 
be very rare. It's probably fine to leave it like this for now and we 
can always add something later, maybe if people start to run into it for 
real.

James



