Return-Path: <linux-kernel+bounces-837617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4CBACC54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A681177314
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96EE2343C0;
	Tue, 30 Sep 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AKxD38i0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9223183F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233944; cv=none; b=oNr/k7IIcutAZ+9ZiR3x8/yr5d4CPupyyVttpcQv+82Cmw9WhbplFgSCHWTThmLFo99JMk1rrfTr4yTk1BPifziaFKKiINBDiHCPURulpX5d+JGg8e+GgVR4jOZfHSi1gdvi22wFCHjICktZZNd4sNsMg+UKo+lt/nS5zs8lZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233944; c=relaxed/simple;
	bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+bKytBvOdlLu/B5G+VFJ0qbrRoImJJ/RooGAmiSfO6B2HlbY4OVvfX4eukPG1FUYc3EfWgCUh2CSSrKcykpEjOsrZJjLt76KlVsoEs+aQirRtlTNBYo6QatEzkwQupfbq/N4SEsfotGeHnVLTmKPiBwUvBSEwb2S7hQMaV9ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AKxD38i0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso33674315e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759233940; x=1759838740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
        b=AKxD38i0Q2/tGPsme7jZ1+EbLReWbmxy++hjSikKeQIuaYTCfSyp/7agdBuna7lm5C
         M1JnA+a5m2Iow9RuQZVbDot/h/3IXbX7flg8/WdP2fBCZgFTmYe6A+VxJSdIv7+NN9sp
         DaVnNxBbTjpVPGBHwzSr6i3lF4EHD/NX9Nn9x8NOUg1KJsOae+sHTUj8kfr316s7RoQZ
         aTBCUcAm4NUY1VcZeNkScz4AA4j7DzsMUxK2U690rm12bfPmuphSnpejNJc6qmHLsqFM
         t81qPlTwPIERT+3HJivfqeQi4YhzLBhrUr9pk3IY0uCxcIcvVc9brkuvz7Vb5zIorWbt
         PDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233940; x=1759838740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
        b=ZZ+WsRueiNdurHvHaeH/Ml/2YIczV+f/+YyOFbhN9fWBdwCy8SP3vyAL/ngYpBarCQ
         WAeGyUqs+Md+kvG8/WP6uBFB7VK6KukGEd88uykH4emJvXq6Apms/CHmu68fmLf+TkPy
         9O2fYyU3fpswjBUg+nDbBKS3/g86NT8KLyqL8g1TuAmnFF06ZTy0MIcFCmMRwi2Bj1Z+
         iaSPs9uMdUj4ec1GRHgsmKogccgi5e+KlIBF1R5hgmhD4Tc1OUTWG+CUnjuSTwTukkds
         ZpK2ZriYDCQ4JLE1UicHTrcbxJFCsaG1DkK9OkKJldD/DI+rCnMODLEOTEuobiBrHjDZ
         SZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCQ5vKR7+KH4vDuDPuAK2WnF2TiBFKbiHgKmOzY7KnYhI4w7YAQtj5xh7ZpVgDIdCip66yeB5tRhL3pRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtciAUjCfFvv5/LtVi0Fy9EbQIHJx6WN4CAMlLaavuh4sC/VIE
	6S6UCsYIvyr2jrUhslckavyBF900n2+3YMHqlqdITfTUnPpVKbrJKf8ndW1cH0gTWZ4=
X-Gm-Gg: ASbGncseY9RxprHl9QVSL11+G66rZRn0mplAVpDtkztM7WLYtFPetR9wq9Ex1oJYlrc
	eKKK90lUb1IiitAaXp8ucTz5cBlAsHHSbcGKh3ON2mti4OJTaO7mllhVmGuSd+z6ifyCXUQxrrB
	zLfclH9Z2o/R4QxO+YTTH7mZOLAOz7PSN/3zM+3rakGkaX6BLaYTjXWyxsSxR8ynjso2Wi1oS5e
	b4udCgX235DPAx1DBrDROtYUh91uORI7ohVsnCmwlAYmJTUSQ10mozagIPP4Px4WlziMpOxz8xd
	1F6tQisA6gSkP5nQS/kOv/g9gZ3zX44ZJAcLcsosyMZRgNvxexRLk7nqo49YG1j0LQNmCJFb12p
	wMnKB/N/nWthezbl8UAnsTF+RYQ0n3xwIsR5YmZgBnmMo9KNZLSwuZL5OQ5259bkNJZg=
X-Google-Smtp-Source: AGHT+IFZ76r97SBznLgxVm8yCuTausgRSw7E3S71YyAviZVyfhtqjrZ9q86ZcZJDn4o7nlRc0TwdsA==
X-Received: by 2002:a05:600c:138b:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46e329a0e52mr163822455e9.2.1759233940334;
        Tue, 30 Sep 2025 05:05:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm11443795e9.8.2025.09.30.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:05:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:05:38 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: llong@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
Message-ID: <wpdddawlyxc27fkkkyfwfulq7zjqkxbqqe2upu4irqkcbzptft@jowwnu3yvgvg>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcitis6hrvtt6osy"
Content-Disposition: inline
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>


--fcitis6hrvtt6osy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
MIME-Version: 1.0

Hello Xinchen.

On Tue, Sep 30, 2025 at 09:35:50AM +0000, Cai Xinchen <caixinchen1@huawei.com> wrote:
> I discovered that the DataNode process had requested a large amount
> of page cache. most of the page cache was concentrated in one NUMA node,
> ultimately leading to the exhaustion of memory in that NUMA node.
[...]
> This issue can be resolved by migrating the DataNode into
> a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
> allow it to evenly request memory.

Would it work in your case instead to apply memory.max or apply
MPOL_INTERLEAVE to DataNode process?

In anyway, please see commit 012c419f8d248 ("cgroup/cpuset-v1: Add
deprecation messages to memory_spread_page and memory_spread_slab")
since your patchset would need to touch that place(s) too.

Thanks,
Michal

--fcitis6hrvtt6osy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaNvHkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhT3AD+KHlYLmIxNmdExRmJBIHo
TrWz6vCQ6NdEpP571RS+KR8BAKhTUtg/9ODujOOm6TZW+z9qjjc7ovQYhj0rhduE
upQC
=rm/V
-----END PGP SIGNATURE-----

--fcitis6hrvtt6osy--

