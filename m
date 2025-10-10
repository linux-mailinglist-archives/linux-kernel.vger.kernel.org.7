Return-Path: <linux-kernel+bounces-848304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246CBCD568
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC15334D81C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5472F363E;
	Fri, 10 Oct 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHkyZrJQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF671288C25
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104263; cv=none; b=ASgZuG0Nl9Aq6iCHEOO5spFU9K8Kjdj5P1K/pLUYz7iebRL+SxTi2I3eNm5MlxUpISBTPoZIM+/LtjR/D7iCfg0L8JWdLhKaLUtFP9ae+JU8dJ6jqp60Ugvi6C043dkXRaBlfSydo0SzV4wJwDPPha1DH+4zFRstrUjqddiZls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104263; c=relaxed/simple;
	bh=4FDjizrFedYdApV4Kwq5abuNiCsIXR1HSp7V6sP08+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAMGXpM0xJYV/0+CU2kRJQYo76s+SAIm9cIfMLGK/4YyQpnO+t+P/W8KL8h1RMDyr+52nS6g+Xa+4r0oLVsIiTc/R3s2dnfXVWHWLzIVlCdDyWMSkZ2xboHkRYaTGpoMeyh6a1qb9NowxtRdhzdMKbl4FFWSMoP4FJCU85k+bkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHkyZrJQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso16233725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760104260; x=1760709060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZ1++ekTPtzW028TaYNKl4rUChmdflgkEaStZQX+AL4=;
        b=VHkyZrJQpZI9qL/a39nCgLsrlKa2/HKE1rTKGEbA0brjf8kuFhkdC1KfwfFsLNqK35
         KhEEsquGFk3tPKTBub0HBNNRn4qki4Lbbw3948Iv7ZH8worFZ5B+eS2gJu/h944aQeDt
         0Gt/XwuP6Br9yeCQm+7mAHWu+ETuZR+oE3xZMaZ5Ub68/C4aHsT242OmDwnIeOtP3k5+
         8jgiGzMevJa4IQBP+GrdBL6PZLfgujRbVGkJyHWr8LLzku2K0kCf20Nk5vNL2UYxwlBQ
         +w/6mhv4to4UdLcDsTmCV0MfupR8Aga0XNlV5OMz12XAx83USECdOyXHuV7ETXlGTXYd
         iM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760104260; x=1760709060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ1++ekTPtzW028TaYNKl4rUChmdflgkEaStZQX+AL4=;
        b=V5g1/gUhpQVPuDPa8mohrPOMZhM9nP39z5JpQESRxRRf0RE9p3H5z/COd8860HAf1U
         UfCVBi3M4Mi8vqApRliT5NAIJwXOOYuLORrFOWcpvjtnZmz/aeNsAPyNPCyTHIwDyrZM
         Nex4B4SQT0DsMNme1mcfPgOai22OuCD3eAOz9mJT2ZZzrXIrm5obeYxAAWqGiF46v47d
         7xmDtJi/IS2I7Xdy+3KJvt2HjPLmvETtTonntW7wmTVec8IDIUZ1U4cAtaiWqkM7GwhL
         AcMapu/+39atBuLbw3HEL6gsHBFy4B0gsvD5BWl7ypqLmcWqdpTpoWwumVmtPGbFduGq
         mrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq0BVCEm9diqkqhvkvFuFX97ZMBDA6Ng9W1JwVNWvuFEiGeRFzfz54u6aRPTyDRsFGK0nQXoUkLBEYEJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/A+8R458ZD1E/MMW8vPbeIP4MMxeAPSMqjz/q0e6DhQsH42VU
	Ao09/QfBDUDcaKUQa0tWxjPnEAlbuZ25o2vgczhqD1KX0b1q6kPCqJwZ
X-Gm-Gg: ASbGncu2RNYpE8e92UM4RtgwvNlMcq7e4TkYxnJnaO0cxRYUlMdtVAbgkbeusXMp6zi
	+mqkK3I+rVH+AYzgdFZWY74nZRQYrTCM//PykMSTWddG7I2aXDpvolYgMh2/gD624Cu2RZI8Aae
	jtef1YNqD2UCSp7jpbN1gMHK94TMJjhNBelRiccJ6hfd1pLTPToUyVwJrJwVnsJqucSN2rKIcp4
	aUwI+JDPT/uL82yvCcAT/gl0cRy8Bd0SrFl6bDEco56y2PbNsALC4rzWmxz6f/b5VvXPtVhFV/A
	CtAZgZw5Ek9s0/VvUYMX2yMPDK+3H9LDriuFoi4tp6GEKiBPNlYzgtnPXSmi1QsGWJiyLPGVSOn
	KoZpksO1mw70TM2Kg7i48eA3OZAIr/UGeaoFyjtRkTXxbe6iVdIWNsXvbcs2vvBxwh+C0u7q/88
	jw3x/QLab9pyJ3eiDr/7JQJ0HUIPhTmbBRLssAKB8=
X-Google-Smtp-Source: AGHT+IEshn5BeHxphWH/iqJ/hWVLW9YiJEVo7JGmJqFmzIvH5+RSg739jHkexUzzwZyAmWc+E2cqig==
X-Received: by 2002:a05:600c:83c6:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46fa9ec7727mr82513905e9.15.1760104260021;
        Fri, 10 Oct 2025 06:51:00 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm49385365e9.4.2025.10.10.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:50:58 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:50:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: IRQ thread timeouts and affinity
Message-ID: <us2hfdn7jpfepdmwk2p62w64p7xagaeoemg3hdt2vm54emtwlv@m6fkuti7hvfa>
References: <j7ikmaazu6hjzsagqqk4o4nnxl5wupsmpcaruoyytsn2ogolyx@mtmhqrkm4gbv>
 <86qzvcxi3j.wl-maz@kernel.org>
 <loeliplxuvek4nh4plt4hup3ibqorpiv4eljiiwltgmyqa4nki@xpzymugslcvf>
 <86o6qgxayt.wl-maz@kernel.org>
 <86ms60x7w7.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="672rw65c6imvnytk"
Content-Disposition: inline
In-Reply-To: <86ms60x7w7.wl-maz@kernel.org>


--672rw65c6imvnytk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: IRQ thread timeouts and affinity
MIME-Version: 1.0

On Thu, Oct 09, 2025 at 07:11:20PM +0100, Marc Zyngier wrote:
> On Thu, 09 Oct 2025 18:04:58 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
> >=20
> > On Thu, 09 Oct 2025 17:05:15 +0100,
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > [1  <text/plain; us-ascii (quoted-printable)>]
> > > On Thu, Oct 09, 2025 at 03:30:56PM +0100, Marc Zyngier wrote:
> > > > Hi Thierry,
> > > >=20
> > > > On Thu, 09 Oct 2025 12:38:55 +0100,
> > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > >=20
> > > > > Which brings me to the actual question: what is the right way to =
solve
> > > > > this? I had, maybe naively, assumed that the default CPU affinity=
, which
> > > > > includes all available CPUs, would be sufficient to have interrup=
ts
> > > > > balanced across all of those CPUs, but that doesn't appear to be =
the
> > > > > case. At least not with the GIC (v3) driver which selects one CPU=
 (CPU 0
> > > > > in this particular case) from the affinity mask to set the "effec=
tive
> > > > > affinity", which then dictates where IRQs are handled and where t=
he
> > > > > corresponding IRQ thread function is run.
> > > >=20
> > > > There's a (GIC-specific) answer to that, and that's the "1 of N"
> > > > distribution model. The problem is that it is a massive headache (it
> > > > completely breaks with per-CPU context).
> > >=20
> > > Heh, that started out as a very promising first paragraph but turned
> > > ugly very quickly... =3D)
> > >=20
> > > > We could try and hack this in somehow, but defining a reasonable API
> > > > is complicated. The set of CPUs receiving 1:N interrupts is a *glob=
al*
> > > > set, which means you cannot have one interrupt targeting CPUs 0-1, =
and
> > > > another targeting CPUs 2-3. You can only have a single set for all =
1:N
> > > > interrupts. How would you define such a set in a platform agnostic
> > > > manner so that a random driver could use this? I definitely don't w=
ant
> > > > to have a GIC-specific API.
> > >=20
> > > I see. I've been thinking that maybe the only way to solve this is us=
ing
> > > some sort of policy. A very simple policy might be: use CPU 0 as the
> > > "default" interrupt (much like it is now) because like you said there
> > > might be assumptions built-in that break when the interrupt is schedu=
led
> > > elsewhere. But then let individual drivers opt into the 1:N set, which
> > > would perhaps span all available CPUs but the first one. From an API =
PoV
> > > this would just be a flag that's passed to request_irq() (or one of i=
ts
> > > derivatives).
> >=20
> > The $10k question is how do you pick the victim CPUs? I can't see how
> > to do it in a reasonable way unless we decide that interrupts that
> > have an affinity matching cpu_possible_mask are 1:N. And then we're
> > left with wondering what to do about CPU hotplug.
>=20
> For fun and giggles, here's the result of a 5 minute hack. It enables
> 1:N distribution on SPIs that have an "all cpus" affinity. It works on
> one machine, doesn't on another -- no idea why yet. YMMV.
>=20
> This is of course conditioned on your favourite HW supporting the 1:N
> feature, and it is likely that things will catch fire quickly. It will
> probably make your overall interrupt latency *worse*, but maybe less
> variable. Let me know.

You might be onto something here. Mind you, I've only done very limited
testing, but the system does boot and the QSPI related timeouts are gone
completely.

Here's some snippets from the boot log that might be interesting:

[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GIC: enabling workaround for GICv3: NVIDIA erratum T241-FABR=
IC-4
[    0.000000] GIC: enabling workaround for GICv3: ARM64 erratum 2941627
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 320 Extended SPIs implemented
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs, 1:N
[    0.000000] GICv3: CPU0: found redistributor 20000 region 0:0x0000000022=
100000
[...]
[    0.000000] GICv3: using LPI property table @0x0000000101500000
[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000101=
540000
[...]

There's a bunch of ITS info that I dropped, as well as the same
redistributor and LPI property table block for each of the 288 CPUs.

/proc/interrupts is much too big to paste here, but it looks like the
QSPI interrupts now end up evenly distributed across the first 72 CPUs
in this system. Not sure why 72, but possibly because this is a 4 NUMA
node system with 72 CPUs each, so the CPU mask might've been restricted
to just the first node.

On the face of it this looks quite promising. Where do we go from here?
Any areas that we need to test more exhaustively to see if this breaks?

Thierry

--672rw65c6imvnytk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjpDz0ACgkQ3SOs138+
s6FCdg/+LsBNRHyYhyktvtT7AXV0J0dQ7HHiuJ3QqP0h/8/55fq+sj47mXE8oeHe
oa8Or4UHyaXbKs/h+FyXynELeYObTsrXlu6Bt2tmAzxT+DGOJ2uVw6J7fVpKasN0
3QSh9o4eTbt8h/bHd4SwvHF3Hc82VMz9KUJyrImVThTil1NI0FEy2OHHzXhc/3ER
dg5vA+yh6koult84wixmq3C4Fb+3DfgM/zOzB0wTc5Mfe2TwZ48b5++k6Tvj7/hF
1ThnZq8mxZK6s71ZSVerVXCwAfyF6ehg/jaBCX8fvnWzDIcb3uc9fA1+F5rJ3aTv
ltPSdj3DykrMHEr3vLvWnQp2qkp+zh7Fp8rv3tg+PaeuDsrfFbxMfTLtBms39QOn
GBt4I33m7jF3ttit7D8R/oXY1aB/ZWhkigGPvw2MA9hICi16MhUXGV8191e9chtm
pEaSBKmWEK9vTf/Gf6OvhBjhuuILizuDGTpOuidGmk8wKxTmr0WB/xL5idn/NJbl
uzw1oz2iL5koIPgMcVjYv8rxKITW/QZxehQ3rUFaTYyeoUoykECb9rJiAmgDL1vo
4MK3cKMeFZOCgbD4M9kOgZJE1zNRKHKp3G7OTL3NFlgYjZl3wI+Y45+hCWV3v2FJ
Nv99rdvczPzi9SyLdE3sr81gQP0qYyW9c5UofSEdoQO7oFN7Sdw=
=b/dB
-----END PGP SIGNATURE-----

--672rw65c6imvnytk--

