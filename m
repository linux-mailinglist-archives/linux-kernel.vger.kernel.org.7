Return-Path: <linux-kernel+bounces-682816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FFAD64E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A88A1894903
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 01:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053D70824;
	Thu, 12 Jun 2025 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1OIudjf"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FA2F4317
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690189; cv=none; b=ohC5OW32/fCXmkJ0xo6JaSk5XFQMpc7bDGvtOxAnlujrIXkkat80QzPB6B1h7QR1H7IRywgtvZUz+umSaj810ZSBq7A6P9ei03P6tZ3hjktlik54wLhcLJqL8RNdvVx66NwH3I8OSsOd0qPDke3rTe/aU6JoaJUtyDt2XhYBgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690189; c=relaxed/simple;
	bh=sK8hh4GrbaJPxO5UXjT4uZdicZ+332w6O+W30ugAODc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du+V06H1RDfsQTtHWR50PgFVslHCFswP/q4mt6/1h0zXIw5hrNkdxEg97onTvRyW+uEz/C8aYTEGxTDdCbhRz2D+cbp6yqVjcRZ57HJjw/WM/MoFXp24Brd28s3SwnoFqQrfOgIFQ1h05huOgEmeOh4ndJNbQtGcNujkVC4U/5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1OIudjf; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d20451c016so24687285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 18:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749690187; x=1750294987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNmsutdsye3P3CJhJsMQlrvMgcaKzefaeXL9LWbLYu8=;
        b=M1OIudjfa2mH0zjUKznhdtRGRlc5RAUo/l2vaYGQ4ua2JCJ0V0u+4OhBdtzyVBef0N
         M1cp779MjH82xzL6X9uJDUTWM9OSmEMpMY7JDkcom7GyW7YTF3/tOTraah9LFUJkfmFI
         DLOzA93CMspRpmSrk7rdHt4eSV6GXHs6cW2WJ35c3NYPyJNAbtvUqaA74lSIIi4XAE64
         tiCLeZVJPucwgoMrAWCANtOv8SDINmREbGUtlD8ozo+C4AlLxqB9mw2B66OM1K4Gig9S
         TnON6+4VUKe3hkHtFHejl+3MP/i2x6snsGiDU8pcSDITLg5caQLWp0a3JC68cgZ0tLS4
         2zQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749690187; x=1750294987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNmsutdsye3P3CJhJsMQlrvMgcaKzefaeXL9LWbLYu8=;
        b=GxnEg6+QDT92Y0aeze63FZNbBJrF4IZTDhH9txlDtPJtPCbgXJ/I7e5t6fWUX0vKRe
         OicK/kdRn3/qJR2r61OG6R2AyhVXwz/DtiVHOePYNg8M9S/xUR6XFtYkWnXDqIm1sE03
         r0XYcATexhzMnSl7+IqAzwu0kMDKukpTtLiaj3e3a83PhgEX4LcYZxvg8OQVNi29islI
         3RdYuQPtH6RhmAETxO4rcYhMHUiAJZxl4lvVErfisd28kPVGIuPSgmLsyDoiAsewXIRQ
         iZgUJKmdupDnhawrw8973xcD6pOU/CSbW0kMzaRFbtp/MKDPkdAkl3kg38YB1ZdP1y/k
         AoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo5yrKscGcmUTkN6UTsJLYA4QH33kvtptccpVILMVtfw6Jr6qPTUPfND+tvzuc9NnQ83xkjCWYYZ03wtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKl6tFvVa2nw89MvJjEfeEeD1iV/9xXZ9otLN2z/j8FPg94++L
	7MbngfKSfVVbdwgMUOuDkQ98oV8CpIdcOGirrv8SejU0EUij50gQ0n72aJ+NHehPgKKvkTlLs6T
	MWT6rAiX2SQ+RKAhk+S2KrwafDegN2+JTV6bMrPql
X-Gm-Gg: ASbGncuvjNwrHnLelVjSLQecTGn42UHhvN7QR3TJd2ck3mBLWQJUE7bR3QqkkEEgKeV
	AA0rlPaLQxr+mRK/SGxatV1Qx52kphZFfgHKg34rtvkHil4MF9nwpFOFb7CdFfzDmfONdmLp+RH
	8Mo5gnWIUsztOo+/F4ko+a7b2XsO/kdelqGSQtw7VXoww=
X-Google-Smtp-Source: AGHT+IFp0H/SdT8TXZjBxo1iu5o7/B6/EdR3KllZkVhClS8c+6Ys31CAAk4hlmnPUPvNSofi1wCF4sFRdVdcowfqamQ=
X-Received: by 2002:a05:620a:a21b:b0:7d2:cc6:b485 with SMTP id
 af79cd13be357-7d3b35c0047mr188173085a.8.1749690186830; Wed, 11 Jun 2025
 18:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
 <aEnLBgCTuuZjeakP@google.com> <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
In-Reply-To: <CAP_z_Ci2HtnSX8h51Lg=XcW_-5OryGb3PAH7MJjWg60Bjpdpng@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 11 Jun 2025 18:02:55 -0700
X-Gm-Features: AX0GCFsD9zg5ZgEveoY8yrj3fK_CYrXNLsmBVWmj9_aAH5Tq9sMRAl0BYKh9JCg
Message-ID: <CAP_z_CjRB6MwNrXW_o_XyWSwcXZKpVHyGZoj1udJU4uBu1iw=g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] perf: generate events for BPF metadata
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 5:39=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
> Is there anything written up about how to set up a machine so that
> "make build-test" works reliably?

Barring that, I've confirmed that each of my new patches builds successfull=
y
under the following build commands: (I have a copy of libbpf that supports
".emit_strings" in /usr/local/include)

    cd tools/perf
    make clean
    make NO_LIBTRACEEVENT=3D1 LIBBPF_DYNAMIC=3D1 LIBBPF_INCLUDE=3D/usr/loca=
l/include
    ./perf check feature libbpf-strings

    make clean
    make NO_LIBTRACEEVENT=3D1
    ./perf check feature libbpf-strings

    make clean
    make NO_LIBTRACEEVENT=3D1 NO_LIBBPF=3D1
    ./perf check feature libbpf-strings

Please let me know if that seems like sufficient testing.

Blake

