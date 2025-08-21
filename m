Return-Path: <linux-kernel+bounces-778751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C92B2EA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E005AA27AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418646447;
	Thu, 21 Aug 2025 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmebX3HN"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C101DF97D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738866; cv=none; b=SJYNzzmKNhWF4rf7sp4yxSK8moxppYVg6MdWph0VpGVMrPPjxRYG9X+fwYe6TJEJXsFZnF0213llCw4ExY6e8Bs1XFlc2z5SpkN+MIFtKSCSuAU3/VTAQxTirpZE/wvLkELw1vAUnQAg8z4hOPphLQdZ3JaD1QKRXQfOW5ePNls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738866; c=relaxed/simple;
	bh=RYNH5Fn80bdsRjGGIR09BiBns06z0WrpWMzLI0Wu/GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHeY+qxghTmgx6RtueqV6PSKIqiJc/Bv/YwVljsPWefAeMv9Ax4g3yH/6+jWe3zeqw50SJvyX0ED7gLeM2/8Wrz4w3QU8A17fH7pxCpphAYhVad0r4zi7ASv7ABdjncJFvIWyOKVOS9dpWhGMn1wWLo/xD48ssKYiAI33qegG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmebX3HN; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3354b20883cso530131fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755738861; x=1756343661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYpRny3qA+sjxXdlk4UywqmKcgpUts7E2+CnSYsDQM=;
        b=zmebX3HN4+lNFfDOrvveHpImIuAXvZsx8SnIm0vqHFrYuou1CuJVejDbNvo6DxyCvH
         /XIhUeBtWCn98kwjCXIrU9rJdy5JWKgdTAJ83CQeA3pStF8GxaXSw9LlhZpvkU+KtMRP
         fGU0zoiBOT6B2SwZl81Qk22sx5JTXsYlvUa8qEtmpOa88bhh+SnI+/7sWWne/4hv7qK0
         Gz+lSgbi4aBghNVWvaL63J7I4FUjuyD5ZD+VZhF/93lYEioYrN1B9UpUxx0wvhDcX4xu
         Ak3aeL7b9PC5RgY9J3mSkdkB9bI+Rb+kh4AWFM1mfAvu9y8MkT7xsKJViQQoFVqK43m3
         f7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755738861; x=1756343661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCYpRny3qA+sjxXdlk4UywqmKcgpUts7E2+CnSYsDQM=;
        b=goD+Su0BQUXlGxldv6u6GzSvJKj6KCT5d097endBRFGRmSF9Q2IWwBRKaaC9vDwSN5
         Sc8dJVUWL7IHr0SWBhIKl8KG4wC5s4iVW1Q36OBDYgUTC7AjvPsT33oLTtoB+dr+WTlE
         yZBsbWJMaV9sElUo9bC8NurZxkJBbS+ObFEfUrSLn+P8c1b6gbQcjUlfyoxLh/HnL4Nm
         dyvdpLj2MKHLQncGw3W5V5yr4BvsnK23xkrOGZNktCd4HX3WqJMUTO5TnivMPmtqvoYq
         9PDM5QZ7F1z1xeV0NdD/Mz9hicuJ0KnizUCmw073qaKWK4Kh2UY3QsKDOqaU+eVxgWeZ
         gw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr1pFgdra2KkltVEiql66Lenqc64P5E8qmhp3Vj6123TjIwe+3YF97Nfex1n79q2nr533JmDeWJ0nPaQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4Qk8QxTdgT+muul8u3H+q9YwpMEtPVaaxaN88wM+FBHmHfKQ
	QTpqfvKjafcLRr1rub6n2EzW9VVxgNvtIfDSgwnbgyttvRmJW4A4vdltTcRBBn6vJI0Fky/6H82
	rcQeaEwPV75Y+5cE7ZkRZcqZkIFJcWKX28gr+ZkAf
X-Gm-Gg: ASbGncsEIBohpbQnstr8Tmy3sLIlxq0RBOjqm4CBy6w+u7wB09OnUOZE0Wg5qb8F6qf
	WloYAHWfhFd21qXDYufNrmhTHQEGgyA6kS4lNIJ2yngu+xiAfQxUSBd+3/wro8INsQv9088XY10
	lmHFKa3dBJifCc2l3Hnah6EqLRI47DoXAorvmb0Ax2owNr5rFi4FZHHgp0bgJKD9M0DWLdJ2z9i
	js4BYiyShjADldYEBZMnasqxX+JJ/xxCge+p46G1PVp
X-Google-Smtp-Source: AGHT+IETu+WGJrhtRV9VHuwi/ck8JYd8pX3ll/eT1ROeF1CZnsMIRL00vhQjhg2HXjIPlxreYuVZ+8/vGfYAVUBxe/Q=
X-Received: by 2002:a2e:a541:0:b0:32c:e253:20cc with SMTP id
 38308e7fff4ca-33549e926a5mr1677211fa.11.1755738861280; Wed, 20 Aug 2025
 18:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1>
In-Reply-To: <aKYEpf7xp3NnkBWm@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 20 Aug 2025 18:14:08 -0700
X-Gm-Features: Ac12FXzOF28RR6xZa7Q2rFIJD-4EFx1-2GTlpbXjfttBrprj8oDB-Hsf_xlfQEc
Message-ID: <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
>
> Not combining entries in 'perf top', so we're getting multiple lines for
> the same symbol, with the same address.
>
> To test it, simply run 'perf top', then do /acpi to see just symbols
> starting with acpi_ and notice that there are various lines with the
> same symbol, press V to see the address and its the same.

With this revert, does it show 1 entry but with a wrong percent?
I am not sure why there are 2 entries for the same symbol, but if we
merge them, we can sum of percents. Is it the right thing to do?

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/hist.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 64ff427040c34112..f3f64aff9b882303 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1391,16 +1391,7 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
>         struct hists *hists = left->hists;
>         struct perf_hpp_fmt *fmt;
>         perf_hpp_fmt_cmp_t *fn;
> -       int64_t cmp;
> -
> -       /*
> -        * Never collapse filtered and non-filtered entries.
> -        * Note this is not the same as having an extra (invisible) fmt
> -        * that corresponds to the filtered status.
> -        */
> -       cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
> -       if (cmp)
> -               return cmp;
> +       int64_t cmp = 0;
>
>         perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
>                 if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> --
> 2.50.1
>

