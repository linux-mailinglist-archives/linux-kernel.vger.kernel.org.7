Return-Path: <linux-kernel+bounces-848269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6CCBCD138
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102293C70EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD00285CB6;
	Fri, 10 Oct 2025 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekz3Ue5J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB11F63FF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102179; cv=none; b=TkfFZEt9PD8GIbjJUri0Fd0iM1zIBDHXrKiM1ihlGUQ6iEpXIVCwPTulqJuOM8GjZDiclfPv/PVF2iiiOomSmzrXM00yQ9oEeL7Tj2S7SgmZmAisMD7QgS5iJi1r2fhJNMAz4kpcE1CN/JzkWe+qGpZp5iKiqihq7+JBZJ4d9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102179; c=relaxed/simple;
	bh=N2KbvdFGyoYES8nigVZMAyfBjCSoYaOhcXXRE2LcdCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjG8PiSvT1cjscWuyR3ZkGSJy+MUn05eqgAKv2/bC3MSMKS2qw6RYVESh6U2KRwe2vu9hmJi16crweo42Fy0QpkeOHlmkHI6leHNYh2Ahvg9DBWOlwk+JhbHHrzUSs5QhBMqhrioT5tPEeyOwZjIBX4LzTDQf8/UUKr9wbu9iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekz3Ue5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760102176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxer9+u7BblvH5ZI0UIQCwT2/E+R71RYa38L9H5HCIc=;
	b=ekz3Ue5JXoIeNICJvb0ZLK9kaXa2uecfKgrWchExiQ6CmPQ+nCvzERuDaN0bstFlALFXYw
	dzi5c45CkEVIynRPpz0R2auFE0nfswPvT9qbDRiwDuDmOQDRq+1QRLo6Y8mT6cjrbUDlnh
	9KunekekTvFOI78+pSznI8EyZ1F+XDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-DgycrCXoNA2_lBZHLFNYwA-1; Fri,
 10 Oct 2025 09:16:07 -0400
X-MC-Unique: DgycrCXoNA2_lBZHLFNYwA-1
X-Mimecast-MFC-AGG-ID: DgycrCXoNA2_lBZHLFNYwA_1760102166
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E57180057E;
	Fri, 10 Oct 2025 13:16:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C5E41800446;
	Fri, 10 Oct 2025 13:16:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Oct 2025 15:14:45 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:14:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251010131439.GB8798@redhat.com>
References: <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
 <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
 <20251010122347.GA8798@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010122347.GA8798@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/10, Oleg Nesterov wrote:
>
> On 10/10, Peter Zijlstra wrote:
> >
> > I reordered the code, it is happier now.
> >
> > Anyway, the below seems to generate decent code for
> > {-O2,-Os}x{gcc-14,clang-22}. Yay for optimizing compilers I suppose :-)
>
> Another approach which looks better than mine ;)
>
> Linus's version is simpler, but yours can handle break/return and
> the "only lockless" case, good.
>
> I leave this patch to you and Linus, he seems to like your code too.
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
>
> But... perhaps we should not "export" the _target names and instead
> add the additional defines, something like
>
> 	scoped_seqlock_read()
> 	scoped_seqlock_read_or_lock()
> 	scoped_seqlock_read_or_lock_irqsave()
>
> ?

And... perhaps we can simplify this code a little bit? I mean

	enum ss_state {
		ss_lockless	= 0,
		ss_lock		= 1,
		ss_lock_irqsave	= 2,
		ss_done		= 4,
	};

	struct ss_tmp {
		enum ss_state	state;
		unsigned long	data;
		seqlock_t	*lock;
	};

	static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
	{
		if (sst->state & ss_lock)
			spin_unlock(&sst->lock.lock);
		if (sst->state & ss_lock_irqsave)
			spin_unlock_irqrestore(&sst->lock.lock, sst->data);
	}

	static inline void
	__scoped_seqlock_next(struct ss_tmp *sst, enum ss_state target)
	{
		switch (sst->state) {
		case ss_lock:
		case ss_lock_irqsave:
			sst->state |= ss_done;
			return;

		case ss_lockless:
			if (!read_seqretry(sst->lock, sst->data)) {
				sst->state = ss_done;
				return;
			}
			break;
		}

		switch (target) {
		case ss_lock:
			spin_lock(&sst->lock.lock);
			sst->state = ss_lock;
			return;

		case ss_lock_irqsave:
			spin_lock_irqsave(&sst->lock.lock, sst->data);
			sst->state = ss_lock_irqsave;
			return;

		case ss_lockless:
			sst->data = read_seqbegin(sst->lock);
			return;
		}
	}

	#define __scoped_seqlock_read(_seqlock, _target, _s)			\
		for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =				\
		     { .state = ss_lockless, .data = read_seqbegin(_seqlock), .lock = __seqlock };	\
		     !(_s.state & ss_done);								\
		     __scoped_seqlock_next(&_s, _target))


(I removed __scoped_seqlock_invalid_target/__scoped_seqlock_bug to lessen the code).

Not sure this makes sense. Plus I didn't even try to compile this code and I have
no idea how this change can affect the code generation. But let me ask anyway...

Oleg.


