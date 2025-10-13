Return-Path: <linux-kernel+bounces-850450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C393BD2D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C7364EF198
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51ED2571DC;
	Mon, 13 Oct 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfBawpga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA719CCFC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356223; cv=none; b=JtjwmZgj+ld73vZAcmTVH+Ao6j+oyKcBmmsOYJN1TyhwhLho3lamWWnCapOHrmzUGSpuMK3oa5Hu5tqV/PXhZdB1pIkr3ScSTwm4V3NFmFfH+V2qMdx1XXmTbGxmKpVIonNLWC2dOPclXRRYbMx2lQXP9QWN84KJc993rqBFUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356223; c=relaxed/simple;
	bh=1uvQYJmL9QKe76KL2BW9+4/bK8gl99vHijqXPMD9QyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obrRctV2EvHvdnZdROUhxltqsuY6wx7y0ZBYpq1862ssFohnLH2HiDVd1gdy/cCVz/vB7KCwmev6kBRA82SyXPIdkIMGoCVtpACqM4dqigtIAp2SGyDWqC/MJk/2NsbVO2W2jA0oEX/+R/FHvIylcuNzMcCsTCtzlOVAIi3LRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfBawpga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760356220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qJXFC0o+1CaVi4fOfDbU8jsuMwjGsE39HDlFOYkUqXI=;
	b=dfBawpgacDOgt3nl+GkwePx279jEw+c2HMYxaIUCi3x1qZhtA/kopI8qRrK2Leuhh/I3PF
	ZEEPPNVin9qGjTe+XEWyXzUZ9321FFp1pH+/+UQNCSl2ziI7V9Ph9/V893mngGG8uqlCj5
	I671nUkYyJf9gMf54YLCID/by8/BFWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-_Ay75PvOOUKe6IQLG9kgKQ-1; Mon,
 13 Oct 2025 07:50:19 -0400
X-MC-Unique: _Ay75PvOOUKe6IQLG9kgKQ-1
X-Mimecast-MFC-AGG-ID: _Ay75PvOOUKe6IQLG9kgKQ_1760356217
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 367E81956087;
	Mon, 13 Oct 2025 11:50:17 +0000 (UTC)
Received: from fedora (unknown [10.45.226.135])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0012230002CE;
	Mon, 13 Oct 2025 11:50:12 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 13 Oct 2025 13:50:16 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:50:11 +0200
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
Message-ID: <aOznWZGV9qyGWoE5@redhat.com>
References: <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
 <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
 <20251010122347.GA8798@redhat.com>
 <20251010131439.GB8798@redhat.com>
 <20251013090313.GI4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013090313.GI4067720@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/13, Peter Zijlstra wrote:
>
> On Fri, Oct 10, 2025 at 03:14:39PM +0200, Oleg Nesterov wrote:
> > 	static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
> > 	{
> > 		if (sst->state & ss_lock)
> > 			spin_unlock(&sst->lock.lock);
> > 		if (sst->state & ss_lock_irqsave)
> > 			spin_unlock_irqrestore(&sst->lock.lock, sst->data);
> > 	}
> > 
> > 	static inline void
> > 	__scoped_seqlock_next(struct ss_tmp *sst, enum ss_state target)
> > 	{
> > 		switch (sst->state) {
> > 		case ss_lock:
> > 		case ss_lock_irqsave:
> > 			sst->state |= ss_done;
> 
> So GCC is clever enough to see through this scheme, but Clang gets
> confused and generates worse code. Specifically it emits the whole
> __scoped_seqlock_cleanup() sequence, testing both bits and both unlock
> options.

OK, thanks and sorry for the noise then.

> So while that additional pointer might seem wasteful, it actually makes
> the state tracking easier and allows the compiler to more easily throw
> away stuff.

Great ;)

Oleg.


