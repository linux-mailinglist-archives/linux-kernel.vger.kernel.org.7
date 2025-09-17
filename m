Return-Path: <linux-kernel+bounces-821457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791B2B814CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3296E2A4B32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1B2FF15D;
	Wed, 17 Sep 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="So6OoEDm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15294242D8B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132335; cv=none; b=cThYpynHyHc88nd4b7Ps0/TSwvqwTYZNElTWY8FLSO5JmJkAlplXHndrfkvr5VRa8aqlZgARYtpgKBEDKM/YIJPniBEcEqUT3mvSMI4Eg4d3d3aPT3C22OZBjgRnvbyteLVOtNNywy6U2THK6RNFrEYymnEihI0gSm6Jj+DpVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132335; c=relaxed/simple;
	bh=MSqEKzh41VCyG9sUnCQ9EAyOn6P8hvgQK1BtnTXPxDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Dssj5V8Y2g2WJgJx9HAV3a23nniodLhJJqCVsKosuMeupme9vGmRd7IxO/jpOPECrjD3/1woqNxSD0de4m2FxPYl6BvzhBewxgLsVTUdTFCydgu53m3T7AlXkbCz3EUUzHODGvttJgGM+GAwi2L5p7EsGqlomvQIdYlyzvuLhT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=So6OoEDm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-265abad93bfso21925ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132333; x=1758737133; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB9k8zghfEZp5b5KEYFYgK1mtyQZW6vQAuJhWb7VkRE=;
        b=So6OoEDm/xiINVKyijLLswjRprRpzLZ8Jpb2K2ujlTcf0kRmRAo1kGCrTAiH8+6Xxm
         FOyNsTw3B94b34KelU7DaAVfFvqPTolbK4LtOIVfFbgfNyF4oCMOSO4oIyL8RVFRvp6r
         Xtngmnd0EXmfy6SCJHfoe/4D0W7PgLVe+RC6vuNExVhH7pl93yZ9bq5FC3VlNcvMbIUj
         JhozX1Ig6a81P2O0yrnFZIcOQxCpV1CXBK7V5GOiXwScOrnekRQxm4fgNmxin1uAaWSI
         zg1B5dcCdLNqLRQAjtK9SuqXa/2L+Y0PijyZHkj/vVhIhHSRvvxY8RW6yM546qhq9q9P
         uOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132333; x=1758737133;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB9k8zghfEZp5b5KEYFYgK1mtyQZW6vQAuJhWb7VkRE=;
        b=xNkZOCQ4BUJHgwQhuAUHubEya1yi2vnMID3tkCNT9GZYvvDGP5K40BR4WEOXnm/KYH
         wP55BUuOAwTQE2qMTQsQIAwR9yGnuzdiCD82tTNON/kPxPZd4fCLnjscnpk6yOjrDjSv
         GgTixwzItxdzBBgEGV6avOhlI3P92I3OFpXI5703xfB67e1QX84cjdcnREd3zLKKGVfL
         JTM4FHtLIdzA2x7D5XRhVwBKDufAsVSXnMg9NE+I0gM9u8qL1h4S1o8RgR99sSU8944m
         3MpuvFmLkutqtO9ocIvbYHluvx9x3vL2VqPVmSu2OFdlGtMbK4mEzXTT4Zk/WYQSlZkM
         fciw==
X-Forwarded-Encrypted: i=1; AJvYcCUJB3Yy5X1RhDgkYIRMVRBQgezX3mEuGoKSgU6OT9OjJistfsXFCH6wQfhxhJyi0A2LfqFVDuEoSCZ2cQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+YhZ4xkHnVujKy3DBsmJKKqnl9MjvJungtLuuj7pO9D/+oUC
	xGy8MVXuwWiFTxGDQ3u981QmMSbQuuhRoemnXpuFMU/+F4YNyFwB2DEc0jJlUrnfBtJso8G9Q2k
	/UWNoHzxXIb4mfJNvIl8gOas86G9xDLwIpjM9yjUf
X-Gm-Gg: ASbGncuoiSDDylTQO42pFFofqp5KxnporFwNI5BtAv4YVlmzwM/p69Is4aFMaB1pPut
	un+jNZ8wntklunLyvUHzmu7CYaX2LfmWd5oQsENaKGA/FozITrmVyBbeOz+iZbb5q1/HXwK/U2B
	BDGW6tSPU0xBEkAAlkCGLmP6gQFBYhNNYKQQz4KVZzqEJ/op6dIVRsJd91MmZiNt3wDv7xom5aP
	KivKFQHC33M+4gxbb41fvuboc4J6kGRPLfddRZlUB6+qG1vwTvCCA==
X-Google-Smtp-Source: AGHT+IGfF3D8R21uKy2Xpl4cZvXu67GMNs6WZ+vo0s0Vdh/pY7u4pma0OnOZXdrCP074WN81gn5DVAQbIBHyYLUb6po=
X-Received: by 2002:a17:902:dac2:b0:265:f30b:ab00 with SMTP id
 d9443c01a7336-26808aebb83mr5849095ad.17.1758132333171; Wed, 17 Sep 2025
 11:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905042643.1937122-1-irogers@google.com>
In-Reply-To: <20250905042643.1937122-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 11:05:22 -0700
X-Gm-Features: AS18NWBkI9kYiZyqngvLWLVxXTvIhBHU7i27lLNk55KDGwSKomZzmJMUJhpRkJE
Message-ID: <CAP-5=fUSuh+hKVg_1owmzPAZka3DGmhr6FzN__n_Cb2XUET3=A@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Fix parsing of >30kb event strings
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:26=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Metrics may generate many particularly uncore event references. The
> resulting event string may then be >32kb. The parse events lex is
> using "%option reject" which stores backtracking state in a buffer
> sized at roughtly 30kb. If the event string is larger than this then a
> buffer overflow and typically a crash happens.
>
> The need for "%option reject" was for BPF events which were removed in
> commit 3d6dfae88917 ("perf parse-events: Remove BPF event
> support"). As "%option reject" is both a memory and performance cost
> let's remove it and fix the parsing case for event strings being over
> ~30kb.
>
> Whilst cleaning up "%option reject" make the header files accurately
> reflect functions used in the code and tidy up not requiring yywrap.
>
> Measuring on the "PMU JSON event tests" a modest reduction of 0.41%
> user time and 0.27% max resident size was observed. More importantly
> this change fixes parsing large metrics and event strings.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. I think this may have gotten lost in noise about things like
hardware json and the python metrics. It is a small change, bug fix
and performance win. It can land independently of anything else. PTAL.

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.l | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 2034590eb789..1eaa8dbc26d8 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -5,16 +5,14 @@
>  %option stack
>  %option bison-locations
>  %option yylineno
> -%option reject
> +%option noyywrap
>
>  %{
>  #include <errno.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
>  #include "parse-events.h"
>  #include "parse-events-bison.h"
> -#include "evsel.h"
>
>  char *parse_events_get_text(yyscan_t yyscanner);
>  YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
> @@ -222,10 +220,6 @@ do {                                                =
       \
>         yycolumn +=3D yyleng;                             \
>  } while (0);
>
> -#define USER_REJECT            \
> -       yycolumn -=3D yyleng;     \
> -       REJECT
> -
>  %}
>
>  %x mem
> @@ -423,8 +417,3 @@ r{num_raw_hex}              { return str(yyscanner, P=
E_RAW); }
>  .                      { }
>
>  %%
> -
> -int parse_events_wrap(void *scanner __maybe_unused)
> -{
> -       return 1;
> -}
> --
> 2.51.0.355.g5224444f11-goog
>

