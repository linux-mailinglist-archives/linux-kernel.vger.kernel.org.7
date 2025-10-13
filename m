Return-Path: <linux-kernel+bounces-851302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD5BD610C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268A318A717F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACED2E8DE2;
	Mon, 13 Oct 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpoZEkWh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A6EEC0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760386941; cv=none; b=pxHET2o5RNvzeiB8vgXSd5nU0ISZI5Ubqf1DDJLHQyKNNpdTq3a8tSKewjodGe2KrzAUhaEh+onfVliUrjIDQ6HOv4gIuYCu/eDK6ru6jsqcYTdtBRYXKEnaOjA4KgiBVBFaw0wq0RhNHop4WZuCUQccue67/M0c4QSgkqtCToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760386941; c=relaxed/simple;
	bh=QsRpjtxk2YXgccJYdtelO5toq1Nqn+nzOxGvRT5A95M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ7NIoDHCUlHnzHKqBmC2PcCjc7BUwIRl2ihEwet8iSQiP+iCW9QIxpuUXM5Gk/CEYvi65r2bQdLu+22XBjJILGJ0ThzgKXYnLfPJ4Cum1VWUeGG7gcxhDXj6wE7mRi1AXSCDF//sAW1CqAviN2YPtp18bfqQ5BzUo749uW/3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpoZEkWh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2731ff54949so439615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760386939; x=1760991739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Enw/IlR5eMQv4LQS+pl4o9NnaHsXnvsQKnh6s2+WY=;
        b=bpoZEkWho8EtoIO9qKnp5Wwot09odDn8cwSmnPwHU+o0nlCxB3uz36PTxvyHFP9JjS
         ws03L6G7xwk46yVm8zxUf6nWGNxxJK5qc19nfIxUgvWw3nNx60yA51r1evFheSRx5eK/
         HYWbRkfaEqpPGnjNBQmzw9SrFKEBiznozUqzsiEgxDVXmGfW2VhG6K258snWMijOcmQw
         qjZEpUXmThc2OQV2d+mYMU/f7CRhAnA6mlTGLyRSrBUoYjq4DntVoRvg2PuUHj2aRCg8
         BCyhZrk+RehB6NvVtuihxDJCfGmvlXgnIjZ69i41CKeNRuSiOaMwbrZDIDeEiMfeiu3V
         MaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760386939; x=1760991739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Enw/IlR5eMQv4LQS+pl4o9NnaHsXnvsQKnh6s2+WY=;
        b=UtYkDJHAzSoxzn5oxuKPN44zq0icTB5DhrLQDBE5LRMElqMCFdDlpF6zl6GXDdUKw/
         0AnGSOFeQ4mFK8QFn0VSjYg9VFERn0HDR7paVo1W5VUJUdKZI69A83r3M+drZl82JYno
         x3Sr2EwYzpYt8wbHQS3HDX55lEd9ThDVQ4r5bUUfcy7pm2b+BKiaBtBtq08bFEEgv5VX
         mvkojRivrg+jxfN0iejouDGjZ3MQJMOkHM6owfOdUooDL7PdN33z5zuqsd9XB2qyM+hM
         Wno4m/fAnvlMur5fOGtSBI1hFe+9KOVhuKXND60s2Kg0NlC+DYRaaYtYaw2FFvSxbafZ
         eGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPuQgSx1859+4vVRAV9ul2E9UleQ9i9u/dNJj5h0F4Funh4vUNT6JvNdM64+cQigGTopga9lMNJ5bKVmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnJbm/56h00RumcxwmpALwmjIZ5yCa9/EEFTXs8NKzJ/YbP8B
	M72JAei2g8W7CExGUzMjFLg2rkJITmaTG0p4a5NpdzNvigWD6cJxqwAX9ldgF4ElPoIpydJPiaL
	4DD57b24QlHNKiOYIul//QAqMdGmyAb3QYyS+6IVN
X-Gm-Gg: ASbGnctaPw9Wx+5toCQL3xZb7+gUdLgyIujdavBS0UFV+4IsvMDXjSjkyRlP83whsmV
	7/im2W0FbArRZvPKv544RidJi+zyDUQH+NWO61kk61K4D82tFq7RMDlhYTxhnPbciOIeCXMjcfv
	lLODSbtt4Tv9Ke/5CynJHcOcMH2RZLre9JYkIFlaNJ8+oCS84+3C3lHBf9Y6EOi/xuLLm8IT4+n
	kxxF4iO6FPISkoFLz9bSa/L3ICuXEYXQ17a/XBI4+V7LYTk1ZVvZOOpVraBW5o=
X-Google-Smtp-Source: AGHT+IEcZpYJHLBQVZvSE9eDp+BP/AU+k2QtgRMfms7sX9GbqQpVlBoMtWNS3BifRo0w2321VonVZDRt04ljb/qAWIc=
X-Received: by 2002:a17:903:46cf:b0:24c:f4b1:baaf with SMTP id
 d9443c01a7336-290275dda1amr23526695ad.1.1760386938289; Mon, 13 Oct 2025
 13:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com>
 <aCz-wD2Syq8mj2_0@google.com> <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
In-Reply-To: <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Oct 2025 13:22:07 -0700
X-Gm-Features: AS18NWB0RfdS9UW4TaImosUPS3vluR73cPOKuBmKWhASCVpwckLvVIRIEkRT4Pg
Message-ID: <CAP-5=fXyxrM4eEjo1AMjBTuC2duqxZLcOPpdqudYQeWQfUiVuQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:45=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gmail=
.com> wrote:
> > > >
> > > > Hello Namhyung,
> > > >
> > > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c=
 has
> > > > > max entries of 512.  Usually syscall numbers are smaller than thi=
s but
> > > > > x86 has x32 ABI where syscalls start from 512.
> > > > >
> > > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the=
 middle
> > > > > of the loop when it accesses those keys.  As the loop iteration i=
s not
> > > > > ordered by syscall numbers anymore, the failure can affect non-x3=
2
> > > > > syscalls.
> > > > >
> > > > > Let's increase the map size to 1024 so that it can handle those A=
BIs
> > > > > too.  While most systems won't need this, increasing the size wil=
l be
> > > > > safer for potential future changes.
> > >
> > > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app=
.fastmail.com/
> >
> > Argh..
> >
> > > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > > calls of BPF_MAP_TYPE_PROG_ARRAY.
> >
> > Right, it'd complicate things but I think it's doable.
>
> Should we merge the x32 fix while waiting for the hash fix?

Just a reminder that this is still not resolved.

Thanks,
Ian

