Return-Path: <linux-kernel+bounces-786802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BAFB36AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE7EA025E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D335691D;
	Tue, 26 Aug 2025 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WUIF0PYV"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C5352FFF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218372; cv=none; b=MWSqIA8IVSCpXTxDFTQ91dnaQ6IMzoYZDG0Q3yIpXYWQC1F8X8IAXQflAgfrdgKq5qtSC8hL5OO5Rv6/uscqDzcALl2yziZpfaRus0xsVFjqrLBBkxZJkaKplO8/aARhE2bHHOxaNvhTwOCKIUE7aqN2FEja6A5b9US571WRgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218372; c=relaxed/simple;
	bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrKkY5A0rHAjm/iPA8rVmxMLNiJTZHU3h0O5jmDuNBGqEEbuRExoDiX0IYgfOgE8D0LYAt21ajHcrFqi7+2SoCA7QieqlXeteAsC0Wks5BacHU8DsQFmpNISz7+S44lJZ0I6eC2gYYUIiGyX1iS14U0KI4hoVXL6OKVG7ODLr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WUIF0PYV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so4323939f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218369; x=1756823169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=WUIF0PYVPiP61ALt5gogMALHqiaWz/BjzD7eEHWaUi5ZNbc3CFbkrwCZngCUd5Xrfg
         XtZM/elqZtL9XlkqFYAH+uC+uZqIvP6AG3XI1lXB1LeU9I6InRqAXPE1kJsNrY+L5c7A
         K9kLx/hEmYvQEON37u/5ziS7tZsu4bh50LmRHdhGoUk3YJmf4t2ahz8yGTkbUKSQEIft
         yGnqDCxda1n3nUz2n9noWr4Fqo64+MLCG1gr3yZgErNhQ/KwjD7LUFTzC3k8xiBlzITQ
         gt0ueC0mzs8B3B9W0Fn9nuo1IGQ7c7ejQlfToC0ZKyrVLOeG0/0B6C4KRyuFUwIrAodq
         criQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218369; x=1756823169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9j2PZULGXZHOrc5kNbcezwPm4NZHYRo32d1BVrCjbg=;
        b=OSEYL5y3HYAJRz1YzOFM0kau8NDxGLEKqCZU3NYc0fx6iGhdXnikfD0pkPiCDDAnOb
         GfMxV0B8wdUmYppXYEF3u9gc7c61yjO5ptwzpzBVreGrcgU0qmBt3agS9ZKDiW7Oyi3n
         VQ+NJW5LdAv1+D0ZDVoz7qRNc0S/tbonvirRQh7MyJnFKVPckDLH49C+jHof2aVSAnEW
         45Vj8w88Nn9jgnSc0vwTQeEoM5Gw5mTxhH+G7SQ8iH5uJuaSYIaSrnqdwlMRSUUQJB9D
         YL3aY/wEXnVv3c4IuK0V+9dReq+GmI3v0fY4WzCZNdUJI9adm37b9/uEctEnAY1NFxua
         /86g==
X-Forwarded-Encrypted: i=1; AJvYcCW4vt/gDJK3Ow4nIi1YkWyrzt2VvKb7Qeo3QmbH5ceU0VAIBdZ16Ssso8h6TYljtGWItAZuyitPmlrgl6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi6XvSD4f4SNKw5Q66SJiEwcqP6TVCihVklmDxwI9LyeMW+JE2
	MEXk+kEOBKR/LQvnnT/4P26JjiVF6JeDd5AnQXiI63DEEG04TSMRr4u6nUMGLuJqlW6jcfqZYFE
	skEFg
X-Gm-Gg: ASbGncvnSSbDU7OwDUJcKGFzd1tukeUg4kfS3QsOc58qBQKOvMLzUHDw5jPzGD5kX0d
	mEhCkEl3dDxrPn7dajkGAAUrSWoPFZSEDBd/2bm+gg7lY1vIomtIBR7wQzj7ykHkdaRE66o/0ST
	WR+yKIYn3laWDN+fteZN/kmFal9OCcNX0hL9WHP/eAPBdyu/14c9uFWBbsLwFOux4xM8DKid4W+
	4UvnwwuhAvsEytONLmGigYrMKYunf7bills38ltoGZjots9SgVcs5jgUHc1VZoFJNd/TnI4zgZQ
	hdDpyv4gQObNSS8IG/DBnVhHgLhXuFtq1LfkZHIU28MxvmpUz6QvykI54SY9afPFnbfbEf/Lx5d
	P6R3kJYJjsYcanuFgaF8PeW4h2/UHlVIGMi1r2SkESm4=
X-Google-Smtp-Source: AGHT+IHNuSehu+kC/8JT6eOvIgtP+0NWIiWUAOSb8fB6NxBNImXOnuq9wHCo/AxRrqB9def2TYx5ig==
X-Received: by 2002:a05:6000:40cd:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3c5dcefcf18mr14788726f8f.58.1756218368812;
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880368sm97231965ad.109.2025.08.26.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:26:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:25:55 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Cgroups <cgroups@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, kamalesh.babulal@oracle.com
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
Message-ID: <hyqcffknmjwjuogoe4ynubs3adk47t2iw4urnpjscdgjjivqz7@b5ue6csrs2qt>
References: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23hhozo72xquqq7g"
Content-Disposition: inline
In-Reply-To: <CA+G9fYtktEOzRWohqWpsGegS2PAcYh7qrzAr=jWCxfUMEvVKfQ@mail.gmail.com>


--23hhozo72xquqq7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: next-20250805: ampere: WARNING: kernel/cgroup/cpuset.c:1352 at
 remote_partition_disable
MIME-Version: 1.0

Hi.

On Thu, Aug 07, 2025 at 01:57:34PM +0530, Naresh Kamboju <naresh.kamboju@li=
naro.org> wrote:
> Regressions noticed intermittently on AmpereOne while running selftest
> cgroup testing
> with Linux next-20250805 and earlier seen on next-20250722 tag also.
>=20
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Intermittent
>=20
> First seen on the next-20250722 and after next-20250805.

Naresh, can you determine also the last good revision? That would be
ideal to have some endpoints for bisection. (To look for any interacting
changes that Waiman was getting at.)

Thanks,
Michal

--23hhozo72xquqq7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3D8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjraQEA/sATM9lqrOJV8YGvjMwn
+GWni0VR34BMM7mWvDUzGxEBAJpsvXzuNyDJBDJGhCreK69pFRuLZ5En4BTai+Fu
Oc0F
=Z4+0
-----END PGP SIGNATURE-----

--23hhozo72xquqq7g--

