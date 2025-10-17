Return-Path: <linux-kernel+bounces-858540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA55BEB19C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAF7E4E587D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87757308F26;
	Fri, 17 Oct 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpYX0lXc"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB8261595
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722827; cv=none; b=mU7vo9nXpULOiNrOZCnsZ5oD24YXyB1b8HbXOONEhsxM+J6ljuDbVS6Sahsj4OSnc+O0yXBa0RrWj560/6mahec+tDIZcgtg2843uVue5AbONR2YH8quUck2OGGyFMCk4/DxdHxR07O6rh+LuuYgjhLIcojWHuJzCVnhhyfQ4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722827; c=relaxed/simple;
	bh=2RysdHxuMiEeGX3LMu1oRMBi5KuQC1DwjQsH18ggAek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mwDSOgcjHPikQ+QbeYMC5n4+y8m4ioRsVlBpoXEKURSPCl2FEQG97FENN+SZeDDBJsoQElZjd/oQDu3RdhtHQrFn5GzSMeQEwblFJJuP4XnHGCs2o9ibsrRiSRdH4ChZBOUcqLjwmTqm3GBgwkHqvraeRK1Y6jBH4oZpqv0bqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpYX0lXc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b63148d25c3so1382322a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760722825; x=1761327625; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7J12+qTHU1oshcnB/C58fDfVlviejVYuguJOo2R2Bs=;
        b=SpYX0lXcy64oQYQEd0HVIY0IERhReUTR6SEibjDLESsggu9RHXZ851vcErOlOqMa5R
         lfGOeQnEOa9jeA5q6J239Q7NTeOt4gac/J0/7NJH3kmFcEy4DsAyHUCVwcKAtCeieV9h
         qXdI5MMqS8U9qaLrMqsYttzxA6BYIP5sgenKA1u5ZQl7lBorFjoQLvwN/dI2cez78Ivd
         PxkmToqbO8O6vTqJPAW8owBxSvuwRU+u7ZZdQ1rNI4B5F9Qsm1LbzfjUtNLN5RpX7xuP
         U31I5jNPN4ap43qQKXCEARHGlPJKDoMpVle8ststA8Z13fjRZXeuTIx+JW38wB81R8yO
         mSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760722825; x=1761327625;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7J12+qTHU1oshcnB/C58fDfVlviejVYuguJOo2R2Bs=;
        b=E6rG2HRJBxk9RRCFOoHJTrRJ6zZVZukvld98E3FivNJT8qOAAiwm6Z1M1/VnHDpncj
         +oE6JVxP9x7xphhS+mcsmLEwwHEDL+JCoN6macuuzoysRVuDZeKc6+Fcj99LEHFkpbbT
         11BzGbg8P1QeGMtiBmCkRm3X2TacciGbpVqHJDx8eUPvd5iPxrCboP29BpHuXjj+gawY
         T8xy2Gs9AC6EY0dsSfcjrDUi+joUbJwdIQHpS5h3k1JrEH9a56SaD42gu9OLY9KFxulH
         rETqdtULQvzwXLvH0sz222N8p+F6LSPPBdlvs/vEHypNaRt0oT0hyRONaU4hzNQjMVbZ
         EwOw==
X-Forwarded-Encrypted: i=1; AJvYcCXXy9lGfPMPW6N1CsvYFsmdsjk3LRNiMuaYn7HT/HOCAKiRQlMSP/mhKgFQc6YUznZIFraByK0JntgSeio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJt/VHNEHmWSdcLhEMwf7F4geBs5gftjvvilqxdIjvEMfzaOZ
	M0kZ2wsXup2fDK7gmhCcPb5je39C1zcW/UrV3kwrf4sovRnEWekcIvcE
X-Gm-Gg: ASbGnctG+tBzHLVl61ZqsMv8RLpKkfoeCkMw+1XNn7YWp7bgNeK4oixTY7ehqJE3oCT
	ss6mGIix2enznCwxaPcyrT6w15OryXjhYc4BGYCs35DeWqcSxYnr4hs+Jy0/g306ruTveD+43GI
	Zl53bZCA4HZF/mA5OJ5RHcBH5BMmOAao2GkRKQs33/G2relJ0Nx21JiM6r32nAxjSrZhHHlSIOu
	AGe4LImbOeSIeQDdBkLegmi/olH3ETbahwjAkJpFs3QDcOc3o+IKAly+2JLIBz9TyqcHvrXrRCY
	B/s5THQ8ej6WOLHZ1V1UiYBoxENl0EhI+bNQE6eS9Pp0owQRpvXNi0dl5mUoZonBK3y/nXhl2Hm
	4aUePHiYErPuu1jkUlRRSEl4feMfkKK+MauTnl/cxpLHZO/8EAU3YteCuFhQH9RtEJClM5xNdFJ
	T34UfQf4e9QPgr7+fe7L6UM3xKfirYwY7sR6M=
X-Google-Smtp-Source: AGHT+IE1kHqHrep5C3xUFAnjuWiDhRo+OW5gMsEsbnV93uBVizwW/D3B1IfWyTNFusVOT9RxT3CGtg==
X-Received: by 2002:a17:902:dacd:b0:282:2c52:508e with SMTP id d9443c01a7336-290c67e981cmr65676475ad.8.1760722825391;
        Fri, 17 Oct 2025 10:40:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:49ef:d9f5:3ec:b542? ([2620:10d:c090:500::7:77fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcdefsm1127105ad.16.2025.10.17.10.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:40:24 -0700 (PDT)
Message-ID: <1ce0c35c4c444ba85f753df5b0d0c5cd4870d887.camel@gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tiezhu Yang
	 <yangtiezhu@loongson.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
	 <linux-kernel@vger.kernel.org>
Date: Fri, 17 Oct 2025 10:40:23 -0700
In-Reply-To: <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
References: <20251017092156.27270-1-yangtiezhu@loongson.cn>
	 <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 10:20 -0700, Alexei Starovoitov wrote:
> On Fri, Oct 17, 2025 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > There are some set but not used errors under tools/testing/selftests/bp=
f
> > when compiling with the latest upstream mainline GCC, add the compiler
> > attribute __maybe_unused for the variables that may be used to fix the
> > errors, compile tested only.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 ++-
> >  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 ++-
> >  tools/testing/selftests/bpf/test_maps.h                        | 1 +
> >  tools/testing/selftests/bpf/test_progs.h                       | 1 +
> >  7 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_o=
ps.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > index d32e4edac930..2b8edf996126 100644
> > --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > @@ -226,7 +226,8 @@ static void test_lpm_order(void)
> >  static void test_lpm_map(int keysize)
> >  {
> >         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_=
PREALLOC);
> > -       volatile size_t n_matches, n_matches_after_delete;
> > +       /* To avoid a -Wunused-but-set-variable warning. */
> > +       __maybe_unused volatile size_t n_matches, n_matches_after_delet=
e;
>
> I think it's better to disable the warning instead of hacking the tests.
> Arguably it's a grey zone whether n_matches++ qualifies as a "use".
> It's certainly not a nop, since it's a volatile variable.
>
> pw-bot: cr

Maybe something like below?

--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
@@ -223,6 +223,8 @@ static void test_lpm_order(void)
        tlpm_clear(l2);
 }

+static int print_stats; /* debug knob */
+
 static void test_lpm_map(int keysize)
 {
        LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PREA=
LLOC);
@@ -334,14 +336,14 @@ static void test_lpm_map(int keysize)
        tlpm_clear(list);

        /* With 255 random nodes in the map, we are pretty likely to match
-        * something on every lookup. For statistics, use this:
-        *
-        *     printf("          nodes: %zu\n"
-        *            "        lookups: %zu\n"
-        *            "        matches: %zu\n"
-        *            "matches(delete): %zu\n",
-        *            n_nodes, n_lookups, n_matches, n_matches_after_delete=
);
+        * something on every lookup.
         */
+       if (print_stats)
+               printf("          nodes: %zu\n"
+                      "        lookups: %zu\n"
+                      "        matches: %zu\n"
+                      "matches(delete): %zu\n",
+                      n_nodes, n_lookups, n_matches, n_matches_after_delet=
e);
 }

