Return-Path: <linux-kernel+bounces-848556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19FBCE06D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 084B94EED5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749E1E1E16;
	Fri, 10 Oct 2025 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWC8PqnX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988313A86C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115660; cv=none; b=hAj54D2gq8k6utDkXoKLFIoS1IEYAPA4PoiqcDL/M9DCq7VLnZPQD4le4K8D2jtK9tu31T+Ud8491Cdg6ixyx09t32tJ2f2TAUu4PnSdUrR780KA58zdVpu1P1piVJ1R+NYNF+gB+auyVSYd7rJA2JfTMTWiOK+LecUA6vTQwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115660; c=relaxed/simple;
	bh=EYyHZi7lJwHBaK15OLYLE1MUoZnPM2C96io0qfOoKwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsO5N5YA7n8Gpfj1/fiVHDXzFtwzvdH4YjYXJJG20gwTAH/MydDmx+D63YZvxbkLLREF3uWbZjsN46lnLsTfxkAENZm4c68BLu3WwMhnXookb570dABZ7+sfcmyBCgabnlzUcJlXyWlScjMmkLsxVaDxFsRaYl5ITgpMlPlf2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWC8PqnX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso219424639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760115657; x=1760720457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZn78b0wyDjiwHnWB67MhXOFvbYgRHJbgZQPwFHCBKo=;
        b=IWC8PqnXSgCXickPzi2TGGW6/J/cp9w9QEv9EzPi/9BusL4AT1JY19iMkMg9rMPbr4
         hvzThRzLBrOml5jN0PfbzTiFnIt6T0almHIHHBsVvZBDv3RKMB7DrqQEP/BcQUNzAIgi
         xiOC2SU0SrXN7Zjj+p79uVPNA2lAck2kuRXns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115657; x=1760720457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZn78b0wyDjiwHnWB67MhXOFvbYgRHJbgZQPwFHCBKo=;
        b=gwTspkTKGSmFftgR4l+H92K32wSMj1GIvBD3Z7znIQ/HhqqdKgS6ncsfmfSTGZtQjq
         OGJuI4kDvdOVMGlpJkX1W6RgrCammqmUXfwOZFdSlWC7fNCMi2sckXg+kguj0+fNSy8D
         QYHHcl8yjcC7bcqJhr1mCng0sqxLi0DyX/A0ZyWzUoeU8e5lLz9ZkVVDLBWrGtRWFwvI
         V6s2xb/xOz7s3kfFdiPPSKgU9VqUEaazQVG+D38t7Hm9mdSkjAlDD9DeByRINQzetm8V
         5j8dZclGeGDj2UhSASGP9riIsqDCNgY6quXtikpTFRqwWaHdHVXQ5kmZjQl23AlyFE3o
         8f5Q==
X-Gm-Message-State: AOJu0Yzq/XMufrDm/hK2yl109MGaTzfff0BXJfAin8X01yqRN22wMElK
	EF/u6h7RCCP0j53VaUpiBgU2UvfE08xgPCksG0POqomWErNrEvb9+i0MkjUI9Eo28cM=
X-Gm-Gg: ASbGncvJX0vbtv7xasdb+0wFt0tdVXDKppHBP9YgDucJFXicsnRck5W6O0jOi3/8uBd
	SaLHL+JrsOBFQdBBzoLZZhMI4MgJOHRVi+VkSZEmq+4+ZKf3dMpYhD/U/SeL3VsDbxW9ZDLyT8t
	xytCl6a9kZC09oxkn5Sm8cGNtVA0Zctpg9vUWOsjH8omAOYhTdx9yI/Veb6LksgHfJZAOSUIf2s
	rl3vjxTr/NtKiuF+JNJUIImWOJH2mKfojXKV6kvYwZ0e5z7+ROfLrKl9XLwoyvTvRmYrmhw5iMJ
	DS9texLTRW60442x23L0VhU4sKwNcci9ZFtTy+d/XzNvb6AG/fD1MJMcvSZ6Sd/+fpz9eLHtgc4
	l1DbbZXo+ER5CeD/q9Cds0tc9WURAaIUJZH4EMWTYlNr/o4lq/Ic7uw==
X-Google-Smtp-Source: AGHT+IHPmVcN5C+66P07fmSeMZl3tP1046j5NJ9TkQM499GvnLbyfyBXHwVz+boWgvfT6iEAzYzEcQ==
X-Received: by 2002:a05:6602:1410:b0:884:1e28:904e with SMTP id ca18e2360f4ac-93bd19712b3mr1401822139f.12.1760115655891;
        Fri, 10 Oct 2025 10:00:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7200b0a4sm1016355173.38.2025.10.10.10.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:00:55 -0700 (PDT)
Message-ID: <bd60a8e5-f4df-4743-8b56-3d6127906ff2@linuxfoundation.org>
Date: Fri, 10 Oct 2025 11:00:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in
 kzalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
 <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
 <84bf5902-b3e5-4d58-a2a7-f01e15cfe143@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <84bf5902-b3e5-4d58-a2a7-f01e15cfe143@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 09:16, Mehdi Ben Hadj Khelifa wrote:
> On 10/7/25 11:23 PM, Shuah Khan wrote:
> 
>>
>> How did you find this problem and how did you test this change?

Bummer - you trimmed the code entirely from the thread. Next time
leave it in for context for the discussion.

> For the first part of your question,After simply referring to deprecated documentation[1] which states the following:

Looks you forgot to add link to the deprecated documentation[1].
It sounds like this is a potential problem without a reproducer.
These types of problems made to a critical piece of code require
substantial testing.

> 'For other calculations, please compose the use of the size_mul(), size_add(), and size_sub() helpers'
> Which is about dynamic calculations made inside of kzalloc() and kmalloc(). Specifically, the quoted part is talking about calculations which can't be simply divided into two parameters referring to the number of elements and size per element and in cases where we can't use struct_size() too.After that it was a matter of finding code where that could be the problem which is the case of the changed code.
> 
> For the second part, As per any patch,I make a copy of all dmesg warnings errors critical messages,then I compile install and boot the new kernel then check if there is any change or regression in dmesg.

This is a basic boot test which isn't sufficient in this case.

> For this particular change, since it doesn't have any selftests because it's in utility library which in my case cpu_rmap is used in the networking subsystem, I did some fault injection with a custom module to test if in case of overflow it fails safely reporting the issue in dmesg which is catched by the __alloc_frozen_pages_noprof() function in mm/page_alloc.c and also return a NULL for rmap instead of wrapping to a smaller size.

Custom module testing doesn't test this change in a wider scope
which is necessary when you are making changes such as these
without a reproducer and a way to reproduce. How do you know
this change doesn't introduce regressions?

thanks,
-- Shuah

