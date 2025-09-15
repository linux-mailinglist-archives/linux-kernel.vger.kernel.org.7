Return-Path: <linux-kernel+bounces-816881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D19B579F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8540A7A5395
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A842FFDE2;
	Mon, 15 Sep 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bm/tibtD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51A242D88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938030; cv=none; b=KSF8n1uuqPP9QUUM2Z0qXxZN2+LNNpOHJboYkUjwPyYbWVixCUwGSLrpHIhyIY3/27/DO7thyiL4LL83GqZpCR/KGVWqRz5QdFh5a15cMMpFG9PnaIeKR5whu2RrxWxeDTyRGQtWG08D7pnoRaj4b0Ks1V9d8xdZl6l93Kqm9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938030; c=relaxed/simple;
	bh=zc+skLfK6zn6FsLIxdXXxVmznAM9rO+sxDy3SSKA7+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku9KgbujJpxMdn7xNeGpg06RO9TSUE0bTesQfIzj8HizE5+c97rVasXK7HCYJcOzHO0WAFy/WdGIdGdRdHop9OvmCmK5ZmXgNmgfUYUugijwPKuWrO+Kshkr9FxPykTJVanotIpFLXfvMnBZSLwfFJxOObhwcBgbS/434HEz/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bm/tibtD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757938028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zc+skLfK6zn6FsLIxdXXxVmznAM9rO+sxDy3SSKA7+c=;
	b=bm/tibtDMNT65Bih8mHCXnJ2sESXff3MIWSXysNEAgCIp7/PGMxbm+8P0rU4AHYqy0yfMV
	ZVCqLvPbdRxW7OdMkhSE3h1JrUQWWFCacyqZqXgORY2nGW5KmonvFTYJ18+KrT2LKrZbkq
	1wp1kEIy8ws6EB07KEc8VXZpGFsq5jw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-3en9uUhQORGuQ9WPkrtFeQ-1; Mon,
 15 Sep 2025 08:07:06 -0400
X-MC-Unique: 3en9uUhQORGuQ9WPkrtFeQ-1
X-Mimecast-MFC-AGG-ID: 3en9uUhQORGuQ9WPkrtFeQ_1757938025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8828F1953964;
	Mon, 15 Sep 2025 12:07:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5F19530002CE;
	Mon, 15 Sep 2025 12:07:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 15 Sep 2025 14:05:41 +0200 (CEST)
Date: Mon, 15 Sep 2025 14:05:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fix the racy usage of task_lock(tsk->group_leader)
 in sys_prlimit64() paths
Message-ID: <20250915120537.GB23082@redhat.com>
References: <20250914110908.GA18769@redhat.com>
 <20250914110937.GA18778@redhat.com>
 <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/14, Mateusz Guzik wrote:
>
> On Sun, Sep 14, 2025 at 1:11 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Change sys_prlimit64() to take tasklist_lock when necessary. This is not
> > nice, but I don't see a better fix for -stable.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c022a0acad53 ("rlimits: implement prlimit64 syscall")
>
> I think this is more accurate:
> Fixes: 18c91bb2d872 ("prlimit: do not grab the tasklist_lock")

Yes, thanks again.

> Unfortunately this syscall is used by glibc to get/set limits, the
> good news is that almost all real-world calls (AFAICS) with the
> calling task as the target. As in, performance-wise, this should not
> be a regression and I agree it is more than adequate for stable.

OK, good, I'll send v2 with the corrected "Fixes" tag.

> As for something more longterm, what would you think about
> synchronizing changes with a lock within ->signal?

Agreed, we should probably change the locking, but I am not a new lock
to protect just signal->rlim makes a lot of sense...

We can probably reuse signal->stats_lock, but it needs to disable IRQs.
Or ->siglock, but it is already overused.

I dunno. In any case we need to cleanup the usage of ->group_leader,
it seems there are more buggy users. I'll try to take another look
this week. And probably it and ->real_parent should be moved to
signal_struct.

Thanks!

Oleg.


