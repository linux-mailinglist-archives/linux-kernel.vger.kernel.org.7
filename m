Return-Path: <linux-kernel+bounces-838835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB5BB03EA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A230C2A378D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6E2E3715;
	Wed,  1 Oct 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va9GHM3/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143317B50A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319594; cv=none; b=Fcd4pdtd179FEHubIkXfV9vkgZGMpJeRBwnzGVZInJeXyX8iNU2IJnUbDPmQqBZkaUxNVcBl1mNyP1XcCttH2/7aIq+Z4UkBBv5yW1nrvzovryondw9REQaT6Fy5HSysI/wACtFqq/pxrtJ/vWhXPbO75vuSJQlBP9/0yH6/0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319594; c=relaxed/simple;
	bh=zOEhEaVbrsV+VZaz9MKzw2dmvYnJV2Wg7J5DGSElUhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9W/GfzKKVhDfE8WHx3rJpxZeFoO90BVmnrRlQehNCXBbV5GB2uLbkRsVRoj/qYzY+Pld+ORXWrl9WsikpS6jWvBeCnESM3ZabapHGHsq7kueBKv79jNUhSbNnOwB27OhxkrQnyXihOUKr5/VeukLUo8xHzM/zDDv6kiGEVEgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va9GHM3/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759319591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/7GAhYGm31KCSY5ybQRZYTB2MfyQi28cKiBy8ZqQl0=;
	b=Va9GHM3/XYuFHT3R9xSF7NcIryUzeTCXrKscQHqIGden807tDZVj0oB9x/gSyv/OF8lfbc
	mKk8pW+oOiU0DhYgLIr25Zy8ZweLVqinLLWwi1QfuepKuvmeE/WgamAPwz8ZQS60go+F8b
	RoPsKfPhCPRfAcu2NTcN9I/IhwNn8uE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-NXi7DfNgP2q6iVeeiIXVCg-1; Wed,
 01 Oct 2025 07:53:07 -0400
X-MC-Unique: NXi7DfNgP2q6iVeeiIXVCg-1
X-Mimecast-MFC-AGG-ID: NXi7DfNgP2q6iVeeiIXVCg_1759319586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E4A195608A;
	Wed,  1 Oct 2025 11:53:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EB6CA30002C5;
	Wed,  1 Oct 2025 11:53:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Oct 2025 13:51:43 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:51:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more
 simple and less error-prone ?
Message-ID: <20251001115137.GB20441@redhat.com>
References: <20250928162054.GB3121@redhat.com>
 <20250928161953.GA3112@redhat.com>
 <2060588.1759270166@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2060588.1759270166@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/30, David Howells wrote:
>
> It would also be nice to fix the static lock-balance detection stuff that you
> get when you enable advanced checking during a kernel build.  It doesn't
> seem to understand seqlocks.
>
> > 	-	nextseq = 0;
> > 	+	seq = 0;
>
> Perhaps an init function or macro that hides this bit?
>
> 	void init_read_seqlock(int *seq)
> 	{
> 		*seq = 0;
> 	}
>
> 	init_read_seqlock(&seq);
>
> or:
>
> 	#define INIT_READ_SEQBEGIN 0
>
> 	seq = INIT_READ_SEQBEGIN;

Agreed,

> Though if we can fold the whole loop inside a macro, that might make it easier
> to use.

Yes...

> d_walk() in fs/dcache.c might give you issues, though.

Yes. But note that it can use need_seqretry_xxx() too, see the patch below.

So. Do you think it makes any sense to add the new helper for the start?
Can you suggest a better name? Say, check_restart() ?

Oleg.

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1355,7 +1355,7 @@ static void d_walk(struct dentry *parent, void *data,
 		spin_lock(&this_parent->d_lock);
 
 		/* might go back up the wrong parent if we have had a rename. */
-		if (need_seqretry(&rename_lock, seq))
+		if (need_seqretry_xxx(&rename_lock, &seq))
 			goto rename_retry;
 		/* go into the first sibling still alive */
 		hlist_for_each_entry_continue(dentry, d_sib) {
@@ -1366,7 +1366,7 @@ static void d_walk(struct dentry *parent, void *data,
 		}
 		goto ascend;
 	}
-	if (need_seqretry(&rename_lock, seq))
+	if (need_seqretry_xxx(&rename_lock, &seq))
 		goto rename_retry;
 	rcu_read_unlock();
 
@@ -1378,11 +1378,8 @@ static void d_walk(struct dentry *parent, void *data,
 rename_retry:
 	spin_unlock(&this_parent->d_lock);
 	rcu_read_unlock();
-	BUG_ON(seq & 1);
-	if (!retry)
-		return;
-	seq = 1;
-	goto again;
+	if (retry)
+		goto again;
 }
 
 struct check_mount {


