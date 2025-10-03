Return-Path: <linux-kernel+bounces-841388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAABB72D5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19724A03DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB223504B;
	Fri,  3 Oct 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMZ8Thfo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1E2AF1B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759501627; cv=none; b=JO4/pDsQOEwl9Wy+OzEiG+xQXMfq1ZBABOpSgNXTvGAW3L2CEcXiaKC5dfaLmcVHNS2QQemdLrtyqhZG9SlOftuj/J7bzaLbCYaXo5uaoAnZcaecuHvVghfEdSe2ZnTJLMkpnS08h7JrM0YBmxmxuHae+gb/wAYTbfL/GQaPc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759501627; c=relaxed/simple;
	bh=nr9X6FKWlufDJmWG56v4EBlRffFdXU/0gJIMya1XzSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNxPyWZ7G+jS7pInXmUyMLkkIiF2g3D9f0cp53MKmGoYJtb0mrhpCx28DlznW7YgTmuDCct5bL48OkytaTMYQOER1ws+K8ZGI2JQg7yUSFmX4j2hOtFhQCjAI5MlcrVji+qMGZyJM8SwORXz9j79GMsXG+N112pTbHF9TR/ypCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMZ8Thfo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27edcbcd158so29913335ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759501625; x=1760106425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nr9X6FKWlufDJmWG56v4EBlRffFdXU/0gJIMya1XzSE=;
        b=YMZ8ThfonpE3sNI9tEj3ohlrdbXYDM0UL3LnibAPfv9uRyK9PRc0BqwVI9Qy7PNmQx
         TikUiRmZ2rHiMcXXNS2bjQwX+r+nn5i2S2wc7pfobfF65++DFeJR+EmzCqDMYTKFN2uE
         fEpwiVFLBjdazcy9WcaJsNKiqGNPVB0zWJhx5DfK23/oKZC9ZIfGhYBP4a4eTJ8h1H+o
         OW1uvEnaOauZiSjKNJRjqaxhUn9J6KVaD33XzUGKyftD+faiuc6A6ZgXeanC9HEh1q/A
         oYkygTsyKFXrEg93/c5GBNUwm5AjN5vXhA2CGbZ6sBllz63RgKbEAZn1XbVkj/yAQwCG
         v9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759501625; x=1760106425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr9X6FKWlufDJmWG56v4EBlRffFdXU/0gJIMya1XzSE=;
        b=eCyIw4NBe0iX8nIKdl0xYlpfumWwE/xncFbA+3EeSlidj/8pVgot9uAxPYWTC735gT
         nZu2ZjDXn/iKF4Z9L5lnpBVshCG4EreLb3jh2R3t+ap45XicIB+2Acbs3akSu7uMEZO7
         9JY7/pd4qMr//+n8eUeT08mzwMzuUbmLNTA6smtz6eSOklm0ENU65+Ri6uRom/rBVsI+
         OmiT09C9dk1H41Sdec6TkXUGtL/PTBsBPwpeE2afsg3WpdhpQSB2Pxchw1xZUfx5fOQU
         9yF2MM7gCWbzYl3UQy6LB0hI/xx3sYGOJrNoGhcXCdZBaSDsHafor6ySO4gaa6AOExjU
         nRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUEl/JQ4je6Kj11YP0xb7Xlf2sUPt0pJkOmYyfzKJ939z9m+BulUcMCwzRlr+J3RrZFO5px+bF8sIjHcDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J9dgl/grueeBKOMfYZJjzCAVfNnd/cOIpFBLyzi6IthHanft
	ZRvkiVfXQD8wrlFmADCOAhodc5sFw56JK1Vh95q45Sq34UXJAgRkC5kC
X-Gm-Gg: ASbGnctMAP/44Wqg+IeUfhhAGUJ78b6sUWI64NzNM27/fMO/COczmMyZvWIDCksJS0g
	Fz6IbqyWFLCXdYYwsHPOnWl0+kTSibav0VNQIk86Nh6Hn62RnoGQdcaJTHup+uDAplE2cfz3OCK
	DT+uXNUFIjfrthoAn80QuJhRpnO2WdbV1uiUS7vMda9EN/PRXJ6RK1qvqxr6X4A2WHoH8WzJS33
	rg4cyN7YfVWlhzKdEflZhB/GwUAFmyUzwJzxob6utAAo/m79SjT31Hfs+TB0U28jpb2Vzhs5Cxg
	iTivhsngvFVaihL7Cv+f/Q/1A2z9Ajo29uMLVKkAnKQlkR9qqug8k5uW+lbuhZQpknwDPLIj6Nr
	y5KNZX0Yay/UJcd17dR6doFsXvheFIE0OsADL+hEmfwEPAyVSmA==
X-Google-Smtp-Source: AGHT+IHy64D4Ksfh4et5sm9wJxuRHJC+w8F4lzSiShR3Mpq9ZsO5wcXCG40jHNmvsYuyoMhEMJ49Pw==
X-Received: by 2002:a17:902:ce88:b0:28d:18d3:46cb with SMTP id d9443c01a7336-28e9a54660fmr32869215ad.20.1759501623851;
        Fri, 03 Oct 2025 07:27:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5358sm51793565ad.103.2025.10.03.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:27:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 37CE04233431; Fri, 03 Oct 2025 21:26:54 +0700 (WIB)
Date: Fri, 3 Oct 2025 21:26:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Issue in Kernel docs / Admin Guide / SysRq
Message-ID: <aN_dLVPkwvxGM9R1@archie.me>
References: <7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NEpccGRzVAYWyfhV"
Content-Disposition: inline
In-Reply-To: <7ca05672-dc20-413f-a923-f77ce0a9d307@anselmschueler.com>


--NEpccGRzVAYWyfhV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 02:32:57PM +0200, Anselm Sch=C3=BCler wrote:
> I=E2=80=99m writing here because I don=E2=80=99t know where to find Kerne=
l docs
> (https://docs.kernel.org/) sources and submit patches.
>=20

It's in Documentation/ directory of kernel sources.

If you want to send docs patches, please read
Documentation/process/submitting-patches.rst for how to submit them and make
sure to Cc: linux-doc@vger.kernel.org.

> The page =E2=80=9CLinux Magic System Request Key Hacks=E2=80=9D
> (https://docs.kernel.org/admin-guide/sysrq.html) says this:
>=20
> =E2=80=9CWrite a single character to /proc/sysrq-trigger. Only the first =
character
> is processed, the rest of the string is ignored. However, it is not
> recommended to write any extra characters as the behavior is undefined and
> might change in the future versions. E.g.:
> =C2=A0 =C2=A0 echo t > /proc/sysrq-trigger=E2=80=9D

I think that the second sentence refers to writing subsequent characters in
this context.

>=20
> I interpret the command as a suggestion of how to properly use
> /proc/sysrq-trigger, and not as an example of what not to do, and I belie=
ve
> many will share this interpretation. The command as listed will write TWO
> characters to /proc/sysrq-trigger.
>=20
> Either the behaviour of ignoring \n should be codified and explicitly
> supported or this section should be changed.
>=20

See commit 39ff20f5fd4481 ("/proc/sysrq-trigger: accept multiple keys at
once").

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--NEpccGRzVAYWyfhV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaN/dKAAKCRD2uYlJVVFO
o9BkAQDgvUKKHvPahn4XA7QFvX9fXWeDV/sJtftcEbTPtzBgkAEAsV1Hqu83m10w
ltFcQ65RHOzQDSGS7QGEgyVCiMfaxQU=
=SRxw
-----END PGP SIGNATURE-----

--NEpccGRzVAYWyfhV--

