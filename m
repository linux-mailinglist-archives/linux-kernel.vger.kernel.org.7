Return-Path: <linux-kernel+bounces-729004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85957B03071
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 11:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7123B4DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9538225779;
	Sun, 13 Jul 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CWxr3Rr4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFF5D8F0;
	Sun, 13 Jul 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752398866; cv=none; b=VY+0TvV6Eh/t6XSKOeq3kHSRH5I6Yy/fSf7lTrh8A0v2+HTOYO7sLUayGAI2zfZ+hEI8EYXTQtdtSFXcxI7TVMT1aTI9Nl/tWne8xRJx0o7wOXCGeOJ2WCj0/Xzj4Ee2r/1RKuyDgSz51jI8TTQCjrNSpIKg3/JvsI7anmJYCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752398866; c=relaxed/simple;
	bh=T42cfsc+7VU7rLmZUluCFiFQFi4Cq1hv3QS+DPaGt1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucomEX48mRubfMv5SdOrH9F4vjCnrT60324HlspYl+NuTN1L+T+4vvXCrBEuhKmCxn+Nou3zIvtPUYVsIJY6FFnVYDvYjQXesgC0HZ7rpA36hhIHjYBLtI+mnguJMU/vGE0PYS6bBTlnQau0GNRhNzNNDnhk1D5tkmNxkHQn57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CWxr3Rr4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 3712C3DC;
	Sun, 13 Jul 2025 11:27:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1752398831;
	bh=T42cfsc+7VU7rLmZUluCFiFQFi4Cq1hv3QS+DPaGt1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWxr3Rr4jzTDt/oGy6ek/20W0/eajivzHVs21lcz7NbtdmnDQlxDsql5ocKADhg6I
	 fg49idYEN60XhBIO0AH5fB7LJRNcVt4jHXHvlc97l7Orp97hI30OwqIx/lZnKBQP53
	 zE564JaUOQpyRlFzICngTAaDZ2qUcybkq8SvKMN8=
Date: Sun, 13 Jul 2025 12:27:10 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250713092710.GB22640@pendragon.ideasonboard.com>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
 <58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
 <20250712163155.GA22640@pendragon.ideasonboard.com>
 <20250713002517.7f52b0e9@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250713002517.7f52b0e9@foz.lan>

On Sun, Jul 13, 2025 at 12:25:17AM +0200, Mauro Carvalho Chehab wrote:
> Em Sat, 12 Jul 2025 19:31:55 +0300 Laurent Pinchart escreveu:
> 
> > Hi Mauro,
> > 
> > Thank you for the patch.
> > 
> > On Sat, Jul 12, 2025 at 10:32:38AM +0200, Mauro Carvalho Chehab wrote:
> > > Python is listed as an optional dependency, but this is not
> > > true, as kernel-doc is called during compilation when DRM is
> > > enabled. Better document that.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Isn't it only when CONFIG_DRM_HEADER_TEST is enabled ? That option
> > depends on EXPERT && BROKEN, so I wouldn't expect it to be widely
> > enabled. A quick grep shows that CONFIG_DRM_I915_WERROR does the same
> > (with a dependency on EXPERT but not BROKEN though).
> 
> Well, EXPERT is currently enabled on several distros. The three ones I have
> it handy all have it:
> 
> Fedora 42:
> 	$ grep CONFIG_EXPERT /boot/config*
> 	/boot/config-6.14.9-300.fc42.x86_64:CONFIG_EXPERT=y
> 	/boot/config-6.15.3-200.fc42.x86_64:CONFIG_EXPERT=y
> 	/boot/config-6.15.4-200.fc42.x86_64:CONFIG_EXPERT=y
> 
> Ubuntu 24.10:
> 	$ grep CONFIG_EXPERT /boot/config*
> 	/boot/config-6.11.0-26-generic:CONFIG_EXPERT=y
> 	/boot/config-6.8.0-60-generic:CONFIG_EXPERT=y
> 
> Debian 12:
> 	$ grep CONFIG_EXPERT /boot/config*
> 	/boot/config-6.1.0-34-amd64:CONFIG_EXPERT=y
> 	/boot/config-6.1.0-37-amd64:CONFIG_EXPERT=y
> 	/boot/config-6.1.0-37-rt-amd64:CONFIG_EXPERT=y
> 
> So, expert on distros seem quite common those days.

But not CONFIG_BROKEN, right ? That would leave only
CONFIG_DRM_I915_WERROR.

> Fedora has it enabled for a long time. On Fedora 42:
> 
> 	$ grep CONFIG_DRM_WERROR /boot/config*
> 	/boot/config-6.14.9-300.fc42.x86_64:CONFIG_DRM_WERROR=y
> 	/boot/config-6.15.3-200.fc42.x86_64:CONFIG_DRM_WERROR=y
> 	/boot/config-6.15.4-200.fc42.x86_64:CONFIG_DRM_WERROR=y
> 
> I would expect to have it enabled on other distros as well.

CONFIG_DRM_WERROR doesn't seem related to running kernel-doc though, is
it ?

> > Is there something else in DRM that invokes kernel-doc ?
> > 
> > > ---
> > >  Documentation/process/changes.rst | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > > index bccfa19b45df..6a7d7c1ee274 100644
> > > --- a/Documentation/process/changes.rst
> > > +++ b/Documentation/process/changes.rst
> > > @@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
> > >  GNU tar                1.28             tar --version
> > >  gtags (optional)       6.6.5            gtags --version
> > >  mkimage (optional)     2017.01          mkimage --version
> > > -Python (optional)      3.9.x            python3 --version
> > > +Python                 3.9.x            python3 --version
> > >  GNU AWK (optional)     5.1.0            gawk --version
> > >  ====================== ===============  ========================================
> > >  
> > > @@ -154,6 +154,13 @@ Perl
> > >  You will need perl 5 and the following modules: ``Getopt::Long``,
> > >  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
> > >  
> > > +Python
> > > +------
> > > +
> > > +At least Python 2.7 or 3.4 is required if CONFIG_DRM is selected to avoid
> > > +breaking compilation. Documentation build and kernel-doc won't produce
> > > +valid results if version is below 3.7.
> 
> Maybe I can place instead CONFIG_DRM_I915_WERROR.

I think that's better. I also wouldn't consider CONFIG_DRM_I915_WERROR
to make Python "required".

-- 
Regards,

Laurent Pinchart

