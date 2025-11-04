Return-Path: <linux-kernel+bounces-884100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D92C2F5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161533A9041
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297362BF015;
	Tue,  4 Nov 2025 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0Fkoi4V"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC323EAB6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233373; cv=none; b=Auz6sPMCcflU7QlGlZbjaQiBMWGgP/Z4rqW5Ida3V/ZG5eRtz7QPXzctrk+PyJUb3+NXLoLwKULjMRe528GmyokSh6ZwoHFjwYsLxTyuylwrfs5JaD2R4FG06Wwe1HhX27Qaf11GfhgtR5s0g5SCZ51RiEBs0wbLUXxH+RdvAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233373; c=relaxed/simple;
	bh=nBA5miH7/Qz55ZmhSHMlH75RHc06u1G1Vw5QkkRj+9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKzN3RR0QhSmF2rPFlCnDVoZFC3cGizJFpFLTadNNq8rnnBAqb7lZxosOU+eEgYf7YgIzsMP4E5u8M//FQp/Xe2QPYmJgEcgwAT8lETeLOpbGYEzDAbU/EmrlWL1GGOmn7fd22ypz87fNKdhRFmvrTTwsjE++JKSyUA/KU6ndog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0Fkoi4V; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2959197b68eso90355ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762233369; x=1762838169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtkcQ+7QlbPCMjWQf4qR2PUXjMqZjQBaQE63KR+6lZI=;
        b=B0Fkoi4VZ0UZS/EP9QjXSF6To+1YKY0ubWUR+Fqias3xGgpUWOml4o6Tfqn7kKQ7bt
         Zi9hMFMRhTj7Tir+6znEAsRCxdtPB7YTpwn8wqIIl+pxX5MSnuKyP4QZjibvG1czc7tn
         FNxxifsc4jXtbpQDYUcTaij9mXuDSDZKhjiuwgR9/K2uccYoctiDVrpK+Yuhx1T+HxkM
         enpIefRsLk5EVe7l436ubcMjiL11ot6EaCSysXfqShiVQuaopj87BkqZ26aX0tsQGTCz
         lQbqB7ZDOtU43DHpFGwqKMzeuc8qaKJQSY3sWLq6pXJ+pLVAm+LB1pW3Lh61sgvO/7Pm
         XoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762233369; x=1762838169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtkcQ+7QlbPCMjWQf4qR2PUXjMqZjQBaQE63KR+6lZI=;
        b=dodkfQTtMyG2hSr8KLpjKgKXFsM9bT4AFf+FIMgz1DS9eneHwdqnBAqUkOSJ+w7Utw
         1rif0pJ/rhu4hsg0XZs6EIq/7m6bhnJ50OZStabqzMM4SxgQMgtwTO78Jxj7901MMJvo
         uUj/J8Jo1NNwZJp8JfjXDHAopsvQ7B0KAfHEdnu6D0qzhZCm1ehaOiP8H3O+e0kKY5+r
         HBFbdT+VVy/5XkKQ2bFt0sjuSZMunUM8rl84RoHOzOvMGl7lHdOFtz7/NO/KFm3G3CBc
         g6OVQ09Oes5qsZF4mUpwjyLZ5Q4gs8I16uHnCRfySMT+Rh5/tNqGqwY/RmX1r4sIv6oU
         ZP/g==
X-Forwarded-Encrypted: i=1; AJvYcCVTKXRaDfa7KQgHAt8AfzXw4me7Ct+lJOOAqkWXgXquTF4D0HiBmdLrdMXE74tc+WXcyMnjhq+nPwb1npM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFj4iYf5QsfOSCMH0hF/ewIqVy/h24FfSkVAeFwcVCfjSx6ZfQ
	vx6Tvri8zcK4ShZTA+vEb/JbtLTXCT7RH87VLc1EJmekaqQ+GGZefirjYGVag/l1ueBQrrsT7xE
	EivNfmNg64ZUD2fr6UZ6XaPWx1U3gQuE/frL/sSxU
X-Gm-Gg: ASbGncvy8HR9hx/v0rj+6kAGWUdl602Z6jh4Y3dbs78NB3rwijqBdJOWYKFzP1Qns22
	VVPhWJ9I2aIIGVq/gyqy+suBqA6H/Zpwb2bTImT7u44/QpSj+xHaFk7dgHL82J5VZyib1AktAqw
	TJN/rZKoKuGmfDUv7b0dkUFtNJ6i9juAuFxizFlQDGkfCcw3+TlxT7AjLwkUowrbxwDZMd/1VDA
	TtzhFTzau2X/VH7UbArdz6UYMAhjB3stDqFAEz+q8HzNYMKGfIScIrpCgDd
X-Google-Smtp-Source: AGHT+IGmW8nRI10W77Cb5vNSTQ/6CVF/p1MggMX7AIzvbiRI1Vjs0B0mstlxdO9pox65Yw5H0W2MFZw7WDk1KSwyyTo=
X-Received: by 2002:a17:903:22c1:b0:293:2a8:3f9b with SMTP id
 d9443c01a7336-29601e363c7mr1873545ad.15.1762233368825; Mon, 03 Nov 2025
 21:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104042632.1560922-1-namhyung@kernel.org>
In-Reply-To: <20251104042632.1560922-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:15:57 -0800
X-Gm-Features: AWmQ_bnI1d3ADTxfRC455NMxgRnbXNF-EzyzxTtyhbBh1UhqvfJydtyoSo9VKuE
Message-ID: <CAP-5=fWuAx-uKp0g__hy9zQQiir83_KCVY4XzjW8uob3Coox7w@mail.gmail.com>
Subject: Re: [PATCH] perf record: Make sure to update build-ID cache
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Recent change on enabling --buildid-mmap by default brought an issue
> with build-id handling.  With build-ID in MMAP2 records, we don't need
> to save the build-ID table in the header are of a perf data file.

nit: s/are of/of/

>
> But the actual file contents still need to be cached in the debug
> directory for annotation etc.  Split the build-ID header processing and
> caching and make sure perf record to save hit DSOs in the build-ID cache
> by moving perf_session__cache_build_ids() to the end of the record__
> finish_output().

The changes to builtin-record look okay, but do we need to worry about
`perf mem record` and similar? The header change will impact all
perf.data file generation.

Thanks,
Ian

>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c | 30 +++++++++++++++---------------
>  tools/perf/util/header.c    |  1 -
>  2 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ffb94a8339b03ec2..fe10bb7f35cbea05 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1890,15 +1890,14 @@ record__finish_output(struct record *rec)
>         }
>
>         /* Buildid scanning disabled or build ID in kernel and synthesize=
d map events. */
> -       if (!rec->no_buildid) {
> +       if (!rec->no_buildid || !rec->no_buildid_cache) {
>                 process_buildids(rec);
>
>                 if (rec->buildid_all)
>                         perf_session__dsos_hit_all(rec->session);
>         }
>         perf_session__write_header(rec->session, rec->evlist, fd, true);
> -
> -       return;
> +       perf_session__cache_build_ids(rec->session);
>  }
>
>  static int record__synthesize_workload(struct record *rec, bool tail)
> @@ -3083,7 +3082,7 @@ static int perf_record_config(const char *var, cons=
t char *value, void *cb)
>                 else if (!strcmp(value, "no-cache"))
>                         rec->no_buildid_cache =3D true;
>                 else if (!strcmp(value, "skip"))
> -                       rec->no_buildid =3D true;
> +                       rec->no_buildid =3D rec->no_buildid_cache =3D tru=
e;
>                 else if (!strcmp(value, "mmap"))
>                         rec->buildid_mmap =3D true;
>                 else if (!strcmp(value, "no-mmap"))
> @@ -4192,24 +4191,25 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.record_switch_events =3D true;
>         }
>
> -       if (!rec->buildid_mmap) {
> -               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> -               symbol_conf.no_buildid_mmap2 =3D true;
> -       } else if (rec->buildid_mmap_set) {
> -               /*
> -                * Explicitly passing --buildid-mmap disables buildid pro=
cessing
> -                * and cache generation.
> -                */
> -               rec->no_buildid =3D true;
> -       }
>         if (rec->buildid_mmap && !perf_can_record_build_id()) {
>                 pr_warning("Missing support for build id in kernel mmap e=
vents.\n"
>                            "Disable this warning with --no-buildid-mmap\n=
");
>                 rec->buildid_mmap =3D false;
>         }
> +
>         if (rec->buildid_mmap) {
>                 /* Enable perf_event_attr::build_id bit. */
>                 rec->opts.build_id =3D true;
> +               /* Disable build-ID table in the header. */
> +               rec->no_buildid =3D true;
> +       } else {
> +               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> +               symbol_conf.no_buildid_mmap2 =3D true;
> +       }
> +
> +       if (rec->no_buildid_set && rec->no_buildid) {
> +               /* -B implies -N for historic reasons. */
> +               rec->no_buildid_cache =3D true;
>         }
>
>         if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> @@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
>
>         err =3D -ENOMEM;
>
> -       if (rec->no_buildid_cache || rec->no_buildid) {
> +       if (rec->no_buildid_cache) {
>                 disable_buildid_cache();
>         } else if (rec->switch_output.enabled) {
>                 /*
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4f2a6e10ed5cc0bd..4de7ca16b5522c47 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -335,7 +335,6 @@ static int write_build_id(struct feat_fd *ff,
>                 pr_debug("failed to write buildid table\n");
>                 return err;
>         }
> -       perf_session__cache_build_ids(session);
>
>         return 0;
>  }
> --
> 2.51.2.997.g839fc31de9-goog
>

