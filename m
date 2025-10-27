Return-Path: <linux-kernel+bounces-872039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCFBC0F2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE93480328
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8738313547;
	Mon, 27 Oct 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/+G8YxZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CE304BD3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580116; cv=none; b=FT8HZRP8jSmLiSq5f1aSVRPXEvwDrRN1xZDLgQOnje0jd6BOpUS4SD8Sd/Lk8T+vnd2Yza9K8/vrnIjWm1h/sodssu9TDzk5/z9iKzFOTLcA32ngraP4BwrynBeQgdUNkPyxYqbPed2k8b2EwurhspirDPRWA5hr6FNeOXMJT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580116; c=relaxed/simple;
	bh=l32Q+ViHVt0CnLpD8jT886v+aqGAVux0lDm8a78ktS4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FfaaoWnmPbmEX5+tp4E0e10DNjjcnZnB6Nd+4W7CMpCxGwfWm3VSwRs/5fOOmeeiKMCLVHcA3un4SMI9dV7mXuWS1mQidwGmSN7XEqbmGE3sQ219uV3P4E1NPNOhvCvZ1eiIzdn4FBBD3QE7MniHfZsJ9+BTdgxfkfnbgGtWc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/+G8YxZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761580113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NM+sK8pHWgjF7zbZgQzGUhI0C0MDr9RLoLcNYdtUY0=;
	b=F/+G8YxZAjJ/YP7ItoSLBX0gVMFPfhykBZvUUkGqRF52lkFIxdoHyVp5Vyf+3VtRl5o4Kn
	DtjxaDpGdeQfsYiKhUO26VUZg5h3PFJEtygwifs5Z1cQBRxNFh+P+VSWuKRWMwlTmd2gHB
	Xe2oBYGAXPyhIkmExeMqDNt4XjajvWo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-qiSFkDEwNJCT0Owfnfai7g-1; Mon, 27 Oct 2025 11:48:31 -0400
X-MC-Unique: qiSFkDEwNJCT0Owfnfai7g-1
X-Mimecast-MFC-AGG-ID: qiSFkDEwNJCT0Owfnfai7g_1761580111
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ecf2adbd3bso8575501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580111; x=1762184911;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NM+sK8pHWgjF7zbZgQzGUhI0C0MDr9RLoLcNYdtUY0=;
        b=nVsfmwsyERXPJJWtvce2F3e4pTaysjNftDlbn/2TVCnVX5VuW38nS+UW0kkvrPGBEc
         4YOuJzcgyxizI8tmT8owkFi469j0U6KM0y4VIRZGiYJd+lijwwN8ga6rdbhGnCOphN22
         xe5HAtXVeNv7s158/mx4Vqg2DQ4SC2zQTrPJ0MQ5AZjeRV2gqxFyNtnhAcn9gUhnNq0g
         7ozBWWv0nU8CGxxIsjcYdMtkkanoR27G97FpgZe8M6YxQ0hL5qw1mLK7RojfOa1wuk8+
         Xi4AWeq3XpvEjguBZnEE2L+MyMA8LbCZ9m7HJcby1jYmFwuAadjy6znW1J+jyZiwjLPv
         B/9A==
X-Forwarded-Encrypted: i=1; AJvYcCXCwURdgOk+LA6tPf/xwqeQl706oSzamHjnITA24Upf4MM6beNBGhIGo3Ij+DVdoN1aWL5O+EgLTomj4NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWH8Z+QmD0g9N1fr5lpyoqfG/KieJ2Op54GPdQTsnLKXGAQJs
	2b/+7czJylBOqO5mb2k4tdRXQCNv1dVFU7zJS6vrTlj7L6CxSGCT3XNjZxDdcReXdqhTXHEZl6H
	AgVtCtcFjQEaC3lmIcH7aF7XQkzIEAg9Me/KO/YduAugeDIkfrn4QbvFwvq45yvzoMQ==
X-Gm-Gg: ASbGnctPqQDLEyCv7uIk62jOL8WD016OE6HgjlcYcEjJKc4pm6okNmQRxetav/uLfYG
	GSQ00R1y50LWIqhNAGd4wYAWRmtsy+7icNw8br/LdY0QQboMWcUq4ilCbhwKYozFtVwudQqdwqr
	6yKL2HxLkR9KXyEGxB+1Cl5TdLGGemVfXTN5d8IyQjzEzn5PkWW5UHzm50DXFFNY9XxdBoQBYW4
	OaGxnf0lib5CpNJM7oKk9UvucjkYVqjd67tu7VnHN6n/I0SnrOvoEbRz8Nfnx2F73dwMhL0BNOP
	YUH4yPOfIg8F055uhLzYqD7ZWO1fND7BcQbmEqaFkspfNbQvwi5axwuCOJSnKiUQCzbkUBvVEro
	qOedBmL3Bp793pooyK9Cn0a5PQZCyx3oOLSYW4H8KIWoYBA==
X-Received: by 2002:a05:622a:1350:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed07546a0amr5094161cf.34.1761580110786;
        Mon, 27 Oct 2025 08:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK35+20Rhg4dVp30yWQ9wI0KCKkP5ZsLL+5MDIkbSzrQdWjPPT62US5+KZQ8oEE9VvBV2n3w==
X-Received: by 2002:a05:622a:1350:b0:4e8:9ade:108c with SMTP id d75a77b69052e-4ed07546a0amr5093561cf.34.1761580109885;
        Mon, 27 Oct 2025 08:48:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48dee2esm58031186d6.23.2025.10.27.08.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:48:29 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4be37a6a-0a04-48f8-9399-25ecb4638cdc@redhat.com>
Date: Mon, 27 Oct 2025 11:48:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/smpboot: Question regarding native_play_dead() __noreturn
 warning
To: Peter Zijlstra <peterz@infradead.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <47A8B84B-2685-4DA2-B39B-E55812374426@linux.dev>
 <20251027125045.GX4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20251027125045.GX4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 8:50 AM, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 01:23:02PM +0100, Thorsten Blum wrote:
>> Hi,
>>
>> I just came across this comment in arch/x86/kernel/smpboot.c:
>>
>> /*
>> * native_play_dead() is essentially a __noreturn function, but it can't
>> * be marked as such as the compiler may complain about it.
>> */
>> void native_play_dead(void) {
>> 	...
>> }
>>
>> and when I mark native_play_dead() as __noreturn, neither gcc nor clang
>> complain about it.
>>
>> The commit message 2743fe89d4d4 ("x86/idle: Disable IBRS when CPU is
>> offline to improve single-threaded performance") says:
>>
>> "Add a comment to say that native_play_dead() is a __noreturn function,
>> but it can't be marked as such to avoid confusion about the missing
>> MSR restoration code."
>>
>> Unfortunately, that doesn't really help me either. Can someone explain
>> what the issue was and if the comment is still valid? Otherwise, I'd
>> like to submit a patch adding __noreturn and removing the comment.
> I'm not sure either, it wasn't there in v2 but appeared in v3.
>
> v2: 20230620140625.1001886-3-longman@redhat.com
> v3: 20230622003603.1188364-2-longman@redhat.com
>
> The difference is that v2 tried to restore the msr after 'play_dead'
> which is silly, since it would never reach that code. v3 removed that
> dead restore code and added the confusing comment.
>
> There is a clue here though:
>
>    20230622054053.uy577qezu5a65buc@treble
>
> Josh suggests play_dead() should be marked noreturn (which it is in
> current kernels).
>
> Waiman then replies:
>
>    921e1b98-af36-1f51-5abe-dea36425b706@redhat.com
>
> which is utterly confused again.

I don't remember exactly how I got the warning when __noreturn is added 
to native_play_dead(). It may be a limitation of the objtool or gcc that 
I was using at that time. If Thorsten doesn't have problem adding 
__noreturn, I won't mind him doing that and taking out the the comment. 
We can see if there is other issue coming up in the future.

Cheers,
Longman


