Return-Path: <linux-kernel+bounces-833106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3638BA13BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAB86C1841
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A631FEE5;
	Thu, 25 Sep 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LoGGZRSY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6631D74F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829130; cv=none; b=ZBHVab74uRB2wcRr41QbAczMK6uzjok/B40N1ZbukmCESqhaWZ1hQZcoOhyl67/zcj1iwj5HDe6SX9mzVZsNHLIvudvickiaA60+tDSp0rtkkptb2IakgfS1UYczYxFTnPhzuv/66QRH2Adq1i6QtQu6g8GhPeaBXK3pGxAxAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829130; c=relaxed/simple;
	bh=MdI2AHIvRAIXfAa0D0cIiFe+/emKPsfH4wCzSWvwGLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAsOy5tAh1VxLd1QEkQln2ftMkBb3f7YJkI1ZrRFGfAFIzw9/axdD9wl+3qx+SlWaDmBgCIbcsyYPkL5qjmKpQ1fB638RQ9Y8dSqWERFwsAt26DEiw5XSonkDIbYUuU2OoPW7KXg88WekEEhAY7gYRI9sybuagBsj4grb7vli2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LoGGZRSY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so51315ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758829128; x=1759433928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmXLeoRNYxQ/q9eeZjkA7V0DrLfH4gyiTpN84frRQQg=;
        b=LoGGZRSYBfrpzhI7/tkXFKICfNLL3tJ3rGrnGl234J45k77luqdswaH4VrL0njMdOe
         iYwRhkjHRyL+M9wAbBD2t/8NB3QwOzAQkUrBKV4pWYIwtJ4+ard6h8NEyb3i8OtlkNvk
         1J26wmYZ6x4OETcYT/UQW9FsOX8rBGlPFpVA/+RIEse091Ho0VFIavvlmtLYSmjb9A7k
         XANFRwhIbz8XWlKeE5vFIHq6EGoIuWq+qKAruXOEtxjjqR+Act6CRDiXxbsHuHTH/KtA
         /F3RdI1kyEcL5UB5KYW6sMR0fSxOvBD1M6HsrA6Q6SBEDJNQmKcl3mN/vXlIPJECKmoA
         vhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829128; x=1759433928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmXLeoRNYxQ/q9eeZjkA7V0DrLfH4gyiTpN84frRQQg=;
        b=TbD1tiuv5+azbnhiDibgQ0qp2ehg7u+//b//oMQ+ojkiubAZE2vIZJ16e3aKRkRijG
         9sFGAyDiCuQBIG7PhZg3p+g3DyIlg8BVzBtuXm6ZvseUYdbVWNZvQ6oCKKTdvQ0GqLye
         Qs+KvAV192AhMQDdFhUScv/m39nCXb+6TqDKEaTRzxAKHpGh012dboQBvJA9jta57hvk
         pypbh6kZvrwj/EfbOcA+9jrjc2iq8awisHKCXw1xVo8kbSg5ko2GKs8UKNb0pao91JzF
         rarVgAAiOrTUp1yKeCBzD6PmuB7++bHl5MqCYOLg7cYZ8ftSow8Wn3UtMfWKDkTX7EBo
         iMgA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Nh6r4CvHJnuadP6jgufqp3BoL0KdP2YTxQ1g6EM+okjcKxTLe75OOHOkhUsWEVJhjEqkHqfoEQQIEE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdv9MeJo9/PTt72qh5Yo/gXVB/bdqDu7baNCXJ/p1QDsw7tcm
	klFbzC+uG6uZ4PyE26pGplv/cZ2i05tTMh9zIjw2KSBHe8sheWBypJRNUN3s2Po7JQ/lAVPvghO
	32efv6gCYiRjbQACJ8DjvK7u5ry9+Ur0j+c6fHXxA
X-Gm-Gg: ASbGncuo+9U4BpXnmqAyjoUgTvPw/lOQN+LwClG4CL1AJr5g+cBzhFNRkfYNgGswrYP
	gyNOekW6QJ8VsnnOabyQGDKRjSSSNvSfrQy0gjE8Hol+vgLxSFJngtYp93d2D9Yg1Ms7wdD6Am/
	yMcn+TYOWbhn7MvMax4D50RwlueUBPNuab6LXMHhCEPpVFq7/YMEy03mxeqmpVZTdd7+rmut7v6
	2/iDSZttTf5Ho0HFqRW7jKZNS9+Jkv7YdKxmWElWA==
X-Google-Smtp-Source: AGHT+IHlWDsv5W+Cnz3QpzSjCLsjC6JqkFfJnw0PQrGoFuGfCPLIcdnOMx84aEiFui77lbyr4nxAshVX71wahiIYeqA=
X-Received: by 2002:a17:903:4b46:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-27eecd5abf5mr876475ad.6.1758829127934; Thu, 25 Sep 2025
 12:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com> <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Sep 2025 12:38:36 -0700
X-Gm-Features: AS18NWArHaslRBdqbnMECGDnT24X9gvQ1wcAN-wPei7OArHIVhWE7ff1fDEiDAU
Message-ID: <CAP-5=fWGKgXV52_9E7n9yDX1uNLF8qWT9XTFK8eKtc_LRCW5wg@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf test coresight: Dismiss clang warning for memcpy thread
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:26=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> clang-18.1.3 on Ubuntu 24.04.2 reports warning:
>
>   memcpy_thread.c:30:1: warning: non-void function does not return a valu=
e in all control paths [-Wreturn-type]
>      30 | }
>         | ^
>
> Dismiss the warning with returning NULL from the thread function.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

lgtm, should this be moved into being a perf test workload as in
tools/perf/tests/workloads/ ?
There doesn't seem to be anything overly arch specific in the test and
being a workload avoids a cc dependency in the test, as well as
meaning we test with our usual compiler flags, etc.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread=
.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> index 5f886cd09e6b3a62b5690dade94f1f8cae3279d2..7e879217be30a86431989dbf1=
f36d2134ef259cc 100644
> --- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> +++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> @@ -27,6 +27,8 @@ static void *thrfn(void *arg)
>         }
>         for (i =3D 0; i < len; i++)
>                 memcpy(dst, src, a->size * 1024);
> +
> +       return NULL;
>  }
>
>  static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
>
> --
> 2.34.1
>

