Return-Path: <linux-kernel+bounces-863464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A87BF7E64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113394F2424
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9E2F39A4;
	Tue, 21 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdbfwjWV"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94B355811
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067715; cv=none; b=VniQmIIm7bMiUkZUGcBtysVUb3XAZd0Txi9gGs7NRMTn2oB+fxINmdmxUtTuMEvHsrYJQJoU3LM5WVKhnF7U/t1loKJbXnYcVZkCB2MD17SB2xQtejHWjdK6QyRJclM6lEV5DWTbMeNEqC/kroL384aWCXTvJWlsOu75dZ09RXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067715; c=relaxed/simple;
	bh=LgeXmUFyk3qaIqo0Rp774eDhtGk8Ghfak1JKFfApf4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2lG0HYh/a1Dr2W/pC2c9vOCnE5o3XRU3FOPgyvx8slPQYTmakbh79VY+b19zNfZ1HP+E/ISZNkX90XN9HoHIjioriz4K+Oal1Lz4Hud83eggOFV1P98Hf2K3kewXZYyu1UuYjtyy5x74yTI7QdXV2sorhtTLFpAAMa7xjXRsvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdbfwjWV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475c1f433d8so4561135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067712; x=1761672512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=LdbfwjWV1/rW+erJxWyI9N15vGetIDsU3fA+YV+HltklPWb/WK4BZrRLplpkTxt3in
         uoyeWFTnf1P6DTgzkotmSmoJodXGCi+7ZCWjNNWqk7yUZxD8T3GOHQKV7ZfENVdqXSsy
         iyUmzAXshrw5SoEAUSg+1tC56MU7qcww1TpmSDKIIPA1nedCV+r1+7sDjpQMZw1sCtaX
         ZfrKHVWKv+m6CKRZzj5TBw9vgsZXsC+k/062iX7Tz3l27KT/iDT+w3ZKk1MYu1Bk6Dod
         ylSux0j/+xkfH2q1np0t4OQDHvIRc2NcU4WfzLe34A9zb0upJb3LzmHdB1rXwAx0L2p5
         hdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067712; x=1761672512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVHCV64PvtiReRqCpWYpH2m/B54XBvjNGhPUP38ZlYQ=;
        b=PhPma6TMezEo7kLGDEa8qWu1BVSnv2uH8x2B+gwmpv4XDwafhYEOM9pgJ9AbfZV3Va
         npObfN3RTUoH9K00DrRQnPZ+T3W0sYeDjRn6Bnjc3tWaeCqOX26VOY3o6OgBTsrEBEm2
         0zgQ+GlseZEbZ/pxdeU+xfK74RZDGItVlzZ7DXkQsqemkpPJ6nT/T4oAYo4ApyQ2KDQt
         3rX0Lolv3O3MAgaif0j61ngyMCkW95Sf8NyE7X4Pb4CDjoC6dFaW9+45f6uG6VMUp57T
         Ed5F9V08B3hBLrV2O9fTVTgBNDubsonKkJCEsi+VtEN+atcl3A8U0IV7m4tVfSMY/Ver
         CMIA==
X-Forwarded-Encrypted: i=1; AJvYcCXYp3BS9AIkPAGnJxkwY2t3x/sC4XFp1jbmDIogrpwS3aM+y/XXaZXSFM3hyZG1iOpYBV+T222lHOdZOAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwi+fTLe99HVpPNT/QXn2NwPx+JmN3Dc/+6iQU6fSQNUMPRq9T
	H2ZhAxlJGc08vGHDtg+utjmGaEDyXJo6oU+2lOqOnMtd/0+oCLnXBbOUOW1jAVBrx6uf7skMqoB
	/jkbmmdQh/3w3wJJpuqC2cyM+uoF9Nhs=
X-Gm-Gg: ASbGncvZ8m/M29RCEPPpsL6XYncscQ8un97Vkyos+0zMcHe/cgZxyUb4wBPfNls8cfe
	QJEJ9G+h1bjhOtUBFunJfnLW1++TwzqVz98FPKpnVgUSdDNaghnC35wlkDK/phF0mWE/hzV4pxm
	ETSMz1m3saMdWeuf0gmR97vfXMTDdUSy6COXIxNqZxHN+9Aq5Sb5kFXsJH7wXnnHtDvsdQTrbhu
	WR6rr8rgDMEEZfgfcX0988gNwHoHxIAmEziSMdjnMPjpbGqocSFbVeD4J/SCh7vBejsZpK1xbMv
X-Google-Smtp-Source: AGHT+IHFn7gR7IuAx4widloDDlPnBPo9AwHt/0RV6fPlW05wXxkH+rY61gYgiE7K+aWrKofOe680pbjuspBOkxZnkh0=
X-Received: by 2002:a05:600c:1493:b0:471:1c48:7c5a with SMTP id
 5b1f17b1804b1-4711c487d74mr87072565e9.9.1761067712035; Tue, 21 Oct 2025
 10:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021160633.3046301-1-chen.dylane@linux.dev> <20251021160633.3046301-3-chen.dylane@linux.dev>
In-Reply-To: <20251021160633.3046301-3-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 10:28:18 -0700
X-Gm-Features: AS18NWBjnzTPARuhNgmAxCmDQioPAWs9SH3Yg-doGNGp6Bbr_qslNv97F3cxhhg
Message-ID: <CAADnVQJ2BrLy1FVEQmnN33ZqNZn0Nge1n6V89=p4NptjQNyHog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: Tao Chen <chen.dylane@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:07=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
> per-cpu BPF callchain entry is used here.
>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..97028d39df1 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,52 @@ struct bpf_stack_map {
>         struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>
> +struct bpf_perf_callchain_entry {
> +       u64 nr;
> +       u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN=
_PREEMPT],
> +                     bpf_perf_callchain_entries);
> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);

This is too much extra memory. Above adds 1k * 3 * num_cpus.
Let's reuse perf callchains.
Especially since they're controlled by perf_event_max_stack sysctl.
See Peter's suggestion in v3.
And for the future don't respin so quickly.

