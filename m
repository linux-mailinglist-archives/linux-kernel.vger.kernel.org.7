Return-Path: <linux-kernel+bounces-749444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E103B14E78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4949189F2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93F1A2390;
	Tue, 29 Jul 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL3B3Vl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE2614EC62;
	Tue, 29 Jul 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796239; cv=none; b=nwaIEHE6zrgB1jyVG6eL+NefYTkh3Jrq+Jfi2VQYL6YbrjZEWplEpFl7W7CxlCMhibvJUtn8CWPQQRIDEzVCGuFsI28cFvl/ebEysFrqzy064WGwdT7DTJ80fAubEpd4Z0HVOk0ItJqZEp2cz/TDwKZuMdIHfG8ZdtOp5hhWqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796239; c=relaxed/simple;
	bh=Xl0gHGBGD/psSSEwLYabusCAgG7WRyptfJr0kzqU7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKxXDdjPkjkB6pRFlkpGxksl6jwjL5na0HqcWvrvWBvj820JlethNjt97WJ3qz+AKwD8i+AIfg6pPrW0hcuia/neNDaRhGleFDdohU/piKvkAm351tdYS5AF9qvWpFOS5A4l31SQBdDK/97Ih9dSzmvVk+0C4v7LLd/m+XIiFVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL3B3Vl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A29C4CEF5;
	Tue, 29 Jul 2025 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753796236;
	bh=Xl0gHGBGD/psSSEwLYabusCAgG7WRyptfJr0kzqU7Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TL3B3Vl+vFMuP4dNzrBz5Ae/hfSiV9q8AdhmbJfhQjG1ePAxGd9+fgDDPgreMlbky
	 Af/G8/+JnpeYYZHhnAoZB7FopraVrQavh7KDO3bb6WL3jwIT5MUKwS8plDMMtirm7L
	 az+A5/KHL7cWclnGsHf/c+BH9KAFBY6kJXYfp95N96k2ZMSq39YvA+WnJqY3Ay9oHv
	 a4xJlDTOg6icGvOWuYNLoQtrZUm/WF2FnyW65Y3PyoTuaJoEZwC2ofkbOrioYk9VDV
	 Pyrx9LsooKW196/yupVUbjXpevenDgzvA4ocudsxPpGmHIPhN8Z3N6OvRJlCwo/SkH
	 5AuU8PNd2ylkg==
Date: Tue, 29 Jul 2025 15:37:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 2/2] docs: changes: better document Python needs
Message-ID: <20250729153709.4040236a@sal.lan>
In-Reply-To: <3170902c-4a3a-4f85-8703-0e2cfc04201b@gmail.com>
References: <adb2d431b60228a772ec4423457a08e9af4b1d2d.1753713955.git.mchehab+huawei@kernel.org>
	<3170902c-4a3a-4f85-8703-0e2cfc04201b@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 29 Jul 2025 19:35:57 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [+CC Laurent and Jani]
> 
> Hi,
> 
> On Mon, 28 Jul 2025 16:54:29 +0200, Mauro Carvalho Chehab wrote:
> > Python is listed as an optional dependency, but this is not
> > true, as:
> > 
> > 1) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;
> > 
> > 2) kernel-doc is called during compilation when some DRM options
> >    like CONFIG_DRM_I915_WERROR are enabled;
> > 
> > 3) allyesconfig/allmodconfig will enable both.  
> 
> Well, these conditions still sound to me optional.

Then we agree to disagree: if a missing package prevents building
the kernel with allyesconfig/allmodconfig, IMO it is mandatory.

In any case, as Jani pointed out, DRM_MSM, which is part of arm
default configs also require Python. Building with clang also
requires it on several archs. There are other parts that
seem to require it, but I didn't dig into it.

So, IMHO, even if you consider allmodconfig/allyesconfig as
"optional", and you also consider clang as "optional" (it is marked
as optional at changes), it is still mandatory for arm 32-bit most
common  config (multi_v7_defconfig) and for arm64 defconfig.

It sounds pretty much mandatory to me: if a distro doesn't have
it, it can't support arm architectures.

IMO, it should not be tagged as optional there. At max, a note
under Python description could mention what scenarios one still
may not have it.

Now, adding a note like that means that someone would need to be
periodically updating it when people add more auto-generated
stuff that may require it.

> > So, better document that.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/process/changes.rst | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > index bccfa19b45df..f6abecf6da86 100644
> > --- a/Documentation/process/changes.rst
> > +++ b/Documentation/process/changes.rst
> > @@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
> >  GNU tar                1.28             tar --version
> >  gtags (optional)       6.6.5            gtags --version
> >  mkimage (optional)     2017.01          mkimage --version
> > -Python (optional)      3.9.x            python3 --version
> > +Python                 3.9.x            python3 --version
> >  GNU AWK (optional)     5.1.0            gawk --version
> >  ====================== ===============  ========================================
> >  
> > @@ -154,6 +154,17 @@ Perl
> >  You will need perl 5 and the following modules: ``Getopt::Long``,
> >  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
> >  
> > +Python
> > +------
> > +
> > +CONFIG_LTO_CLANG requires python 2.7 or 3.0+; some DRM config options like
> > +CONFIG_DRM_I915_WERROR require at least Python 2.7 or 3.4+.
> > +
> > +The kernel-doc tool and docs build require at least 3.6, but they depend on
> > +dict changes that happened on 3.7 to produce valid results.
> > +
> > +Other tools within the Kernel tree require newer versions.
> > +  
> 
> These details look confusing in changes.rst.  The table above says
> python >=3.9.x.  All you need to say here would just something lile:
> 
> +Python
> +------
> +
> +Required with CONFIG_LTO_CLANG, some DRM config options like
> +CONFIG_DRM_I915_WERROR, the kernel-doc tool, and docs build (Sphinx),
> +among others.
> 
> Other details can go to comments in each script or other docs if
> necessary.

Maybe something like:

Python
------

Several config options require it: it is required for arm/arm64
default configs, CONFIG_LTO_CLANG, some DRM optional configs,
the kernel-doc tool, and docs build (Sphinx), among others.

Regards,
Mauro

