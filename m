Return-Path: <linux-kernel+bounces-842335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3944ABB988E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B29933464AF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272282874E0;
	Sun,  5 Oct 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSTSqxSj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D931F936
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675871; cv=none; b=N8Ku89JWD+p5qTaerP9AnNRjB52PFKLAzNGQ16aFzUNu8H0Z6pxuJ5H8Vy30sRUnxGYV9QUx4biT89Uhs6ZyqhPWS0d5DwgRgkc0SsGiShrYiDE9E1YpiTAIiJw1EQPdNJh4V7OfJeH1r1V/4mkNqt4jUeGn4lvzGvOWh5tXC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675871; c=relaxed/simple;
	bh=sJoMvAO/VdeBbQOVDl5SJHrJ1YL/1r9w2VgHIkPAjBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R45ovaNj7ezQGKbWw6R6WRO1pLUdvBpHVgRi3tQeIR5Z+BNHrpr187GlW5B4UKp16lf5LwMBF/++B13gbXXktzuELQcs5muHhx6LrTUEGaqtI6MMdyI4zzN/0tG6cMUlxiZ7ft28AU2LfQQOMIWeOsbkPg3JzeseggKw29nNMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSTSqxSj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759675863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKRWNImlooZ1Fo3Wa8tFOs52ibHxagit0G6SvS/nTUg=;
	b=aSTSqxSjMaUTbFNvZ5qMKt5S2ZLHrrToUTc/XL08NgevXw/SoBoHVtUn5oNcQqYIQcAMB1
	gZdCXFVUXDEeVtijHmTIKr3j8vlOXaHXtRfWNc6cSwc2yXa0k0ArNkjJWV/6dLIeAOewDY
	IukMUCQt1ba1ecPH1htf9xc9pEC/qsI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-ht8YsQa2NsWncCpZ06mG0Q-1; Sun,
 05 Oct 2025 10:50:59 -0400
X-MC-Unique: ht8YsQa2NsWncCpZ06mG0Q-1
X-Mimecast-MFC-AGG-ID: ht8YsQa2NsWncCpZ06mG0Q_1759675858
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 175DD19560AA;
	Sun,  5 Oct 2025 14:50:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8208419560A2;
	Sun,  5 Oct 2025 14:50:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 16:49:36 +0200 (CEST)
Date: Sun, 5 Oct 2025 16:49:29 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] seqlock: introduce SEQLOCK_READ_SECTION()
Message-ID: <20251005144929.GB1188@redhat.com>
References: <20250928161953.GA3112@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928161953.GA3112@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

OK, let me name it SEQLOCK_READ_SECTION().

Al, could you look at 5/5? Please nack it if you think it makes no sense
or wrong. I abused __dentry_path() to add another example. To simplify the
review, this is how it looks after the patch:

	static char *__dentry_path(const struct dentry *d, struct prepend_buffer *p)
	{
		const struct dentry *dentry;
		struct prepend_buffer b;

		rcu_read_lock();
		__SEQLOCK_READ_SECTION(&rename_lock, lockless, seq, NULL) {
			dentry = d;
			b = *p;
			while (!IS_ROOT(dentry)) {
				const struct dentry *parent = dentry->d_parent;

				prefetch(parent);
				if (!prepend_name(&b, &dentry->d_name))
					break;
				dentry = parent;
			}
			if (lockless)
				rcu_read_unlock();
		}

		if (b.len == p->len)
			prepend_char(&b, '/');
		return extract_string(&b);
	}


TODO: add another trivial helper

	static inline int need_seqretry_or_lock(seqlock_t *lock, int *seq)
	{
		int ret = !(*seq & 1) && read_seqretry(lock, *seq);

		if (ret)
			*seq = 1; /* make this counter odd */

		return ret;
	}

which can be used when the read section is more complex. Say, d_walk().

Oleg.
---

 fs/d_path.c             | 31 +++++++++++++------------------
 fs/proc/array.c         |  9 ++-------
 fs/proc/base.c          |  9 ++-------
 include/linux/seqlock.h | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/cputime.c  | 14 +++-----------
 5 files changed, 69 insertions(+), 43 deletions(-)


