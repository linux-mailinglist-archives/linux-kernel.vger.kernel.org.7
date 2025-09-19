Return-Path: <linux-kernel+bounces-825259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCCBB8B700
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F5B641E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA82857D2;
	Fri, 19 Sep 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDaisk38"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437CE36B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319413; cv=none; b=iGGeRydofxxA+ogwmsukcp/Ika62HuNzp2rILZnZxx26rSjkjHZ6zLzLYZdZgsuIoroW5QX7bEc6aXGVhV4Wyq/rYhXmQlPH7Ty2DNVzhS7+w56hoX+C5n120TlPCJpzEDBiwwoEZYM/IackQrDCpgleO3g1PWvOqjMQZRyAyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319413; c=relaxed/simple;
	bh=pCHucsLT5P3ZsgU0T7z20r2f4B/eHCIhX5LArsOJmuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+lKhBSRTm5cTVusCAxv7154zR39ugFZ3uEn32ikTJ0sxI4XtlCKFr5PXldXktEv72iwZ8sdefqUb0PEmbqqHTqBay5GU5nLAGMI2fR0tqgK2MVE992nb2GnurvG+S/ai63qYfeH9Yfkr8LT5hJpOkLUsMx5GQefPPi/saOOtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDaisk38; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2681645b7b6so19575ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319412; x=1758924212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKiy/m0+cOmNMee9GUcfQ4T1DjGRK2p5T2fy+Za3D5c=;
        b=LDaisk38ETIrdLNa8Jgmlg/vcX2YOLpD3895ewKWJ6J9Rv1ITGWGADMrJYgsu2oCjJ
         aLvByWG9X02L7XjQ8nyB/4GGajBuBbwi/8f8OqgyZZsCBubW8gErEHdJyeLTlItnwN0U
         OUwQlxNZfRX1oz2/BvGhfN1O/OyRmDTUn7fsymuUVwbkiujihZg/LTz8Gv2Rz4SruoGt
         sn8TzgkOrTeT92HVAkbW24uO+yF+bgiwkveNSaGuHQncKjyVSp7b1MPklQGnt0BclNBX
         u/BJehL2weRvudkb3jmp/RBU6b8rDsjux12lbizYw8hfp5BwVXLEL8UzIoUunp+w/f/S
         KUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319412; x=1758924212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKiy/m0+cOmNMee9GUcfQ4T1DjGRK2p5T2fy+Za3D5c=;
        b=eG2i1r7c4Vv3aUYK9UWApALIkBwRxzag2y6AalPMW6jbH0uM4A/lcJlPlqG4oPnWNp
         NlQhTcno4X8Ii1NabIijzFyUD7wtWGHjYp1Fk2wyYDJsLYikg6b3644/HXq7tY6H4UgU
         1iJq5R83JeZIOK659bRskjqd71SRIqYAzlxTebIAbqVxcwmaj7xoYi9OAU3OGkSCYW9Z
         HKkUBrLPv/5QBJvCdPa7pfeeTdtFD9iNzwdoX8L920UFqtCaMsymnS3R/cdAYs5vpLmJ
         sjjnCHagNfyvZTWyJvRPJmJ1rmnvP0r+zNP7pCUA6d5ru/90JcBi4+0Kmykz0iD2OJv/
         Ar0w==
X-Forwarded-Encrypted: i=1; AJvYcCVdo1RRKAx+0epj7WEGpg1B45hDjpIjKYxePZWL5l+hGRhTOds0+j1zj7B5TYWyyMLCeQngg6sepuAdlhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7x17jY06T2ZCke/42SY9p/q7t79eftMGWLWXdgpHGxtcVrOx
	Tu94LFOxprekPb4rg4KSfECADzCmsfPKIPaKTzaX4cg2j6NPM5u3nLaJF1Zvn8LR2Lh6A0EietL
	RsguRVA1WaZaYgEm+E9bk36ot4haPmkFfk4vcUwKM
X-Gm-Gg: ASbGncudEnGZlENN11tZwrw5N8nXp/azW/clWawx7DgsUWeKLvyCVfC1Xjw98tQUka/
	V844PeQW+HR3pPncTiWbDvx36ETvutNLEGJBnLQXJs29tV05QAJ5JBVsIV4CzE623DsvS0y4nz4
	5LA2lIbHXbZNHyyL29lFiDT6PxTZoQ9CDZS6TW7ZOqgSsy0B2c3OVL4qkvBNKeOd2Es9flJ2foi
	ibPzBTT
X-Google-Smtp-Source: AGHT+IFxce0HLNf3NmhbLRlCJ9F+PK9cigxmx8jIuBWo3JRMbzF/75YM/UR0mgu+t4nd9d/RKhL7wrOwbbxrqB0N/OE=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr15448915ad.3.1758319411403; Fri, 19 Sep 2025
 15:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <20250919210654.317656-3-acme@kernel.org>
In-Reply-To: <20250919210654.317656-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Sep 2025 15:03:19 -0700
X-Gm-Features: AS18NWBBr_OMapccE_pePLiwwGgPyzXXthzaFZOsmjG_0k6N9qe5Q5gO2X5Ymrk
Message-ID: <CAP-5=fXQSA2PWCWQh7d7ou77pLvk9QcicnJc303+C_vHr2Tb2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf bpf: Check libbpf version to use btf_dump_type_data_opts.emit_strings
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> When building perf with LIBBPF_DINAMIC=3D1 on a fedora system with

nit: s/DINAMIC/DYNAMIC/

> libbpf-devel 1.5 I it was breaking with:
>
> util/bpf-event.c: In function =E2=80=98format_btf_variable=E2=80=99:
> util/bpf-event.c:291:18: error: =E2=80=98const struct btf_dump_type_data_=
opts=E2=80=99 has no member named =E2=80=98emit_strings=E2=80=99
>   291 |                 .emit_strings =3D 1,
>       |                  ^~~~~~~~~~~~
> util/bpf-event.c:291:33: error: initialized field overwritten [-Werror=3D=
override-init]
>   291 |                 .emit_strings =3D 1,
>       |                                 ^
> util/bpf-event.c:291:33: note: (near initialization for =E2=80=98opts.ski=
p_names=E2=80=99)
>
> Check the version before using that feature.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf-event.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 2298cd396c4235e2..59f84aef91b4a2ec 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -288,7 +288,9 @@ static void format_btf_variable(struct btf *btf, char=
 *buf, size_t buf_size,
>                 .sz =3D sizeof(struct btf_dump_type_data_opts),
>                 .skip_names =3D 1,
>                 .compact =3D 1,
> +#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
>                 .emit_strings =3D 1,
> +#endif
>         };
>         struct btf_dump *d;
>         size_t btf_size;
> --
> 2.51.0
>

