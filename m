Return-Path: <linux-kernel+bounces-752467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B2B175DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED0AC7B8C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953628FFD8;
	Thu, 31 Jul 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihJWYAKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C313D51E;
	Thu, 31 Jul 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984542; cv=none; b=D7EtETPVJxDqV0xAV0u9OvJrNs399qF3deJlhpi/kEj4xyQZu6Z286lpnU6pgrjPXmMUR5gPxKBS71oWx2cak77uDFVIA4XKJG2xaaOYKgSYGGdEi2NCxUVncOXoOT49CEhH+iORPH8kl7dXfKnQZ9yWjh2uV/8DIyuv8fpI5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984542; c=relaxed/simple;
	bh=hvb9Z7U61i0WAoBKCawzhOgRTTsbdjytLuv86CZZdZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5EOS/R9S6ngy6581pse8J6X7ClmkxwSB/sfKZP9bbGwR7RcWA6HFG5NYl8xRIffDCASIpQs/J9cHPn50BL1Q+J4Pa3c2QBj6T3KfgrB+PQxatmgV1PvjHtTGTfRNqA2GrpsmZzT89DSI3dDCDlJ6SPMOhmNq2IQ6GQf6m94emU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihJWYAKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E2C4CEEF;
	Thu, 31 Jul 2025 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984541;
	bh=hvb9Z7U61i0WAoBKCawzhOgRTTsbdjytLuv86CZZdZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihJWYAKHyN/LkjwFFtzyJGwcXcM+vx532WAz8YUX885QbQbDyKMLGjY726KiETxnj
	 tVKP++z/TAIcrVvgviEiVYUL3iJCDqVWKd6lqGCnZuhXgFJSvbH3dHJGig16WW/i7Z
	 3IHiNI8Zlr9gpijdEs0x+fyjl+T888cDaou8OaSwTKIbNloNNvpnn1hZWhJ4TQCXdx
	 6o6Updz4ATLZ1Ct2m9YIaS0YluFFPp9Cil01Mz/TnU5DUWbw5bhUb0v2mNV9JaO6i7
	 ipecFIBWDYzAkVaHFEWKkr6sJ0WeMaE2nQVkkEoqruhprtcK138jHP7rRU32XK6tWV
	 KiJ+/F+F6ZK1w==
Date: Thu, 31 Jul 2025 19:55:36 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Sai Vishnu M
 <saivishnu725@gmail.com>
Subject: Re: [PATCH 00/15] Translate sphinx-pre-install to Python
Message-ID: <20250731195536.6075afe2@foz.lan>
In-Reply-To: <20250731135107.6c2b32c2@foz.lan>
References: <cover.1751318230.git.mchehab+huawei@kernel.org>
	<d37eab74-a034-4be6-b92b-e0da60a99477@gmail.com>
	<87bjpu69q3.fsf@trenco.lwn.net>
	<9148ae7f-7954-421e-b5dc-366651f0bc48@gmail.com>
	<20250731135107.6c2b32c2@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 13:51:07 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Tue, 8 Jul 2025 23:56:01 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
> > > My question would be: are the results somehow worse than those provided
> > > by the existing, Perl script?  
> > 
> > Not at all.  Mauro made some improvements WRT opensuse/leap over the perl
> > one, but there remain a lot of rooms for improvements here and there. 
> > 
> > I've been ignoring sphinx-pre-install all these years, but the impressive
> > test results presented in this cover-letter made me test it.
> 
> I'm now working to fix PDF generation, assuming that all packages from
> sphinx-pre-install are installed.
> 
> I'm placing the patches on my scratch tree at:
> 	https://github.com/mchehab/linux/tree/my-docs-next
> 
> It contains several branches merged there in sequence:
> 	- elder_python_v1: makes kernel-doc run with elder kernels (2 patches);
> 	- netlink_v10: patches adding an yaml parser for netlink (14 patches);
> 	- sphinx-pre-install-v4: current version of this series (39 patches);
> 	- pdfdocs: specific fixes for PDF doc generation (11 patches);
> 	- sphinx-build-wrapper: a new script with a large cleanup at docs Makefile
> 	  (7 patches)
> 
> On my testbanch, this is the current summary, where:
> - PASSED: means both HTML and PDF were generated:
> 
>   PASSED - AlmaLinux release 9.6 (Sage Margay) (7 tests)
>   PASSED - Amazon Linux release 2023 (Amazon Linux) (7 tests)
>   PASSED - Arch Linux (7 tests)
>   PASSED - CentOS Stream release 9 (7 tests)
>   PASSED - Fedora release 42 (Adams) (7 tests)
>   PASSED - Kali GNU/Linux 2025.2 (7 tests)
>   PASSED - Mageia 9 (7 tests)
>   PASSED - openSUSE Leap 15.6 (7 tests)
>   PASSED - openSUSE Tumbleweed (7 tests)
>   PASSED - Oracle Linux Server release 9.6 (7 tests)
>   PASSED - Rocky Linux release 9.6 (Blue Onyx) (7 tests)
>   PASSED - Ubuntu 24.04.2 LTS (7 tests)
>   PASSED - Ubuntu 25.04 (7 tests)

Forgot to mention, but for Debian-based distros, my setup does this at
the distro setup phase:

    if [ -f /etc/ImageMagick-6/policy.xml ]; then
      # Remove any existing restrictive policies for PDF/PS/EPS/XPS
      sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-6/policy.xml
      # Allow PDF patterns at the end </policymap>
      sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />'etc/ImageMagick-6/policy.xml
    fi

    if [ -f /etc/ImageMagick-7/policy.xml ]; then
      # Remove any existing restrictive policies for PDF/PS/EPS/XPS
      sed -i '/<policy.*domain="coder".*pattern=".*\(PDF\|PS\|EPS\|XPS\).*"/d' /etc/ImageMagick-7/policy.xml
      # Allow PDF patterns at the end </policymap>
      sed -i '/<\/policymap>/i \ \ <policy domain="coder" rights="read|write" pattern="{PS,PS2,PS3,EPS,PDF,XPS}" />' /etc/ImageMagick-7/policy.xml
    fi

to fix a debian-specific packaging issue that makes ImageMagick 
to fail when it is used with PS/PDF files.

Regards,Mauro

