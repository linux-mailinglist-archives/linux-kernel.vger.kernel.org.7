Return-Path: <linux-kernel+bounces-743200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4DB0FBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCF63B882A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278F8223323;
	Wed, 23 Jul 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw8eQLi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874892E36ED;
	Wed, 23 Jul 2025 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753303660; cv=none; b=S2egU4pSkCCNNtxbLPyVT/h2HdIRPD9ysileC8TBInEDaBhXMKrDhTHCMb5Enef/axFDDCZSo877Gc0QoWEwlDv4tNipYwMheQ0BkK5gZssyTQWa5YwlLPEISNLEGWUcBscEAO2kC1sZfSOOMZwStyJYFvQC7Z6R+Oq4dNaRgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753303660; c=relaxed/simple;
	bh=LE8QfiZvugmKxke6wBLIdhZ5pFSHw3p7PL0ajIhDg4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzDrJRvJNu4V+Umm5LxoFrtyODaVrIPYd/W3LdYwZ3rrsUyER6bvxqhnujRBan1TMcV5xbjwzaW7AUMysF/h4lgbbiiznyaVRU2MThq//InJjIQvNU07H9EMxHFJskguG3xy3nnz0FW78gfSQLONDZMZpEOUdoct9ZeZo2bd8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw8eQLi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0646BC4CEE7;
	Wed, 23 Jul 2025 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753303660;
	bh=LE8QfiZvugmKxke6wBLIdhZ5pFSHw3p7PL0ajIhDg4s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Sw8eQLi0MAaHvpkTLfVE6LQkCi6jkA4Hrz01RFTWxx5FEf//kuhmmkCPFP/CzpSjB
	 9Vi6V9Vis8cmYAJLK4drEXVyl61Af5Ys7JdFrHyh2hLWHFGgrR35TP2FBWc4AwSymk
	 Lnr7EuOFmVubFyGPHiq0C8Bcb85Y1bANJEHzP6uD7NqLNN6KyL7VEfOof0rBtbTR7z
	 ED1qmwhjUmVC5rvauCjdPvwZQPQms5mypJZ8DBwi2hKF+W7B9VTpufDqTg+l5rNGJM
	 ax4pGoPj3rHXPyiNx1NpBm/30nsgTo4MZzQDpchETC5Vo2UUlGindH1YjMpcOmK88H
	 peYmjbHJmdLpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A899ECE08DF; Wed, 23 Jul 2025 13:47:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:47:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: carlos.bilbao@kernel.org, bilbao@vt.edu, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] docs/core-api: Fix circular buffer examples
Message-ID: <8723a37f-0a04-4e46-80a1-7bb817ecae03@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250720160243.149595-1-carlos.bilbao@kernel.org>
 <1e3c4ee3-f66e-4ce0-819e-e0bed6a744e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3c4ee3-f66e-4ce0-819e-e0bed6a744e8@gmail.com>

On Mon, Jul 21, 2025 at 11:47:25AM +0900, Akira Yokosawa wrote:
> +CC David and Paul, who are the authors of this doc.
> 
> On Sun, 20 Jul 2025 11:02:43 -0500, Carlos Bilbao wrote:
> > From: Carlos Bilbao <carlos.bilbao@kernel.org>
> > 
> > Fix circular buffer usage in producer/consumer examples in
> > circular-buffers.rst. They incorrectly access items using buffer[head] and
> > buffer[tail], as if buffer was a flat array; but the examples also use
> > buffer->head and buffer->tail, so it's a struct. Use buffer->vals[head] and
> > buffer->vals[tail] instead to match the intended layout.>
> > 
> > Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>

Hello, Carlos, and thank you for your attention to detail!

This one could likely use more help, as the last substantive change was
more than ten years ago.

But are you referring to a particular use of CIRC_SPACE() and CIRC_CNT()
for this change?  If so, could you please identify it in the commit log?

							Thanx, Paul

> > ---
> >  Documentation/core-api/circular-buffers.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/core-api/circular-buffers.rst b/Documentation/core-api/circular-buffers.rst
> > index 50966f66e398..b697915a2bd0 100644
> > --- a/Documentation/core-api/circular-buffers.rst
> > +++ b/Documentation/core-api/circular-buffers.rst
> > @@ -161,7 +161,7 @@ The producer will look something like this::
> >  
> >  	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
> >  		/* insert one item into the buffer */
> > -		struct item *item = buffer[head];
> > +		struct item *item = buffer->vals[head];
> >  
> >  		produce_item(item);
> >  
> > @@ -203,7 +203,7 @@ The consumer will look something like this::
> >  	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
> >  
> >  		/* extract one item from the buffer */
> > -		struct item *item = buffer[tail];
> > +		struct item *item = buffer->vals[tail];
> >  
> >  		consume_item(item);
> >  
> > -- 
> > 2.43.0
> 
>         Thanks, Akira
> 

