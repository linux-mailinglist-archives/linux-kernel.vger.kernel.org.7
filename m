Return-Path: <linux-kernel+bounces-642259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0EAB1C5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37BA16706A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813423C51E;
	Fri,  9 May 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6aR8Y+v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12C239E71
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815632; cv=none; b=jS7WR6k5b4d2+b8k+klgKqRjic/WMOCtTJOrJKYv38dYHdpF+AR+tbQDr4YmUCBm/N8MQ968vdlE9qZzQN0UbaCuGKZdsuszuJLeQBUgzBs2QTV5scubpzgLCmerfOZPKCeFslyRdSKUS3SsDdHnK5KMxzFcm4kAMZyc+AzopbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815632; c=relaxed/simple;
	bh=NExlrnswyHIJcXXajxp1nvUpQkfg++fyr8mjuwKWgeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwBeaY7/MQHGoBvneYOkuBDQE8QA6LVWVDLFbH3FXbzpd3Svu0eakrgTy2T5FUP36eCZcltdD7MD48lJpKJqxP2WAG3+shpBBf9AajP1lqvWfsVA74Ux+29cO2/s9PxCrBYzVZj2xO76oQYrAdHPnaYb/+hmF/FeALsucfhRWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6aR8Y+v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746815630; x=1778351630;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NExlrnswyHIJcXXajxp1nvUpQkfg++fyr8mjuwKWgeM=;
  b=N6aR8Y+vgT7yv5vogTpz5ATKHOMUafVP+efPd1AyaP35IIVj33xEpEbe
   puuHy8JZO9PZ4gnoIXNQzdtlKHNDU391JcPm0uKnqNvph9gz/h17XI+Vi
   ck+8P7osF3TZ/PpHnp4R2z5s7M7DRzsDygq6lhBw5YNcEGHFvWvSeTPCh
   ueWHc8MgO0LXP94DSqHiZod1cdee9N7drvmEGfP+3bXF7FKVG+7AsPkvf
   2HgCjhodrtHDWVbyCRSOdoOQ5MWigqOzyl5uZNFkUL179mPDrO2sR6Tus
   h9v/JY3wyjcFXMI2sAi2QXXhAtd3UhfrMH4GQNa7qrBEYpP8VvOfCE+UI
   w==;
X-CSE-ConnectionGUID: sfo2kn34TVOLgaD68kRtqg==
X-CSE-MsgGUID: NcuPlU0IQBi/nXesVkzsHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="60001975"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="60001975"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 11:33:49 -0700
X-CSE-ConnectionGUID: KWdvAj8bRbOTx2+TsBcW5w==
X-CSE-MsgGUID: heKlrp96To6gdwYJHwX/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="140762395"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.203]) ([10.125.108.203])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 11:33:49 -0700
Message-ID: <7f237574d9f08a9fa8dcaa60d2edf8d8e91441d4.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] alloc_tag: keep codetag iterator active between
 read() calls
From: Tim Chen <tim.c.chen@linux.intel.com>
To: David Wang <00107082@163.com>, surenb@google.com,
 kent.overstreet@linux.dev,  akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 09 May 2025 11:33:48 -0700
In-Reply-To: <20250509173929.42508-1-00107082@163.com>
References: <20250507175500.204569-1-00107082@163.com>
	 <20250509173929.42508-1-00107082@163.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-05-10 at 01:39 +0800, David Wang wrote:
>=20
>=20
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  lib/alloc_tag.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 25ecc1334b67..fdd5887769a6 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -45,21 +45,16 @@ struct allocinfo_private {
>  static void *allocinfo_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct allocinfo_private *priv;
> -	struct codetag *ct;
>  	loff_t node =3D *pos;
> =20
> -	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> -	m->private =3D priv;
> -	if (!priv)
> -		return NULL;
> -
> -	priv->print_header =3D (node =3D=3D 0);
> +	priv =3D (struct allocinfo_private *)m->private;
>  	codetag_lock_module_list(alloc_tag_cttype, true);
> -	priv->iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> -	while ((ct =3D codetag_next_ct(&priv->iter)) !=3D NULL && node)
> -		node--;
> -
> -	return ct ? priv : NULL;
> +	if (node =3D=3D 0) {
> +		priv->print_header =3D true;
> +		priv->iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> +		codetag_next_ct(&priv->iter);
> +	}

Do you need to skip print header when *pos !=3D 0? i.e add

	} else {
		priv->print_header =3D false;
	}

Tim

> +	return priv->iter.ct ? priv : NULL;
>  }
> =20


