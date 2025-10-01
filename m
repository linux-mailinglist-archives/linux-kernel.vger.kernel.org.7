Return-Path: <linux-kernel+bounces-838980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 676CCBB08FA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC551946822
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFA2FC875;
	Wed,  1 Oct 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZJq028j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD02FC03B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326487; cv=none; b=Dj/g2Xh98bNIEIjgXGjbJf5ClrLZYmpEh+MoDQYZd7wRqpsXsjD7djNLUwRUR/ObekxqkLcl0AYDPCoYjTWp+hH4mOssN7CcnzknFCRHOzMps2BWcu7WhUm48/xIyYBIoHcp+b4yw2pXH+lM3qs0OT0n8wrNXeP8T2oSTK1+Lb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326487; c=relaxed/simple;
	bh=J/nuUOVxYpb0UrodtpB0XFv0pqteiAFX48PMz/vtXCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8zC0IMqESPV2i37mE22W8v9ghMOLqUxjDTfBTMPHkEoboYkA3qsuO9p+24CrZ+eU4E0iNH5+LbpF2KPecqPokOagHBs6qhI3vBTQWd1siALxLpXXoNB0hPB8jsns4Q+QHNDKALbiUCD4lpXommaT1sg2ItwFd5yjWU0Oqvt9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZJq028j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759326484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFdM8xTsM4J75ZeEtzgFOpoEzk4JYjTkj4EMEmMP5+8=;
	b=cZJq028jwVtIkiQ8nJYMNiJW4U/0GX7xqz0fkMYqag8/5T+vEtGY1/ADhVmla9mQJmkA/j
	NNjRqr/D+cdMVFL7Nr3XXGTYmrWAVgL6r3sFD6xVlU3Yp8D6CJPJbZ4tFYnplaycpE8Scd
	KPc8mg9qF8zHCyXhhKelOXNGjX+xV7M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-0wd1dkDsMpaY69hXk98jXA-1; Wed,
 01 Oct 2025 09:48:01 -0400
X-MC-Unique: 0wd1dkDsMpaY69hXk98jXA-1
X-Mimecast-MFC-AGG-ID: 0wd1dkDsMpaY69hXk98jXA_1759326478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2896D1956059;
	Wed,  1 Oct 2025 13:47:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 94B5A1800452;
	Wed,  1 Oct 2025 13:47:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  1 Oct 2025 15:46:36 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:46:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more
 simple and less error-prone ?
Message-ID: <20251001134628.GD20441@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
 <20251001130229.GO3245006@noisy.programming.kicks-ass.net>
 <20251001131337.GC20441@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001131337.GC20441@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 10/01, Oleg Nesterov wrote:
>
> +static inline int xxx(seqlock_t *lock, int lockless, int *seq, unsigned long *flags)
> +{
> +	if (lockless) {
> +		*seq = read_seqbegin(lock);
> +		return 1;
> +	} else if (*seq & 1) {
> +		if (flags)
> +			read_sequnlock_excl_irqrestore(lock, *flags);
> +		else
> +			read_sequnlock_excl(lock);
> +		return 0;
> +	} else if (read_seqretry(lock, *seq)) {
> +		if (flags)
> +			read_seqlock_excl_irqsave(lock, *flags);
> +		else
> +			read_seqlock_excl(lock);
> +		*seq = 1;
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +#define __XXX(lock, lockless, seq, flags)	\
> +	for (int lockless = 1, seq; xxx(lock, lockless, &seq, flags); lockless = 0)
> +
> +#define XXX(lock, flags)	\
> +	__XXX(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)

Note that __XXX() can have users too. See the patch below. Not that it makes a
lot of sense, just for example.

Oleg.


diff --git a/fs/d_path.c b/fs/d_path.c
index bb365511066b..b4cde188be4f 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -332,28 +332,23 @@ static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
 {
 	const struct dentry *dentry;
 	struct prepend_buffer b;
-	int seq = 0;
 
 	rcu_read_lock();
-restart:
-	dentry = d;
-	b = *p;
-	read_seqbegin_or_lock(&rename_lock, &seq);
-	while (!IS_ROOT(dentry)) {
-		const struct dentry *parent = dentry->d_parent;
+	__XXX(&rename_lock, lockless, seq, NULL) {
+		dentry = d;
+		b = *p;
+		while (!IS_ROOT(dentry)) {
+			const struct dentry *parent = dentry->d_parent;
 
-		prefetch(parent);
-		if (!prepend_name(&b, &dentry->d_name))
-			break;
-		dentry = parent;
-	}
-	if (!(seq & 1))
-		rcu_read_unlock();
-	if (need_seqretry(&rename_lock, seq)) {
-		seq = 1;
-		goto restart;
+			prefetch(parent);
+			if (!prepend_name(&b, &dentry->d_name))
+				break;
+			dentry = parent;
+		}
+		if (lockless)
+			rcu_read_unlock();
 	}
-	done_seqretry(&rename_lock, seq);
+
 	if (b.len == p->len)
 		prepend_char(&b, '/');
 	return extract_string(&b);


