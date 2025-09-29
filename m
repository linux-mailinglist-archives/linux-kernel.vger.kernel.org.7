Return-Path: <linux-kernel+bounces-836457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778FBA9C00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28FF7A26FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18314306485;
	Mon, 29 Sep 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX0j0bys"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34B2144CF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759158220; cv=none; b=YzgUvkePLJeca7go7jzZDkmje1QIcnKUsCx2rXd2uJqK4wfQMAXxCExd7ERz9/rePXzf2uZHfBuCMEOH922HVVPZmr/XgtSsGGGG/1NiwqnaZTFdK0EdYtYbvPZjDEgM6as4xCPZ5oBTQ2kd5uwve8A9/ft0/cENb6v2CRoaKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759158220; c=relaxed/simple;
	bh=Txljvt4Nq0aTqDJEu/ZXvtErmn62T+wSfeV8ckXdBe8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oy9YtfONYmYMJu3SEZUvYHYQsJtVcmnM4cumm3q7diS8AOdjM8uGvx2RWx5s591BZyvq2h5WhEjHQcmI9RMYjcmvnShrBVV/KHJjE3h1JTKU7ejjYJrSYsF+UodN9qAWJSUQrEyLluRCzjHBf0msZkszopEFHoaw24Cwjyqc2Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX0j0bys; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b1eac8460so33607466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759158216; x=1759763016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1XrYQjyYcqW6k1KsAQsJ4lFAw/seygwzewKvhwTUHM=;
        b=MX0j0bys+2sTRt04ax4Cv9+y88VhGGSiPiDidNJNjjci3SaJGmGJBGXUiLuN+2cv+/
         sEA6MkKd5jJexcg8wgFweiMNKgkwi0Jc3Nlo7OIUa0cw9Y8R7hvYNxmqLwA7LBx5zwdP
         M5zT+87/VSqx2Q/JQEe11mId4Rik7YkqnPVo+0KfMyIyPxAs9jLI14Z5QzcBPTv8zyky
         7qMudrMAedHjqUior0bWZiabfSO1jLK7SqdlPKK5BRrWBDD+nfbbq1wT9j9IJdXjzSpB
         mtECKRv7ATv0XLmwNta0ExKMd7JLN6fDtzUPqsfJj8VyE5IydH8qBgNZvQHKXKp7EDnQ
         G3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759158216; x=1759763016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1XrYQjyYcqW6k1KsAQsJ4lFAw/seygwzewKvhwTUHM=;
        b=Q+d7eBp0ddjTtDqM59SyXgLPg4ry7ZfxuAO3AuMRk0DJ+R+vKOgvhQD6aC6KZwZQ0x
         mL56bVI5vtKgafjGLS3cTwSJaju6Sk54rZzcqqu8D6K2VvxhV2i86zgKbRaKgACyAMI2
         gzQgDIxMu6yKdEEYlUiIYNtNJxCzqal5tkdNIpUqfgAmsqKtlO/9s9LloFgliwJWupck
         d2mnMh1l4pL9maFkr1yvUEIbKAgeDuUAEIdEkM4jh05t/AdiyJIjNPKQwT6cDSoA7zdr
         pFoYqioCJuxnRFEDnEdkNUI4+WFx2WCD8w9mmpJLlOUYHVkHiVk7T6aCUe4UnO+aNLPo
         OW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT3aUmoaBcQmeC01o1zvH6ABsKgz7t0xUCmHcp8tZ8OCguhY5uGok78JJAFyUhn+fkPOYLgG4V948nshM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlWFC8OKr0Tjc9fh/wrR+LbVaAqITnf0VDNuDPZ8DH8ckMfUI
	kIMw3/alTvSfh3K0J8SruQOGrpFSiDcNEmCaLKc+5vqFJ0HsIfx6ae5y
X-Gm-Gg: ASbGncsHsQ49Gid1wQfSd1RYOcre+ihRrM1TYGZ5WXL8XM3W+xI1dCsNJsMvd4fz08q
	cIqMXdGT2tQsvsDmoYAQI+tumOM8IEQZcSl/jfhdTbUWtQHFQPAFMHwUvsNvtLX0zf9Y3LBQnh7
	m5oJADMa73uFXwcje9vv08JauFNA0UJP6SOEJwJztU7rAmIz1AspIfeRuIvFG7JR3inwGJL7THu
	73UuZMkPhR9yfSTiFxljLwXjMbKDmrNCS5iL/0D0ScECgqx3kqu5PFvWvoz9ActnkxixYrG41pg
	fsTLJkg0w+VcUEIhTBqaYhGQ/qaoPJVqQsAHnjC+G+Fc5VWC/SDLa0Iddu0bKjUESbRUY0jARaZ
	hmXAyOvOO953g4ySIFLNtMarNNoOO2ArARO9xRlBtx9/0
X-Google-Smtp-Source: AGHT+IGB16HNv+Jp1bLAOldcBF3kwkXvbqxilb33Pzgtml+xb1qiDD8br1uCM6zm8zTtfrtEl6gFPw==
X-Received: by 2002:a17:906:c14b:b0:b07:c715:1e44 with SMTP id a640c23a62f3a-b34b8999455mr944929466b.5.1759158215348;
        Mon, 29 Sep 2025 08:03:35 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.77.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d461a411fsm309818066b.10.2025.09.29.08.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 08:03:35 -0700 (PDT)
Message-ID: <e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
Date: Mon, 29 Sep 2025 17:03:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
To: David Laight <david.laight.linux@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
 <20250926124555.009bfcd6@pumpkin>
Content-Language: en-US
In-Reply-To: <20250926124555.009bfcd6@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/25 12:45 PM, David Laight wrote:
> On Wed, 24 Sep 2025 17:23:49 +0100
> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
> 
>> -Change all the source files and the corresponding headers
>> to having matching sign comparisons.

Hi david,
sorry for the late reply.

> 'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
> The only real way is to change all the types to unsigned ones.
The last v3 did only do that with no casting as it was suggested by 
David too.

> Consider the following:
> 	int x = read(fd, buf, len);
> 	if (x < 0)
> 		return -1;
> 	if (x > sizeof (struct fubar))
> 		return -1;
> That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
> doesn't generate an error because the compiler knows 'x' isn't negative.

  Yes,-Wsign-compare does add errors with -Werror enabled in that case 
and many other cases where the code is perfectly fine which is one of 
it's drawbacks.Also I though that because of GCC/Clang heuristics 
sometimes min() suppress the warning not because that the compiler knows 
that x isn't negative.I'm probably wrong here.
> A well known compiler also rejects:
> 	unsigned char a;
> 	unsigned int b;
> 	if (b > a)
> 		return;
> because 'a' is promoted to 'signed int' before it does the check.

In my knowledge,compilers don't necessarily reject the above code by 
default. Since -Wall in GCC includes -Wsign-compare but -Wall in clang 
doesn't, doing -Wall -Werror for clang compiler won't trigger an error 
in the case above not even a warning.My changes are to make those 
comparisons produce an error since the -Werror flag is already enabled 
in the Makefile.

> So until the compilers start looking at the known domain of the value
> (not just the type) I enabling -Wsign-compare' is pretty pointless.

I agree that enabling -Wsign-compare is pretty noisy. But it does have 
some usefulness. Take for example this code:
	int n = -5;
	for (unsigned i = 0; i < n; i++) {
     	// ...
	}
Since this is valid code by the compiler, it will allow it but n here is 
promoted to an unsigned which converts -5 to being 4294967291 thus 
making the loop run more than what was desired.of course,here the 
example is much easy to follow and variables are very well set but the 
point is that these could cause issues when hidden inside a lot of macro 
code.

> As a matter of interest did you actually find any bugs?
No,I have not found any bug related to the current state of code in bpf 
selftests but It works as a prevention mechanism for future bugs.Rather 
than wait until something breaks in future code.
> 	David
> 

Thank you for your time David.I would appreciate if you suggest on how I 
can have a useful patch on this or if I should drop this.
Best Regards,
Mehdi
> 
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> As suggested by the TODO, -Wsign-compare was added to the C compilation
>> flags for the selftests/bpf/Makefile and all corresponding files in
>> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
>> carefully changed to account for correct sign comparisons either by
>> explicit casting or changing the variable type.Only local variables
>> and variables which are in limited scope have been changed in cases
>> where it doesn't break the code.Other struct variables or global ones
>> have left untouched to avoid other conflicts and opted to explicit
>> casting in this case.This change will help avoid implicit type
>> conversions and have predictable behavior.
>>
>> I have already compiled all bpf tests with no errors as well as the
>> kernel and have ran all the selftests with no obvious side effects.
>> I would like to know if it's more convinient to have all changes as
>> a single patch like here or if it needs to be divided in some way
>> and sent as a patch series.
>>
>> Best Regards,
>> Mehdi Ben Hadj Khelifa
> ...


