Return-Path: <linux-kernel+bounces-723812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F9AAFEB4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116AC547BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D92E7BBF;
	Wed,  9 Jul 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1firUzt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4D2E5B2C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069470; cv=none; b=nRO4Q/ldLWBlcQooIxFCj/C5nqBzdZeFzNVSXwptZKNdGezubpi3BGCyypamBbAFnt/D+kE5DKnmkbztk8gPO15PpTs1pOPg4OKoJdaqJr11syEt4lWlpLgAz1AutU8fKRkq3oJ2LTtmkXTxVASFEwc/ch0PZjZj7jxCXPIldDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069470; c=relaxed/simple;
	bh=aciBxMorgcnxml2dz0hEXnAFfDQ4Hq6ZDMSr0RlpZOc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UT4QX2hWig2LfUCd19r0dM3SYkhIxCXhan1VYLR+LumcKWPDEQKohihh9Dm4YivWud1Iw9bijUWEVijoUlmY/n2pdw6YMqxFZZhDrpWY5GAhO3gZsaMxZKIdRCevkzl5ATbBXwvTeP0OegiupyOeIpBAQZPh96+iO1cD356ZAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1firUzt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752069468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OqCYNbHde+oj8u7v3nO86EHv4Rdw2RpeFK65Esh3UY=;
	b=d1firUztnNicBOAdSaLaOrXxoYERaxQ+TN8GuoJcGNvXIH/7c4F4scOkYpj0eNI6lh8ral
	yFKdU05CtTrAFUF8HU2SWbzyRcPbOB7vThBIH5wYhwqt9peSITm0F7ZO4/zocP8DPvttwK
	x1h1iKupnJteZOhS5Y+cKWtxwUXhu5A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-ppewAm92PTOnvb6BLD6dxQ-1; Wed, 09 Jul 2025 09:57:46 -0400
X-MC-Unique: ppewAm92PTOnvb6BLD6dxQ-1
X-Mimecast-MFC-AGG-ID: ppewAm92PTOnvb6BLD6dxQ_1752069466
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-702b5e87d98so115711726d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069466; x=1752674266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OqCYNbHde+oj8u7v3nO86EHv4Rdw2RpeFK65Esh3UY=;
        b=qgiUGEfrYlZjN8zyWiu8xROSymcw6AQKOsNWcohOrTne0UTVYCQ3isboRRNEP1A2MQ
         Hn270sCQtXI+pqwmgj8eycT1Yzlz5M8D8vZ4D+2eaugY/UqHnY/UQER9AlR7Csdq5YXp
         CRJeZcmsJcEs0oYfa+fSu2fUOK+ny2JDbPbGKSi6EY86+Gi4TLHHgVoAHbdvpNI7ZqY/
         DYfzX7DiGO0mXNEktdOED7WK1Fegu1IObnVM8iZgvJiTK8xvibAO+KfT3zI9TY9BPGag
         TLyaS1q9WcPZqUsyJqraJQk0zbfVKfHMlJuW1nVylhxCkXcO4sQWkkn24WDYDYivlp85
         kaSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTD/zFSjjWvyyVEyTIYjhDpWjYoKMjf19735kqpiBMhGx7yWySngksb7FG+9w0TSTmMpfYwKQwA5yWpZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVASPTTF07Hos7JSldMfAOrX0CT4mHx8babKbWV5P/o46CJ5a6
	97UvBe513KKebXFp8dFgt2U0Ndj3VSxqssFUKgFCTiRxcJBtCRNzLTHyWQD3aEOPVJdCxl9FfZn
	22JCM2x1YnXmUZecNySEPWJcFMzgBU+Dxn3wY/vY7f7aHLZH/mQvxIkaqd/EGgG8DDg==
X-Gm-Gg: ASbGncuejw80+GLNxbuhb9EgKrxFLiLFjIRxBfbqpBtf15Q3x9oh5IdvnAXWt7/G5Hd
	W/mz3UG5LufoRhml9snfHjZyvQesc62HO5n4o9U46R9JTsY4hNs0Bkcnr+gJl8VkyxD1JLLzKDS
	ZLEqS8Bof3MWuY3KnW/PIatsfGxwXLAy3uvnMycGv2cpPP17Ct477f7pDHcxN27zU5DUO8aKFan
	jX4Qf8xDuk219VjSsHPLfhuzga2fQjI3z66Yol8iSsS1ee8uYdm1ARX6UZkv9dvkRlA+yA1N6KP
	paU8GM5aEg/Gh83XhnujJLON1k9iMy0em0voKaPZse1Uw/tORIfdWKjPn4R87/yt3L+6
X-Received: by 2002:a05:6214:5f0a:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-7048b84f81fmr47113356d6.19.1752069466274;
        Wed, 09 Jul 2025 06:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcAp3iZpe0X7o1M9/EPYvjmMQs313LShghAvdJjRZHmp4+jzUA1+znSQ7TVfsCLnAaxXLSKA==
X-Received: by 2002:a05:6214:5f0a:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-7048b84f81fmr47112836d6.19.1752069465726;
        Wed, 09 Jul 2025 06:57:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4ccd6b5sm92513406d6.49.2025.07.09.06.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 06:57:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <798d0707-8f05-4ffd-9ee5-7d3945276ee8@redhat.com>
Date: Wed, 9 Jul 2025 09:57:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
 Erik Lundgren <elundgren@meta.com>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <aG49yaIcCPML9GsC@gmail.com>
Content-Language: en-US
In-Reply-To: <aG49yaIcCPML9GsC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/25 6:00 AM, Breno Leitao wrote:
> Hello Waiman, Boqun,
>
> On Fri, Mar 21, 2025 at 02:30:49AM -0700, Breno Leitao wrote:
>> lockdep_unregister_key() is called from critical code paths, including
>> sections where rtnl_lock() is held. For example, when replacing a qdisc
>> in a network device, network egress traffic is disabled while
>> __qdisc_destroy() is called for every network queue.
>>
>> If lockdep is enabled, __qdisc_destroy() calls lockdep_unregister_key(),
>> which gets blocked waiting for synchronize_rcu() to complete.
>>
>> For example, a simple tc command to replace a qdisc could take 13
>> seconds:
>>
>>    # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>>      real    0m13.195s
>>      user    0m0.001s
>>      sys     0m2.746s
>>
>> During this time, network egress is completely frozen while waiting for
>> RCU synchronization.
>>
>> Use synchronize_rcu_expedited() instead to minimize the impact on
>> critical operations like network connectivity changes.
>>
>> This improves 10x the function call to tc, when replacing the qdisc for
>> a network card.
>>
>>     # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
>>       real     0m1.789s
>>       user     0m0.000s
>>       sys      0m1.613s
> Can I have this landed as a workaround for the problem above, while
> hazard pointers doesn't get merged?
>
> This is affecting some systems that runs the Linus' upstream kernel with
> some debug flags enabled, and I would like to have they unblocked.
>
> Once hazard pointer lands, this will be reverted. Is this a fair
> approach?
>
> Thanks for your help,
> --breno

I am fine with this patch going in as a temporary workaround. Boqun, 
what do you think?

Cheers,
Longman


