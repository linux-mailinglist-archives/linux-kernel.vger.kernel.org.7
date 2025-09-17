Return-Path: <linux-kernel+bounces-821117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2BB8078B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB9EC4E07C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0069328962;
	Wed, 17 Sep 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3zfuuZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076152E040E;
	Wed, 17 Sep 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122298; cv=none; b=OyS66A/IwaKE/PHhm+34ar5ByX/4BscIUJB2VlONY2PRrZ6aaiTbpKIfd1HMpBP4v+MhEruZQbYmY1r7UArsQwY+buy1kgdmYL511fpFgjAL5qd3UeMGDgHbwyzsZzc1ArhpQkoSos6sdO1o2FHhFF0jvqZp4xEpwINka1ZRoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122298; c=relaxed/simple;
	bh=y9WEoUVUu7lUvnuKGMu7ZFrltWJNm0HvJteHPeqQdWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX9nNKwEk90ATCGIqmG+GevgEtG9Ncdcy2FhoWDHvYfYSXfbcFQS/Uln54e3egH+DKwC0y6xU+iZcnzIGi8wuzeFvhB7wq5LKq82zAeVPDVKDSX0iKsDnQU3luvjAroCVVRrP6Tx5VM85T99ep1Owe8doXzRk0qpcJPAGAEEOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3zfuuZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F21C4CEE7;
	Wed, 17 Sep 2025 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758122295;
	bh=y9WEoUVUu7lUvnuKGMu7ZFrltWJNm0HvJteHPeqQdWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3zfuuZwAckI+SFGy5xCtjEy+F2/wOo/SolK4lX+raVYFvgRKhCEsC/K/NA+J7GrE
	 bX0oNDK1iQU6ZSbgBBdMvxKTPTjVGAjvsbxYbvcFG6gw3gGDBzXVxOd/w+pID+QR/B
	 ssNRLgf5m81oaxNNfwit+ZbF3WIkjtLvmw6RrXYtNNsF8OhuQOSRaSompBMQ0Nh9Xk
	 HZ54bpQk2UlNg34Mjgugc7TMda0gPqCfLWTy9bHP9q1E4Rjkj4PKnKY7HvwNEPJz9t
	 +7cPol1QYhC+fRLLUh9/60CzqmzN20jd3Je6/k++SJtHmOQ+4abmL+6HRfu9zJWtfb
	 cddaiSs3XPb0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uytvB-0000000CKcR-25Qy;
	Wed, 17 Sep 2025 17:18:13 +0200
Date: Wed, 17 Sep 2025 17:18:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: mchehab+huawei@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6 10/21] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <wasa5qgsl2fzltmcqgfapcel42op6waaqoqfwxvbz2jckotrep@rog4gu7mxztz>
References: <4d4dc78a4e29f2478fd1c1a746378dc61a090ca3.1758018030.git.mchehab+huawei@kernel.org>
 <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d454604-288d-4185-8567-836e06b3cbea@gmail.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Sep 17, 2025 at 05:35:31PM +0900, Akira Yokosawa wrote:
> [+CC: Jani, -CC: rust people and list]
> 
> On Tue, 16 Sep 2025 12:22:46 +0200, Mauro Carvalho Chehab wrote:
> > There are too much magic inside docs Makefile to properly run
> > sphinx-build. Create an ancillary script that contains all
> > kernel-related sphinx-build call logic currently at Makefile.
> > 
> > Such script is designed to work both as an standalone command
> > and as part of a Makefile. As such, it properly handles POSIX
> > jobserver used by GNU make.
> > 
> > On a side note, there was a line number increase due to the
> > conversion (ignoring comments) is:
> > 
> >  Documentation/Makefile          |  131 +++----------
> >  tools/docs/sphinx-build-wrapper |  293 +++++++++++++++++++++++++++++++
> >  2 files changed, 323 insertions(+), 101 deletions(-)
> > 
> > Comments and descriptions adds:
> >  tools/docs/sphinx-build-wrapper | 261 +++++++++++++++++++++++++++++++-
> > 
> > So, about half of the script are comments/descriptions.
> > 
> > This is because some things are more verbosed on Python and because
> > it requires reading env vars from Makefile. Besides it, this script
> > has some extra features that don't exist at the Makefile:
> > 
> > - It can be called directly from command line;
> > - It properly return PDF build errors.
> > 
> > When running the script alone, it will only take handle sphinx-build
> > targets. On other words, it won't runn make rustdoc after building
> > htmlfiles, nor it will run the extra check scripts.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile          | 131 ++-----
> >  tools/docs/sphinx-build-wrapper | 581 ++++++++++++++++++++++++++++++++
> >  2 files changed, 611 insertions(+), 101 deletions(-)
> >  create mode 100755 tools/docs/sphinx-build-wrapper
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 7570d4cf3b13..4736f02b6c9e 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -23,21 +23,22 @@ SPHINXOPTS    =
> >  SPHINXDIRS    = .
> >  DOCS_THEME    =
> >  DOCS_CSS      =
> > -_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
> 
> Wait!  In the cover-letter, you said:
> 
>     It should be noticed that it is out of the scope of this series
>     to change the implementation. Surely the process can be improved,
>     but first let's consolidate and document everything on a single
>     place.
> 
> Removing current restriction on SPHINXDIRS does look inconsistent with
> your own words to me.

You misread the patch. Look better some hunks below:

    +# Used only on help
    +_SPHINXDIRS   = $(sort $(patsubst $(srctree)/Documentation/%/index.rst,%,$(wildcard $(srctree)/Documentation/*/index.rst)))
    +

Patch doesn't remove _SPHINXDIRS. It just moves it to be closer to the
help and document that this is used only there.

> 
> So, I guess I have to NAK 06/21 as well.
> 
> Regards,
> Akira
> 

-- 
Thanks,
Mauro

