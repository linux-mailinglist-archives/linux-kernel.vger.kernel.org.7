Return-Path: <linux-kernel+bounces-871949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2AC0EF16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 196F04E49D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED6307AFA;
	Mon, 27 Oct 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVQJy3nf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F7274670
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578333; cv=none; b=P6BTnkD6z33KJjjfNPDq2DIva1TKzIPcJIKm5vygbk5dToqw7LOvZidaUZ3dhcKs+Mxyk1O88bq1m/q8/YYAwb1Ml88WVuT1HR5IQmKct0DGwAbFxxvculabv1/5QB4gq2amd4PkkvbreEpDwTFY1QMt1eCEde7UIG1k4HgjbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578333; c=relaxed/simple;
	bh=vFEGA7OM1aKyD8LRqXp7yNHHYSE0s2CENxoo3ovZ8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr2sGa4Z3Mqg2cW+BxDDMnk22MbjymB3WV9eec+0TRxYb64GAPQ0BZ3ZU00NEzEfkVlyYijHvWM3bCtbf287+kC3xuh1N4cAaYf/5UtXU1r/Oa3sxvZVZwpXhHdhx6sGvyah6a3iGyc800ibWmvniCQZ1mRWDVf2W1MjoWkoSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVQJy3nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D55C4CEF1;
	Mon, 27 Oct 2025 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761578333;
	bh=vFEGA7OM1aKyD8LRqXp7yNHHYSE0s2CENxoo3ovZ8A4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AVQJy3nf6asn8f2+k+tlpW45PTUbiv6RPzjhGMJC/+gqEBbG0bMXcPhZHgFmRJt1L
	 st0zYLRyIIGdfLaQii4pg6g4OS7Jf/lxT8bsQVsBnu0LMwLIe2UWQiMFD7v/bSUNnD
	 t8gDNeB2YjNl6RW42smku3coOrb3MtRY5RzKxXIcwfRrJvi3pLGA7COPsJc2UFeqW9
	 moI8F89NddcZtv9gDgxJ/XIdR5GcoCcR5zsVKFtE4ZFSdwvGT+NuSJqZbWkKG3LEnl
	 PzhyJhdcKXU00REW/zEaW0RPlJsk9Vn2AyDilCBuBIrtfh1mj9n0EGW4ZyzqmXWMEk
	 6XxexdvjanNrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 155EFCE0D0D; Mon, 27 Oct 2025 08:18:52 -0700 (PDT)
Date: Mon, 27 Oct 2025 08:18:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] kill task_ucounts()->rcu_read_lock(), add
 __task_ucounts()
Message-ID: <bf07a721-ed57-4b8f-af4f-ca2dd21b12b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251026143501.GA22472@redhat.com>
 <20251026143140.GA22463@redhat.com>
 <2258932.1761576956@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2258932.1761576956@warthog.procyon.org.uk>

On Mon, Oct 27, 2025 at 02:55:56PM +0000, David Howells wrote:
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > So I think task_ucounts() can just do
> > 
> > 	/* The caller must ensure that ->real_cred is stable or take rcu_read_lock() */
> > 	#define task_ucounts(task)	\
> > 		rcu_dereference_check((task)->real_cred, 1)->ucounts
> 
> Can you use rcu_access_pointer() within exit.c?  E.g.:
> 
> 	struct cred *pcreds = rcu_access_pointer(task->real_cred);
> 	dec_rlimit_ucounts(pcreds->ucounts, UCOUNT_RLIMIT_NPROC, 1);

No go, unfortunately.  You can only use rcu_access_pointer() if you are
*not* dereferencing it.  And here, dereferencing is happening.

However, if there is some mutex that is preventing changes to ->real_cred,
then something like this would work:

	struct cred *pcreds = rcu_dereference_protected(task->real_cred mutex_is_locked(&whatever));

Alternatively, if this is due to the running kthread being in some
state, then a check for that state can be substituted for the above
mutex_is_locked().  And so on.

							Thanx, Paul

