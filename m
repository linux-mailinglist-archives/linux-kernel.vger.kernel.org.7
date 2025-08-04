Return-Path: <linux-kernel+bounces-755149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1248B1A229
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F5B7A6B17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3BC259C9A;
	Mon,  4 Aug 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvqK6dn6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6F2594B7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311525; cv=none; b=foWTH49MhUTVfrC/MzDihNHJaFIqBJkmLYzAIta9Uo+jBpZazR/yPnmkRRsmBzFUVq97Vf8qy8U5SDOTMI1nYGCm6N8/foJKLXw+RuxZpN4w7RMmmYj9QH5gBRIO6aqG6QAC12xSS/SBy+D7HfUL0KMyKCStNHNuoQ1bipgtbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311525; c=relaxed/simple;
	bh=fFFRXvrQS99x9piN15hBZwVac3q0r2uq+eumv9Fwzug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtBU0XZfuA4taSJyysPMgJnwk5UO+ABeToa8ktwIq2D/vrYlFLaHFM/2/eASLUyYOtmhgbWOKX8s3svREdrpdM/hYdILeWqZCuM7z+T+72tNWrxd4d1ztCR10FUZE887byBhlYMPXQUJRR9rfDh8WGVDUoB9QGg8Fa9sAUuyq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvqK6dn6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754311522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5zoYjV26dHCOzWmge3eqxmfxwSQEDZekz7GE288a+GQ=;
	b=GvqK6dn6UgNP8SmcIsahGdFNif8togCIyUmfVbhqzNyC3errQ3ytB2eMEUE2qJ2PWvRZ+D
	ySEs41D++hDkjUmazyIuGzrGv2aJqpbLSArV4vxE6UI7rWz7NTbAR4SsSIVtgm12k3ATOl
	e8ObBr+6KgGU9LI5tUzwWZp3IOKuIrc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-bFTRUP02PPC494s7pAUhwA-1; Mon,
 04 Aug 2025 08:45:20 -0400
X-MC-Unique: bFTRUP02PPC494s7pAUhwA-1
X-Mimecast-MFC-AGG-ID: bFTRUP02PPC494s7pAUhwA_1754311519
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FFBA1956046;
	Mon,  4 Aug 2025 12:45:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1466A180035E;
	Mon,  4 Aug 2025 12:45:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  4 Aug 2025 14:44:07 +0200 (CEST)
Date: Mon, 4 Aug 2025 14:44:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Xiang Gao <gxxa03070307@gmail.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250804124402.GB6656@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-gepfercht-delfin-0172b1ee9556@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/04, Christian Brauner wrote:
>
> On Mon, Aug 04, 2025 at 01:49:01PM +0200, Oleg Nesterov wrote:
> >
> > You need something like
> >
> > 	info->pid = info->ppid = 0;
> >
> > 	rcu_read_lock();
> > 	if (pid_alive(tsk)) {
> > 		info->pid = task_pid_vnr(tsk);
> > 		info->ppid = task_tgid_vnr(tsk->real_parent);
> > 	}
> > 	rcu_read_unlock();
>
> I distinctly remember having seen a similar patch about 5 years ago that
> did the exact same fix for some out-of-tree abuse:
> 20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal
>
> Where in the kernel is that code supposed to live? Is this again an
> out-of-tree module?

I don't know.

But. I need to re-check, but I just realized that pid_alive() can't
really help, tsk->thread_pid is not stable even if tsk == current.

This means that, say, task_ppid_nr_ns() is buggy.

I'll return to this tomorrow.

Oleg.


