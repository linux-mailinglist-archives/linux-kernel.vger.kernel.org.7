Return-Path: <linux-kernel+bounces-861960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 840ECBF421E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DA683413A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCB11CDFCA;
	Tue, 21 Oct 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQZ35ovK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBD17736
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005871; cv=none; b=Bas1BhelmgrI9ToGnXJM+z4u6GpIMwsCsZPuxC3THim8eI9SXVt429WWzsZSi9qQJTXdnf4MuC/h9J2AWgkHGwSFqBfAwoaEIsP8xDDhH5PaUfSlNyyY+tR/IlaU1OSB9yfeclzAWNs2ldl6gouxTFXYLn92MFQV53DviEBjEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005871; c=relaxed/simple;
	bh=vFA5jWjJwG3KGfKV3NylgtBNOpUzMJeaJAuNwrifEf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtRt8KbNgObYTfLqtDazT32g66JPMRKvuO0QXzD+r8+rFQkGzzgD22usVEpgmKPdH8p6gEw0mt3NfzxemhashcR2ln2HqxbeaV6lVDBF2tHcaUiNeEfZqTfk5ew+fA2zX3f4e2tHMVw80eNgE/EiIYis7Bgt69dpLsENNGvxrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQZ35ovK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7841da939deso4616883b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761005869; x=1761610669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0k2HQYaXzdk1lCw7ANhIJpf6VwtFRwHqSy2iFVshPF4=;
        b=XQZ35ovKbtFv10dM1xiwElksah3Sa8SWTq2nXAnYRFWLxCm0Z45KDHZ+apOYxNky6G
         t4O78JWNzv+3eFsPxUbF6E0wcGWWqobJFxRVHkwvKUIuEurYCqvr6SopmgEsRhcW9Sf0
         iMOzNzJ8KruYe7SL0ic/3p92epng4ei6ZrRvjHfsGZYGwcEIFM3WOLP/Hjw8kcSnO9+m
         rFAzVfdfFRCuOK2MnX2k9p3bwdKwrMGKjRRkek01iUrOkSjuHFnsqqkPUtahcQUsz05Q
         Usq0LYFAjzJ7OnxmZ/0GVEl1R9Sju5wapOt/Zo/cjRtBp7e8I2uXT34hjZGFta201v+A
         ZGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005869; x=1761610669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k2HQYaXzdk1lCw7ANhIJpf6VwtFRwHqSy2iFVshPF4=;
        b=gHVZehnILV0shPvZ4iFUysKlUaH+QHkCtsRXNiQ3VGMRNgBdRnVhZhAr64OyYlR9QU
         XAU8dNiVRGShOqhL0MMrhWQCjGKc9r0v5JNdVFZTcIpjQtMvuUfVF9ZWDVrXoyZRQNHN
         56+2QgZyi/0YBkYzCLmpzwSJKLk8pcGlxkGssge3wcUB5y/3J8GIjqRt18a82SJcZHMf
         mxuuestKwVLXUzPflEQHjSTDPqas1TxtOENcZ8J/OcTgSuUkGJ3lUK3kF4SnSqcXVglU
         5pAKRlMNCNN0aCnXEQbSf6Tm/RWRxYYm8sZjiNan+bbN4bZ/7OAScEm8T9sCl+8pAwna
         1phg==
X-Forwarded-Encrypted: i=1; AJvYcCUHzgl8Se8NwzRxYzFT+Jd5HVZP5boyk8OYN1SB9SarGPe71cy1Me1U4R+T6JQZCalrLi6oEiP1nlsgw64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60td1gheDZp2fm0XPpdsOtTBV/SvWBbCj+Q49SooRmgE8/dBn
	d5MNTpMSgguEXBJ4kYiAorY5ddw9eMSmC+tcTkwoDr4xrdE4j8ADDI1z
X-Gm-Gg: ASbGnctFmF5Cy7FuFuZW+zM68AzjQDJAzZVjNtB3uZjF+KHNHVF9ZGpOW6Shu7IPpXp
	TiTkKXEvKuRwKtcyQYd67J58MYuaBri+HFdI6i/3NkpMxMaygcO+XPWNQYBnICJF8OSs1Tw1jEp
	z+SYEiH3tSBPpKCpKdjiBix6Y/cq0u5i22rqttBkltsMnOaRQiHkDk45I2q5Gu+nuspKYF1/NiU
	Dh42BgbAAgOujhmJEvf60PCplux7R6UIKhtwco+XFeuHf1LdV3GhjqJPLr528DOnBVwaEshzlDc
	5HhkBEMy7P9ISK6Qv30+yRT/XHfKkvUTZGqwBfpVhaXOT32GusxnurKpHqC0nHU6/7rZdgkpZAr
	oCkNZxa07+xFeOwYIuEjrUpAgC1ApOnqR4LY792HSj6hbL9I9C5pa7KTOU1fZ99CLSzoUZIbwOV
	F+XGSbBwB1JoddHQ==
X-Google-Smtp-Source: AGHT+IFq++y4W80Ih2jHmrfYp10BD40l7TzjNSqxSnI9I0d7jWklXwTwil0r3CdzGN6TUJib1z/iKA==
X-Received: by 2002:a05:6a00:9508:b0:781:2272:b704 with SMTP id d2e1a72fcca58-7a2208fcf14mr19313733b3a.5.1761005868811;
        Mon, 20 Oct 2025 17:17:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm9532381b3a.22.2025.10.20.17.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:17:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EE0BF412B0A6; Tue, 21 Oct 2025 07:17:45 +0700 (WIB)
Date: Tue, 21 Oct 2025 07:17:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <aPbRKScRgkxUDYew@archie.me>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ur+dtA2G+9wRct2L"
Content-Disposition: inline
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>


--ur+dtA2G+9wRct2L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:07:38AM +0900, Namjae Jeon wrote:
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can you write the documentation at least in
Documentation/filesystems/ntfsplus.rst?

=20
> - Journaling support:
>    ntfs3 does not provide full journaling support. It only implement jour=
nal
>    replay[4], which in our testing did not function correctly. My next ta=
sk
>    after upstreaming will be to add full journal support to ntfsplus.

What's the plan for journaling? Mirroring the Windows implementation AFAIK?

For the timeline: I guess you plan to submit journaling patches right after
ntfsplus is merged (at least applied to the filesystem tree or direct PR to
Linus), or would it be done for the subsequent release cycle (6.n+1)?

Regarding stability: As it is a new filesystem, shouldn't it be marked
experimental (and be stabilized for a few cycles) first?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ur+dtA2G+9wRct2L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPbRJAAKCRD2uYlJVVFO
o4fLAQC9ziCngS89WuEfqTocrRXlfW6dZ4CSfXOgRPLqmBXt8wD9ESIhxlphKnHL
WSd7sZPRU/pLFxr2Jyn+0gNvGzkDCQk=
=zCxj
-----END PGP SIGNATURE-----

--ur+dtA2G+9wRct2L--

