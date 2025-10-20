Return-Path: <linux-kernel+bounces-860315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030EBEFD35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 889614EDCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DA2E8E03;
	Mon, 20 Oct 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ASFi69k2"
Received: from mx-relay31-hz2.antispameurope.com (mx-relay31-hz2.antispameurope.com [94.100.136.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C42DC328
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947810; cv=pass; b=Y3QUZgWU+0GK7SBvOBzbYUMZmgX8kLv7MuKg3H5AnWYz/0Kv917leF4p1rg5yRynIHh+posxiaJwrnTMr4MaSx0P4fX+6KQjQr4VsVlMdipVaPpmwqpSfEzzMba6nJdO4QdgTZfrjNM2CA+IX9L76f8qFvZHZI7s13Er51O8v5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947810; c=relaxed/simple;
	bh=2xJDUu8dXX4juX5uweFWbTSz+4Hz86ETjFpZFcK9Ei0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAP2+6HiMg1HLcV3oG//1ynmbOPbcYLPHCJ98INZPUcsoBJfmgQcWYLtkwFhkzzwpKzp1eCCAxZnMtEDaXr1F3Ao3YdIpM59/O2e79+mMJScBoYTrMCg2IHo+zakBCeSYlzaN00mqhbfgiizTynEYNMu8v1XRy2PIfkZnHpOmdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ASFi69k2; arc=pass smtp.client-ip=94.100.136.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate31-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=SJ1iu3qQhIz3Rj3mCvPCsfbK0AahgJl9A/vKcVA1tTU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760947787;
 b=eTckCKB7eWjueFBzlZfAGl2EYrYeNKypXPs35MPx36QATTJ+edr2u+iBWlTgiJ54URZAi3nf
 BnC8MyYiOtTkaOiSD0m31rEcpRSTkoLHgZ+3mYRhCacIwrqojtukX583AgKat7m/pzAT9UE9a+s
 /LFy6HnavppxMLQ2CZd8UUzGJhFnIA6SwoZpNyEXnsUZ27WFkubg7FQ/WU05I5KdZ1Wp/k3gtSU
 DY07iYPgirfTr8O8RUTau/7f6ElzSkmcNaG+0uhrfQNMisEv33kVt6tnolkg0bL/is1xPWfb+eC
 GDzS3tossOhCaRQkWmPAEiMej6PtMIAPssG4bGvlDXHBQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760947787;
 b=ejgXrle8RkLXccDFe3gfz3of0XQmIld92NOh++QvdvyEg/6clAwqCh/P6t3MQcfPYuS8Ts2t
 puh4TNPiex7m0D/C4DZzsIxGjdM2c3VuQujBqezcRWSdBXZUqgehWbyE9/3hwpyUz6CiZmYIynK
 iUSk+arAT9NPKd1Xmw/syLbx4EnyO6c3ncNuatLaNOaXXclMOwI4U/o1qQY2XXKTLaDXfaqCmNi
 1FSAjTE1vMhpm0otUa7E5P+IJXm1GdoF4/T+BcBxo7CntHqWlfGwHXVML2TPnL0u/2ZO2a9qe9w
 tpUbFaqVO88YHGfUaJ3WTJMTXCXVoQB56yMjf/JUUUr1Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay31-hz2.antispameurope.com;
 Mon, 20 Oct 2025 10:09:47 +0200
Received: from [192.168.153.128] (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id CCAA2A4118D;
	Mon, 20 Oct 2025 10:09:29 +0200 (CEST)
Message-ID: <7d3df04c482e71760ccc941469c99412b608c92b.camel@ew.tq-group.com>
Subject: Re: [PATCH] serial: imx: allow CRTSCTS with RTS/CTS GPIOs
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org,  imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Date: Mon, 20 Oct 2025 10:09:29 +0200
In-Reply-To: <cdkpp74ra2ltr7h46psutkwnzyvl4iegcicnhqqj7svm5trltm@w2egfj5nryjm>
References: <20251016113730.245341-1-matthias.schiffer@ew.tq-group.com>
	 <cdkpp74ra2ltr7h46psutkwnzyvl4iegcicnhqqj7svm5trltm@w2egfj5nryjm>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay31-hz2.antispameurope.com with 4cqp4B4MC2zGq5s
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:4274035f3daba9a9b82ce09d6a79390d
X-cloud-security:scantime:2.261
DKIM-Signature: a=rsa-sha256;
 bh=SJ1iu3qQhIz3Rj3mCvPCsfbK0AahgJl9A/vKcVA1tTU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760947786; v=1;
 b=ASFi69k2tb6n0eZkO0/lE4H3hRSkviedBahGt5kidJW//xVGodYJu9qeDstPpbmUEYIFQEgx
 rawgvaynhjUZRP6bQkar/rsTNs1lAaJo3fclShINE7PDPEkj2/gPBDMHdG/S39jD3QhYNkQzXST
 DYqa6K9Ps8BjWtO9vIctpn5i1q1AedkqajJ+gU4S2XQfqWKgZvo57yN5i29yDeqQaiGQqQ72VSc
 YjP7u3GU0nby3ixxlrwu9F9MuhFKKJVNHtPXQf/VdDoh1sQuTrqSORU+CazY/TcJmFbfRiHgME3
 YMTRqGiCk73zfXSNxrXQzXXRxht4geNDiSjYp5wd4BpWQ==

On Fri, 2025-10-17 at 17:01 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Oct 16, 2025 at 01:37:30PM +0200, Matthias Schiffer wrote:
> > The CTS GPIO is only evaluated when the CRTSCTS termios flag is enabled=
;
> > it should be possible to enable the flag when only GPIO and no hardware=
-
> > controlled RTS/CTS are available. UCR2_IRTS is kept enabled in this cas=
e,
> > so the hardware CTS is ignored.
> >=20
> > Fixes: 58362d5be352 ("serial: imx: implement handshaking using gpios wi=
th the mctrl_gpio helper")
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/tty/serial/imx.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 500dfc009d03e..4a54a689a0603 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1117,8 +1117,8 @@ static void imx_uart_set_mctrl(struct uart_port *=
port, unsigned int mctrl)
> >  			ucr2 |=3D UCR2_CTS;
> >  			/*
> >  			 * UCR2_IRTS is unset if and only if the port is
> > -			 * configured for CRTSCTS, so we use inverted UCR2_IRTS
> > -			 * to get the state to restore to.
> > +			 * configured for hardware-controlled CRTSCTS, so we use
> > +			 * inverted UCR2_IRTS to get the state to restore to.
> >  			 */
> >  			if (!(ucr2 & UCR2_IRTS))
> >  				ucr2 |=3D UCR2_CTSC;
> > @@ -1780,7 +1780,7 @@ imx_uart_set_termios(struct uart_port *port, stru=
ct ktermios *termios,
> >  	if ((termios->c_cflag & CSIZE) =3D=3D CS8)
> >  		ucr2 |=3D UCR2_WS;
> > =20
> > -	if (!sport->have_rtscts)
> > +	if (!sport->have_rtscts && !sport->have_rtsgpio)
> >  		termios->c_cflag &=3D ~CRTSCTS;
> > =20
> >  	if (port->rs485.flags & SER_RS485_ENABLED) {
>=20
> This hunk makes sense.
>=20
> > @@ -1794,7 +1794,7 @@ imx_uart_set_termios(struct uart_port *port, stru=
ct ktermios *termios,
> >  		else
> >  			imx_uart_rts_inactive(sport, &ucr2);
> > =20
> > -	} else if (termios->c_cflag & CRTSCTS) {
> > +	} else if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts) {
>=20
> I agree to add the parens here and consider this more readable than the
> alternative
>=20
> 	} else if (termios->c_cflag & CRTSCTS && sport->have_rtscts) {
>=20
> . Note there is no real win here. If the port doesn't have RTS/CTS it
> doesn't matter if it tries to control the RTS line. While you could
> argue it shouldn't set the line, it only makes an externally observable
> difference if one of the SoC's pads is muxed to its RTS function.
> I claim it's more robust in this case (i.e. no uart-has-rtscts property
> but a pinmux for the RTS line) to control the line according to the RTS
> setting. This is (at least IMO) better and more expected than driving
> this line to a constant level. So I oppose to this hunk.
>=20
> >  		/*
> >  		 * Only let receiver control RTS output if we were not requested
> >  		 * to have RTS inactive (which then should take precedence).
> > @@ -1803,7 +1803,7 @@ imx_uart_set_termios(struct uart_port *port, stru=
ct ktermios *termios,
> >  			ucr2 |=3D UCR2_CTSC;
> >  	}
> > =20
> > -	if (termios->c_cflag & CRTSCTS)
> > +	if ((termios->c_cflag & CRTSCTS) && sport->have_rtscts)
> >  		ucr2 &=3D ~UCR2_IRTS;
> >  	if (termios->c_cflag & CSTOPB)
> >  		ucr2 |=3D UCR2_STPB;
>=20
> Hmm, not sure. On one hand the same argument applies as above, but on
> the other if there are pins that are not explicitly configured but still
> in their CTS function this might affect operation in a bad way.
> Also this affects the (very usual) configuration where only RX, TX and
> RTS are used and CTS is not. In this case have_rtscts is true (right?)
> and then if there is an accidental CTS pin this is bad and not fixed by
> your change. Hmmm...

I think it makes sense to always keep UCR2_IRTS set when have_rtscts is uns=
et,
as otherwise there might be two separate CTS signals in the accidental CTS =
pin
case - the hardware + the GPIO one, both affecting the UART operation.

If we keep this change (the 3rd), the 2nd should also be included for
consistency in the code path where I just changed a comment - there, UCR2_C=
TSC
is set only when UCR2_IRTS is unset. The 2nd and 3rd change together keep
imx_uart_set_mctrl and imx_uart_set_termios aligned.

>=20
> So in sum the 2nd and 3rd code change is controversial. If the first one
> already fixes the problem you're facing, I suggest to go for only that.
> If you still think that the 3rd (and maybe even the 2nd) change is a
> good idea, I'd request to do that in a separate commit as this is a
> separate problem. Also the commit log only describes the first change,
> doesn't it?

The commit message describes the first and third change; the second is incl=
uded
to keep the setup consistent. I don't think these changes can be separated =
well
- the second and third change only affect a case that couldn't occur withou=
t the
first (as (termios->c_cflag & CRTSCTS) && !sport->have_rtscts would never h=
ave
been true). My suggestion would be that I extend the commit message to expl=
ain
each change in detail.

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

