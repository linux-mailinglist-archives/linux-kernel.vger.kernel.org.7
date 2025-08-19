Return-Path: <linux-kernel+bounces-776154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F2B2C949
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61645C05E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B861F3BB5;
	Tue, 19 Aug 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7jNMwCr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372E38F80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620107; cv=none; b=Kqf1KjLVocoBO++vKzvV3SbmYdECuQSQtno/AnZo/HPynRGoEAFXAfEwLwG0ZGsjVDUWEvAmXPTGlFAYWHbsLclIbOeTo0qTawqsgmEiSVjraypS+bi4yjhL0mdTrLUAIae/BTh9VGMXw10RAB1XoiWgbV2s3q97bpevpcuci8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620107; c=relaxed/simple;
	bh=kr+F4blUg6FODR+2BQWkkRgkHiFy8Hzr+twDnZG4NyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ew79vxFne1sKVF84EYSq+Y/X/rlwD6iQ1IQw0kX9pdnVCOETwgpgXWwhvOJNlqxZ+ZDcFwQaYicFq6affHCSsVqPEE8kRCk2nAucmE3qtC/dRKuab4FVAF+51G6tW0K5TnUmrG13ORsis+s+9j7il6H/vMFLfwd1ecEVVpP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7jNMwCr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755620105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kr+F4blUg6FODR+2BQWkkRgkHiFy8Hzr+twDnZG4NyI=;
	b=R7jNMwCr0dzxjPtJ0cU3+0+9CAIhRhhp4U3YjJ5INjfZvKB5PO30jdUv2JE7gcgzEo5i6U
	MSKG4wBEwTgGPLcF1Hw3VP7CTemR/KLz+xY5NtZljf0Pt339dEpWk39ZAa6YeYxDn4Ng4m
	yhVx1rvUB8P8bHCe7AASzv7BEpkfEqk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-3o2EMjNHMyeBJ5Vh3nX_AA-1; Tue,
 19 Aug 2025 12:14:59 -0400
X-MC-Unique: 3o2EMjNHMyeBJ5Vh3nX_AA-1
X-Mimecast-MFC-AGG-ID: 3o2EMjNHMyeBJ5Vh3nX_AA_1755620096
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4928A180036E;
	Tue, 19 Aug 2025 16:14:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AF8BF18004A3;
	Tue, 19 Aug 2025 16:14:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Aug 2025 18:13:37 +0200 (CEST)
Date: Tue, 19 Aug 2025 18:13:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com,
	elver@google.com, glider@google.com, jack@suse.cz,
	kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, v9fs@lists.linux.dev,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] 9p/trans_fd: p9_fd_request: kick rx thread if EPOLLIN
Message-ID: <20250819161329.GC11345@redhat.com>
References: <68a2de8f.050a0220.e29e5.0097.GAE@google.com>
 <20250819161013.GB11345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819161013.GB11345@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/19, Oleg Nesterov wrote:
>
> Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Tested-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68a2de8f.050a0220.e29e5.0097.GAE@google.com/
> Link: https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
> Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Prateek, I turned your "Reviewed-by" from the previous discussion
https://lore.kernel.org/all/67dedd2f.050a0220.31a16b.003f.GAE@google.com/
into Co-developed-by + Signed-off-by, I hope you won't object?

Oleg.


