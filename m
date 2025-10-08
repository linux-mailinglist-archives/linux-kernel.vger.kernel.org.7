Return-Path: <linux-kernel+bounces-845465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F286BC50AC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D1B4F6869
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B126056C;
	Wed,  8 Oct 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EsEKIMRz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698CB25F96B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928210; cv=none; b=Psgx5Y61jj1PBii79atp6h93Gav2eiUsvPc323w/Jb9FKnaX36crQRgmjiiQlyqkNwEDR/rssjRsfgSW+Uy9CaX0mbpnIxLsUheFTUJcOuKEkusaUuZzfrImcXWkujDyq01rUZYhlmgf0DC/To9mUA+8PSGek4wWIW/NfsoXfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928210; c=relaxed/simple;
	bh=8ga4KahnC4QYzNa1TpwiK5mmMaXexOt/auzcC1HtDHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtdcQU101t4u52MNm2KiRGYY7vN5z9LVIZPPGrKO7MMgeC+c+gOGwnCHXqeNDufsVhg8HnSFFezWb4D2ykLJ1h9OSiTSrkbyhYoh8uhKtTFLd0Jn91fMiwkzHB6ZCuXKZ2Opq8FHl7y6fgJCJ5vTUAY+cJ5REmOtdPVgbRrTQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EsEKIMRz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ga4KahnC4QYzNa1TpwiK5mmMaXexOt/auzcC1HtDHM=; b=EsEKIMRz1tzz0xNmKbhmBiKF/j
	K64qyX+qvHwDBZ9r0z3lpa7w8gKdLzpUT5yY0WMTc/9aig5csiGNfay+XQKQ7cU+5/gQUp/UtmYRH
	JKmyEWC9jiMsWBbqzZ5zI/pu9X60wOYSY1JJGCKMbkJjpgfuuZU/42SRAp/lZY0zoRVxuOwmbDpjD
	46tbjynNuiA/h5M86mVYSMcilxxFo8AerZiaHhiT4xsycE/A3U2Mg80iTrXVixLBgI6/IJ75xjW61
	XcdWp0KDThXRtAjMdAGiulSA1zX6BBU084kSQ/r99PoJYjWTHUwYG/qVe1OK0HpTepkUxpxggRc+2
	oujnE+mQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Tig-00000005NyF-3moS;
	Wed, 08 Oct 2025 12:56:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 25D82300462; Wed, 08 Oct 2025 14:56:39 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:56:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008125639.GK3289052@noisy.programming.kicks-ass.net>
References: <20250928161953.GA3112@redhat.com>
 <20251008123014.GA20413@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008123014.GA20413@redhat.com>

On Wed, Oct 08, 2025 at 02:30:14PM +0200, Oleg Nesterov wrote:
> Only 1/4 was changed according to comments from Linus and Waiman,
> but let me resend 2-4 as well.

Shall I put this in tip/locking/core once -rc1 happens or so?

