Return-Path: <linux-kernel+bounces-788320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE2B382CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791B317F51D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030134A32B;
	Wed, 27 Aug 2025 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9pvEGnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA22301010;
	Wed, 27 Aug 2025 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298896; cv=none; b=n44aAm4SlVTWcoeRTXjGTcSW34G9kPe+QkGf03vwsHLsSlKwUd+HkbAZdeidWRVKzxXugKzA5xva1lsAV5WmbhqmbHVIUnT6K6b/uscNKSbRNUWfc4iVuFwnrZnRPY9yRg++NCTRXY4AdzSbPjiNemKpJ5F8ibw9zBpIry2O0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298896; c=relaxed/simple;
	bh=446GKTdq+eU8SJQb/MXBWHFElhnkbinBcXvD2n46AgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emZImyjenX2jcmif5errLMGXp4xhx+2c5KKb4drFyQBfsziofI6sfcgjA16EbJPS1HT4973vENty1roaqojGNVuOBD2IhK43A5eCni/vX0s4id5wT1iR+HBZUhB3y59GhlBLWf3gznL6IDuJKpjS2KTlnP7OrbT20TOnCuotCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9pvEGnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45E3C4CEEB;
	Wed, 27 Aug 2025 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298896;
	bh=446GKTdq+eU8SJQb/MXBWHFElhnkbinBcXvD2n46AgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9pvEGnZaV0N2O+kDhv8eOxMG//LUL0MBscniqDhxYB2HeHz0UZ2nA59xykj6oNxt
	 oY3ops7GHLNecKcwnHfwPcEoLogLQhu3Itv585rf+Te6HwBxpeOODC8oZ9EyY2rN7n
	 K8RY7WcqioT3zOtbfACpaJUUYH2qmif4eeCa8h+CJt26Jgg/v6HpoLob8OxPgA//RC
	 SuQYa4ygss8n3JyCJ6KXYPZQKvnZZ0A8iCS6BYKWDfGOpT6v4wwT6fUaJPj8j6/duz
	 CqmYeQ8jwevZ4odvuZmM50KrM4UxB6JIc2vKMMKzJBQNR1QpxcQpElIM/CgfuMeyd0
	 PbjQGS//T5nZQ==
Date: Wed, 27 Aug 2025 14:48:10 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>, Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?=
 <j.neuschaefer@gmx.net>, Fox Foster <fox@tardis.ed.ac.uk>, Federico Vaga
 <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <20250827144757.26599d50@foz.lan>
In-Reply-To: <877byp9f63.fsf@trenco.lwn.net>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
	<87wm6p9v8l.fsf@trenco.lwn.net>
	<20250827113312.62162725@foz.lan>
	<877byp9f63.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 27 Aug 2025 05:28:52 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > As a non-native English speaker, "had better know" looks really
> > weird on my eyes, as, at least for me, "know" is a verb.
> >
> > Heh, I just discovered today by looking on a dictionary:
> >
> > 	https://dictionary.cambridge.org/dictionary/english/know
> >
> > That know can informally be used as a noun (a shortcut for
> > knowledge?).  
> 
> "know" is a verb as used in the sentence in question too.

That's new to me. I would expect that a verb locution like
that to have the final verb ending with -ing, written in the
past participle, or have "to" before it. After looking for this 
particular grammatical construction, it seems that "had better"
is an exception:

	https://teachtranslatetravelrepeat.com/semi-modal-verbs-had-better/

where the main verb remains in infinitive without "to" prefix.

> > For me as a non-native English speaker, when one writes:
> >
> > 	They "most likely know"		(know here is a verb)
> >
> > or:
> > 	They "had better knowledge"	(knowledge is a name)
> >
> > Things become clearer.  
> 
> But neither of those say the same thing.  Read "had better know" as
> "really should know" and you get a lot closer.  I guess I didn't realize
> that it was such a strange construction.

I bet very few non-native English speaker developers would understand it
like that.

Thanks,
Mauro

