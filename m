Return-Path: <linux-kernel+bounces-879325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA664C22D74
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81ED634D0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395CA21D59C;
	Fri, 31 Oct 2025 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgHATln6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CB2AD13
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872838; cv=none; b=oVnYdFc7dNkDI12ujJfHvwKi2PydGoGoRPHeX9Dz+CCzqUBjsdlHXDugtN5F/jFpTJNVL+1Ou3udsikcJMq67ms11Dd7yWqhKs90Y2O1q6vAWUxKWQU65i/7MoKLkUMcIfo6OpdAQNKVEzqD23H0BlzEz/Lzm5Ca6y62stTlD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872838; c=relaxed/simple;
	bh=5uhKQCEfPz03zSOKTn3bEuX7eCLvIgdhi/QnEgo5NfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cg1Yjb09SgkSJBWAASdR3uj5DWa9jYICkBaewGzDgeOkpxqJcFBFp4EfNszQQZh2Q80a1T2irOGjDP0KM1E1jzetw4FxKvkb9z88bN3aKihfwW+AbVdKsUyH/ssRMMD4FlJ9s9f3UNYTlthcEyF1lgO1h/aPCftYuQJLBUhzEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgHATln6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EA8C4CEFD;
	Fri, 31 Oct 2025 01:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761872838;
	bh=5uhKQCEfPz03zSOKTn3bEuX7eCLvIgdhi/QnEgo5NfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgHATln6l7qexu48uM1wqKiMZHQNmXJTGRaDyYIj9PMXE2xf1MloP2WeSSXdsBx18
	 AntBVv4cWagIlOAfR0ShrdyEo2JW08dj57/b+d9u2SQEiGc9ZHl4aw7gStcuUer8vi
	 caJ1ZF1JU+TBStXp3BZuQfXq+8pQ984jTfksWEwkYu/aDJTq/AteRGbPcVURPo1U6q
	 XnHb8UVRS78+j7hjdaZesSoSE22VJFUQ5w/skC+VDN6gl+7Mg7WhFb61yhsVdQm0Hd
	 rOOKas+lRqVm1bMydD/Oo4GPLxUqcOVpreDT0/5pblPGcDgAgtY1eUA5izL6l3vyH5
	 bh922HBBaKr+Q==
Date: Thu, 30 Oct 2025 18:07:15 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, joe.lawrence@redhat.com, Naveen N Rao <naveen@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Message-ID: <kxdu6nbnm6pger627erjqajgpq4bpy6enhyhhgyry73dpzj5v7@54a76wpspao6>
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
 <aPjW3P2AU7L71S-s@pathway.suse.cz>
 <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>
 <aPnxlEkV1rL0hWOm@pathway.suse.cz>
 <875b21ae-c30f-4dff-bef2-e41965013416@linux.ibm.com>
 <wxqithrj3vvgbefr7d7afv5vcnuu2ssuzrw6fqtmdjtq3ete3j@pfsgyacqjama>
 <7f461974-7fdd-422f-b4fe-e65af50b0728@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f461974-7fdd-422f-b4fe-e65af50b0728@linux.ibm.com>

On Thu, Oct 30, 2025 at 06:09:54PM +0530, Hari Bathini wrote:
> On 30/10/25 7:36 am, Josh Poimboeuf wrote:
> > On Wed, Oct 29, 2025 at 11:42:54PM +0530, Hari Bathini wrote:
> > > > I looks like another problem. I would expect that it is in
> > > > the ftrace code, either in the generic or arch-specific part.
> > > Yeah. This is part of arch-specific code that does init of ftrace
> > > out line stubs. The problem seems to be since commit 1ba9f8979426
> > > ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").
> > > Before this commit, .text.startup section was featured in INIT_TEXT
> > > but now it seems to feature in TEXT. Is this change right/intentional?
> > > If yes, I can post a fix patch in ftrace arch-specific code accordingly.
> > 
> > Ah, I wasn't aware of .text.startup.  Apparently it's used by KASAN,
> > KCSCAN and GCOV for a significant amount of constructor code, which is
> > only called during boot.  So we should try to keep it in .init.text.
> > 
> > Venkat, does this fix it?
> 
> I tried the patch along with
> https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org
> It fixes the problems reported. Thanks!

Thanks!  Patch posted here:

  https://lore.kernel.org/07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org

-- 
Josh

