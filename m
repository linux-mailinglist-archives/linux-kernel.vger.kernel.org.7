Return-Path: <linux-kernel+bounces-751065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198DB164E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD45B1891778
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1922DE6E7;
	Wed, 30 Jul 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="K3S0v9HZ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12838DD1;
	Wed, 30 Jul 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893658; cv=none; b=oC09eFw2ulP0OPxAsXdJ9TsvELmPA0SzafLvhF/GSUSC0S5h0Ed+0hMKv+tjw2alGvRxOq9h//c+ECIE77JRYrJ28Uq8Z/7TYb///6W9mlD7btwKdg2c8YUZes2pEliq7RiZ0eE/UW4iqOa/6QV8wyD9ZWZrYvod9AkWHJxFfCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893658; c=relaxed/simple;
	bh=MV++cH2GAEMecjjfJMiy5iN+OnKppbKWoUNDv5Jcd+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv2FPFQIcYGUYAq8MRhu0YAgL65BlZKACGfsDeAZPPlqgB7iK5L9Wm9CFGOBfMGn/YySBW+pL7omHwyCygyp0pp5OVdUZkss6nLZ+ndA/Rj7RsAqBsblJ78IWfi6e7/Quw290cKoZa1v2oHFxie1Ib70n8eNx0em53QRbaVx8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=K3S0v9HZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=6sLPbRXvL8Nqf2gPmejb047phT2gVvAoedZaMe5bpu4=; b=K3S0v9HZS5WFmGWp
	Ycl9I6JZuFGY1hU+WrtRYuF/lelksWGLaBFSS3XB0JgI1acFKHwyu8lBgVD7c5rCRvL5w5zF/GcQH
	jfhH+pSxJV9PVi66b0tV5T22d5JjVmmXbI1aBoJvtHKG92DesorJ/BslJGM6Od8t7Fi5rVnzgUWHA
	v/Eu4EiCJy+QPIVtApoEETPgHScN6pypm9LrW03xGj2+V4n7p9MPSXSfwmxpZ7LhMO3tTIkFIhBna
	wZDldFiVkbqpa2CsbvdjYLOLl3mdwG02MWoQPAQVaaSDJDpXrKpFSSu/pFDFRlzFrPtZvaYIwbesr
	B0CTpNgFGH6vPEnqnA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uh9r5-001NZ3-1P;
	Wed, 30 Jul 2025 16:40:39 +0000
Date: Wed, 30 Jul 2025 16:40:39 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
	Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpLB5oMc1tSq1SP@gallifrey>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250730121829.0c89228d@gandalf.local.home>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 16:31:09 up 94 days, 44 min,  1 user,  load average: 0.07, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Steven Rostedt (rostedt@goodmis.org) wrote:
> On Wed, 30 Jul 2025 16:34:28 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> 
> > > Which looked like someone else (now Cc'd on this thread) took it public,

(I didn't know of the tab discussion)

> > > and I wanted to see where that ended. I didn't want to start another
> > > discussion when there's already two in progress.  
> > 
> > OK, but having a document like this is not in my view optional - we must
> > have a clear, stated policy and one which ideally makes plain that it's
> > opt-in and maintainers may choose not to take these patches.
> 
> That sounds pretty much exactly as what I was stating in our meeting. That
> is, it is OK to submit a patch written with AI but you must disclose it. It
> is also the right of the Maintainer to refuse to take any patch that was
> written in AI. They may feel that they want someone who fully understands
> what that patch does, and AI can cloud the knowledge of that patch from the
> author.
> 
> I guess a statement in submitting-patches.rst would suffice, or should it
> be a separate standalone document?

If it's separate I think it needs to have a link from submitting-patches.rst
to get people to read it.

To summarise some other things that came up between the threads:
  a) I think there should be a standard syntax for stating it is
     AI written; I'd suggested using a new tag, but others were
     arguing on the side of reusing existing tags, which seems OK
     if it is done in a standard way and doesn't confuse existing tools.

  b) There's a whole spectrum of:
      i) AI wrote the whole patch based on a vague requirement
     ii) AI is in the editor and tab completes stuff
    iii) AI suggests fixes/changes
    which do you care about?

  c) But then once you get stuff suggesting fixes/changes people were
    wondering if you should specify other non-AI tools as well.
    That might help reviewers who get bombed by a million patches
    from some conventional tool.

  d) Either way there needs to be emphasis that the 'Signed-off-by'
    is a human declaring it's all legal and checked.

Dave

> -- Steve
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

