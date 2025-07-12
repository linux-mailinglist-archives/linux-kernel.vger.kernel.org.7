Return-Path: <linux-kernel+bounces-728822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA9B02D75
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5B51AA14FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 22:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091C522F74B;
	Sat, 12 Jul 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzlsQU+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB671A2632;
	Sat, 12 Jul 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752359122; cv=none; b=bZUU53M3KrRL/YeVN7i3gtHTupzdhsGHSC8aQmTqSHdK5v41TzHsYdy0fnvmvKWFqZdAsA08FIn9DjgjSOa7p1HaD5z3+N8hQmtzruAE5mZ+QD4vuQGDU8NjMAhuBUt/mpBJiIHE+XOjcLZUKTaFzqm+S3h07z/Y8j0TBiPrIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752359122; c=relaxed/simple;
	bh=Pb59kI0V+CsYfGf7Co6OsYTxadRWaErlQCZTbso4Y0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auGupQBKGBoGVeHaIWSqiGp+31VKfe7NbbJRecxoCtTcSicWx66n8S14yWTop7tXnurYRCgs1bGphGTSMvYfrbJrEfktYheb2TkKwqZ618cX0wR8pedN3s7yD3DVRdNg5owgpEXqPJrwyMlWLD6/2MzbxwHwOs6iHeoFsKXzOXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzlsQU+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3B5C4CEEF;
	Sat, 12 Jul 2025 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752359121;
	bh=Pb59kI0V+CsYfGf7Co6OsYTxadRWaErlQCZTbso4Y0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UzlsQU+eSL2Zytwxpn7KxvPBArBguAIJol3LHvMdEHhQGnmrzvkr92blGlFHxWlRo
	 Uj3vY4sMEtRSS7AXkS31RGNq30nu4MGWKLCWrqAuMGOxjoOphftZ6w9b7fyenTiqmL
	 iS0bDTAPwxa07A64cHdc3cfgYrNd9umkIWA3W6zUBs8JNyKYN/idBrVqPpVyxA+4Yi
	 j13cunyYEKn0vXFrrB6Ql1hcWH+nt1JUuWBhg0NMFDH8NlLG1MPwQSRRc92iFDhZjm
	 fFtLWpuOzxM0ncZj2TiSggbOShFv6uSquT1Wdlpdv+tFsmQO/QJ7Ppok05fBsRdnaQ
	 PiIaUtqOEadBg==
Date: Sun, 13 Jul 2025 00:25:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/2] docs: changes: better document Python needs
Message-ID: <20250713002517.7f52b0e9@foz.lan>
In-Reply-To: <20250712163155.GA22640@pendragon.ideasonboard.com>
References: <cover.1752307866.git.mchehab+huawei@kernel.org>
	<58c0cfb40e600af697b1665ffbc8e5bb3d859bb5.1752309145.git.mchehab+huawei@kernel.org>
	<20250712163155.GA22640@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 12 Jul 2025 19:31:55 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> Thank you for the patch.
> 
> On Sat, Jul 12, 2025 at 10:32:38AM +0200, Mauro Carvalho Chehab wrote:
> > Python is listed as an optional dependency, but this is not
> > true, as kernel-doc is called during compilation when DRM is
> > enabled. Better document that.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Isn't it only when CONFIG_DRM_HEADER_TEST is enabled ? That option
> depends on EXPERT && BROKEN, so I wouldn't expect it to be widely
> enabled. A quick grep shows that CONFIG_DRM_I915_WERROR does the same
> (with a dependency on EXPERT but not BROKEN though).

Well, EXPERT is currently enabled on several distros. The three ones I have
it handy all have it:

Fedora 42:
	$ grep CONFIG_EXPERT /boot/config*
	/boot/config-6.14.9-300.fc42.x86_64:CONFIG_EXPERT=y
	/boot/config-6.15.3-200.fc42.x86_64:CONFIG_EXPERT=y
	/boot/config-6.15.4-200.fc42.x86_64:CONFIG_EXPERT=y

Ubuntu 24.10:
	$ grep CONFIG_EXPERT /boot/config*
	/boot/config-6.11.0-26-generic:CONFIG_EXPERT=y
	/boot/config-6.8.0-60-generic:CONFIG_EXPERT=y

Debian 12:
	$ grep CONFIG_EXPERT /boot/config*
	/boot/config-6.1.0-34-amd64:CONFIG_EXPERT=y
	/boot/config-6.1.0-37-amd64:CONFIG_EXPERT=y
	/boot/config-6.1.0-37-rt-amd64:CONFIG_EXPERT=y

So, expert on distros seem quite common those days.

Fedora has it enabled for a long time. On Fedora 42:

	$ grep CONFIG_DRM_WERROR /boot/config*
	/boot/config-6.14.9-300.fc42.x86_64:CONFIG_DRM_WERROR=y
	/boot/config-6.15.3-200.fc42.x86_64:CONFIG_DRM_WERROR=y
	/boot/config-6.15.4-200.fc42.x86_64:CONFIG_DRM_WERROR=y

I would expect to have it enabled on other distros as well.

> Is there something else in DRM that invokes kernel-doc ?
> 
> > ---
> >  Documentation/process/changes.rst | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> > index bccfa19b45df..6a7d7c1ee274 100644
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
> > @@ -154,6 +154,13 @@ Perl
> >  You will need perl 5 and the following modules: ``Getopt::Long``,
> >  ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
> >  
> > +Python
> > +------
> > +
> > +At least Python 2.7 or 3.4 is required if CONFIG_DRM is selected to avoid
> > +breaking compilation. Documentation build and kernel-doc won't produce
> > +valid results if version is below 3.7.

Maybe I can place instead CONFIG_DRM_I915_WERROR.


Thanks,
Mauro

