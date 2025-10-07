Return-Path: <linux-kernel+bounces-844568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9472BC23D6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1EF19A3841
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838122E8B95;
	Tue,  7 Oct 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrjbR7Eb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07912209F43
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857584; cv=none; b=P4ZFHwLuapkX0kQvZ++m9r9jN0XYIsLUfO5YfbeRe4g71CB06dxBffqBs9T5tvaShrOj7meaOhy2QOnvI9I3QTZjTAi1Tv9/E/s/t/uay+iAqwm56gE+FoNGnQBZoqkjOaB8bjLZ85g7jcKKe4VgzQ+BT/q3LARx1MPjDbKpet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857584; c=relaxed/simple;
	bh=04gTbKgCSHKZd3aBKRMj417uPit6Bz6/wDOB3rF1/jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D27k+zSxES3D0x+LntF9e8JNmwCu5smPNRkDn63uETeOICYBy/57e3cEYISogM8F/owiojvPMezv8MjbQgZ/VUdBrRkjeC8HVV8mEwfiqca1vx/VqrKvQxpBm3W3lgawwSgB87U6nu6Y0OETgvPLz3inr1uOQzm+LFs5gQVmJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrjbR7Eb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759857582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwJDP7d40VHHRzU3PU/T877OPeeWj4IAykDDFZsodqQ=;
	b=DrjbR7EbkSmLtcAwMT0prcfLZnA7/P6TVBLc9gY2XdDdlRVuHUCmoWrUyOxUTVxYw0+Sbq
	svqIh/bw9VfAX6pCr7tYnL6FEOfLI4lCYeHJwwbkBLNYPnA8i9yL7MBkQjT1TpI/eEzCP6
	fGesx8HgPn5Nhyaj0GO5am7TRE0gio0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-0WsfU-pcNciFzh1vLmiJog-1; Tue,
 07 Oct 2025 13:19:39 -0400
X-MC-Unique: 0WsfU-pcNciFzh1vLmiJog-1
X-Mimecast-MFC-AGG-ID: 0WsfU-pcNciFzh1vLmiJog_1759857577
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ABA7195608D;
	Tue,  7 Oct 2025 17:19:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D5872180047F;
	Tue,  7 Oct 2025 17:19:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 19:18:16 +0200 (CEST)
Date: Tue, 7 Oct 2025 19:18:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251007171810.GC12329@redhat.com>
References: <20251007142113.GA17118@redhat.com>
 <6e804e9b-ec73-4f2d-8e1f-c187ea5eb319@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e804e9b-ec73-4f2d-8e1f-c187ea5eb319@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/07, Waiman Long wrote:
>
> On 10/7/25 10:21 AM, Oleg Nesterov wrote:
> >+
> >+/* internal helper for scoped_seqlock_read/scoped_seqlock_read_irqsave */
> >+static inline int
> >+scoped_seqlock_read_retry(seqlock_t *lock, int *seq, unsigned long *flags)
> I would suggest adding the "__" prefix to indicate that this is an internal
> helper that shouldn't be called directly.

OK, I will add "__", but I thought that "internal helper" makes it clear that
it shouldn't be called directly. Nevermind, will do.

> >+#define __scoped_seqlock_read(lock, lockless, seq)	\
> >+	for (int lockless = 1, seq = read_seqbegin(lock);		\
> >+	     lockless || scoped_seqlock_read_retry(lock, &seq, NULL);	\
> >+	     lockless = 0)
>
> I like Linus' suggestion of putting lockless and seq into a struct to make
> it more consistent with __scoped_seqlock_read_irqsave().

Again, will do. See my reply to Linus.

> >+/**
> >+ * scoped_seqlock_read_irqsave(lock) - same as scoped_seqlock_read() but
> >+ *                                     disables irqs on a locking pass
> >+ * @lock: pointer to the seqlock_t protecting the data
> Maybe we should we should add a comment saying that this API is similar to
> scoped_seqlock_read() but with irqs disabled.

Hmm... This is what the comment above tries to say... Do you think it can
be improved?

Oleg.


