Return-Path: <linux-kernel+bounces-844904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD8BC3070
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08294E7830
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BA4317D;
	Wed,  8 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOi0Bqlm"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9CD271
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882069; cv=none; b=DwhZ6wKNTbgTJE8RaPS4rqWBULcfNkV8kS7+sOpuUfwOg0+nT03hm7Fe1yC6rFLACsg8f88L4IsKvL+UHDf2neNWM8nDpvhHFCL+dArQezHbXVaQEAk8kCktX6BIXLOlPIoY3noBDuyBr5yGujGSEhurK8smMdlHR1eAszDtchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882069; c=relaxed/simple;
	bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQZg69TTMXfGiGlwDTLVrktBk+Yz/rbZLMWPrW1L8HQZlFOkdE650WEg3++7wg50T8etePTLrPu6U4LDsBzSbAV8NHMvS+RIoBdmX5Dy/0KVe0SZHel7wVmjGBrVykCMYGUhO/5PNe5HQ6NJG12PVZBMZQctFXec4BjjwAQJg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOi0Bqlm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so4224925a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882067; x=1760486867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
        b=eOi0BqlmjnkjpLi/J9aJ/pQHE0cLgHvakbsgbEuQykHg3WX5c1DR9lR9GZqJWid9Sm
         MZhx1AAYqKDTwJyfUPnO1JjLsAX4biK3yHwglKCCgDhujg/eZiTN6MVBrcG9Hzp3LBYW
         9IkYUaarQbtwPaLjueK2MjE2i2qKyveVDNDxeZOMTKRkjbAV/Tqn4e/LU/PEPETgFBUj
         PVS3H9dhVhTd8pzlM9aiOYEBtMm0hesmjXzdslCeYhety78qWJUbubSyab9flXvVISju
         2Sa5FdquNXcVxUWQZb29afckAdkxCWHQ85r9dWs6Cfibm4TcKwOn9v6y1j+DRtbXfJyG
         JAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882067; x=1760486867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4S5DxriXVBDip76PzIYOyJuhXHx4LTL9c53nJwdfoQ=;
        b=LKhw6yt1JmIIc1hsKpQHy+AtRn0Fc2uSyquMsBITxnkHmqsnJavZ8JvR6tks8xyqv1
         i0EVGyG6K6xida7wB4QVv9OGuwMTd4LBJRxL/iTYFSHiFJPoBxGULJCtZMhK3ZlxdRT7
         Il00pG5O0kjStGPfip203ybaoApfVs05T4MZ+ZW8kmy/3UtE9+zpKr3ZF6mVYGpgirK5
         A79syu3Wc9Pch1KkyC1CXrI2SeGSlY2VT9eJ8t5DVkNWoAmPWCgycaptX2HlakxoGATW
         H1T04WSnI/niA60pVMO9ML/8S8cRi7fEdvVr1EFX5F77awmPZH0lM6GmdnDOH4JUa8+l
         UwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXo16ziad7QbEdJF96hdutE7g/yDrs+ia6PX1HUOYnPJckpt2lwroGcfz0OFbrZ0aweEzCFF9txdRPb+v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFflREhnUhqXzAts/d73OZMfCmzTBgR5U4jVH7a1O03O94Z+U
	qCin81NUiNUNcC0xKdE5nsys1tDAl8fk01T5IQwVb7sIcmqLp1KTHAy7
X-Gm-Gg: ASbGncv/g3tu3RXXWVeryrs+tlMS5BXPf8EhNthqwLuOOSvvzEv+J8mwi3EujF4cTDz
	OoZRtVNWHvnpyv20UwpKuFqtEDbQ+OcwD6wOfOcoPyZviY84dRZgVhah1NurhSmB20pZcnTjMVR
	yc9L43UK0pvQw6O5FudE4Y0BjQB5IKzTGhzh+tAM7kAJ+vDmf6uKyeYplR3r3o5eRYZpNtRkbum
	t7D6ySW+mPk80aMI34mxZs9pa58uD0rYNRXHML1WVoWjQ1Yj2yjU44aAcJYSoja5YwsgLkivCnE
	b+XCNheUPK0kDh1E5xmmUujf8Uw4Qx0Rne6VZ7J/tLYUAiWJ8OGwY11xNd1YESg34GwoaedYOq9
	GuNjNBLGPO7mEog4a3Y3FeQLOAqJvjZ5Np65MQ+Sl0qtJ68qs1A==
X-Google-Smtp-Source: AGHT+IFvLrrTtLYc/WdPj/MLYULIodTkELvA/9nEoTpJDQVKXDnFiVL5AgqY4kmgosIYn/DoCBNTOg==
X-Received: by 2002:a17:902:e550:b0:268:15f:8358 with SMTP id d9443c01a7336-29027402ca0mr18266115ad.42.1759882066181;
        Tue, 07 Oct 2025 17:07:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28ea1d99ab1sm140124385ad.9.2025.10.07.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:07:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 262AE4233430; Wed, 08 Oct 2025 07:07:43 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:07:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 3/8] Documentation/rtla: rename
 common_osnoise_description.rst
Message-ID: <aOWrT79N-Pavz-6z@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-4-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v16T4K3LqUohqyO6"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-4-krishnagopi487@gmail.com>


--v16T4K3LqUohqyO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:52AM +0530, Gopi Krishna Menon wrote:
> common_osnoise_description.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_osnoise_description.rst to common_osnoise_description.txt
> to maintain consistency with other common_*.txt files and prevent Sphinx
> from building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--v16T4K3LqUohqyO6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrTgAKCRD2uYlJVVFO
ozVZAQC5CsLiy7sQl+rTtl5xrbElBxWgvxQ21/IMGdTbJfuv9QD/WSnjn7oWG8BK
g6i2dSDUeR5aG7vCmABdR1Qmzhp+ggY=
=skU1
-----END PGP SIGNATURE-----

--v16T4K3LqUohqyO6--

