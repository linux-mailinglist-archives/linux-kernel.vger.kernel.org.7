Return-Path: <linux-kernel+bounces-832590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35096B9FD61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21055188E2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051A288538;
	Thu, 25 Sep 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="q/TpsiuY"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59C13C914
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808803; cv=none; b=ADQQK7w8JdsfhSBgsM5nF60L0p2fpPWvZ92KyH1HRCiSaX1xw8KPMZWIgskNWjMh9fU1tYpKC1PPFI3h1pgdfeQkthQUwLyP4PPP9DLBOw0tbZGYjEh27AdtFmajGTGJBb5xLHXiX3pjCbzPI75ZkeEvCQ1Nq25G1owKs48/azc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808803; c=relaxed/simple;
	bh=cOeaK8VeP+NiUEh1fkd9LbsW3YqQGsvHSoaqPLpCDXc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UYmfWxPP9n9mWrP7aKZKH+/yzDzriMXM+b8CdwN2alNRnNJbUq/GXpJxcU6OUWlZItsgSPXU1aQXOaJDMLymOwjkxiOcct2yPhJvdsgCqWGe8C8XT+K7DHP9tNEqjXhaWSmKANqZdbEb16eStR5+NFxojiwzx6ChXPIQ1HKm6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=q/TpsiuY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758808798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6zXbnirHPfwURjTSzjf0yuewcHo8JAYP7+VOWSU0F0=;
	b=q/TpsiuYwjlQgxS8kmy2CYvW3WT+sO1+7Ax4CLGDFqC2d+RxkkegkWFQctwA7XxU7FItms
	DkURbfekIuXl1omweLieacGb0/N1V6+Bc8VetgeZgBkSdE1mL5KPnatcJrbdQpCaCwOtCc
	6w96VQwbYnxSsvpA7+8hWOyHqjCKpHUoLDdCmDAwZuHCQVzzwncHXC5D7vgQSJXIiHeMtu
	Soo6MIMISB35FMbJ+A9ZwJTcxJFyEEq1Fnyh68oEkZaEwJDSmV5R3GKqI0IvuWAg86zc3U
	OD7bJNjIHTOOr94Cxg9LPx8Qwhx27r9fRFv4OJWKklI2QJKN/EJnwWBQnzttDA==
Content-Type: multipart/signed;
 boundary=d1cbf490ecbd8c6ccce0deb6a66abc7d8a9e3325aeede4af7c494c5816b0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 25 Sep 2025 15:59:44 +0200
Message-Id: <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Heiko Stuebner" <heiko@sntech.de>,
 "Sebastian Reichel" <sebastian.reichel@collabora.com>, "Sebin Francis"
 <sebin.francis@ti.com>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Jon Hunter" <jonathanh@nvidia.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in
 fw_devlink_dev_sync_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>, "Saravana Kannan"
 <saravanak@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-pm@vger.kernel.org>
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
In-Reply-To: <20250925115924.188257-1-ulf.hansson@linaro.org>
X-Migadu-Flow: FLOW_OUT

--d1cbf490ecbd8c6ccce0deb6a66abc7d8a9e3325aeede4af7c494c5816b0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the messages that are being
> logged in fw_devlink_dev_sync_state(). In particular as they are at the
> warning level, which doesn't seem correct.
>
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driv=
er
> may be built as module and are still waiting to be initialized/probed.

"there may be nothing wrong with it" doesn't sound very convincing.
So there *can* be something wrong with it, so warning sounds
appropriate? If there is (certainly) something wrong with it, I expect
an error.
FWIW: most of my drivers/modules are built as modules.
I do seem to run into 'problems' more then average because of that, but
to me it just signals there is something wrong ... which should be
fixed. Not silenced.

You're the expert, but I'm not so sure this is an improvement.
I do regularly check dmesg level 0, 1, 2, 3 and 4, hence it landed on my
radar. I do not regularly check all the dmesg msgs, so this change would
result it dropping off my (immediate) radar.

On Fri Sep 12, 2025 at 8:32 PM CEST, Saravana Kannan wrote:
> Please don't just disable fw_devlink using fw_devlink=3Doff. We want to
> fix any issues you are hitting with it. I might even delete this "off"
> option sometime. It was meant as an early debug option.

That response made a lot of sense to me. I haven't gotten around to it
yet, but I want to test all my (Rockchip) devices to see if they 'need'
that parameter to 'silence' the warning. I have a (vague) recollection
that some don't need it (for that).

My 0.02

Cheers,
  Diederik

> Ideally these messages should be at the debug level, but since the
> ->sync_state() feature is under an ongoing deployment and the prints
> provides valuable information, let's move to the info level for now.
>
> Cc: Saravana Kannan <saravanak@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..97eab79c2f3b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device =
*dev, void *data)
>  		return 0;
> =20
>  	if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) {
> -		dev_warn(sup, "sync_state() pending due to %s\n",
> +		dev_info(sup, "sync_state() pending due to %s\n",
>  			 dev_name(link->consumer));
>  		return 0;
>  	}
> @@ -1792,7 +1792,7 @@ static int fw_devlink_dev_sync_state(struct device =
*dev, void *data)
>  	if (!list_empty(&sup->links.defer_sync))
>  		return 0;
> =20
> -	dev_warn(sup, "Timed out. Forcing sync_state()\n");
> +	dev_info(sup, "Timed out. Forcing sync_state()\n");
>  	sup->state_synced =3D true;
>  	get_device(sup);
>  	list_add_tail(&sup->links.defer_sync, data);


--d1cbf490ecbd8c6ccce0deb6a66abc7d8a9e3325aeede4af7c494c5816b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNVK1wAKCRDXblvOeH7b
bu9cAQDgWb2pxgFG3UFhZ5AJ4XnkZoo6afbzYvPejyBq4VRNVQEA+D1rt5xMXzkr
wKGuYk+Gprw82liU5r/9UMBzEgnLcwE=
=qpi2
-----END PGP SIGNATURE-----

--d1cbf490ecbd8c6ccce0deb6a66abc7d8a9e3325aeede4af7c494c5816b0--

