Return-Path: <linux-kernel+bounces-728455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF8B02860
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED366582B04
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30067DA7F;
	Sat, 12 Jul 2025 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/lLPgOw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C3288D2
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280965; cv=none; b=J+BA5OwP7DjeSjlkSD+/s34YksWEcu414wqi1cLB1+CZMKJdXvwvnfm8zmfmg3d/hUUVODVeB/Vp24cxTi3VPwJqOgGDPvqbTgesE6YklKBNfWW0rZdGaZsQsSY9C49cP6Y+qiqymylm73bBSlRQFix1FxUX8Y7s/UJ2KJ03VYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280965; c=relaxed/simple;
	bh=f1j1x3DIgBTVQiIPtwdwpfxg2pEVMUXFHOuvOc0yHYc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JMcIwlF2su+9r+CHoDZcrF+hBgoe4IFW/r6TBhq1oVX7hmy6VVxl8LhvNUyLZbdWV4UdFzI2jUAX8SQCwpUAlQSI5kz8jeuKpXvm/SBxcPc9O4pAw5mKHhWhidPlFKLCd8H76qnhllAUXXACZsiy99AdE59hH7RmUT3jZjFXKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/lLPgOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752280961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEN/iZyl58nwGw0EKzAVGsowpBgVKuDX9yuLX5N4J7E=;
	b=G/lLPgOwMejo2peqU62bou5orSXOX2qAYcFBz6R1vg08v0+mvvJLBhvcIsOcyVLkib6514
	HpsqyKq6xTcyX26wHfoSrc6nzrwP0vPVBSjR7PZTAJzh5xw10P08FFBfvVEGPTuSEVAXVo
	pJZ/WCtJH8jklIHqnXyEw8pSts/7/9k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-wH56jrBcN0-QiBBILkOG9A-1; Fri, 11 Jul 2025 20:42:38 -0400
X-MC-Unique: wH56jrBcN0-QiBBILkOG9A-1
X-Mimecast-MFC-AGG-ID: wH56jrBcN0-QiBBILkOG9A_1752280958
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704b4b61d10so1954146d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280958; x=1752885758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEN/iZyl58nwGw0EKzAVGsowpBgVKuDX9yuLX5N4J7E=;
        b=FK0ZvUfokzbXcruw47ioIK3ixSaT7vjkBJ8CfLDUUZmJZERpMsPggR42t71CgDXmSu
         mZQ/Oy/7bH0CcKpWTQSvHnat+7Wn/jOCMEhuzIS8wKNRQXJuz8Sf8DL+rZkSELl0PIUq
         3oMN/3GsDVFOxr4z/xPNd7Pleyzzg3/S7wWQIxI8vmdl1pmwDPLtrwyFYslugrWpDIZo
         CnJ0oyYeuNwsOkG8NFnOKW4NilgSPJ8F+DwwQQO0brKpmb9YyIa+r0sjZTUbN7xiKya7
         vSotNIumDT5uUNDmRblwihJKuPFi7QJ/VhyLaHJ3nH/WwNclxwDSZCJIHcFHchu0oMtB
         PEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxGEF45ZK26jhXNl8aptoP2yCpHb/HF/QxaDbL2jLLKUn8dXQhiv9Xgl7OSbf1+YxlNUB27Q0pRT0f8mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcxTfh5w2FuUWbQBRKc6rm8YaMZyvpG0+wj+DFDQwXGcNDBUQm
	yOfxyp9DcTfd+gTa1+uVqMDYhzPw5gW7Z5/PV1ob6N1EKkICZXqxLpd8YyS6FvCJ46qrbiXl86d
	zUPcK5CdHjw4I8lbx0WXvU+9CvHo+qy0IQG8fixPTNSmdprOEdyuuCFqS+bPR4dD/+g==
X-Gm-Gg: ASbGnctODf/tNaN8Jt2dioB7FQ8MJyupt73GwTkh8hpDufIWUByiBiEsOXXvmUGk7no
	qrwJ794OT4zAFnjZN07GLPRq/e0wScnrZCh+i3dBkQ/gZruyANd5kKGOA4TzCPmRKeXqHtbl7X7
	uUcMUHBojwjrp2CmWiAaKd1SpDxXLespqb0kK5sszkovJClSiMtPDZrfYwp6omJAbaFlmNOVlBd
	zyVenO/1ZpmNrnjl2X7zbt31hPYDRouK/PtYisGyccaGbLszhGGps+5RJRcW8aDQlv8kN16Xl/4
	zsO7LQ2kTZVUfS4SiTvv6nyWfPFS9xTCOolvdIKC4AWdfU3aN+l25iD48qsdOFX9YonW9U4PfZw
	z4lNSzRYuew==
X-Received: by 2002:a05:620a:7012:b0:7d4:58d6:2c63 with SMTP id af79cd13be357-7de050a72cfmr747349285a.22.1752280958312;
        Fri, 11 Jul 2025 17:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtPe3xkSHeQOi/b4NmVYfRPs5A+PblGn7yo6Y+3Y2t/MY/VIyHttXj7drgJkmPKGAE5BNovw==
X-Received: by 2002:a05:620a:7012:b0:7d4:58d6:2c63 with SMTP id af79cd13be357-7de050a72cfmr747347385a.22.1752280957956;
        Fri, 11 Jul 2025 17:42:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdebea43bsm272430085a.102.2025.07.11.17.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:42:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e88452ed-411b-419e-a41d-0ff98d54a59b@redhat.com>
Date: Fri, 11 Jul 2025 20:42:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Add debug code to help catching violation
 of mutex lifetime rule
To: Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20250709193910.151497-1-longman@redhat.com>
 <aHGONjuRiA3KfH1q@tardis-2.local>
 <CAHk-=wj4gifTA94-11JXKj5Q5TSieu2LXgOauNDC9gbOQRcZeg@mail.gmail.com>
 <aHGeF7ko_4uXHUgl@tardis-2.local>
Content-Language: en-US
In-Reply-To: <aHGeF7ko_4uXHUgl@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/11/25 7:28 PM, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 03:30:05PM -0700, Linus Torvalds wrote:
>> On Fri, 11 Jul 2025 at 15:20, Boqun Feng <boqun.feng@gmail.com> wrote:
>>> Meta question: are we able to construct a case that shows this can help
>>> detect the issue?
>> Well, the thing that triggered this was hopefully fixed by
>> 8c2e52ebbe88 ("eventpoll: don't decrement ep refcount while still
>> holding the ep mutex"), but I think Jann figured that one out by code
>> inspection.
>>
>> I doubt it can be triggered in real life without something like
>> Waiman's patch, but *with* Waiman's patch, and commit 8c2e52ebbe88
>> reverted (and obviously with CONFIG_KASAN and CONFIG_DEBUG_MUTEXES
>> enabled), doing lots of concurrent epoll closes would hopefully then
>> trigger the warning.
>>
>> Of course, to then find *other* potential bugs would be the whole
>> point, and some of these kinds of bugs are definitely of the kind
>> where the race condition doesn't actually trigger in any real load,
>> because it's unlikely that real loads end up doing that kind of
>> "release all these objects concurrently".
>>
>> But it might be interesting to try that "can you even recreate the bug
>> fixed by 8c2e52ebbe88" with this. Because if that one *known* bug
>> can't be found by this, then it's obviously unlikely to help find
>> others.
>>
> Yeah, I guess I asked the question because there is no clear link from
> the bug scenario to an extra context switch, that is, even if the
> context switch didn't happen, the bug would trigger if
> __mutex_unlock_slowpath() took too long after giving the ownership to
> someone else. So my instinct was: would cond_resched() be slow enough
> ;-)
>
> But I agree it's a trivel thing to do, and I think another thing we can
> do is adding a kasan_check_byte(lock) at the end of
> __mutex_unlock_slowpath(), because conceptually the mutex should be
> valid throughout the whole __mutex_unlock_slowpath() function, i.e.
>
> 	void __mutex_unlock_slowpath(...)
> 	{
> 		...
> 		raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
> 		// <- conceptually "lock" should still be valid here.
> 		// so if anyone free the memory of the mutex, it's going
> 		// to be a problem.
> 		kasan_check_byte(lock);
> 	}
>
> I think this may also give us a good chance of finding more bugs, one of
> the reasons is that raw_spin_unlock_irqrestore_wake() has a
> preempt_enable() at last, which may trigger a context switch.
>
> Regards,
> Boqun

I think this is a good idea. We should extend that to add the check in 
rwsem as well. Will a post a patch to do that.

Cheers,
Longman

>> That said, it does seem like an obvious trivial thing to stress, which
>> is why that patch by Waiman has my suggested-by...
>>
>>            Linus


