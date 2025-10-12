Return-Path: <linux-kernel+bounces-849772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA74BD0D82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC923B6219
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1E2EC0A5;
	Sun, 12 Oct 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZW0qHMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FB82EBBB8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760311079; cv=none; b=rlAc8mYxcW+eQMdad/NWLvu78G3pV78nKhyj0d8d4XuYrj8AHnPUu0ppvsV/rl4EO6l4caQ8CaN/7C7UnTD2BhGrUFn7inLILJTsJaDDLnIozJWhqKjnCivW36iR55uevIK5/r7Ms8uk60q72V1lUy28rmB1C8QDMrDA9bPJ4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760311079; c=relaxed/simple;
	bh=GD3OjYjrNwSiwUh1ZnQ1W4VUQS5ZBBNvT9/53sEhPZs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bOIdZxpSLjnsMuGoaRbEzC4gbnhmpKAWdGi9M8OF5UJonkIgU6Vbbsmg8+wv5mUNKMutKih8SuvvwzQLPdvLxWH43vmtG50GLNelp0gQd+g1JZzB1D5AUvOR0FafaznqKsDUk+tIEggqti4wrzOiLNtBSz+AxM0Jn2VsnpmZYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZW0qHMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760311076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6E9aJnD4pThJM+yVpaZTb+HSYYAWTd042QuYhCmauDI=;
	b=NZW0qHMKTExmlwuTJn5ovJmry+wUNzatVpS7UqzdCzpBEWtgOIxn8vAdZvMYUHFY8O75hZ
	2sVVqdBSDkpNt2fCTb9YmlQXlovK4q7sFbwWmecWtJ+XXwQOYHJszGwwmV7Bo4u2CnmdzR
	+Z7i34E01QzWX9sVhROtKMFRSYaxO0o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-U_D4rLT0PeynUfo8aqdaEw-1; Sun, 12 Oct 2025 19:17:54 -0400
X-MC-Unique: U_D4rLT0PeynUfo8aqdaEw-1
X-Mimecast-MFC-AGG-ID: U_D4rLT0PeynUfo8aqdaEw_1760311074
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28e538b5f23so79243975ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 16:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760311073; x=1760915873;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E9aJnD4pThJM+yVpaZTb+HSYYAWTd042QuYhCmauDI=;
        b=sMjAVdR/7NXNr6V9Nm42C6BrzVpYBAqJMZL+9W0WUDv3lGhNfIFIfvNZBNfoVyb2jl
         yI88FUY2kWsio/Af+LjTtFwuu08yJCWE8wXwxiWbFC7a1ZzgbwnzwzClCQ8mMTX3W7R2
         nonGwbLcERmwFq4J1dGKLPkK7r4etm0C1P72eAIowKSMO+SCHN7x+dVqBKdpnu9PIPoI
         3B86lJKQKYhEz9bYQjrAg3J6tRiQ4XbH/s8xfi5OauvnuL67MakSlIoLCbTtsLh2u5fq
         mb6F+x3CR6fpLSTWVuUoC7WKNkjanGixnkajhaTmN8HQxB/ukK4LD+8JaNv9EzmiRK85
         p2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+p7bgklJ6z8/DJi8Ml3mvXVuRAEdRsJrhf5DTGD1EesE/f4MjLuIRa1pq5OD9K/a8J1uhjH3v8g4AJXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmezds9PzPuIwqG2DpPq8rX0NkYuvVSU7hFjzDZ4qJavCNvNxF
	SBAGeJuY0zNnV2m94kYnNzW3lj8w5Sj+hgzIcXqAeeY5lQcX9B0t3UGaT52S7EMdZxkpOS3omw+
	o5PavwfCZsVgvdCIlqM1jXYpEVJiucjLhyqX1IuFvS5IBwO9Kk7P60f9IqbimrgkwSw==
X-Gm-Gg: ASbGncvnXZso6NzhI5Sodtg4V/NVdJjAvx9n9frYz2TDrQKtpcHJQTsq4KMjnpiBOeM
	95DG3cO7E0AMsNFhinnbhkn6gxkz/yufp0HWvXyDr2W0aW8WYP4p/x8Cnl16UUvZfbA1b3fs1up
	cBJ+mdZAnT8x6j+tQrFyX5nQQgTOOdfltjZMP/6LoUTX9xxJ5Nx2iklKKxDWQvPJPm6TG9ykY/L
	zVvCEgiz4HNAxYrYsdwK0JNP2yvliufde2mRJR1MYvdNOMwlOcIru6p+y6JLSTfbB4bRAhtcTKn
	lvOsP6C+SKxMihZYWtzFQwPAzW0mFD894vS1rqYr9k/WxAeZTq7fjOuTT5NWF2IF7kPcvSEwOOE
	ZulTcP19lstg=
X-Received: by 2002:a17:903:1aa4:b0:27c:a35a:1321 with SMTP id d9443c01a7336-290272e6f79mr219373695ad.51.1760311073621;
        Sun, 12 Oct 2025 16:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrznzoH1irBTZPRyvcgZgI0fX4jbxcpQvoGStKU3Qe6arbfvAqVDyBR4viFeI10GKIuwkMbg==
X-Received: by 2002:a17:903:1aa4:b0:27c:a35a:1321 with SMTP id d9443c01a7336-290272e6f79mr219373475ad.51.1760311073165;
        Sun, 12 Oct 2025 16:17:53 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f9cf7csm115262005ad.125.2025.10.12.16.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 16:17:52 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a2ddd23-9c19-48d7-b58b-0c74b4777563@redhat.com>
Date: Sun, 12 Oct 2025 19:17:51 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lock: Add doc comments for spin_lock_irq()
To: Daroc Alden <daroc@lwn.net>, Waiman Long <llong@redhat.com>
Cc: corbet@lwn.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20251010215403.743811-1-daroc@lwn.net>
 <4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
 <20251011142804.29da9591@azalea>
 <957be7c9-7860-4824-b491-88cb9741dfab@redhat.com>
 <20251012094830.0a237044@azalea>
Content-Language: en-US
In-Reply-To: <20251012094830.0a237044@azalea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/25 9:48 AM, Daroc Alden wrote:
> On Sat, 11 Oct 2025 22:31:17 -0400
> Waiman Long <llong@redhat.com> wrote:
>
>> On 10/11/25 2:28 PM, Daroc Alden wrote:
>>> On Fri, 10 Oct 2025 23:15:50 -0400
>>> Waiman Long <llong@redhat.com> wrote:
>>>   
>>>> On 10/10/25 5:53 PM, Daroc Alden wrote:
>>>>> The commonly used spin_lock_irq(), spin_lock_irqsave(),
>>>>> spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
>>>>> currently have any documentation; this commit adds kerneldoc
>>>>> comments to these four functions describing when their behavior
>>>>> and when they are appropriate to use.
>>>>>
>>>>> Signed-off-by: Daroc Alden <daroc@lwn.net>
>>>> This patch looks fine. Just wonder why just
>>>> spin_lock_irq()/spin_lock_irqsave() and not
>>>> spin_lock()/spin_lock_bh() as these functions also don't have
>>>> kerneldoc comments. Also spin_lock_irqsave() is a macro and not
>>>> actually a function, maybe we should mention that in the comment.
>>>>   
>>> Because I had to research spin_lock_irq()/spin_lock_irqsave() for a
>>> recent article, and therefore felt confident that I understood how
>>> they behaved and what should go in the doc comment.
>>>
>>> If you — as a more experienced kernel person — can describe how/why
>>> the _bh() variants are used, I'm happy to add doc comments for them
>>> as well. My current understanding is that they interact with
>>> whatever is left of the "big kernel lock". Is that right?
>> "bh" in spin_lock_bh() stands for bottom half which is essentially
>> what what is being done in the softIRQ context. So spin_lock_bh()
>> just prevents the softIRQ code from being executed. This is my
>> understanding, but I may have missed other use cases of
>> spin_lock_bh(). Others can chime in if there is more to say. Anyway,
>> I am fine with adding more comments to spinlock code.
>>
> Ah, okay!
>
> I went and read some of the existing locking documentation with that
> context in mind, and I think I understand. I think the doc comment
> should look something like this:
>
> /**
>   * spin_lock_bh() - Disable softIRQs and take the provided spinlock.
>   * @lock: The spinlock to acquire.
>   *
>   * When data is shared between code that can run in process context and
>   * code that can run in a softIRQ, if the softIRQ tries to acquire a
>   * spinlock that is already held, the system could deadlock. This
>   * function disables softIRQs before taking the provided spinlock. It
>   * should typically be paired with a call to spin_unlock_bh() in order
>   * to reenable softIRQs when the lock is released.
>   *
>   * If the interrupt code can run as a hard interrupt instead of a soft
>   * interrupt, this is the wrong function: use spin_lock_irqsave(). If in
>   * doubt, using spin_lock_irqsave() instead of spin_lock_bh() is always
>   * permissible, since the former is a superset of the latter.
I believe the above description is correct.
>   *
>   * If synchronizing between a tasklet or timer and a softIRQ, the plain
>   * spin_lock() function can be used, because these are not interrupted
>   * by softIRQs on the same CPU.
>   */

Tasklets and timer handling are run in softIRQ context.  SoftIRQs are 
sub-divided into a number of priority levels (see 
include/linux/interrupt.h) from high to low, they are not going to 
interrupt each other.

Cheers,
Longman


