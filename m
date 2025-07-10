Return-Path: <linux-kernel+bounces-725470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364CEAFFF87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F62F17668F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B192DD5EF;
	Thu, 10 Jul 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="b/Ge0SHU"
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCFBD27E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144355; cv=none; b=SRDbKKFHo4U5CVF0vKJedBoUrrvzUrzVpPlRgwG6sC+iSaZGscCQQgyQ3IXCAg632qkxRhbWdGMIZ1ejIMLRizs5wNYuCfkcNPxIEgWGgFN2R1aGvOk5pd0eeyG9oFTgFdRwiLjst9AJBN2WQxjra6KdiyzKSsFnqYvMnaAJQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144355; c=relaxed/simple;
	bh=ypeDCAgR2fUhnNql6LPGqQy5Ci+gLKPe50v7LDCd4eo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq7E6Alp8060LEFAXyajCqBXbOrIVvLHzPml37O85om+/tEKTNRHmcWfM5sLLiXfZ2Pp59MkXVasbKKzVPyOSMM32LiNC9Swba7pIPI7PlukG9gl/DqD8YmxUVpNpzdttaMaa9OLdDq2SW5+IyZsTv9IYFQUew1FV5EUqrF7NGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=b/Ge0SHU; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752144349; x=1752403549;
	bh=ypeDCAgR2fUhnNql6LPGqQy5Ci+gLKPe50v7LDCd4eo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b/Ge0SHUd3cAMQuR+TE6+5qwtYJb0fhNAcAlBvemrLcBZNzF8jggwOrXUQYo7kNTb
	 NdFLNAc/oHioibxUGu506+hnqQZdZVo2Q2g/HCJ3buuqgQvT1ZyrUd0mlqhpUnCQSc
	 pJl4oVijX1VhJGfUM/WLhBfu2VJDNnK4gnwnpQz/rilgGJpg6G9+ICIO+WZsWvaON5
	 7SWtKohk60DvNuUUYUpeVOoEvHH9pKBHa/tUiVsQ2LFpYqD6wCExfIG+6wgQ7kQMHY
	 VcMQLqPafkdACZnk3KjQ7fVs0w47ovcXwyIFbfRcgXIL+RyHlOHbzfsqy4zD886OjO
	 NwvEU3QijkJ4g==
Date: Thu, 10 Jul 2025 10:45:43 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <p5aiunwdx7vcncsmamq3q7orffrfpmcjzwnrgn2vfczs3y26ak@jxgbwf3bduat>
In-Reply-To: <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com> <aG-DGEpZOHqFoIY3@smile.fi.intel.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 08b16e312e7406c43c80f427fe1d79d499fc86c8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, Jul 10, 2025 at 12:08:40PM +0100, Andy Shevchenko wrote:
> On Wed, Jul 09, 2025 at 02:35:12PM +0200, Sean Nyekjaer wrote:
> > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > calls during probe. These are not required when the device is marked
> > active via pm_runtime_set_active() before enabling pm_runtime with
> > pm_runtime_enable().
>=20
> Hmm... What will happen if the autosuspend triggers just before going out=
 from
> the probe when this change is applied?

Nothing, as pm_runtime is enabled as the last step in probe.

>=20
> > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > path, since the core is not incrementing the usage count beforehand.
>=20
> This is interesting. Have anybody actually tried to see refcount WARN abo=
ut this?
>=20
> > This simplifies the PM setup and avoids manipulating the usage counter
> > unnecessarily.
>=20
> > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42=
600 driver")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> This should be the first, or close to the beginning of the series, patch.

Ok, but help me understand why?

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Thanks for the review :)

/Sean


