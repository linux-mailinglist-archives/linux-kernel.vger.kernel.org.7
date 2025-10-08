Return-Path: <linux-kernel+bounces-845471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E1BC5141
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8239619E314F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360091E412A;
	Wed,  8 Oct 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ih0a4sfx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286E25B2E7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928437; cv=none; b=jfqVWEZko5REW54yS0WoHAtO+gN9E4joFl5bNKHN3JamguI/40Jt/8yrKLSxa34R51DzCfyZu92inVNpIQ+Wq0ypa988vm+7Tpif+5793xb3sP7i6mDxvHvSJFp/vDxsRzTs0cP3Ov459D4aX2MA4Ozozj99yz/OMSvJN64tgQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928437; c=relaxed/simple;
	bh=bXAXBisFsJW8wmT+WVxS/b4YOt8W0E8eUJOvD5cw6Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbm3TstILtBF/bCfrrDSJRWhFKv+yPhlA8WrAUCwD7Yiy+Cz8w+BWZJI6aB0X/+cgd3eRpa8e7vBpyyLnIvjSn9acfMnnU6JqbhE6btahWKbi9AZ+1SQVoNmVMMosU8Tqu+YKoxY6GccgtdhoiF+gn2XSyYyBAe7H3UjJPvap04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ih0a4sfx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759928435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VCNG0/hQ71fzjWzsa1yt3K0dE6BZi9tfln7B0h7lqvs=;
	b=ih0a4sfxllaoZWuFdCynyixKcdJFsmUlaybjaNSr5HEEo8Dg/wA/U6RS6o6eG4SbywpBXz
	2vwHEMhinXrUbDDuLR4Rj5z4oJFBs/ppo3IIkx6CkhxxNwykQtZSIZw8SYL4yyK76RoS1E
	fPhlt2sDmtAEEajGDTJQvQHwkcYgYCs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-aMwrcUrvOJGiT9Jm4xBK8g-1; Wed,
 08 Oct 2025 09:00:30 -0400
X-MC-Unique: aMwrcUrvOJGiT9Jm4xBK8g-1
X-Mimecast-MFC-AGG-ID: aMwrcUrvOJGiT9Jm4xBK8g_1759928429
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1690B19560B6;
	Wed,  8 Oct 2025 13:00:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D68F13001FF4;
	Wed,  8 Oct 2025 13:00:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:59:08 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:59:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008125902.GA23813@redhat.com>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <20251008125508.GJ3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008125508.GJ3289052@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/08, Peter Zijlstra wrote:
>
> On Wed, Oct 08, 2025 at 02:30:45PM +0200, Oleg Nesterov wrote:
> >
> > 	scoped_seqlock_read_irqsave (&seqlock) {
> > 		// read-side critical section
> > 	}
> >
>
> Hmm, on first reading I was expecting that to be:
>
> 	do {
> 		seq = read_seqbegin(&seqlock);
>
> 		// read-side section
>
> 	} while (read_seqretry(&seqlock, seq));
>
> for lack of that _or_lock() wording, but I suppose we can make that
> something like:
>
>  	scoped_seqbegin_read (&seqlock) {

I was thinking about scoped_seqcount_read() but I agree with any naming

Oleg.


