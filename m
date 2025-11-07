Return-Path: <linux-kernel+bounces-890185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A11C3F6BC
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A10F4ED496
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC0305065;
	Fri,  7 Nov 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rftim6RO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1F21D3F8;
	Fri,  7 Nov 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511244; cv=none; b=Thjpl4P1y5HB6T2ak2b3OEqFp3hHSglZ7zgNtyWOUPSrnnBHew0+DKtezoyKQrWmpWnIgqes0Gm72wAdpOAexz9DYR21olcUUGzekrKUY2ybyCL/5ZnFUPbEhYCe+a4jv3t7Gvcj0mo2T3iv/Kdm9JM1ApJKrSZ/j6pIjvvfjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511244; c=relaxed/simple;
	bh=Gnt42O9rhYijO4KUfbQ9JnF/NlAmgpbQr2e14VAYYvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2/Ll/7LN71z4xG2vyNLqu0LpOWbgJA2AHoDE1ni64i0CWJJh3iIvSNVl2dFTGB/fJcEsyI3e7giDRdJv0a2ikKC+U8Dx8IWxYhUcYr/+Fk+9m/efbusgD/EHII3ua4MJvcV6XtuT0lQD5NFeRtiwZ6OKFR8mE/TC0un3WY38lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rftim6RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2834FC19421;
	Fri,  7 Nov 2025 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762511243;
	bh=Gnt42O9rhYijO4KUfbQ9JnF/NlAmgpbQr2e14VAYYvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rftim6ROXWpzJBZgVSz7zVyo94O04XFude0SiLMqtdwZRJ1Ij/wpPWMIzySd6CMed
	 C0ZPZnrnGiQhGB6BqvFZ1mKxH90m0CJ2+CXC+C2K2JoL4QE5+28eaBdBHGC/8ioCy+
	 ddEbkATVtPf+gcW3J6cE7KI+FXuW5d+y4HnjLa21c+uZ4fVLC1SD9f18gu9fCy4uoF
	 bwRzifCR0iFL9lq5mrDBvZcFirSim14qFqVB3pfCBHABQliJPyyG8A8QdmP4TyTHef
	 Uo3lYvnHbnA8uVXlxEMZhcmsnrM3XCnAnkdv0RBC8hyBkSZndAwaEKYE3wxWjbWqX/
	 CLWgj8ZjhAmyg==
Date: Fri, 7 Nov 2025 07:27:18 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Jani
 Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v3 0/8] Collect documentation-related tools under
 /tools/docs
Message-ID: <20251107072718.36bbda53@sal.lan>
In-Reply-To: <87h5visjn5.fsf@trenco.lwn.net>
References: <20251024200834.20644-1-corbet@lwn.net>
	<d3f4c7ee-6351-4c6f-ae93-f423245c4c9e@gmail.com>
	<20251026073405.0672c9dd@sal.lan>
	<874irkp97o.fsf@trenco.lwn.net>
	<87h5visjn5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 28 Oct 2025 17:15:26 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jonathan Corbet <corbet@lwn.net> writes:
> 
> >> 3. change the core of the logic to be something like:
> >> 
> >> 	# kerneldoc_bin = env.config.kerneldoc_bin
> >> 	kerneldoc_bin = os.environ.get("KERNELDOC")
> >> 
> >> 	if not kerneldoc_bin:
> >> 	   out_style = RestFormat()
> >> 	   kfiles = KernelFiles(out_style=out_style, logger=logger)
> >> 	else:
> >> 	    print(f"Generating C documentation by running {kerneldoc_bin} binary")
> >> 
> >>    this would still allow using KERNELDOC to point to a binary
> >>    that will handle C files executed as a separate process.  
> >
> > This seems like an obvious improvement, and one that, perhaps, should go
> > in ahead of my current series in the perhaps vain hope that we're
> > finally getting to the end of the list of things I can find to break...
> >
> > I can send a patch around in the next couple of days if you don't beat
> > me to it.  
> 
> So I have that change working just fine ... only one problem.
> 
> For this to work, we have to take out the definition of KERNELDOC in the
> top-level Makefile, otherwise we'll never go the import path.  But there
> are a few other Makefiles, mostly in the DRM area, that need that
> definition.

True, DRM makefiles run kernel-doc to check for warnings within the
DRM subsystem. 

>  So I have the docs build working, but I've broken other
> things, and I think people are getting tired of me breaking things.
> 
> Possible solutions:
> 
> - Add a new FORCE_KDOC environment variable that is used instead of
>   KERNELDOC to set the program to run in the docs build.

Works for me.

> - Keep the current logic that special-cases setting KERNELDOC to
>   scripts/kernel-doc.py and really runs in the imported mode in that
>   case.

Not sure if I got what you meant. Do you mean not running the classes
but always run exec() syscall? This will likely affect build time,
and prevent further speedup optimizations. It will also duplicate
warnings if we drop the output filter logic for warnings.

> 
> - Go into retirement and let it be somebody else's problem
> 
> Anybody have any other great ideas?
> 
> Thanks,
> 
> jon

