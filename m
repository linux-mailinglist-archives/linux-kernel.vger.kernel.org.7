Return-Path: <linux-kernel+bounces-822349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2227AB83992
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C574721742
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D682FFF9E;
	Thu, 18 Sep 2025 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAThHaqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2082F9DAF;
	Thu, 18 Sep 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185493; cv=none; b=NbfrIoFBR7RJmHLMnif9i5jk87PRuthA9Xe09wfdL9kEeCkvFaa94346z7VpmNFCMSnKgbf7NVH3ERfHWhbZyKfYQWWQGwmSIi52dy/gM6mtlIOuSE3xWOVxhnxs2aYvrnyJxea5l07g/T8J/Z7tQivIdtxpgfMsmvV52+u2UOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185493; c=relaxed/simple;
	bh=/03h3jsMxljIVekEltK1ygHyCyhWTpzD816qiyEvgvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2RvN3n/Lwi6DcbLsjQOv8dZxqAhfXmBgceQ04+hKddtQs8BQakHmn8LwTxleABCyFh6jTMkk0bnAxJX5cuwizz0hqHyb0TiLanpbRzhXDDGgay7NftYqo8P+MjMIdi0NDM7bUrh46PC3nXoAd1H02OAzLX4SNKv04narBdBkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAThHaqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02D4C4CEF1;
	Thu, 18 Sep 2025 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758185493;
	bh=/03h3jsMxljIVekEltK1ygHyCyhWTpzD816qiyEvgvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAThHaqVjK7RI8qOisp5Pyo0TGAfrdls7mAPINus76LrtU7OHcA/jChZSjx38rnwz
	 Z4d6ry615h6/6ZeoPFk/S8QJurPxRs12RQUPYM2MIrc1mzq0utETqnj4dWHbwShvrk
	 ZwgN722g4YWxcOF3nIneX+FkatxYWt+4HF9VCG9TGlVnDWdsMCUSpJhVHXpJk1btls
	 GhBdzYtypbKfGrrTzYoJyshHHRWX43EB52UJ9fm+4sLxeeKwCF4a5Wwfn116aHO+T0
	 KvqTk8Zgm1pt4T0CXfBID2K4ml/EAKB/14giWVR7AcXebtvDv0i1lZbmKlfTdfeGXi
	 Zrh1MK5hm3tmg==
Date: Thu, 18 Sep 2025 10:51:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/21] scripts: check-variable-fonts.sh: convert to
 Python
Message-ID: <20250918105124.3728661a@foz.lan>
In-Reply-To: <eaab7ba4-f23c-4c33-b9d1-faae73c136a4@gmail.com>
References: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
	<52932ede-eb04-4275-a051-952bc2859cf6@gmail.com>
	<20250917104818.62862b48@foz.lan>
	<eaab7ba4-f23c-4c33-b9d1-faae73c136a4@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Sep 2025 08:22:44 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> Hi,
> 
> On Wed, 17 Sep 2025 10:48:18 +0200, Mauro Carvalho Chehab wrote:
> > Em Wed, 17 Sep 2025 10:09:05 +0900
> > Akira Yokosawa <akiyks@gmail.com> escreveu:
> >   
> >> On Tue, 16 Sep 2025 12:22:40 +0200, Mauro Carvalho Chehab wrote:  
> >>> This script handle errors when trying to build translations
> >>> with make pdfdocs.
> >>>
> >>> As part of our cleanup work to remove hacks from docs Makefile,
> >>> convert this to python, preparing it to be part of a library
> >>> to be called by sphinx-build-wrapper.
> >>>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> >>
> >> I could apply up to 05/21 of v6 and did some quick tests under
> >> Fedora (where Noto CJK VF fonts are installed).
> >>
> >> At 3/21, "./scripts/check-variable-fonts.sh" doesn't say a word.
> >>
> >> At 4/21, "./scripts/check-variable-fonts.py" complains:  
> > 
> > I got a little bit confused with the above. I guess you picked the
> > wrong patch numbers, but yeah, there is a bisect issue, caused by
> > the part reorder I did moving this change to happen before adding
> > the script. Basically, I updated docs Makefile the wrong way.
> > 
> > Thanks for pointing it!
> > 
> > For v7 I'll ensure that all patches will properly print the suggestions
> > from the script.
> >   
> >> =============================================================================
> >> XeTeX is confused by "variable font" files listed below:
> >>     /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
> >>     /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
> >>     /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc
> >>
> >> For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
> >> Or, CJK pages can be skipped by uninstalling texlive-xecjk.
> >>
> >> For more info on denylisting, other options, and variable font, see header
> >> comments of scripts/check-variable-fonts.py.
> >> =============================================================================
> >>
> >> Of course, I have followed the suggestions in the header comments.  
> > 
> > I didn't try to follow the suggestions to solve the issue on Fedora yet.
> > It is on my todo list to test it.
> > 
> > The new script has an exact copy of the instructions of the previous one.
> > 
> > So, up to patch 09/21 from this series, there won't be any change at
> > doc build, except for the script conversion and some code cleanups
> > and reordering.
> > 
> > Patch 09/21 moves the env logic of FONTS_CONF_DENY_VF to the wrapper.
> > So, in thesis, fixing it before-after the series shouldn't have any
> > impact (I didn't test yet. Will do on my next respin). Btw, we should
> > probably document it at make help.
> > 
> > If the instructions from the header is wrong, we need to update it
> > on a separate patch series.
> >   
> 
> I have tested v7.
> 
> With v7 fully applied, it is now possible to build translations.pdf on
> Fedora.  Nice!
> 
> HOWEVER, running
> 
>     ./tools/docs/check-variable-fonts.py
> 
> still complains.  I'm not sure but there might be some minor issue (typo?)
> in the translation from .sh into .py ???
> 
> So I have to keep the NAK on v7's 7/24 ("scripts: check-variable-fonts.sh:
> convert to Python") for the moment.
> 
> Please run the script under a terminal session and see what happens ...

Yeah, there was a typo there. I fixed it for the next respin.

To better allow running it manually, I'm adding to the tool a new command
line argument:

	$ tools/docs/check-variable-fonts.py -h
	...
	options:
	  -h, --help         show this help message and exit
	  --deny-vf DENY_VF  XDG_CONFIG_HOME dir containing fontconfig/fonts.conf file

And changed the class __init__ logic to optionally use it:

    def __init__(self, deny_vf=None):
        if not deny_vf:
            deny_vf = os.environ.get('FONTS_CONF_DENY_VF', "~/deny-vf")

This way, it will keep using FONTS_CONF_DENY_VF (defaulting to ~/deny-vf),
yet allowing it to be overriden via command line:

	$ tools/docs/check-variable-fonts.py
	<no output>

	$ tools/docs/check-variable-fonts.py --deny-vf ~/deny-vf/
	<no output>

	$ tools/docs/check-variable-fonts.py --deny-vf ~/dont-deny-vf/
	=============================================================================
	XeTeX is confused by "variable font" files listed below:
	    /usr/share/fonts/google-noto-sans-cjk-vf-fonts/NotoSansCJK-VF.ttc
	    /usr/share/fonts/google-noto-sans-mono-cjk-vf-fonts/NotoSansMonoCJK-VF.ttc
	    /usr/share/fonts/google-noto-serif-cjk-vf-fonts/NotoSerifCJK-VF.ttc
	
	For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
	Or, CJK pages can be skipped by uninstalling texlive-xecjk.
	
	For more info on denylisting, other options, and variable font, run:
	
	    tools/docs/check-variable-fonts.py -h
	=============================================================================

Thanks,
Mauro

