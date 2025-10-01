Return-Path: <linux-kernel+bounces-839360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC03BB17A3
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989111C47A0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FE2D3EDB;
	Wed,  1 Oct 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN/VMmNy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B82D373E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342879; cv=none; b=Zrlk0ugdJOdyDdA7PZZHL4epMqVtL4sn3M0gDr+Tcb7sjkAt7N2rljQD4+HWDL3oWqtWC+hDIsm1jGUaQoQzL7HjQWkKZcXUJWFNlNqsK2QgYmaErrV6vDTK6G0n1FWxSXblNRPuoDTv+Rr2vnUT/aR28ug/KY7SkbPU7eA3o0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342879; c=relaxed/simple;
	bh=CS8MHSf2uOlLI506IgtHYgDh+qwqLc54KaNtIl6zpDo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rrplL9oQNBSgKyFbwnMX06a5lITwgDnTYE1+A4h51AeGcgUT8qcE3iYaVmxS3+me6LtBllLNqZKZqe5bIMzNVOVTkA5Ei9TkQvpDEK4MieO5k5chK4W4OsRmasAHQP0Jti9fzpnNWEJKS7wMf3bPVRs5GP1ApatWuJKN9LgQPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HN/VMmNy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759342876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7zMw/kYYqbWu1yDuudzJNbCyAVSF/dRJNmHaWwpgTBo=;
	b=HN/VMmNyP+BOoT7t1yiS/bYJ+r1yvZnuO0LORV+MeJ7Y++MNB9sHsA2ULHWGKAy9wKXOBr
	cysZocTNUtuQKrkkUPVqd7xoTXo079/4tY8kGt0J7Cbmn4TlhRLHwedcEIJdZnkxU/l0dj
	5VWg8WmZufJnmbRl424ChsXH0ATAJGY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-uGtKmy1bMWyIueQyvBnBPQ-1; Wed, 01 Oct 2025 14:21:14 -0400
X-MC-Unique: uGtKmy1bMWyIueQyvBnBPQ-1
X-Mimecast-MFC-AGG-ID: uGtKmy1bMWyIueQyvBnBPQ_1759342874
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-818c83e607bso2680406d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342874; x=1759947674;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zMw/kYYqbWu1yDuudzJNbCyAVSF/dRJNmHaWwpgTBo=;
        b=C3IoHvEODoDr670Ijny1w2/mdCnqaI0dHWAbrGYt4TdpvpwcbSOOKk0K9eDaeSiBE9
         K2cvlNesUgA5N3nZao8NxcGacp/8kA5PO3M7IqpSLsl1tcEvBMZpYU/P0Vt3QEvgyPOv
         y2VYobIoLfTy9D/bdbCWiLytnfaIt/LuqBr9sXMLtxsYeSywEYFXWlLPWbis7iEVwkGN
         eEAiPgZPD9EyGIw8RGJu7/cWpbF7ENS1M5e8wcgZXsygNnU4vlykPjuLFQUS7VFX73CP
         BJUmE5J5ozeEJKjFMQlcFPvRsRokn0BmSPLW79ksiqaxNpwn24Ezq3lIGGPI+aqftyoK
         9hAQ==
X-Gm-Message-State: AOJu0YybPheCTpN+xJZrzbcKwkgErVfjCnjbJ/vOM3LMy8gP/GFS5lvF
	7ZednUIuu9TwM9nh3VZb9sE1eSncn1SNqp/eaZ6rEIXspebdw0bd6+fIH0aeCyiyLSrWiQxCzS9
	NNxBmc3BgfAVu2yfwFwP4LOwqkvTl3vbK+khemKZJV2p7ClDfJ18siQcjF071K7aO+w==
X-Gm-Gg: ASbGncsuYr337LAuPqUNtly36tWjqt7G8fMjEBr1uTSoJcvocj18Z/kT4HeEncC9T4M
	bsCrJ+95QDK4q7JtpfT4Zoeg3I9XaDUPSmaz3EmzHCKGO5Wqb9ZGdQe6opU7n4hJjc50vueMJa5
	0zYdqVYkmVeb7DqFBXpXerP/xDgtEdS2JhjaC3HFmw1dy9FvwSEqdJerGSGeDCGqzyF+yF8Xefr
	M2Z+O4a/PkqvVKDKtHBkj4iLg0at/Ql08cB22WrqRthrdlSGq10194ly0nmAdwhmSUfoatU0wTJ
	en0y+HP3Dw72Ct3LfKHONNuiiRGsz5tiq7G7Sy6nLOTNUmGsIMyVg3cbIeS/kNJqT8y08wNw+Wp
	LFji550rgA6fXhyeD
X-Received: by 2002:a05:6214:21e5:b0:80d:7913:c93c with SMTP id 6a1803df08f44-8739dfa60e9mr89981556d6.28.1759342873827;
        Wed, 01 Oct 2025 11:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkc1ZjTydU53NvdcScCx7ZsXUvg5a2DvNw/hwaL0O6SSephnpKDP8ZFaQYUB+/DfRCfYS4A==
X-Received: by 2002:a05:6214:21e5:b0:80d:7913:c93c with SMTP id 6a1803df08f44-8739dfa60e9mr89981026d6.28.1759342873415;
        Wed, 01 Oct 2025 11:21:13 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bbb1d5c0sm3178446d6.30.2025.10.01.11.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 11:21:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
Date: Wed, 1 Oct 2025 14:21:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] documentation: seqlock: fix the wrong documentation
 of read_seqbegin_or_lock/need_seqretry
To: Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Li RongQing <lirongqing@baidu.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250928161953.GA3112@redhat.com>
 <20250928162029.GA3121@redhat.com>
Content-Language: en-US
In-Reply-To: <20250928162029.GA3121@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/25 12:20 PM, Oleg Nesterov wrote:
> The comments and pseudo code in Documentation/locking/seqlock.rst are wrong:
>
> 	int seq = 0;
> 	do {
> 		read_seqbegin_or_lock(&foo_seqlock, &seq);
>
> 		/* ... [[read-side critical section]] ... */
>
> 	} while (need_seqretry(&foo_seqlock, seq));
>
> read_seqbegin_or_lock() always returns with an even "seq" and need_seqretry()
> doesn't change this counter. This means that seq is always even and thus the
> locking pass is simply impossible.
>
> IOW, "_or_lock" has no effect and this code doesn't differ from
>
> 	do {
> 		seq = read_seqbegin(&foo_seqlock);
>
> 		/* ... [[read-side critical section]] ... */
>
> 	} while (read_seqretry(&foo_seqlock, seq));
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   Documentation/locking/seqlock.rst | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
> index ec6411d02ac8..167d442d3c7f 100644
> --- a/Documentation/locking/seqlock.rst
> +++ b/Documentation/locking/seqlock.rst
> @@ -218,13 +218,14 @@ Read path, three categories:
>      according to a passed marker. This is used to avoid lockless readers
>      starvation (too much retry loops) in case of a sharp spike in write
>      activity. First, a lockless read is tried (even marker passed). If
> -   that trial fails (odd sequence counter is returned, which is used as
> -   the next iteration marker), the lockless read is transformed to a
> -   full locking read and no retry loop is necessary::
> +   that trial fails (sequence counter doesn't match), make the marker
> +   odd for the next iteration, the lockless read is transformed to a
> +   full locking read and no retry loop is necessary, for example::
>   
>   	/* marker; even initialization */
> -	int seq = 0;
> +	int seq = 1;
>   	do {
> +		seq++; /* 2 on the 1st/lockless path, otherwise odd */
>   		read_seqbegin_or_lock(&foo_seqlock, &seq);
>   
>   		/* ... [[read-side critical section]] ... */

It is kind of odd to initialize the sequence to 1 and add an sequence 
increment inside the loop. Perhaps we can do something like:

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..0f607ef28d98 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1126,6 +1126,9 @@ read_sequnlock_excl_irqrestore(seqlock_t *sl, 
unsigned long flags)
   */
  static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
  {
+       if (!(*seq & 1))        /* Reread sequence # if even */
+               *seq = seqprop_sequence(&lock->seqcount);
+
         if (!(*seq & 1))        /* Even */
                 *seq = read_seqbegin(lock);
         else                    /* Odd */
@@ -1144,6 +1147,15 @@ static inline int need_seqretry(seqlock_t *lock, 
int seq)
         return !(seq & 1) && read_seqretry(lock, seq);
  }

+static inline int need_seqretry_once(seqlock_t *lock, int *seq)
+{
+       int ret = !(*seq & 1) && read_seqretry(lock, *seq);
+
+       if (ret)
+               *seq = 1;       /* Enforce locking in next iteration */
+       return ret;
+}
+

With this, the current document should be good. Users have the option of 
using need_seqretry_once() to enforce at most 1 iteration. Of course, we 
still need to do similar change to the other read_seqbegin_or_lock_*() 
variants.

My 2 cents.

Cheers,
Longman


