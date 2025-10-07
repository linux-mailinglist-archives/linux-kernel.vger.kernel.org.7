Return-Path: <linux-kernel+bounces-844570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1488BC23E2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBA5B34FD83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD092E8DF7;
	Tue,  7 Oct 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+1gBqnx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BE2E090C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857690; cv=none; b=UyDZMe0PPZWggHKH/Wm3WedMzcKrw2Z3uiiARALo00EFmBOrzYnM7ALR/2llecm+zR2Sf1xg11SSBoqgNRydQjTGXATL/Gmy2L1vHZAft1HcQ1vFvrrdIDo6P2ddhqEVUZ8jf67xWzoN9xT+T6tD4X93iDFczYbhrmeV+kvrGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857690; c=relaxed/simple;
	bh=b2vHjDsP2BxSjpiOVSVFD8j9UmUoOh1nH1hX783c5rs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iztIFthJ0J+Qe1qnWQfqFlQBYOJ85DwiMUjoqyAYrHjHS9qpCNf9jp4V/DfnA0BIRC1cPhWmCRyK4b8yFa4Ab4Hex9cr9JzI2ghYk7QXwc2cgHtqIQb8u1yL37JPVYFRu0TgP/rScuINSfL3zab9101P3iX+PX7KTT3hM5DQrow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+1gBqnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759857687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wfLqwqfh7pqxZEfbQpikVBptkM8ufmn/kKGSr4Jd6Yw=;
	b=K+1gBqnx2xJOTbF+YDRgyttF8c0DN4/X0wSgJ39mXnyfZvIxtIU7nS6hbOER0ssC8zKKuY
	rq9YQtXIhtTcqg4AF72rG1e5QCsZTB0joJAi4egLrpEqLMl7bMK6HDAxlrxwS/UiQ3/v+L
	4HVEv9RxyNRXmCbMhefogt4fCPOaGdQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-HNWG8xUPORSPtVRdK-zzHw-1; Tue, 07 Oct 2025 13:21:26 -0400
X-MC-Unique: HNWG8xUPORSPtVRdK-zzHw-1
X-Mimecast-MFC-AGG-ID: HNWG8xUPORSPtVRdK-zzHw_1759857686
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78f3a8ee4d8so119302156d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857686; x=1760462486;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfLqwqfh7pqxZEfbQpikVBptkM8ufmn/kKGSr4Jd6Yw=;
        b=vYQ97caA5N9HSO6GhJi2ghyoi0QH7kZo4tXH1++FFMvULnXMGYvuV8GHDE1BDG9jNj
         K63qfhaH5AfaOwdeFCYNn/eQb9W4ojnBnO/10hyTNFHPC17s3IBq2mKbJ0YAeyRIVZdI
         pjmLOzqLrJ8KzMNUT0KkZ8bsmZuo1ooAhZ3uxNaaDCV3Xe+L1/NkYyxmudH1Xj3s/06F
         2EJxWyafsLiux3itl9RJf12QhA4T6OdS2+Tu9GVEEuoUK/bGGUDTEJo4VxSRceFENoBF
         g4Nd2OX4pHghHpjgwNW6I4Rfymu/rHovv4UKLOkryhxdt/ab7Pr9zGnueLMvVE/lFlMk
         wiPw==
X-Forwarded-Encrypted: i=1; AJvYcCUGgGgukQHARKIhjqBKaZIywQQ9Uk5I1sZQR1YWRwFDF9kyN2I8hm2nt0Obdyx7Wl7rmM0aTanNJ6/8PS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyosfdjl2mCZZN3pFDzF+5Lj4/ChNXm8cH9ZzeqApegjL41d/lo
	/UAsOvUNkiu2dY2/1tKcpVid/ZNOdUaiGGGkp9USxR39jNfEFU0r3K3nSeRtDRKA6kwssoRn+BF
	UMbjS7qOUg3Ifdn8cBvkb9x+nYDuU6BxdPuFAEFPBaX0AWHf8QchmFZDE3e7TaSDAJA==
X-Gm-Gg: ASbGncv4oUxEpbd/WcEwmM7ITCdusCMhTT3s38vVsJHFxvZaVKvx/YwKDi8+DY+j6w6
	VJ5oLRrFFITFZ1KJLgPIKBBPkcZB6C50qCLM9RukvkC3McGOgySkHZ3vjN/ThdwulNuNr9rDJhz
	x/sJJvX+Rl1c+GtgY3Ph5rQlWz1Q+xUxM1L1wmFTGyAXd1F8SdXy6llDhHza4mpVLI3zHJRoFdV
	HhsgsQn8727ynYhyUqTgzLWK7kNKqFbmtG1DxzJLZSY3wDkRbjRKwC2WWHmT0ifg3pbw8HJtV6O
	CVgU66vMFrSrJSPG7UoT9IoPm1gts1sJ82uFyWffqqHnthdlD3ZIf9bYtXeJkRxLqWlBq2t4ILY
	yitsn4TcGy26WaihL
X-Received: by 2002:a05:6214:5012:b0:70d:f9d0:de72 with SMTP id 6a1803df08f44-87b2f005742mr2718786d6.61.1759857685697;
        Tue, 07 Oct 2025 10:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB6Pon6/tq/QF2SuS7Tynf1CLwWPH8R1IxJHBqbKPp6PdP09o/UQXK+tnc70iWYXkENmbzaA==
X-Received: by 2002:a05:6214:5012:b0:70d:f9d0:de72 with SMTP id 6a1803df08f44-87b2f005742mr2718156d6.61.1759857685141;
        Tue, 07 Oct 2025 10:21:25 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf533a0sm155713596d6.58.2025.10.07.10.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 10:21:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9299a314-fd20-4255-ae4d-38ee97e16879@redhat.com>
Date: Tue, 7 Oct 2025 13:21:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20251007142113.GA17118@redhat.com>
 <6e804e9b-ec73-4f2d-8e1f-c187ea5eb319@redhat.com>
 <20251007171810.GC12329@redhat.com>
Content-Language: en-US
In-Reply-To: <20251007171810.GC12329@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/25 1:18 PM, Oleg Nesterov wrote:
> On 10/07, Waiman Long wrote:
>> On 10/7/25 10:21 AM, Oleg Nesterov wrote:
>>> +
>>> +/* internal helper for scoped_seqlock_read/scoped_seqlock_read_irqsave */
>>> +static inline int
>>> +scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
>> I would suggest adding the "__" prefix to indicate that this is an internal
>> helper that shouldn't be called directly.
> OK, I will add "__", but I thought that "internal helper" makes it clear that
> it shouldn't be called directly. Nevermind, will do.
>
>>> +#define __scoped_seqlock_read(lock, lockless, seq)	\
>>> +	for (int lockless = 1, seq = read_seqbegin(lock);		\
>>> +	     lockless || scoped_seqlock_read_retry(lock, &seq, NULL);	\
>>> +	     lockless = 0)
>> I like Linus' suggestion of putting lockless and seq into a struct to make
>> it more consistent with __scoped_seqlock_read_irqsave().
> Again, will do. See my reply to Linus.
>
>>> +/**
>>> + * scoped_seqlock_read_irqsave(lock) - same as scoped_seqlock_read() but
>>> + *                                     disables irqs on a locking pass
>>> + * @lock: pointer to the seqlock_t protecting the data
>> Maybe we should we should add a comment saying that this API is similar to
>> scoped_seqlock_read() but with irqs disabled.
> Hmm... This is what the comment above tries to say... Do you think it can
> be improved?

Sorry, I missed that. Never mind :-)

Cheers,
Longman


