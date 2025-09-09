Return-Path: <linux-kernel+bounces-807910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6541AB4AAFF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211CC3B0C45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382131CA7E;
	Tue,  9 Sep 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHrtPiqS"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44631CA7D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415474; cv=none; b=A4nXd+rDUzIFf3DKO+1hQPh/WLbLZ7pMYK+Y5AjZVQHp7Tp85zKtj66vmYH6D6STbZLGJggmbvZwrI7+KpbDJnnDRnxY/dGObtHbMv6zwEyIjLJY48Mf738yZPG/vjMELpueEEdORtK6v6Xwr4Xmi3P5JUcznaFY9FYSLQ2kuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415474; c=relaxed/simple;
	bh=2qJii75iX2H9ZNmZHO96TRyyefKym2oMcBVinEsMC3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m69YnyS9bfARW14uOso6THRnQPoCuSl3mBzFJhoOuR0nxlj6ZYa+fQr3AEg23di8CXtauuEenv0NcYrTDWxAJV5y0MdrUlYo1yKNWaeSwcgL3uUSPfonpia7eoNZO+CRDdygW0GW2GuFPVeQytKd4jWqR3hewXgx/lN38tG0dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHrtPiqS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-323266cd073so485970a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757415472; x=1758020272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOj657j5Mnz8nVz+aHzr8oWclDauOAy9FeLA5tjE16Q=;
        b=dHrtPiqS1VZM0UI0SiB0xsl+itFnqtwkkrVklzKNexbMHFJLuOXKzgY8LxTDtmbIt6
         GhY0HV4pIFIdU8D3/2gA8OWldM+gV9KFerqT4LZ+2YSdRveymIoZrRW2flPrsTHZF0C/
         aDnUpsGxmgiZlSP4kDnjIytEO7V/H+jCQkakVc50NoAm1Z0IE+j8vFLVR+uWPvr8Zy9N
         lMURjwcvcbvzuhFqd0v0lhTmRq1eBEzS3VakiEOY0lifJjWBWZlKStWjSDN7G+Xj5KLP
         p4isBv2c8hS4BqGXGimtmTqtJCuKTVRATYAvPtvF+jQ3cA9KoRGOLHTQbpHLqgkLZ/nT
         Uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415472; x=1758020272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOj657j5Mnz8nVz+aHzr8oWclDauOAy9FeLA5tjE16Q=;
        b=DBPoO2peEltzL5bK9N9Qq9LK4cSlcYMd1pJey1WnEhV70Z5FiyMDqw3eUnrGwxcm7j
         A5rVM5OGZoxjGpPNHYeq5SsBu+nqV15Dy4rKZ4zfdh7se9yRzS4ViECTxwj13CaQCNGR
         ysCIMXeLhu+Mg14ZbsFj0X6JuhLvkMc1N0WlvLSZWi4KMj5gpzX+oKgkM5bHMCOjAd0/
         pEJ3LvK4No3D+fUiKDJr1YaOfEw42gy0Qo6qM4DApHFmhx46VjCNeyg9gIq+TIwEaALI
         CAzsae6O/QQb2OwfkaQI0b9hgOf95dn1OPfslMq3gKVulriAE4o1C3oUt8zoSjLheS7N
         QMvw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgAmreTx7CSk6H36u5jpD+70/OLYfBsZFqkbyoVg4JOvEvynQ4dGTwFjQdKklZUiKQO1XiXJl2Ti+z8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4mJxTQhMMSSwKoaKkjaBY7/GPVUyzH5HNSP/tG9Q4lO2rTfV
	q0yphBUvL+FfqbwcbwlTP3pRCN6aEBEfZQBltNwvJg/qSqpjO/3T/0bqNmTY+sWhnsK5sljlLnC
	AIPtvlbOGJid/A7nHmd7OKpov7OZ7jr8=
X-Gm-Gg: ASbGncvHtJDkFIYqAE68ldL0z+9l2F1Zc3JPOg6abWolw/KYnzNxNLg8HWSxQmPt/z9
	gaA0ApstCPqI+v45ATjBk8+A+jfIhcqR6BWA7M4Rc4qqIHRa3GzuQpZsU/zf/VkrDbISTqYNEus
	c0w3C6sCfcK3OuVglj9YEpzoZOmQKH/GGO7GaJO/DR/R3+95VSQWzUukB1p9oGWZdEdhrAl0DUf
	AkL4ozVlpJhut7q6/puemyAct1lXn2Te8qhCkl0K5PBPBO/al6jC9Dzx4j4/Qo8TFbzgZwPzbyp
	/zl8MKAYd0lYd9k6jJs9VKK+KVSO9kw61Hmx
X-Google-Smtp-Source: AGHT+IHmJSD9mvx32JMCMKUtj+A6Iea7OUmn870TZehtVnrYC8OSU5oHqTLumOjvLIOX3eQTIcrVZlGUnPI9cim9tKY=
X-Received: by 2002:a17:90b:1d12:b0:32b:6abf:d94e with SMTP id
 98e67ed59e1d1-32d43e2b577mr8427871a91.0.1757415472504; Tue, 09 Sep 2025
 03:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1>
In-Reply-To: <aL9Ch_XaYTxMzFXK@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 12:57:40 +0200
X-Gm-Features: AS18NWCGswd-XFUKG33qMZwlodKSwmA-15DaQhSx_nbEJ5Xz7_FyaFy_GrM1YqM
Message-ID: <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:54=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> +       // a seemingly Rust mangled name

Yeah, it is a Rust mangled symbol:

    core::iter::adapters::map::map_try_fold::<usize,
drm_panic_qr::Version, (),
core::ops::control_flow::ControlFlow<drm_panic_qr::Version>,
drm_panic_qr::Version,
core::iter::traits::iterator::Iterator::find::check<drm_panic_qr::Version,
<drm_panic_qr::Version>::from_segments::{closure#0}>::{closure#0}>::{closur=
e#0}

From your `grep`, it seems that is the only one you see? If so, it
would be nice to understand why.

Cheers,
Miguel

