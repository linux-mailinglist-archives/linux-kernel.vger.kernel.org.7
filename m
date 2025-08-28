Return-Path: <linux-kernel+bounces-790623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B3B3AB05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A16464AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1CC27B344;
	Thu, 28 Aug 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2l8OQbO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686827A135
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409785; cv=none; b=YM0WX4H7qj1pB6e/JxackoVgUbN7GgQZ0Ofo0jrhFBsGSCPqchloUcqQmxdf2drKO36KKdBHrxIo7ECHsrBYRX02skyDwnjsFkcqG5h8ui4V8Hwr1/z3FXdmph2FGGSpXuxGSDUguGYXLmAKT7JUoPg3+xd+uZHMd6hXhegwO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409785; c=relaxed/simple;
	bh=H8yMuSqeJzW3/9qS7WLSVRsjSYpF6jP94tYrdjqyjLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsKSWJo7+v4xDqcaUSGGWKvHhdFQaL6OcAnNxFJ6snAOwE+92PHjFFfosOICOhfufczPkV8yesvfIMV85HDHTYDNJE0StwaXW1fwHX3ij9td+/xl4Gu6ya5YUB6imH5QRkcKFRjSGyUVPIHRQ8flrQb7LOANF6g4ysUoZnLvAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2l8OQbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96836C4CEEB;
	Thu, 28 Aug 2025 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756409784;
	bh=H8yMuSqeJzW3/9qS7WLSVRsjSYpF6jP94tYrdjqyjLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2l8OQbOlBTKGTvU1kcXHJouERm6GxIGBtGbjkXFftfrrgJmr9Krm61cZfrEY2ebF
	 t1P9VPrqjC3jQZ6jKIAedzMvejHkG5sCBf6T/wqvisS8QN83C3Mnls/Z/ryEOCSdKn
	 i+dFiDQazRGe914TpSvrVNqyEYIqtk01MUiLb/Ocl710r/Ucv7pXANO7zgq+8VYdHe
	 /yV6ETqxjoBF2O067RjFbTq6Ydz2F7sMcCl55mPxHMeDHLVcOdv9Ees9J1wgimQbM+
	 sLM6FI/btq/xtOx75PG0scFC1risV32wIU7Z+PkMEn6LxSU55kgk78cSel1Tscv5qV
	 kkvVA1W1NA0/Q==
Date: Thu, 28 Aug 2025 15:36:20 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [for-next][PATCH 1/3] sorttable: Move ELF parsing into
 scripts/elf-parse.[ch]
Message-ID: <20250828153620.6972c36f@batman.local.home>
In-Reply-To: <aLCoGIEXLRrQ9PmL@levanger>
References: <20250828182754.733989525@kernel.org>
	<20250828183125.288650678@kernel.org>
	<aLCoGIEXLRrQ9PmL@levanger>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 21:03:52 +0200
Nicolas Schier <nsc@kernel.org> wrote:

> > --- a/scripts/Makefile.vmlinux
> > +++ b/scripts/Makefile.vmlinux
> > @@ -97,6 +97,8 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
> >  $(vmlinux-final): scripts/sorttable
> >  endif
> >  
> > +.PRECIOUS: $(vmlinux-final)  
> 
> Why do you need '.PRECIOUS' here?  Does its need match to Masahiros
> explanations in 

I don't. Crap! That was from debugging where I needed to keep the
vmlinux-final around to test. I must have accidentally committed it.

Let me go and remove that.

Thanks for spotting it!

-- Steve


