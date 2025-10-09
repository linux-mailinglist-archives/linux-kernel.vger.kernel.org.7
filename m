Return-Path: <linux-kernel+bounces-846968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E871BBC98CF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11CD3A574C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9B2D374F;
	Thu,  9 Oct 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnHm3NGW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CC1E47A3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020762; cv=none; b=coSyIS5zV75/WD1ZBDH+7LpXsuMLMyt6NXgOc8ATFdP4SpacGjoeggkaaw2+6gVTlI4IUCe1zz4Rp3wnf1orMY27SCfUwN17Pm97sqG+SV/GY31Is9G88CzzVY6YlbPy3M5EG8RojSoudNUru4P0Hqm+gFLL55QbairjEzqFqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020762; c=relaxed/simple;
	bh=j93VkEC5y+j4DrXUTnVPQHWqW1fdd5T1XGijsRlHJEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXNa0KTF/zh7nn/MzAt9uIy9SvyKaRHKN05RPc8qBIoUeeuSyFk8YaHSwWmSvr1PB3agL/Y6zeyv4dDU/h8x7AMOLdDjwLuB2KG/AHQCuWPcr4zM88jtnxNyR/n6cCIaxD2bQbYoV+TRsMTyt7owBP7UjYG5q+u5Frp4pRqD6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnHm3NGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760020760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knbG7CN/zSrmeXUiLurkTiRiRI7XemaD20mgY1wNrHI=;
	b=UnHm3NGW0FMb44ZkNxFUmIV5h5GpJ15bZb43D9923KUz7A5hqfECyDE3L4j2dQAckvhiFl
	fg8x5liVz+uN83CdA7KJZKHC6LdsPrUv7Eo7IX1Kcbu41gHHaPoQNTSdYHJxA0jLeU8U8f
	/GyH38F2tWmzbGyibzRvKJDDSSwSLUM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-egfYjIPEMbK6ZxbLKno0wg-1; Thu,
 09 Oct 2025 10:39:17 -0400
X-MC-Unique: egfYjIPEMbK6ZxbLKno0wg-1
X-Mimecast-MFC-AGG-ID: egfYjIPEMbK6ZxbLKno0wg_1760020755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 442D519560AF;
	Thu,  9 Oct 2025 14:39:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2C10330001B7;
	Thu,  9 Oct 2025 14:39:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  9 Oct 2025 16:37:54 +0200 (CEST)
Date: Thu, 9 Oct 2025 16:37:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251009143748.GA2704@redhat.com>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/09, Linus Torvalds wrote:
>
> I'm batting zero. I still think it's true that this logic should be
> handled by the for-loop, but the *seq=1" hackery did actually do
> something.

Yes...

> But I think it means that "lockless" would have to be a "phase", and go 0/1/2.

OK, I like your version more than mine. In particular, the fact that it
puts seq/flags into the unsigned long data "union", somehow I didn't think
about this option. Plus, yes, it removes the "make/check seq is odd". Nice.

But do we really want to unroll the loop? This code should be optimized
for the likely case when the lockless pass succeeds.

Let me think a bit more before I send V3...


> #define __scoped_seqlock_read(lock, s, cond) \
> 	unrolled_full for (struct { unsigned long phase, data; } s = { 0 }; \
> 		s.phase < 3 && cond(lock, s.phase, &s.data); s.phase++)

I guess in your version "struct" doesn't buy too much, just saves one
__UNIQUE_ID(). But this is a matter of taste.

Thanks!

Oleg.


