Return-Path: <linux-kernel+bounces-893299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21AC470CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AE43A570E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72B3112DD;
	Mon, 10 Nov 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bnwUw4s4"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDC30C609
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782617; cv=none; b=ZTHt4TzmEW3nMejlvcp3t5Kr4RRz5ExMhd1Ow5Mrhm5Ge2z+1Xv8U2ykoXYFoKLWRL5R9pqu7NJsv+puwQcf0DETG0/typGY/df/hgwAtPLT988mYoGT8MnFkjTschv4tgGF5LxJlu3elb7sEBbCHJyQz4bkWJY8lkha0xn6XDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782617; c=relaxed/simple;
	bh=Z2GcdcHLSBPyJMV4Z1quXuXSj4IHiZox4TXxVh4RwU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcBPQkw8uvnlHZR40FBeenQMaIlsMA149odDCA2vvjeQjNUAgHYVODjCpkXNt21Pc/PVy0nmbuWMuFVoLxm8stpo9sYkMrAH28JTZWbcuev5vXLjQYfgydLZ6sV1D8Tmg01HzoqzdsEIu/xCYa5O/atXY4ON7tNDFNlf1VgsS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bnwUw4s4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso20055395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762782614; x=1763387414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCs1YwS37zjMEsWnDzmEV/JMvwyL1fiKF8eAfxcvVZM=;
        b=bnwUw4s4sThlYanFH58caHNcesysUXuk2S+0Vpgj4pW9LBZQLQBwJ+ViyTca6zvith
         +dUOylNOB7oUfsNfDf/wm22jZB/tG4+feDi8t/RSQCxRuZe5YoW8kFh3CUkqJ/J3x9qa
         iV3x2NrH8ptPvAfqgVucKkGxsyLmSaYp69YSionh1rpwDLixr2AQl+O/U6BJCO05wher
         aWCdJGfSyO8Xc9a3UsEHRiFuFn/fvAfvZVBeQiHSchgPs1FIbHcjHP02tiawRdHUccDg
         aU6H5GbGHNGUsgiVJsAmgsguknYvYehi0EG/J0Vw5HWXNVHBGiqjZ2qVAkdpz3zc8RVx
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762782614; x=1763387414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCs1YwS37zjMEsWnDzmEV/JMvwyL1fiKF8eAfxcvVZM=;
        b=UKsu2FJ/okMzRnAKvXHOmNeY7AVnGxmUqX+PfqDeG8z3Cf0Dj+L2NvxLnQsqyyD2u1
         TyyKlP1JTv849wvuTKT0jB8UUFwg+3soCEhQ3ONAOOm4tMqK0oO4dYOK6kKCueFEaebA
         KSeQ8OVsgNld5W6fYk2PhGlDF5QlVp/CuLyThoG3dY0OsFSs8F3jKEN6YLPNvG7Yip7H
         fazGxbraYgZks5JohEtba7954C6/fRultMoUALn0qxdAfTMmi46LKPa662ewmmIhQ62B
         pWN1lOjVu6/TkE17ZpjqgOBYBQaBNkKrykBz5vHzNsEcubCHcfX6dkG/XZTwvCvQ0LDX
         05sA==
X-Forwarded-Encrypted: i=1; AJvYcCV/MJDNlONt8Liuhb+Tl9cGdXNs/U36p+ET8SezBP3w+wrA1A0nQVFYIBKlJBeHxg6vmPUnhZ48FD+3fl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfPyQTMm++RbRKvWfDXPOxfUrSpSDIrMA09UpXAjRemx6a1DK
	qy8YN9l7ZLgZkbikVhHvTaCEKuuBHXHpDw00qEklfcrGvxQrvCjcI1dcig1JKYle9so=
X-Gm-Gg: ASbGncssgGZSm3VRr2EoeOENNYnzL4vV4ZKyCgUDI63cZ8JAHTI2My+bfm2iNDNjicm
	x8dwSX4YzXBWbhM6FvOthvhcx3BukQfV3gXcP1YBcDgntMrEkCDCtNqc4uGjSNy29PFOeJA1i6M
	6asJAWP7EP9G4R64kUdWAJDnedmWw5tusHS1XfeHeUddLdP73eWEbgv/dXw19JruqlhW4JiD6Lp
	DUO3MMm5UT6mvivXB+qHbre2oPRDjNv+iVkfxBrV/xs+wsxnfe+AJHB6LTbtv7KBdgl3D+LZlM1
	Lz+KBSAynbTmkfA3EGnrNR9MFljJNZAMrniGKsVRft0ALQ9iG4k3HN7+7mQq12Jubjw9rIlpwiw
	qvNJdqbj2Ndc+nX8VgdNAFB1zSooFstvz69ktv64YeTAHXfnrTd/CAuW+CTfOoso5QDCSaa3V7H
	0YAWpzxs3uT3A1X+M+3I8stbDoFZqfrrY=
X-Google-Smtp-Source: AGHT+IFbwuDPMH0i3HrzOH4fQgag2ujLMbEc53k+8Ky8ZYKaeuvXAQUWa6E5cujElbmdZf149UMenA==
X-Received: by 2002:a05:600c:3511:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-4777323ec8fmr52334305e9.16.1762782613605;
        Mon, 10 Nov 2025 05:50:13 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2dd927c9sm15613706f8f.27.2025.11.10.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:50:13 -0800 (PST)
Date: Mon, 10 Nov 2025 14:50:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, joel.granados@kernel.org, 
	jack@suse.cz, laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com, 
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <ewcsz3553cd6ooslgzwbubnbaxwmpd23d2k7pw5s4ckfvbb7sp@dffffjvohz5b>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elrbjxmejfczykla"
Content-Disposition: inline
In-Reply-To: <20251110101948.19277-1-leon.huangfu@shopee.com>


--elrbjxmejfczykla
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
MIME-Version: 1.0

Hello Leon.

On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shope=
e.com> wrote:
> Memory cgroup statistics are updated asynchronously with periodic
> flushing to reduce overhead. The current implementation uses a flush
> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> determining when to aggregate per-CPU memory cgroup statistics. On
> systems with high core counts, this threshold can become very large
> (e.g., 64 * 256 =3D 16,384 on a 256-core system), leading to stale
> statistics when userspace reads memory.stat files.
>=20
> This is particularly problematic for monitoring and management tools
> that rely on reasonably fresh statistics, as they may observe data
> that is thousands of updates out of date.
>=20
> Introduce a new write-only file, memory.stat_refresh, that allows
> userspace to explicitly trigger an immediate flush of memory statistics.

I think it's worth thinking twice when introducing a new file like
this...

> Writing any value to this file forces a synchronous flush via
> __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> descendants, ensuring that subsequent reads of memory.stat and
> memory.numa_stat reflect current data.
>=20
> This approach follows the pattern established by /proc/sys/vm/stat_refresh
> and memory.peak, where the written value is ignored, keeping the
> interface simple and consistent with existing kernel APIs.
>=20
> Usage example:
>   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
>   cat /sys/fs/cgroup/mygroup/memory.stat
>=20
> The feature is available in both cgroup v1 and v2 for consistency.

First, I find the motivation by the testcase (not real world) weak when
considering such an API change (e.g. real world would be confined to
fewer CPUs or there'd be other "traffic" causing flushes making this a
non-issue, we don't know here).

Second, this is open to everyone (non-root) who mkdir's their cgroups.
Then why not make it the default memory.stat behavior? (Tongue-in-cheek,
but [*].)

With this change, we admit the implementation (async flushing) and leak
it to the users which is hard to take back. Why should we continue doing
any implicit in-kernel flushing afterwards?

Next, v1 and v2 haven't been consistent since introduction of v2 (unlike
some other controllers that share code or even cftypes between v1 and
v2). So I'd avoid introducing a new file to V1 API.

When looking for analogies, I admittedly like memory.reclaim's
O_NONBLOCK better (than /proc/sys/vm/stat_refresh). That would be an
argument for flushing by default mentioned abovee [*]).

Also, this undercuts the hooking of rstat flushing into BPF. I think the
attempts were given up too early (I read about the verifier vs
seq_file). Have you tried bypassing bailout from
__mem_cgroup_flush_stats via trace_memcg_flush_stats?


All in all, I'd like to have more backing data on insufficiency of (all
the) rstat optimizations before opening explicit flushes like this
(especially when it's meant to be exposed by BPF already).

Thanks,
Michal



--elrbjxmejfczykla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRHthRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjIDgD8D7HBEqfD01sGDIReAADc
4pTJ2AD2pY2UoeiHwekZY7MA/0iGiNuZJTf1Sq2EA+RVWF9MNs3x64m7LutLmfib
iBcM
=PZ8F
-----END PGP SIGNATURE-----

--elrbjxmejfczykla--

