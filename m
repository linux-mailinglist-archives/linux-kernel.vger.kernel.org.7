Return-Path: <linux-kernel+bounces-761386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECBB1F977
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A713B8F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E123B611;
	Sun, 10 Aug 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Dgsk0sQB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC422B5A3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754817696; cv=none; b=Zb3hgmc+5fgxcfd4VHHa33cXQdE/3ijGPOuHmm5e8c0Yll9YrQMjKXPIBIxZJWZaxnDFLhDIIAxJ5ZWDQ0QwjYcA4DsHwxbvUt4n5TP6HJXLKqxAWjfA1G1xiajOhxLcUyLNo/KeTZ7Lug2mntLIITs8p7yTxonPdNe3wOesSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754817696; c=relaxed/simple;
	bh=VFwkm31i9/tKE057pPNZIoanm3t4mIphBXmwDC5Uils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rulTB1eyS4IQSV41YIjfZHlo/M6rIOiaeZ0RZAlL8bAlZIgfAKVocIpCLwVRA4mBR+i0qgv87ZgoXjV5HR65YCivZu+6wvfxE8MtS1oHu/A7gKK0lSWKadhOIPaIwCPaZW33h7Di5GM/5bcBnFkgzdoGTIGJNpJ2hOSzUf7gPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Dgsk0sQB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754817692;
	bh=VFwkm31i9/tKE057pPNZIoanm3t4mIphBXmwDC5Uils=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dgsk0sQB21nZ9PzQOVKk2iiVoV1rTBZ5/5544czQpjYx8SmgqZ+upRXfobmMV3Tdl
	 EHD06Lwa9ztRq7cgLzzHGa3RH5wRImcyMtJdnzdv4ITH9cshabt7sTkwVTH83rm7wy
	 PNrs76CSpHDZ1gBp1ik1g3sPCHBxUPW+80Bt9xIE=
Date: Sun, 10 Aug 2025 11:21:32 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Daniel Palmer <daniel@0x0f.com>
Cc: geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Add target for lz4 compressed vmlinux
Message-ID: <e4ac35a6-f521-47fa-b949-b827197ca537@t-8ch.de>
References: <20250809015529.373693-1-daniel@0x0f.com>
 <5dd0a031-dd7b-4078-b1a8-6b760248390b@t-8ch.de>
 <CAFr9PXmF-AOL8yj9FntHw+b1A8HWKNeAHU=rx7Dk7pfi1N_4fA@mail.gmail.com>
 <d7974cbe-41b3-4994-8982-30c8f660e65f@t-8ch.de>
 <CAFr9PXkJCPm9UwV8-FeZxhB+ODxGgtbKdD3n90UjqyPGF8tMSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFr9PXkJCPm9UwV8-FeZxhB+ODxGgtbKdD3n90UjqyPGF8tMSw@mail.gmail.com>

On 2025-08-10 18:08:15+0900, Daniel Palmer wrote:
> On Sat, 9 Aug 2025 at 21:29, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > On 2025-08-09 20:35:39+0900, Daniel Palmer wrote:
> > > On Sat, 9 Aug 2025 at 16:50, Thomas Weißschuh <linux@weissschuh.net> wrote:
> > I would continue with vmlinux.tmp. It might not actually be stripped.
> >
> > quiet_cmd_precompress = PRECOMPRESS $@
> > ifndef CONFIG_KGDB
> >       cmd_precompress = cp $< $@
> > else
> >       cmd_precompress = $(STRIP) $< -o $@
> > endif
> >
> > vmlinux.tmp: vmlinux FORCE
> >         $(call if_changed,precompress)
> >
> > targets += vmlinux.tmp
> >
> > This will also correctly handle CONFIG_KGDB changing.
> >
> > (Maybe the naming can be improved)
> 
> Nice, that's a lot better and I've reworked my patch to do that.

If you also modify the existing code, you should split up the changes
over multiple patches. First split out the rule for vmlinux.tmp, then
switch over the compressors. Each patch should do a single step and
explain why it is done.

And I am still not happy about the naming in my example :-/

> > And for the compressor invocations we already have predefined commands:
> >
> > vmlinux.gz: vmlinux.tmp FORCE
> >         $(call if_changed,gzip)
> 
> I also did this for all of the targets and $(call if_changed,lz4)
> results in an lz4 file with the old header format[0] and 8MB block
> size which is not what I need.
> So v2 will have a patch to add a helper to generate that style of lz4
> in scripts/Makefile.lib

Modifying generic files in scripts/ will be more effort to argue for.
Also that change should be its own patch again.

I am wondering a bit why the legacy header format does not work.
The manpage of lz4 specifically mentions that it is commonly used for
Linux kernel images. Which is exactly what we are doing here.
Does your usecase work not work with the legacy header? If not, please
mention this in the patches.


Thomas

