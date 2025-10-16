Return-Path: <linux-kernel+bounces-855381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77963BE110A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC91F19C18B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FFA13C914;
	Thu, 16 Oct 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLWjhbES"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AC469D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760572918; cv=none; b=szxZ8O/zbhsKP+oXWTpm2MX+wBCzJChtijufZviYfXrmS5CAu+PxdcaBf+JddWvAQZ1P5TvewZkTD4r4aK7BsSKgcA6ICD4iYiT+5bcfn2jgvhrjd5321ptzsL30PoX25b8ZoO3C+yPTriG1tVH4oUICXPcPyeIz0JKpMvmGtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760572918; c=relaxed/simple;
	bh=Zrfi/VMjUvLRNlm3QRjfVIbaOCS5M7RG1lr8DfSwgF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTPaQ0FuEVzxrIkJb7LrlrAOQmeFtSU1r3KRKybeS7dfpA+b/0ZxEHFItMFMZKM4QnJpjE5Y05RYPaeCzNhISD9DR31acXVIMeMl8EhamPd+ITJzj+hk3EY46NC7sgTRpRP/00EaD2G/rnuTs5vCzywPh0DTerfeRD0FEk1Kuw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLWjhbES; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-796f9a8a088so177479b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760572916; x=1761177716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrfi/VMjUvLRNlm3QRjfVIbaOCS5M7RG1lr8DfSwgF4=;
        b=BLWjhbESuViax4jmUHuU1/C5sfslurZOjjWZclg5tojd0F1jYht252vvFgwbY7U9ap
         YrCbOKrE6/TpNU+1+55xeKMyD8Bjeox/WQqAy4W6q88grrFf9j67GENnULSt9cpu/MfP
         JUf6RjKvjEF+bKrwT3dqm2wm2aoWCZ3WJg5V/SkHCaSxqlsqChXjztjlBpaiBBLXW+AX
         oTO5mFZy9U6HO4tjS5saeAfDo+qa4R+Nm39XRK0ujfrzHWU0oblvBBB4HQo1NKvCMOxT
         fMupSb0BMTzkzfjcjM8f0aEMFyduTvyZ25c4S8brvRKMe7BXt1Anpl/9LbjSue+6H+WU
         gEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760572916; x=1761177716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrfi/VMjUvLRNlm3QRjfVIbaOCS5M7RG1lr8DfSwgF4=;
        b=AQ8vxjRjoW+H5wxMqHkCk62WsXC52NowyiavGy/yv+5uaOKyogNor4q7P7ekcbVRzU
         jecr8ftm2Bg5QlnpZjEWCo5twCAf8VAecaPOFy6+dp9NDYlKrxzOccGG3BR4+MHG/pqf
         UIpOv6o+jUo+ysZCxXhVZVkQX1yRcn+e4koQc86AQwB/HKdLYEgFPqgC3VvLp38yeiGd
         pZDxIrLEawGM1qrOqtolb5s1EGJmsAKIrKgMOx5t9KaaOTHJ2EyENpLx8/Rgk5Ee3FbD
         i+hE9Y3YbVVbEyXabzm09n5kkpzf40gA8bLfu6B3JlMEUjwagFyMDKSBVo4eOlIA5xX1
         KyXA==
X-Forwarded-Encrypted: i=1; AJvYcCUZWkTlULde7UbArcQc39OU2/1dZzgjtdM2gXKVBTBhch9/9VonV0g7ycNQjKGCgrgJe6mMPHe/NgsHav8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgbCcX9LPGRzR+NrqdfzJi8Qusb6sp0XuGM0NvoHObQ+ynh7B
	1pWb2vCHzVzMwhrhRPttUvXmSIBy73xqS2qj3zD0iQEuigvmtJS94QbL
X-Gm-Gg: ASbGnctZOS7SCnjC7rReBCLyJ3ZTX5PpRXGgpR5jQFFvrlMQRlZtSsY7AP5HbvNKbn7
	//VhCUUxysAjo91vjh+JKV12goiVgCh71E9XbZ4ZGex5R8Dmy5WzI5Xqk99XslIp5zrTHVbaiZO
	Nm0ZDrC9eqmB3HcY55c1NG0k1n9tFhQ8klkewmK8EWshLWHwS2U1/UeFp50qBnKsJ2fyRWmHDhA
	2I/KEf6pVw+J3mtwUw6sy0/9x6k1c364Jp+eG1aM6zBjA+YUB8TaT6g98OOcbsIDb+fQXy+YJgs
	gz8RYF5nm4ihFDzODKz6rcKz0v4SSaksBrr+9LWv/p7szxxV7gEALywZFsZMLRK5YBKGTqeL/Je
	7sYD7JllETnLhDTRj8/REC6gHPK4jFrczj6E2hX/NRmwy+p2KeUfLImroAHLsKfDHzj52Vp2aP/
	FexPe05YXtM5qeqg==
X-Google-Smtp-Source: AGHT+IHWPFl3wQ4UvDVjKcFZV8JmCaZHewB/K/pGnpEkw5mCOGWpXdamSbh5/nnQLrluiU4qXrWD4A==
X-Received: by 2002:a05:6a20:3d1c:b0:2e8:1c23:5c2d with SMTP id adf61e73a8af0-32da845fde6mr38728255637.50.1760572916459;
        Wed, 15 Oct 2025 17:01:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm20159494b3a.32.2025.10.15.17.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 17:01:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AC288420B701; Thu, 16 Oct 2025 07:01:53 +0700 (WIB)
Date: Thu, 16 Oct 2025 07:01:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, corbet@lwn.net
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] htmldocs: userspace-api/dma-buf-heaps.rst: fix block
 quote warning
Message-ID: <aPA18fxQW398WHte@archie.me>
References: <20251015183402.1649988-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sY9Nki+MnmfjR25j"
Content-Disposition: inline
In-Reply-To: <20251015183402.1649988-1-kriish.sharma2006@gmail.com>


--sY9Nki+MnmfjR25j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 06:34:02PM +0000, Kriish Sharma wrote:
> Fixes: 1fdbb3ff1233 ("Add linux-next specific files for 20251015")

The correct blamed fixes should've been:

Fixes: 507211e3c7a1 ("Documentation: dma-buf: heaps: Add naming guidelines")

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sY9Nki+MnmfjR25j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPA18QAKCRD2uYlJVVFO
o1mRAQD9zW96GC/QMBetvLQDoIrsCo0iDBbnK6vSUvPUFGiJBgEArGkrI0xtSD65
ufBe3Zc3jnfHJR/WnO5dziYq1UDYjQw=
=fHXv
-----END PGP SIGNATURE-----

--sY9Nki+MnmfjR25j--

