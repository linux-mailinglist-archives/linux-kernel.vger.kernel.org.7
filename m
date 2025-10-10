Return-Path: <linux-kernel+bounces-848077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD61BCC73D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6968840263B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74C2ED17C;
	Fri, 10 Oct 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PQNtyzcz"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88520A5EA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090370; cv=none; b=pjsft5lEBdqmOWs/ALnVS0+WkIFx9n6oojy+wiQJIsSiFuGQv3lpwXSjLGQaK/lZf9C6+Qp6twOQQjQ3yUOuv7KpN2ZsaF3jDmpVxoiFjVy6wYh93Bq2niYi1GqUCjnWISepjYQXaQzN5y+Ar9vmGC/IqDxO18Lm8W5hyXUy0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090370; c=relaxed/simple;
	bh=vQWMYvYYYMF9y9WflHX8XkNouS4Wqt/G/yc56cKJNGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJg06eaX8+FFxsZdMVunQcWBqntj2D8OjzCDr3+ERWyAZwlwPPvTQb1o9MIyfDstUFHSuRzQLLF0g/dzs+aSmlAkeG/hw9uC1S+n89Jt7u6CKL8L0a9K2uq6WPTpWgooLvMX3g+HUOOVlN0xdr63AXHzFE06v9BSQ6QWNLpljrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PQNtyzcz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4257aafab98so1622206f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 02:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760090366; x=1760695166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8DzAn8h5K5sSJjaAHPz0TH/gQotZMWW1j3+EKC49O1s=;
        b=PQNtyzczxlDdhAIyLrO13veTVPsvystYcjbf28Jd90p/+0CZeTHBX2ZA4z1C2qCXK3
         Dq3LiKc9ThOd49Yr/ZST8rsb4IN65QwlKm7HOhIQVyH9HnOtXnDh2KE1ePVza9KxJFXg
         /rafNFYK53bNEtTEUnf5b+AUcunbtsM84tJL7JJ8G7ltI6e8NkNaf7R3DEW0dx9dHJ3d
         ml1QV5E8e1N0EDSX/RWPNvqgSgAmm3qAX+66eNLmbyJ4ARl1b1nPMb0dkoKrQDpoxJrK
         IBkXmMoM+vpv+okBKeBQjaZu2PLvauEr2JLhRrdskbyXWoUSobNt0hFWs6NAdNu10Jbv
         9NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090366; x=1760695166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DzAn8h5K5sSJjaAHPz0TH/gQotZMWW1j3+EKC49O1s=;
        b=OTaWemkv2VA0zz8gURpkPDPTmOFKO/VqB+ipasqwQymY8pBv5Hb/dui4F6PeWYINPs
         nFi8yk5gmP3MiS1xSJzQsBQhpJhBsjibYJ1FnMLe0veiJhlyNF13yKr3AMjDXi82QvuI
         AAIWb4F69jz+BLIu7IEvfaD4EuLX3C0cAke6X+fmK9o/SBWUVCD7DsFmJuH/0qaa8eLA
         R2Y06vGdpQHhJPAyNfPGM8C7cpDScqmcGmbd6MQTcXioSbnbf8tF1CE84s7Rwr4dnLdt
         cYaL88Tary98OjlYY2Hs7kvqn7mq/u80f3Jkm3eY1edfiA+QYPyC/lqqVK0MPNNuXszh
         F5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyrsCzXgNM/shjzN+Tob0Jhn7ZW/ypwT15r+BbXbFwWwBEHWQgVtg9P6LQ6+EU+02Yg6iFFPwca23PSqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+v0l6wpe5e12baB/Auph6wyDBsheduzybJYnUUAiOVON9eUf
	Rm7t5DXvotaei+u0x9vzPXqs1U+vl06L/jwhzxnDuhbtBMAXuE9qg3GC3T3JPzA1rh4=
X-Gm-Gg: ASbGnctx6Go+YhhXM2ZPztwt9QvLsGprFdA0VKx6cuzzSWhzN/FGZxkYbAtdYsfiMRG
	xhiIEkyisDJY+1R+Qxm5OtxHh6qnxgMCVo7cf3vohwHhRnMbi9zBXHRVzJkSiZmoMx904fpoO1t
	OJKRMeetFxCybwonLu3Xil5SAFJQoGy+yvLEuLO2DchQrzGgQeE4euOlnACvjpwjkwRQ+vckAn5
	Oxu/pGZ15YedRzGW1stNaQSd2GnXnAtiT3u58Gw8YoVJ9ZzKMcyw4qxDT/ylIwWHdBM9pssxJWb
	Z4PDGUzy418rhLtg+Mvu//dlFL3I9Fxd0+FObWr9r0KKgY4LjMNUDPjhTmxDBiLG53+XoM+35ms
	9MEYQq0N1SZiLwNFql1zhp8tqYJLMbs7M1vlRjFvNjLT4fNcZHC4zczXCn/O+Kp92pAGURjLlCw
	IvfbK0Mt4=
X-Google-Smtp-Source: AGHT+IGBYsfMh75Hh5zxiwruYu23yH7nClDJDGYy+ble0hfKIDqxAPcoM9f6zkelCUi0z7d0tu8mqg==
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id ffacd0b85a97d-42666ac7279mr7036053f8f.24.1760090365997;
        Fri, 10 Oct 2025 02:59:25 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce5e10e8sm3345992f8f.39.2025.10.10.02.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:59:25 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:59:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: chenhuacai@kernel.org, dan.carpenter@linaro.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org, ulf.hansson@linaro.org, zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aliep4j5jmbdixu5cmqztoxwp3jv4r4hi63qpvhughepsepzb3@qh3mwgryf5ny>
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
 <20251009152744.9734-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="54dwufa2azbfzfm6"
Content-Disposition: inline
In-Reply-To: <20251009152744.9734-1-rakuram.e96@gmail.com>


--54dwufa2azbfzfm6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
MIME-Version: 1.0

Hello Rakuram,

On Thu, Oct 09, 2025 at 08:57:38PM +0530, Rakuram Eswaran wrote:
> Your suggestion makes perfect sense =E2=80=94 since host is devm-managed,=
=20
> explicitly assigning its members to NULL has no effect.=20
> I=E2=80=99ll remove those two redundant lines in v2 as you suggested.
>=20
> I had one small clarification regarding the remaining host->dma_chan_tx =
=3D NULL;
> in the TX DMA error path. Since that branch uses goto out,=20
> the cleanup section below may call dma_release_channel() on both RX=20
> and TX pointers. Setting TX to NULL there seems like a defensive step=20
> to avoid accidentally passing an ERR_PTR() to dma_release_channel()=20
> =E2=80=94 is that understanding correct?

Ah right, so either keep host->dma_chan_tx =3D NULL or improve the error
handling like:

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..e5068cc55fb2 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -715,7 +715,7 @@ static int pxamci_probe(struct platform_device *pdev)
 		dev_err(dev, "unable to request tx dma channel\n");
 		ret =3D PTR_ERR(host->dma_chan_tx);
 		host->dma_chan_tx =3D NULL;
-		goto out;
+		goto out_dma_tx;
 	}
=20
 	if (host->pdata) {
@@ -765,10 +765,11 @@ static int pxamci_probe(struct platform_device *pdev)
 	return 0;
=20
 out:
-	if (host->dma_chan_rx)
-		dma_release_channel(host->dma_chan_rx);
 	if (host->dma_chan_tx)
 		dma_release_channel(host->dma_chan_tx);
+out_dma_tx:
+	if (host->dma_chan_rx)
+		dma_release_channel(host->dma_chan_rx);
 	return ret;
 }
=20
> Also, I noticed that in the build configuration downloaded from the LKP r=
eport=20
> link (CONFIG_DMA_ENGINE isn=E2=80=99t defined), the kernel uses the stub =
inline=20
> version of dma_release_channel() from include/linux/dmaengine.h,=20
> which becomes a no-op.=20
>=20
> From what I understand, when the DMA engine framework isn=E2=80=99t enabl=
ed,=20
> these APIs compile as no-ops through their inline stubs.=20
> Please correct me if I=E2=80=99m misunderstanding how this works.
>=20
> Please let me know if this reasoning aligns with what you had in mind.

Sounds right.

Best regards
Uwe

--54dwufa2azbfzfm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjo2PkACgkQj4D7WH0S
/k5wUwf7BFg4e6GvALl61mEKV9IwUSBj6wGkRqj3UTzRfeqjt2/9cfLxrg9YrQXq
ZjjEQ4EDNpqeaVtzJmG6Cdv/sz49fAat8Cu3LUlg7iQjecA2Bp2ZT05wgAWD+lb9
/sc5wevdk7Lkwj835EAQsGZja31qEDsvIsuVL936pPYuLOAeH/KjlRD5mVp9rVGz
pQAfBsKe9tyeIDZPjmKyR8xrAvqqri3Z39LL+GJWtTUmQEy7z+Ibwcegu2HI5pea
0qHZAYpkqzFSiDrMF4n66sSyaF5ddDa+HwPHInzM4W5IKPWTtu3vNybWF4rvbpjU
mxedmYUlwln6CAHXIa6iHKqC8OYi4g==
=3GaF
-----END PGP SIGNATURE-----

--54dwufa2azbfzfm6--

