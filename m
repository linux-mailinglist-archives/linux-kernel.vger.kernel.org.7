Return-Path: <linux-kernel+bounces-844521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FBBC21F8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0EC19A4ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB2217F24;
	Tue,  7 Oct 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql+UIF/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CB1D5CFE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854924; cv=none; b=eQUOSXWp0EL4rZQFi2JuXIxxU3VpN8hVCOyEeTsR4bAk26u3htDvhv1yHQF2kjBm01FADowAHlGtDJBy8EvSxSo4GuqOG1qnl9+cVpkxxbo07thXXOX90G8KCGsqlbgikedZQPgDd5jn1ygXg6E1S5nmhWrTecYQwAM7apmSOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854924; c=relaxed/simple;
	bh=YAYu69oqTB3xeQy4HsiVJHo4x6M38bCk3uERTMXlpdM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ArF9bBHs7bOB2wsBJws+lGHKkxDTvjZRbjf6O9ADbQfm1+qsdo95hK+StKQgNPKJrdcs1cn+5k2V6Q9T9bhrYd2AXgWKfJLKO29N8SlfXZyaO3/+tqtaknJ2ISHNeJFV7kJhhMxYNkx+VNPETVbckxwpT4M32ivN1N9ehyReUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ql+UIF/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759854921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XLNkh1yO/GL2ndLNKU/mc4pjg+7SoRGXonUzdT7/+Vw=;
	b=Ql+UIF/I8ISvtKEniDWeKZB5Vz5P5wCDC55cDgSlxK/9GPQmLnq0+fbWS8RemUlIIf1q2I
	mzlTJwl5Axmj+uW1xtivRkzxMVP5rXofQ1X3lq/GXbLJgH/P0xiv9ngjMyBNrdbP4Nv8tT
	dPutO0lvQmbvKUd6xX2m/yg9mP2vtEY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-YI9vRp8vPOqMDfgTKnjw1w-1; Tue, 07 Oct 2025 12:35:19 -0400
X-MC-Unique: YI9vRp8vPOqMDfgTKnjw1w-1
X-Mimecast-MFC-AGG-ID: YI9vRp8vPOqMDfgTKnjw1w_1759854917
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7fa235e330dso1104656d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759854917; x=1760459717;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLNkh1yO/GL2ndLNKU/mc4pjg+7SoRGXonUzdT7/+Vw=;
        b=RxiKUA2h1vIFG9N5HPpXgCjYbHGFVP0S3oggMH6h2OWq6ZmvgQmGm9Yyjyj836cErX
         OMeN4nYQflnrAqGQ6kUSvFN4KGICH9BSRjrjr+9rQn/aDw4e1wX6+qneG9PqQxZmQBgz
         kKhqs3J/c/fkuJVQyIuy91mcjRXRzZ5nA1PwbX4OewQ2zh+MUJYP55yxV6Kbzl+z2fHb
         L6qStVLQBpSYpfrTbRbuGlXJTCSy0iZ+zzB4f19x7BxIoYVlsTVfQYFALukcUOT0uJBD
         a2Ia1E9ow4ru/y5r0rMq7QQ6s+HUUmMbE9vBxYrcMbT5vee5tyUkqjr4pGkO/6XM+noP
         EJeQ==
X-Gm-Message-State: AOJu0Yxgn6gGFwXE/5z4LI8Qp3tio0PvFvNHY/fzH+MjJ+THEECeYafV
	7TLnyp/Aw01M2G9ssssopTZq1WteSZujfIuOCQ4ngrwsiy8QUSoYNQ3I0lzIwWNV/SRReuZnRDo
	CPUainfEENg05arNMXmwYfRBa5SY0kNFK5qOHHBwk01VWdBwib7Mo3uM1JutkTPYRHw==
X-Gm-Gg: ASbGncsZivPFSNH8+JWv0U7cQqGgPdLwFiEDA5uRKgBq0G+lZ8E6GqJTWbKm8g9HHpQ
	2V9K5YKiP3YkVclhCnMHCYki17oAvunwQ03Nwsd2XtjtUskEW9unDnxOxlI5befhYF152qX992T
	Hwf2K3xyr3fdp1sNWaPkVnCRk92zoE6iko03kS5vTu9CV8E7HHKqcSAGEQ1unIZ+J/rFNdo1F7C
	sXq5a7UEIPkKI544QsNdEtWcQ77X6STYOvSsVaf2obNcgmtyEVrmJuAaj2rSi58hu8cuTTBG+ud
	fYHDExZqRKrImaiQNMR4eW5OCT7RK1XauF6FPz3P+jqHYtaxYrOJhKY308YrE+AheCbLI8Lo0jT
	GHEAH32F4DufhMiVJ
X-Received: by 2002:ad4:5964:0:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-87a0527fd81mr61432656d6.32.1759854917269;
        Tue, 07 Oct 2025 09:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj4teVUSEHNUCpCFTe6+pvQIagL1hNlFMQfjvoiR6WrHIf6BRF0caV9+mp1bNTVSA6AMdv6g==
X-Received: by 2002:ad4:5964:0:b0:753:c0ea:b052 with SMTP id 6a1803df08f44-87a0527fd81mr61431686d6.32.1759854916462;
        Tue, 07 Oct 2025 09:35:16 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60cc2sm138361516d6.1.2025.10.07.09.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 09:35:15 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6e804e9b-ec73-4f2d-8e1f-c187ea5eb319@redhat.com>
Date: Tue, 7 Oct 2025 12:35:15 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
To: Oleg Nesterov <oleg@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Boqun Feng <boqun.feng@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Li RongQing <lirongqing@baidu.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20251007142113.GA17118@redhat.com>
Content-Language: en-US
In-Reply-To: <20251007142113.GA17118@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/25 10:21 AM, Oleg Nesterov wrote:
> The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
> error prone. With the new helper the "typical" code like
>
> 	int seq, nextseq;
> 	unsigned long flags;
>
> 	nextseq = 0;
> 	do {
> 		seq = nextseq;
> 		flags = read_seqbegin_or_lock_irqsave(&seqlock, &seq);
>
> 		// read-side critical section
>
> 		nextseq = 1;
> 	} while (need_seqretry(&seqlock, seq));
> 	done_seqretry_irqrestore(&seqlock, seq, flags);
>
> can be rewritten as
>
> 	scoped_seqlock_read_irqsave (&seqlock) {
> 		// read-side critical section
> 	}
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   include/linux/seqlock.h | 61 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5ce48eab7a2a..9012702fd0a8 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1209,4 +1209,65 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
>   	if (seq & 1)
>   		read_sequnlock_excl_irqrestore(lock, flags);
>   }
> +
> +/* internal helper for scoped_seqlock_read/scoped_seqlock_read_irqsave */
> +static inline int
> +scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
I would suggest adding the "__" prefix to indicate that this is an 
internal helper that shouldn't be called directly.
> +{
> +	int retry = 0;
> +
> +	if (*seq & 1) {
> +		if (flags)
> +			read_sequnlock_excl_irqrestore(lock, *flags);
> +		else
> +			read_sequnlock_excl(lock);
> +	} else if (read_seqretry(lock, *seq)) {
> +		retry = *seq = 1;
> +		if (flags)
> +			read_seqlock_excl_irqsave(lock, *flags);
> +		else
> +			read_seqlock_excl(lock);
> +	}
> +
> +	return retry;
> +}
> +
> +#define __scoped_seqlock_read(lock, lockless, seq)	\
> +	for (int lockless = 1, seq = read_seqbegin(lock);		\
> +	     lockless || scoped_seqlock_read_retry(lock, &seq, NULL);	\
> +	     lockless = 0)

I like Linus' suggestion of putting lockless and seq into a struct to 
make it more consistent with __scoped_seqlock_read_irqsave().

> +
> +/**
> + * scoped_seqlock_read(lock) - execute the read side critical section
> + *                             without manual sequence counter handling
> + *                             or calls to other helpers
> + * @lock: pointer to the seqlock_t protecting the data
> + *
> + * Example:
> + *
> + *	scoped_seqlock_read(&lock) {
> + *		// read-side critical section
> + *	}
> + *
> + * Starts with a lockless pass first. If it fails, restarts the critical
> + * section with the lock held.
> + *
> + * The critical section must not contain control flow that escapes the loop.
> + */
> +#define scoped_seqlock_read(lock)	\
> +	__scoped_seqlock_read(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq))
> +
> +#define __scoped_seqlock_read_irqsave(lock, s)	\
> +	for (struct { int lockless, seq; ulong flags; } s = { 1, read_seqbegin(lock) }; \
> +	     s.lockless || scoped_seqlock_read_retry(lock, &s.seq, &s.flags);		\
> +	     s.lockless = 0)
> +
> +/**
> + * scoped_seqlock_read_irqsave(lock) - same as scoped_seqlock_read() but
> + *                                     disables irqs on a locking pass
> + * @lock: pointer to the seqlock_t protecting the data
Maybe we should we should add a comment saying that this API is similar 
to scoped_seqlock_read() but with irqs disabled.
> + */
> +#define scoped_seqlock_read_irqsave(lock)	\
> +	__scoped_seqlock_read_irqsave(lock, __UNIQUE_ID(s))
> +
>   #endif /* __LINUX_SEQLOCK_H */

Other than these minor nits, the patch looks good to me.

Cheers,
Longman


