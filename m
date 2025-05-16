Return-Path: <linux-kernel+bounces-651815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77142ABA35D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3361BA2A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 19:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2427F4D6;
	Fri, 16 May 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yuw/m7s7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241EF25A626
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422222; cv=none; b=KPIs5YGCakzJpPy4kULDs/uXXKIK7b6Le5R+CkLgS6UTud5M/Oiae8WWOAmwOECGsKBlxWNw3Rmr64MhBugPXGBiIsTpM04RHYGNE13Qe4IHCDcV9UzfUeYIMopZCPnC69LrZEqyFGWxg7Y6vhWAHn7oE+O3AUFMkzgMFYIAUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422222; c=relaxed/simple;
	bh=Wk2d0x6Jja6BDe8vPt2pVFQXgWfevTDH54jv3B5FPHE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=JVlQU/Z3Bg6uIiUHQJUg9E7ZX/5NcZY7noa7et22Q80CQSfOczz30P5pkzk/5k95Bziusepq2XMZ2pgl+hicELtlWIrg7wRh/TT3qdpKTyyLTR6Rz+sAUfePACkc8XdTsG3kmTs8SAZPS5c8LomkZDX/lWTZEYUkabfKFDoUa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yuw/m7s7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747422220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wk2d0x6Jja6BDe8vPt2pVFQXgWfevTDH54jv3B5FPHE=;
	b=Yuw/m7s7b1rdbs1CxP3e/9lnAt67dDwTl+CbLbY81rUBEMsSeq0rNS8adaQkwevcEosVyG
	St1Qu4eXz2oGbDE3A3uTkPTieQwfbNWrNCoMfS0o3zXrK/udOTQa5yvmDfTY/ySA4hRY8b
	UjWB1y7H7hVeVA8D+Y1pNePtgw2P3wk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-dWn05TtXNf2h9Ic8zkZYmQ-1; Fri,
 16 May 2025 15:03:35 -0400
X-MC-Unique: dWn05TtXNf2h9Ic8zkZYmQ-1
X-Mimecast-MFC-AGG-ID: dWn05TtXNf2h9Ic8zkZYmQ_1747422210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8E48195608D;
	Fri, 16 May 2025 19:03:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88732195608D;
	Fri, 16 May 2025 19:03:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6824951b.a00a0220.104b28.000d.GAE@google.com>
References: <6824951b.a00a0220.104b28.000d.GAE@google.com>
To: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2652585.1747422206.1@warthog.procyon.org.uk>
Date: Fri, 16 May 2025 20:03:26 +0100
Message-ID: <2652586.1747422206@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Note that the mount() syscall in the test program doesn't seem to work if
SELinux is enabled.

David


