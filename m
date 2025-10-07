Return-Path: <linux-kernel+bounces-844288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ED7BC175B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE7E1892C38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177F2E06ED;
	Tue,  7 Oct 2025 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCTvGeXb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA51DF982
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843015; cv=none; b=MyvBO44X6bU6fA4sbkDp4QVZ4Jo4qSgJ1UsUor29a1O6hyjVhT9OMFsCWngJy/8+j2GrBJhROqtfLBCV8azqhQ38PID3i5sDaCiOxgPCtgdQm/5cpV8YtZsm/tAmWMXrutaLjGkuv6uR7Ib7h69MeMagPKKzsdc7gnM+4HwUuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843015; c=relaxed/simple;
	bh=J/YAh18KJjnxLSjBY0LB/WOt4/ZQIBzPzeD1/BKjt9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7oeH+zu2jugl7fFxWf8kPOllq9PvPUCoJyDUE+c23w5/k3Q36kL68VMLotvM8lbWPBOKBUCjFiiF2/NiQGnnAmfx049atL++da7ySFTZl6Bf0zbPZeQMP2umAJJa7eIjkdV11U5OwDceGvkaVzdidpi0ResWElutNaEoxLrhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCTvGeXb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2731ff54949so149775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759843012; x=1760447812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSfSd1we65hmmqWHgywIdlQEPXK8lK5SW/TKK7x5FcU=;
        b=OCTvGeXbDQIBCCMm70GKsekKk6z9KTSbOe3J0Jt5dDUeFitzQow0n34lJhB6i6xUwL
         NQuebr1M+gB3HPVkkZIkXLyuSjZv71ix7tVDAhA/DtyzyqNbmlgN4Dz3XKJJv/r1uG9j
         OVYQgftzuSI3/MrTOemdocQIcysEzXFNObJEEIurjHg60Gfotn+bqdbfvmLKDa/YVgUU
         aOCC2UkALzvRSATumnjLfqV2vWb2bI13b5fbsnK9HBwt0pLqnAiafNYv/te34uiwU3p9
         nm//vi8GNpqKimMMl9oCwWHKjgt2V0fdNdc3y8hQ/bOWrywM2Zy4Mh2S4oPQDAx19Oap
         6EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843012; x=1760447812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSfSd1we65hmmqWHgywIdlQEPXK8lK5SW/TKK7x5FcU=;
        b=IXQpsHYwzBEh9fQo+nrp8UMBqvsFTgpTEDuoiKQrsIm2ngWvuSxyXcm56UIQ7IfL81
         hf4l623RQPxOOT+ovAl/HqcFc0OM7ClqYdZ79mpmw9WYzERhWZBsSPU8u0W3GNET/bZB
         u7CU0Ux1duGPKw0Wv4/EU5tTSzQhY4I0tLkdj3MdQW3wa/0rgcfmGZeE6UCPj9wQh5Ss
         P9RwZvxTkQBK1CgInJHiR1biCuB8hYA0r3PfGLOq6/qfV6nPl68AY7eNXcrKKXX8Dj+M
         r/oqo2gu0I7fyjXYtZryQqXKNSl/ecF+dULatNeZl8yKcVeupJOL6U1+1h7Xy0YZVBwu
         cp+w==
X-Forwarded-Encrypted: i=1; AJvYcCXbS3vh7Uds57B4mwmyKaeudwg024fFjl3goh2ldqWRB/MTKIwRVZ3uA0Z1Gpaeld+TSKixQcgKoBOg1Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPD0sJMBAEPSTTjnA+kz3RsXUFYrH04c6S7KT+xhcgiQqbemCD
	JCs1IK/MVqEYI3clAGmop5cO9m/9vJ/eZT3nY+nGGzyVt68RYmvl5i+qoT3slXMXZ5mJeADTGPI
	Am3b8BZ5VkMN/w9phDikAxTnHM/FjFQRjfGhPCDXU
X-Gm-Gg: ASbGncvYwPdBQTzr/BL8bH7jhwpOojnJoUzDcfl8j2HwwBvZ/NOa0FaUm+34Y19SIRb
	Tuergbt4IYSgGRDhsbXHpdDVGYslO+LcsDy/pW38zoXd5kKtO/Ax3atgAPWAUYWv0u7kJ6Ckp49
	VqyfvD5tSPYJRpBjirV89Cez/abyQNBn4E/Ezfh88HSxPIpMvylzIx0UIyx4t2qYxK0NXpiZPR9
	Cw5ova9WLzKIm9Iv8/uU1ahIE9YeHEqhf2BSpNLap/j+pY03g==
X-Google-Smtp-Source: AGHT+IGLvZHO+2IQDlx0SmhtcwrTQypioWsShFCb3CsrkvHp6iWw4YYQCDZUevZB7MB371BijbijcocHtBepyDc0eTA=
X-Received: by 2002:a17:903:380f:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-28ecb38ef11mr4535175ad.12.1759843008106; Tue, 07 Oct 2025
 06:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com> <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
In-Reply-To: <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 06:16:36 -0700
X-Gm-Features: AS18NWBixu2P5pAAcvQHyygsEN47zZ3Nd60KZoAneyZhg5r0_V9hdQmXhFk4cRE
Message-ID: <CAP-5=fV1N-j+f4GBFnDWsmoMZcz_k0U=nu1A7NZz-g4gzCH4KA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code reading"
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:10=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 06/10/2025 4:21 pm, Ian Rogers wrote:
> > On Mon, Oct 6, 2025 at 6:11=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >> We already only test each kcore map once, but on slow systems
> >> (particularly with network filesystems) even the non-kcore maps are
> >> slow. The test can test the same objump output over and over which onl=
y
> >> wastes time. Generalize the skipping mechanism to track all DSOs and
> >> addresses so that each section is only tested once.
> >>
> >> On a fully loaded Arm Juno (simulating a parallel Perf test run) with =
a
> >> network filesystem, the original runtime is:
> >>
> >>    real  1m51.126s
> >>    user  0m19.445s
> >>    sys   1m15.431s
> >>
> >> And the new runtime is:
> >>
> >>    real  0m48.873s
> >>    user  0m8.031s
> >>    sys   0m32.353s
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> >> ---
> >>   tools/perf/tests/code-reading.c | 119 ++++++++++++++++++++++++++++--=
----------
> >>   1 file changed, 85 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-r=
eading.c
> >> index 9c2091310191..4c9fbf6965c4 100644
> >> --- a/tools/perf/tests/code-reading.c
> >> +++ b/tools/perf/tests/code-reading.c
> >> @@ -2,6 +2,7 @@
> >>   #include <errno.h>
> >>   #include <linux/kconfig.h>
> >>   #include <linux/kernel.h>
> >> +#include <linux/rbtree.h>
> >>   #include <linux/types.h>
> >>   #include <inttypes.h>
> >>   #include <stdlib.h>
> >> @@ -39,11 +40,64 @@
> >>   #define BUFSZ  1024
> >>   #define READLEN        128
> >>
> >> -struct state {
> >> -       u64 done[1024];
> >> -       size_t done_cnt;
> >> +struct tested_section {
> >> +       struct rb_node rb_node;
> >> +       u64 addr;
> >> +       char path[PATH_MAX];
> >>   };
> >>
> >> +static bool tested_code_insert_or_exists(const char *path, u64 addr,
> >> +                                        struct rb_root *tested_sectio=
ns)
> >> +{
> >> +       struct rb_node **node =3D &tested_sections->rb_node;
> >> +       struct rb_node *parent =3D NULL;
> >> +       struct tested_section *data;
> >> +
> >> +       while (*node) {
> >> +               int cmp;
> >> +
> >> +               parent =3D *node;
> >> +               data =3D rb_entry(*node, struct tested_section, rb_nod=
e);
> >> +               cmp =3D strcmp(path, data->path);
> >> +               if (!cmp) {
> >> +                       if (addr < data->addr)
> >> +                               cmp =3D -1;
> >> +                       else if (addr > data->addr)
> >> +                               cmp =3D 1;
> >> +                       else
> >> +                               return true; /* already tested */
> >> +               }
> >> +
> >> +               if (cmp < 0)
> >> +                       node =3D &(*node)->rb_left;
> >> +               else
> >> +                       node =3D &(*node)->rb_right;
> >> +       }
> >> +
> >> +       data =3D zalloc(sizeof(*data));
> >> +       if (!data)
> >> +               return true;
> >> +
> >> +       data->addr =3D addr;
> >> +       strlcpy(data->path, path, sizeof(data->path));
> >
> > nit: perhaps strdup rather than having 4kb per tested_section.
> >
> > Thanks,
> > Ian
> >
>
> Oh yeah that would have been better, not sure why I didn't do it that
> way. Although the max sections I saw was around 50, and it's usually a
> lot less so it's probably not worth the churn to change it now that
> Arnaldo's applied it?

I'm easy. It is one of those things I'd probably eye-ball at some
later date and send a driveby patch to change. You could send a patch
and let Arnaldo decide whether to squash it or add a follow up.

Thanks,
Ian

> Thanks
> James
>
> >> +       rb_link_node(&data->rb_node, parent, node);
> >> +       rb_insert_color(&data->rb_node, tested_sections);
> >> +       return false;
> >> +}
> >> +
> >> +static void tested_sections__free(struct rb_root *root)
> >> +{
> >> +       while (!RB_EMPTY_ROOT(root)) {
> >> +               struct rb_node *node =3D rb_first(root);
> >> +               struct tested_section *ts =3D rb_entry(node,
> >> +                                                    struct tested_sec=
tion,
> >> +                                                    rb_node);
> >> +
> >> +               rb_erase(node, root);
> >> +               free(ts);
> >> +       }
> >> +}
> >> +
> >>   static size_t read_objdump_chunk(const char **line, unsigned char **=
buf,
> >>                                   size_t *buf_len)
> >>   {
> >> @@ -316,13 +370,15 @@ static void dump_buf(unsigned char *buf, size_t =
len)
> >>   }
> >>
> >>   static int read_object_code(u64 addr, size_t len, u8 cpumode,
> >> -                           struct thread *thread, struct state *state=
)
> >> +                           struct thread *thread,
> >> +                           struct rb_root *tested_sections)
> >>   {
> >>          struct addr_location al;
> >>          unsigned char buf1[BUFSZ] =3D {0};
> >>          unsigned char buf2[BUFSZ] =3D {0};
> >>          size_t ret_len;
> >>          u64 objdump_addr;
> >> +       u64 skip_addr;
> >>          const char *objdump_name;
> >>          char decomp_name[KMOD_DECOMP_LEN];
> >>          bool decomp =3D false;
> >> @@ -350,6 +406,18 @@ static int read_object_code(u64 addr, size_t len,=
 u8 cpumode,
> >>                  goto out;
> >>          }
> >>
> >> +       /*
> >> +        * Don't retest the same addresses. objdump struggles with kco=
re - try
> >> +        * each map only once even if the address is different.
> >> +        */
> >> +       skip_addr =3D dso__is_kcore(dso) ? map__start(al.map) : al.add=
r;
> >> +       if (tested_code_insert_or_exists(dso__long_name(dso), skip_add=
r,
> >> +                                        tested_sections)) {
> >> +               pr_debug("Already tested %s @ %#"PRIx64" - skipping\n"=
,
> >> +                        dso__long_name(dso), skip_addr);
> >> +               goto out;
> >> +       }
> >> +
> >>          pr_debug("On file address is: %#"PRIx64"\n", al.addr);
> >>
> >>          if (len > BUFSZ)
> >> @@ -387,24 +455,6 @@ static int read_object_code(u64 addr, size_t len,=
 u8 cpumode,
> >>                  goto out;
> >>          }
> >>
> >> -       /* objdump struggles with kcore - try each map only once */
> >> -       if (dso__is_kcore(dso)) {
> >> -               size_t d;
> >> -
> >> -               for (d =3D 0; d < state->done_cnt; d++) {
> >> -                       if (state->done[d] =3D=3D map__start(al.map)) =
{
> >> -                               pr_debug("kcore map tested already");
> >> -                               pr_debug(" - skipping\n");
> >> -                               goto out;
> >> -                       }
> >> -               }
> >> -               if (state->done_cnt >=3D ARRAY_SIZE(state->done)) {
> >> -                       pr_debug("Too many kcore maps - skipping\n");
> >> -                       goto out;
> >> -               }
> >> -               state->done[state->done_cnt++] =3D map__start(al.map);
> >> -       }
> >> -
> >>          objdump_name =3D dso__long_name(dso);
> >>          if (dso__needs_decompress(dso)) {
> >>                  if (dso__decompress_kmodule_path(dso, objdump_name,
> >> @@ -471,9 +521,9 @@ static int read_object_code(u64 addr, size_t len, =
u8 cpumode,
> >>          return err;
> >>   }
> >>
> >> -static int process_sample_event(struct machine *machine,
> >> -                               struct evlist *evlist,
> >> -                               union perf_event *event, struct state =
*state)
> >> +static int process_sample_event(struct machine *machine, struct evlis=
t *evlist,
> >> +                               union perf_event *event,
> >> +                               struct rb_root *tested_sections)
> >>   {
> >>          struct perf_sample sample;
> >>          struct thread *thread;
> >> @@ -494,7 +544,8 @@ static int process_sample_event(struct machine *ma=
chine,
> >>                  goto out;
> >>          }
> >>
> >> -       ret =3D read_object_code(sample.ip, READLEN, sample.cpumode, t=
hread, state);
> >> +       ret =3D read_object_code(sample.ip, READLEN, sample.cpumode, t=
hread,
> >> +                              tested_sections);
> >>          thread__put(thread);
> >>   out:
> >>          perf_sample__exit(&sample);
> >> @@ -502,10 +553,11 @@ static int process_sample_event(struct machine *=
machine,
> >>   }
> >>
> >>   static int process_event(struct machine *machine, struct evlist *evl=
ist,
> >> -                        union perf_event *event, struct state *state)
> >> +                        union perf_event *event, struct rb_root *test=
ed_sections)
> >>   {
> >>          if (event->header.type =3D=3D PERF_RECORD_SAMPLE)
> >> -               return process_sample_event(machine, evlist, event, st=
ate);
> >> +               return process_sample_event(machine, evlist, event,
> >> +                                           tested_sections);
> >>
> >>          if (event->header.type =3D=3D PERF_RECORD_THROTTLE ||
> >>              event->header.type =3D=3D PERF_RECORD_UNTHROTTLE)
> >> @@ -525,7 +577,7 @@ static int process_event(struct machine *machine, =
struct evlist *evlist,
> >>   }
> >>
> >>   static int process_events(struct machine *machine, struct evlist *ev=
list,
> >> -                         struct state *state)
> >> +                         struct rb_root *tested_sections)
> >>   {
> >>          union perf_event *event;
> >>          struct mmap *md;
> >> @@ -537,7 +589,7 @@ static int process_events(struct machine *machine,=
 struct evlist *evlist,
> >>                          continue;
> >>
> >>                  while ((event =3D perf_mmap__read_event(&md->core)) !=
=3D NULL) {
> >> -                       ret =3D process_event(machine, evlist, event, =
state);
> >> +                       ret =3D process_event(machine, evlist, event, =
tested_sections);
> >>                          perf_mmap__consume(&md->core);
> >>                          if (ret < 0)
> >>                                  return ret;
> >> @@ -637,9 +689,7 @@ static int do_test_code_reading(bool try_kcore)
> >>                          .uses_mmap   =3D true,
> >>                  },
> >>          };
> >> -       struct state state =3D {
> >> -               .done_cnt =3D 0,
> >> -       };
> >> +       struct rb_root tested_sections =3D RB_ROOT;
> >>          struct perf_thread_map *threads =3D NULL;
> >>          struct perf_cpu_map *cpus =3D NULL;
> >>          struct evlist *evlist =3D NULL;
> >> @@ -773,7 +823,7 @@ static int do_test_code_reading(bool try_kcore)
> >>
> >>          evlist__disable(evlist);
> >>
> >> -       ret =3D process_events(machine, evlist, &state);
> >> +       ret =3D process_events(machine, evlist, &tested_sections);
> >>          if (ret < 0)
> >>                  goto out_put;
> >>
> >> @@ -793,6 +843,7 @@ static int do_test_code_reading(bool try_kcore)
> >>          perf_thread_map__put(threads);
> >>          machine__delete(machine);
> >>          perf_env__exit(&host_env);
> >> +       tested_sections__free(&tested_sections);
> >>
> >>          return err;
> >>   }
> >>
> >> ---
> >> base-commit: a22d167ed82505f770340c3a7c257c04ba24dac9
> >> change-id: 20251006-james-perf-object-code-reading-9646e486d595
> >>
> >> Best regards,
> >> --
> >> James Clark <james.clark@linaro.org>
> >>
>

