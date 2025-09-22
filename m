Return-Path: <linux-kernel+bounces-827573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3917CB921FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B00189A54C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55606310764;
	Mon, 22 Sep 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iByImEF+"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046F48CFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557093; cv=none; b=BXrrRxguSiFQ54KGVi1pZcLxBjZDLpE6Y1ujUBLrW3hnEG+JglxN2RvKxNrXZvUSZ8icS8e+eLTLPv3l+PHG8NXaodjdbgXw/pLP5HHGR15boeG435VUwN0bNcMm5XihCHECB+DLhPOb0jkSDDSufRHZA1Jfjt16DxfCGA6eoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557093; c=relaxed/simple;
	bh=eVcTWrZCCQXQKEvyt0ECeLBgfnYB7E4UW/QXsjEnE6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdFNR/mWVwngR3EyIG2uj78dGkeFLNSx8DZ3vHw7+xCzm5QSWwad8Zqd00lmgk7UXsxZd2aooYziGpgXMzhChrih/JzaQmMp58IENC3ouqVLsX3fDrtuT1hWCVDLJLsZmfFtMDDDCL74vZTV05Oqs7KRhtfLm0/+Xt6JgF9NuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iByImEF+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758557089;
	bh=eVcTWrZCCQXQKEvyt0ECeLBgfnYB7E4UW/QXsjEnE6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iByImEF+ESPqh+9OVfLJbkxlhK/cOt7POvbPMqVjyOl28YXYmxd3zcJo+HYOPT99q
	 oiIz8mTt9jZlhPB+oEyBjvJucJOSuoPYdjvi8uFuFOjmb+jbeP6rUvLMAbCyRHC3+R
	 pU7O/DzaK+P6RsTYduWKMZjhLbjwnh+ohe4KJi9o=
Date: Mon, 22 Sep 2025 18:04:46 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>

On 2025-09-22 17:14:18+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 16:01 +0200, Thomas Weißschuh wrote:
> > Right now it does not provide any advantage over a regular syscall.
> > Essentially it is just overhead. That said, if you do want to make a
> > real vDSO out of it, I'd be happy to help in that.
> 
> I don't know if I'd say "just overhead" - depends on which path is more
> optimised in a typical libc implementation? I'd basically think it's
> identical, no? You either link to the vDSO, or a __weak same function in
> the libc?

The code also needs to be built and maintained. AFAIK __weak is only for
the compile-time linker. The vDSO call will be an indirect call.

> > > I mean ... on the one hand, sure, it doesn't really do much after this,
> > > but OTOH it lets userspace actually use that path? So might be useful.
> > 
> > What advantage does userspace have from it?
> 
> Right now, none? But it's easier to play with if you have the
> infrastructure, and I'm not convinced there's a _disadvantage_?

So far that hasn't happened. The disadvantages are the ones from above,
nothing critical. But of course it is your subsystem and your call to make.

> > > > Also the functionality to map the host vDSO and vsyscall page into UML
> > > > userspace looks very weird and error-prone. Maybe it can also go away.
> > > 
> > > Surely host vDSO etc. is never mapped into UML userspace and never is,
> > > not sure what you're thinking of, but clearly that's wrong as written.
> > 
> > This is how I understand the 32bit implementation using
> > ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_ehdr)
> > where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).
> 
> Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
> kill that. I'm not even sure it works with the host kernel trapping
> there? Oh well.

Ack, do you want me to send a patch? This was my real gripe with the UM
vDSO. I want to enable time namespaces for all architectures but these
need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
not a problem as the syscalls will work correctly.
But the interaction with the weird 32-bit logic on the other hand...


Thomas

