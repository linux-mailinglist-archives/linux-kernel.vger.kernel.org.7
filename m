Return-Path: <linux-kernel+bounces-847153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05581BCA252
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26284FFAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E12EBB86;
	Thu,  9 Oct 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifOsoQ9B"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD9226173
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025926; cv=none; b=DSYtPEN+j0RVT1c8Kzvrpze9VYDQNYHs3AtVustScb4n4yUhVzbeyh4lwvAQo/e950AsS0OWZWgQTw/VF0aOv1sa+dceptmeYBscWVa2laD1dJm1kmBAI+WtTOtulZR44ZUeIOTpql405hInWUE1XlXdaXa7VoEax4BzawAHQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025926; c=relaxed/simple;
	bh=unAvA+RbShXheJ36o53ulWGdqzWHeRH1pf34YmMcgVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7HOYGd9VSvK0ZZprFa1+AkztgGpOoqculsTjtk8MIZyTUbpUZ69LsijzbJFqZolAUf7EyvRhZHI7H7JIBe6SEEpWFWjUqefCkRz69jsLwymN0EfF/YWgyb+zU09zm1DKIei+Fb1BCpFva89RHvzpUbJkIiJ4BSE/PwZ23j+Sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifOsoQ9B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso915922f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025923; x=1760630723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=re2LVHmQYfMPpDvoOEi22gcukJgsAd89KFwqYXVYUWo=;
        b=ifOsoQ9Bjt0E9HV5CtTQF+ZqSx3hysVQiNevi3TI9H9w5qZzA8TMeGO3gl9F1EvTXO
         p86QgtzUsP3dLvu9U7vFtcZMpqN2ldZkWXW7vLL250XLA18zsXL8uC1ad8rc4r3crRGB
         JptGFD6kps0yY1rdYcmfdIQjsohGofx7pWs///Tbsr1a8FFQ1/DrXtAFmG1WqMN1XFAX
         CSbZ8WubFZGQO6JEBTY2d8k88nj/xdwAb0f0wm0bU2wgrgmaz3CRlN2rHIJjhg1vF2XT
         czADiY3sAvSgXhELP5O5HVSa5gJYHF7ngTqAy4o4Jy+99kknUxlAEnTomo9L2XaMboUx
         p0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025923; x=1760630723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re2LVHmQYfMPpDvoOEi22gcukJgsAd89KFwqYXVYUWo=;
        b=pTILkaZENAj6k2eqhQ1yUa51s18dyU1aKqleD/KN7djn3V/IX2vZfqB+iKPSr2ysG/
         NGyMFQ9HhfREqMpxtRIQ6QZsz99V8R9g5vfkLYFj2z7oaDOKTCXFIAZIBUSoTBAVc6Qo
         jmjPsIDmAkO/Jv/s+pbeZZVsXek7xKWSB5qusJamKCyyUb7E/yDMRbRC+oTmjf16r4Xl
         7yb8iWo1UCm6uBWuOi/B0by+HfY3eUoSf3Po6ZJKMlPLPEb8EqWDxxQsmA9V3kuhksZS
         7OU8Dxua7hWgKMSILDjlmxhhyzmwtI39cSR0kYsHUi4SUku+xgM8eUO2r7Q045h2NBvs
         99Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU+7zf19XacJPr2kiORTXAmkVvLQVAdPZHo499iR+f+BU5F2TVi+jXQsJH1YEZ+y9pfjfuqaR8cGZNrRQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36TUuMGmLLvoic85IXYMKdhIw20Uwct1MfCXvs5Ux4Wg+Amly
	tTc09hg/sEywivTIZoY+DQhuii3GVUkAGACftAxZmy1jxE1atw1ehzsx
X-Gm-Gg: ASbGncuWwynEIcoZbiZCp9QDc/BDzI3NH30jYn+QE3ETZpngMbi9YJ18pnTxuxrGn0c
	QoJgCnSeCOcmUX8mYR9osJR7ogoSUap/XDWmlyBZmsKBcRbeQAgFK8qnNNXEe3unOTnk0sYlNAs
	BD1hrFEj2gUZd8jsq2kGBGDYEOE6uTQL04r2IMnbsjbZh+zyNkM4Ag/uVXL8XzUmSd6u1cWPxU6
	SxEBHbp2lrOBp1ReI2u2k+IiYApdtPHqyVmUyBvtdEbQKzfZNZ1xtCmYIe159yz4CUcyYb3yMw2
	pyS4Xkp33+SooVfoW4+UL//UywG3mmADJygptjIOlxAq0agPkwR0a79p4EYubIku7DNt3X/MaiV
	nNVoJuTsOQCXLWVw585dmfQtwqN4ixLTFmK00yCi6XFPsDzzKq6EPaLObu4I6KF/4ZgIeRPKFmW
	946KcF10pH6eTnScOvQyD4FWivS0Wq1M511A==
X-Google-Smtp-Source: AGHT+IFOzFZCAz1bvnO194N0WES7OEH7GfUA/BRjdohTZijoPsQbpfZni9sA7IHmHQ3LMF15FxD4jA==
X-Received: by 2002:a5d:5d03:0:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-42667177c28mr5473434f8f.17.1760025922451;
        Thu, 09 Oct 2025 09:05:22 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426cd99fd4esm30074f8f.42.2025.10.09.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:05:17 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:05:15 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: IRQ thread timeouts and affinity
Message-ID: <loeliplxuvek4nh4plt4hup3ibqorpiv4eljiiwltgmyqa4nki@xpzymugslcvf>
References: <j7ikmaazu6hjzsagqqk4o4nnxl5wupsmpcaruoyytsn2ogolyx@mtmhqrkm4gbv>
 <86qzvcxi3j.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ytjgx34t7yap2p7t"
Content-Disposition: inline
In-Reply-To: <86qzvcxi3j.wl-maz@kernel.org>


--ytjgx34t7yap2p7t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: IRQ thread timeouts and affinity
MIME-Version: 1.0

On Thu, Oct 09, 2025 at 03:30:56PM +0100, Marc Zyngier wrote:
> Hi Thierry,
>=20
> On Thu, 09 Oct 2025 12:38:55 +0100,
> Thierry Reding <thierry.reding@gmail.com> wrote:
> >=20
> > Which brings me to the actual question: what is the right way to solve
> > this? I had, maybe naively, assumed that the default CPU affinity, which
> > includes all available CPUs, would be sufficient to have interrupts
> > balanced across all of those CPUs, but that doesn't appear to be the
> > case. At least not with the GIC (v3) driver which selects one CPU (CPU 0
> > in this particular case) from the affinity mask to set the "effective
> > affinity", which then dictates where IRQs are handled and where the
> > corresponding IRQ thread function is run.
>=20
> There's a (GIC-specific) answer to that, and that's the "1 of N"
> distribution model. The problem is that it is a massive headache (it
> completely breaks with per-CPU context).

Heh, that started out as a very promising first paragraph but turned
ugly very quickly... =3D)

> We could try and hack this in somehow, but defining a reasonable API
> is complicated. The set of CPUs receiving 1:N interrupts is a *global*
> set, which means you cannot have one interrupt targeting CPUs 0-1, and
> another targeting CPUs 2-3. You can only have a single set for all 1:N
> interrupts. How would you define such a set in a platform agnostic
> manner so that a random driver could use this? I definitely don't want
> to have a GIC-specific API.

I see. I've been thinking that maybe the only way to solve this is using
some sort of policy. A very simple policy might be: use CPU 0 as the
"default" interrupt (much like it is now) because like you said there
might be assumptions built-in that break when the interrupt is scheduled
elsewhere. But then let individual drivers opt into the 1:N set, which
would perhaps span all available CPUs but the first one. From an API PoV
this would just be a flag that's passed to request_irq() (or one of its
derivatives).

> Overall, there is quite a lot of work to be done in this space: the
> machine I'm typing this from doesn't have affinity control *at
> all*. Any interrupt can target any CPU,

Well, that actually sounds pretty nice for the use-case that we have...

>                                         and if Linux doesn't expect
> that, tough.

=2E.. but yeah, it may also break things.

>               Don't even think of managed interrupts on that sort of
> systems...

I've seen some of the hardware drivers on the Grace devices distribute
interrupts across multiple CPUs, but they do so via managed interrupts
and multiple queues. I was trying to think if maybe that could be used
for cases like QSPI as well. It's similar to just using a fixed CPU
affinity, so it's hardly a great solution. I also didn't see anything
outside of network and PCI use this (there's one exception in SATA),
so I don't know if it's something that just isn't a good idea outside
of multi-queue devices or if simply nobody has considered it.

irqbalance sounds like it would work to avoid the worst, and it has
built-in support to exclude certain CPUs from the balancing set. At the
same time this seems like something that the kernel would be much better
equipped to handle than a userspace daemon. Has anyone ever attempted to
create an irqbalance but within the kernel?

I should probably go look at how this works on x86 or PowerPC systems. I
keep thinking that this cannot be a new problem, so other solutions must
already exist.

Thierry

--ytjgx34t7yap2p7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjn3TcACgkQ3SOs138+
s6G8yRAAv041zNcMgGZ0avjjb7ZaT6br0d8spAZRKqEUblfT6ypcmLRDIdQikbIJ
7l+LrNKGk0onNtvCoGVuMqdc5HWEpYc+ur4eu2DGX6qFcrTckGZYDNJRwgmSc8LU
mx2xRjZL9+8p1p/ZJ5ZtCjS0o2A6SkxHPCGZmU586GHNvdOyzi5mj8W2mL5520c9
W/GiZkPYJmNJOz7XxxdfENmx9UDbsBlw98mEWa/4WX2vNpqwjjx6DvjqEZbLd4L0
SuN/+ptQJ6rdGEosaWnurFUoEuAJP6kwQFeYrs6eEEoG4SAheVMCoBsXtU2S0aME
ZzRLjDOdlgjlJBcBzeEMCN5KE4u13rni8DmDfp+mvwlb7GOxaVDkMKUXty10Z1bm
Suu9F8w0dkyMdIVHPbxYDYV5UGCLRB23fTVgeJ8XnAEgBviinkoiZiBkpAZ/mivm
985PDzT8AB2RLsVdb9E2k6pwlD1ShsCunyssQHDj3QqfhKv16QLLyEFq5agJ8mJ0
Au6aDjn4d2NYERVvUI3RoCeogRvfk8vVdiymMxoV+jdwxvUYzoHCmAcNHlCyzoFe
jYeCeYyEIEAYKMg4zSofqW2+EqYvMmQ98PK0Vt5Mh0yhsFw+yoL7dwWJbfFQgvBa
DWj6h+sChHu5/hq/rwXkBS8xiacKru+DMcjCRwz0k2iMPkAaVM0=
=N60K
-----END PGP SIGNATURE-----

--ytjgx34t7yap2p7t--

