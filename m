Return-Path: <linux-kernel+bounces-827370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F970B9190F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D2A189A363
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAD57260D;
	Mon, 22 Sep 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c/P8qUNN"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB3134CF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549736; cv=none; b=SnLJ7ScmqaAEhoUuOP1RIuTNUVTADq7tzw8v2IOCgu0ZgwGoqUm7Vtzxm1BWZ3xVWXrI/+hFuwAUzkdFrQ2qlNypUF/hmoYggM95GijWP6Q9p/T5cmwRs0mgCxUSYbtGbtjzPxObM+E4Nxqi+3bxbBZwbXXdpkF4Uk799FVfcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549736; c=relaxed/simple;
	bh=e5PY6U82YwilDEzB4p0kKsmSnXCVDFHMHAYraZzOBuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyZ+xkMKpCCfofJ6CuQc2C2jC9jXxSIiZGuqZn+LALBYW9tR6dYGyGO7ICCuzsELWgwuM2nCLpfja3qCVoSamE2sQ7KL0nYwZ3KCHG7lIfot9gVuru6X7NbGx7gf80H82z30kJ98tf1WuKEc5MmduGrXDv8tUbkYF+0Pfaeoknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c/P8qUNN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758549729;
	bh=e5PY6U82YwilDEzB4p0kKsmSnXCVDFHMHAYraZzOBuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/P8qUNNgX72CeMTDluIenBfBLO6g4qqsq/BAOdrH/S0tT0jWbqFWMvGiQJcpC+ck
	 xMptr4GXEzdfZegnDLP1x8QIbJ6EUCgbkfx9xk1/UJhMwTWaLwISzlSzr7GUb5bFq+
	 PBoM4pVwbPUPx2t2C1oQib1DfS7qKG8nPHLFgOSw=
Date: Mon, 22 Sep 2025 16:01:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>

On 2025-09-22 14:12:52+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 14:05 +0200, Thomas Weißschuh wrote:
> > > The original issue could now be considered resolved. So in v3, we no
> > > longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> > > Perhaps we could remove the whole VDSO before we implement the "real"
> > > VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> > > and it could serve as a useful starting point for the "real" VDSO.
> > 
> > A "real" vDSO would require quite some more infrastructure.
> > 
> 
> What's not "real" about the vDSO now? Yes it just implement syscalls
> after the getcpu removal, but ... it's still a vDSO? I _have_ played
> with getting data into it for the time-travel case, at least.

Right now it does not provide any advantage over a regular syscall.
Essentially it is just overhead. That said, if you do want to make a
real vDSO out of it, I'd be happy to help in that.
(I did most of the recent work on the generic vDSO infrastructure)

> > And it is not even clear if such a vDSO will make a difference on UML.
> 
> Syscall overhead is _huge_ in UML, if it does anything but syscalls it
> will _certainly_ make a difference.

Ack.

> > In my
> > opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
> > it. The code can still be easily restored from git.
> 
> I mean ... on the one hand, sure, it doesn't really do much after this,
> but OTOH it lets userspace actually use that path? So might be useful.

What advantage does userspace have from it?

> > Also the functionality to map the host vDSO and vsyscall page into UML
> > userspace looks very weird and error-prone. Maybe it can also go away.
> 
> Surely host vDSO etc. is never mapped into UML userspace and never is,
> not sure what you're thinking of, but clearly that's wrong as written.

This is how I understand the 32bit implementation using
ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr)
where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).
But I didn't actually test this. I'll look at it again, but currently
I'm travelling.


Thomas

