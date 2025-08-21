Return-Path: <linux-kernel+bounces-779497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201FB2F4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D721E564B70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9382EE26B;
	Thu, 21 Aug 2025 10:05:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DB2D8DD1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770721; cv=none; b=UxSQBAyTEABfFzhXJ6pYqio57kyZ/Az5ybEAXYKiEtagCoO123KHp+KagIUgRmJGYB+VLXgjbMbJek2tBfbaNXfeqsZsjZaULeZ11B0IyOH57hha0FXGAtO99dNEdkGcXuGxaz0jDq2JJ//8o2R5OI/1U5kwmfJQOEIU6Zf1L6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770721; c=relaxed/simple;
	bh=Kuiy6M+c34XOWZ6h6vh9kbd23reNtEjtUaOCR7T8gLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7jjOvgXUonLzx700Hx+CCSmwkkusppvPIefWuWo4l2XcXVn3mZpiUYilSmapYEQZ6uyzTwcuIryHG5zS3u7ITn0nbw6zR11NVu0LXpHospnPdqfwT6zj7J/OHJObKrPLfUqWhqnIGQvSGUoRx/eLhI+sODAJx9fymNpKqxENCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1up2AP-0000TZ-AE; Thu, 21 Aug 2025 12:05:09 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up2AO-001OXg-36;
	Thu, 21 Aug 2025 12:05:08 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1up2AO-007znM-2e;
	Thu, 21 Aug 2025 12:05:08 +0200
Date: Thu, 21 Aug 2025 12:05:08 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v18 0/7] firmware: imx: driver for NXP secure-enclave
Message-ID: <20250821100508.sh35kuosczdhadpa@pengutronix.de>
References: <20250619-imx-se-if-v18-0-c98391ba446d@nxp.com>
 <41909d9a-0ee8-460b-8c0a-1ceee0cf8723@kontron.de>
 <20250821095032.5o2trkwf6mdmyx4w@pengutronix.de>
 <PAXPR04MB845980CB4C7EDB091495DC058832A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845980CB4C7EDB091495DC058832A@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 25-08-21, Peng Fan wrote:
> Hi Marco,
> 
> > Subject: Re: [PATCH v18 0/7] firmware: imx: driver for NXP secure-
> > enclave
> > 
> > > Shawn mentioned for the v17, he wanted to test this [1]. Marco had
> > > some concerns on the general approach [2]. How can we move on?
> > >
> > > FWIW I have tested the v15 of this series with the ELE OTP driver [3]
> > > on
> > > i.MX93 and we use this currently in our downstream kernel.
> > 
> > From my pov, this series causes more confusions till the ELE FW fix is
> > available because you need to be really careful during the integration
> > in case of a verified-boot setup which are the most common setups
> > these days.
> > 
> > Not sure why NXP doesn't just add the OP-TEE support for the required
> > features e.g. eFuses, watchdog, HWRNG. The whole Linux part is mostly
> > in place.
> 
> You mean let OP-TEE handle eFuses, watchdog, HWRNG, then linux
> relies on OP-TEE to use the features?

Exactly, due to the FW issue only one MU can be used. OP-TEE could use
the secure MU and Linux uses the features via OP-TEE because these
features are not very timing critical and some features are _only_
available through OP-TEE, e.g. writing eFuses after the device was
locked-down.

Regards,
  Marco


> 
> Thanks,
> Peng.
> 
> > 
> > Regards,
> >   Marco
> > 
> > >
> > > [1]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > patc
> > > hwork.kernel.org%2Fproject%2Flinux-
> > mm%2Fpatch%2F20250424111632.103637-
> > > 1-
> > lorenzo.stoakes%40oracle.com%2F%2326356782&data=05%7C02%7C
> > peng.fan%4
> > >
> > 0nxp.com%7C1ac2ac137e8a41d871c508dde098450d%7C686ea1d3bc
> > 2b4c6fa92cd99c
> > >
> > 5c301635%7C0%7C0%7C638913666802700666%7CUnknown%7CTW
> > FpbGZsb3d8eyJFbXB0
> > >
> > eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> > WFpbCIsIl
> > >
> > dUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=%2FSC9WU4CoKtPrVuhjL
> > uLC7trQhAcbEkaCu
> > > xohN%2FIuM0%3D&reserved=0
> > > [2]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > patc
> > > hwork.kernel.org%2Fproject%2Flinux-arm-
> > kernel%2Fpatch%2F20250619-imx-s
> > > e-if-v18-3-
> > c98391ba446d%40nxp.com%2F%2326443037&data=05%7C02%7Cpe
> > ng.fa
> > >
> > n%40nxp.com%7C1ac2ac137e8a41d871c508dde098450d%7C686ea1
> > d3bc2b4c6fa92cd
> > >
> > 99c5c301635%7C0%7C0%7C638913666802714776%7CUnknown%7C
> > TWFpbGZsb3d8eyJFb
> > >
> > XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> > joiTWFpbCI
> > >
> > sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=B%2BUZWN6OjkEu27C
> > By1%2FFKte9Uw9NQ
> > > DA%2Be9EdPZhtAUk%3D&reserved=0
> > > [3]
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > patc
> > > hwork.kernel.org%2Fproject%2Flinux-arm-
> > kernel%2Fpatch%2F20250416142715
> > > .1042363-2-
> > frieder%40fris.de%2F&data=05%7C02%7Cpeng.fan%40nxp.com%7C1a
> > >
> > c2ac137e8a41d871c508dde098450d%7C686ea1d3bc2b4c6fa92cd99c
> > 5c301635%7C0%
> > >
> > 7C0%7C638913666802731697%7CUnknown%7CTWFpbGZsb3d8eyJFb
> > XB0eU1hcGkiOnRyd
> > >
> > WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> > fQ%3D%3
> > >
> > D%7C0%7C%7C%7C&sdata=RilSInf5N%2FfrF04qOubqT2yNjC%2FwAhy
> > Oe6GIEfwtIGs%3
> > > D&reserved=0
> > >
> 
> 

