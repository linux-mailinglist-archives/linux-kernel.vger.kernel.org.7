Return-Path: <linux-kernel+bounces-862534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A1BF58CB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A72018C78D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671FD2E54DB;
	Tue, 21 Oct 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="sPGQ/C4T"
Received: from mx-relay03-hz1.antispameurope.com (mx-relay03-hz1.antispameurope.com [94.100.132.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FF2E718F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.203
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039548; cv=pass; b=QrMqCeaNmhMuXUziPKbfXbDIBHVodAeXj3dXq6NYcZmoxmVfK/0sYB8OWukDSRApRo7XETYT8V+A/0woLqUMqRETN+5htK22ULfHD+judkok9H4r8kf4Yth8EieEC97WtJrFYzFMO0A6mCHjTq9yJkfDOHGukSyWSJi6VKi3NMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039548; c=relaxed/simple;
	bh=eKhIEr2wdHZOdT7ow5a3AzpUQkJ0Ei2/IGrS1CI/pVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9P4LMQW/pWBPd22wm2TwsPkEI+uqD3JstK+rI253RAoLMm528KjYP69Teqrmnq3tRn7JVJjhlOmip4tsqgaioTHRhlJJPXhnSTwbTSfBw/QEQ+ZZOdhtuprSS9sTtZThcwrPT+7WdSxtAVJIl4OYTNuxyoCyZjZ6On+ob3ZBus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=sPGQ/C4T; arc=pass smtp.client-ip=94.100.132.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate03-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=i9zmwlits19MWVeZiMnlveUvVwY/OpDAaLlQOnMopBQ=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761039505;
 b=H5UMn8Y0llI5iNasot/OMpYBcqgsTRxWpfH/aoiRRnX+UkhZwWrDo1Q/SXEtvMdTt8EnWITa
 1HZTV2PspUcx1g/EOQpN3o+m2biZFYxPelxxYVxceznKT7lGhxoU0WFhAJ0lWnZC0iYKKXa9q0i
 Bp/F03QeESdxf93Y8b+gwjboDs5bwrvu4eaQ6BtGYJ28kze+bTfwl/SKPeZOPmVf5W9a+jG7UkX
 v7ny8KLFOTTya2geFAsm8k4VQFX+dByZypZQlCZYHw7v3wKnf4zTblm+ysmg7lvo3EFxSr3mrJ7
 vkR+lz9xKKsnq52UCscg6gdCx9ps8lLufEsn92NnFs0Yg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761039505;
 b=mqp2evxGUD+jncxs7DxaqT2UznIWGKy7TJgPZWDhblwVgdMDSzjr19JsV2ZeBwKUE/w8boqA
 jLSRYr2bSZHhJNH9tgrHJD4a/7Tz3LY+A8drMd3x25ujBaEMNcqtDUXwH3X8rvf1tbhATVkQJV/
 ZKPxTDFH8L5WI7/De5rL6z4dWBOZprYC0lun/tI7I6/ULZIoeqUPK6xAVV3RVxWoU11aA/WwxEm
 7NVd/75OSZGkq6HA07f2kZTFr4DuZkHEvJZ+QNOTyr7bN0wHM2+0G4NiztfeTF81leP2vccX2Yb
 r/w/4G1yu9RZCEr2E3USKCnbWN+raBjrVk9dvnNvi6s6Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay03-hz1.antispameurope.com;
 Tue, 21 Oct 2025 11:38:25 +0200
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 11E9CA41274;
	Tue, 21 Oct 2025 11:37:38 +0200 (CEST)
Message-ID: <1963351b2e50c537418293e6ab9293576a239c98.camel@ew.tq-group.com>
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,  imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Tue, 21 Oct 2025 11:37:37 +0200
In-Reply-To: <lgse44as4k6fpzarztfnfl7wbxq2bfg5k7m7l6xlsyx23pmem4@khal3tytgwjn>
References: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
	 <cdkpp74ra2ltr7h46psutkwnzyvl4iegcicnhqqj7svm5trltm@w2egfj5nryjm>
	 <7d3df04c482e71760ccc941469c99412b608c92b.camel@ew.tq-group.com>
	 <lgse44as4k6fpzarztfnfl7wbxq2bfg5k7m7l6xlsyx23pmem4@khal3tytgwjn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay03-hz1.antispameurope.com with 4crRzQ6tXCzdsVM
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:b6a1ef41415f75c94556ef2ddcc8cb65
X-cloud-security:scantime:8.361
DKIM-Signature: a=rsa-sha256;
 bh=i9zmwlits19MWVeZiMnlveUvVwY/OpDAaLlQOnMopBQ=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761039505; v=1;
 b=sPGQ/C4Tcs87n48rottrdQsiSHYGbNbo9q/nTl62LsSvVBSrOwvLzBcVoAewhtt/TPHH6wRR
 mKcQOyFR7oYD3zd84UIy/Kb8tHLtsgtj+lNVRD0WM3AyPfaA8rvSoJmmLREhZxLgpnSzJ+hwixa
 KGYA6DOp2mH87791Uy7XxRCS+8dsogfJ6aMR8fc0jh3yf18zRqMIcxac4VsT3bZn673V0CF0gJ8
 dSRD0Bj3l4Dtck7jigSp16P8IaZD7IuxzK6E6IBgMAFa2phnn6mlRhDHGQxpY8KOvT5W7b/D2IR
 iGdeKBZX3B2lj7Cu67FkMof3aVfa1ynNHazzuVgSi0rxA==

On Tue, 2025-10-21 at 10:59 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Matthias,
>=20
> On Mon, Oct 20, 2025 at 10:09:29AM +0200, Matthias Schiffer wrote:
> > On Fri, 2025-10-17 at 17:01 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 16, 2025 at 01:37:30PM +0200, Matthias Schiffer wrote:
> > > > The CTS GPIO is only evaluated when the CRTSCTS termios flag is ena=
bled;
> > > > it should be possible to enable the flag when only GPIO and no hard=
ware-
> > > > controlled RTS/CTS are available. UCR2_IRTS is kept enabled in this=
 case,
> > > > so the hardware CTS is ignored.
> > > >=20
> > > > Fixes: 58362d5be352 ("serial: imx: implement handshaking using gpio=
s with the mctrl_gpio helper")
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com=
>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index 500dfc009d03e..4a54a689a0603 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -1117,8 +1117,8 @@ static void imx_uart_set_mctrl(struct uart_po=
rt *port, unsigned int mctrl)
> > > >  			ucr2 |=3D UCR2_CTS;
> > > >  			/*
> > > >  			 * UCR2_IRTS is unset if and only if the port is
> > > > -			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> > > > -			 * to get the state to restore to.
> > > > +			 * configured for hardware-controlled CRTSCTS, so we use
> > > > +			 * inverted UCR2_IRTS to get the state to restore to.
> > > >  			 */
> > > >  			if (!(ucr2 & UCR2_IRTS))
> > > >  				ucr2 |=3D UCR2_CTSC;
> > > > @@ -1780,7 +1780,7 @@ imx_uart_set_termios(struct uart_port *port, =
struct ktermios *termios,
> > > >  	if ((termios->c_cflag & CSIZE) =3D=3D CS8)
> > > >  		ucr2 |=3D UCR2_WS;
> > > > =20
> > > > -	if (!sport->have_rtscts)
> > > > +	if (!sport->have_rtscts && !sport->have_rtsgpio)
> > > >  		termios->c_cflag &=3D ~CRTSCTS;
> > > > =20
> > > >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> > >=20
> > > This hunk makes sense.
> > >=20
> > > > @@ -1794,7 +1794,7 @@ imx_uart_set_termios(struct uart_port *port, =
struct ktermios *termios,
> > > >  		else
> > > >  			imx_uart_rts_inactive(sport, &ucr2);
> > > > =20
> > > > -	} else if (termios->c_cflag & CRTSCTS) {
> > > > +	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {
> > >=20
> > > I agree to add the parens here and consider this more readable than t=
he
> > > alternative
> > >=20
> > > 	} else if (termios->c_cflag & CRTSCTS && sport->have_rtscts) {
> > >=20
> > > . Note there is no real win here. If the port doesn't have RTS/CTS it
> > > doesn't matter if it tries to control the RTS line. While you could
> > > argue it shouldn't set the line, it only makes an externally observab=
le
> > > difference if one of the SoC's pads is muxed to its RTS function.
> > > I claim it's more robust in this case (i.e. no uart-has-rtscts proper=
ty
> > > but a pinmux for the RTS line) to control the line according to the R=
TS
> > > setting. This is (at least IMO) better and more expected than driving
> > > this line to a constant level. So I oppose to this hunk.
> > >=20
> > > >  		/*
> > > >  		 * Only let receiver control RTS output if we were not requested
> > > >  		 * to have RTS inactive (which then should take precedence).
> > > > @@ -1803,7 +1803,7 @@ imx_uart_set_termios(struct uart_port *port, =
struct ktermios *termios,
> > > >  			ucr2 |=3D UCR2_CTSC;
> > > >  	}
> > > > =20
> > > > -	if (termios->c_cflag & CRTSCTS)
> > > > +	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)
> > > >  		ucr2 &=3D ~UCR2_IRTS;
> > > >  	if (termios->c_cflag & CSTOPB)
> > > >  		ucr2 |=3D UCR2_STPB;
> > >=20
> > > Hmm, not sure. On one hand the same argument applies as above, but on
> > > the other if there are pins that are not explicitly configured but st=
ill
> > > in their CTS function this might affect operation in a bad way.
> > > Also this affects the (very usual) configuration where only RX, TX an=
d
> > > RTS are used and CTS is not. In this case have_rtscts is true (right?=
)
> > > and then if there is an accidental CTS pin this is bad and not fixed =
by
> > > your change. Hmmm...
> >=20
> > I think it makes sense to always keep UCR2_IRTS set when have_rtscts is=
 unset,
> > as otherwise there might be two separate CTS signals in the accidental =
CTS pin
> > case - the hardware + the GPIO one, both affecting the UART operation.
>=20
> With that change you break setups that have an RTS-GPIO but rely on the
> HW pin for the CTS function. Not sure how common that is, but in this
> case you only want the first code change. You could argue that in that
> case have_rtscts should be set, but that's somewhat fuzzy.

Such a setup should set have_rtscts IMO. In any case, my patch would not br=
eak
existing setups, as the CRTSCTS flag simply cannot be set for !have_rtscts
without these changes.

>=20
> > If we keep this change (the 3rd), the 2nd should also be included for
> > consistency in the code path where I just changed a comment - there, UC=
R2_CTSC
> > is set only when UCR2_IRTS is unset. The 2nd and 3rd change together ke=
ep
> > imx_uart_set_mctrl and imx_uart_set_termios aligned.
> >=20
> > >=20
> > > So in sum the 2nd and 3rd code change is controversial. If the first =
one
> > > already fixes the problem you're facing, I suggest to go for only tha=
t.
> > > If you still think that the 3rd (and maybe even the 2nd) change is a
> > > good idea, I'd request to do that in a separate commit as this is a
> > > separate problem. Also the commit log only describes the first change=
,
> > > doesn't it?
> >=20
> > The commit message describes the first and third change; the second is =
included
> > to keep the setup consistent. I don't think these changes can be separa=
ted well
> > - the second and third change only affect a case that couldn't occur wi=
thout the
> > first (as (termios->c_cflag & CRTSCTS) && !sport->have_rtscts would nev=
er have
> > been true). My suggestion would be that I extend the commit message to =
explain
> > each change in detail.
>=20
> I'd still request to split the patch in at least two patches. The first
> code change is to allow rts-gpios to work at all. The two later patches
> change details about how HW pins are controlled in the presence of
> rts-gpios

Okay, will do.

Best,
Matthias


>=20
> Best regards
> Uwe

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

