Return-Path: <linux-kernel+bounces-900074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4CCC598D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B684353BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0530FC15;
	Thu, 13 Nov 2025 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="KAOtBBAp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okJS8zZI"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881212DDA1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059394; cv=none; b=Vr0QcmJQZS9xq/mrlRTz55S/3ICaV01QL9MZX9z6Q93uvht3G1UEbEqQn2JVnNYzSW68qpCb+0/vQRU8fgtEEUdPQczww2HKWjGP8YUKZtyysEno6lHUHqhi28uRgGIxSJRwiyVKbkQeXbiJAdOpfo9PtJKe0S4Cln41eN9Qgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059394; c=relaxed/simple;
	bh=ztPwJ+7cMcLpg0x4rIzQAo7X2WjabXKpfzo7dLKsKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm8M6CqDYDxDpzf8QQn/W4DdFrB3PeNllZpF7KoVcoLZ0OEvDBPAxIUbgNYEE/lMf3N4FdbwlrE0AT5N0orrO/HHWP60eZJkSjNRKBkVpCC5biC9Euc1nDDpws7MaFVfrCrhNFN7zWiUnE+ucSF7OyjpmYVzeBvawO4/MMAt3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=KAOtBBAp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okJS8zZI; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C9A71D00313;
	Thu, 13 Nov 2025 13:43:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Nov 2025 13:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763059391;
	 x=1763145791; bh=lXxLZsOxpREcR2HuC2Fg0UpqH2BHTtEmo6JxubieZyA=; b=
	KAOtBBApaFoXo1ev2sX81dEjpOwSx88xDiKvL17DK5xSVzR9tOrpSTH/LDKso1dE
	HygUFq4ywRQEYw8SwDZKXR1g+4GoO4l7GfvuiP5vYyjFdwcet9nB4JD9UwQzJNHd
	3VzVP8huy6E2TVOaU0B1LWLY2owM34eGxa3ZIHjhPb/HUuQBWKKxPLXLsug/CuGw
	lg1WzBfeOyY7EhojcnvRS/yvdr9FCxUzB+nqL2u7X5BJrgQEiYcCL8BfkKBKuDD2
	iM2SfPWznqdRoz5OxuhonR3UWo2YYO23ZMBLmXjw5uAp6kkkDi9LRswZc0JDzDFJ
	GFNMwa19WFedVK3SXXV/FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763059391; x=1763145791; bh=lXxLZsOxpREcR2HuC2Fg0UpqH2BHTtEmo6J
	xubieZyA=; b=okJS8zZIk6KNPbQrqKWzVNt0s75dEtfV5QtmgKKaVKhFLkD6+/t
	1lrjxKCrCDB4ZDDprpNf+jR4QZx1w9r6LgoYezwARBetfnNaPWun4csiKshjXn6/
	xhOvLtRkDI3tEozbJ3E5PZss6q5UQ1/+OiJ0+mbDp1eqhQvj3dycQEKNAdQUrF/i
	naOhOszABdDE3OsqYWUkeokID4Oy0TcD5IZgF7aCoAKc89GGBt87qXEYqT+4O1lO
	nhmCtJ462psyqWGR2hmFrw9TK2S8Kb1DGsDXlJBZiLyzmYj8i1B8YyKZFxJnD1Zf
	1/rg9vQ6zmPJZdbzujYmFpDlnH1/AeCECkQ==
X-ME-Sender: <xms:viYWaflcrBwHFfi9H4DAVYlkWZTPuEf4PNzZShGPUAO7_-n_f5HvIg>
    <xme:viYWae1JL5W2mtFO8mr-uBCpLv-9GhtfaZT13kaNOhfxFFI800ON-ykEcuCfbEZzD
    P9LPmJmoapQJMx4jWIQ57kXDlKuZd9oQK-uau9SyZ58fPcMecE>
X-ME-Received: <xmr:viYWaX24zDD4Emr8zQXTEC4UQFRzLvK9og_DIq56jQcBNmere7U7BZ5XtEhbSNOdG_3JTGuvNXHmmRR10JS4m0BOsThlztgROMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepieeluddv
    keejueekhfffteegfeeiffefjeejvdeijedvgfejheetuddvkeffudeinecuffhomhgrih
    hnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrg
    gsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjghhrohhsshesshhushgvrdgtohhmpdhrtghpthhtohepshhsthgrsggvlhhl
    ihhniheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhlvghkshgrnhgurhgpthihsh
    hhtghhvghnkhhosegvphgrmhdrtghomhdprhgtphhtthhopehjihgrnhhgrdhpvghnghel
    seiithgvrdgtohhmrdgtnhdprhgtphhtthhopegthhgvnhhqihhujhhiieeiieesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjrghsohhnrdgrnhgurhihuhhksegrmhgurdgtohhm
    pdhrtghpthhtohepgigvnhdquggvvhgvlheslhhishhtshdrgigvnhhprhhojhgvtghtrd
    horhhg
X-ME-Proxy: <xmx:viYWaYq72mAbLE6ZjHOIexKo5CBfw5XhM-X8ivyjDyycQKzAVXdNww>
    <xmx:viYWabiq9dfFJCgJNel92GabUZMqPSE0uMT3D2yUSVQR3P-x7Mvvqg>
    <xmx:viYWac-1J6roKTKpn4zsuYd58CvB4D6-PQIoNUj571oenr_wTchgMA>
    <xmx:viYWafWSlL5Tb8_48cWM70HjW6QP0nZRK0CpZAjSSnK_slG9toGbWA>
    <xmx:vyYWac8fLx6NH354UureVdHrvxp2BRJzEP9yIXe4imP6SXmX4CqXqFro>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 13:43:09 -0500 (EST)
Date: Thu, 13 Nov 2025 19:43:07 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen/xenbus: better handle backend crash
Message-ID: <aRYmuwW5rShXqMj1@mail-itl>
References: <20251102032105.772670-1-marmarek@invisiblethingslab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oRemhD1n1wZhbvYq"
Content-Disposition: inline
In-Reply-To: <20251102032105.772670-1-marmarek@invisiblethingslab.com>


--oRemhD1n1wZhbvYq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Nov 2025 19:43:07 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Peng Jiang <jiang.peng9@zte.com.cn>,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Jason Andryuk <jason.andryuk@amd.com>,
	"moderated list:XEN HYPERVISOR INTERFACE" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen/xenbus: better handle backend crash

Ping?

On Sun, Nov 02, 2025 at 04:20:12AM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> When the backend domain crashes, coordinated device cleanup is not
> possible (as it involves waiting for the backend state change). In that
> case, toolstack forcefully removes frontend xenstore entries.
> xenbus_dev_changed() handles this case, and triggers device cleanup.
> It's possible that toolstack manages to connect new device in that
> place, before xenbus_dev_changed() notices the old one is missing. If
> that happens, new one won't be probed and will forever remain in
> XenbusStateInitialising.
>=20
> Fix this by checking backend-id and if it changes, consider it
> unplug+plug operation. It's important that cleanup on such unplug
> doesn't modify xenstore entries (especially the "state" key) as it
> belong to the new device to be probed - changing it would derail
> establishing connection to the new backend (most likely, closing the
> device before it was even connected). Handle this case by setting new
> xenbus_device->vanished flag to true, and check it before changing state
> entry.
>=20
> And even if xenbus_dev_changed() correctly detects the device was
> forcefully removed, the cleanup handling is still racy. Since this whole
> handling doesn't happend in a single xenstore transaction, it's possible
> that toolstack might put a new device there already. Avoid re-creating
> the state key (which in the case of loosing the race would actually
> close newly attached device).
>=20
> The problem does not apply to frontend domain crash, as this case
> involves coordinated cleanup.
>=20
> Problem originally reported at
> https://lore.kernel.org/xen-devel/aOZvivyZ9YhVWDLN@mail-itl/T/#t,
> including reproduction steps.
>=20
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
> I considered re-using one of existing fields instead of a new
> xenbus_device->vanished, but I wasn't sure if that would work better.
> Setting xenbus_device->nodename to NULL would prevent few other places
> using it (including some log messages). Setting xenbus_device->otherend
> might have less unintentional impact, but logically it doesn't feel
> correct.
>=20
> With this patch applied, I cannot reproduce the issue anymore - neither
> with the simplified reproducer script, nor with the full test suite.
> ---
>  drivers/xen/xenbus/xenbus_client.c |  2 ++
>  drivers/xen/xenbus/xenbus_probe.c  | 25 +++++++++++++++++++++++++
>  include/xen/xenbus.h               |  1 +
>  3 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenb=
us_client.c
> index e73ec225d4a61..ce2f49d9aa4ad 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -275,6 +275,8 @@ __xenbus_switch_state(struct xenbus_device *dev,
>   */
>  int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state sta=
te)
>  {
> +	if (dev->vanished)
> +		return 0;
>  	return __xenbus_switch_state(dev, state, 0);
>  }
> =20
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbu=
s_probe.c
> index 86fe6e7790566..3c3e56b544976 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -444,6 +444,9 @@ static void xenbus_cleanup_devices(const char *path, =
struct bus_type *bus)
>  		info.dev =3D NULL;
>  		bus_for_each_dev(bus, NULL, &info, cleanup_dev);
>  		if (info.dev) {
> +			dev_warn(&info.dev->dev,
> +			         "device forcefully removed from xenstore\n");
> +			info.dev->vanished =3D true;
>  			device_unregister(&info.dev->dev);
>  			put_device(&info.dev->dev);
>  		}
> @@ -659,6 +662,28 @@ void xenbus_dev_changed(const char *node, struct xen=
_bus_type *bus)
>  		return;
> =20
>  	dev =3D xenbus_device_find(root, &bus->bus);
> +	/* Backend domain crash results in not coordinated frontend removal,
> +	 * without going through XenbusStateClosing. Check if the device
> +	 * wasn't replaced to point at another backend in the meantime.
> +	 */
> +	if (dev && !strncmp(node, "device/", sizeof("device/")-1)) {
> +		int backend_id;
> +		int err =3D xenbus_gather(XBT_NIL, root,
> +				        "backend-id", "%i", &backend_id,
> +					NULL);
> +		if (!err && backend_id !=3D dev->otherend_id) {
> +			/* It isn't the same device, assume the old one
> +			 * vanished and new one needs to be probed.
> +			 */
> +			dev_warn(&dev->dev,
> +				 "backend-id mismatch (%d !=3D %d), reconnecting\n",
> +				 backend_id, dev->otherend_id);
> +			dev->vanished =3D true;
> +			device_unregister(&dev->dev);
> +			put_device(&dev->dev);
> +			dev =3D NULL;
> +		}
> +	}
>  	if (!dev)
>  		xenbus_probe_node(bus, type, root);
>  	else
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 7dab04cf4a36c..43a5335f1d5a3 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -87,6 +87,7 @@ struct xenbus_device {
>  	struct completion down;
>  	struct work_struct work;
>  	struct semaphore reclaim_sem;
> +	bool vanished;
> =20
>  	/* Event channel based statistics and settings. */
>  	atomic_t event_channels;
> --=20
> 2.51.0
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--oRemhD1n1wZhbvYq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmkWJrsACgkQ24/THMrX
1ywbfAgAmQnHHJlmbMTOX3RtNPXxgqaSefI2mnhv5lYA7X74m8OZxYA6RV/AIkU/
yAVUPQmOahNBjJnSGhkTTV2aFgyf+r5O63Hr9eFGgbGY6TH416bgXLj/dJ/cfLgL
OWxAhSF9TphGmIu1Aqm/JmkM7dic8yTNoL72eKdHY2oKie6dqtX6NfmJEwxrQYwP
iw1pP1A2tWDR+mzfvm4p+camWTAxlYc59CgA5VKOGcb9XsC6PxPXteIkG70bz/iv
d1FywMWsOTb4buaLMRGAGATEOhrK5BY5nPO3uYRogL0EB8zBVUJOIIlLlOYma8GV
G21Rrxa+gQvJtJM73m47Tj0cq8O+TQ==
=/ugj
-----END PGP SIGNATURE-----

--oRemhD1n1wZhbvYq--

