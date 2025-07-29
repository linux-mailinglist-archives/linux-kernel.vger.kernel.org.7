Return-Path: <linux-kernel+bounces-749422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF8B14E19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5265F3B1737
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011815573A;
	Tue, 29 Jul 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM962kHJ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566414D2B7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794480; cv=none; b=f/Eqt1OlsSyYyQp6WPrw0GAlxgJvOpi+GLUktbitT72Ox+TdTYvADBQyiz9PVx3CAP7B3jM2PwWWHRyjk5Z4qm6uN9WEhQ+mhHmYjrwsHC7hhVqW5C1vrYKMa2BnM1gMissEWniWcRNIRyYkBTQykhJiEkrM9FcY0q09yritNBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794480; c=relaxed/simple;
	bh=MBe2c0lwAQ20+tn4Yt0NFFbBlv0wC7hPqoyYxcY01+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHXhbSIXi6fIOamQEFY2Y3D6FUWkMWpKqoORzLsOUlQ7hcQGCc4Q5kRXowyjD50WjWXcVb4kB143Fz/DUA3wEKxxmVJsM4Au80K8YOlF19Xb5vr14s2lMVdm78I8x3YYbXK4fDKFxJO+/TiF6GHOHnvkNfnnNkxWCqX2D4/3vfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nM962kHJ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3321de5c9d3so3349391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753794475; x=1754399275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBe2c0lwAQ20+tn4Yt0NFFbBlv0wC7hPqoyYxcY01+c=;
        b=nM962kHJaBys+F+Axm444iaqEjHo9l39nwAD1iaIW4qbnVTL3iwgk3PszZ6Wtz0V28
         1K38WhdKj5e87ymgh0/FelHdAmk4ZJQvl9q62tJ5RDlnmOSVfNFwVyHcZPFldiBLwhzj
         Rdkfc5zGkXo+sCR2VF+YCvRIBdzmgMuXozxHMGOBn+rJX53qHT4A12k0r16r419el/3p
         dIY5VXkueNo86/UHhLGUZYRZuiNn0uCrpteymbHnNYu/GMu81mj5nIn6OaBnP9667TWY
         MiVk7A0xFW3b56U2CU6X5Xc85v8KIKQg7UDNOEQ55TtpNY3U8AAIRGnExYuP8gspTMPN
         pgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753794475; x=1754399275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBe2c0lwAQ20+tn4Yt0NFFbBlv0wC7hPqoyYxcY01+c=;
        b=Dza/NcazI92GNMec+7zpgFCb4WFcow5YMfjO6SJn3/qtMk3f10+O4uTm9rBhHw4gKq
         INdja36UQ464B+TFcZMRJSCl8wbYYZWi7cprcqpX3+hd+/3tDC8f8cQPJyNzyWWJA6/O
         URJuHeXf8vuCdZ89uOTTQKQ8F2NUyvQyeBF+w8r1EG/bxjKE2vP/2hRrDe6/bDlaJeRW
         3kjG0b7eXOy2VjprYK7MeTeV1Rzx9uSjqCxrpufmegxGKQrmSUlVsqRDWspgToNlCjSg
         x4JX0bqo9f30jSFcx0JvHGPeu0S5N6hhdAwdK8FeEWY6Gq09GawHge+jNyUheoSJhlEo
         gF6A==
X-Forwarded-Encrypted: i=1; AJvYcCWPKwD4Vs6qFObDkqfItPMbTCeyNLsE6YLr4CLwZGGhyA2pzd62ZDG/pvNHS9VkvLDt7LQutftEtgV+Guk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYpE7EA7eZZcIvbueb+PqKUj1Z/uMjvo/HTi3eKJriqDypbCb
	wjnxHfoS46Xq4/P/8BjEHNQi9i0ihR+cGwcN6t7232bJMaKBIS8DHlvn
X-Gm-Gg: ASbGncvExOEImId6ETlCHvcseYpnDRnogHCUPkpOyHjm0289DzQtoP2Hv/A0joSgtcR
	esXUZ7AxpNcHpx+PVhaK4tGljwI88944qcLNBGaVSJwwGrg2FiSIeZwIrpAYSD86Wa7AE7KkHo9
	4GxTy8IsS4YZD6o5QxVzaIrAj+8UWHbNh1gPqv5wPXs3DJbMHmP+L1V708WXSEYsrTSLQI6qcOl
	1LE7yvRlNaqBQ+gWnqOskWOAk+TrZpISuaegBGfD7/MWzha2XKRdWnfjgIJnk7n35geDKG6T9t8
	oC1JLbhppITiVBGTbJt+0OnmFGwMsnY6Xazx2o9r2otWb2EOFDeuITLQWG6u7K5QWchfuDWKsAF
	A0J8E0TYDNzXg3P+G58ob27G6HS3P3BA1B4ZInSR78d6H9f1rxYGBaMk2qik=
X-Google-Smtp-Source: AGHT+IEOLM70tlkReLeYdoB11Jx9OgwXfRo2bd1DL3h+FQZIBragJKJj7iLvkRL8wVB4DF7MiS1gKA==
X-Received: by 2002:a2e:a98a:0:b0:32a:74db:fe73 with SMTP id 38308e7fff4ca-331ee733b68mr57359851fa.28.1753794475059;
        Tue, 29 Jul 2025 06:07:55 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f40a2f3esm16323231fa.34.2025.07.29.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:07:54 -0700 (PDT)
Date: Tue, 29 Jul 2025 15:07:52 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sitronix/st7571-i2c: Remove unneeded semicolon
Message-ID: <aIjHqAB1Kkq6Zino@gmail.com>
References: <20250729042620.2057603-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kNrapcqmsUN3Vipw"
Content-Disposition: inline
In-Reply-To: <20250729042620.2057603-1-nichen@iscas.ac.cn>


--kNrapcqmsUN3Vipw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 12:26:20PM +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>=20

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

--kNrapcqmsUN3Vipw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmiIx6EACgkQiIBOb1ld
UjL9/g//RPodx9Aa1+1YVipIoqc7kS3ym5tzMJIo407F6n0l0yXfK8Obvnm6xxhQ
b68Cjeg0RPG3P8cZM1Qahe6WDa/P+hm0XtbFKbwbuMoqT5TuZtfbGH2M/tUp7z8M
ZxZQG9fpw7k1aZX8VhhqCFi64BIF+TgM/LxFFuUTkRFefc382M7I1hKrIvQZvhTG
RWOqEIVKViY71YuWEfO4y/Y4iS87HofbAWNwZaJA2jDtxjnRFSxXhNAqCLqD2CA9
2Q8a0d1w7M6PbmV5/V6tZmfE8+jB0pkpe4DpY8Sx991P4CDYOXCLsTfm/sqvCfnH
bCpRgJahNEYaMP47MwYYrGDTMzR8qQU4xAKDZrXSpSBkUhr3GGRAze5TucIjuP1e
vSCxMVQWZf+GZRigH3xim0crlNlsFQ/3WA30sdK2I/l1DGI34u+BFSSH0RDaZwJ1
Rhk09kJmgQ1C2mIDwjaLGhgzU6DsvUp2Zh81WKc53tME/wpRCUqQutN+D9Jfrz/q
EW94tq8aZVsuyXKWEyMzrRG3DvajjLZGjJMSeGJn/FG4A2woiaTCBRY/CNb/4j4E
pC2UA38NtcT2O/0UQmKClKYRcdOoH3uxlGTWRMrgbbEOYqESIT03X5wmOcCZoDFN
6bSFdF7vN5ge6/iTepuSdDqQJU0rcLCb9GnyEjflL3J+dIfCpnY=
=FwcT
-----END PGP SIGNATURE-----

--kNrapcqmsUN3Vipw--

