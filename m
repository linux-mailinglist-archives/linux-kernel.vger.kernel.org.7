Return-Path: <linux-kernel+bounces-857739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D791BE7D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F4B189DC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6966C313E2A;
	Fri, 17 Oct 2025 09:35:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CD8313E37
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693711; cv=none; b=R4hFIm8b7y74/kq+JGZNe3a1nbjjUqaC8mLKrKNdTMuaF8NdCi6cbwT/kz2jIU1vvqrbBpmXJgziNBatrVu3yRzMoiZnaa/4I42L7eP58db1p6OminmenW2kGDkAAC0rPAAb6La8tcDhvAL2yJXe53h5Ss8TRtEbDrESi5ku2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693711; c=relaxed/simple;
	bh=6vzNI1DK18m3ce5DSYBfwoD5ny5GBGqbd/mU6bAfUFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f2SnYfy3lJAwScl8vA0Fo1tDmmSIAYRjFCHNOwa1ccNLgCB5gegIHAwQvLtOjcWUTYL2IrpmvdTBjgI0Son5YA+io1uXU8JselmhD385cOLLCdvk8DrjThaRJ7iR+IoYpbxQCtxjflyI+IiEb1BpQ2pL1trvNsgQsNaG08LQ5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9grO-000516-Q7; Fri, 17 Oct 2025 11:34:54 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9grN-0042MN-32;
	Fri, 17 Oct 2025 11:34:53 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v9grN-000000003Jz-3fNi;
	Fri, 17 Oct 2025 11:34:53 +0200
Message-ID: <7cef6733507f86dfcc30131f1d941a47771a394a.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: remove legacy reset lookup code
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Lechner
 <david@lechnology.com>,  Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 17 Oct 2025 11:34:53 +0200
In-Reply-To: <20251017-da850-reset-lookup-v1-2-362a309a9f09@linaro.org>
References: <20251017-da850-reset-lookup-v1-0-362a309a9f09@linaro.org>
	 <20251017-da850-reset-lookup-v1-2-362a309a9f09@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Bartosz,

On Fr, 2025-10-17 at 10:02 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> There are no more users of this code. Let's remove the exported symbols
> and the implementation from reset core.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/reset/core.c             | 120 +--------------------------------=
------
>  include/linux/reset-controller.h |  33 -----------

Ah, the best kind of patch.

>  2 files changed, 2 insertions(+), 151 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 22f67fc77ae531c6efba3ce92cc73a2d57397762..9ca4ac27daf955d7fe74f7684=
819072a6f32492b 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
[...]
> @@ -1081,70 +1054,6 @@ __of_reset_control_get(struct device_node *node, c=
onst char *id, int index,
>  }
>  EXPORT_SYMBOL_GPL(__of_reset_control_get);
> =20
> -static struct reset_controller_dev *
> -__reset_controller_by_name(const char *name)
> -{
> -	struct reset_controller_dev *rcdev;
> -
> -	lockdep_assert_held(&reset_list_mutex);
> -
> -	list_for_each_entry(rcdev, &reset_controller_list, list) {
> -		if (!rcdev->dev)
> -			continue;
> -
> -		if (!strcmp(name, dev_name(rcdev->dev)))
> -			return rcdev;
> -	}
> -
> -	return NULL;
> -}
> -
> -static struct reset_control *
> -__reset_control_get_from_lookup(struct device *dev, const char *con_id,
> -				enum reset_control_flags flags)
> -{
> -	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> -	const struct reset_control_lookup *lookup;
> -	struct reset_controller_dev *rcdev;
> -	const char *dev_id =3D dev_name(dev);
> -	struct reset_control *rstc =3D NULL;
> -
> -	mutex_lock(&reset_lookup_mutex);
> -
> -	list_for_each_entry(lookup, &reset_lookup_list, list) {
> -		if (strcmp(lookup->dev_id, dev_id))
> -			continue;
> -
> -		if ((!con_id && !lookup->con_id) ||
> -		    ((con_id && lookup->con_id) &&
> -		     !strcmp(con_id, lookup->con_id))) {
> -			mutex_lock(&reset_list_mutex);
> -			rcdev =3D __reset_controller_by_name(lookup->provider);
> -			if (!rcdev) {
> -				mutex_unlock(&reset_list_mutex);
> -				mutex_unlock(&reset_lookup_mutex);
> -				/* Reset provider may not be ready yet. */
> -				return ERR_PTR(-EPROBE_DEFER);
> -			}
> -
> -			flags &=3D ~RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> -
> -			rstc =3D __reset_control_get_internal(rcdev,
> -							    lookup->index,
> -							    flags);
> -			mutex_unlock(&reset_list_mutex);
> -			break;
> -		}
> -	}
> -
> -	mutex_unlock(&reset_lookup_mutex);
> -
> -	if (!rstc)
> -		return optional ? NULL : ERR_PTR(-ENOENT);
> -
> -	return rstc;
> -}
> -
>  struct reset_control *__reset_control_get(struct device *dev, const char=
 *id,
>  					  int index, enum reset_control_flags flags)
>  {
> @@ -1157,7 +1066,7 @@ struct reset_control *__reset_control_get(struct de=
vice *dev, const char *id,
>  	if (dev->of_node)
>  		return __of_reset_control_get(dev->of_node, id, index, flags);
> =20
> -	return __reset_control_get_from_lookup(dev, id, flags);
> +	return ERR_PTR(-ENOENT);

I think this should be:

	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;

	/* ... */

	return optional ? NULL : ERR_PTR(-ENOENT);

With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

