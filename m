Return-Path: <linux-kernel+bounces-750986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA8B163B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BF2162F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BADF2DCF69;
	Wed, 30 Jul 2025 15:27:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88810298CD5;
	Wed, 30 Jul 2025 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889263; cv=none; b=GZwu7kPZdf7YwbwF72zWswOXT+414NWvKfvyPQ9mUJS5jH18cAPG629NxW24sHHQuL771l3FT/wLrVVNjQehhPedxYm6fXPu+fczzAtEMHhRnC2+S/eCTvqQLOr0OcU6RE5Cqg73xqpfmP985FT8hClKMEE1P6Fe3ggimeSJSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889263; c=relaxed/simple;
	bh=ThRQpQImKohW3j0bDzEv1ge11WAODJfzdzfjbsd8yyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEjkmLBoKnPutUsuT9r+rlRTMMSR8rWo2OtHCBNU3hcu3SOqIEpmxnK0TnWY+08PFSXueJZWO2/mRHjHfE7UzNcupUcjY52jMR99R5nh2GCLO3/8l13Jb9vuRSQFTJ4xJzzmnWDzVackyJeB8uYQZXel0YoDs/lgUGjQFBdZsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 976B81A04C8;
	Wed, 30 Jul 2025 15:27:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 155412E;
	Wed, 30 Jul 2025 15:27:37 +0000 (UTC)
Date: Wed, 30 Jul 2025 11:27:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730112753.17f5af13@gandalf.local.home>
In-Reply-To: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a3f4m4toxzif1947pcpybdrnexzuu6wh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 155412E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/6zddIWnwaG0PC03/R4rWftBR/ZnZuRK4=
X-HE-Tag: 1753889257-723928
X-HE-Meta: U2FsdGVkX1/WwWjUnrXvCwivuj741K146bUz3Qsieq2Nfs3GLxqCHF45x8wUpM7HqpoDkWTiRuWNq4wUhpA/30hhT/xdy+X4ky7BKuFgFAsJUVtUZRYnxv99OZGA0vNyncrDk8rPvOkQoDYp7WjQ2iwGCPRxshtVPKucme7o6w9PYU+N3WbgkiShRvLeDPusWKYvvOaKV+oyh7+N7nYh1+CWgv8JJht94yW+nOEUovVTHGXqozcEHl1zaaJnaqqe+2eBl4iHVIf5FoF45B2c1mvWnbKe8av9gWHpG/lbrsPC09NKFfRmsBEeGLFmWW78H/lBsjNwKm2Ssure1CPlqEfbnXNPOmw/fwtgFByt1XoOxS1LFj7DFxp7N+w7BIYm5H8k7aVEPegQC7Bkn2mSEErZBB3/opyXyu1F5cDNXAM=

On Mon, 28 Jul 2025 11:52:47 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Mon, Jul 28, 2025 at 12:35:02PM +0200, Greg KH wrote:
> > > So to me:
> > >
> > > - We should establish an official kernel AI policy document.  
> >
> > Steven Rostedt is working on this right now, hopefully he has something
> > "soon".  
> 
> Great! Thanks for looking at that Steve.
> 
> I think a key element here has to be maintainer opt-in.
> 

I had started looking into what to write, as in the TAB meeting we were
going to pass a document around before we posted it to the mailing list,
but then I was made aware of this thread:

  https://lore.kernel.org/lkml/20250724175439.76962-1-linux@treblig.org/

Which looked like someone else (now Cc'd on this thread) took it public,
and I wanted to see where that ended. I didn't want to start another
discussion when there's already two in progress.

-- Steve

