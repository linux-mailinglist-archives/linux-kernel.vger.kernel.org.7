Return-Path: <linux-kernel+bounces-740475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64EB0D4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B6B1AA49EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C932D8793;
	Tue, 22 Jul 2025 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=erik.faye-lund@collabora.com header.b="ONH9fMJ0"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1102D8767
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172987; cv=pass; b=odj6J9Gun69nulX5BZZdQqParBON6adcsTkTkfbS5SLAV6PUtou8gcRX87T8dPOc5aaPownjtzDd1gcpeoyxpo/IGUAQRA98cWRQtTXPbBuOelEczNu6YxUyWOtiO+bReb5oRiEe/d7Ojk7437jOhe6U7aGTrJ+T3827hkBG5rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172987; c=relaxed/simple;
	bh=BR8KPmhFM1TbcMnG0LwzavzLcKBTwQeuDOBo5sxlB4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEHZi9HrYhf7EtzvzbyN8OHkW/EoGtNodMx3njykr9trzNTo+KvWGIO6qPI3Xnrk5jnMUibVjuFcdsj6Ux5eQ8D9uoHR6HQFTL2crChu1dXwOugUxnscE7yJ7/4gRQsYJ2mUSgma7JebZUq0Jub5P1MvtwGvI06Ea70PqSQ2/1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=erik.faye-lund@collabora.com header.b=ONH9fMJ0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753172971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z26ZDr2WLRHM13aYU8MWWF7ViIeVdELRGUeCtqUXv/KLj0zY48Q+tIOdo9dd43pmWmyyVmcvP/EhodgZMp/9RaglQRrw8jzY7k/Zaaae7AdQAmkS1cIJqPYeXG57/8yWQJYlByTYzRSKLmN5n904DcNfDsFgy1VFHn3bxWdff6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753172971; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kYLsrkqZUuwVDb1Zq02YDwQ1D3jxtY8K+gjAuZAnlfQ=; 
	b=DH3gecS/oiFPuJfENf/iceDqjXYWUVBsnoVWBZi+1bgPTQwsCYCWpX/FlSEAOm2pgsJDzwxgKQ8aCCJCxhiwwJ4BP54nLLoBp9VQm+2DG37isDAFFzGZ25UhgC8UrAlDIfiMeMAr/tFREY3FcEy9Mh0QCzJZ/C+2+oMcUmm+4DM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=erik.faye-lund@collabora.com;
	dmarc=pass header.from=<erik.faye-lund@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753172971;
	s=zohomail; d=collabora.com; i=erik.faye-lund@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=kYLsrkqZUuwVDb1Zq02YDwQ1D3jxtY8K+gjAuZAnlfQ=;
	b=ONH9fMJ0NUgRgf4llJvYo0IgVw1sCDZrA1nVU3dWI8JK64DeqPMN8eBlRagQ3wzi
	e2tDGdODUoptcWLeJ2lGxAXbyGMe0vaKYYOHQCzWKzsww85U4MqjWN8hP7hJof5SUPk
	1Vex0bKmVPYk43WQCc46Fn6gXCq8R8D4BBRIlGGM=
Received: by mx.zohomail.com with SMTPS id 175317296642515.56143309745596;
	Tue, 22 Jul 2025 01:29:26 -0700 (PDT)
Message-ID: <abc0eae5319ed14409c88baab3160b7aed2061b2.camel@collabora.com>
Subject: Re: [PATCH v5 3/6] drm/panthor: Add support for Mali-G710,
 Mali-G510 and Mali-G310
From: Erik Faye-Lund <erik.faye-lund@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>, Steven
 Price	 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 10:29:21 +0200
In-Reply-To: <20250721111344.1610250-4-karunika.choo@arm.com>
References: <20250721111344.1610250-1-karunika.choo@arm.com>
	 <20250721111344.1610250-4-karunika.choo@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Mon, 2025-07-21 at 12:13 +0100, Karunika Choo wrote:
> This patch adds GPU model name and FW binary support for Mali-G710,
> Mali-G510, and Mali-G310.
>=20
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
> =C2=A0drivers/gpu/drm/panthor/panthor_fw.c | 2 ++
> =C2=A0drivers/gpu/drm/panthor/panthor_hw.c | 6 ++++++
> =C2=A02 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c
> b/drivers/gpu/drm/panthor/panthor_fw.c
> index 36f1034839c2..b7b454d16f12 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1402,3 +1402,5 @@ int panthor_fw_init(struct panthor_device
> *ptdev)
> =C2=A0}
> =C2=A0
> =C2=A0MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");

This isn't a problem with this series per-se, but these (as well as the
ones you're adding in later commits here) are all missing from here:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/tree/arm/mali

Any plans on upstreaming these so people without DDK access can
actually try these patches?

> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c
> b/drivers/gpu/drm/panthor/panthor_hw.c
> index f39010c0ca86..7f138974d43b 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -15,8 +15,14 @@ static char *get_gpu_model_name(struct
> panthor_device *ptdev)
> =C2=A0						GPU_PROD_MAJOR(gpu_i
> d));
> =C2=A0
> =C2=A0	switch (product_id) {
> +	case GPU_PROD_ID_MAKE(10, 2):
> +		return "Mali-G710";
> =C2=A0	case GPU_PROD_ID_MAKE(10, 7):
> =C2=A0		return "Mali-G610";
> +	case GPU_PROD_ID_MAKE(10, 3):
> +		return "Mali-G510";
> +	case GPU_PROD_ID_MAKE(10, 4):
> +		return "Mali-G310";
> =C2=A0	}
> =C2=A0
> =C2=A0	return "(Unknown Mali GPU)";

