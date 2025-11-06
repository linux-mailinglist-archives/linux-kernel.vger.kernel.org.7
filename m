Return-Path: <linux-kernel+bounces-888320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389DCC3A786
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD4C1A475C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FE2ED844;
	Thu,  6 Nov 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1SFhVMm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8A2D9EEA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427438; cv=none; b=O1DdgofrbTvFhqoLmdut10SVs5PLRMamJ2tUZdfnDyOy/taEV1QejthrVUeUix7ud0paT+iXHC6lHN+Sdoyoyta9DgaGKwbVcyJDVZwY9KnQK2AsNfXGV2l7wPEFJgioM9UMVHIgoOYc8kvgpr/UY4hPpv96tBkn+q7PU6OeH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427438; c=relaxed/simple;
	bh=2HOJE+HVsVq4jDi0RFJp+8lGPaPymLnBxCpDhoqIT6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJdHEi4JKp9zLhIhyBtHyCrEe1egpYn+unAeheBtpcaimpfo6N/QfayP0QAmh8qh0v0mxd5x1IK3tMkESz/mdrQNONdBHGDfLZguJE4pvm4TXNcAWpMoliDVWPG1x+qBUcOJW8oDzXVyZ1cxbKKUl8DxIC+YHALH0oKqgaHLBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1SFhVMm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso1405029a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427435; x=1763032235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HOJE+HVsVq4jDi0RFJp+8lGPaPymLnBxCpDhoqIT6Q=;
        b=m1SFhVMmac9yBKFzexdaGJugKMrS3f/YSgJ28D0duZ5cUldc2Dasj6NkCLEA0udMVj
         Y4Ekb1kBgyW5kyxoFC2zvg822dtF19YIbD6SB3PDDZzIYC51MKactgy6MlLzv9apdDYV
         1HjVYizlhr3USF99gmiL32T0koaEOin81xJDhlHp6X27mfjox5hBHMv59y1suF6DI+TF
         60FNcDyejT7FSgBlIQwp9f9adS3nOhte4efrJ9N3HafZqY4axxg1X9G5gpHUyIEJk+eT
         GWj2Z3phVhLBBVGcGOGqP/i07mWBmPVpJER1ASRWVpwnuZxUGU/GNf7Ex/D+k7xC0X5g
         sWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427435; x=1763032235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HOJE+HVsVq4jDi0RFJp+8lGPaPymLnBxCpDhoqIT6Q=;
        b=JKK5BXwi6Jn6LyoomNy9vMbDSFcl8XyGnsseMQg5l/NnCaroCx8SLp9y0bCEcZn0Pf
         2Rt+1K4xgH/LnUg1JXQxPd9qw7ExUz0SXVpsUzaHepoIPCFQVQwj7QRsMhQznSrtWblF
         fEFQQPsu6eZuZ0V2GZ0C3nlJrV5fFs6kWqTc+fPpQBqgn/FpHyVHKdeTpR+Oej69e+5T
         0NaC5/1uG1UVCgHdI8Tq9GCZTzuXHUJoldA42z35fzSWI7hPrFZuP3nE9PaA7xNF64h3
         oiQG6lQSAyLFlAYgJ/n0AUB17nUtnqNCIAqxfOWWDW5EWx1erc7lD4IrBg9DWyGwswtX
         otVA==
X-Gm-Message-State: AOJu0YxhQrVnQJH5OjbGaPg3W4H4PpWUGVKKPKdgHPh3OI+oWbZBpChz
	EWgPEAodLkwWYEsT/AGM9LsLUtKv4ek6QZuhPJQxBzCNUaW4QZWzbWK3
X-Gm-Gg: ASbGncsyulH47sJN2+Oy/rGcR5EKleAOPcnrluy5A0THsamiE8fJm0qbTx4brpPH9+p
	O2DUo9mGIIQ1/FpyZ8YOcnKhvrrRu3tyYEVXL2VoPtQOeYtuvAXZFjvEKB/ik9LYDT9wvPjlxKV
	yQiWvT4w5Oq9KHpKxNSe/nXQVdNFtImr4/vlDrSUTBAkf4O2qBmpgfD5D3TcqY5Z/1PDhPctxT9
	ztLHCFm8iZZLFMfbTEmeqwBmCtdnX7ZRW7Tl2Hk68bgbju4rHpBEXvNoipzHtAqh+sUL0TXsiZn
	pso7E636HqldPjVNoOvCtqP0xwJwqFaK40IeeON/IBGorse5r5no0dvKBHRn/n4198J/zMO6cHH
	lFn1CORzCPMg6cSZVAjpj9KgP+/+OMubpkO6v+Mbn1OMpr3HiUIzSbLDMhffV63hV4ZZW8lNTzs
	zm
X-Google-Smtp-Source: AGHT+IGaxhluR1EdJp1LK95NPfDa80lJF7xKFLk2zAG333TwyEnCysl7N+wlyZkybqLt0nbS4usvag==
X-Received: by 2002:a05:6402:40c1:b0:63c:2e3:6cb with SMTP id 4fb4d7f45d1cf-64105a578f4mr6255036a12.26.1762427435349;
        Thu, 06 Nov 2025 03:10:35 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm1578811a12.33.2025.11.06.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:10:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 09CA5420A685; Thu, 06 Nov 2025 18:10:26 +0700 (WIB)
Date: Thu, 6 Nov 2025 18:10:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux RISC-V <linux-riscv@lists.infradead.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Albert Ou from riscv
Message-ID: <aQyCIoipfejuaONp@archie.me>
References: <20251031112702.41271-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fZuX68Rtq6BKZVir"
Content-Disposition: inline
In-Reply-To: <20251031112702.41271-2-bagasdotme@gmail.com>


--fZuX68Rtq6BKZVir
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 06:27:03PM +0700, Bagas Sanjaya wrote:
> From: Charlie Jenkins <charlie@rivosinc.com>
>=20
> Albert is not an active maintainer (he only posted on LKML three times
> in 2019 [1]) and his inbox rejects all emails. Remove him from the
> maintainer's list to put an end to everybody who interacts with the
> riscv linux mailing list from getting spammed with rejection emails.
=20
review ping

--fZuX68Rtq6BKZVir
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQyCHwAKCRD2uYlJVVFO
o5FvAP4kSjGOvT4bALDy0P/jnLCWzceZqua2ANQSbtHWsEukQQD/YV69wA7u3yzr
jL/3ST0vq9rRs7f0XoYiCac68VBUMgo=
=CRee
-----END PGP SIGNATURE-----

--fZuX68Rtq6BKZVir--

