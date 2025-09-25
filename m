Return-Path: <linux-kernel+bounces-832918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07028BA0C07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5C362090E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582A30C347;
	Thu, 25 Sep 2025 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZyjK8nmt"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3630BF62
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820119; cv=none; b=QJg+DOqVZetWFkARxlpy1NKkcCS6bDpi7abASnTWJQI0kx+29+zla/UQowEK3pKB/Cr9QwceRrSxGGzZjSSNmwH6Rgt4DKeWXG7SdH1l/HUdI1vhPB54sPugiJDTzVm4qFMzso5yDOAG4AbpR9RD1N52EuiXvnj+u1IIxQq4osE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820119; c=relaxed/simple;
	bh=gLMNiUHz0jN+yB725jmooRejtzuPZZGG/vNIFpyP0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4GQerC5rK1TtqelRsb30AhHy3zY2juRFlmwkWGdW87XU89m2TiRtxlsumtTpaQ1iBzll3d/cKhG2b7UF4O87Gqq3Rtjk0BmzDWpq5/OGeDmzmH13Ka48dYvZXVTSD60EX8KPBwTesslpMjQFrj7tDjnJ7Y6Yshamd9Man318zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZyjK8nmt; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758820115;
	bh=gLMNiUHz0jN+yB725jmooRejtzuPZZGG/vNIFpyP0vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyjK8nmtXV2dv9avk6p1jDrX3CNurghKoSpFMBpCb1Xzz/mYkGxXGrsoQpXWo0Des
	 QWnmbBNRscsjHW4+LhSsrLX7D2L3Ozqw+5hR2Jf42XW2RKeH6Zg4HkLorDDyR3kfv8
	 U8mLxEhnVUymS65Eipg0WhGmyrGbVmtlFVBPfdRo=
Date: Thu, 25 Sep 2025 19:08:31 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, tiwei.btw@antgroup.com
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
Message-ID: <bfa3b5fe-ae5d-4647-a49e-b2b53a46de4f@t-8ch.de>
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
 <20250922045020.48158-1-tiwei.bie@linux.dev>
 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
 <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
 <61ae09df-d65b-4c9d-a0c1-7de915246590@t-8ch.de>
 <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96ae8e726480a36a37d472106b761a141394e845.camel@sipsolutions.net>

On 2025-09-22 19:07:27+0200, Johannes Berg wrote:
> On Mon, 2025-09-22 at 18:04 +0200, Thomas Weißschuh wrote:

(...)

> > > > > I mean ... on the one hand, sure, it doesn't really do much after this,
> > > > > but OTOH it lets userspace actually use that path? So might be useful.
> > > > 
> > > > What advantage does userspace have from it?
> > > 
> > > Right now, none? But it's easier to play with if you have the
> > > infrastructure, and I'm not convinced there's a _disadvantage_?
> > 
> > So far that hasn't happened. The disadvantages are the ones from above,
> > nothing critical. But of course it is your subsystem and your call to make.
> 
> Yeah, kind of agree, though I'd like to actually use it - especially in
> time-travel mode - but haven't really gotten time to add it. Having it
> maintained in-tree is a bit nicer in case of global updates, but yeah,
> ultimately it's not really all that important either way.
> 
> I guess we could get getrandom() pretty easily by taking the x86 one.

Yeah, the only architecture-specific part there is the assembly chacha
implementation. And that will be the same one as used by regular x86.

> I actually have half a patch somewhere that rejiggers the UM vDSO to be
> more like normal architectures, using lib/vdso/gettimeofday.c and making
> the build more regular etc. Maybe I should dig that up and try to make
> it work entirely - it was part of a previous attempt of adding the time-
> travel thing I mentioned.

Sounds good. And let me know if you want me to look at it.
Using the generic vDSO library and datastore is mandatory nowadays for
"real" vDSOs.

> > > Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
> > > kill that. I'm not even sure it works with the host kernel trapping
> > > there? Oh well.
> > 
> > Ack, do you want me to send a patch? This was my real gripe with the UM
> > vDSO. I want to enable time namespaces for all architectures but these
> > need to be handled in the vDSO properly. For the 64-bit stub vDSO it's
> > not a problem as the syscalls will work correctly.
> > But the interaction with the weird 32-bit logic on the other hand...
> 
> I guess? But I'm confused by what you say about it being related to time
> namespaces, the vsyscall stuff doesn't really _do_ anything, assuming it
> works at all? It's not like the host actually could be doing anything
> other than syscalls there, which are intercepted? If it were doing
> anything else, it wouldn't work in UML in the first place?

In emulation mode the trapping kernel will not actually trigger a
syscall but calculate the time in kernel space and write the results to
the respective registers. If I understand correctly the trap is handled
by the host kernel, so that would bypass UML completely.
My wording was a bit wonky. I stumbled upon this while looking for
potential time namespace compatibility issues. And with time namespaces
the chance for a clock mismatch between UML and the host are higher.


Thomas

