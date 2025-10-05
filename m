Return-Path: <linux-kernel+bounces-842345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0D4BB98C9
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78EC1894EDA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF91991C9;
	Sun,  5 Oct 2025 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IZNMGl71"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA9DFC0A
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678223; cv=none; b=styYom5msy5hS37872e149ZweIy0fjpXXJNemQtIVi2T3aKJHOkOO+ljiT56MdMEwidwn53tIr7rKvraRCm+y84De2IxX7dqrPkDSPXpFuG036VjGZbHMY5iAwQ7zNVybEaZxmQ9Zoh44YkXp0V/2Z2L5dGJyQxd3a6z2JD14RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678223; c=relaxed/simple;
	bh=30HIk3OxJwZWmBQtJCoUL/ss1cHXsf/x7yn+r3uYAms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqe2H8LipIwZNXJsTqLV7upLikMFdE6/S7RlJH8iiXetAhMaKE8guBp67KrdthyTb6JPou8EPgYSRo/kFkE9vBzTL2U5/CInwKxkmG6vu+brqlh68y6I7qXrCWHAzxzv0DDyUPusVYaFN5EC53O7Z6+JNz9zQmuFCuxOZPuVY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IZNMGl71; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n6qmGnJvfK9dytrVM5z8+YJgoIi4PLmLawqX3mHm/NY=; b=IZNMGl71HJVtuArPGWth51sGOI
	JTGjijugqf7uScfzr5LG3iN6QxVp6vJ8WT2ugUiN3F/05XLa9/8tlPSQtyoPKRXZhcR6B5oL+CGaA
	StTE3zbGkBsjkV0ewAvibEOb+jLGhC0PYRt84xI2PSzFVDrjPucixRNj4yMddOavlQ1OIaEkExm1Q
	i4YWLpMJrdKcAZFwcJ/GswVTqcHO2pJh1VnnNqjgXuzPXJKgEWT51AWqdxkGrAm+SHL5Vcp04rkf0
	X8CnKyabPQfO76VnhHteiN6z+AR1QpD0QILJWGjzQaLTqHfueoBqUolq2snk+mdnAVOB2kY8g4GEk
	xUUShh/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5Qga-0000000DB2P-2jLg;
	Sun, 05 Oct 2025 15:30:08 +0000
Date: Sun, 5 Oct 2025 16:30:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] seqlock: introduce SEQLOCK_READ_SECTION()
Message-ID: <20251005153008.GF2441659@ZenIV>
References: <20250928161953.GA3112@redhat.com>
 <20251005144929.GB1188@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005144929.GB1188@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 05, 2025 at 04:49:29PM +0200, Oleg Nesterov wrote:
> OK, let me name it SEQLOCK_READ_SECTION().
> 
> Al, could you look at 5/5? Please nack it if you think it makes no sense
> or wrong. I abused __dentry_path() to add another example. To simplify the
> review, this is how it looks after the patch:
> 
> 	static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
> 	{
> 		const struct dentry *dentry;
> 		struct prepend_buffer b;
> 
> 		rcu_read_lock();
> 		__SEQLOCK_READ_SECTION(&rename_lock, lockless, seq, NULL) {
> 			dentry = d;
> 			b = *p;
> 			while (!IS_ROOT(dentry)) {
> 				const struct dentry *parent = dentry->d_parent;
> 
> 				prefetch(parent);
> 				if (!prepend_name(&b, &dentry->d_name))
> 					break;
> 				dentry = parent;
> 			}
> 			if (lockless)
> 				rcu_read_unlock();

<cringe>

> 		}
> 
> 		if (b.len == p->len)
> 			prepend_char(&b, '/');
> 		return extract_string(&b);
> 	}
> 
> 
> TODO: add another trivial helper
> 
> 	static inline int need_seqretry_or_lock(seqlock_t *lock, int *seq)
> 	{
> 		int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> 
> 		if (ret)
> 			*seq = 1; /* make this counter odd */
> 
> 		return ret;
> 	}
> 
> which can be used when the read section is more complex. Say, d_walk().

prepend_path() would be interesting to look at...

