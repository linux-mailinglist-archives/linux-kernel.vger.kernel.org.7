Return-Path: <linux-kernel+bounces-840755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A64BB5261
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6772D485E51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C51EEA55;
	Thu,  2 Oct 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzpMTRKy"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8171DF97F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438028; cv=none; b=IhhAkGwD/lt65SbJigZYZ5Tp5CNfxYRc3Z/rbILFTgn6YI2focjSb087qU7wO2l4reC7bMYX/4/h50AzYeJi0Z0viIYq63DxdQnwwZLlU5Yds7ZqO1ljIyuYsivGxFkBT8NVEIKAU/Y7k7JJSurrPJiHn9abMEQ74Uqpp0LCRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438028; c=relaxed/simple;
	bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eSk4mIy3a4IV0aq30VriKuSgFGZGxcDA1MBEQ3qvNKdd6pb1jJHxa+vKVUqisNc7uKCFsvP0+fxesf+HE2BStYSX+nudTk7BGhit9KSpNtod2bRGr/hB563TmCw3wd4Wm7LUtavtl7B450ocjyxl/JAQMTt9nYPz+l4nEk8tnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzpMTRKy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so15085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759438026; x=1760042826; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
        b=SzpMTRKyfGX6J8chm6op3vEywBE3i+QypSnAvn9VY4wfQModMa2l9JucAdJtCzUXOl
         st/OZcGp3H3sxG5Rme3nQppuWBr41HawrDW0ToZYMNvtwjF+RgkCSp7LADZkMa7J1/H3
         FHA/eblWYRyoj6knV/q3cKGME15/Hswl884p95rZ/CGkM+ZMGwKqALkE4Q+o86BzGbbM
         5KZr3T4/3nEMYEYwQROmD/fNmpiw1jyMmqVI6ZiygaBKdUyUhtXgM63S6bv5wpXMO92Q
         9tVk9YuvojSHng/PioDA88tmcKQPpH2mmzDiJGgBPuRMov4WlSPG9QbpzjeF/pdx7Q/b
         qmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438026; x=1760042826;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGpuZ6M76mxssiVzFPguhRDJhH4kxLiycpYO+f7VSAo=;
        b=lENrHAQNu1MZe6N49CZGKXHa4aWxmdk9C4aPYNaIhbMJ9zvn+OVZ6uHZKU3fI6PsPG
         yrd4DKB34e/xiNO42TvdNQI72CKinWmITF4hslIPIOdwxaqkjZEbWJIMEQHvuKx1zEO8
         tgI25K7b+wy0NAJB/ETH8WRacJDFVjWoE0NQYmG0EJuImq8Bltl5AK0MhqgeHu2KQBsM
         HE72GFAL5hpaVbXOc6o49jAI0KeRm5amJFFi7EUu2dKs8v/8tWtfxheX31TCkyG7lIV1
         BoSdClFms4ch1bKyrdI/DZ776jZ2NK9bzZ+m8fgcjZos3ABycLpHZef1xz4qQWgwrNBX
         AGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRxcPM2Xaqgw9wRcfLc/8eGFxICbP4vRzBv8TkYBeXDbuhNu5oPJolVD3Q9WTB8oHMZzkKSQB0zVTk0Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCWQpqVQfC+voCJT9ZRx/ar/mybAwwbCCOZ7gdJAaEpwBNZYnE
	MuZ2RdcD1fvBzeLQZjSHgPN/6elVRjL3GNYYnLJC70EDJbzQhWQLoZdH6rUxfN71kw7n8HS3gw5
	wKOgrAJYRvkzkwecNx5FKm1x+7TqUqiPexhWpFpyU
X-Gm-Gg: ASbGncukAfs4mD1WCuxdunyMFpWg/faT2FFx0hMsjAHqGjftL7nn6ya4UOHNvTsKc5K
	dwQSKUQUmAtM1PUmofvxZkHoI+q564J2D/ZqY2VGdujK7qJf4kGmIL56eoJDwHYxjnzf7CXN/tz
	v+71oTbkxcubF9wMoAaeaJrkqWe0IMaUqhxNrS5ohsCgxt0pAFeEoxbl3I/ceyQ9QLqBnUIw9s0
	7sOJuiq8SxjmucPMwAe0oQuUBzR5+nPvARB6f776oE63i/t9OYFBl0TYBU93PhTFnGvD6aouyfD
	Gqw=
X-Google-Smtp-Source: AGHT+IGeT/Wv4F/Aj2sMPivpvB6xqpoM5WwcESEP9AUk2vBvZmhz0lOz8ASNJ4/8/WdJIostUr9SbQ5MlLrOBK0r7gE=
X-Received: by 2002:a17:903:17cc:b0:240:6076:20cd with SMTP id
 d9443c01a7336-28e9b6819dfmr277485ad.15.1759438026136; Thu, 02 Oct 2025
 13:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002200604.1792141-1-irogers@google.com> <20251002200604.1792141-2-irogers@google.com>
In-Reply-To: <20251002200604.1792141-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 13:46:54 -0700
X-Gm-Features: AS18NWAkMYJeep1oFyAislGqnoiAUDkYmOZdGhymPKgmBEyVCgnWt3LjibdjhnI
Message-ID: <CAP-5=fWvj-cAzh9R=8EjjUaaLGe9+XW5x_f4Pka6EdAQMU1X4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf stat: Refactor retry/skip/fatal error handling
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:06=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> For the sake of Intel topdown events commit 9eac5612da1c ("perf stat:
> Don't skip failing group events") changed perf stat error handling
> making it so that more errors were fatal and didn't report "<not
> supported>" events. The change outside of topdown events was
> unintentional.
>
> The notion of "fatal" error handling was introduced in commit
> e0e6a6ca3ac2 ("perf stat: Factor out open error handling") and refined
> in commits like commit cb5ef60067c1 ("perf stat: Error out unsupported
> group leader immediately) to be an approach for avoiding later
> assertion failures in the code base. This change fixes those issues
> and removes the notion of a fatal error on an event. If all events
> fail to open then a fatal error occurs with the previous fatal error
> message. This seems to best match the notion of supported events and
> allowing some errors not to stop perf stat, while allowing the truly
> fatal no event case to terminate the tool early.
>
> The evsel->errored flag is only used in the stat code but always just
> meaning !evsel->supported although there is a comment about it being
> sticky. Force all evsels to be supported in evsel__init and then clear
> this when evsel__open fails. When an event is tried the supported is
> set to true again. This simplifies the notion of whether an evsel is
> broken.
>
> In the get_group_fd code, fail to get a group fd when the evsel isn't
> supported. If the leader isn't supported then it is also expected that
> there is no group_fd as the leader will have been skipped. Therefore
> change the BUG_ON test to be on supported rather than skippable. This
> corrects the assertion errors that were the reason for the previous
> fatal error handling.
>
> Fixes: 9eac5612da1c ("perf stat: Don't skip failing group events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> An earlier version of this fix exists in:
> https://lore.kernel.org/lkml/20250923223312.238185-2-irogers@google.com/
> This version is more thorough and tries to make the overall code base
> more consistent.

Looks like this broke some test expectations, will fix up in v2.

Thanks,
Ian

