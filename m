Return-Path: <linux-kernel+bounces-787473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D42B376F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FB97C757A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65831DB95E;
	Wed, 27 Aug 2025 01:34:25 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8851A8F84
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258465; cv=none; b=ihe4KEHgruft4pUUxlbeMrrHQkq0FRI/UFrNNaY9doSvKAswFcbcDdaNSbGTBOrmtXDv7VXFwIKYHmQB8vtypqvLMCoaRA6ANbhrt9PJjFEdVPdx27wIfa4URltRK3ALh57MEPBYxtGRyqrFhZ2vmrDvfCJBy6DXlrJUzGsf9iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258465; c=relaxed/simple;
	bh=EKvacJKZ+n/LI1Y2Vba84HtYOzBBJadJZPaJP6ikri4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UapOAvwz95izH7tLuOKzWuMZeOKlKqT3y5Urw0OF+7PLwGqZsSyCb9VHuuEBnQyiR7m2/QWHtf9TSIb6NHGEiRVXbKXq7WGK0vccBDDojiE0Xt/MhCpY/qbbhgIn3JRwLJXndm3Bo7BQz23MWNDtbKScrIDg8mJGALxBKU4sX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b68eac.dsl.pool.telekom.hu [::ffff:81.182.142.172])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088D34.0000000068AE609C.00233DD6; Wed, 27 Aug 2025 03:34:20 +0200
Message-ID: <8187d109eb70f6d459df63f3507a0be79efd9aa9.camel@irl.hu>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Fix EFI name for calibration
 beginning with 1 instead of 0
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de
Cc: broonie@kernel.org, andriy.shevchenko@linux.intel.com,
  13564923607@139.com, 13916275206@139.com,
  alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
  baojun.xu@ti.com, Baojun.Xu@fpt.com, jesse-ji@ti.com
Date: Wed, 27 Aug 2025 03:34:19 +0200
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

In the tas2563_save_calibration() function the variables are read in
the following order: R0, InvR0, R0_Low, Power, TLim.
They are also included in cali_data in this order.

But the tasdev_load_calibrated_data() function reads them from
cali_data as R0, R0_Low, InvR0, Power, TLim.

And this may be true for tas2781 as well.

Could you check this also?

Thanks,
Gergo

