Return-Path: <linux-kernel+bounces-840157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DEEBB3B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3843BDD9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9F30F93A;
	Thu,  2 Oct 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIMsRVjK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB20281532
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403001; cv=none; b=rkspaItn/eNvcw+OVgqWs/AdZultZFYC7MESn+b2GfIhnCiW8tJuCfMKTFcpjFwm1vACqy8xSHnROEiGigTS+lw+qxojx8iVgKeWqEkz+3nVkfTS4hmfTo8CNhQmJ9A5U5NzViPMjEUbEoexwvZnNPcjCAi3dU5n50/x5IsKe9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403001; c=relaxed/simple;
	bh=yC+PbgFZiOQxjpGDKRNCpQ0P7tNQaBKJanXoNhgC7jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmWgy24evCvRjccjXdwiv8wG/b5lqTTLuNHtePt4r89pXq2o8I89DJ1r5VieJ5fCisDJ04faE3MWPvldBrj4Bqd/6Gxd94fpjN7TMzLxve/EhgXgY9sOFlI7q/3SWjzMaPP0ZkEgRCGdoTFu1LTFpDvyyi2FqIwSGFO91AC7Ryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIMsRVjK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759402998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Ew6Bs4Qsc62/OLSs03LoMwOouJwdZJK8357qz8fjKA=;
	b=LIMsRVjK11H0BLoby7/zJB2hiiltMTi9v5vEOEyPYHRO/oPBmkgxIDbZstZdThPMQipBJG
	IqbzXGyp7ZzROM9EaCZZSrtBY9PUhRsTdfe3mBLQPQ+zNs6gwlz79ZLcoY4HBU4ZL8r0Ue
	BM68lD6jUNTUb8qyDq4CiiwDybiJPBY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-bAALu9vIPtOz0UN8f74Fmg-1; Thu,
 02 Oct 2025 07:03:15 -0400
X-MC-Unique: bAALu9vIPtOz0UN8f74Fmg-1
X-Mimecast-MFC-AGG-ID: bAALu9vIPtOz0UN8f74Fmg_1759402994
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 985551800451;
	Thu,  2 Oct 2025 11:03:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EA97C180047F;
	Thu,  2 Oct 2025 11:03:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Oct 2025 13:01:50 +0200 (CEST)
Date: Thu, 2 Oct 2025 13:01:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] documentation: seqlock: fix the wrong documentation
 of read_seqbegin_or_lock/need_seqretry
Message-ID: <20251002110145.GB32506@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162029.GA3121@redhat.com>
 <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b83e9c1d-2623-4abf-8c63-1110a0b92d2e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Waiman,

This is probably my fault, but I can't understand your emails. So let me start
from the very beginning and write another reply to this email.

I don't think that we can change include/linux/seqlock.h so that this change
will make the documentation correct without changing/breaking the existing code.
But perhaps I misunderstood you...

And just in case... of course need_seqretry_xxx() and/or XXX() must be renamed.

On 10/01, Waiman Long wrote:
>
> On 9/28/25 12:20 PM, Oleg Nesterov wrote:
> >-	int seq = 0;
> >+	int seq = 1;
> >  	do {
> >+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
> >  		read_seqbegin_or_lock(&foo_seqlock, &seq);
> >  		/* ... [[read-side critical section]] ... */
>
> It is kind of odd to initialize the sequence to 1 and add an sequence
> increment inside the loop.

Sure. That is why I am proposing the new helper which can be used instead
need_seqretry(). You named it need_seqretry_once() below.

Now, from Documentation/locking/seqlock.rst before this patch:

	/* marker; even initialization */
	int seq = 0;
	do {
		read_seqbegin_or_lock(&foo_seqlock, &seq);

		/* ... [[read-side critical section]] ... */

	} while (need_seqretry(&foo_seqlock, seq));
	done_seqretry(&foo_seqlock, seq);

> Perhaps we can do something like:
>
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1126,6 +1126,9 @@ read_sequnlock_excl_irqrestore(seqlock_t *sl, unsigned
> long flags)
>   */
>  static inline void read_seqbegin_or_lock(seqlock_t *lock, int *seq)
>  {
> +       if (!(*seq & 1))        /* Reread sequence # if even */
> +               *seq = seqprop_sequence(&lock->seqcount);
> +

Why? I don't understand this change...

> +static inline int need_seqretry_once(seqlock_t *lock, int *seq)
> +{
> +       int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> +
> +       if (ret)
> +               *seq = 1;       /* Enforce locking in next iteration */
> +       return ret;
> +}
>
> With this, the current document should be good.

No? How can this change make the pseudo code above correct? It will never
take the lock. OK, unless CONFIG_PREEMPT_RT=y but this is another story.
And the documentation is still wrong in this respect.

> Users have the option of
> using need_seqretry_once() to enforce at most 1 iteration.

So we need to change the pseudo code above

	-	} while (need_seqretry(&foo_seqlock, seq));
	+	} while (need_seqretry_once(&foo_seqlock, &seq));

and this is exactly what I am trying to suggest in "RFC 2/1".

So I think we should fix the docs, and the new helper(s), and update the
current users one-by-one.

Oleg.


