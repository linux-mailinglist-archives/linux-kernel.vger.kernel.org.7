Return-Path: <linux-kernel+bounces-827358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 996EFB91896
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED6118971DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5730E849;
	Mon, 22 Sep 2025 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Y2hztTB9"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEAE26FDB6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549490; cv=none; b=SXgo0UYcTd67iI5C0/c5guabKnjfKmqj/y8NsfNcw/REeFH2Q3cX/6XE9fHjW/rwp/gB0pXA1MHOaEEAxWhcv14qPfITNJZUCo7qxrtfDRsvCLD0i0ogkO5iR74oEMCj6kp9VNdqxbQjzjS4uwiY6D/5bOQSCR3U79sb9/kRyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549490; c=relaxed/simple;
	bh=j0E0JLElbkGQzcGMkewDl5HOnFcpcIh5H8sfEdo74Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXhl0tmkEj8QgBz3uEpolHJ6dpOGqS228eNcg+2K96pUDY23jZIVwKaxeMEGAqQ6Ct6CWhLGPjCOO7czbyfTfN7/Mw4dFG3GzVaP5SCDG1IR+WsFwXS3hA2xn45U6WYKU2D43KO/YY0NBmj5hy99ksj+fitFFqoxfRfAzb5x7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=Y2hztTB9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88cdb27571eso143996339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1758549488; x=1759154288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qP87JigH9w3cESkF8N5cnJLXmDva7bVQRI9ZccgkIPo=;
        b=Y2hztTB935k9lh3Mv7EhIMt0zzVUJp9+prmYfn6nF5e3fqvOxqNAnE6niyqRDa/l4b
         aYFiQNRGFYR49OZSHFukU+AqKgVp/KRwRb7h2eHfzHqCkXpiyX5T5vrf3sKWgw3NJr8a
         e2zGZzkVl1LWRyhtcckmbYC0ZAN7/2hz/WLz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758549488; x=1759154288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP87JigH9w3cESkF8N5cnJLXmDva7bVQRI9ZccgkIPo=;
        b=iu5dedauxvNhq+E0qhK5Wo3VbhqVOeE2qVm2RD5Shc7am8nvapufoA5aty0LTTryXh
         WtN/kZ8lMM7KPD29x0PV4XnlqBev64MXcIoJA/XTcIghpMGvxLQDVSuffZXIbO9UFHMB
         WuTsKX5OcmUVftdBnVT7xnhg57wAAubcIAife26GB55nGVKIMEHCeVRDkGul0ZRIHYp0
         qVNZU90C/mzpFgMSgGL9nbO844nXm1ODfIC12sQV29DXfJ04sBLLjoyN9GtKkgCwFcgp
         ZHBxbihT6gMUnszPr4EoYaJHGMeSXx64/Qu/pY4C1L6Xh0gow/Wyhldcevubl8s44RWL
         o9nA==
X-Forwarded-Encrypted: i=1; AJvYcCXJX3pTc16EPAEcfqCUI5zcyF1bqreLbPjvRBPPeUPMAzfeCPKjXdT7eMvsMH8Eg287qosVqgiokyOgMpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFWzp9Fcvo1BmGc3gNPSh+EkyiO2XYrv/Xk/+L21gq/rqpY3tY
	wtw0yk42qnsiBe/1zVQTh9DTTu+nGdzfnozkBQoJsAlyMa5PNDRgBv6zAHEIvg2WkIs=
X-Gm-Gg: ASbGncsYmhFJiqQPBTNv1Cd4Nw8tYzMywMPT7Y1KtWMzDxHFp1KMn8XET/uvZpfYgc5
	8nFrEZnCyMML/TfdjDgUFO4mmqslrDJwdYoFgbVwAAkrYhcI1PEbTzkm8AoZFy6m00geowLVnGu
	dbb4/b0dEcCUOowzbEWnCw2cwQlXKm5yrBV0yc6yC0AwwnreaLUH9xnjTX8NXLDie2j406AkkOi
	4ij8nZxd50bBEP0hZ7omrlLj8r5i1BmTg5o9bzd8RyKqmqMbEuKrq8j+PDdbhNACZaEe4tyve8z
	mY9kq4q2Kd8kHGwyaCzRAOuCBb9ytwT2UYGPlYf/Pn5bKs+WFyND3j6u1ehA5KhvaXHqAtaoTvv
	/04Xc9RkzE35JN27WGiG70bUSglc1s9sa4PT42zTBldMGQ+YwSlitHOOd
X-Google-Smtp-Source: AGHT+IH8EMB15PYxcBuPL2NYgVxhRe138NFMfR7r961S2ZQFsxef2uERidjsotlvIOx9aFYgUCCKjQ==
X-Received: by 2002:a05:6602:154a:b0:8de:1f2a:8367 with SMTP id ca18e2360f4ac-8de1f490876mr14201839f.19.1758549487477;
        Mon, 22 Sep 2025 06:58:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8d7f8f481bfsm31892439f.24.2025.09.22.06.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:58:06 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:58:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 1/2] scripts/make_fit: Support an initial ramdisk
Message-ID: <20250922135804.GA124814@bill-the-cat>
References: <20250919211000.1045267-1-sjg@chromium.org>
 <9cafbc70-7235-4e49-928c-4d68a57b7d46@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E7czkW5eDIll3KJ9"
Content-Disposition: inline
In-Reply-To: <9cafbc70-7235-4e49-928c-4d68a57b7d46@pengutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett


--E7czkW5eDIll3KJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 09:14:55AM +0200, Ahmad Fatoum wrote:
> Hello Simon,
>=20
> On 19.09.25 23:09, Simon Glass wrote:
> > FIT (Flat Image Tree) allows an ramdisk to be included in each
> > configuration. Add support for this to the script.
> >=20
> > This feature is not available via 'make image.fit' since the ramdisk
> > likely needs to be built separately anyway, e.g. using modules from
> > the kernel build.
>=20
> AFAIK the kernel supports multiple concatenated separately compressed
> initramfs just fine, so it may still be useful to add a target which
> builds a cpio with all modules inside and the rest can be then
> concatenated.
>=20
> What do you think?
>=20
> > +        fsw.property_string('compression', args.compress)
>=20
> compression should be none as the kernel would take of decompression.
>=20
> Both U-Boot and barebox should warn about ramdisk compression property
> that is !=3D "none".

Agreed. In U-Boot we've been handling this correctly since:

commit bddd985734653c366c8da073650930fb2e9b5003
Author: Julius Werner <jwerner@chromium.org>
Date:   Fri Aug 2 15:52:28 2019 -0700

    fit: Do not automatically decompress ramdisk images
   =20
    The Linux ramdisk should always be decompressed by the kernel itself,
    not by U-Boot. Therefore, the 'compression' node in the FIT image should
    always be set to "none" for ramdisk images, since the only point of
    using that node is if you want U-Boot to do the decompression itself.
   =20
    Yet some systems populate the node to the compression algorithm used by
    the kernel instead. This used to be ignored, but now that we support
    decompression of all image types it becomes a problem. Since ramdisks
    should never be decompressed by U-Boot anyway, this patch adds a special
    exception for them to avoid these issues. Still, setting the
    'compression' node like that is wrong in the first place, so we still
    want to print out a warning so that third-party distributions doing this
    can notice and fix it.
   =20
    Signed-off-by: Julius Werner <jwerner@chromium.org>
    Reviewed-by: Heiko Schocher <hs@denx.de>
    Tested-by: Heiko Schocher <hs@denx.de>
    Reviewed-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>

--=20
Tom

--E7czkW5eDIll3KJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNFV6AAKCRAr4qD1Cr/k
CnGjAQD/vmuAq3ofEv1kMg56vhno1TytM3a+z+O5XKpKGYMIWQD/QQs0y0YpQT9i
kJycivHT7DiRwR+v9g47p3ibeMyePQo=
=Fyyb
-----END PGP SIGNATURE-----

--E7czkW5eDIll3KJ9--

