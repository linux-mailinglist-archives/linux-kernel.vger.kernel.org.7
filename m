Return-Path: <linux-kernel+bounces-817259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C65B57FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31DD20839A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BE341648;
	Mon, 15 Sep 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+EMtRhX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62893002A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948479; cv=none; b=daPdgzn6xtzvY7n3spRgUuecDBS0eP5exh/r4zjoE4toVm05BzyWMOTcnZMf42fGoxuIcsguf6d7SirkWYZNoCuCU7F21sLMyaIqlXtfmzQ/lfz96q/0cy+Qz54CeGuYBVmNPTdb3F/U4j2nF4+PC0LnmjOXou+5aoujiJPoqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948479; c=relaxed/simple;
	bh=XNzym3SlW68WTjuaImeS6uxut+Hkf13t1gya8khOoMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aI5ZC/expUfHfaxrzxL7aY17fgzqzXkV7Kp/MUUGyP150dAYrVc0TdrAsGtnDnCzNaF04j3l3a5UXK145PgrndmyjTUk+3LkRE8BFMR5i5kjvnDJCj8kxtW9Y5i190S3zatszlrTrUp1kIQELUIiBsqP8cLL7/SYNdnxVR2tzlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+EMtRhX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2637b6e9149so331145ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757948467; x=1758553267; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9K2ZNoVdFEQAo4l5PTBMo8u7yy6tT4YYzBB/JfpAiU=;
        b=b+EMtRhXmbQPKQDIdxgKr5lFiiyJE7z0nBf5NKKAb9YWK9bhs5hcUJfEcUbnf4Gb0E
         BaFd9u88VuW6tFvRhgxE1by2Ld0rGHTbZCAOoYtKRI1qrn9nmP1rA5yy8a2LZW10Mkqz
         2XzVnJR7b+hP18EU8x4gKY5tawXRU2KEDBEZFvTA+BqfuVRLd3aFkbAb/jMS7b8H/ONS
         feVikVt54/dBwuJuhaCZregXA/pBuapVUEhuGjAc2O5vWt6MyhL/dIJXR0eQUHMno9gI
         RAu1hr+QFvajGSBbvv2dBZ0000e83hgkPw8jADdYXT2yDck43aymcBtgqnVvbwLu8IVQ
         9lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948467; x=1758553267;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9K2ZNoVdFEQAo4l5PTBMo8u7yy6tT4YYzBB/JfpAiU=;
        b=eTCjN2p3AQ6JxBb9yc2fT3KkgjRjKc2Pvl3+OZamS+fsbWuLdBX4AJeE9fhmTigH5C
         987K+bLJMveVhefwSrMbLfUe0ab2pH3V7f/8xVIGhxtkSSAQArc6+EeAKhB21vUkOmaU
         L6HhLHvqzNDc0rw/iU2TfMLdAIb7UswQ8oxFPl/3BiqM7ZcBuZtjk3hMjDeIeVidjY/k
         urljLkxsnK+1R4Dnb+6QGe7dpxBp7+enrKbMUn+D0jnTeUp3OtSN6Mj0O+JaDhOPIL4W
         Utvi8DqCwTBGMJP43O6GUVbCk0Ze6ORPwg8E17mbBJXurq4zQ+egai4f12NjsxilveVE
         O4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJrb87eEoK7MmNXh8NZ1A0EFZCxxK90EHdG4bcvaTzFkY97rAC94GgJmR2QTFCw2C0TWJ39rxzLSf30CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjONxjQ8A2hPY0UWfdhbxjkyN8cj8+5lD+y/5jAWoHm0AG+z/u
	K1Jbu1PoxSF7pwtmwjRFM70tfbA4WrrCtgYasS8MPT4gCjT3HqHh6RMtlcKQb3hG5K9I372gsrB
	Fp8WMyipiB0hBL/uhMB6/7VulXNsvX/jnYQqDI7vy
X-Gm-Gg: ASbGncv1Vnj4CPHQTOqKahuCzQDSXa//DWBNrtXFP8/czsaBqi6ryvOluAXqop8Cw0f
	e5aRBLEe/fwp5nLKGkjt4qvjvxYvZyL6b2qLOC+QxPenHycCXYCqjiYJaoBKI7RngX00pudKz/O
	JZ77+o3+pt46P8FP77EHLXhUccDbByqCmWlXAw7D4nOVSy1LXl2yL0oTkxwm/O0kgHh9v4gAXav
	giVjWuyq9ioC9AwVzd/zMKOIOeU9gaxLvkSvQWcaLrHZ/j/tQotlic=
X-Google-Smtp-Source: AGHT+IGySltNDMqtEE6Huhdc1tR9G0RC/iwxIoxdqKUeG2fq3SitVMFnig3n05ncji36jZGgJEZr47n8UCv81x6Enc4=
X-Received: by 2002:a17:902:ea08:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-266b8a2f830mr2974895ad.3.1757948466100; Mon, 15 Sep 2025
 08:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914181808.1957729-1-irogers@google.com>
In-Reply-To: <20250914181808.1957729-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Sep 2025 08:00:53 -0700
X-Gm-Features: Ac12FXy_iXabN6eCwLi19NLkk4n6ATbOkH6fj37zAuckwN_qB8gDAsBy5dmJucI
Message-ID: <CAP-5=fWz9Put0QznfXSf1ATXjcfQj1T2toZmXrXp502qU4fRSw@mail.gmail.com>
Subject: Re: [PATCH v1] perf maps: Ensure kmap is set up for all inserts
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 11:18=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> __maps__fixup_overlap_and_insert may split or directly insert a map,
> when doing this the map may need to have a kmap set up for the sake of
> the kmaps. The missing kmap set up fails the check_invariants test in
> maps, later "Internal error" reports from map__kmap and ultimately
> causes segfaults.
>
> Similar fixes were added in commit e0e4e0b8b7fa ("perf maps: Add
> missing map__set_kmap_maps() when replacing a kernel map") and commit
> 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added kernel
> maps") but they missed cases. To try to reduce the risk of this,
> update the kmap directly following any manual insert. This identified
> another problem in maps__copy_from.
>
> Fixes: e0e4e0b8b7fa ("perf maps: Add missing map__set_kmap_maps() when re=
placing a kernel map")
> Fixes: 25d9c0301d36 ("perf maps: Set the kmaps for newly created/added ke=
rnel maps")
> Signed-off-by: Ian Rogers <irogers@google.com>

This may be worth picking up for v6.17. It was a fairly regular source
of crashes on basic commands like `perf record` for me on certain
kernels. `perf record` by default is processing the whole perf.data
file and if there were overlapping maps, from BPF symbol events
typically, the broken kmap would trigger assertion failures and seg
faults.

Thanks,
Ian

> ---
>  tools/perf/util/maps.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 85b2a93a59ac..779f6230130a 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c
> @@ -477,6 +477,7 @@ static int __maps__insert(struct maps *maps, struct m=
ap *new)
>         }
>         /* Insert the value at the end. */
>         maps_by_address[nr_maps] =3D map__get(new);
> +       map__set_kmap_maps(new, maps);
>         if (maps_by_name)
>                 maps_by_name[nr_maps] =3D map__get(new);
>
> @@ -502,8 +503,6 @@ static int __maps__insert(struct maps *maps, struct m=
ap *new)
>         if (map__end(new) < map__start(new))
>                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
>
> -       map__set_kmap_maps(new, maps);
> -
>         return 0;
>  }
>
> @@ -891,6 +890,7 @@ static int __maps__fixup_overlap_and_insert(struct ma=
ps *maps, struct map *new)
>                 if (before) {
>                         map__put(maps_by_address[i]);
>                         maps_by_address[i] =3D before;
> +                       map__set_kmap_maps(before, maps);
>
>                         if (maps_by_name) {
>                                 map__put(maps_by_name[ni]);
> @@ -918,6 +918,7 @@ static int __maps__fixup_overlap_and_insert(struct ma=
ps *maps, struct map *new)
>                          */
>                         map__put(maps_by_address[i]);
>                         maps_by_address[i] =3D map__get(new);
> +                       map__set_kmap_maps(new, maps);
>
>                         if (maps_by_name) {
>                                 map__put(maps_by_name[ni]);
> @@ -942,14 +943,13 @@ static int __maps__fixup_overlap_and_insert(struct =
maps *maps, struct map *new)
>                                  */
>                                 map__put(maps_by_address[i]);
>                                 maps_by_address[i] =3D map__get(new);
> +                               map__set_kmap_maps(new, maps);
>
>                                 if (maps_by_name) {
>                                         map__put(maps_by_name[ni]);
>                                         maps_by_name[ni] =3D map__get(new=
);
>                                 }
>
> -                               map__set_kmap_maps(new, maps);
> -
>                                 check_invariants(maps);
>                                 return err;
>                         }
> @@ -1019,6 +1019,7 @@ int maps__copy_from(struct maps *dest, struct maps =
*parent)
>                                 err =3D unwind__prepare_access(dest, new,=
 NULL);
>                                 if (!err) {
>                                         dest_maps_by_address[i] =3D new;
> +                                       map__set_kmap_maps(new, dest);
>                                         if (dest_maps_by_name)
>                                                 dest_maps_by_name[i] =3D =
map__get(new);
>                                         RC_CHK_ACCESS(dest)->nr_maps =3D =
i + 1;
> --
> 2.51.0.384.g4c02a37b29-goog
>

