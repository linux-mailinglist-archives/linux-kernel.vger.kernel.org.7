Return-Path: <linux-kernel+bounces-838201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FEBAEA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 00:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4023ADD71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8D2882B7;
	Tue, 30 Sep 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HmaDJ0G3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1919C540
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270178; cv=none; b=fgerLlDclzwx0su/8GVPR/o8sL6tYRemdHGgIEuD8RK2Ou0DKfqvxxeXFeigQHSKWm9QvnHroa8luHM5G8QzvVVgV3ewuqdBO4Z7mFPEvfpqgjwsGOgs1alWi02Rb4KK/gKWSn2tI783R1ebsVrmMfnnkuj/GU6kNvvLiQZKaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270178; c=relaxed/simple;
	bh=3dE6ZY8DDCWKUhCE0JZ/ajz2ahy27BhaA2XqD7WVCCk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=feJ0pBWvwrJ/jbenuNu69YkTipHHvu/UGmHWsT8M5Mju2GKv2mi5d5nTV4EJFOPvncoszYXXWMhfwqx67q3I2J1+8L7kCzx1xZzQDvu/LmDYvLC8JdDRvM4/VFd0SvI159x4JJhDLh3nzDj1hzIYd8hlDUkSNhpuq9JVqlRJE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HmaDJ0G3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759270175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2X58BHmT7cyXnDKOb1E3hEOS9ATLii9dOwb2upw4iw=;
	b=HmaDJ0G3P9ZWeTD/HLZNWN9/eq0kyf5Dz0t4QXotrMHUe/r86dQTp73FkhRR1XqXzYWrwI
	X5FeksxLOtMAEEhiePJpCK4e7FsEeyoEC5wmkWjCJ32scaMSyM82fBfKYOYnohnh2BBlhl
	LDZ5bCQdpgfxmgc5a+nz2VK29ud4rt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-4NTc-AOxPe6dYEgRUzKWGg-1; Tue,
 30 Sep 2025 18:09:32 -0400
X-MC-Unique: 4NTc-AOxPe6dYEgRUzKWGg-1
X-Mimecast-MFC-AGG-ID: 4NTc-AOxPe6dYEgRUzKWGg_1759270171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F6E619560B5;
	Tue, 30 Sep 2025 22:09:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D61C19560B4;
	Tue, 30 Sep 2025 22:09:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250928162054.GB3121@redhat.com>
References: <20250928162054.GB3121@redhat.com> <20250928161953.GA3112@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Boqun Feng <boqun.feng@gmail.com>,
    Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Peter Zijlstra <peterz@infradead.org>,
    Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more simple and less error-prone ?
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2060587.1759270166.1@warthog.procyon.org.uk>
Date: Tue, 30 Sep 2025 23:09:26 +0100
Message-ID: <2060588.1759270166@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Oleg Nesterov <oleg@redhat.com> wrote:

> 
> Can we improve this API?

It would also be nice to fix the static lock-balance detection stuff that you
get when you enable advanced checking during a kernel build.  It doesn't
seem to understand seqlocks.

> 	-	nextseq = 0;
> 	+	seq = 0;

Perhaps an init function or macro that hides this bit?

	void init_read_seqlock(int *seq)
	{
		*seq = 0;
	}

	init_read_seqlock(&seq);

or:

	#define INIT_READ_SEQBEGIN 0

	seq = INIT_READ_SEQBEGIN;

Though if we can fold the whole loop inside a macro, that might make it easier
to use.

d_walk() in fs/dcache.c might give you issues, though.

David


