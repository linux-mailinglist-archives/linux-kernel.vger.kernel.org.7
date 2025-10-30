Return-Path: <linux-kernel+bounces-879131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ABEC2257A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2488A18840F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8CA3314B8;
	Thu, 30 Oct 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iglJxxgx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDD329E7E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857291; cv=none; b=h1pnDwLxAjXxMZXxePl4aN+BCpIf8wheu5uvqcoxV3anP8GtzEyESPFx3AWBhWiEGYayOWSfpApkxY4FW9wxXL0YXFS5i9joSlBCmgZMRP4ZAS1/nseq/0b7iEYsI28Z5EtTOxatXe2UxWjLpTfd5zoJLx3toe55eHe6uj61aMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857291; c=relaxed/simple;
	bh=Fz5PXbsNrcSaKnNALENxX8MfnuZdWTAdB2j4iUi4yJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxNgIeV/omSZrlePWXTw+YMoRS19QmBPoPw+ssYvop0HHXG3IwvPenC12sADFMyYCe8KKcVKwmzBy2DR6Sjx1vEcJWeyhjSJU+Axptv/vyu1U8PsP5FORfGqFVpsFcmgGoy4M6II8FOpp0oCwbs426ecsZfYjOCjPJNSFNYG2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iglJxxgx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eeafd4882so56775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761857288; x=1762462088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhQQ7zOAq6MhzCKRAcJwq7qvtQnnnWF1CQoqWqCYdV8=;
        b=iglJxxgxkBV/TCOnMqRI2i6sStNm1aESmgUF5R4eFsza/TiP38+B5N6gjsAlpRzsx9
         Nk5e6ct90vZ8V6cMMxeFrqLwdWZk9LrbPgMSPSJrHpm1y8lqHsQP3vIuTHmLB4Iw9lEH
         on+8d7aoLA9NCjQUKIc6GIQYA6pTVhRGYd9u1Ktgq1Jcjw7DhneDi4pqdhB3nKnjNOnJ
         rlruaNxgufr4i06tpvxMTgPyde/QhWYIadYqhFdOaKBahnfuqK+F0Zu3bGc3AdBYv/qO
         6d+x+Z8Z8+aqd0r52Cn2eJIMpmt7OEnIytwMAmPYaOwfZBqWGQYPvVUX0U8wvlbs8u9U
         TFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761857288; x=1762462088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhQQ7zOAq6MhzCKRAcJwq7qvtQnnnWF1CQoqWqCYdV8=;
        b=Lxly2+4fJvDKKCZhAOBFcp8BOc4qCUu2YyAuhBFDoXvRGEtA8j7HJsrbU9Hdd9YLBc
         UYBZCBpvhOpJQwAtMua7XKL1SVE0ezxEEcRrGE+iOEG+X1PMqa9VS3WtmHxoDZ21Y2yT
         5hn6pcb45nggLrFajkr+bSM8y3ZWYdQJwE4EnzwcL3JVSabSz7XgSxS+/hEVWUFoeO9B
         9yt044x0ZRAN9amTetVuXadoi45momfl5DR6fhyi/F0PpxbzO2h9SwBgxIoKXQP70TJp
         tOtdXbO9oN8FBrsbfOpZrt+cEJ3aZkzGUocms34Lw3YmzpJ2hWTyUQ+y0+58mvJE4YF3
         cGBw==
X-Forwarded-Encrypted: i=1; AJvYcCU0r8SOv2j6KOy1UJnroElPgWbzr+5T9KB/SzVAJKDpi+UbTLzQQ00qSchjX8CCJS42Jnmh5/eTT+utO4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyX8MyjuCxl9XK0yvA9IWt4YfEvMDvKXqh7Xgb3gC9JfwYgVI
	Ms4zc7TMrXVNwFmoEYWGwfOMLWrDooty7MXIGpEBSc01CWLKB7PQ146NvW/5YsgQoXunlQqn+VD
	i0H3S/DAn3xObMdrM95ZoyQaUrf5kJDORI7pMcsDl
X-Gm-Gg: ASbGncupVfgDknidpdYk5Ve/OS4crw8LQXGT1QN1TGGRpP8icJRQmlauvswOYvRhbMv
	TmCId42bWrwMS1WYqmRP/SY2cVPeb2DI80rHKAzWfXkDkFzI/XJMGuXSpxM7SbjhrhodO6YRsKS
	bk/vnuNn1yr2U80Z7474N2aRn529wpvJjbFKVFu9kvbHgPmzvqs6VH6AaJuOq4qbkPzzobIeAW3
	UTgT64AOzbAjny1YsTxTUIO9dO4Cm+M9VRovhoG26E/AHlG4Mm7i+IyQta9VMGtV9JhGmdho0ka
	i+ZlImrmvE6zhaRSb9JmfAnS
X-Google-Smtp-Source: AGHT+IG7DYT6OKhAgWj/D9qPmgJi3LlzwZ4lb9oX4EL82poH9qsGt6wZSc55m4UfN7seDtJR27dorjECISDHYLslg2E=
X-Received: by 2002:a17:902:e887:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2951e61f5a3mr1155985ad.4.1761857287361; Thu, 30 Oct 2025
 13:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com> <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
 <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 13:47:55 -0700
X-Gm-Features: AWmQ_bkd44FjAB5SigD6PjGDXSbK6BSfXlpCgpsX-KWWmt8cQFNDhZMfuF4fPug
Message-ID: <CAP-5=fVBXUeEH2oi6NU2Hs5GCBUqW7BMVUJ6=LDTBfmb=xoL3Q@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:22=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Aug 21, 2025 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gma=
il.com> wrote:
> > > > >
> > > > > Hello Namhyung,
> > > > >
> > > > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf=
.c has
> > > > > > max entries of 512.  Usually syscall numbers are smaller than t=
his but
> > > > > > x86 has x32 ABI where syscalls start from 512.
> > > > > >
> > > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in t=
he middle
> > > > > > of the loop when it accesses those keys.  As the loop iteration=
 is not
> > > > > > ordered by syscall numbers anymore, the failure can affect non-=
x32
> > > > > > syscalls.
> > > > > >
> > > > > > Let's increase the map size to 1024 so that it can handle those=
 ABIs
> > > > > > too.  While most systems won't need this, increasing the size w=
ill be
> > > > > > safer for potential future changes.
> > > >
> > > > Do we need to worry about MIPS where syscalls can be offset by 1000=
s?
> > > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@a=
pp.fastmail.com/
> > >
> > > Argh..
> > >
> > > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tai=
ls
> > > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> > >
> > > Right, it'd complicate things but I think it's doable.
> >
> > Should we merge the x32 fix while waiting for the hash fix?
>
> Just a reminder that this is still not resolved.

Ping.

Thanks,
Ian

