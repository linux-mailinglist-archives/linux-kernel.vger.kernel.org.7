Return-Path: <linux-kernel+bounces-885702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C91C33B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4538E349FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0F218596;
	Wed,  5 Nov 2025 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM5hKU8q"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E21C84BD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307865; cv=none; b=upDIvUKR4MTTj6F9e2UXQ82v6P4Ta3o94qs4HqQfx+cp2jevE8P1f9OJyuXSTaPYehApRe8drVxLXCz6UlP8Yted8cQShfi1fEsWvdrZZvuLd1jCjuOqtOR7oGOrd+vBnMpBf4SHiC4pr/OIZgcftnYYOgeoAC1u81GGVTj99TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307865; c=relaxed/simple;
	bh=kIBkaG4fXIkzxYJM4+SHpSYNPKawIJMW91gnWOQCLVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZaMbmBxbb7cR/PXukWLO9LIe1m5bKRQj6KhRAUUtFcaeAYjrwBvWI+ek38EQqCs5reMRCKskF/bGg3bUBeKxNcAF+Rh3kyMIumQen334iMwDMqJ8dSVjsEiH+6gWfWu+JvPhTyl6ptGGkAX9IZ6dniR6EunqRv7ByFknMxTgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM5hKU8q; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ade456b6abso616303b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307863; x=1762912663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7QXdXPqYVzaqknJiF4d2FHnRogGGdgrOuALsEYlJt4=;
        b=RM5hKU8q5wGqp44Ozx2wgH4ob6c1Nl6e4CrhKaoNh7M5eRJSF+0+ey7ELWMx4dEDba
         XYEW7xJ8n8virjMCqsjvgh4SGRuN9qtjQIe23nNxHCoqPWbt5VtTXsoeupjv4GNzeDj0
         QAQ+YEp0SeYRGo4K3bIx+P7LvcUYMrk/6FvvEbnuCM3U7w7mD2DuyPO+V6J6KxFtycxp
         5U2QEMHPSBRApBBB9hZX6SjWLIouAaigHoRtAYKD3D8Q93cGM2RJIVdlGTgHULSqWaWo
         SNSt/DR+0ROGBCXA9z2JP6NiGJiUVJGCT4GNT+Z/JJOISFKTwniUsUFDJ0ExTKeOoG/1
         2aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307863; x=1762912663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7QXdXPqYVzaqknJiF4d2FHnRogGGdgrOuALsEYlJt4=;
        b=fKLSjWa0rNU+fSvs4/Io11L2IpeOSTtYqShv3/lKIs5gQNx9FIBp9syaeUt1/Y6IRa
         FwtG6TUvS1OGXqlbyadqMKsSP4kU3PnuLhK9riX/AIjaWIW7tFTYhKIDqdFo8RCU0z3h
         DmjwF23v5lqS93ILjIyrAX8HBygLOiMu4pveKAhJyJLutctyK3wd2hubOqz9PWs5BlR5
         HTc9A6BaUQVvFE7ubZJZWh46deTB7wKBqZ0gvsZ4KZYi4uOmc5L6VaG/UymE52Bnw/zJ
         fH72yKfHY6tAZVSpV3Co43RRgW0c3bVEF2Un3+8Dvsvj6aSTVVOLb2de8VkrC9fzPnh4
         F2TA==
X-Forwarded-Encrypted: i=1; AJvYcCXFLvrpRqzidoxEbLhI/Ojh+BtYrhF7vyFRNIkvIOq+XMJ2BDIt5quYgExKT3bOc/DXI0Eysi/je0r1K+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcunvUjj1cIO65FXh8GZXgTfc/8+HbRiVneCYAVzQmcDj1fuq
	dT24MNnW/buk8OaOGkth74CS0OueAx6aReLHRCrIwb3qyOpxgeXBMd7i
X-Gm-Gg: ASbGncvO1O6rcYdpAx+NSt4yd56OfkqTJwBO60fmO/uWOT3NH05olXhmmsQwTUAZHEz
	QIZ3VIgcyig5ssZchRn2ec8BsvRSjUdRXR1FPd54RYJ1SCzH9E1YerHsK1X6Lil0RvL9Ega3+BY
	XXHiVdUWp9wd8BLPMVFQSMhaUSxbMnNk/AV/otiOtxntT3JDTogW/a380vM0MFf7ZEriXqyjQFj
	k4kSjeRFrysk/kWZpZXU9YEFsmV4f/u46vHmWPm+mL4oKV0cu3jHGsU+rBL06Sz+xamwRwnL/hb
	L2lIMtKtOUAmyVFmKoNtU5PetYnCTQYBUk6w4dZG3Qg7g6U1YYEPrV42iYPY7Wug2HQiNWsd2fk
	qpBSLTI6jyAP1T8FYYO27V8Mt4xNC/c3vE2oTSj1ttkx41U+4excBHkCm7vmlsf5m9P6z0r+7T5
	yD
X-Google-Smtp-Source: AGHT+IFltqwlLw/qoAh/Ic6xf0NjzjzpJGPbTkKnz8JOnOsH+5MlmsP9Q/aB13ieURxS0a35dg2/8A==
X-Received: by 2002:a05:6a20:9183:b0:33e:eb7a:4483 with SMTP id adf61e73a8af0-34f83f113f3mr1764667637.19.1762307863306;
        Tue, 04 Nov 2025 17:57:43 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f7569611sm3804562a12.22.2025.11.04.17.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:57:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6C941420A6A0; Wed, 05 Nov 2025 08:57:38 +0700 (WIB)
Date: Wed, 5 Nov 2025 08:57:38 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary
 Key Certification in Userspace" section
Message-ID: <aQqvEsdoj0El2Dq4@archie.me>
References: <20251104131312.23791-1-bagasdotme@gmail.com>
 <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xcdopG/xTaOcl4jy"
Content-Disposition: inline
In-Reply-To: <50acd6bfbc8b9006bef5d7d0376b7ce4ab35f94c.camel@HansenPartnership.com>


--xcdopG/xTaOcl4jy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 09:55:08AM -0500, James Bottomley wrote:
> On Tue, 2025-11-04 at 20:13 +0700, Bagas Sanjaya wrote:
> > The last section heading in TPM security docs is formatted as title
> > heading instead. As such, it shows up as TPM toctree entry. Demote it
> > to section heading as appropriate.
>=20
> It's supposed to be a separate heading.  It's explaining how to certify
> your booted kernel rather than describing TPM security within the
> kernel.

Should I keep the whole section as-is or should I move it to separate docs?

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--xcdopG/xTaOcl4jy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQqvCwAKCRD2uYlJVVFO
o8AoAQCExGLWsqsoM1i8GHUP+Fgv9X24rbgRfat4KNR1jYRIkgEAv1C61BYGUewY
KxDdWXOniy2ku0+gYvy3bqqF17wYjQ0=
=iC0f
-----END PGP SIGNATURE-----

--xcdopG/xTaOcl4jy--

