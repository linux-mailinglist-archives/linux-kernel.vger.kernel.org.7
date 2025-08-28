Return-Path: <linux-kernel+bounces-789013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8085AB38FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F661B27585
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA716F288;
	Thu, 28 Aug 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="offt3uIB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934630CDA0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340945; cv=none; b=cOJeL4bICv0OsILz2eZ+JN3LHDzfhCxPwKrfsHypdP4EHAWrNegUqv7UKpaS8FhtQdLCF00V77I8+rqxBhWy0lf5lXM9Vbg2g9BPX1E1nt7exIIV8bIoZB5fW3JPBZQPyymEG4us85c76Q45sxfAdZQQY//BwbxjqYBYaFoLN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340945; c=relaxed/simple;
	bh=dxd8QSAVzwmbR+1mbcfn8utb4yYnDh1tvifJBiMUI5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLHxI8sCoMDj9U0shCKwbwovlBGdET4iGyqO60UTR2P286+O0XhAwoECpRI5g+1IG1NGUztrZn4A1R8c94DIMZTN4UTH7YI8zYSH0cva5t/Jtk6c96w+cyiiUnuPJVO4NgV54+9FxpRTSaXQoiGIu1grOctaqT+JMij0mqjqMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=offt3uIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B13C4CEEB;
	Thu, 28 Aug 2025 00:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756340945;
	bh=dxd8QSAVzwmbR+1mbcfn8utb4yYnDh1tvifJBiMUI5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=offt3uIBmutis+Mh5PpSxuw/lPMS2QQhM7fru9wFzq/WpNzVEokV7W1k4VMc87LRh
	 C8KMGbJQfErrMNWwOxLqLigoRY1cEUbKn/SHNz+c91OH/qPVv/6hR8AWyk1HrL6qY/
	 xuN6bAtyBJexMiKq7Q/ZZo3Ma8QFR2Gwva9GSb9NddFX2GRzVfaglLDcgQbP0VnGS7
	 Cz2q52gPykgswUZQQOOZ/JwO+W8cIvglf/Y68QFOK8KqeNot3rviPnsyYb7iaDbyTT
	 kDqTlZpu5rDnPEpLSokJ5mLImBcmyQbXerfATuLiIjoxR5sK6dcb/TcADcTO6a5yzI
	 shtJiodRalGvA==
Date: Wed, 27 Aug 2025 17:29:02 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	syzbot <syzbot+8785aaf121cfb2141e0d@syzkaller.appspotmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, peterz@infradead.org
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_munmap (2)
Message-ID: <ourgzm4wai237cpcef3ypdn67hspjgw4u7fee4hyouj2hn3gwx@c322noqn4kzq>
References: <68a7eee9.a00a0220.33401d.0168.GAE@google.com>
 <2d1297ef-5df3-4679-8e38-05be188f18d8@lucifer.local>
 <aKh2vr9HtFRKcnR6@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKh2vr9HtFRKcnR6@harry>

On Fri, Aug 22, 2025 at 10:55:10PM +0900, Harry Yoo wrote:
> On Fri, Aug 22, 2025 at 01:08:02PM +0100, Lorenzo Stoakes wrote:
> > +cc Sebastian for RCU ORC change...
> > 
> > +cc Harry for slab side.
> 
> +cc Josh and Peter for stack unwinding stuff.
> 
> > Pinging Jann for the CONFIG_SLUB_RCU_DEBUG element.
> > 
> > Jann - could this possibly be related to CONFIG_SLUB_RCU_DEBUG? As it seems to
> > the stack is within KASAN, but no KASAN report so maybe it's KASAN itself that's
> > having an issue?
> > 
> > Though I'm thinking maybe it's the orc unwinder itself that could be problematic
> > here (yet invoked by CONFIG_SLUB_RCU_DEBUG though)... and yeah kinda suspcious
> > because:
> > 
> > - We have two threads freeing VMAs using SLAB_TYPESAFE_BY_RCU
> > - CONFIG_SLUB_RCU_DEBUG means that we use KASAN to save an aux stack, which
> >   makes us do an unwind via ORC, which then takes an RCU read lock on
> >   unwind_next_frame(), and both are doing this unwinding at the time of report.
> > - ???
> > - Somehow things get locked up?
> > 
> > I'm not an RCU expert (clearly :) so I'm not sure exactly how this could result
> > in a stall, but it's suspicious.
> 
> Can this be because of misleading ORC data or logical error in ORC unwinder
> that makes it fall into an infinite loop (unwind_done() never returning
> true in arch_stack_walk())?
> 
> ...because the reported line number reported doesn't really make sense
> as a cause of stalls.

There shouldn't be any way for ORC to hit an infinite loop.  Worst case
it would stop after the caller's buffer fills up.  ORC has always been
solid, and the RCU usage looks fine to me.  I tend to doubt ORC is at
fault here.

Maybe some interaction higher up the stack is causing things to run in a
tight loop.

All those debugging options (e.g., DEBUG_VM_MAPLE_TREE, LOCKDEP, KASAN,
SLUB_RCU_DEBUG...) could be a factor in slowing things down to a crawl.

-- 
Josh

