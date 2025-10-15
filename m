Return-Path: <linux-kernel+bounces-855379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEDBE10EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB64E60E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF3270542;
	Wed, 15 Oct 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmNo3KLc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D8223DEA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760572608; cv=none; b=gbm9Z3z6psobxAcdvMy4Rux/K7V4YvbqK2i5yDd8jHH091P672eGdGzKL475JelOjQw/hWI7yRRaJnRxwJuwX0XLJTDD+icBe1g+NgcvuLu8xIpaSVd6mOLmfMBDD1zP3wYwc0kHl1qrPiSmWArA0+C76uMPXcdCPO0qvzhSp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760572608; c=relaxed/simple;
	bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2uMzdSltgGSL8RS+3zVca6LWTb64ts3SCfrLIPPif/G6tYDJCAVICuQkEXj2uJ8jaTYe53JcKhjH3kyXVYFt63w2ezgtHdl5HzQr9FtsBvPlYiKeAD1FkCx4ZXV/6F6VsYB+A4HoFW35k2tficax1A4OsI9QzbC/HPmLHpq8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmNo3KLc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso57084a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760572606; x=1761177406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
        b=EmNo3KLchX5BOKY+Gug74htQ8237XXTPl3MyGg0kEITSNrVU8h1+FLzUn28cRCsDPA
         llyHcg+S7CNE7CkiQHold5YA/XgVMZmYq1sIB+nIcBrEtFlnTI5bLbFPQa4a7yTOiZno
         9eAQLi/pTtJRsshVJ262jo7eCXIWorVjq6ADgz0EejBNAko1bw8mztDFN2kvdmFal2Ub
         8fgIYZGor3QsKXjOsrbL5/Hllp/ttwSCO+pv2ImM+sGSRI24e0GouTxd/VEqZiQf9DUh
         Ie6DG8CZ+cehNFLnIRPmYVMVOV4NsS8Vg35M4BxtOSq6eyxvMf37h5ilaE11pSOpO+xM
         bF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760572606; x=1761177406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrdjKA95pfJlziaCm9nOUEwTPMyNUSWxkOAgrsJdVf0=;
        b=GQgmllRyabHOM3Glwm5k0J5uSXcbZx2tyI1LU9qaoWi8BIwb6UQdCpd5Wsx+JN8Ysp
         9WEbwu0wjA/5pOTXF7KJFWbsKxU2avRFNTk61zJCBMsvqdKmEqMAUuYzbw/IitCwX8yT
         J3XFI3Ljr/91s6mO+1tWy0h6Ygu273fPyqWKwTCvuRzVBDQNEPOb9BHRCUot6E+Ak/tj
         Z1AAbEJqSoyFe1RUYO7bIDDCXz2aniq91zd6daeCUcFmRSz6kH5VBtnZ8anRBTfmvrCm
         7gjTQdeAAADV/uec1N266RnNxkM4tf8pYr7DapdFu3a/05vnOEANUcI2Rw0lzBiRL5n/
         ZZCA==
X-Gm-Message-State: AOJu0YzfXIz7a7DzHDXFLTwJzzxe7SOf4IzIeIIxI2eOMS2ZfeHKsGw5
	uFNl9QZiwZZrkvxz2lKU197j6+41oCVhAb2O9XYb2oH0lpsibikbKkmE
X-Gm-Gg: ASbGncvaYDLlGSRRrDT6QFmUVA4JeqotmYBozGNX1LTkEe6KDQy1sRL2nQqBk56zdLP
	WsOsavghCxyOTQnzm5kmFvJcTX9I0bO6ka6mJG7ppAkJQArYTXnqpQ7JsBZiVmIH+r3bVH0Um6l
	Alio22S25CEbJT9KDQD/gdtytpfGIcr9ycGr9LtiqAHGzV6DzIQ1vdK2G56cHRzaMQ7Ck1C7QuC
	KgC8mUodULfEkVHQolUot8FQRNmj5/hFe1Zn/qRaaNybmSnyBL/S/dK0Q7DEf9T3Y03No0t4MxR
	S/ruDPDyMoHxuiME+2MyuITbSAS6FRS8UXq+PgexlaBrvd261drmBTgUeKF2ph5j8iycgF+z1XX
	IW+gwxlcZVLAhG6v2FZ5hsDGMfiK8Oz7VRfU3DMkQruzxukpwJTYqX+mpEB09PUKxmNxfoLT21B
	m2/QutNNYXSK9XxWUdoxRVNLy3
X-Google-Smtp-Source: AGHT+IGSJiLb5NMgZSUQODUANG+2COIewb92cwb9YvRlW3gs67WecUf+O5HmxRj2ud/Z7M+Voe3WDQ==
X-Received: by 2002:a17:902:cf41:b0:267:776b:a315 with SMTP id d9443c01a7336-290272c2019mr363652655ad.32.1760572605763;
        Wed, 15 Oct 2025 16:56:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97878b03sm3872453a91.16.2025.10.15.16.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:56:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 27E53419B28D; Thu, 16 Oct 2025 06:56:42 +0700 (WIB)
Date: Thu, 16 Oct 2025 06:56:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vasudev Kamath <vasudev@copyninja.info>,
	Krishna Kumar <krikku@gmail.com>
Subject: Re: [PATCH net] Documentation: net: net_failover: Separate
 cloud-ifupdown-helper and reattach-vf.sh code blocks marker
Message-ID: <aPA0ucheaqqhuUqb@archie.me>
References: <20251015094502.35854-2-bagasdotme@gmail.com>
 <aO_OPBukiAjmO43g@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwZlaeVNL9Fp5cUU"
Content-Disposition: inline
In-Reply-To: <aO_OPBukiAjmO43g@horms.kernel.org>


--pwZlaeVNL9Fp5cUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 05:39:24PM +0100, Simon Horman wrote:
> Hi Bagas,
>=20
> For the above maybe this is more succinct and intuitive:
>=20
> Debian cloud images::
>=20
> ...

Thanks for the suggestion! I will include it in v2.

--=20
An old man doll... just what I always wanted! - Clara

--pwZlaeVNL9Fp5cUU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPA0tQAKCRD2uYlJVVFO
o4oFAQDBERR//Sh1k48W7RWGnLb3IrKcEpaa2Ru8q8OMSFVD/wEAzCIBRrvx10Ap
XZKRtUoSLGf+YfhBQfKerigKla/hpg0=
=GtTb
-----END PGP SIGNATURE-----

--pwZlaeVNL9Fp5cUU--

