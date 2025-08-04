Return-Path: <linux-kernel+bounces-755588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBCB1A8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027ED17FEC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D448286880;
	Mon,  4 Aug 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="eYpcfetL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDC2628C;
	Mon,  4 Aug 2025 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330476; cv=pass; b=fTvb8k6dHl0zEZp6Hmgkulzonx+SO8c+g6MfzgtWN/sAjHzaCy+hHqcwXkOxZi/w4EevuNhK8aJ9eP09iIc6y/vY2e1AV7rmHDtyBCbrphzy9NqKDNSiekiZvEKjkr32E18VHoC8Ar2jGW1/XmmvCHoAwQsuhX/CHDRTFiRYOUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330476; c=relaxed/simple;
	bh=2VlqSM7mhiriLDqKh0FfR65d1dLTPvUxN6bQkuhT13A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4enkR0dF4My6TLLnT+wRA21/STPHYW72yrFESwnlV5WXVGcTJd4Efcb9whDYhlDdOjXJ31VxxOCPX5Ahzqp0vaxYauWfF1Rz521Gv12LzYMtJKur3LSMBH4k7RDHAq6999iZc1/JMOYJOZZ2QAfCiXyPk/hSsPbheM0QwrDbWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=eYpcfetL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754330464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Dz/bE12TQTmgzuiobPP9Kes22ftWWQGSh6bNkFWego4z+oh/Zz+/fPRxHA29ERzASfxOoaxJDvzTL/p3odwf6RWYaVsZNbYyjjCkVaP09UoHsk6S6tP8eLVhzmz4ygtZZxZSpmj9KylURIfHnp8OzsVDU/g2XPfu1P2qRz5KTPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754330464; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DLKxRUcXqQoFr2Zx8ObMHQulUpMn9UHaj5EPAbI92RQ=; 
	b=UcCnNKaMp2vvQUlr2IegypOR78gKrQX4AMg7LWvfiw2nwPMgO1DvXjOCH5xH666tHRGgV939l2T9dWn1Sy3mFTOzGD7ajJgJnSIiO6bFHV9YbpK39uhjuqjFUh3Qvyx8rPNufI6VuQU/n9rCf35n7QKEWdVVh5mRxvj86aO66Jk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754330464;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=DLKxRUcXqQoFr2Zx8ObMHQulUpMn9UHaj5EPAbI92RQ=;
	b=eYpcfetLujjHR6HYkPltiPY4XkQSwZFjxtVjOATpc24QQhXn2ujdjVLdVojMOvv9
	6xilL6vwyzK1fmgoHG7i3eycZkJULTCfV4Ib6o8QaGpNGeASToFXdYLUmgRMtb4yzfj
	vl2bZFhpJPddwkUKKtzkBkBSDzcFn1d7WSshcp/M=
Received: by mx.zohomail.com with SMTPS id 1754330462856505.21849886120685;
	Mon, 4 Aug 2025 11:01:02 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id E780F180645; Mon, 04 Aug 2025 20:00:56 +0200 (CEST)
Date: Mon, 4 Aug 2025 20:00:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Yongbo Zhang <giraffesnn123@gmail.com>, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] usb: typec: fusb302: fix scheduling while atomic when
 using virtio-gpio
Message-ID: <m7n22g5fsfvpjz4s5d6zfcfddrzrj3ixgaqehrjkg7mcbufvjc@s4omshvxtkaf>
References: <20250526043433.673097-1-giraffesnn123@gmail.com>
 <aDbkBZi1L442jd7i@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcwqx5br2udmxx2b"
Content-Disposition: inline
In-Reply-To: <aDbkBZi1L442jd7i@kuha.fi.intel.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/254.317.26
X-ZohoMailClient: External


--tcwqx5br2udmxx2b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] usb: typec: fusb302: fix scheduling while atomic when
 using virtio-gpio
MIME-Version: 1.0

+CC Hans de Goede

Hi,

On Wed, May 28, 2025 at 01:23:01PM +0300, Heikki Krogerus wrote:
> On Mon, May 26, 2025 at 12:34:33PM +0800, Yongbo Zhang wrote:
> > When the gpio irqchip connected to a slow bus(e.g., i2c bus or virtio
> > bus), calling disable_irq_nosync() in top-half ISR handler will trigger
> > the following kernel BUG:
> >=20
> > BUG: scheduling while atomic: RenderEngine/253/0x00010002
> > ...
> > Call trace:
> >  dump_backtrace+0x0/0x1c8
> >  show_stack+0x1c/0x2c
> >  dump_stack_lvl+0xdc/0x12c
> >  dump_stack+0x1c/0x64
> >  __schedule_bug+0x64/0x80
> >  schedule_debug+0x98/0x118
> >  __schedule+0x68/0x704
> >  schedule+0xa0/0xe8
> >  schedule_timeout+0x38/0x124
> >  wait_for_common+0xa4/0x134
> >  wait_for_completion+0x1c/0x2c
> >  _virtio_gpio_req+0xf8/0x198
> >  virtio_gpio_irq_bus_sync_unlock+0x94/0xf0
> >  __irq_put_desc_unlock+0x50/0x54
> >  disable_irq_nosync+0x64/0x94
> >  fusb302_irq_intn+0x24/0x84
> >  __handle_irq_event_percpu+0x84/0x278
> >  handle_irq_event+0x64/0x14c
> >  handle_level_irq+0x134/0x1d4
> >  generic_handle_domain_irq+0x40/0x68
> >  virtio_gpio_event_vq+0xb0/0x130
> >  vring_interrupt+0x7c/0x90
> >  vm_interrupt+0x88/0xd8
> >  __handle_irq_event_percpu+0x84/0x278
> >  handle_irq_event+0x64/0x14c
> >  handle_fasteoi_irq+0x110/0x210
> >  __handle_domain_irq+0x80/0xd0
> >  gic_handle_irq+0x78/0x154
> >  el0_irq_naked+0x60/0x6c
> >=20
> > This patch replaces request_irq() with devm_request_threaded_irq() to
> > avoid the use of disable_irq_nosync().
> >=20
> > Signed-off-by: Yongbo Zhang <giraffesnn123@gmail.com>
>=20
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>=20
> > ---

I'm currently investigating a potential "regression" (quotes,
because USB-C support is not yet enabled in the upstream board
devicetree) with the Radxa ROCK 5B USB-C support after rebasing
to latest master branch. I'm not yet sure, if this patch is at
fault or totally unrelated, but please be aware that it undoes
previous work from Hans de Goede to NOT use threaded IRQs:

207338ec5a27 ("usb: typec: fusb302: Improve suspend/resume handling")

At the same time the fix from Yongbo Zhang misses cleaning up the
now useless fusb302_irq_work() split, which had been introduced by
Hans patch to have the hard IRQ as short as possible. With the
interrupt handler being a thread itself, the code can just be called
directly.

Greetings,

-- Sebastian

> >  drivers/usb/typec/tcpm/fusb302.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/=
fusb302.c
> > index f15c63d3a8f4..f2801279c4b5 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -1477,9 +1477,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void=
 *dev_id)
> >  	struct fusb302_chip *chip =3D dev_id;
> >  	unsigned long flags;
> >=20
> > -	/* Disable our level triggered IRQ until our irq_work has cleared it =
*/
> > -	disable_irq_nosync(chip->gpio_int_n_irq);
> > -
> >  	spin_lock_irqsave(&chip->irq_lock, flags);
> >  	if (chip->irq_suspended)
> >  		chip->irq_while_suspended =3D true;
> > @@ -1622,7 +1619,6 @@ static void fusb302_irq_work(struct work_struct *=
work)
> >  	}
> >  done:
> >  	mutex_unlock(&chip->lock);
> > -	enable_irq(chip->gpio_int_n_irq);
> >  }
> >=20
> >  static int init_gpio(struct fusb302_chip *chip)
> > @@ -1747,9 +1743,10 @@ static int fusb302_probe(struct i2c_client *clie=
nt)
> >  		goto destroy_workqueue;
> >  	}
> >=20
> > -	ret =3D request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
> > -			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> > -			  "fsc_interrupt_int_n", chip);
> > +	ret =3D devm_request_threaded_irq(dev, chip->gpio_int_n_irq,
> > +					NULL, fusb302_irq_intn,
> > +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> > +					"fsc_interrupt_int_n", chip);
> >  	if (ret < 0) {
> >  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=3D%d", ret);
> >  		goto tcpm_unregister_port;
> > @@ -1774,7 +1771,6 @@ static void fusb302_remove(struct i2c_client *cli=
ent)
> >  	struct fusb302_chip *chip =3D i2c_get_clientdata(client);
> >=20
> >  	disable_irq_wake(chip->gpio_int_n_irq);
> > -	free_irq(chip->gpio_int_n_irq, chip);
> >  	cancel_work_sync(&chip->irq_work);
> >  	cancel_delayed_work_sync(&chip->bc_lvl_handler);
> >  	tcpm_unregister_port(chip->tcpm_port);
> > --
> > 2.49.0
>=20
> --=20
> heikki
>=20

--tcwqx5br2udmxx2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmiQ9VQACgkQ2O7X88g7
+pphqRAAj7l4jBr6GYVa/hlGtdWb5fOjv9fZUeijnhzV0+HQh9jO/GRO/aHbQhsC
4tyvcTrQrRYytm0fzkVViDbTiI6f7glCZXuZlnYKW0t4R1h2j9bmaUz0M+vEDHej
pP+G9k8+8hPLs9JKdSlz6edSbFcxdFUfN7dK1n8RWF0GLI/xnHER9cT5nuMJIM4Z
cbW1PJmPi5JF8hVkXD0xNowVpziYfk2CfKDlxEZ0+hBw/CCSO7kJV7jMZKPPOerO
3u9R5RlbEuOlUpqCUZxLoVoMusdYM8lu2wmS80jK7EMCrEsKZchvE4Eny1HKwoRL
TiZlCW2ffSNlslMSrZfu7AUI3rVa8+FTk5kWybtanMeO10OKffxbIrPIZbseUQ2y
zpczzCDB9unpuP3s++O8NVL+BBDYk0UObW9t6JIHEkNUri4CYVpcoq13c/8J4G0f
DEtJa51JimJRWG/L1aj3loTYZk6HZ/DdsaQ4ABFMA0eoZ8RVbvTgPYDsiQsYau41
cVCfgq/x212LXf0c+wJ5JEha/tOT+mez9sfOBhS3ATDWiNb8UURUXeFKGf4Hl/wV
3GM/UYEmWnmjnunyViztDtU6PWfthNDEaDXnUC1/l6Igpjg52xu2yyDLJffeUnJt
Uo+dQeESyxZQ5P8LK5qbx2m1EZF9UV8E3Pf6uPvyo2p1IXaVBCU=
=3lk7
-----END PGP SIGNATURE-----

--tcwqx5br2udmxx2b--

