Return-Path: <linux-kernel+bounces-813483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69557B54617
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106B3AA625F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10126E70E;
	Fri, 12 Sep 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI9RVXTq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E490270EBF;
	Fri, 12 Sep 2025 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667384; cv=none; b=Hfg9MelkEDeSX+RF71wK13eY9exCiRABo+jb2uxji0NTJ2C+HwZ5mwIcR8hEUmCn3SA+78aube+w8kZAbC2hB5teQc3mwfD2kFf2IzTr2a9lPmmRAy1Kp9pqpZA9KYOmEiqI2fcqW0En8v668EUEJdFHwfX/GV1hyhZHvACfPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667384; c=relaxed/simple;
	bh=aGj95vE+HeX/MtHrExL73IFxy035ObvEQTw/TraBBgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdU/eTrqIVstDy/NsSqELKYpnCKMq51NfSxVh9xiWcK6ktcpDbclYdK8sbcuOzALQKRmN8d4TGSKSYdIHqYhXX72auSddBDlOsI651gCAX1FbhXUz9AEQBg57QJNMoEuijJ1T5/ALok7kRz9ac6J03t9yWuYxeQoZ59+0+hoCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI9RVXTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA69CC4CEF4;
	Fri, 12 Sep 2025 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667384;
	bh=aGj95vE+HeX/MtHrExL73IFxy035ObvEQTw/TraBBgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eI9RVXTqOyiYKua4+r4sm1Qer0Q3SuzeF6YT1Lx2oudBBoL628Z6+OxTkwQrWo5gh
	 ZLl7cLy7RoqF8klYaLYUekNEWC76jg4UUk49thNxhTxDEZdKGLckXCkyYiaTAXWaBV
	 4AC/BDUr1O6+IUuZoFsStnaLduRtOZRqlhy73ixcSu3zvwmx6Lf8LDjKTC9ZvyoeLj
	 VJcSLgRFzdhb5nLKpZdwJIG1XfDvY7+iHhvm+iY95oR4QRhqixOWQU/roySf544WyR
	 8TnGKXVRb4kpMQirwco4vlixaDPELpVxu15mCpgmOPeNA4vtXdhvDcJ88Van2sADNA
	 b1po/Ed1Grv/g==
Date: Fri, 12 Sep 2025 10:56:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] docs: Makefile: document latex/PDF PAPER=
 parameter
Message-ID: <20250912105618.10e7953e@foz.lan>
In-Reply-To: <d20b612ee510c65dcd60183eda5068b164294759@intel.com>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<52411bce7bf0d068bfc8e33b35db3259c3ae0c64.1756969623.git.mchehab+huawei@kernel.org>
	<d20b612ee510c65dcd60183eda5068b164294759@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 10 Sep 2025 13:54:07 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > While the build system supports this for a long time, this was
> > never documented. Add a documentation for it.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 4736f02b6c9e..0e1d8657a5cc 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -126,4 +126,6 @@ dochelp:
> >  	@echo
> >  	@echo  '  make DOCS_CSS={a .css file} adds a DOCS_CSS override file for html/epub output.'
> >  	@echo
> > +	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
> > +	@echo
> >  	@echo  '  Default location for the generated documents is Documentation/output'  
> 
> The Sphinx make mode 'sphinx-build -M help' provides all of this and
> more...

So? Relying on a help message from sphinx-build would just make
our makefile fragile.

btw, it didn't work here:

	$ ./sphinx_latest/bin/sphinx-build --version
	sphinx-build 8.2.3

	 $ ./sphinx_latest/bin/sphinx-build  -M help
	Error: at least 3 arguments (builder, source dir, build dir) are required.

Thanks,
Mauro

