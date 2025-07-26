Return-Path: <linux-kernel+bounces-746559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB774B1283F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 02:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3366178381
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096551E4AE;
	Sat, 26 Jul 2025 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoSCg8zN"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6929A1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490731; cv=none; b=IvU38dunZChHeWAaDyGtqVQCFslAlscQ0hwQvwMk6Dcxro8hjVWYQ8pPH/fU2sBtsw2HzqygNp9CMmCrK6vPkY81Al2EIwCCL46TjTbm5F+/NFUyqBq8XdSggQVeN9Hy7wKwqp1n1/Omly5g6Ww+GGMDNQuIBievxMnv1gjv5W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490731; c=relaxed/simple;
	bh=pxg2xmAtW+OVA7ABSm7SU28mz1UKZOLH76wzUQ4/Ls8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll1KtWw0WEXm/NYa+PZSCdeYjYez4izff9f41n1znCJ59ryCf4KllKXwvtWVs+6vMmtnsa0wfEDGwEVp8/FW3McIgtnTIoY1uFLJM3DHmsPg4bKmm4mdtfUVRoRPRf6su0GDWkNHZjJrA8TRk3hGZaD0CVrHsmbqeJGat6Rhw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoSCg8zN; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3ca89a34bso56645ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490729; x=1754095529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=SoSCg8zNJnOkOmVQK/nnZbmlCb9uvS96/TWhGFMSNh2uvbBECsZ3eWnUD1sVj//sUl
         kiQkdKQKZ2FeVFKUoVfJ5hPAQsxKQ4H/JDgmIRjuvpuft53APdblE4cKXHT6vj2I106M
         fkPtE2d9y+MpCfd3lUcLIpmX25IHWg622TpfqCPGOed61J6j8qtzR18xvpoh09Fx+SYA
         FLsGBIeH9StLhwv3oUpl4bMERm89k9TshCTrlxk2QcM3TG1CC+niwrOMh1TKICqWCxod
         v7NL0t07Z2B2l7AqVoJ3PUTIvt+6aSTo9gdO8iltcW1Bnu4v6ZNZIFeG90GNC4ec+cxE
         4AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490729; x=1754095529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=BjNq53+TLfTudnQ4UYT70FjWCvZ4owaEnkxINGF/sb2A/cBK1LY2bX3eKmuMMY4PfV
         vqts4mZr+1LhXqN/7RvWNFrulLP08h5Pzkp50nPsSPmUgOoH1o42VhVyW3Wbyl+p1Y/X
         iwZWaEun2AbXUZCDf5yhILLYi7HHSqu6inAQvb3vfSCDkfr2zMsVjA+cjARk63QKcGkp
         O1hZOxJNP4EMVW/f3N/En/SqHihm//aBY07YItc3cTS8qPFrRv2NS3qxCqLrbEGtzKWQ
         xv3WLpYjaAFalq505kksF4Kt95F8YGOd7J88QGaA6me8h71HrPasRM/6KCpLUC1Rp9ID
         64ag==
X-Forwarded-Encrypted: i=1; AJvYcCUCvTxu+SrfOi5TzNTrbhBhFwLpUxe4e3UxDae5R7Z1ut226f/2EB2Y9/gZrePxRXAshGKxI8QlamOYGVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzYypWPplHsFOvf+SMIS95kv4+6X8e/k9uUQdNKRUbLXYF4+G
	Om+3A3FaUUQkjGBLuHdFEbxAsbWIydJ2Cdcve92dzWFTCa0W0fef4YPZBdAPWu7VrC2g0I1T1DA
	Yre63Sy4UujpzdDDOlUHktQcrwgZPRzfF5nX4DGRl
X-Gm-Gg: ASbGncuxnegZRxDTl2WidAjbzhOxMizhGsytklW0ylnIvtq27BpE0utwwtCq+S+VcSN
	JSdyhoIFaasu7jRafGRvG6A/7HBCBufJVVlGtuLXV5Pdq5RChjqQnqlTH40COcXqJLjQ7a4kjQh
	0b2Rn3kLnz+JjeIlHDa2IDkgPblPopM7CqLFVJKThin5uSoMRcnXjz6k1cWwpETxxCHurE56GcJ
	aywcuGp
X-Google-Smtp-Source: AGHT+IGN6wOzatqvy/OpRoHOW2RLac4VBB3V05rQp+gk4PFfomyB5gIzPstXPdr5ruJ8rl4Jxzlz2syi3jTHQ8DVvOc=
X-Received: by 2002:a05:6e02:2167:b0:3dd:c9e4:d475 with SMTP id
 e9e14a558f8ab-3e3cbfe104amr1623005ab.22.1753490728894; Fri, 25 Jul 2025
 17:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726004023.3466563-1-blakejones@google.com>
In-Reply-To: <20250726004023.3466563-1-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:45:15 -0700
X-Gm-Features: Ac12FXwghoIBGejz3QD5ztrbBqVaqe3VNiAirRjc2_3fAscr-xIW4oR3aZ07LEg
Message-ID: <CAP-5=fWjq-6MbYt93FOBWqV_1VNjAq0FCqxm4B1W4KXCyBZf6w@mail.gmail.com>
Subject: Re: [PATCH] Fix comment ordering.
To: Blake Jones <blakejones@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:40=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
> BPF metadata collection") overlooked a behavior of "perf test list",
> causing it to print "SPDX-License-Identifier: GPL-2.0" as a description f=
or
> that test. This reorders the comments to fix that issue.
>
> Signed-off-by: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index bc9aef161664..69e3c2055134 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# BPF metadata collection test
>  #
> -# BPF metadata collection test.
> +# SPDX-License-Identifier: GPL-2.0
>
>  set -e
>
> --
> 2.50.1.470.g6ba607880d-goog
>

