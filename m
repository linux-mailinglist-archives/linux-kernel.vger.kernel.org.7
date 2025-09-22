Return-Path: <linux-kernel+bounces-827480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CEB91DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061001903C24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D492DEA86;
	Mon, 22 Sep 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xaqL307l"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9A2836F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554074; cv=none; b=br3amG6nWwT0ZpBsaXYtscpHn3Q/qwV7hiLFWEcCHzM9zp0vs1qjEP9pb5VeiZ6poOcXijvKSTE/Rvt84iGcp97ocaKbZfBDWrcM/F3SnTuaD8qMY+044MVJrWCBdfQbT9AfScOUOIfAP9LL99yfjk9N01yNNBMwDfdUryrY1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554074; c=relaxed/simple;
	bh=4boiJmYSJNRhez+0ST5UcGBZ3m5jTxEHMhvYrFzRwSs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHs9htovusbShoybiKhOhBZ3Vy7swISpCfdQNHPdvgIVG3z2jamxaDYVMbr27bqQsrZA5YzoJs7YqhbB8tQc8Oe5N7Kji5Zij6ghW7MlgwrCP0G3y9vUS+deRfVhQtYlZ+spmN+TUmwdO41hKn/2DTaPi/jNJdbnLvTffxhwn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xaqL307l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4boiJmYSJNRhez+0ST5UcGBZ3m5jTxEHMhvYrFzRwSs=;
	t=1758554072; x=1759763672; b=xaqL307lVpB+1yg9dJxeD7DUR3Gg3BwHHp6lfNfWE0i2dNc
	YTu+DgDpow2PJI4ntvmTF75HMh1Fob8VQmULaMrsgDDGE6UFdyM8smzO8Mc8Zg5Hsx18XKT5nAgBP
	nWLDL/56GRYV7PTjADY4BcRNQqM9XP5Wo4/Cg3JxaT9riocStPMNUhLy9+28CXtT8oY2aA0tmf2Yi
	xVxD0BNtGsIA7tJr5rE3B7MOAJj4p1rM04iOcIc+PIZI95iX1Sy3t36/rZPUXfSp3v2iDjT2PQHtY
	Jhw4F4Z3l3MarHzH8Ej2gvSYp+vYD2uBvGtuFSW0aBsF6ytX39mJz23SIN0/TPcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0iFA-00000004lGw-19zD;
	Mon, 22 Sep 2025 17:14:20 +0200
Message-ID: <366bb558c3fd23b9a80008d923f29ed0234e17b9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, benjamin@sipsolutions.net, arnd@arndb.de, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	tiwei.btw@antgroup.com
Date: Mon, 22 Sep 2025 17:14:18 +0200
In-Reply-To: <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de> (sfid-20250922_160212_262231_0E1FE0F0)
References: <1568f254-7963-4015-91ed-7630d5d87881@t-8ch.de>
	 <20250922045020.48158-1-tiwei.bie@linux.dev>
	 <495a5594-8ac6-4b7d-be6b-7c176b741c21@t-8ch.de>
	 <76b5ba35f864764100c9a5a00d50d8fa4276cd98.camel@sipsolutions.net>
	 <21755635-74d4-4fa4-8ffd-371c17630fdf@t-8ch.de>
	 (sfid-20250922_160212_262231_0E1FE0F0)
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

On Mon, 2025-09-22 at 16:01 +0200, Thomas Wei=C3=9Fschuh wrote:
> Right now it does not provide any advantage over a regular syscall.
> Essentially it is just overhead. That said, if you do want to make a
> real vDSO out of it, I'd be happy to help in that.

I don't know if I'd say "just overhead" - depends on which path is more
optimised in a typical libc implementation? I'd basically think it's
identical, no? You either link to the vDSO, or a __weak same function in
the libc?

> > I mean ... on the one hand, sure, it doesn't really do much after this,
> > but OTOH it lets userspace actually use that path? So might be useful.
>=20
> What advantage does userspace have from it?

Right now, none? But it's easier to play with if you have the
infrastructure, and I'm not convinced there's a _disadvantage_?

> > > Also the functionality to map the host vDSO and vsyscall page into UM=
L
> > > userspace looks very weird and error-prone. Maybe it can also go away=
.
> >=20
> > Surely host vDSO etc. is never mapped into UML userspace and never is,
> > not sure what you're thinking of, but clearly that's wrong as written.
>=20
> This is how I understand the 32bit implementation using
> ARCH_REUSE_HOST_VSYSCALL_AREA and NEW_AUX_ENT(AT_SYSINFO_EHDR, vsyscall_e=
hdr)
> where vsyscall_ehdr comes from the hosts getauxval(AT_SYSINFO_EHDR).

Huh, hm, yeah I forgot about that ... 32-bit. Yeah, agree we should just
kill that. I'm not even sure it works with the host kernel trapping
there? Oh well.

johannes

