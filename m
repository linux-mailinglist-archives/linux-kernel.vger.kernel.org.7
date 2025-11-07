Return-Path: <linux-kernel+bounces-890250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9BC3F9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F6C188FE26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69827EFE9;
	Fri,  7 Nov 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHOmJr5Y"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7731AF1A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513112; cv=none; b=cGrggd9Uk7fs2qsRslyh1RVPJuDQiP6Tl81a0r2TQ7VORdS3wUisX5pW1D8kTcQsAwfv/7v03qmt9/O/nDKKPH6gZrQ/hiItcxU1uRmCwIuOlxqe8lRZj7ymHLwGUWl2UwJCcn4BhmYqC6ehoC7v9rQ5LEf4E1G0OZHlNfoknYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513112; c=relaxed/simple;
	bh=I+1XbG5MKk0JUlX3zpvi5l1EFf07YFs7e7m1N4z3ees=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBKkRWL6tiUxJZAQEgyAE+oSvkQN4aiz+cotXG7D4bxmmEnssddHYqwadYu+Xls48OS9+zRx793M8wnk2SiT3sxfaAKfkq7EwnwKmc/Cc+XZdWnqT/P6AO4gokXY29PdTPM1ZcG0qbvk1SAzxjJjs/xx03H0SmR3kk58yN3T3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHOmJr5Y; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f976ef4bdso539230d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762513110; x=1763117910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DexNAiPrUqW+UF+u1s34KGk1K6Hek62QKMP3UTIAgww=;
        b=HHOmJr5YbduSMDMcPyV92hZutg8fHgjl9xVKaWlKOzBGvQ+9n0RtEV0lL/maJGHznI
         15OeGHfkh0M3BtHnMQ5wem5uFW4l29Oymjoh0d+xbvwNS2ubb2VS4D0Jmf7zBDtDZd8V
         yis/GunYzhpoOABIMc1ibaJH1Zo/NI7Xtngac82oVnhDFO0cwMPJ72gG+lt4KIg+oeWt
         8/VT6pT9tiQDZzsSwMfpH1HS8FSuxlmglsPCYjPcjH9RzkN5JZKJ2GTKhjsOTZfTFOvg
         Iu6nOjU9ImE5JoRhN2PL7qtIOBdCGuUhMcMKHIbOjXnWHJg0c/EPKFWUky9dhoatbGcQ
         JAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513110; x=1763117910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DexNAiPrUqW+UF+u1s34KGk1K6Hek62QKMP3UTIAgww=;
        b=rYuM4y20gxbLQhc1yjYY+fYW6ioebGmoCxYDFggAvLdk6xa6LpF6NZCcwjHPPpNV19
         F+4Ef8hRX5IChda0DGGxqQFgJ1wy18mkVdZ6AaYaYwks6DjK24Atgj59aXcduYefMt7q
         J1BONtDMEFkeBbyLQFdylberOTh1T/UwarReVtOZQFQeGNurowJfZ8orSrNROzkRPRmm
         tm3b096EsKvd4qjyY/wNCzh/O1swKskSP7hAB+9bogoVmA46gFr7iDzq9TDEjwKC+OjV
         4G8QFZiC9tYxgtf8S51qErWRAjtZjAtKqcnfecFSLj4vZSFRqba64ELmzootP/hVhqWu
         5yMg==
X-Forwarded-Encrypted: i=1; AJvYcCUz3y/A+B9mX7VqjV9gr6XNbSSMM+0LCSZsVnOeJon1nRKNoIPsqrW+O9hPNYB3ZHeJjDNzSyv5eKlnFts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS39bj0SEdEtEEAq1CcJ+NtfF+vSN3XcXrgnKQG+8p0idJPa//
	6S9T8pxkDrHQ1/20s3+GCeCX9rfkHh7x0s9tb8YXvPU4bKMC1lnENXFrL/LlKPbx7TU=
X-Gm-Gg: ASbGncvzqfxFHDJN0sszLxTp9usn1cPXItKLm7X6sd0nIaMybXSHYTio1TVVmt7ROxD
	RLU+d8L5p/4mMEale62Vt/nxFm6tzM75YIbPyQVQEekvf+/wPX37cwZw1uKdhEimRTPiPak4JrG
	XVFb2XxZmm2iLNnU6kGG942GA0qkbbK5TeLIfwE6wrB6HzP1o9fo+FZbMKDbgaMobT4T/vAAFXq
	gQFoyYc2jFEiYJlB3zXgx+68o2j8qy+87/4kjvPJOjhAjf0cOogYkVBe/Yu+/iH+Tvi4vXCA7CN
	YI8YDHt2vxmh4mPd5qtnybqB0M6clfpnAwbcj46Qei+iD3esEl7DOfLq1RCaKggV/BgjpSCjlvg
	rtgqvFZSsmNDMXHJfDhIwqFNKAxeZU1cHHlIo8WE5tJeQXUm3mFpyQRaFViIvZnKDJBDGvj8Q7o
	y05FYxYK42LMc=
X-Google-Smtp-Source: AGHT+IEJRldSXfFeXYiKiO8G4I9T3YZohbEK+rJmYtj24ejpVXVcPSIEgmad6H3oZH3lB6Oe138a5Q==
X-Received: by 2002:a53:acd8:0:10b0:63f:bca7:ffb2 with SMTP id 956f58d0204a3-640c42a6a83mr1880057d50.33.1762513109848;
        Fri, 07 Nov 2025 02:58:29 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13f3f9esm16732927b3.15.2025.11.07.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:58:28 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 8278E42BA568; Fri, 07 Nov 2025 17:58:24 +0700 (WIB)
Date: Fri, 7 Nov 2025 17:58:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <aQ3Qz4QuUX1S2her@archie.me>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0+GUtBQGmRh9mhO6"
Content-Disposition: inline
In-Reply-To: <20251105231514.3167738-1-dave.hansen@linux.intel.com>


--0+GUtBQGmRh9mhO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 03:15:14PM -0800, Dave Hansen wrote:
> +Out of Scope
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These guidelines do not apply to tools that make trivial tweaks to
> +preexisting content. Nor do they pertain to AI tooling that helps with
> +menial tasks. Some examples:
> +
> + - Spelling and grammar fix ups, like rephrasing to imperative voice
> + - Typing aids like identifier completion, common boilerplate or
> +   trivial pattern completion
> + - Purely mechanical transformations like variable renaming
> + - Reformatting, like running Lindent, ``clang-format`` or
> +   ``rust-fmt``

Manually fixing checkpatch warnings is also out-of-scope?

Confused...=20

--=20
An old man doll... just what I always wanted! - Clara

--0+GUtBQGmRh9mhO6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaQ3QxwAKCRD2uYlJVVFO
o+6XAP9eIWREFzsvbOkD/DBnyaV5DLANoIwaFQ2na3/vPk+W1gD/ZUT/SJ3y/AR3
lcAHsrSAVDbIMMJ/8Tz37JS6K4zH/w4=
=VU6W
-----END PGP SIGNATURE-----

--0+GUtBQGmRh9mhO6--

