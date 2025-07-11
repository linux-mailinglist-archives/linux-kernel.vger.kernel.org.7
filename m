Return-Path: <linux-kernel+bounces-727444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B3B01A46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1F616FE28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226428B7C6;
	Fri, 11 Jul 2025 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJaYsozx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70228A411;
	Fri, 11 Jul 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231891; cv=none; b=V8DdDRSLWCyami/wB6LT9UHAYXmE5tGt/8SBXlWxeKG++YayUfSReMIiD9RwHuV99UrXjgKauAwGFfjbG4Y30b+rJbP9cMJSRLN8+LOUJKkfM0ApanU/Z+6vjk3Msj5yxpTU4mk/S+ge4lktsg6GPULCaB8wkSS0e2QlSF32JuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231891; c=relaxed/simple;
	bh=za2rJxcZ2osXt3pn6Xn/ijEkRJ36GHTvknYmkuXDjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo1OGaUvCmqOWSrd930XCrhaHl48Iv7M2sdvFYAwlJPOvmgBaIC6lOlHzb3Ym56UvMfXCXo1CqQgeePcC45ME3/RG+zs/bHLLagLcfbdaZzxCBE/7z5Cozp3diimZ198AfeGcJKtBZ4pipAck+upuHgnz6w2GoEFdFd0+nKuPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJaYsozx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A540C4CEF6;
	Fri, 11 Jul 2025 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752231890;
	bh=za2rJxcZ2osXt3pn6Xn/ijEkRJ36GHTvknYmkuXDjCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dJaYsozxQ4sNUXd2oIBQ7wfxA8b7SDeY7f0BHvdFonmAetYvdp8L/I+Lw2jav5OW/
	 kQ/oVXivQk2mu2xaPm8cw481X9XM917aGy+RuiZsRHDxamMzM5T/zwM9EnNaGlKd2a
	 0RQCJ77UI3iOVT0IJKzcYWDRCASjvs5m+GmmTUgHCiqMeqUIYfZMbMR47WYEUPCbq5
	 HXynrnEU+wScyGv1zAfH9zfWNapUBBq5+a5ALiLX6QFMsllU8U+uo2cLPB9RLheHEZ
	 S8D/OYmn2Zs/lrVg5PjQnW8ZSr/F8Gq2j3fxvm3tUFqoBoQjiwsu/0s2wLgUNm5Yl5
	 n48WTx9vDQnJA==
Date: Fri, 11 Jul 2025 13:04:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/39] Translate sphinx-pre-install to Python
Message-ID: <20250711130446.1b761538@foz.lan>
In-Reply-To: <d12fb63e-b346-4094-b9d6-aa6823aea541@gmail.com>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
	<d12fb63e-b346-4094-b9d6-aa6823aea541@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 11 Jul 2025 19:49:41 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> [most CCs dropped]
> 
> On Wed,  9 Jul 2025 15:51:32 +0200, Mauro Carvalho Chehab wrote:
> [...]
> 
> > Please notice that my goal here is to test just this tool.
> > I didn't try to actually build the docs on every distro.  
> 
> I tested the docs build against opensuse/leap:15.6 for you, and
> the install completed. One step forward.
> 
> However, running "make latexdocs" ended up with the following error:
> 
> -----------------------------------------------------------------------------
> Exception occurred:
>   File "/usr/lib/python3.11/site-packages/sphinx/builders/latex/__init__.py", line 405, in copy_support_files
>     for filename in os.listdir(staticdirname):
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^
> FileNotFoundError: [Errno 2] No such file or directory: '/usr/lib/python3.11/site-packages/sphinx/texinputs'
> -----------------------------------------------------------------------------
> 
> That "texinputs" directory is supposed to hold files to be copied along
> with latex sources Sphinx will generate.
> 
> openSUSE is unique in that those files don't belong to its base Sphinx
> package.  They are provided in "python3-Sphinx-latex" (or
> "python311-Sphinx-latex", or any appropriate one for your base Sphinx
> package).
> 
> Is this news to you?

Yes, but it should be easy to add it at the tool. I'll address it, test
on Leap and submit it.

> By the way, 33/39 contains diff of test_script.py and can't be applied.
> I needed to remove the hunk manually and apply the remaining patches.

Sorry for that. I'll drop the hunk. I may eventually submit in separate
a patch series with the scripts I used for testing, but before that,
I guess we need first to move doc-related stuff to tools/docs, as
Jon suggested.

> Anyway, your translation of sphinx-pre-install into python is now at
> the bottom of my to-test/review list.  So no need to respin this.
> 
> As a matter of fact, I'm seeing weird performance regression of empty
> documentation builds when the O=<somedir> option is used.
> 
> It appeared in v6.15, which has your conversion of get_abi.pl into
> get_abi.py.  Will send a report once the time-consuming bisection
> completes.

Did you try with docs-next instead? I remember Jon caught one
issue causing the doctree cache to expire. Can't remember if this
was on 6.15 or at docs-next, but the fixes should be applied there.

Regards,
Mauro

