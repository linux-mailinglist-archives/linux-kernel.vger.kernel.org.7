Return-Path: <linux-kernel+bounces-869384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF1C07BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2096619A6709
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FB344023;
	Fri, 24 Oct 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRMtWeTm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22CD219A8A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330394; cv=none; b=NMyK3pAiJW/FReEaX/J+W2m9eLIVoPx9OnK6MzJWeXrlpdzWxDCTM4IX2o9qBc07GQCkqnh0lm9o+HvpVQWrTT0KPHxhL9/7EphMOnmh3VvWrhGZBNFdoe9u1d7Rgf32zM1NWnef7ehM7AwxRsm3I9B63uSHu51qIyvfg6mgRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330394; c=relaxed/simple;
	bh=/xXYT/dLZvs79m30ucc/SA6mjHSB6UGSKFkcpqjvd78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/uNlSwE9e/xNnT9tBktOsMb/2gM9nBeaj2MrUcbBpn5HUfCNf+issNFsucEX5TP0KlsHIVE7lW9s0roaoK3xynryqH2mxVKiHkuelxGNQi4LQvtIWPg+SPPxpm+n2qz0GsEXzp3AVxpMM3HSQ7mYpEDrTn1Y6OhUCono2VOlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRMtWeTm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so27525ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761330392; x=1761935192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6URo0RHCzgXmccx7rlNSvSKMolAOCwrmZ6PQotsL+68=;
        b=dRMtWeTmLea/xzT1JlBg9Oy6uMQf8onbFF0V4XYRy36iXggpnDse/XjfH9Csx0fnLd
         SmpsJF4wFp2NqCu5yJNvIkELvptDDFytA+6vt9dn5tilB2Xn+JE2WkJAHOJTuFv4T0L7
         F7yG7/O+bvdQcjRlEhF3mdWl4M92zeWb0ssxdYWmwSa6NO9ri2XDKLKHIiJBPs5k47Zl
         R/GWP52b6J46ki6/OM5MAPffiQ5CyhldVvVRPeg0Rws6jKUZSloQDunkeBehDYhmGkTu
         0uBTO4rRwSVmVNvP7F6UuP0O7gHtsqXk7aHW+hm9JUu3ZopYfj+aEHezzefhtQ6VcDNR
         EJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330392; x=1761935192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6URo0RHCzgXmccx7rlNSvSKMolAOCwrmZ6PQotsL+68=;
        b=nZkHjdRz2UL0nSBJngQyPrL+FdzfCN8aQV3LYDQdXL6cuYntlbrkPxUgyjNAOXaPg1
         Svng4/kuETVsc6bOqkdPW+teS4EgPzgWlUd0WC1potEZw9estJ/JN8w1UZWA6JQM0Moh
         rShrldPe0tnqmQfqfUfSRnSLtm0P7y/ko4uzAcTyIy/Ps9Uqoa4MOkFNgDWWUP7lw7o/
         yNbyLEiJn0ADEcV+zJYII74wh8d0YxE3OH9F+IeEUg4nMI/5Xum8dNWDNysiGTnOaIj/
         Su0XejqOzTJMbuB7kwpGZC8XVVfJDygZy+hCmAm+8uMkUoyweBv+0tcTke4xZ+BwF/nz
         ms5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOR1/TtmfAa0OWLW23tRDZKAEkrf5JHjsh92o/zxdu5E+Zq+10sdQvMYVMsUDPtb3kBdIPRzH/76+ft90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytjc9loRudkN0tInXfFvyySbzkIUikEp+8K0c8JYi1IB3z9zr8
	/GaYHB5p3XdKvlU5mC/sUNUB72jruqb3Vbr1cl/UynQT7vtA4qedu8Fw1qZk1Kp6vkJmAI/ZSjo
	qAawYhmgvfNeWIV1yFse8UX+xlq/vyGrjHXR4DrjD
X-Gm-Gg: ASbGncvHUTc8/PbHbG9qqvVMjOyO83abEtvoY3zNf1s55qfWbdxSXVV1C60KMwvogVf
	5X5k+WmBASBZLSnI3uz8LuMRYQGuULj0cfi2ksevuxWfGksesj2zS6sKTK1934oG8nwH6eDGxM1
	/1HBfOjI6WkmNlLDH2K606AMQQGSPI5ItRDYNylS1KrIRNUl2Vpr890Ns0EitWVIQtEdx1T7bkw
	WGeHI+vdR+gxzV+PZjG7NYCJLEPsJ43HK/IWSsm/2NRJtMfQ6l00QKz73mB29MX/Zfh9iCJbA1a
	eIN+jjKSzirr6+MG5Hu55Zg4
X-Google-Smtp-Source: AGHT+IE/R1MWUMoRED9m8KDFeIvwsQdy8ET29v31C+Q9bortUC4rMaEW0+tjaZB8YlaiwfwGZSQhF9utyG5KG6THwWQ=
X-Received: by 2002:a17:902:f605:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29497c0c9d2mr351855ad.7.1761330391641; Fri, 24 Oct 2025
 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
In-Reply-To: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Oct 2025 11:26:18 -0700
X-Gm-Features: AS18NWDqeMJm0qdg4y_7XXPpGJ0ljpcenxt2e3n92QfttyvGjhVX5ObkesE21ZY
Message-ID: <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:46=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The following command will hang consistently when the GPU is being used
> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> being opened to read build IDs:
>
>  $ perf record -asdg -e cpu-clock -- true
>
> Change to non blocking reads to avoid the hang here:
>
>   #0  __libc_pread64 (offset=3D<optimised out>, count=3D0, buf=3D0x7fffff=
ffa4a0, fd=3D237) at ../sysdeps/unix/sysv/linux/pread64.c:25
>   #1  __libc_pread64 (fd=3D237, buf=3D0x7fffffffa4a0, count=3D0, offset=
=3D0) at ../sysdeps/unix/sysv/linux/pread64.c:23
>   #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
>   #3  read_build_id (filename=3D0x5555562df333 "/dev/dri/card2", bid=3D0x=
7fffffffb680, block=3Dtrue) at util/symbol-elf.c:880
>   #4  filename__read_build_id (filename=3D0x5555562df333 "/dev/dri/card2"=
, bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:924
>   #5  dsos__read_build_ids_cb (dso=3D0x5555562df1d0, data=3D0x7fffffffb75=
0) at util/dsos.c:84
>   #6  __dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7030 <d=
sos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:59
>   #7  dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7030 <dso=
s__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:503
>   #8  dsos__read_build_ids (dsos=3D0x55555623de68, with_hits=3Dtrue) at u=
til/dsos.c:107
>   #9  machine__read_build_ids (machine=3D0x55555623da58, with_hits=3Dtrue=
) at util/build-id.c:950
>   #10 perf_session__read_build_ids (session=3D0x55555623d840, with_hits=
=3Dtrue) at util/build-id.c:956
>   #11 write_build_id (ff=3D0x7fffffffb958, evlist=3D0x5555562323d0) at ut=
il/header.c:327
>   #12 do_write_feat (ff=3D0x7fffffffb958, type=3D2, p=3D0x7fffffffb950, e=
vlist=3D0x5555562323d0, fc=3D0x0) at util/header.c:3588
>   #13 perf_header__adds_write (header=3D0x55555623d840, evlist=3D0x555556=
2323d0, fd=3D3, fc=3D0x0) at util/header.c:3632
>   #14 perf_session__do_write_header (session=3D0x55555623d840, evlist=3D0=
x5555562323d0, fd=3D3, at_exit=3Dtrue, fc=3D0x0, write_attrs_after_data=3Df=
alse) at util/header.c:3756
>   #15 perf_session__write_header (session=3D0x55555623d840, evlist=3D0x55=
55562323d0, fd=3D3, at_exit=3Dtrue) at util/header.c:3796
>   #16 record__finish_output (rec=3D0x5555561838d8 <record>) at builtin-re=
cord.c:1899
>   #17 __cmd_record (rec=3D0x5555561838d8 <record>, argc=3D2, argv=3D0x7ff=
fffffe320) at builtin-record.c:2967
>   #18 cmd_record (argc=3D2, argv=3D0x7fffffffe320) at builtin-record.c:44=
53
>   #19 run_builtin (p=3D0x55555618cbb0 <commands+288>, argc=3D9, argv=3D0x=
7fffffffe320) at perf.c:349
>   #20 handle_internal_command (argc=3D9, argv=3D0x7fffffffe320) at perf.c=
:401
>   #21 run_argv (argcp=3D0x7fffffffe16c, argv=3D0x7fffffffe160) at perf.c:=
445
>   #22 main (argc=3D9, argv=3D0x7fffffffe320) at perf.c:553
>
> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> I'm not actually sure if this is the right fix for this. Commit
> 2c369d91d093 ("perf symbol: Add blocking argument to
> filename__read_build_id") which added the blocking argument says that it
> should be non-blocking reads for event synthesis, but the callstack here
> is when writing the header out.
>
> There was also an is_regular_file() check added in commit c21986d33d6b
> ("perf unwind-libdw: skip non-regular files"), which presumably falls
> afoul of the "which unfortunately fails for symlinks" part of the other
> linked commit message?
>
> So I can't tell if we should add the is_regular_file() check here too,
> or just set it to non-blocking, or it needs some extra state to be
> passed all the way down to dsos__read_build_ids_cb() to do different
> things.

The fix lgtm but I worry about making all the build ID reading
non-blocking meaning build IDs getting lost. It seems that generating
the build ID feature table is unnecessary if we have build ID mmap
events, including synthesized ones that will have read the build IDs.
I wonder if a better "fix" is:
```
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb52aea9607d..15f75c70eb76 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
       for (feat =3D HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat=
++)
               perf_header__set_feat(&session->header, feat);

-       if (rec->no_buildid)
+       if (rec->no_buildid || rec->buildid_mmap)
               perf_header__clear_feat(&session->header, HEADER_BUILD_ID);

       if (!have_tracepoints(&rec->evlist->core.entries))
```
that should disable the build ID feature table generation when build
ID mmaps are in use (the default). Having the build IDs twice in the
data file feels redundant. Or we could do your fix or both, wdyt?

Thanks,
Ian

> ---
>  tools/perf/util/dsos.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 64c1d65b0149..5e1c815d7cb0 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, v=
oid *data)
>                 return 0;
>         }
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/true) > 0) {
> +       /* Don't block in case path isn't for a regular file. */
> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/false) > 0) {
>                 dso__set_build_id(dso, &bid);
>                 args->have_build_id =3D true;
>         } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
>                 char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
>
> -               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/true) > 0) {
> +               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/false) > 0) {
>                         dso__set_build_id(dso, &bid);
>                         args->have_build_id =3D true;
>                 }
>
> ---
> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>

