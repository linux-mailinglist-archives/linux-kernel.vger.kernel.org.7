Return-Path: <linux-kernel+bounces-827179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A47B9112D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A83179C13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217773064B5;
	Mon, 22 Sep 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xnRaOOGH"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0612566D3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543185; cv=none; b=rEcF0ZIXCqSK79VIvnLTffhQhtB2XgmKNCgAt4Hg/SSpJk/Tra3aH2IcR2Fl0TbVlUeyvXO1iTLTL0hSIeGG0h7cyPDVfas5L89SSVQYLz1Q92dzLi+jvV5Y7AD1oK5Ps1A4u4J0FNCCH9aiFqmmjEPbN+M+ApHRWVHUV5oSN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543185; c=relaxed/simple;
	bh=Ycui7EF1uPqypt1AZAs48YhxpkNn2cVKejuM0yOxXhg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZW/6FSf1twchZA9Frq1BJokxzU+pc96qPXChqT9Q2rsBN+cy/l0kdnHTC33tx3dGyjwKAedjelUHztYRabWEOW6+TH5mGPkzU5bjrrenitm8KqOVs98OwhE/xmnfCZ8Jiic6FuItueMXnu0MCEzUbEZySNU92mkvRCLuBnvhKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xnRaOOGH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ycui7EF1uPqypt1AZAs48YhxpkNn2cVKejuM0yOxXhg=;
	t=1758543184; x=1759752784; b=xnRaOOGHfaIbYtQopJfzpY6Jj1VTM2XJiB3eZ3jQSKiXlLs
	gDt4V3Lp9HHzNX7nSiUYFZUDhEOPALn9VXxJjAAilQtE8b1/5fTNxsfJ2tzr15juczfXIA4ztBnNj
	CS2tABNxmhw4qtCbCI2+r6mQYvyVs1DZGORe/KsmJfGcNX1lgY/70PDQgq2SOoP+26MLkP5P+0AtE
	x81YwU7GWwdj1/eBamNRtyd2UrwWBrNp67a11RN8LoMxPBpwUt8kSedoqbshzPyAumU0eRGN3zzKK
	3wO+cuzCIXmQ9X3Gr55J7muPQERtYJkIwOodXVjitngjJycJgKljC4TiacQNT+vQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0fPZ-00000004XyA-1okk;
	Mon, 22 Sep 2025 14:12:53 +0200
Message-ID: <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Tiwei Bie
	 <tiwei.bie@linux.dev>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 benjamin@sipsolutions.net, 	arnd@arndb.de, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 14:12:52 +0200
In-Reply-To: <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de> (sfid-20250922_140539_000914_4D0E5682)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 (sfid-20250922_140539_000914_4D0E5682)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-09-22 at 14:05 +0200, Thomas Wei=C3=9Fschuh wrote:
> > The original issue could now be considered resolved. So in v3, we no
> > longer turn __vdso_getcpu into a syscall wrapper; we simply removed it.
> > Perhaps we could remove the whole VDSO before we implement the "real"
> > VDSO. However, its implementation is clean, so keeping it wouldn't hurt
> > and it could serve as a useful starting point for the "real" VDSO.
>=20
> A "real" vDSO would require quite some more infrastructure.
>=20

What's not "real" about the vDSO now? Yes it just implement syscalls
after the getcpu removal, but ... it's still a vDSO? I _have_ played
with getting data into it for the time-travel case, at least.

> And it is not even clear if such a vDSO will make a difference on UML.

Syscall overhead is _huge_ in UML, if it does anything but syscalls it
will _certainly_ make a difference.

> In my
> opinion if __vdso_getcpu() gets removed, the whole vDSO should go with
> it. The code can still be easily restored from git.

I mean ... on the one hand, sure, it doesn't really do much after this,
but OTOH it lets userspace actually use that path? So might be useful.

> Also the functionality to map the host vDSO and vsyscall page into UML
> userspace looks very weird and error-prone. Maybe it can also go away.

Surely host vDSO etc. is never mapped into UML userspace and never is,
not sure what you're thinking of, but clearly that's wrong as written.

johannes

