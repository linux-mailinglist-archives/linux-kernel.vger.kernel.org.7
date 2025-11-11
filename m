Return-Path: <linux-kernel+bounces-896242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D8C4FF26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B1D3A953D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0252D2390;
	Tue, 11 Nov 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywMeHg8x"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5223D7DC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898847; cv=none; b=FT6hzrTT0J3Pccek4+jyJyrCqQq2jDm6Y+gw0I8ajFTyLVYnSQ5Mzm/17bwOhKcwtE2cFfUGKuB11BmcGwbGe2oLo5JLyN5+2so5zOYeVShLwB2DPkL9/nmNTLe95aDJSKU0RnO70gayJdSwvGuNG8VIsspwNuJFHE9ggTpkv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898847; c=relaxed/simple;
	bh=mA77ezxgvjZHAoyuf95fl06d018ucEAB+VRi8nNbuB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PH4+rZHq69KRKGn6CazcBf4lPgcqYrhgiNA/PJXmKeLQeqI+pq+JaxOOP6cs6vnMfrRs0fsPenDprxs1gstlrfNWZ5ImuSvwlGOu5/2OHKTmGyk9HgsvMcUkDQcq9EdkKcV1DDzbCWIe6/YA4qxpwBpBwfeG/ggtPXAu8fMeJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywMeHg8x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2980343d9d1so23895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762898846; x=1763503646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R7jKTaSGqnTZ3LxKwc79SSPGy+UT9Qy0Tn1e0OdMfM=;
        b=ywMeHg8xaqewUi7kbLmjvWDp8UOQtR5IDBWcgSmyy8URO7V8V8xo6gIonK5aeaxy2P
         b6DG9UlNAs5cNciCREU3Dr3qZ1LznhSlNWdzTDiomZkR7HlYMBAguuf50q19GfaVOPsn
         EJH08H40BJjNRig4cfXLPEI4ry3DQBG7WfAZTovgbZf4/KQ0rq2q+O2cwlG9l/n5mmPG
         6XEblTnBZRPXC0ZOKeItVWQKMRDbnMztcZ9qcY3/HfJdDzHxkUi5Z/4WAhJJj5SgvbFl
         wmtlCF8/PJoninoc7Jpl0EwnoGAdNvHKJJPbC3SHbkLP+SkX7YbTYnYXz13YdV/IYnai
         pllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762898846; x=1763503646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1R7jKTaSGqnTZ3LxKwc79SSPGy+UT9Qy0Tn1e0OdMfM=;
        b=U6jMy/dZ7mNI+evfxOV68ELqvEnLWALtLiHMdhqGyzAeLaTeeyKX3J2Bm2Ya/gLkbv
         h2XKEMT7cffc0UZmw/GHkF2W4k3gHgQa8/JmP5Gu+S4VzGUagHD/j3IsH8jsIJzzrF9g
         XRsZv4hxB8HcdvQ54WlkKOO6rJ9ihYdBO24gGEPLkJrcj31C0fynR9VCZvQGn6v2hfie
         A+yaQuBVixL3lxX51I2xplfjWo24DTNoIbVZZf/oXRvoirFi/GG36YsRoW8LdfDRq7h0
         PocuLruzV5C23nQOuW0AZYC7L9KZ/U+H7shkzrY+GkiYYOQkHLtasCTdOHwbfTHNNadr
         F3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWal4AOW1Oo+Aie4Ogj/gPvT1l9kWvxATJYDl3sN/mf/L4n9lpEWfzKmRxgCgy9BoevycpbXS9GvNhrSeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6Itc8L/jLotE1gHxwYd2tfpiGQUAfzRTILmG4oUy3MMfECEp
	shshcnFLv+ALskwy+RwK5VONNF1OkI9BVugBaDpxa328prMEKh30zdvq5E/pD0iD2eqCpzRGp02
	4eDgKVoWRaD9eLYFvWKVnykQpJIXr7N6S0MSjO/yx
X-Gm-Gg: ASbGncsF5Wa/6JT204dLrDtftmP4IvOa8CEf1Zy+4eBdWX6K0vZy9kxaTzdOnPFL3wO
	IxapjaPs5KPlwlSh22LMiReJyhdL5yGQdHYg6RSMLg/Vq/3bjvOphBVya5oomtVfyuW8lvRIX9A
	ip8E+bd2tEHy6ze8cZO3aOdV5puJiavh6sZwQelg7GfvuJ/FWiwaNCq9Y0kt4PSku08p+TexYn2
	+ZuMdVu3EsqQCOcT9QquzTnR/XYncPQvVMhxrxZjMtScBFDlEEmNMIVNi5xIBanARMWDGtfeOIe
	/J4nE4G0wbadHUBLuc9ndEpUEA==
X-Google-Smtp-Source: AGHT+IHzO+IaAQ9GVB7SA1mDEjIw9oRS4p66h60UA0TUNbImTXcGAF8bOvtBdB/4pwKG2pyyy+FbEdqJZXYz8yUATmE=
X-Received: by 2002:a17:902:da81:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-2984f828d21mr1387495ad.10.1762898845522; Tue, 11 Nov 2025
 14:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107173150.135037-1-thomas.falcon@intel.com>
In-Reply-To: <20251107173150.135037-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 14:07:14 -0800
X-Gm-Features: AWmQ_bmy0ww8g9aHraErOTrWRxeZ7i1gJoZw_-FbTEmIWdfwQT5lH2BYK10CxHw
Message-ID: <CAP-5=fW0OD1tDnvmFQZ79=JjAri9FS2mT0myDG-C=oMZBGXOSQ@mail.gmail.com>
Subject: Re: [PATCH] perf: write bpf_prog (infos|btfs)_cnt to data file
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:32=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> With commit f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF
> info"), the write_bpf_( prog_info() | btf() ) functions exit
> without writing anything if env->bpf_prog.(infos| btfs)_cnt is zero.
>
> process_bpf_( prog_info() | btf() ), however, still expect a "count"
> value to exist in the data file. If btf information is empty, for
> example, process_bpf_btf will read garbage or some other data as the
> number of btf nodes in the data file. As a result, the data file will
> not be processed correctly.
>
> Instead, write the count to the data file and exit if it is zero.
>
> Fixes: f0d0f978f3f58 ("perf header: Don't write empty BPF/BTF info")
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/header.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index db2ad19fa50d..54968881481c 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1022,12 +1022,9 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>
>         down_read(&env->bpf_progs.lock);
>
> -       if (env->bpf_progs.infos_cnt =3D=3D 0)
> -               goto out;
> -
>         ret =3D do_write(ff, &env->bpf_progs.infos_cnt,
>                        sizeof(env->bpf_progs.infos_cnt));
> -       if (ret < 0)
> +       if (ret < 0 || env->bpf_progs.infos_cnt =3D=3D 0)
>                 goto out;
>
>         root =3D &env->bpf_progs.infos;
> @@ -1067,13 +1064,10 @@ static int write_bpf_btf(struct feat_fd *ff,
>
>         down_read(&env->bpf_progs.lock);
>
> -       if (env->bpf_progs.btfs_cnt =3D=3D 0)
> -               goto out;
> -
>         ret =3D do_write(ff, &env->bpf_progs.btfs_cnt,
>                        sizeof(env->bpf_progs.btfs_cnt));
>
> -       if (ret < 0)
> +       if (ret < 0 || env->bpf_progs.btfs_cnt =3D=3D 0)
>                 goto out;
>
>         root =3D &env->bpf_progs.btfs;
> --
> 2.47.3
>

