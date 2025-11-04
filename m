Return-Path: <linux-kernel+bounces-884379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE4C300E4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DCC3BE9C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C28431D396;
	Tue,  4 Nov 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JJndxSo/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9F306B37;
	Tue,  4 Nov 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245718; cv=none; b=LyJedHzM8quA4CDZBu/I4K4FNBnDCo0Vy+NzvMsA98AMoyHhq11Tbh0G2iTV6qz5rBBOFPWbfz8ESY+kV0aPxbgXLYb6Oq7jF+CSBPIccvouC3MaT4dq/XjMl8MjilmqVqSrfW9f/EO67kOikQuqUJk4LQAEXb7oK7KAGKpKcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245718; c=relaxed/simple;
	bh=purqrqfkmeNjHQsl8PGKaLr5sce14i7I1X0t6grKmRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6+0//4UUgD1jpYooeDEDkzfTa0Ctw/k30rs1UfyS+AxcikTatQZy7liJjDzjCubRvWBeqwKRIUarSF6kwlAIXIg3CPktI6sgY5/5sfCRXJW/QB5I0SMZji7BGIfEZIXiHHCxdHLDN3Po6WYu39dBGntVNviuEewiNBYpQZu4qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JJndxSo/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762245716; x=1793781716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=purqrqfkmeNjHQsl8PGKaLr5sce14i7I1X0t6grKmRE=;
  b=JJndxSo/Jbv9chcr/MWWsqgrFvkje+0i2hTjJHWbHBIX0JWjoyWVJfC6
   YPurGJYhgiwu8S6vv6Nfqs6CTEmCRdChAhEbbX9fSGSSUdu+fa3eEc1r/
   sRlnP1iWe+5VbbLZ494p/7FRVONmLm3DVfq3UEFwhaBcnCyvFA8ULqWDn
   GOe7Te1ZughGtnhtM7oTX3Jr3MdIICo/aJ+0zgT01S02lnm9zASppzNYK
   hrUY6q0IcD8uFhU2C0Ta9vQZP6Ue5AizARKsFofioVrfmVof8WDKYRJbU
   G9nj1t8hRDmgxtxpde1sTnfYctqan7ktfsxAiKqbPJZYNioFYUqBWttO9
   g==;
X-CSE-ConnectionGUID: UM+sI3xNSuSueVWnZFHkVw==
X-CSE-MsgGUID: mbc01x2RR+e0T7CjDOussw==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="asc'?scan'208";a="48018374"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:41:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:41:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:41:22 -0700
Date: Tue, 4 Nov 2025 08:39:39 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: <Marius.Cristea@microchip.com>
CC: <conor@kernel.org>, <corbet@lwn.net>, <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-doc@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: temperature: add support for
 EMC1812
Message-ID: <20251104-displace-pretense-9efca7fd0796@wendy>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
 <20251029-hw_mon-emc1812-v1-1-be4fd8af016a@microchip.com>
 <20251029-blaspheme-stinking-91b73a8ab778@spud>
 <c844428aa8d57d870b8cb55ce37d6359e3142585.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/AVkAT3sA6d22eia"
Content-Disposition: inline
In-Reply-To: <c844428aa8d57d870b8cb55ce37d6359e3142585.camel@microchip.com>

--/AVkAT3sA6d22eia
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 04:35:27PM +0000, Marius.Cristea@microchip.com wrot=
e:
> Hi Conor,
>=20
> On Wed, 2025-10-29 at 18:25 +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 05:50:58PM +0200, Marius Cristea wrote:
> > > This is the devicetree schema for Microchip EMC1812/13/14/15/33
> > > Multichannel Low-Voltage Remote Diode Sensor Family.
> > >=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---
> > > =A0.../bindings/hwmon/microchip,emc1812.yaml=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 176
> > > +++++++++++++++++++++
> > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +
> > > =A02 files changed, 182 insertions(+)
> > >=20
> >=20
>=20
> ...
> > You should be able to just move this into interrupts:
> > =A0 interrupts:
> > =A0=A0=A0 items:
> > =A0=A0=A0=A0=A0 - description:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 alert-therm2 asserts when a diode temperatu=
re exceeds the
> > ALERT
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 threshold.
> > =A0=A0=A0=A0=A0 - description:
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 therm-addr asserts low when the hardware-se=
t THERM limit
> > threshold is
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0 exceeded by one of the temperature sensors.
> >=20
> > > +=A0=A0=A0 items:
> > > +=A0=A0=A0=A0=A0 - const: alert-therm2
> > > +=A0=A0=A0=A0=A0 - const: therm-addr
> >=20
> > Also, should this and interrupts have minItems: 1? Are both actually
> > required? Can you have therm-addr without alert-therm2?
> >=20
>=20
> Right now the driver doesn't support any interrupts, but it may support
> in future. The "alert-therm2" is a maskable interrupt and the "therm-
> addr" can't be masked and is "always enabled" into the chip.
>=20
> I didn't use "minItems: 1" because I wanted to leave to the user the
> decision if he needs any interrupts into their system

Unfortunately, this doesn't work the way you expected. If you don't set
minItems: 1, then anyone who wants to use an interrupt must use both.

If someone that would connect therm-addr would always also connect
alert-therm2, then minItems: 1 is enough to add. If someone might want to
use therm-addr but not use alter-therm2, then this needs to be changed
to permit these in any order. You can do that by adding the names as an
enum, eg
items:
 - enum: [ foo, bar]
 - bar


--/AVkAT3sA6d22eia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQm7xgAKCRB4tDGHoIJi
0qzwAP9rzTZh+YSsUM1T+ZHciOGT5L48rZNWNccs8J4qtoMlvAEApRwHpACBMctm
Mk4QHnFon5IRCmT2BU8GZYlnlDRTDQ0=
=lZcD
-----END PGP SIGNATURE-----

--/AVkAT3sA6d22eia--

