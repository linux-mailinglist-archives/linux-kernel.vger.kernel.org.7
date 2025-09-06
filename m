Return-Path: <linux-kernel+bounces-804197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0284B46C7A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EC85A49BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09128AAEB;
	Sat,  6 Sep 2025 12:13:11 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361922882BE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160791; cv=none; b=OTXTBaEH2Q8dVv8uzvk9iwvjAccys1+5ZiwdZg14X6KOzPmAHZ55pNt0heeHR4xawdN16z1GFJ2KmD2lCziBy9c59hZUU9ekNx+yvFvWRWxdzUvtX5uta62DoN1x3s4aFjXHHUkyUGj8R86tw0VzRX8ZTN0KnvaeCzrYGCWIWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160791; c=relaxed/simple;
	bh=gVq4aknE4F2Hu/FUFAH19yK/uKyKkcQIRaVzweqhS4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bICdSzygbuA5dWIk+RWGWiKpfVdXqhKUiluqGSdXKfvhHAoKj7+JrYu2P4Xz/SjrRXvwNoY0uz5aphuO9e92huhtbwg4rWAKmZz+6kGUHhGMMf/wo4bVMLfwhibKxKAtQ0XdsYAIwmacdcTFbfrBd4psDyH2YylWb3Ywa7++ISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b699de.dsl.pool.telekom.hu [::ffff:81.182.153.222])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D6A.0000000068BC254D.0024C3D3; Sat, 06 Sep 2025 14:13:01 +0200
Message-ID: <a102c7b1db0aaab8457032dde493a37b39a100db.camel@irl.hu>
Subject: Re: [PATCH v3] ALSA: hda/tas2781: Fix the order of TAS2781
 calibrated-data
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com
Date: Sat, 06 Sep 2025 14:13:00 +0200
In-Reply-To: <20250906091923.1760-1-shenghao-ding@ti.com>
References: <20250906091923.1760-1-shenghao-ding@ti.com>
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

On Sat, 2025-09-06 at 17:19 +0800, Shenghao Ding wrote:
> A bug reported by one of my customers that the order of TAS2781
> calibrated-data is incorrect, the correct way is to move R0_Low
> and insert it between R0 and InvR0.
>=20
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-=
data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
>=20
> ---
> v3:
>  - Take Tiwai's advice on cali_cnv() to make it more simpler.
> v2:
>  - Submit to sound branch maintianed by Tiwai instead of linux-next branc=
h
>  - Drop other fix
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda.c | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codec=
s/side-codecs/tas2781_hda.c
> index f46d2e06c64f..f4a44c6b0234 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
> @@ -33,6 +33,23 @@ const efi_guid_t tasdev_fct_efi_guid[] =3D {
>  };
>  EXPORT_SYMBOL_NS_GPL(tasdev_fct_efi_guid, "SND_HDA_SCODEC_TAS2781");
> =20
> +/*
> + * The order of calibrated-data writing function is a bit different from=
 the
> + * order in UEFI. Here is the conversion to match the order of calibrate=
d-data
> + * writing function.
> + */
> +static void cali_cnv(unsigned char *data, unsigned int base, int offset)

unused base?

> +{
> +	struct cali_reg reg_data;
> +
> +	memcpy(&reg_data, data, sizeof(reg_data));

data points to cali_data?

> +	/* the data order has to be swapped between r0_low_reg and inv0_reg */
> +	swap(reg_data.r0_low_reg, reg_data.invr0_reg);
> +
> +	cpu_to_be32_array((__force __be32 *)(data + offset + 1),
> +		(u32 *)&reg_data, TASDEV_CALIB_N);
> +}
> +
>  static void tas2781_apply_calib(struct tasdevice_priv *p)
>  {
>  	struct calidata *cali_data =3D &p->cali_data;
> @@ -103,8 +120,7 @@ static void tas2781_apply_calib(struct tasdevice_priv=
 *p)
> =20
>  				data[l] =3D k;
>  				oft++;
> -				for (i =3D 0; i < TASDEV_CALIB_N * 4; i++)
> -					data[l + i + 1] =3D data[4 * oft + i];
> +				cali_cnv(data, 4 * oft, l);
>  				k++;
>  			}
>  		}
> @@ -130,9 +146,8 @@ static void tas2781_apply_calib(struct tasdevice_priv=
 *p)
> =20
>  		for (j =3D p->ndev - 1; j >=3D 0; j--) {
>  			l =3D j * (cali_data->cali_dat_sz_per_dev + 1);
> -			for (i =3D TASDEV_CALIB_N * 4; i > 0 ; i--)
> -				data[l + i] =3D data[p->index * 5 + i];
> -			data[l+i] =3D j;
> +			cali_cnv(data, cali_data->cali_dat_sz_per_dev * j, l);
> +			data[l] =3D j;
>  		}
>  	}
> =20

Gergo

