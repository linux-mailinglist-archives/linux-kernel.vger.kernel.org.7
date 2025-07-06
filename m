Return-Path: <linux-kernel+bounces-712252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C961AF06A3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 00:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A7917B279
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4860E28468C;
	Tue,  1 Jul 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1gDnitJV"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330421A0BE0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409552; cv=none; b=J0WT7B76FZ5v8zd8rn3EpKRznwCo5WLBQCCCu55Fm8e6fbEp23uI9pKO+igmKoRgrSIE6E9j5DYdWv4X+vTvKXXXqDLW4BwFRvO2eYGjyLnOrsLrQAofKefsuu7ICpBRKagpkbrjxkJ1/iUFFj2baLp27qKzd1lMAOQqGw42gCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409552; c=relaxed/simple;
	bh=m4cZDXkfcfxBQQaGP86b4lphrrWWQtEyDVX5MSb8vD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsAPyVuNnA+armfiM7KqPbRzD2Z2UMK4YatGHyo+Xs8QGUFkrSueyiFQMJiuObxWLuSO9w76FgWqWjkMdfZoMCN61o2q+cMRVvwCeVAhDJw90G1YStFfXhGOfab/6Fp3ZK349A1gvGYLfxzwq0tZca5Gqa1cfIqqLK84NyVPlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1gDnitJV; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3de210e6076so188125ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 15:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751409550; x=1752014350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpyGEdDpnCEn2a42JaX8WeXreftuN9Iuk43Y+AJ7NKA=;
        b=1gDnitJV9/n3i7vOD54ahYulIEtYytLIP9ncV5FEziUoBXvzNbZQYT32eOHVOaxukz
         94A+huWWIigwq9sMCNYtPD2qpnOdbGa8pPhZG7gj64yBdRl6uHXWFBEmGd7cOlU+L9G6
         S1odryf5Q+OlX4y56BAzdfVjnM+6XV9DEG3nD5IkpWAphuxp09AVwal2LBCae3/nMZyM
         sJEzkeEbbI10Zo7lg3nTEmGOa5dZfsXbAy97iSlBSGPLdcLVhY02m8Px84LgXg/uYIq0
         aNPLH60RKhJR4gP/dwBhvSBncbvviAgKAsc8UKgmafZysQdCa3pwvPdfC7V/E4kl22Sy
         OOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409550; x=1752014350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpyGEdDpnCEn2a42JaX8WeXreftuN9Iuk43Y+AJ7NKA=;
        b=qOKUprV8amrn6rBfzoGZmhp3nmVXOX1uCDd0s7I5yczzC0rT06aN5fHZX02T+XsKIv
         cqQ2dBDGeKqaRyso3mAUndPCYftOifBKYCdV7YwoFytZWUfpxIrOtYdXoo10kGsL0de9
         qmuizpRSqdCFySDGNipjzTRQqqVcwqtEw3XHR1qFRe7yicnCDmDXuPlRIoQgk/JaHrxh
         YVyIo1EvT/h/ZhH9jLyLKXnlR3Z1syRCq73JHPVesW0guHFONPQvgumj4CnHBD9Mx0Ym
         CBJif/TTkxPc3/U/ksjT3NA6RhjI0zSiBoHyzWj8T+qlVgHh60wQ4ABDfzphZ/yaZCfw
         GThA==
X-Forwarded-Encrypted: i=1; AJvYcCUfcK38hhznY2StNdY4fm/j3lVzI2f56B+EMM72zU2LrXW/FuWmnvC4WLzgSbeTmYOiqtB06ws1T1tOqx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEJMGi41AzDVTVsQMqHzTBTdmrpUW2oJ78tzAr3ZCsjqLGzfB
	A63f0404ypYJvNXdQXzyHgzlwwBjH94A1AaJfqHdN/2B6B3gFNFGODH33EnVXSHKWsKm5ImLCKG
	2oKKrZ2JMCpJCYQ64FCLwKLzUVqTsdTr4p6/8Pm6j
X-Gm-Gg: ASbGncuQlxwcTffg9Ev80D5ci6LVHAM+FUz4+BSLpXKgTaguu078N8XzXUV68vQ3lSa
	bGxftLnQnX9ZKhEsIV0WgBKw/Urr1MKVpomzNxVDZhZ26RsL/4bZs9DU/JYDkswiVNMqElGY/7Z
	B6iSFGFui6Hb89uQwMCaI9DV8uDs9/iO6IrutOG53c1Vv2fND9dMfHJf6HeFvsULoyKe2Eff1o
X-Google-Smtp-Source: AGHT+IEmmBEGqi3IIDg+Q9SNOxMcJnafO9w31t9izo1s+lT3b5jydpD1uzfZpVKC4GogDkVz4p5tY/A89IQ83k5rbVo=
X-Received: by 2002:a05:6e02:1b0c:b0:3dd:d664:7e0d with SMTP id
 e9e14a558f8ab-3e04a0a52f9mr5650785ab.25.1751409550078; Tue, 01 Jul 2025
 15:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701201027.1171561-1-namhyung@kernel.org>
In-Reply-To: <20250701201027.1171561-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Jul 2025 15:38:58 -0700
X-Gm-Features: Ac12FXx8w3Jn8xxCAXZNurK4Ls8Y-aDt3TJ2dVP3A0qFSOTJrlYz0-lUdd2AlQs
Message-ID: <CAP-5=fUzPcoMstxfxTiztVAjNwbhny4=fhRnbSu61-sq1k=rew@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf test: Check test suite description properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Currently perf test checks the given string with descriptions for both
> test suites and cases (subtests).  But sometimes it's confusing since
> the subtests don't contain the important keyword.
>
> I think it's better to check the suite level and run the whole suite
> together if it matches description in the suite.
>
> Before:
>   $ perf test hwmon
>   (no output)
>
> After:
>   $ perf test hwmon
>    10: Hwmon PMU                                                       :
>    10.1: Basic parsing test                                            : =
Ok
>    10.2: Parsing without PMU name                                      : =
Ok
>    10.3: Parsing with PMU name                                         : =
Ok
>
> And keep the existing behavior when it only matches test description only=
.
>
>   $ perf test "Equal cpu map"
>    39.5: Equal cpu map                                                 : =
Ok
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/builtin-test.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 80375ca39a37a256..846c9b3a732c9b3a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -539,6 +539,7 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>
>                 for (struct test_suite **t =3D suites; *t; t++, curr_suit=
e++) {
>                         int curr_test_case;
> +                       bool suite_matched =3D false;
>
>                         if (!perf_test__matches(test_description(*t, -1),=
 curr_suite, argc, argv)) {
>                                 /*
> @@ -556,6 +557,8 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>                                 }
>                                 if (skip)
>                                         continue;
> +                       } else {
> +                               suite_matched =3D true;
>                         }
>
>                         if (intlist__find(skiplist, curr_suite + 1)) {
> @@ -567,10 +570,10 @@ static int __cmd_test(struct test_suite **suites, i=
nt argc, const char *argv[],
>
>                         for (unsigned int run =3D 0; run < runs_per_test;=
 run++) {
>                                 test_suite__for_each_test_case(*t, curr_t=
est_case) {
> -                                       if (!perf_test__matches(test_desc=
ription(*t, curr_test_case),
> +                                       if (!suite_matched &&
> +                                           !perf_test__matches(test_desc=
ription(*t, curr_test_case),
>                                                                 curr_suit=
e, argc, argv))
>                                                 continue;
> -
>                                         err =3D start_test(*t, curr_suite=
, curr_test_case,
>                                                          &child_tests[chi=
ld_test_num++],
>                                                          width, pass);
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

