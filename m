Return-Path: <linux-kernel+bounces-727468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E0B01AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A81C80DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDD28B7DF;
	Fri, 11 Jul 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4Mb4YtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4032146585
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233891; cv=none; b=CyVLj17XsC1ao2Dm56I/KAaVsv+tzsVD1Q/edfoa6KJttddspX2jwwHWjNa/9S8GVyog+sf+od9sLlOpg0gl8rVhCRJEblc1l5jO3Y04X9ynuu9Ec2+UdQjtibTGFb0X9dHxL0KOFGTxnoayPPJKTf2a/a4pEFi6bxeRdjcpQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233891; c=relaxed/simple;
	bh=lSvoT5vt44Jp8PaBB+rkOYldsL6euG1VhFB9xopGaRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDQ/CBSOPZL2T5EVamJ/hsLh3FWurWyoaHE5bqDrkZPi7wsukny2F4vEsRKpm/n6OvQRbPWklSy7SOMzp8NjLUMtQpYPGz6O/GiyFTyruSlcTPC4NM5xRwuj/BCKDIwc0dh9iHoXi7a732WWBONdWiqtXh/+0yI/d5t1+GvafuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4Mb4YtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1204C4CEED;
	Fri, 11 Jul 2025 11:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752233890;
	bh=lSvoT5vt44Jp8PaBB+rkOYldsL6euG1VhFB9xopGaRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4Mb4YtSbYGdHc+iYwE0/RCEEQ6a3YMKvwQuJcuiO0tb8cmWBC4IcbaVt4z825U/W
	 vybKH50YMqS17MNTfNPQuWFapCMc0cKKCFviufU97su4HTgduYgw8Cls4YOj0k21z+
	 trsZJWu01xXAWVtGdAx/cdogG3k7aZxapr//o24I=
Date: Fri, 11 Jul 2025 13:38:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
Message-ID: <2025071124-cola-slouching-9dd2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org>
 <20250711065742.00d6668b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065742.00d6668b@gandalf.local.home>

On Fri, Jul 11, 2025 at 06:57:42AM -0400, Steven Rostedt wrote:
> 
> [ Adding the TAB to this as well ]
> 
> On Fri, 11 Jul 2025 00:36:28 -0700
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, Jul 09, 2025 at 05:25:49PM -0400, Mathieu Desnoyers wrote:
> > > Allow the unwind_user symbol to be used by GPL modules, for instance
> > > LTTng.  
> > 
> > I don't see a LTTng submission or any other user in this series.
> > So the usual prohibition against adding unused exports applies here
> > as usual.
> 
> I want to bring up this discussion. I understand there's a policy not to
> add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kernel
> proper. My question is, does this policy have to be draconian?

It's not "draconian", it is "we do not add exports for stuff that is
not in our kernel tree."  Simple, direct, and obvious.  We have no idea
how, or if, external modules do anything with apis that we export and do
not use internally, so we can't change them without breaking anything,
so it's simpler and more obvious to not even attempt to care about them.

If external users want to use a symbol, they should get merged into the
tree.

Yes, lttng is a "good citizen" of the kernel community, and yes, it's
not merged into the tree, but that's not our issue, and living outside
of the tree has it's penalities, both economic and technical.  This is
one of those penalities, sorry.

So no, we shouldn't change this at all.  And I think we need to start
doing more of the "only export this symbol for this subsystem/module"
trimming as well.  I see the horrors that out-of-tree kernel code does
and by removing the ability of them to even get access to the things
they do have access to today, would be good for everyone involved (i.e.
our community, AND the users of Linux to allow them to have a more
stable and trustworthy base to rely on.)

thanks,

greg k-h

