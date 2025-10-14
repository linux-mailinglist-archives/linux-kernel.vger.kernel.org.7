Return-Path: <linux-kernel+bounces-852418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A0BD8EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A34D4E2B91
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D60305063;
	Tue, 14 Oct 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7028YIM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792592ECD3F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440117; cv=none; b=TQk/UZi1XiAdlwKjQ6rqMBN5nP3gkWZ0Uz3XhSwzvoUQAYaRosj/sMxLLnEFPCkPbh1v5fk2chNQjWWvh0ytD5OkAYH7Md4LNjDXr6MSiozQIxapTsJTmjyFU7oiHZhAViIKsQH7C8chHZd6imrAKNEB5jfJjM4Lb81gr046krs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440117; c=relaxed/simple;
	bh=G2RPqglnkhxPCycGIsQsokk1Hrp2ASUzryFOm8mZU2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcVWIza63DLgnhXI3SdtlXCjHubafbmngIEVbBtEsQVSDuNZvg0QdUhYVZkaIUJ6CH7/cPpe93Xhu7RrHB3HSMtVBDOBhYhjtbkCCWDMD1Ecx8rq0bNVW0QI4w/OFpHV7UHep90I+A9ZKr/sDxCDpvzpylS3GDWndAZeDB3js/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7028YIM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so5893087f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760440114; x=1761044914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPetjpKaANYcaWLgkrrduiZNuU2Q3v8y55EcDsrfO0c=;
        b=k7028YIMojxl1wnK5gaAt8Rj9NA1p+0Yitq5Wz7awORHiKh88jmNKcMdGUZi6CjKXh
         /ssqe0hJ2n45OkLCFjxNwk4GqlBJK7Pibzsrqgp6GJiAjg8FYRe7T067Q/uKw7o2XnQc
         pI1J/TzM9WVqotDU21QGWSipbCXl3FEoiyAkLjvdCEoqp8GCJiCppC6jqWMtvkVTSH0y
         ZR+oTbPRs2RaLOTJJjBz6OpOyKY95nO5bgiRdhJcprb5rq3vnQieUF7N08h6DxZiQ/Pm
         /zKLwdp/AC0WAjwJ4WDsxX9X0GqkhaLgfWxSHiecNfItjRyokU4wAJuXFLqhWUeWBSW9
         k8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440114; x=1761044914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPetjpKaANYcaWLgkrrduiZNuU2Q3v8y55EcDsrfO0c=;
        b=r8t31BDz/IKQGwk76lC5goJHyO5XZmWil/E9Msk+svEMS+NIq5+NbxQ3YttANq2RUx
         oI2QiJymuDJE+AYyi7wE6Ns97Jf7xpKqKH14VMDflzEQMQg/U185ShZd14evJGR3bPXA
         quTHO6BC/4/MeVjFePk7QwhdC05eiCuoLf9nnELpVHjCFbJCo3woSrlytjX5uHuoIx68
         +cD7RCM6+MnXwEgdqSrqvPZZcdZj9NpFOI+GcQWUlHKkjQK1RB9rz1+4Xsz29r8QBA6v
         EwK7dVMM3J75KgSULEc/VVw5SjfmKxn/QloGeLy6UmrafwENCA4/IHP1+xKhSygZITYx
         2wZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6+tmYv6hednFbamzNCcwwlRaj1kN/ntOJYrsUlTwem5si7IDOKpRDGLPNKXuXUh0I4SVlANXJeRomNW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuizFGClJDiLXFWxfjtuL/Ui87KsHj0uBAVq8wmt29o3S16q8F
	24GTYrYSUct2+pgVBSHN1kgFI+o0HB4SO+c/rYIke+pgvcGEnaxDRSWZ
X-Gm-Gg: ASbGnctlYyt+zDJ/ulHGCVjjHW+eR0dePz9WgzHedZfrVRkwpZVIUNQtQLiKVwWi3+f
	Fyq9kM0VoU3+mFm/Ix62bQy3lTvVYBTKSwRKz0LAsucprNsXcxCZS2i2s3mxGzzW60U7USb51J0
	oL4dTqVTTa/hvCITD7YQh+UfJ2Bcm56jsA6Jkf6PpCz0KXLBoXhJ4Rfjzom8x7DZpg6bt3uZpgH
	xcUBRiri31/3dLQxz/jo4ZtUgJGIXWq8t01csc5B1B/mjHvdVHFK2IH2NI3TxVNFQOuKJPCv0vM
	Jdox1OgGuxXh+ltpBWDv3jcL4ylQB37iLiGKNpYssALsraIY6xmC/1Ms2yjGouaw+ITNxxSci4X
	g+BNGNa6zTAochBRB+EZD40SOGVotZB0+IkthPC+S2SITCjO5NkQSavNnu9vMdMzlNTZAt7hczq
	JdjjD0ry8zTO+I/NPNx0aibWajFXl11EV/7+opUV8=
X-Google-Smtp-Source: AGHT+IESDQkkKQFxDd3gKEVsTIe3KB0qZiIE+wyBsS0WnJH2Bh8XOS/Fj/147wchmYc+eDbh7IytIw==
X-Received: by 2002:a05:6000:2910:b0:3d1:c2cf:da07 with SMTP id ffacd0b85a97d-42666ac48bamr14569143f8f.4.1760440105681;
        Tue, 14 Oct 2025 04:08:25 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc03sm23711273f8f.4.2025.10.14.04.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:08:24 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:08:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: IRQ thread timeouts and affinity
Message-ID: <wosxizbb5z3goikqglsdbrgmshith62upwnavnbqeq5dndfau3@bna46rg3w2ak>
References: <j7ikmaazu6hjzsagqqk4o4nnxl5wupsmpcaruoyytsn2ogolyx@mtmhqrkm4gbv>
 <86qzvcxi3j.wl-maz@kernel.org>
 <loeliplxuvek4nh4plt4hup3ibqorpiv4eljiiwltgmyqa4nki@xpzymugslcvf>
 <86o6qgxayt.wl-maz@kernel.org>
 <86ms60x7w7.wl-maz@kernel.org>
 <us2hfdn7jpfepdmwk2p62w64p7xagaeoemg3hdt2vm54emtwlv@m6fkuti7hvfa>
 <86bjmeyh5m.wl-maz@kernel.org>
 <graeplkpsgbolpnnq2pndpdb7fymyy7zvm37osbdtre347tns2@mjbgzwterefv>
 <87sefpoj10.wl-maz@kernel.org>
 <6hb5vyl5xxsxfcwk4v3xpq277wusj5jq4tubdpjocpjc5smj3w@wx574kluhedj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nz4k73ft56a2tnts"
Content-Disposition: inline
In-Reply-To: <6hb5vyl5xxsxfcwk4v3xpq277wusj5jq4tubdpjocpjc5smj3w@wx574kluhedj>


--nz4k73ft56a2tnts
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: IRQ thread timeouts and affinity
MIME-Version: 1.0

On Tue, Oct 14, 2025 at 12:50:18PM +0200, Thierry Reding wrote:
> On Sat, Oct 11, 2025 at 11:00:11AM +0100, Marc Zyngier wrote:
> > On Fri, 10 Oct 2025 16:03:01 +0100,
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > On Fri, Oct 10, 2025 at 03:18:13PM +0100, Marc Zyngier wrote:
> > > >=20
> > > > CPU hotplug is the main area of concern, and I'm pretty sure it bre=
aks
> > > > this distribution mechanism (or the other way around). Another thing
> > > > is that if firmware isn't aware that 1:N interrupts can (or should)
> > > > wake-up a CPU from sleep, bad things will happen. Given that nobody
> > > > uses 1:N, you can bet that any bit of privileged SW (TF-A,
> > > > hypervisors) is likely to be buggy (I've already spotted bugs in KVM
> > > > around this).
> > >=20
> > > Okay, I can find out if CPU hotplug is a common use-case on these
> > > devices, or if we can run some tests with that.
> >=20
> > It's not so much whether CPU hotplug is of any use to your particular
> > box, but whether this has any detrimental impact on *any* machine
> > doing CPU hotplug.
> >=20
> > To be clear, this stuff doesn't go in if something breaks, no matter
> > how small.
>=20
> Of course. I do want to find a way to move forward with this, so I'm
> trying to find ways to check what impact this would have in conjunction
> with CPU hotplug.
>=20
> I've done some minimal testing on a Tegra264 device where we have less
> CPUs. With your patch applied, I see that most interrupts are nicely
> distributed across CPUs. I'm going to use the serial interrupt as an
> example since it reliably triggers when I test on a system. Here's an
> extract after boot:
>=20
> 	# cat /proc/interrupts
> 	           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5  =
     CPU6       CPU7
> 	 25:         42         44         41         29         37         36  =
       39         36    GICv3 547 Level     c4e0000.serial
>=20
> I then took CPU 1 offline:
>=20
> 	# echo 0 > /sys/devices/system/cpu/cpu1/online
>=20
> After that it looks like the GIC automatically reverts to using the
> first CPU, since after a little while:
>=20
> 	# cat /proc/interrupts
> 	           CPU0       CPU2       CPU3       CPU4       CPU5       CPU6  =
     CPU7
> 	 25:        186         66         52         64         58         67  =
       62    GICv3 547 Level     c4e0000.serial
>=20
> The interrupt count for CPUs 2-7 no longer increments after taking CPU 1
> offline. Interestingly, bringing CPU 1 back online doesn't have an
> impact, so it doesn't go back to enabling 1:N mode.

Looks like that is because gic_set_affinity() gets called with the new
CPU mask when the CPU goes offline, but it's *not* called when the CPU
comes back online.

Thierry

--nz4k73ft56a2tnts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjuLyYACgkQ3SOs138+
s6HKKRAAsKq6KQD9SNZ7hoquknxqVobKoCxv4LN0G9P8nD9bTQQvGw/ocGG3Pu4Z
/tHLC34ssVALvO9tOxRi8wsWM6O7wiQhKmFskX4u8MRbXAoHBKOJO2pW69ZwW/5Z
HJEwKhmDymvpH2htv4gvcHdL7iQJfK1hLD2wRnzXllgwnCFA50leSfPCS/jr2LQP
tZJY2An4Dtr/TvT+gSEVxEuHNJRHavLEqGbg4mY0OEsGhkoQ/wDEq3TOCuDV2CFH
DZm2+rk7fGRP59gV3a5xOgCb1MAsfCsraw2mshaeOo4XzrCVByW0G0W9IuYzbfjW
UGJTc5VikmKdvjHvrgQo0RtGLcH7D13+piuwCeTV0zEhjmtI43y4lvXWPVhc0E2v
1VAFoVT/UUop7FKy0CT+UOvhjvIQFehJXfxz99sXrjnV0udGR28rpSYU4289LxGp
xtV5Z8XSeh5qp5Vgj99N3pv4jE/nYpumLEO8BxrNld1gLOeH2l44XztHeHqTsZH5
wKccisf+h2ADiLiTK6EHI1u2exQ1C2Xu8KeKI/xz9UDDyDBPxYxcfGGdm/510qq3
wtoZ4d4BjJ6OXB2G+IC9qVpKpxW587UxYrfKt1/Gjs8BdqU9doN5uSq0JEqu0UMd
Tf0dE61kCSlqDSWLBz4ZVewIafm68sFm7t8pBrzIyViYGJ4VN6A=
=gdpR
-----END PGP SIGNATURE-----

--nz4k73ft56a2tnts--

