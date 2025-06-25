Return-Path: <linux-kernel+bounces-703440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B82AE9034
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7E14A6A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63120FA96;
	Wed, 25 Jun 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzlIjk2G"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6CD20E031
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887238; cv=none; b=h1wtsTvnPcpjx9WMvPlPJglT7lQ6eTZ7+XXWTrIrW0VOTsODMpXdHJFTfequYsvfVViJ/XGO4YDg7YkE+3lDc133Cp1bZRrAoHUFoNAvREFy3SQYAhg7U+mJcu8SCh9Z1mgF1pp6MuEAQpuo4Wx13iaE640cyR+cQhQoFYDZxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887238; c=relaxed/simple;
	bh=ggYYtkSgsTIFM6TYXPIenOdMm5KXbE0dEHr+DwJiqoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2TIQMEGcXDnXxP5W2pVy4UdDDDeknBceoMq738OtmvqQYEoyyc+sfp7K7GKoyRVc1rwf5UyJemDIiXR0X/wTfblZUyIFIxqOiQrEUs4OljrvNHfZSfB48OZGA+oGG97tQJZ3IGKHGJtp+zP3vKBBxqW6j1acNHTJOO3mcKNQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzlIjk2G; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so50625ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750887236; x=1751492036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viXeojWpY2MRwpzm578tuXycnwNkllpVf+Pl0j+tdQo=;
        b=qzlIjk2G4psWcznCmortxcjfxR9UDKA/6tfkkEKloCoCXZKO0/DRzP7Zz9WuJA6cXe
         RUtzeR5/QNAK7yOGBB8ptPKzoUL+0+oOijwVIFKipTJFk9T6ccQ7HcRD3wzo2v5K1jCJ
         5dxPPKeDOcNufX1snvfbKMHpf94RaWmxwLSarQ+ly7oDj6o+lWr3EgKrYveszBuJaNCH
         l/DJL5qkRvJI/Zg3LV2QVrUJesXmVVe1UmZyYieBPZjnpCOtisKgZXHQ3WSwYLFCSwOR
         EJXJsnBygo74Y+3TAm3h56RFgFFb0TXwCAWQEoRS8A0dRfk2p6Qj8V9hw7e5DT6kWJLD
         oyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887236; x=1751492036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viXeojWpY2MRwpzm578tuXycnwNkllpVf+Pl0j+tdQo=;
        b=lCUbFb5NcALJxMQlYU3WRtY1jHvEHCQSNrRkyWFzkvsm+RitmytNe+f5ifjX5tj7gb
         ZJ0AsqE4mBNBZCLMk77KcO8L0V/5xb8GfQ3NovWDy3zxFy/bMk2o2yoo98zmSXa7CHVl
         Smf60yUTu04cXXoiw6IvCcLnPq5au5Tz7a4GdePVzvyA3GW6A+LGFy/GJNgrMP99ue1s
         25xH4V+9l7MAXHHZs4U2jI40kKif7C1K3VQ0UM4T4PqAylBrJItsdY88sAhW2j7CrDpQ
         0DfBR8AzvnS9vnaDpHreo//OJgXgm3KvEsTyUHR+mVLBFI+3TAPiT/f1RTG5MnkLHcXX
         eETA==
X-Forwarded-Encrypted: i=1; AJvYcCW6uTizMJgi9qCn5YGNBgcmOzFdqVtLd8WCkU1uFsmnyAG3o91BEuz1KJAN9vDmPhBiranDvcp0Cjr6AG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvncvnx8pnDMGtxNAs4H+p0rZvja+Ezn+8tdfF5hwaTRVJU99v
	xeQtgps6Eyk8bf2Pa3SzRDvqJoze4i4a7enbSC1aZS6h3qjHa8B4kKs1hAxhwDIvnAwVXOLQKc8
	fxDTdOhD6EEBxb4QyMvlP8QEhAV4eYpmEK8dOSxXM
X-Gm-Gg: ASbGncuMeyJfU4mLC3a//F/pU5lDZOslFkv9RhZLngiiZg6TL/iglTi/CZ5YfktHoZG
	gwuDo2LouKIvqwzG+/o7ELXBlIrbqnaKEr3crm1Dl5xdExrqtzdcecVo7ERjTP7hbsr9QR73G4x
	052puhVuZJIQuqDlhQHWuHlLcIp0MCoWKgJtaBr/+y4Kfu+3pS3TQxQuh082Dr+XcxGVoc5G/o
X-Google-Smtp-Source: AGHT+IFdX/8fYSsxuNYM2MoFbGqUhMTT49vo4RGaIl8cUl0EIead4y6GT4JZEpDoxZw3twfDLccf6rZ+VZzuw7LaJrw=
X-Received: by 2002:a05:6e02:1aaf:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3df3f5fab27mr981365ab.26.1750887236188; Wed, 25 Jun 2025
 14:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625202311.23244-1-ebiggers@kernel.org>
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Jun 2025 14:33:45 -0700
X-Gm-Features: Ac12FXwHyHpNvyuthY1qkC86JQd06byT5GjQhW0vfB34IuD7BdSTFxs2oIntQFA
Message-ID: <CAP-5=fVkaO5Yyij_Hh=R56M9ECcH1gEBQLO1QDuOmQBqBNoN5Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] perf: Remove libcrypto dependency
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:24=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This is a reworked version of
> https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
> I've changed it to add a new minimal SHA-1 implementation, instead of
> trying to pull in the kernel's SHA-1 implementation which is not really
> designed to be extracted into userspace programs.  I also added a test.
>
> Changed in v3:
>    - Rebased onto perf-tools-next
>    - Removed unnecessary parentheses in array indices in sha1.c
>    - Updated my email address.  I've started consistently using my
>      kernel.org email address.
>
> Eric Biggers (2):
>   perf build: enable -fno-strict-aliasing
>   perf util: add a basic SHA-1 implementation
>
> Yuzhuo Jing (2):
>   perf genelf: Remove libcrypto dependency and use built-in sha1()
>   tools: Remove libcrypto dependency

I'm trying to make it so that the -fno-strict-aliasing is unnecessary
but we can remove that when the changes land.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

>  tools/build/Makefile.feature            |  2 -
>  tools/build/feature/Makefile            |  4 -
>  tools/build/feature/test-all.c          |  5 --
>  tools/build/feature/test-libcrypto.c    | 25 -------
>  tools/perf/Documentation/perf-check.txt |  1 -
>  tools/perf/Makefile.config              | 17 +----
>  tools/perf/Makefile.perf                |  3 -
>  tools/perf/builtin-check.c              |  1 -
>  tools/perf/tests/make                   |  4 +-
>  tools/perf/tests/util.c                 | 45 +++++++++++-
>  tools/perf/util/Build                   |  1 +
>  tools/perf/util/genelf.c                | 85 +---------------------
>  tools/perf/util/sha1.c                  | 97 +++++++++++++++++++++++++
>  tools/perf/util/sha1.h                  |  6 ++
>  14 files changed, 156 insertions(+), 140 deletions(-)
>  delete mode 100644 tools/build/feature/test-libcrypto.c
>  create mode 100644 tools/perf/util/sha1.c
>  create mode 100644 tools/perf/util/sha1.h
>
>
> base-commit: 9c9f4a27eb1096beb650f312a1ce996a9960b56c
> --
> 2.50.0
>

