Return-Path: <linux-kernel+bounces-746381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFEB125F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7310AA2CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BC25BEE1;
	Fri, 25 Jul 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSm7JxjL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E880246BA5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477548; cv=none; b=BvkUMZ+r1KWWEutagpmGIUww0urteZK+D7jl6BZg1WiNvOajNcJ7uyh2KIPzE8EsSMeawr/QbwE3BW0wafqBdy/sVo0qCw1upW0RVbQm50EEsKMPUkIu8XhtV4AdWwNdvjdXFThiRoTVS2ePf8GVMiDQv1lAa27/wS65cvmolvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477548; c=relaxed/simple;
	bh=nf+R02+pjhtsyUzumbeTBX0BQg3tdsTFzeaRhqxDnK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKCF0rQESeXWwEoZutkWR6zEVPMr8umi/L/c6AaRthL0nwEnReq7KJ19B2QwBUHuW1HQCLJtN5vo8gkDwH+8mGFbwmBJpXOZQH9VLLcxyxWM51B8fXwMSsVsQEEf7GtXCSrq4JMCom/7Q9dWvqcWP8ybCpogaZMDf3xd6cXku/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSm7JxjL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso453397966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753477545; x=1754082345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf+R02+pjhtsyUzumbeTBX0BQg3tdsTFzeaRhqxDnK4=;
        b=lSm7JxjL+CYh6d8ZxdjRBVpt2Jl0L+nSkHTz2iA1LsQynGvbYcO6x08i3UybMl/ymY
         ZK/E6LbLd6p/e98nDJVqhtW75SiWEfMi3eCOxQMV4o/ZGgC3n33XNAa9gdDTa+HaekSt
         maVvcXN/2NxBPBYzQe1tGVgn49DrJDoNBywMIB+b+t8uW7Q/so+lw0VEMaXy4AQ+kCjl
         O59r8bI6GYN8w6CEgjDrMgmWT7A+TL9OarfMSjnYQEkO5VcTZvQShKKynHczd/ZYov+P
         /qAA/B1SublRcAaIU8AU1lPHH5bjhWrwMZikq9L5bUVkodhFVLSvi+NGXO5RpicGX3+A
         wzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753477545; x=1754082345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf+R02+pjhtsyUzumbeTBX0BQg3tdsTFzeaRhqxDnK4=;
        b=XwqntV64IEGUreuQVamxAjIUJo64dBFDenI8+6ocOPvwzTTLCM00XEOE6DqZ3j+WPr
         xPdPjckMiKr0bpBr/n+6TN4SfN6fsvw01srt0o4rXKC/K8S7LHkHiUgY9mJR3TwF94N1
         G2f3QjmZAaWtCdmRLDP6LnVMhgVXYRZK9e+vhqIXt89x7gotN4kr1xkcc7tnilPNdfoI
         r/WbInROkteCMp71Z1XV/Qgo8bK8KIpdni4Jlqi9j1VAoH5gay6G4L8mfrXrxi9MPh7Q
         P7ZaVf+WWDii4LJnzNyQwGxQZ1DAdw9mu85QKov87MSn9Al+eR+trVr6EsWJKQVdiMVg
         8N4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOpVvAIpneJLuqhS63h1yTvVE3qWmGuepknuomMsixtmu6x+AsNGtdEu70494t1T1RwmmzNZLyfB3SBBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNkzdPBYRVXD0QerA61GDhU4YdhKZJfsM2YfiIS60AI+Q0qrk
	oyNWLJQq/Oy7jehMjGVjsD7XSmxDSAZJZlxAqrfKFRT156lIbwWl21f/T6UKXwmjGqBPgtGt8DR
	WHryJeUiRF7t6GA4yTHVJ0ZtgATmxMxarfwpwNr+g
X-Gm-Gg: ASbGncvP0dbrXbo7e8zfsSd7FVbHi93nSGk392U6PrqaDagTZ2CVpLMuJ5qVleW2rFH
	y6puL1UG5F9y+Ls/lJfs+Wt5uYHux7go5MB2tZCqDLoQj9lE1v12W1tEOUBBMsn/nMomK10C7Tk
	Zy53og1WJsisox8KCLo5OVqtPVcG1Cpn/VL1LdwQ6Jlps0jzRKrtRSIaLBXwa1sl/J4x2FuBMgv
	uN7Cj/ni4eJa4p4ume59k0e78LCxPdzby4YKTdUQPVp1/IZ
X-Google-Smtp-Source: AGHT+IELAu9YuIK2gpEKQqlX6S6RNRCmG5Auv842Kcma0vF6HvouVSX2qV6UIVxCupefMMHOEt8vR1Wv6bnzwGZ3g9w=
X-Received: by 2002:a17:907:7743:b0:ae3:6dc7:1ac3 with SMTP id
 a640c23a62f3a-af4c3c4c1c5mr740099366b.15.1753477545147; Fri, 25 Jul 2025
 14:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701210230.2985885-4-zecheng@google.com> <202507161052.ed3213f4-lkp@intel.com>
In-Reply-To: <202507161052.ed3213f4-lkp@intel.com>
From: Zecheng Li <zecheng@google.com>
Date: Fri, 25 Jul 2025 17:05:32 -0400
X-Gm-Features: Ac12FXxmKByQmwfUb0QXa5wHOkURuD6CJej7ElHNuDTDyyw5-98nj6F_odDj5k0
Message-ID: <CAJUgMyKAcnJyZbKpZu=MxpSRav3KEr4n2U4-xZJ96QN_aHT8hQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] sched/fair: Allocate both cfs_rq and sched_entity
 with per-cpu
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	aubrey.li@linux.intel.com, yu.c.chen@intel.com, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Josh Don <joshdon@google.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this patch series.

I'll be communicating from a new email address, zli94@ncsu.edu as I'll
soon lose access to my current corp account.

On Wed, Jul 16, 2025 at 4:51=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed a 8.8% improvement of stress-ng.session.ops_per=
_sec on:
>
>
> commit: ac215b990e70e247344522e1736fd878cb3c25b6 ("[PATCH v3 3/3] sched/f=
air: Allocate both cfs_rq and sched_entity with per-cpu")
> url: https://github.com/intel-lab-lkp/linux/commits/Zecheng-Li/sched-fair=
-Co-locate-cfs_rq-and-sched_entity/20250702-050528
> patch link: https://lore.kernel.org/all/20250701210230.2985885-4-zecheng@=
google.com/
> patch subject: [PATCH v3 3/3] sched/fair: Allocate both cfs_rq and sched_=
entity with per-cpu

It's great to see the kernel test robot can measure the improvement of
this patch.

