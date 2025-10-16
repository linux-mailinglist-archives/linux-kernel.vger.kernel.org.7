Return-Path: <linux-kernel+bounces-856438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20CBE42AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A218508CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA29343D95;
	Thu, 16 Oct 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+e+UmHO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AB341AA0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627687; cv=none; b=VY8p8NztmPO3zreYWwQpjsEFQgK1iMMC+2GhKhM8O3p/pxz8gNBCSXWPNOShi+PQbD2PRueUY47/LgMVoV3aUh0NDQ99fdA4pShjDGNdZ365GfDg5tAq623kOEJmnYJQ+XmwTlR8da4K6qdaYDYBF+pDLLKOaep24+80Uqv3pTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627687; c=relaxed/simple;
	bh=hGWSYNWPlK0emE98FnXV2CDEvbnl8xx7bhE7l1Ib1L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHBGGZLOicnEQSuIjTdJJw/D5NYOrAi9pB+a+uufgY9IgVZgvqrxg6DRIzvyPzLoNLmr/g5YZ8pdJwNh5jZ0iau+EEv0GscHYltd6A7fJ6TuahaABNkjsjmMEdMYRWf3YyTiqHxGkOnIOc/PWzqnLDTeJI+5OHX+8Iw/xVRakVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+e+UmHO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471076f819bso7228705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760627684; x=1761232484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EoOHIdsdrpxMX0n43mbcTrRfSQGGMlYUvz0zw3AbSco=;
        b=Q+e+UmHOo15Da84maIiJ/kfAs3ExMXeI1WJ8cZ4I/1W2LzBBiA7ZV204g9OwjyTP7d
         uIgeS3bNDtSe0blmXEzpHNFB1D+O19V1avn2lCvn1EYI7TPYYVeWLN24wPP2ldYAzzNW
         eo1UCtP7igLuoOR6jr4IUOyoq1s7Qp3HnfuKr3NCrdaXHFgUkLEse9Bn8dlUUhcYdCKD
         DuFyAZTl0eUjkDR2U1ioYhENCfNKlaDG4XSJ3jamMtnaAu14ODLwgnOegTJWW9pfmezL
         f0thkbHF+cO9AmEMu44+fRSnl8KVmllq0YMlcN6YGaZDmT7xNgCgClka57Vgdd0Xgd3b
         retw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627684; x=1761232484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoOHIdsdrpxMX0n43mbcTrRfSQGGMlYUvz0zw3AbSco=;
        b=rxy79JmuhH77XzgK0abeH5WikvhrHH2t8T191QWMCzD7i3isJDCRZDmzDAWkhMvIUQ
         yl8raLvKKAZVkSk19E4Ql5OJ7ELPdUjkMnVSy2oRWXxJYMXm8wMRk6zr+c+3j8tC/VkS
         3A3mkJ72WenRIiixMLTWD6LYOnp7kXEQiW4dJdT17H+D0NMe3RJntMMA9lNNeo4BY7ev
         DVHEo3bNmC7foQ65tkXoGn2m4p/91vMwBaTHdHGzgiZphjrLbMALmEAOdtY2XQbky4WY
         tExU2S8SR/a/lbWObJfrJo+eCppVSS25jCh5A//VOf5dmP3/mCI1uE1V+6y9LSykp3D5
         T7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVfIEmh4Afq7lE3l4Vb5hn0nToGu72ysM+OBuA1H8uQu2tifD3tIhg+99J34cEddWgj0Qhv7eZXAlBaCe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOHgTNtkOhf/7GEu4MvXD+oTSBO3NrFhqCDPcK7Rwqyz6rklA
	YMUkuDjdLtsJpdrlSzLEKFHSnfHAZm0VheEMVYcg5m2OpFRaJ0WOJ5iX
X-Gm-Gg: ASbGncs80pqc4tarA+y2coQNNhCTD/0gpxI25iJnfAKXyql0gnxBhMNFlq7KPgIByCh
	MNp5NGGpjAftOwj6v3RKIlcK4OgbNC/iqycNHxtCwBlOEglHNxyYSlTGIOqXGjlcg3K6LuAUuyW
	uq6qdaQmLR/hgBg5f0hul0NULMQsYMc6IFUp5Bfb0xRZOrLxltkHdzgRlBI57vJ6d075MoQtmuA
	Isibs/olyrfFE87sJfsHcR+sTAwGs5HfAwRG9zeE2M2qDHQi19RZ+dx0Vlw3UGGVyZc7xl+U8lc
	COQmZgCqL9vuIDRZn2o6f3DpCABwEEL4LWhWn9Nfoy6o2CAfenG4+5CfqI2pvPzFmEuEh3gMHpO
	W9sr51jv3GHDELl6S2smaLOnkZK0M5OpueGcjbgL0U90xEAtEKHhuKXvXLkypcJkgeaa8HKgy5G
	8GzPQ7TavfbdzdgKBk5ne+KVB/5nguMU/PJjt20MOhJsYffLGvjIfgfochhQa/sUeKy/bENfEYx
	g==
X-Google-Smtp-Source: AGHT+IF3n3VtNdhsWvLalKoTzz4VLTyBDlsARgNwi1Y2P6nJNR3uu6ecU3ZEzG9VFbpUOYGZEkzvoA==
X-Received: by 2002:a05:600c:444d:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-471178ad982mr2701175e9.17.1760627683366;
        Thu, 16 Oct 2025 08:14:43 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711443e7a1sm33668125e9.9.2025.10.16.08.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:14:42 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:14:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com, kyarlagadda@nvidia.com, 
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/2] spi: tegra210-quad: Fix timeout handling
Message-ID: <mqyiss7smpwlsfblxgrfkvsg55n7uctujtkmdtdejo7fg3hatj@22cyzfpuk23i>
References: <20251016132923.3577429-1-va@nvidia.com>
 <20251016132923.3577429-2-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rhvddrsybgdqrlkm"
Content-Disposition: inline
In-Reply-To: <20251016132923.3577429-2-va@nvidia.com>


--rhvddrsybgdqrlkm
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="zoxvwpn4fv5owykj"
Content-Disposition: inline
Subject: Re: [PATCH v2 1/2] spi: tegra210-quad: Fix timeout handling
MIME-Version: 1.0


--zoxvwpn4fv5owykj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 01:29:22PM +0000, Vishwaroop A wrote:
> When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
> is excessively busy, it can lead to rare cases of the IRQ thread not
> running before the transfer timeout is reached.
>=20
> While handling the timeouts, any pending transfers are cleaned up and
> the message that they correspond to is marked as failed, which leaves
> the curr_xfer field pointing at stale memory.
>=20
> To avoid this, clear curr_xfer to NULL upon timeout and check for this
> condition when the IRQ thread is finally run.
>=20
> While at it, also make sure to clear interrupts on failure so that new
> interrupts can be run.
>=20
> A better, more involved, fix would move the interrupt clearing into a
> hard IRQ handler. Ideally we would also want to signal that the IRQ
> thread no longer needs to be run after the timeout is hit to avoid the
> extra check for a valid transfer.
>=20
> Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI c=
ontroller")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/spi/spi-tegra210-quad.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-q=
uad.c
> index 3be7499db21e..10e56d8ef678 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_q=
spi *tqspi)
>  	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->s=
tatus_reg);
>  	tegra_qspi_dump_regs(tqspi);
>  	tegra_qspi_flush_fifos(tqspi, true);
> -	if (device_reset(tqspi->dev) < 0)
> +	if (device_reset(tqspi->dev) < 0) {
>  		dev_warn_once(tqspi->dev, "device reset failed\n");
> +		tegra_qspi_mask_clear_irq(tqspi);
> +	}
>  }
> =20
>  static void tegra_qspi_transfer_end(struct spi_device *spi)
> @@ -1173,12 +1175,14 @@ static int tegra_qspi_combined_seq_xfer(struct te=
gra_qspi *tqspi,
>  					dma_ctl &=3D ~QSPI_DMA_EN;
>  					tegra_qspi_writel(tqspi, dma_ctl,
>  							  QSPI_DMA_CTL);
> -				}
> +			}
> =20
>  				/* Reset controller if timeout happens */
> -				if (device_reset(tqspi->dev) < 0)
> +				if (device_reset(tqspi->dev) < 0) {
>  					dev_warn_once(tqspi->dev,
>  						      "device reset failed\n");
> +					tegra_qspi_mask_clear_irq(tqspi);
> +				}
>  				ret =3D -EIO;
>  				goto exit;
>  			}
> @@ -1196,6 +1200,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegr=
a_qspi *tqspi,
>  			goto exit;
>  		}
>  		msg->actual_length +=3D xfer->len;
> +		tqspi->curr_xfer =3D NULL;
>  		if (!xfer->cs_change && transfer_phase =3D=3D DATA_TRANSFER) {
>  			tegra_qspi_transfer_end(spi);
>  			spi_transfer_delay_exec(xfer);
> @@ -1205,6 +1210,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegr=
a_qspi *tqspi,
>  	ret =3D 0;
> =20
>  exit:
> +	tqspi->curr_xfer =3D NULL;
>  	msg->status =3D ret;
> =20
>  	return ret;
> @@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct =
tegra_qspi *tqspi,
>  		msg->actual_length +=3D xfer->len + dummy_bytes;
> =20
>  complete_xfer:
> +		tqspi->curr_xfer =3D NULL;
> +
>  		if (ret < 0) {
>  			tegra_qspi_transfer_end(spi);
>  			spi_transfer_delay_exec(xfer);

The original patch has another tqspi->curr_xfer =3D NULL in
handle_cpu_based_xfer() that doesn't seem to be in this patch. I'm
attaching it here again for reference.

Thierry

--zoxvwpn4fv5owykj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom 6c35ff11a4ef6e917aa1891df5cbd6bfd5902067 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Tue, 7 Oct 2025 13:40:26 +0000
Subject: [PATCH] spi: tegra210-quad: Fix timeout handling

When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
is excessively busy, it can lead to rare cases of the IRQ thread not
running before the transfer timeout is reached.

While handling the timeouts, any pending transfers are cleaned up and
the message that they correspond to is marked as failed, which leaves
the curr_xfer field pointing at stale memory.

To avoid this, clear curr_xfer to NULL upon timeout and check for this
condition when the IRQ thread is finally run.

While at it, also make sure to clear interrupts on failure so that new
interrupts can be run.

A better, more involved, fix would move the interrupt clearing into a
hard IRQ handler. Ideally we would also want to signal that the IRQ
thread no longer needs to be run after the timeout is hit to avoid the
extra check for a valid transfer.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-qua=
d.c
index 3be7499db21e..a103265e7eab 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qsp=
i *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->sta=
tus_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
+		tegra_qspi_mask_clear_irq(tqspi);
+	}
 }
=20
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1176,9 +1178,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra=
_qspi *tqspi,
 				}
=20
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset(tqspi->dev) < 0) {
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
+					tegra_qspi_mask_clear_irq(tqspi);
+				}
 				ret =3D -EIO;
 				goto exit;
 			}
@@ -1200,11 +1204,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegr=
a_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		tqspi->curr_xfer =3D NULL;
 		transfer_phase++;
 	}
 	ret =3D 0;
=20
 exit:
+	tqspi->curr_xfer =3D NULL;
 	msg->status =3D ret;
=20
 	return ret;
@@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct te=
gra_qspi *tqspi,
 		msg->actual_length +=3D xfer->len + dummy_bytes;
=20
 complete_xfer:
+		tqspi->curr_xfer =3D NULL;
+
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1395,6 +1403,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra=
_qspi *tqspi)
 	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
+	tqspi->curr_xfer =3D NULL;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -1480,6 +1489,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, vo=
id *context_data)
 {
 	struct tegra_qspi *tqspi =3D context_data;
=20
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (tqspi->curr_xfer =3D=3D NULL)
+		return IRQ_NONE;
+
 	tqspi->status_reg =3D tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
=20
 	if (tqspi->cur_direction & DATA_DIR_TX)
--=20
2.51.0


--zoxvwpn4fv5owykj--

--rhvddrsybgdqrlkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjxC+AACgkQ3SOs138+
s6Fa3Q//evLYuwnbYxOKDhFrZmDwXFibzeB4ybyDIvEok2dR4lrF1//hBeMx2LDD
tc/SoS6z9z1uz6i3aBwigUWeZFnEis+NIegialJY/SUozlkdRc6EjjsvptPQJR06
+wssprXAhdlB/JBSaWSvbSC4gl/HTNDIYgzjQdoNHEo5px0snsN3kUN8YlZ0iTOi
OYE2/cWeAWKwT9I2JFw8JX+0Wgke7HXlYJAGU9Ax3FiJN5jsnL37zLkhXqclu7RS
gKBPqQtYQTgITsU566pyTBkiFHeNGgugZWe6Eyf8XGealloY51cC1/885ewCzDWc
wHltjXQViL4/skq67v1LsqHmEpCMSRQlRVK+KShI0OvXJasbpUlarhZj0Bsn4ETx
16OmKXTo5VcIO5ufXRgFT0MCOKB8ZcGsCMOwjQqNS//t7/JHemF8Nwq3hohzyoRd
BdMGxt+1vQPEYnF4PKTWkG+OChbFJ/3Q0rueGNvL7R6YI8rH/tH455yAWG1VPpSp
9upVhtQNo0wJzeMSyUMXNtza8zjZKu2eD5O+BDAg0bFKEwhFx+Ba5YqO0CgOMo+n
gKH15jeUAGnUDUvcNRq113FN+gpLTw4avCbUXhWbpnvwsy+f7MumfWYAMzf7F26m
waK4woXg8XoJuxESyI/1+Eq0U1PrlmKYCEOAUo1q/YpcH2zjk+o=
=Npcl
-----END PGP SIGNATURE-----

--rhvddrsybgdqrlkm--

