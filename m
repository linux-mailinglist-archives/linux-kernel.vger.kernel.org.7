Return-Path: <linux-kernel+bounces-839440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457F7BB19EF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063EA16EF38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B64266B52;
	Wed,  1 Oct 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA5zcfGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B426335C7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347295; cv=none; b=A+NgsHTpdLS8XjjBTixoFlngTJxhZ3z6pYkrErRaWWjK0gfWHw+JUwuDzwDYJ6M9wr0hAvuIignFSZFSVjBAzmd4VFw9yDuKyo0r/s1iKliqKTPu3KC9mnVxUyYbL0LRZeoOmcMo85G5C2dFjmZY+Vva3X6GHn+rpLzLW6ZQFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347295; c=relaxed/simple;
	bh=h6GNrChgMTR7gyFqAMhCc0PD7j1Ta7qW85x6703GMWM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fhCAseZRSdpFMMuSLN/sCkUJgmG8q6FJTO6RrSne51fLpav5L7cNbH1YqlxIZaWHzaJZHHLGZotjvZeArNi+nnMbFXiSPcyyqOk0Xl/AXJqc18y/YQ3EUECSO80ldzffM1RVhG/RJ2XiXHB5pnrga6sftmTJPo0mBvV3Y02dHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA5zcfGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759347292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+8FgvXBnLoEeKHRLgt+wllaRxRl7E+rnlsq3VoP2Ng=;
	b=GA5zcfGZMQoQHXKmth05AcWjaAz1OkL6T4Te6/TEWIlTOD6d7nZ94uKBh2v6cxv2ZsiJHn
	1jzsD35kUdCFKq8wC6GkjghCIYXLh9m0CH9rXQCMnHB5P3g/RIJLsmbcJXEI0j7g4t1r2I
	uKA5hMXy3GP5jT1Za/gNW1B7x4r3a4I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-_Iv_vFw9PSGEdcIpYiM6jA-1; Wed, 01 Oct 2025 15:34:51 -0400
X-MC-Unique: _Iv_vFw9PSGEdcIpYiM6jA-1
X-Mimecast-MFC-AGG-ID: _Iv_vFw9PSGEdcIpYiM6jA_1759347291
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-79538b281cdso3629166d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347291; x=1759952091;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+8FgvXBnLoEeKHRLgt+wllaRxRl7E+rnlsq3VoP2Ng=;
        b=oSOihTzdxbVzavSasHeye1qVNHI+tZiArdVoTX14pv/CerD6v4rTYMg/uXXZZaM5Pj
         8dPKFEmt9XJwkJCOrxIDGyMMWNlYVFISG2wkdLY8odi1HjCIijM8MXCfDn1XnXP7IpM0
         XzoewvPv3OnhrVOnOOx7UT+VSn5JfURWwl4J74cTloz+5e9GOpH6aBLLK+/jynE2XQdG
         KZuQT4q2M7PVi9vDuOJElwn9OMsz7uO0EGJmeU+ixekiHdaMBMTUSxsBYmZvEiIKA/IZ
         9HivGxBRKPn+VrJKFdvQxZfHdvTcX7BL84rxcMZDhe+8h9RPAL7IPCBqdZSYawiQbU/n
         MjJg==
X-Forwarded-Encrypted: i=1; AJvYcCX6hUMWIuoYnmYXGatFSXzoccKIEw9cq963skaANyNUYiqU6d0J0OSXPNQoh75CIq4sz61eTDMrGSM+XjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7u/aqGc/sGv8TXqckpJWPRDhnIKql7EhAtLtmjAAo7qmUREY
	bBuXNEBKpjUqMmXr5+/vJZHRhi08rZqxJPVoLF+hT+njKTmMN2rib899LQJ7lCF1NHODzVR6ZLn
	Y/P9bHpD8spJkpjKpLQddGlLtsenJ+a2IwH2sXaWDYslFY11oVk/K/6boEKE/ISACUQ==
X-Gm-Gg: ASbGnctD1XCZ3su4RcggUoIK/QnySEzpcHHheAOCzoCrPf6mh79SyO5+RZt9GDen9Jg
	R4RUP8BaQSzab9/N/lLz+LfP80HOrN/wTosAEeAdLrleiqlFVRniWXgn9VqFRCdKgTvjP2ZRiqY
	FoyPL7C6rjZ6i29fAX7sLCXBYs3OpQyvl9xKLXohDkUOn9yNLDfDFH0tj5sUh48lsZseHqGltLt
	uJX6BIE9lV9zS4L5Q0F/llXxVlnjcg6KJO+YW9Wa/UJc5b5fUiMUOHJsjeFaxYDWKnSYvb7nT4u
	J+C5GjiULmqG4g9mplb+nOO6xjMxizKzftjq5jHpTHme3dRn2ArwZF0t8FXRcQvjuoWMJry+Evw
	QaSeUbGO5lNc1wLPz
X-Received: by 2002:a05:6214:f68:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-878bb72f458mr15352446d6.32.1759347290839;
        Wed, 01 Oct 2025 12:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEjAw1wkF+BQ1tjnR3dvHgepF7S04JY0vqjMEFmKJr+MSZqbKHECq4ivelkqU0wCAxTMR8UA==
X-Received: by 2002:a05:6214:f68:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-878bb72f458mr15352066d6.32.1759347290354;
        Wed, 01 Oct 2025 12:34:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb4469bcsm4944776d6.16.2025.10.01.12.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 12:34:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <94086b14-37c9-40a7-a474-52887bf17138@redhat.com>
Date: Wed, 1 Oct 2025 15:34:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] documentation: seqlock: fix the wrong documentation
 of read_seqbegin_or_lock/need_seqretry
To: Waiman Long <llong@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250928161953.GA3112@redhat.com>
 <20250928162029.GA3121@redhat.com>
 <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
 <20251001190625.GA32506@redhat.com>
 <339a4e0b-f323-4d48-8a1a-b7459aec53a2@redhat.com>
Content-Language: en-US
In-Reply-To: <339a4e0b-f323-4d48-8a1a-b7459aec53a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 3:24 PM, Waiman Long wrote:
> On 10/1/25 3:06 PM, Oleg Nesterov wrote:
>> On 10/01, Waiman Long wrote:
>>> On 9/28/25 12:20 PM, Oleg Nesterov wrote:
>>>> --- a/Documentation/locking/seqlock.rst
>>>> +++ b/Documentation/locking/seqlock.rst
>>>> @@ -218,13 +218,14 @@ Read path, three categories:
>>>>      according to a passed marker. This is used to avoid lockless 
>>>> readers
>>>>      starvation (too much retry loops) in case of a sharp spike in 
>>>> write
>>>>      activity. First, a lockless read is tried (even marker 
>>>> passed). If
>>>> -   that trial fails (odd sequence counter is returned, which is 
>>>> used as
>>>> -   the next iteration marker), the lockless read is transformed to a
>>>> -   full locking read and no retry loop is necessary::
>>>> +   that trial fails (sequence counter doesn't match), make the marker
>>>> +   odd for the next iteration, the lockless read is transformed to a
>>>> +   full locking read and no retry loop is necessary, for example::
>>>>       /* marker; even initialization */
>>>> -    int seq = 0;
>>>> +    int seq = 1;
>>>>       do {
>>>> +        seq++; /* 2 on the 1st/lockless path, otherwise odd */
>>>>           read_seqbegin_or_lock(&foo_seqlock, &seq);
>>>>           /* ... [[read-side critical section]] ... */
>>> It is kind of odd to initialize the sequence to 1 and add an sequence
>>> increment inside the loop.
>> Sure. But a) in this patch my only point is that the current 
>> documentation is
>> wrong, and b) the pseudo-code after this change becomes correct and 
>> the new
>> pattern already have the users. For example, do_io_accounting() and 
>> more.
> Thank for letting me know, but I believe my suggested change will work 
> with this modified loop iteration.
>>
>>> Perhaps we can do something like:
>> Perhaps. But could you please read the "RFC 2/1" thread? To me it is 
>> kind of
>> odd that the simple loops like this example have to even touch the 
>> sequence
>> counter inside the loop.
>>
>>> +static inline int need_seqretry_once(seqlock_t *lock, int *seq)
>>> +{
>>> +       int ret = !(*seq & 1) && read_seqretry(lock, *seq);
>>> +
>>> +       if (ret)
>>> +               *seq = 1;       /* Enforce locking in next iteration */
>>> +       return ret;
>>> +}
>> And this is exactly what I tried to propose in "RFC 2/1". Plus more...
>
> I had read that. You used _xxx() suffix which I think a good choice 
> will be to use _once() to indicate that we only want one retry.

Note that with my suggested reading of the sequence count within 
read_seqbegin_or_lock(), we may not really need this extra helper. 
However, there is still a very slight chance that reader and writer are 
perfectly synchronized in such a way that an even sequence number is 
always read even though it is still increasing after each iteration. So 
this new helper is for users that is paranoid about this rare case.

Cheers,
Longman


