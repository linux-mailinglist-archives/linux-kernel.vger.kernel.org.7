Return-Path: <linux-kernel+bounces-838127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B74BAE804
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251543C21FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156B1A83ED;
	Tue, 30 Sep 2025 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkK9+ffG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845831624C5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263074; cv=none; b=EPYo19EiboXEriavRQLU+1D7oYTxDSj1slZJpxr3HEIK+cMHbez77aWk3Ca5Gln6v/aa2TbnqRA3Qtd4+ODSfQHVOyPMW9UhHrZILD6vKM2oJ8uaQ6xBVKYmzu+fj5y0gBevpePJ0ujn88d98BEaPXoMfe/6Hn2Ppibynfm+KgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263074; c=relaxed/simple;
	bh=28CiOOtE1+utCGkn71XoVKwktkzm+lmXvMrk0Texmhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8QYDgrjdoLXYGSbH2kL4w4WF/UtKtU03Hz22txo67WLaCPUfQ6cbGKBTH9aDoB1uyBCG7+KV7sy3lTVZejzzBETJRAMMLKSPUJYsymMDafDZ4jibJP6H4Y+d8zFtD5OalY71PcbAUOwZGjewR0pjgB1nQM0jk80UQ7ApepQ7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkK9+ffG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so58265ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759263071; x=1759867871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z35lL/3kx403pYQW8IvvheoMziA8YGpWpHWvXvsIQU=;
        b=ZkK9+ffGx+h4khUErsG9ROuKLdKQwG3HIpjLxVvFR+mDzLku5pe9yvP0yFta1Xv/aU
         OIfe49eiPpQHqCkoqtdho6TzKPgkQpS5noh2EXWIIOocblrWs4QTz1/aJ8oKX8jIOgrV
         BgtjwxLJCNZ+TQ8ybBUgFbMl6aIBzW1gPyZWlMK9ud9f9ekcX5FDMFBXuTXPBlopHE7K
         p5EOQ35cgPJkTR1mAT9acW3TchW+gqit4Pe8ETo2ODTc9koF99S2eUXvLl33Ww4Iqs0r
         GFuEwycBCLnBQJNmBahLC7D7plpf2B9Y5mY5QTWZ/Qr1XkgaxPXIGjqVxsKHmqZ7uF0O
         JIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263071; x=1759867871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z35lL/3kx403pYQW8IvvheoMziA8YGpWpHWvXvsIQU=;
        b=d4s3fIcBVNpwFO7eTMIVfbBh69qXm+7M7DtNOfsZWMT2zqMMOtWeqtFuKf03FP2li2
         5QQXNrT/gCz0o1XXQxCHqedkVjzHipSRZSgnhi14Oc2VBKuMiHA9nsn+dy/2j6azh9IB
         nPJsozPTsB/EZPg8RxPM8QkpJjY+UbUgQy0i9OolrXMJy1AVNOr8UNVHssKhxID0B9tt
         dmTYzfihfsa2mZ8jxDxd9k7hZ+ac50woJTTgEM693guHvJE/4ahoGerpO1ZY87B61CU/
         Cd7LYXZz9z98/ZFBWrt62YsqcciqYtxh61u5cXA/AGboekwTpUu7R7hMH7yf0wHMJyrg
         aCYg==
X-Forwarded-Encrypted: i=1; AJvYcCUv05h0GVun+lacpnY6mKsHbp70i37N9TLPogvDTD6MNhPv/rD/IoKlCftEIfLb6HQBrDrqZn1QTVnvhUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVCPK+ZU+ZSZwzj9Q8m5trXRcZEq2c7AGZ2qp9fWKRzPKGkwH
	sCELnX0lG0otlULaWXh615UAA+SNQKigcFxBJ+35krsoJOs6DdEdN/JEEGomUsmQVR4I+Kjz1tR
	+YO8PUu6UrVr550RwuPcP0Ecgpt8y9m8dLZm4R4pQ
X-Gm-Gg: ASbGncvP2EdiS8e4BCi6z/6tg8kjCNSmGet2ZO7ehkdM6tPc1bVgw6Nv4OS2o3b2CkS
	M+oF7UwFnt2eimM/p/jGU1DifBEK9Hudkiur7kqSf55dhwHFmpesB/OIJdEFY709BUmRR9LZ/sA
	04h79FpKVErMu27V+To1CXoH/fIeLupmCX30OnVfUwfuZLj7RKi63KO9CtGaL9r2Zyq1Tcck/27
	QKMcAvmVjqcll5KdAKmzffQjAWicfSeMaIhE4+T3VO0Fv+8c9FEq8crBTGgihUS8unr
X-Google-Smtp-Source: AGHT+IERdYR1/mUI7zXBnM19rHV5/7EdktMJLu+4W1r6xYhstvFfzAM7cCBplh6Yc4QT+b1yPwrOREhwdiT63r7xiis=
X-Received: by 2002:a17:903:3203:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-28e8129b9d0mr150215ad.13.1759263070428; Tue, 30 Sep 2025
 13:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <aM3SCGOXZsP3GZal@google.com>
 <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
In-Reply-To: <CAP-5=fX6=7Ycp=Su2ahZS1R0wS9s4eozPPcBgMBG25UCaC6uBA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:10:59 -0700
X-Gm-Features: AS18NWAMU8EozYGGxgb_yx-b4bLuOaxCH94CW8izj29kx3qqp2nmTeyfVuIUP5g
Message-ID: <CAP-5=fW6tPRW2qdFE4AbXg+47CzTjDX5HEjenjTxgOZ35fFa8A@mail.gmail.com>
Subject: Re: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Sep 19, 2025 at 2:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Fri, Sep 19, 2025 at 06:06:52PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Hi,
> > >
> > >       Please take a look, noticed after processing a patch from Ian
> > > for another such issue, on a hurry now, haven't checked when that
> > > emit_string was introduced.
>
> emit_strings was added in Linux v6.17 and libbpf was tagged as version
> 1.7 prior to that.
>
> Thanks,
> Ian

Ping.

When this lands I can rebase:
https://lore.kernel.org/lkml/20250830053549.1966520-1-irogers@google.com/
on it.

Thanks,
Ian

> > >
> > > - Arnaldo
> > >
> > > Arnaldo Carvalho de Melo (2):
> > >   perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
> > >   perf bpf: Check libbpf version to use
> > >     btf_dump_type_data_opts.emit_strings
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> > >
> > >  tools/perf/util/bpf-event.c  | 2 ++
> > >  tools/perf/util/bpf-filter.c | 5 +----
> > >  tools/perf/util/bpf-utils.h  | 5 +++++
> > >  3 files changed, 8 insertions(+), 4 deletions(-)
> > >
> > > --
> > > 2.51.0
> > >

