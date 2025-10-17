Return-Path: <linux-kernel+bounces-858491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1ABEAF09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E481AE2E48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED52F260C;
	Fri, 17 Oct 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVJH+qMw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D92F25E3
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720374; cv=none; b=PXALHlqv9LqTrXRLtkW0KQBqpBj0vIFdY+/jhOhd7T5mejUFPQTy7FhbeHbr22ETTM34NRyBrIzcvnYiZ7n0SaGbzw6stq904jAjus85fC45Q+WNENXaQFLERsbvTsxBMhyUVn13VuaTnDl5a0jk+u9REw1vkWoQKMMvyR0aShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720374; c=relaxed/simple;
	bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qo00TcQDNCmfWd+S8YfULjnDNeJfu0si3CsTFcvTPW3ImPVwUnVwx5p4qaULiz3HScZHNawGETZQaI6CN8qju5Ror0tALwS70CO6PFhu+ytYOvz+aeyzXvnd4YTP1zk0BQWLAZNaqFB6uJvYX7F3Da8kM+hiIjKI5XgrK91o5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVJH+qMw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290d48e9f1fso5845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760720372; x=1761325172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
        b=NVJH+qMwfl03WPOnyYS40+0xTrB1C6/MsUZoHrznJ76KStmRo4Ei2eAFOC6KNwejsH
         X6XWnUeVlvsqHqQixRT2XccFAnjPEcP4MejupMkuK8XqRlH8hV5C02fGhfjUTRTNsoIP
         q/zae9GvFj+i/9i7aUJpOIPZJo67B/JCxj7dNve7Cibt03fKbQUwfbiLL4BppVYiklaz
         igMk3ChGnxFLj4ywgCF+N0apxWKVEE3m2sOpEDMEa93PyTR4waQU4HrAy+On5XXClE1r
         aK4X4f39JStBws2sE39Zb3PH1XLPf4PXaEB+UG/t5DW9Amya8ljcHkMIZKIwcjee+/be
         4ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720372; x=1761325172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ci8yuuHIIxvuhpiDNi21ZF21b8HMT0846DfbovB3ec=;
        b=IiRogSnjud7e//qju6H2d2fEuKw5wWDwNO/Hkpcva7xQcFGDssvGb3iMiF9Qx8WG1w
         kk1wolEqGtzBN7ndFgRc1x68f+Sc74xsCC2H4z+ceSzcv4I9On00MWERhwZcj6I8fSDN
         mMkpRoEkVE/o0Hn8MH8CtuW3VrfMDZbhPaMGqenuGOTY3FCQrpnQYhLwdWfhkSOrR4mf
         kxp8wx4is59HcpIV0KUI5cUMH5PsVL4gw8sRrhlh6AX7NnyAxZdnPKNiHJeqEowTyGvP
         41Y7V0i262vOYdQew2XVCT75+Dz+FyT26DIhzD78qX9CrThobEJiDZ3JuN3g4B3tvoLs
         XeVg==
X-Forwarded-Encrypted: i=1; AJvYcCUMs6tGQBVLchsEq1K4BrK6+Rmp5IT3CVfG0Yhd/C+3gd1ni+Em1OnaTTpSsbpZcy9YSO45L9qyQgC7XVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAlqXG3Nr3NBFsLQ2LVOjIWY3OkzQLaEZ53eR1s95L7+18lP7
	hmv9dZ2Ob/5UdW2/W7LUgROxaq2QGCMwpbPunA9JRkd73s5pYawahUbwj8KEDK5JvJoCbclbeRf
	lxNts29AxA6UDkYU7wzTgJCsbUktBEUv4MWkEhraw
X-Gm-Gg: ASbGncuvlmW0gZ3iLGUUyskKkcbE9Ny48Eli5IMkKEgCp7JTx0eVIMeh4JSwCWVbIRp
	+Wmv6j8Pmte5LqaRH21xA69C8mUG/ylv+Ad9Mvkho/UC7QHtKvDC+tGTH3v412dLDYkKyx8i/ww
	1Me6p3tRVqXymDWu5LbxsUOTBAzpaJiL1jDBN50D8ojkqwp5An38eU4nPm370XgyvyvYCWSViXL
	islP5PMJ7e2dJNPUEdVrgIur3hK0LRxV/dGZQ5scAkhWKkdDG0fv9XHIfjq
X-Google-Smtp-Source: AGHT+IHT9GHP3NDyXisLOGrRAg0pd0hnfx7c5ihQP7tcFT9uPoT+264mPqqPBBPE6PtZuA5bXZA0JefaZcFAajbv7EA=
X-Received: by 2002:a17:902:e88b:b0:270:bd33:f8d0 with SMTP id
 d9443c01a7336-29087a6f8demr19017785ad.14.1760720371784; Fri, 17 Oct 2025
 09:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825211204.2784695-1-irogers@google.com> <20250825211204.2784695-4-irogers@google.com>
 <18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com>
In-Reply-To: <18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 Oct 2025 09:59:20 -0700
X-Gm-Features: AS18NWDqe896mlksjatj2u7oKmSK9x4F3VsHdOBQKUfd686j9G2rPAm8LErB1wM
Message-ID: <CAP-5=fUvppttK3t7GHsWyan08bZJRkv4-M_P2vJpe50bOuiCYA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] perf parse-events: Add 'X' modifier to exclude an
 event from being regrouped
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:25=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
> Hi Ian,
>
> It looks the "X" modifier only works for the cases without explicit group=
,
> like this.
>
> sudo ./perf record -e cpu/mem-stores/ppu,cpu/slots/uX -- sleep 1
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]
>
> Once there is an explicit group, the "X" modifier would not work and the
> regroup still happens, e.g.,
>
> sudo ./perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
> WARNING: events were regrouped to match PMUs
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.019 MB perf.data (7 samples) ]
>
> I suppose we should enhance the "X" modifier and make it work in 2nd case
> as well. How's your idea?

Hi Dapeng,

hopefully fixed in:
https://lore.kernel.org/lkml/20251017165753.206608-1-irogers@google.com/

PTAL. Thanks,
Ian




> Thanks,
>
> Dapeng Mi
>
> > ference|ops|access|misses|miss)

