Return-Path: <linux-kernel+bounces-855779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C545CBE24B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718814066BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE530FF3F;
	Thu, 16 Oct 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmZGAz28"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2E30F7E6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605705; cv=none; b=hEBAyCMvfMvvx91gCMzgdi4fF5Gz+mr21y3rWbiDBPLXPYeZnREziDSz4E6NHhksuCUfTCDJ3zLPARhfx5VCsxgJn0hcXAE6QQZXFbFuEwvnLGES20wCN5ZBM8E9GzJKpCbTh7KmKBLJkYjrxKFc/C7FkbnD0Gi1FZf5+k5ZURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605705; c=relaxed/simple;
	bh=Z3b+ZKz4HAOIT+dIhsy0oGO3fN0g3guLGEf4SOf1J48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+BUsGhqNXPxwRsgrs0PVOqI2TKZ/kdRTBLchc9DCaniRn4QztG3DBaNdwJila9fbbEtZDV7lwbQtOLZrm+owt3FskjFIyI5NSAovyWojB8DY61hHphTQ2E35v+qGqqGHKqhHPDn0WP15Twd4yjiuy97nSQFgqUsOEdD2SVrKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmZGAz28; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710665e7deso2138165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760605702; x=1761210502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=abdY6FoJ2RE+nIOHLn4Md+/wD8DMWssQTpR3F8UFL/s=;
        b=HmZGAz288NvEOb9egZJdKzketEhhm0YmWNqJAqmTl/abiS7h4L/KG0j6KegeZyW6xi
         Q00dBTDV8ccGdPgGxhj+8NR7XEfXV0lmbr7PTTIozVTVRinSSDGrLrk6EjJwOPJV29qA
         i40NmQGGFG1iDWVnIsFzC9zV/b/lHLYCyddZKiWpw2dehL+PNCRDpf3OplyUE2TiJK7y
         /bbID3+oyf1GFaTyxd/tE2PWFG1K39HYhDUIWeeA4NUWbbvxEV2uVtNP18NUPLlvgnDX
         4S9mZfPZ3qF/LvMEKTo71ry47+ZCSeyoiJQEXAWAMWTqIYqk/cytNzRe755y15XS/eeY
         6JHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605702; x=1761210502;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abdY6FoJ2RE+nIOHLn4Md+/wD8DMWssQTpR3F8UFL/s=;
        b=OKoaPG2KI08VMDvwDhKgIluGOSE3xOA2TvUi0Enka+JR3r68W+Znjox/dyBOXD4ee6
         AeXZFOX2xDmmbnVELikE51CpVCs4VTcY4bbqJUNRwUBaUSFnLIQKck8llpbjpChUxzIG
         BOIXf+0+LGEQB4xZYCLRBAzULX53p7uPm7FCYj6gx/zLoexd1pk/MySlKE5HEpQMybXJ
         YN4/uuNJRWQ4VMPduhYBmDgkHZGuVpg+nQQIhaSmJSXWM/Kmn38Eh3qs5F2PO5AxjHJm
         04UEMFF3bBj9dhCj544ietjbsLFEqqLjS2EzVn/AXQPqcgC5Cyd2kuztxcLHJ65OzZD5
         NUUw==
X-Forwarded-Encrypted: i=1; AJvYcCVIzuGyncpAjeB/jomq0ueSjYJ41tqQpYqU7b+JnsxQHECRfIRJ3bD1me7C5kZ6NYNiWbGUYNbpE8TcNDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGykgwhFRIJ8VNB4S/RtdbawUmaV94MqGUNNanmhE8VWd+oly
	nF805FbVTk2BOEe4JQ1kTLsVb3mseDOe0jQkjx1cnauqGA6CA4RvoEZniSWvR2xQ
X-Gm-Gg: ASbGncsDIc603lkDnRLyUmzIdBkFnw8FlJP1BMPE/gk/FODFJHU6teA8O4EkrFfdL7S
	Hcga4TQkRrAojewKYHIXznN1NR6NH+qVzprGCCjz3Htpe8fNgETmehqMfPAC5lAkiaiwborjmYW
	XKBA2tkjbOASzPHo1OTSfhYnhdhX/vW/vMc0iHlLVQAlMuvflPmUFGydkDoGdpR+lg8VQ5nRKdy
	fixVCfIgA/cExN1+ZGCmqspTirZKO2ByEBLdn7uyEZ8pbC5wFzMfCuk3h0uDyLZHW4KoLJmuT3r
	f3WdupFhj+1rxs/McoMTNbruBt3m2ejQ3jsqIzPyZVpC3Ba1pwFdTF8biHDvQqDUxCbBhe3PURp
	4H0jlOcOvzbvLPFSlCy47MewVj/1gMXF1mWvGT1tz1B7+YBkIhtOZg8NKpASXxvlEfpfgNHvZHy
	/WKCj58BCgFfQJp5JHHBE=
X-Google-Smtp-Source: AGHT+IGY8OEZMZNUGJFFWPHGkt+BkJz/xJ0U+q5T/YA/R/Qn+zeASomFVXxFQjW0EoWe8qfc8YL/fw==
X-Received: by 2002:a05:600c:871b:b0:471:1337:7220 with SMTP id 5b1f17b1804b1-47113377843mr8240285e9.3.1760605701416;
        Thu, 16 Oct 2025 02:08:21 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711441f975sm14570015e9.4.2025.10.16.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:08:21 -0700 (PDT)
Message-ID: <c4b5a42f5f1d3f577cb986946b642b4edc1300e9.camel@gmail.com>
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Sean Anderson	 <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-iio@vger.kernel.org
Date: Thu, 16 Oct 2025 10:08:53 +0100
In-Reply-To: <ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
	 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
	 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
	 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
	 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
	 <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
	 <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
	 <ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 13:38 -0500, David Lechner wrote:
> On 10/15/25 11:43 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-10-15 at 11:15 -0500, David Lechner wrote:
> > > On 10/15/25 10:18 AM, Mark Brown wrote:
> > > > On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno S=C3=A1 wrote:
> > > > > On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
> > > > > > On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=C3=A1 wrote:
> > > > > > > On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 controller=C2=A0=
=C2=A0=C2=A0 < data bits <=C2=A0=C2=A0=C2=A0=C2=A0 peripheral
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----------=C2=A0=
=C2=A0 ----------------=C2=A0=C2=A0 ----------
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SDI 0=C2=A0=C2=A0=C2=A0 0-0-0-1-0-0-0-1=C2=A0=C2=A0=C2=A0 SDO 0
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SDI 1=C2=A0=C2=A0=C2=A0 1-0-0-0-1-0-0-0=C2=A0=C2=A0=C2=A0 SDO 1
> > > >=20
> > > > > > > Out of curiosity, how does this work for devices like AD4030 =
where
> > > > > > > the same
> > > > > > > word
> > >=20
> > > The AD4030 is just one channel, so doesn't do interleaving. But you
> > > probably
> > > meant AD4630 when it is wired up with only 1 SDO line. That line has =
to be
> > > shared
> > > by both of the simultaneous converters so it alternates between sendi=
ng
> > > one bit
> > > from each word. This patch series doesn't address that case. But this
> > > series will
> > > work for the AD4630 when it has 2 SDO lines wired up.
> > >=20
> >=20
> > Hmm I didn't even remembered that one. But what I meant with interleave=
d was
> > having
> > the same data word spread through multiple SDO lines (one bit per line)
> > which is what
> > (also) happens with the devices I mentioned. And since you mentioned ".=
..two
> > different data words at the same time, one on each bus...", I raised th=
e
> > question.
>=20
> Ah, yes, I know what you are talking about now. I didn't mention that use=
 case
> in
> the cover letter because I didn't want to confuse things. But actually th=
e
> AD4630
> can have 8 SDO lines, 4 per each data bus/ADC channel. The groups of 4 ac=
t
> like a
> quad SPI where 4 bits of one data word are sent at the same time. Those 4
> lines are
> considered one "bus" since they are all connected to the same serialzer t=
hat
> combines
> the bits into a single word. We already have support for this sort of thi=
ng in
> Linux.
> And sure, we could mix the two together. So a SPI transfer might look lik=
e:
>=20
> struct spi_transfer example =3D {
> 	rx_buf =3D rx_buf;
> 	len =3D 4; /* 2 x 16-bit words */
> 	rx_nbits =3D 4; /* each bus is quad SPI */
> 	multi_bus_mode =3D SPI_MULTI_BUS_MODE_STRIPE; /* 2 data buses */
> 	bits_per_word =3D 16;
> };
>=20
> This would result in a transfer that reads two 16-bit words in 4 SCLK cyc=
les.
>=20
> And the .dts would look like:
>=20
> spi {
> 	adc@0 {
> 		compatible =3D "adi,ad4630-16";
> 		reg =3D <0>;
> 		...
> 		spi-rx-bus-width =3D <4>;
> 		spi-buses =3D <2>;
> 		...
> 	};
> };

Yes, it makes sense! I guess the above is what Mark meant in the first plac=
e.

>=20
> The AXI SPI Engine doesn't know how to do the quad SPI part yet though, s=
o
> it isn't something we could implement right now.
>=20
> If we tried to do it with spi-buses =3D <8>; then we would end up with th=
e
> "interleaved" bits (or nibbles depending on the wiring) that requires the
> extra IP block to sort out when using SPI offloading. Technically, we cou=
ld

I think that extra block already exists today. I was thinking the idea was =
just:

// the case where we just have one channel with eg: 32 bits words (eg: test
patterns)=20
struct spi_transfer example =3D {
	rx_buf =3D rx_buf;
	len =3D 1; /* 1 32bit words */
	/* 4 lanes which is actually quadspi */
	multi_bus_mode =3D SPI_MULTI_BUS_MODE_STRIPE;=20
};

I still did not looked at how the stripe mode is implemented in the hdl IP =
but
maybe the above would work as we get 8 bits per lane and we do have the dat=
a
reorder IP (or at least used to have) after the offload engine.=C2=A0

That said, I do see now the above is not the intended usecase for this seri=
es
and even if it works we kind of have to hack the xfer len to 1 which does n=
ot
reflect reality.

> make it work, but it would require a bunch of extra hardware description =
that
> the driver would have to interpret in order to correctly format the struc=
t
> spi_transfer. I was hoping we could avoid that and just teach the SPI Eng=
ine
> how to do dual/quad SPI like other SPI controllers.

Agreed!

- Nuno S=C3=A1

> > > > >=20

