Return-Path: <linux-kernel+bounces-711644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512CAEFD88
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 17:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9E1656B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275F275108;
	Tue,  1 Jul 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mReJQHnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9727935F;
	Tue,  1 Jul 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381857; cv=none; b=SS+7Fo6MzEqbYpLYQoEK6SEsnnzYCILU10uMzTw1l5bIzYK2BrUiRwMsINSEI0upQ1xLr26MrjTxPIoIKWrZH1sMggKw50LxcNB4AnyxuE+Lt5k4eZttC0b5OGG9tv2vPQQoGtNYEiHrIjwvss1S188N3rgOuACUxJRlySlFedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381857; c=relaxed/simple;
	bh=zytX0gt/ByuFXfsGeNFtSW+Q9wpGSV3HZoRdbykqG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfeOTHXIHQRRmeo/saFl19OYpPbiJDB+HXHGADk2i84jv2dGZt9NwVOZUDZh95wr08DeULD1fWrHbNPuhgjiecalN5a27Ty86QQNfoXC8o4ZBkN8laNAIyHa7V/eEArhBkWPaEtYIbe36t0LMrXVWHgs20NZ7LRvGSmajKSRQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mReJQHnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FC3C4CEEB;
	Tue,  1 Jul 2025 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751381856;
	bh=zytX0gt/ByuFXfsGeNFtSW+Q9wpGSV3HZoRdbykqG+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mReJQHnzEMiLZyiRv5ZVnjueyz7RXQzy4om0oFgY5nY6S21Oy+sd9oeu6drqAIgsN
	 vM6ev8ykHWkd6K+wo5bQ4BW0nF7Zvqv1JbXUAuXS5yberQiWwBJf2OjLaRbDK60BEk
	 rOy495/HCSpiWhFVcevnOt6yezZoJ/WSV/AZUSZpNHuAwsklSMX+tW3viCIWFWsGVi
	 svnbA/VCgr0KlsbDTYhFxIgtTExy9lILQoe76Sc/r8oVMIcH1SqgMAFrJTN+s3Pn9d
	 WY5LfBRS7GfZKEDkGy5G3XoawxGrBHJCuVVYE9exu4dzKa3gQZQEvVZs3AcGJ/rpgp
	 SfSX70wxzpoCw==
Date: Tue, 1 Jul 2025 07:57:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Brahmajit Das <listout@listout.xyz>, Carlos Maiolino <cem@kernel.org>,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/xfs: replace strncpy with strscpy
Message-ID: <20250701145736.GE10009@frogsfrogsfrogs>
References: <BgUaxdxshFCssVdvh_jiOf_C2IyUDDKB9gNz_bt5pLaC8fFmFa0E_Cvq6s9eXOGe8M0fvBUFYG3bqVQAsCyz3w==@protonmail.internalid>
 <20250617124546.24102-1-pranav.tyagi03@gmail.com>
 <qlogdnggv2y4nbzzt62oq4yguitq4ytkqavdwele3xrqi6gwfo@aj45rl7f3eik>
 <CAH4c4jLjiBEqVxgRG0GH37RELDp=Py3EoY6bcJhzA+ydfV=Q1A@mail.gmail.com>
 <ldak3a3zmqlkv67mjproobt4g7pe6ii7pkqzzohd5o5kyv64xw@r63jjlqzafzp>
 <CAH4c4jJcyA+=x5y3BrW7dQkWOM3bVTepH0W16cm+_CLqHr4hfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH4c4jJcyA+=x5y3BrW7dQkWOM3bVTepH0W16cm+_CLqHr4hfw@mail.gmail.com>

On Tue, Jul 01, 2025 at 02:18:12PM +0530, Pranav Tyagi wrote:
> On Mon, Jun 30, 2025 at 7:48 PM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > On 30.06.2025 14:36, Pranav Tyagi wrote:
> > ... snip ...
> > > > >       spin_unlock(&mp->m_sb_lock);
> > > > >
> > > > >       if (copy_to_user(user_label, label, sizeof(label)))
> > > > > --
> > > > > 2.49.0
> > > > >
> > >
> > > Hi,
> > >
> > > Thank you for the feedback. I understand that my patch is incorrect and
> > > it causes a buffer overrun. The destination buffer is indeed, already, null
> > > terminated. Would you like me to send a corrected patch which uses
> > > strscpy() (as strncpy() is deprecated)?
> > >
> > If the destination buffer is already NUL terminated, you can use either
> > strtomem or strtomem_pad [0].
> >
> > [0]: https://docs.kernel.org/core-api/kernel-api.html#c.strncpy
> > (Description)
> 
> Thank you for the suggestion. On going through [0], I see that,
> both, strtomem and strscpy require the src to be null
> terminated. As far as I know, sb_fname buffer has a size of
> XFSLABEL_MAX (12 bytes). This means no terminating NULL
> for the src. So shouldn't memcpy() be the right function to use here?

memtostr_pad?

--D

> > > Regret the inconvenience.
> > >
> > > Regards
> > > Pranav Tyagi
> > >
> >
> > --
> > Regards,
> > listout
> 

