Return-Path: <linux-kernel+bounces-855009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21121BDFEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECF464F0D61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29415262FC0;
	Wed, 15 Oct 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYo223ge"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C632FDC30
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550150; cv=none; b=f9qY+pxdKF8c1oaCBQeHcsur67NwL2SbYUK4ou3jjzZUUm8KNqvuqFBYDmCDvzCUVYPD6xpGWfGOYOlbC1WhuUT7kP5IHuL3Pndacy0wD6XkNdQtzPMi5C9Qd4wsLDP4/Z7qT+vjFm/d4uCAsIYMcqrX/mN+SoqJzdB1gHW5BJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550150; c=relaxed/simple;
	bh=3+itAC0ygGD72LAGTTk7iU8ATNurfAWGwrb2f3cn7NE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbPFNa4hFHb40dGqpZRwbmGBmSzYT5OdboBPxN9AbWpkWQBxH5cJWeZ22uyC9QurGZXkfpqHRrJDCXxCazklNKLUJlnHhNDk/LRPMgCvp0+dbL3i2+l12cmmkCO3mUMX/Oegoykux9W/DTXVjQFltcqswfAZcTMVSI0yz6O8jZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYo223ge; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so7187975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760550146; x=1761154946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+itAC0ygGD72LAGTTk7iU8ATNurfAWGwrb2f3cn7NE=;
        b=BYo223geAauqK3E1+dYo5vT1M0nxArwCW8KLQQeX1e7FaJtHORsKr6xJb0CNOtJZxg
         OnrEECsyLeoUmhD9NcEWRTV17G1FjKsstwmQLZ5jMeP+Apdqo6Bpei/Pk2DqWU5jgOte
         HThhZDyM+xDiM0j1Db2IpyzzLp9qtjdeu2Ll5nKaXLALAZ6HSJxF4ITZchSQ7IS++v53
         4JUzu9MHkI9yh5JbZXH5JdL3MDEZbbck19C0m4FG/FG2xMDauul7m7ZJIblUfj5HMbwS
         B+fyA6AAaZmdec/nH+wnCuEiEMQETRBCLL5WveTyqL6uG73aF+dMhVTWHP+6Bvxssq0h
         CQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760550146; x=1761154946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+itAC0ygGD72LAGTTk7iU8ATNurfAWGwrb2f3cn7NE=;
        b=TKPgstia8FZMIrBG6gT9YG+v6uCMrGGEojCSpDG9/6nWaFsYJGMMDeUYU3O8lZFc/L
         wVwVbN+Oid4VAu47DhoscYjPFK207orv3BI2W4le0cQfcWirE9DYWU8kT1hNXj5JFszH
         VTgmaU5IUidPyCE0/xP1ds9XMdndK6QnB2w9Q5mvtdz1foGEU2OhMrt/kIzq2QLOJFsF
         XJ2DZABrXoa/4gjAGPPt4F9IdIStHDrw57ZLUpZzHixnTYrWZ3Pcnp8Mltq4AELDtrC9
         TKBKM6ORkgT015T2TBzI+/0Iz0wD2ZHKdk26CM5o+CTyO28UkwF0LhIoRm3ar+gmud+U
         uymw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGYF6aGa9eX2/7KdsGKEKHzWv+UgwJzOe/bjxUXkZC4GSs793ySmV+uDaq32xxtKIhOYqvd1uC218mLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ClTaLeO5lsfFN29XpadcAHFfnB2ZP1N6e1srSlG+b+aAJbl/
	1vInrIKwfkrzV3VuxovVXzUQGlM/0cVO1JUf+Zanu7SfUQzUJtJEW/yA
X-Gm-Gg: ASbGncvxn6tt65dHv3dk+PK2HLnVpUj9+YGZDz964JOuAq374xOEBFQW37gLAwMGqNw
	0cmhCGDomiIXXR7R/oVSSqGZAPOatMkNbJlPIg5XdWmuEiAdm5oG1fX7jZXIAgCCFjosMz5zP1t
	3E3KP2d6wT6cyxo/x2McRAeSJ6D5vZqzxGDywd2MVfxFzwW7ifjLXQyt352SKP8jllFKbb2CJSS
	2x//3b0ECh4jRqPsQzbQ1pJMTk2RPyLQ2XRAnMWLPYDxPUYHt6hg1KduyEYbS2gg7g70RpZ0UpD
	sUQL5wfblTP1lrKdZFUasjA8x2Ig0vUWtpmPDALUbN/kzhxwYOKB2vyxsl1AoHMCLnmEjY3gRT+
	xQie9O7R39LvpHXbtXixdzhXGzNj8ayyJCXGIFERLFxRVh+3Sh+syDBukO1O2RUeR9CZlq1Q4H/
	pp8UOPmGYLpmiHBvGD6QVQ4Cgl
X-Google-Smtp-Source: AGHT+IFgW4ioV30CaVR3MUPobKOQBTrlVgHHJX7mniQYbGNt/6t4FH7ErC+FnEf2jcNfSIVwBiGr0w==
X-Received: by 2002:a05:6000:1a87:b0:3ee:b126:6b6 with SMTP id ffacd0b85a97d-4266e7dfee2mr17701996f8f.34.1760550146266;
        Wed, 15 Oct 2025 10:42:26 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426fb279857sm1628868f8f.20.2025.10.15.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 10:42:25 -0700 (PDT)
Message-ID: <9024f05854dcc3cc59345c0a3de900f57c4730d9.camel@gmail.com>
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
Date: Wed, 15 Oct 2025 17:43:22 +0100
In-Reply-To: <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
	 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
	 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
	 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
	 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
	 <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 11:15 -0500, David Lechner wrote:
> On 10/15/25 10:18 AM, Mark Brown wrote:
> > On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno S=C3=A1 wrote:
> > > On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
> > > > On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno S=C3=A1 wrote:
> > > > > On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 controller=C2=A0=C2=
=A0=C2=A0 < data bits <=C2=A0=C2=A0=C2=A0=C2=A0 peripheral
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----------=C2=A0=C2=
=A0 ----------------=C2=A0=C2=A0 ----------
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 SDI 0=C2=A0=C2=A0=C2=A0 0-0-0-1-0-0-0-1=C2=A0=C2=A0=C2=A0 SDO 0
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 SDI 1=C2=A0=C2=A0=C2=A0 1-0-0-0-1-0-0-0=C2=A0=C2=A0=C2=A0 SDO 1
> >=20
> > > > > Out of curiosity, how does this work for devices like AD4030 wher=
e the same
> > > > > word
>=20
> The AD4030 is just one channel, so doesn't do interleaving. But you proba=
bly
> meant AD4630 when it is wired up with only 1 SDO line. That line has to b=
e shared
> by both of the simultaneous converters so it alternates between sending o=
ne bit
> from each word. This patch series doesn't address that case. But this ser=
ies will
> work for the AD4630 when it has 2 SDO lines wired up.
>=20

Hmm I didn't even remembered that one. But what I meant with interleaved wa=
s having
the same data word spread through multiple SDO lines (one bit per line) whi=
ch is what
(also) happens with the devices I mentioned. And since you mentioned "...tw=
o
different data words at the same time, one on each bus...", I raised the qu=
estion.

So I guess I kind of misused what interleaved typically means (even though =
I guess
it's not completely off :)) and was thinking more on the parallel concept M=
ark spoke
about.

Anyways, from your reply I see the intent is to also use the stripe mode fo=
r this and
have some kind of external IP deal with data re-order. I gave a look into t=
he ad4630
IP core and indeed there's a data reorder IP block after the offload engine=
.

- Nuno S=C3=A1

> > > >=20

