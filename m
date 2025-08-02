Return-Path: <linux-kernel+bounces-753943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B72B18A6C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 04:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7188B1773ED
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3413A41F;
	Sat,  2 Aug 2025 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m6n2Hfv1"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7CEEB2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754101560; cv=none; b=nRy+dk92++99lRVo1R53IeSKORY3nsMcflpO4Thlse23qY8zKPplA3p9TE/ls0q7YyFMekgtFHaBaTduUudVi8vuD3uzItw057jNJ8DfKoK5Qt2tmX+xKYMeLuq/qFLTy+SjX6UPaijLIyIXeKt0w4eq/2BF2/cuJbFqJxj61Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754101560; c=relaxed/simple;
	bh=0/Y4q7Ppr5Vy+ZJzdqJYmduHhWS9CiV6/ZjhJfaVFac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdeXUFYL1IhDhYHe+CPNqlMxjJz+QmWwRtXiHpYT1FpGrHDvOef7HDhAdTxEYiVQcYiIoN5jJBGh6MIydu1vQgWq8uad7FaM7cQPZ9yLB/bOrwJvW8jqKWQfdy2PS/nxfTjEYoG6hAaYj18YTR593b8cMsin/sjoIVD92ZpyBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m6n2Hfv1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o88M/veoZBXPxPXGk24CIts65SvNF0xS1ckpPgoWhBc=; b=m6n2Hfv1p/CvMB4uio8fPykT3W
	ttN2gmvv0vELIWBFvILIJN9CUoAUPzPlETcqNfB2bBIzbyg1ulqyFw9jcsv1mQltITEC0MHpLkCSj
	OPdcNteNSHVkWXRwqfP6P3AMAz2tl61xoYlsAchxf5kUbpFce+21fcnZw0JNhi2RnyndVaM1EkWJM
	bm5paqLkXM8q+QNHPZAnnncDMQVB2l3jNw8g0qm85Z8VUJUHKmv+OoxUgiTtVckkUwHOhwO33Rp9M
	hD2mNy42OOFMEp7I9wjm+45sNDR9IiIjyDOixh/PyhSLNNK+mSm+b75NSDjKmyDW3PHRQ61vvLKQ5
	lCT/+kCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ui1wU-00000004J0A-1ngd;
	Sat, 02 Aug 2025 02:25:50 +0000
Date: Sat, 2 Aug 2025 03:25:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: brauner@kernel.org, oleg@redhat.com, mjguzik@gmail.com,
	Liam.Howlett@oracle.com, joel.granados@kernel.org,
	lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250802022550.GT222315@ZenIV>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802022123.3536934-1-gxxa03070307@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Aug 02, 2025 at 10:21:23AM +0800, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> __task_pid_nr_ns
>         ns = task_active_pid_ns(current);
>         pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
>                 if (pid && ns->level <= pid->level) {
> 
> Sometimes null is returned for task_active_pid_ns. Then it will trigger kernel panic in pid_nr_ns.

In which conditions does that happen?

> 	__task_pid_nr_ns+0x74/0xd0
> 	...
> 	__handle_irq_event_percpu+0xd4/0x284
> 	handle_irq_event+0x48/0xb0

	Huh?  Just what is it doing inside an IRQ handler?
Hell, the notion of current process is not usable in those,
let alone any properties of such...

	Details, please.

