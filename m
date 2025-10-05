Return-Path: <linux-kernel+bounces-842377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CBEBB9A40
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A44C634617E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445641AB6F1;
	Sun,  5 Oct 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/eOmwwW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F912FF6F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759686107; cv=none; b=j9WcUJhv31xH6Y/qfEmy8mDWyTs14Av3c8RFXyHFOj8LZuXbLmay+Stguj5IiK6aGLYYIArezpcZL6OQWlVpupm+08xRKGz7A0ZHeKKsTU3lwaIAkgBknv9WEMQPNyl3qmi5Kmd2sx+MOwWJQ1ZcVGalMvFtE7z3bQBNyYB6hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759686107; c=relaxed/simple;
	bh=TXFd7/3FqnHWELv/Ea6uDVP94OHBKV/Ebdx8I7W/T4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2zcwD4pIiXcNjocWqUGJr2U51j8eRrKP5KdpRH17YDd9uxO1HkiF0Mac3+Xmbl2r5RhHD6QHyYdYRV9QyP8kPw7MDqyvJLRB1IYN3j2ln6+KKeDCjvbwEyI4hepoMF94sDa1q2uPd1CtY6LrLJWXFH46qgnmGhH457gx4ad8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/eOmwwW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759686104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F0S1vPSRJ5NnfHBNzwpj/3+V8U0XpDMUFkziRa/whMs=;
	b=i/eOmwwWdeEpu5xk/YjouU48ukNSQ/mA0BmK749fSEte3fC0GcLBExvyHFLbLc1azEEw6P
	BVn5kDe9cHlW26j4glggq+Vl7+g4xjj89IqAjs8G5JJSmQniPusG6uvVmukZknFaJZwJ8R
	yj2jU95zkJN/2mCYHHl4UGXU7OKS0ps=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-4pgTW0HvMEWQvPQThhQCIg-1; Sun,
 05 Oct 2025 13:41:39 -0400
X-MC-Unique: 4pgTW0HvMEWQvPQThhQCIg-1
X-Mimecast-MFC-AGG-ID: 4pgTW0HvMEWQvPQThhQCIg_1759686098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BF7618004D8;
	Sun,  5 Oct 2025 17:41:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9BFD11800452;
	Sun,  5 Oct 2025 17:41:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 19:40:16 +0200 (CEST)
Date: Sun, 5 Oct 2025 19:40:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] seqlock: introduce SEQLOCK_READ_SECTION()
Message-ID: <20251005174010.GC6063@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20251005144929.GB1188@redhat.com>
 <20251005153008.GF2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005153008.GF2441659@ZenIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/05, Al Viro wrote:
>
> On Sun, Oct 05, 2025 at 04:49:29PM +0200, Oleg Nesterov wrote:
>
> > 	static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
> > 	{
> > 		const struct dentry *dentry;
> > 		struct prepend_buffer b;
> >
> > 		rcu_read_lock();
> > 		__SEQLOCK_READ_SECTION(&rename_lock, lockless, seq, NULL) {
> > 			dentry = d;
> > 			b = *p;
> > 			while (!IS_ROOT(dentry)) {
> > 				const struct dentry *parent = dentry->d_parent;
> >
> > 				prefetch(parent);
> > 				if (!prepend_name(&b, &dentry->d_name))
> > 					break;
> > 				dentry = parent;
> > 			}
> > 			if (lockless)
> > 				rcu_read_unlock();
>
> <cringe>

Weird or buggy?

> prepend_path() would be interesting to look at...

Yeah, I have already looked at it.

Not sure yet what the "good" cleanup could do. Will think about it more.

Oleg.


