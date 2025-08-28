Return-Path: <linux-kernel+bounces-790856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C8B3AE60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CDD4680B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FD2D061A;
	Thu, 28 Aug 2025 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PSVd2B8l"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E07082D;
	Thu, 28 Aug 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423191; cv=none; b=niYKaYHovYElsWRvehCjuJ0bwwVnR+DzPCCL2U9FAEHp6B46GXUtsX5tQnJEPIpGsrXZYyBuPHmO+MCyQ/E7VOJxU5Qe51ib88rj9F/4W9f6yZjXb8rqgKxB0/ZjGipFnWCiNM3pRYbSDKtybJbk+dHp3FKgp+YTjVkfyQK4DiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423191; c=relaxed/simple;
	bh=MbkhkeeQnY7QmmuHl+SC+zlCJnWYkl+P18QjJWxIOT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFrCF2QuLMEzrCOiXwlqbAGdbanA6RQX8vbOxD98F5BqRnnpCOnUfeQe/VQhqLUKJifHBpy51sSlZAk5FaRMbg7R5OIWqZAW5JcXTsCC3OeNzX7gYFcE38bykj6RZNA+bsucT2o+YWK7D3ygkIrbvyrcEd99FJFO5oPnib90USc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=PSVd2B8l; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (212-76-243-235.access.telenet.be [212.76.243.235])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 759E01129;
	Fri, 29 Aug 2025 01:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756423122;
	bh=MbkhkeeQnY7QmmuHl+SC+zlCJnWYkl+P18QjJWxIOT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSVd2B8lno8KN4PP07hYJCEIvZPBwlJK8xNbsbUocQlMkFbQCHlp+TPxurJJssOAH
	 cfrW2Dsg4n0owzjQaDehazfOGiIKQ4pqfaxznf3kVCa0CuXEfkf+KIXgzT7Ny12WNx
	 79cTPrURYOsjmj9idIxvxbqqiPEJqi7FeW50ZVdk=
Date: Fri, 29 Aug 2025 01:19:25 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Fox Foster <fox@tardis.ed.ac.uk>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <20250828231925.GB9916@pendragon.ideasonboard.com>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net>
 <20250827113312.62162725@foz.lan>
 <aK_XIoncppxWp7sB@archie.me>
 <d0070beb-f6fd-477c-a315-a2c6db99c227@infradead.org>
 <aLDhY00iaiMYV4Lg@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLDhY00iaiMYV4Lg@archie.me>

On Fri, Aug 29, 2025 at 06:08:19AM +0700, Bagas Sanjaya wrote:
> On Wed, Aug 27, 2025 at 09:18:57PM -0700, Randy Dunlap wrote:
> > On 8/27/25 9:12 PM, Bagas Sanjaya wrote:
> > > On Wed, Aug 27, 2025 at 11:33:12AM +0200, Mauro Carvalho Chehab wrote:
> > >> Considering that "know" (noun) seems to be a shortcut
> > >> for "knowledge", what about:
> > >>
> > >> 	They "had better knowledge about the details than you"
> > > 
> > > That can be alternative.
> > 
> > Nope, afraid not. Just leave it as is or (I think) 2 people have suggested
> > something like "They should know better about the details than you".
> 
> Should I send v3 then using "should" wording as you mentioned?

Let's leave it as is, I don't think this mail thread is being very
productive. If someone wants to rework the whole document as Jon
suggested that seems worth it, but spending time discussing this
particular sentence isn't a very good use of time.

-- 
Regards,

Laurent Pinchart

