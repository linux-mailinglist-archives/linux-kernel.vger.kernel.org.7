Return-Path: <linux-kernel+bounces-747871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD14B1395C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E82179466
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFBE24EA80;
	Mon, 28 Jul 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qirASrLX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8B19E96D;
	Mon, 28 Jul 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700206; cv=none; b=QboT1mV+M8yUd8T/tGc0eq07/GdhyifRywd1AgAntn5MfznxPOa9Sxv1uj48KuaSSGDOA6hlhjlWkZpUJV+R10vOldnWb3Tj8qOPa+qHoz+MaT6+AWUg+sZ3jvZ0DZc9qN/e7fEv11NYUkgJ7SV2syazC32+oY/aXPXTy4g8cHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700206; c=relaxed/simple;
	bh=6v5l+SGws6eU5rcGvZDcWB3QUuuC6ppDE6v+bXjfM24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoiWak8l5d+E8hD4uvqkzf5VWx7torpIAp3kVNCGYXaSIHREcc2bwsQozbXVgKr01ZCFWQugjVRhop8X9b7bgqxoLntHc6RPSjXPAW/Wycdijib2vcKU32Z05uAik4wIrphuoWp/r2QqGi8Q8bOIc6ydu066mRaO7jJHdsq6x18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qirASrLX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7EFB7446;
	Mon, 28 Jul 2025 12:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753700159;
	bh=6v5l+SGws6eU5rcGvZDcWB3QUuuC6ppDE6v+bXjfM24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qirASrLXDOxyLp7/oYBYjS1pQt9kZP4oX9eMvJcyGOfoiBB5mVW516RWU2ZG18UbD
	 VbV6UXQSuZQXVeEDpqSEjJHW6MIdzcGM8ZtQ29L1XpfZ2yyOt7zuDh9mulsx//I17t
	 IVewpsqdEUkXOhiCcLtRpxhtnR4XEIzrhfKQ83Qg=
Date: Mon, 28 Jul 2025 13:56:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg KH <greg@kroah.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250728105634.GF787@pendragon.ideasonboard.com>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025072854-earthen-velcro-8b32@gregkh>

On Mon, Jul 28, 2025 at 12:35:02PM +0200, Greg KH wrote:
> On Mon, Jul 28, 2025 at 09:42:27AM +0100, Lorenzo Stoakes wrote:
> > +cc Linus
> > 
> > On Sun, Jul 27, 2025 at 03:57:58PM -0400, Sasha Levin wrote:
> > > This patch series adds unified configuration and documentation for coding
> > > agents working with the Linux kernel codebase. As coding agents
> > > become increasingly common in software development, it's important to
> > > establish clear guidelines for their use in kernel development.
> > 
> > Hi Sasha,
> > 
> > I feel like we need to take a step back here and consider some of the
> > non-technical consqeuences of this change.
> > 
> > Firstly, there is no doubt whatsoever that, were this series to land, there
> > would be significant press which would amount to (whether you like it or
> > not) 'Linux kernel welcomes AI patches'.
> > 
> > I don't feel that a change of this magnitude which is likely to have this
> > kind of impact should be RFC'd quietly and then, after a weekend, submitted
> > ready to merge.
> > 
> > This change, whether you like it or not - amounts to (or at the very least,
> > certainly will be perceived to be) kernel policy. And, AFAIK, we don't have
> > an AI kernel policy doc yet.
> > 
> > So to me:
> > 
> > - We should establish an official kernel AI policy document.
> 
> Steven Rostedt is working on this right now, hopefully he has something
> "soon".
> 
> > - This should be discussed at the maintainers summit before proceeding.
> 
> Sounds reasonable as well.
> 
> But I think that Kees and my earlier points of "the documentation should
> be all that an agent needs" might aleviate many of these concerns, if
> our documentation can be tweaked in a way to make it easier for
> everyone, humans and bots, to understand.  That should cut down on the
> "size" of this patch series a lot overall.
> 
> > In addition, it's concerning that we're explicitly adding configs for
> > specific, commercial, products. This might be seen as an endorsement
> > whether intended or not.
> 
> Don't we already have that for a few things already, like .editorconfig?

We do, but isn't .editorconfig a vendor-neutral solution ?

-- 
Regards,

Laurent Pinchart

