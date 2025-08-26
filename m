Return-Path: <linux-kernel+bounces-787398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B0B375B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EBD1B66C78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08CA307AF9;
	Tue, 26 Aug 2025 23:53:27 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542223D2BF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756252407; cv=none; b=l8t7nBMc1WEWcEVUf2ih452D/I5HESoadMMiuSrdLo06NUNibR27bpTOfYPjIlz+4ZCVyJBb77HgJNHP00ov84VC6BssSC/eETb8rROhWkIBI7rmjZIGlrmGKJb0wdtLUmsC7LBVCU7vLo6q8uqwwCgna5dN/jqP3AbXFdSPvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756252407; c=relaxed/simple;
	bh=hZd7DMon6nfo9tAnosKX54eivkP18xoOYKwiqLXaORg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z++VY8bjph1QmYc2wXjylJks/bosdu4hRZmHOnOOrvVFLoCOZbRsumDSXy8zbKmtSkRLJySGOEbfSn6BaP9PZpGif9TAYVNWUN7y605txk8j1ELsebpG8bnucka/lMvbsaO48lP+f948/tdWWlyhHStFQRryOc1Vc3WfDyS68KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68eac.dsl.pool.telekom.hu [::ffff:81.182.142.172])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D34.0000000068AE47BF.00233BCC; Wed, 27 Aug 2025 01:48:15 +0200
Message-ID: <7d64e317bc748fbc1853bb4bc714cd088450fe02.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Fix EFI name for calibration
 beginning with 1 instead of 0
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com, jesse-ji@ti.com
Date: Wed, 27 Aug 2025 01:48:14 +0200
In-Reply-To: <20250826094105.1325-1-shenghao-ding@ti.com>
References: <20250826094105.1325-1-shenghao-ding@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Shenghao,

On Tue, 2025-08-26 at 17:41 +0800, Shenghao Ding wrote:
> A bug reported by one of my customers that EFI name beginning with 0
> instead of 1.
>=20
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-=
data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> ---
> v2:
>  - remove unrelated change
> v1:
>  - Fix EFI name beginning with 1 instead of 0
>  - Add extra comments on EFI name for calibration
>  - Remove an extra space
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/c=
odecs/side-codecs/tas2781_hda_i2c.c
> index ed7771ab9475..635cbd8820ac 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -340,7 +340,8 @@ static int tas2563_save_calibration(struct tas2781_hd=
a *h)
>  		data[offset] =3D i;
>  		offset++;
>  		for (j =3D 0; j < TASDEV_CALIB_N; ++j) {
> -			ret =3D snprintf(var8, sizeof(var8), vars[j], i);
> +			/* EFI name for calibration started with 1, not 0 */
> +			ret =3D snprintf(var8, sizeof(var8), vars[j], i + 1);
> =20
>  			if (ret < 0 || ret >=3D sizeof(var8) - 1) {
>  				dev_err(p->dev, "%s: Read %s failed\n",
> @@ -349,7 +350,7 @@ static int tas2563_save_calibration(struct tas2781_hd=
a *h)
>  			}
>  			/*
>  			 * Our variable names are ASCII by construction, but
> -			 * EFI names are wide chars.  Convert and zero-pad.
> +			 * EFI names are wide chars. Convert and zero-pad.
>  			 */
>  			memset(efi_name, 0, sizeof(efi_name));
>  			for (k =3D 0; k < sizeof(var8) && var8[k]; k++)

The previous tas2781_apply_calib() and tas2563_apply_calib() functions
performed a big endian conversion on the data readed from the EFI
variables.

I couldn't find this in either fmwlib or this file.
Could you please recheck if this happens somewhere?

Thanks,
Gergo

