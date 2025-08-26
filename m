Return-Path: <linux-kernel+bounces-786845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D539B36CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18191A01441
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24372737E8;
	Tue, 26 Aug 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Te3raU5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D88B8635D;
	Tue, 26 Aug 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219615; cv=none; b=L4IGK01Ad2NXx/R6X2ioncrYAs0A4qY1JCsc41lL+K3YeLjNppnycNmHSKQGUqLEXN9Lz9s+JViwRMwpGhL4gTDjaEqmxLg/h/yBeLkmLAuDt6wZYtNtGxkr9dmvmaBVI3jGYEQUX/UYTVul6rf3ZYyt32TUKDGxPqN2JML+lkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219615; c=relaxed/simple;
	bh=Lxo2DeBPbjwel3AvvdT8bRYWUnkhTXi+8e7kr/g5VCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fD2ZUc21L2Lnp4lwuKtwNHTkPIm897XklHpOrdqD796aEQ5q2OH3QgcvRBr6TmF1ex/sfp+c/0Wr5cbFG6OCb4S57R8BO2mg/UXovggnmgTatslS0EXtM5BPuhb8IOp8QV41ughfN6c/fKCyICYpPJZh4Ysfx+wLKIz8BmIPm4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Te3raU5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD5C4CEF1;
	Tue, 26 Aug 2025 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219615;
	bh=Lxo2DeBPbjwel3AvvdT8bRYWUnkhTXi+8e7kr/g5VCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Te3raU5HZlMDXYoh6KNEfqk3cjNLfUMn6vv+4z4bj9nm0v1PJjGzk2TXKPuCPQjsF
	 2e8PXce6LEH4ewDis3GsTW/II9B9QbP3/ZtHl+xr10i1nNGXaoZC9tmfF0ugsoOrjZ
	 bdbyZnLp9Uw8Waaj0PUtKNZ2vBj8XpkNIj42dkFY=
Date: Tue, 26 Aug 2025 10:46:50 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux Kernel Workflows <workflows@vger.kernel.org>, Fox Foster <fox@tardis.ed.ac.uk>, 
	Federico Vaga <federico.vaga@vaga.pv.it>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: management-style: Correct "know" past
 participle
Message-ID: <20250826-fearless-glossy-dinosaur-46ebbf@lemur>
References: <20250826003437.7695-2-bagasdotme@gmail.com>
 <87349ed6zj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87349ed6zj.fsf@trenco.lwn.net>

On Mon, Aug 25, 2025 at 10:47:28PM -0600, Jonathan Corbet wrote:
> > Management style docs writes on people under a manager, where they know
> > the details better than the manager himself, in past perfect tense. Yet,
> > "know" is in infinitive form instead.
> >
> > Correct the verb form.
> >
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  Documentation/process/management-style.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
> > index dfbc69bf49d435..1381b253b19ef4 100644
> > --- a/Documentation/process/management-style.rst
> > +++ b/Documentation/process/management-style.rst
> > @@ -42,7 +42,7 @@ actually true.
> >  The name of the game is to **avoid** having to make a decision.  In
> >  particular, if somebody tells you "choose (a) or (b), we really need you
> >  to decide on this", you're in trouble as a manager.  The people you
> > -manage had better know the details better than you, so if they come to
> > +manage had better known the details than you, so if they come to
> >  you for a technical decision, you're screwed.  You're clearly not
> 
> This seems actively wrong ... ?

I do believe this is a clear indicator that the whole sentence needs to be
reworded:

    ... if somebody tells you to "choose (a) or (b), we really need you to
    decide on this," you're in trouble as a manager. The people you manage
    most likely know the details better than you, so if they come to you for
    a technical decision, ...

This change would detract from the... unique... style of this document, but
would hopefully be less confusing to non-native speakers.

-K

