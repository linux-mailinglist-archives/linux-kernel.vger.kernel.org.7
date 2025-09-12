Return-Path: <linux-kernel+bounces-814312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662BAB55248
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F025A00AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9130E0E7;
	Fri, 12 Sep 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxLH01ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52637191493;
	Fri, 12 Sep 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688638; cv=none; b=PSaO2oEw/q3jYDvT7Ed+avO44ASMmdojB/S1lVBcYl6KsIDc/wxj2VHUi/iQ2uhVN5FWonik7/WbGIWd+NSf/8q2tZGygQaV1duGy2o6XDOBIGuphp3Io49tRzS7JeOTUSu539Y7IW4psRvH2tOEeRb6/iEpjfg+xCOomPEU0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688638; c=relaxed/simple;
	bh=9eZk9095w1WZhXBeISMQg21C+JnxIll3pGEFVK/1qFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3+cNMiKrYVz3hK1vIG4sJb3zWTJOD+1aMFqY/Laj3LWlFDj7QHrxPbzYVyrFnoQZCmLR/jbM0K7W78WJeCrtlXg1x5btH+MGjEIHTFMm6rZx21pLfXQC5hrksV9WSmFpqSDlkRUI5p/pnNFbhQFkSsaJ0H/loRba9R+QYQKsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxLH01ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9913C4CEF1;
	Fri, 12 Sep 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757688637;
	bh=9eZk9095w1WZhXBeISMQg21C+JnxIll3pGEFVK/1qFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxLH01chw4zHcXhxpCsI6X1hd8kZjfDtRLhomhhSF/RgnsxhehpTLfl+SpOPz4U3/
	 Mhaoe6WBST1JB2w/T8cHD0u07N3qyp11s6IeYS/587BOPVgVDxty0uxZhpjWZB6xfu
	 QRa0fBbjyciDBNfULxOwa4A1cKe497uh4iU8DhaRGvPQAJnLCnrJVOQO5+2wJwCVfw
	 hfh/ibu72y1TEUKh+W3ZI4DSR0FyV7VwzOf4/rDZDiDHprwlcYCnoSaU33Nt+LeDC+
	 dG4Em74VWYcGXRtukDNVOl1hmkBUmJ8dqT1bCHTzGeCcmYIrwpZ3Vif6BUqEWL/Kzg
	 fT08iHlbIzvlg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux56i-00000008WGO-0PcR;
	Fri, 12 Sep 2025 16:50:36 +0200
Date: Fri, 12 Sep 2025 16:50:36 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, corbet@lwn.net, 
	jani.nikula@linux.intel.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Sep 12, 2025 at 11:03:43PM +0900, Akira Yokosawa wrote:
> On Fri, 12 Sep 2025 13:04:20 +0200, Mauro Carvalho Chehab wrote:
> > Em Fri, 12 Sep 2025 19:15:44 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> > 
> >> [-CC: rust people and list]
> >>
> >> OK, Looks like I have to bite.
> >>
> >> On Wed, 10 Sep 2025 15:33:34 +0200, Mauro Carvalho Chehab wrote:
> >> [...]
> >>
> >>> The current approach of using LaTeX for PDF is dirty:
> >>>
> >>> - Sphinx can't produce a LaTeX file from the Kernel trees without
> >>>   hundreds of warnings;
> >>> - latexmk hides some of them, but even it just one warning is reported,
> >>>   the return status is not zero.  
> >>
> >> This sounds interesting to me.
> >> As far I remember, I have never seen such strange results of latexmk
> >> under build envs where all the necessary packages are properly installed.
> > 
> > I saw it here on multiple distros including Fedora (which is the one
> > I use on my desktop). Media jenkins CI running on Debian always suffered
> > from such issues, up to the point I started ignoring pdf build results.
> > 
> 
> So please provide exact steps for me to see such errors.

Sorry, but I don't have enough time to try reproducing it again
(plus, I'm ran out of disk space on my /var partition forcing me to
reclaim the space used by my test containers).

> 
> I don't have any issues after strictly following the suggestions from
> sphinx-pre-install under Fedora.
> 
> I even invoked [...]/output/latex/Makefile manually after running
> "make latexdocs" by:
> 
>   - cd [...]/output/latex/
>   - make PDFLATEX="latexmk -xelatex" LATEXOPTS="-interaction=batchmode -no-shell-escape" -j6 -O all
> 
> , and all the PDFs were built without any issues.
> 
> Quite puzzling ...
> 
> Or does your Fedora have some Noto CJK variable fonts installed?

On my main desktop, yes, that's the case: it currently has some
Noto CJK fonts installed. I wasn't aware about such issues
with Fedora until today, when I noticed your check script.

On my test containers, all docs were built even on Fedora.

Yet, the issue that forced us to add "|| exit" hack to ignore PDF
build errors is not new. As I pointed, at least since 2017 we
have a hack due to that our Makefile, but I guess we had an older
hack as well.

I dunno the exact conditions, but depending on latex version, distro, 
if the computer is in bad mood, if it is rainning - or whavever other
random condition - even when all PDF docs are built, make pdf inside
output/latex may return non-zero, for warnings. Maybe it could be
also related of using latexmk or calling xelatex directly.

If I recall corretly, we added latexmk to fix some of such build
issues.

-

In any case, this changeset fix it on several ways:

- A failure while building one pdf doesn't prevent building other
  files. With make, it may stop before building them all (if we drop
  the "|| exit");
- It prints a summary reporting what PDF files were actually built,
  so it is easy for the developer to know what broke (and it is
  also easily parsed by a CI);
- The return code is zero only if all docs were built.

-- 
Thanks,
Mauro

