Return-Path: <linux-kernel+bounces-845420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034BBC4CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FACB19E2274
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3E1E47A5;
	Wed,  8 Oct 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKcoskn3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45823ED5E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926706; cv=none; b=NUtTno+edKE+oQfRVUAsSUmVVaJ0bBJZ+KaHap/Suo2hp6rZBGuJve9u4xzr58mi4wT/zokrAyqw0QoqG2nnCFHCFar/GPXqyAeOHRS7SfG/ypaQWmXxiHP2UGtAFRd82w40wcXWu5hx+/iF3vgpTVHA6LmEbm3EMLrt2NGkAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926706; c=relaxed/simple;
	bh=bEgUHXoa1WYuuLNIfLs48QBGJsE8OY0lu57FvjnM+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfvhU/8dULrJhwfQ4gfI1gkQjn0cdxX5ahWbRPH20BlgqoRyqNFufYFiFMbIMh1ne5ry6IhSq7t3P8aMTa3bvw+ruCuR8EXROMHffQupMcy5gsY8Gt7/al5X19iAE/uGUfTGfvzVDtFcHaHUiPIuRbXkh9Q5SkkDKRBrs/qJzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKcoskn3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759926703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkeBMAKL7xNpbsdS6OFeoBOsIrdHtmtb3LVYivTTxAk=;
	b=YKcoskn3uwSXMFKlPMITaDCEQAI5poZnuLsrqJJdHSThFfkrFmMiZHse5vyau5ruyvg332
	Tu77VeKad+TkkyDc2IF//6wnnso04pstXNJL4+GBt2pHDmmt9zB1JYcegVgU3J3BcekV5M
	32Rm59k/pf543/FfWPNHLgsdWN/8LqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-CblNqUHIM1aAz0hM5Jg4WQ-1; Wed,
 08 Oct 2025 08:31:42 -0400
X-MC-Unique: CblNqUHIM1aAz0hM5Jg4WQ-1
X-Mimecast-MFC-AGG-ID: CblNqUHIM1aAz0hM5Jg4WQ_1759926701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA8F218002C3;
	Wed,  8 Oct 2025 12:31:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B4E6C1800452;
	Wed,  8 Oct 2025 12:31:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:30:20 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:30:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008123014.GA20413@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Only 1/4 was changed according to comments from Linus and Waiman,
but let me resend 2-4 as well.

Oleg.

 fs/proc/array.c         |  9 ++-----
 fs/proc/base.c          | 10 ++------
 include/linux/seqlock.h | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/cputime.c  | 15 +++---------
 4 files changed, 71 insertions(+), 27 deletions(-)


