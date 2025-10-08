Return-Path: <linux-kernel+bounces-844902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EDBC305E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ED33B9E83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC71400C;
	Wed,  8 Oct 2025 00:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7if866x"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66521D5AA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881704; cv=none; b=X17yWhVd8WmGIo8n26zAUz4iXK4D2KHkMBTT4QjXt21wvPBKjr4/hfvTu6RPJhFRZnX+/HT1a5D3f68jVDF54KbaTBqrqjce156x2RXqid5xssQJibEEL1/nk6+q1JA3XvbaTHO1L/FRJxfX8ED6Jjx7+4zqKahr65Yl6ueNxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881704; c=relaxed/simple;
	bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwjaoMtJ1NfvlGllL4Ibsr2ku2TanzJ/2ruYqpTuMPwiyc/EDdb53LvGqzTCdbKVtIA11HtfJY6vhBiaDZ/DA9/VzGzAC4YULd5Ax5hvKYdxmc5KjvJaAUG/VDdMCrwyVMcB2BnmLkAW4u+C0GzhNg3KUcceGN9UucrkN4eg9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7if866x; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b631b435d59so1163597a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881702; x=1760486502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
        b=k7if866xlxBz3a2XY010yHHPwx70SFZzEx7M0Bb46aROqne5OMbPCUVzNk7HWnWloe
         3iyLSfNPvO+YrEvURbd+i25NvBWNmnwU7bkBQmtMxqj7wN7TNH0Yug7x6j1a+EitbLCZ
         T97ivJy7unowxzc4WY+MOEUOB7zXjEXqxd3K7EJlgRfWR8esxKblt+M2VMOPF0iDgr5d
         zwwLlf4und7btFi+evVnES+xwbOnWOk+EZHkT21fZF/PNGhbyMJ2g4gPPWpjfDIUFf6o
         l5HJd/CvKraAmeJAf7Lu5gfZ7MdczCz02sraYdHxgjAstIoqORlJDAw4zVqBycxrhlcW
         qsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881702; x=1760486502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBmCVEFJbv2kiaRdVBoJHVhH1kJ5GFIYxxjuk93NNyg=;
        b=eGAlmVBtS68yCvmnzMS/P/R0nuibdoz3Cfh2it1KsQHZVWjJJsuqmwm51EQ18lajfn
         WIzyu60ERHIm/vS5OLaut7QnLBS3WJDK27Z7d88fVBd88huTIBeL6zZ6xWKdX0KZz070
         TwmhchaTjfNhjXWHoBJBU9AK9w/3yXidlgzf34poWXE2JbCuEmJVkznj6WvwxGEYYjPd
         ynwKPANBtg3U3fs7TTqrq7oXz2fvQBm4osMpQ91WOuAxBWbCW7BFoB3jup7G9DNeZsA3
         ei7I2ZomEkQzcT7F3TNYiU8xCEQaCn0BCuj2GMaNwyZIe64h/wWFXDgmLHTRalpJ8AGI
         nc4A==
X-Forwarded-Encrypted: i=1; AJvYcCWfodOhyY4hA0CGTdneNs6b4g2GeaNhSUN2A0IBq+gNHXoF9/JAOF6a2XEE3YmZ4qv1yHPsbt5Bj9EHkME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzl4z2GSIrrkWm1i3Im3cXDwYstWwv1bYPTcJPpG6lGJpIH0f/
	MSUxA/DT4AQtLdg6bqXE+FbqhoDh5hsbFw+M57DKX+8U9hFiNGVo2lRg
X-Gm-Gg: ASbGnctkTWXe5z03iro+2E1lLCclOTgWP15wIezBWvOfmJmFUsJFJz/IRwnzsniIK+m
	5zh6JhkLzOPAI4cJu7aT+FW9AidfE53Oyjq853k3zf1KwJwKnFqM4D7ZK7b0X/iTzaSjUnXJ2BG
	yQztDxEYA6NIou1zVCW7vmuyMw1XOASUSDznAEeZe6SqLnsAlGcLAAfdTVYG+A1qhd4owg8VfzT
	pgOn+34Y0uXalkTkIRtjlKCuplBc4KBAXC4ZW75bpw+RQ0uNVZpHqEjUEsqi8AEbobOFo9nYE9g
	nnhRpyps/EvLMUnPVXSNgtc+A7fO9hCb2G3hSKN5bXUm7rx1ir3wKyBon7r0II7pVWESLMRUpmK
	RJ6ca1PMyfSDgsENARb6ON6ulTwU8dc5iK/lMQvOtFv2XpSnTSw==
X-Google-Smtp-Source: AGHT+IHI6SipQj91c1vmLSFiOqIaOwefO3QQs9+bfgg/4mvECMIsZcVKX8SEp5HMEolcaTUK42Latw==
X-Received: by 2002:a17:902:e54a:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-2902741e857mr17501365ad.53.1759881702182;
        Tue, 07 Oct 2025 17:01:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b510ff9a8sm980371a91.8.2025.10.07.17.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:01:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 062764233430; Wed, 08 Oct 2025 07:01:37 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:01:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
Message-ID: <aOWp4RXBN2iayT-p@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-2-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bPrGD7sryDE01aLw"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-2-krishnagopi487@gmail.com>


--bPrGD7sryDE01aLw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:50AM +0530, Gopi Krishna Menon wrote:
> common_appendix.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_appendix.rst to common_appendix.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--bPrGD7sryDE01aLw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWp4QAKCRD2uYlJVVFO
o4OOAP4uFuO1E6ytqdspEZ4WG7emXxflG1kNie6NJqWxpwX+MgD/T4akmHZvTpT/
XIrgErE+u7Ms0xsIdcYEKAqyV9wkKQ4=
=GCZL
-----END PGP SIGNATURE-----

--bPrGD7sryDE01aLw--

