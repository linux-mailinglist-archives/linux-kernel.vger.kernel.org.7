Return-Path: <linux-kernel+bounces-859133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FE1BECD90
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FA254E7B44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9DE2F9DBC;
	Sat, 18 Oct 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5gWF2ru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A92F361E;
	Sat, 18 Oct 2025 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760784078; cv=none; b=OC8LX047sbpLxGehzGuRLQQM8YIYZ2tB4m35CNnI/0QIxxbmZfMM1rC8b6dzkyPGmjVmT1y/1Y51Neh6Tk2yPokbZWEsgN4CanwGLjcC4v/G0+vejGWaeqQawlsfv7fgvbpVln+t2hoCbL/7HSemWRqeDXzhg3hBnphtrtQ4a2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760784078; c=relaxed/simple;
	bh=EJZ7fXdrMVCkRfhK+Ds9/NpbpDHJ4iXEOM1rIVxCtck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3bgD/cNlvZ5RnRUt0r2ojzTZS0dhptv0EzuWHRTI0btMYlf4J/ZXRwPY+1K2kJYdgrvUut+yBYWpLHVvsc5GStZbEi6Vz1spG+iBRAjEQ+NEAJgVdcNp13qSqLozVKITZ4+NDHq/YGYkKOhDarGSStlPPTnTyYsG7mppMRsUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5gWF2ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371EAC4CEF8;
	Sat, 18 Oct 2025 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760784078;
	bh=EJZ7fXdrMVCkRfhK+Ds9/NpbpDHJ4iXEOM1rIVxCtck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5gWF2runfdVwb3kN8gazRXarEFW/hhVH+7xeXFLVT1L2gybXwz0ZUys2EyUYs32A
	 42E1HjNnAXlBeXnhHWzWg5oCq0Ivp2nblsUuhrj2dBukmLWCkJyJsZEVJU8sVbD3ye
	 VPhZGnreBPopAkyBQwZ2DbbqZOSxctUiM7zedGcYiPiYipy2AwKR2kdXpm++gGsi+y
	 9h9o/g1jy6g/30YBAja6r17pgqVqbLhls39+IqyPvtnDmzqAiWptSuuKLbA0zCKZ3W
	 5+0yOtBZxyJierG2Q9yEA+nPsDzHU8p+JLDATy7A3ddcU0wXtYrSyJ33w2KQIzImwI
	 SWQ0/n8l0rG9A==
Date: Sat, 18 Oct 2025 07:41:09 -0300
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
Message-ID: <20251018074109.33fdb167@sal.lan>
In-Reply-To: <87cy6l1e2y.fsf@trenco.lwn.net>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
	<87cy6l1e2y.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 17 Oct 2025 14:13:41 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > v8 contains a bug fix for ./tools/docs/check-variable-fonts.py command
> > line together with a new --deny-vf argument to it, plus addresses
> > a couple checkpatch warnings. Only 4 patches changed: patches 1, 2, 4
> > and 5.  
> 
> I have just merged this series, along with the accumulated fixes, into
> docs-mw; after a month of separate exposure in docs-next, I don't think
> that there is a lot of benefit in waiting longer.

Thanks!

> 
> It still makes me a bit nervous, hopefully all this will work out!

If something breaks, we can fix it ;-)

Placing everything altogether and callable via command line and
documented IMHO makes the docs build easier to maintain.

Regards,
Mauro

