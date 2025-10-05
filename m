Return-Path: <linux-kernel+bounces-842361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D81BB9948
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F923ACC94
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B22727F5;
	Sun,  5 Oct 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieWBUZ/u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3A34BA39
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680569; cv=none; b=r5kOVYMQ3Dks0ADAe3iGPldbk48i07Vc5DmR8K6Zus47hYdECiupR8dMCpAjya18319Ef4oyKR9w9Ybw5lGlwq/TKjXkHdqpiQG7LsOz0zyO3de+VQi0dJ2en/qWlZTLPy0O4ap4+vylQ2X0WiLN1PCuFiJTotyqnncRN3JjdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680569; c=relaxed/simple;
	bh=bSpQItiEKJn4hBxJVSxte9sVOvdSXJvVol3zUwxuWuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkYNSJaXQOvlKpbKa1d02cK6DmM4J5JIsKZWf9AOvKu1W8BkNvG+FEjwp/VMVDoXymXhj63MM+RX4JDHZPwpnBeLET6I9nS2Bjc6Lbn7lc5LbT4Tp8K7hqEqyP6R1hb452zI7XOYjUv0XTce73qlHeGNpEurJKeirkB8JTtoa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieWBUZ/u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759680566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FnA8nxMv6AsRyDI6YfkVtN4D7KvSzea/c4016HywNE=;
	b=ieWBUZ/uAV59xOH6HUCXZ7KavFZsxySLu7DH2JPvBuHtyUiLw7ssusPsy6JFq6kUe5bi9o
	QzBGZA/pcV7ECv2MOWMej/fVyL4z3fPmwKEBe/j96vEPWyTI+s7+VGnJTjyrFrZOIgwpe/
	UC1eVqY/BeFuaTeo970N7fxZu+ttWkY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-ygcATBIMO7u_XLJ4aoshYA-1; Sun,
 05 Oct 2025 12:09:22 -0400
X-MC-Unique: ygcATBIMO7u_XLJ4aoshYA-1
X-Mimecast-MFC-AGG-ID: ygcATBIMO7u_XLJ4aoshYA_1759680561
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F023180035C;
	Sun,  5 Oct 2025 16:09:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C4AB4300018D;
	Sun,  5 Oct 2025 16:09:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 18:08:00 +0200 (CEST)
Date: Sun, 5 Oct 2025 18:07:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: introduce SEQLOCK_READ_SECTION()
Message-ID: <20251005160753.GA6063@redhat.com>
References: <20251005144929.GB1188@redhat.com>
 <20251005145016.GA1254@redhat.com>
 <CAHk-=wjPvwcRwqNmvuZ=jNFyX9g8kO=ECN4u=shHiBknNuTZcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjPvwcRwqNmvuZ=jNFyX9g8kO=ECN4u=shHiBknNuTZcA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

OK. I'll send v2 but let me ask...

On 10/05, Linus Torvalds wrote:
>
> As far as the users are concerned, the result doesn't end up being
> really any different from our scoped guards, so I'd actually suggest
> you just make this helper look like our scoped_guard() macro does.

I swear, I too thought about scoped_seqlock_xxx ;)

> And instead of making people pass in a NULL 'flags', just do a
> separate version of it, exactly like we do for locking. Even if the
> internal implementation then ends up sharing most of the code, please
> don't make people pass in NULL just because they don't want the
> irqsave version.
>
> So make it two different things:
>
>    scoped_seqlock_read(lock) { .... }
>
>    scoped_seqlock__read_irqsave(lock, flags) { ... }

OK. But if you don't object I'd like to avoid another DEFINE_LOCK_GUARD()
or something like it in this case. To me it won't buy anything.

And I think that the "generic" seqlock_read_section_retry(flags) makes
sense, the "if (flags)" checks should not generate the extra code.

Will you agree?

> (Maybe 'flags' can even be local to that scope?)

The problem is that you can't declare "int lockless/seq" and
"unsigned long flags" inside "for (...)",  but I'll try to think about
it more.

Oleg.


