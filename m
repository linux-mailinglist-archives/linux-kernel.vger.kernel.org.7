Return-Path: <linux-kernel+bounces-751158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3A9B165D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDD918C5E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008102E0401;
	Wed, 30 Jul 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXSoBULA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C31E0DE8;
	Wed, 30 Jul 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897870; cv=none; b=cqAFzEjtvVXDkiCbv4D4jO4415KlrtDFlN/OYonw+rmBSgMQwLq47LIHOOVjNTHUCIe1dmRj3ZuHl9LqSCZFIFARDeqfy9XVsHhxydpx95wL7NumOdOOpIbO0GDnJHiB87o5U9Esdrha/OE3tvUX1sz7hz83mr2RMTPgye+zx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897870; c=relaxed/simple;
	bh=SjD3gxtb2NQnzg3Ltut5H64k+5Je2XNn0GZBKQBUOCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE0OO7PauWboBZOHDgnmLgCnItCjJ0a46ea3PgO6ozg2xbwlKxTT93LkPdzMTafUUz2qGWLV+bh8NWAz9WK9oTH91ZJj3Ujxy0PGQSAS8ConodKg+ta8qmZzoXdseX1M0B+1txIKJYKEOUtpR6gxlo+zGtvYfoMk0bYbEWNRDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXSoBULA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80F6C4CEE3;
	Wed, 30 Jul 2025 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753897869;
	bh=SjD3gxtb2NQnzg3Ltut5H64k+5Je2XNn0GZBKQBUOCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXSoBULAPu7ypqeoj8fxHAUhkpSxrX7Deiss9twPiKBCX+3uWvqR++bWal2C4ZyXv
	 1YKBEURrDHMZt/j/8STwgoadgYQRHfVJ/H/Jlt4tc7yUIn7dsExH75hR/Wz6QNBKZG
	 XAjoY2u/wf5ude7Vt5Wsl1BBgzzA8pxcOvKM3H2C4FPctkj2VRS3l9TPb/DTR3F6Ng
	 koZ3IG3pB8pfHg50380Ne7eMIzBm+oLqwKAr3fxGWjk2nTcjRFVtsggVvskipzm2an
	 RVkHethygW8xDRG14pSoyRmlng+jsJu2lmU6Cbvwms12QeaUUoW2cIZtJIIO6nsLu2
	 kxrIO1ze1Ixag==
Date: Wed, 30 Jul 2025 10:51:09 -0700
From: Kees Cook <kees@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <202507301042.C7A6FE5ABB@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpLB5oMc1tSq1SP@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIpLB5oMc1tSq1SP@gallifrey>

On Wed, Jul 30, 2025 at 04:40:39PM +0000, Dr. David Alan Gilbert wrote:
>   b) There's a whole spectrum of:
>       i) AI wrote the whole patch based on a vague requirement
>      ii) AI is in the editor and tab completes stuff
>     iii) AI suggests fixes/changes
>     which do you care about?

There is a vast spectrum between i) and ii). For the 2 KUnit patches[1]
I sent, I had already taught the LLM about KUnit (via Documentation/),
and I walked the LLM through the API in question, then asked it to produce
a KUnit test. It spat out the core structure with proposed tests, and
it iterated on running the tests to make sure the tests were passing,
adjusting its assumptions about the API. I took that result and went
through it test by test to tweak edge cases, add additional checks, etc,
etc. By character count, those 2 are probably 70% written by the LLM.

For the atomisp fix[2], that was, by characters, 100% LLM, but I gave it
specific code style adjustments and guided it to examine the problem
correctly. Should it be considered "AI wrote the whole patch"? Maybe,
maybe not.

-Kees

[1] https://lore.kernel.org/lkml/202507301008.E109EB0F@keescook/
[2] https://lore.kernel.org/lkml/20250724080756.work.741-kees@kernel.org/

-- 
Kees Cook

