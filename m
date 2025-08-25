Return-Path: <linux-kernel+bounces-785289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C32FCB34899
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C807A563F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27BF302766;
	Mon, 25 Aug 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqBMoMH3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D21C84DE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142672; cv=none; b=kB7x64PRwYdRciVi0A+i2nfT6qFc7a+i4WXP4N0YOml3D7gDxFwXQgeqhHYbsnChLumHAFQaskHsm/SxyLzfHrt4MI5H+3LTCvneoslHiyJ47shxLgujs/niDEGYLCaPSVKKM2Jd4LE3RKiIvus5gOYso3R6kIn2+kDuAZif+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142672; c=relaxed/simple;
	bh=XhWDg/JIuuCQd4L0mouLCvJf2fOoYTh89nNKKlrcIks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcHoFurxhAI92ot3/0+GUDy9GK6+42OYOPsV9x0p/WLjf2ABzaeSz4KYws4r/l7/1M0dl5BHdiE8F8Rx03Ik6ebgDi7vf4arstXHSif8k2IbjdZpSLLJIshfjjwN5BMZtI8D6AaWqQj+gyTzp0LFI+9dQ4jbNMonPJycsBPDNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqBMoMH3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-246257e49c8so14535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756142670; x=1756747470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ORHuStfojgrwK2UdFk3EZ3mv0VOd3rvM8MRoO+GpXI=;
        b=ZqBMoMH3S6ZPuEe9tUZqj9lkCppXU+moJ8aXG/BIvG60yjE13UlCQJZqmZye+0gWVH
         7nfK66BmihQigXkDOnC6zHV4hO6mx6qP2wzRn0yidrywrVie9YRC7JyalSL8T0bTBZrN
         xj79pgBrMz7rhK7J9YziWgsuKcz2FtJHZYvpnaFGYh+jfjlnR6vLaq1Ko+CQ3gnY59d8
         uI/0RayazQ2adBsLnVZXVrmWpJlNSolShOGXJm3nyUXKCjWukim/q0IcKAPK9y6bKj50
         JWieqEx+gv4V9aIZh0u71elGBIurRNPEhg7HROmL6/lK4SGrHqg1zIdf4x/xiLd90ODv
         +6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142670; x=1756747470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ORHuStfojgrwK2UdFk3EZ3mv0VOd3rvM8MRoO+GpXI=;
        b=rBjGwhviDjyIHqXs5te+2rZgZ9Gvg9mghNRzrxL6MCVLYC0aLQXzV5VdnlWO2HjWGP
         +lSEntOW4mylVx6/fIQBEibvwpnQag3J3ONejrIt3mU+/ctF+vloKZ73kScAlZo1QCl7
         Fy/nC4qCCRytD9v9T92CJO/i/YVaLE5Wgw4+xkxkRyg+PAYz5OKp2h/sebyUFnTfMZQS
         XQcqxpwnM37FprbY8IgjvXzwc8gWeWtIxj5+tGNfgk70lEBTIXLAxsd3nGWRmGOr6A9w
         eJ7sYNzUpzUgIGf9m/aqZZ7Z4D8Rqk/92qDdXFaSAOv2S1qCyaI5RoY236m6CLFSiQuH
         oSGw==
X-Forwarded-Encrypted: i=1; AJvYcCULhI48tZrPQcbiuQq1u3xGIV8WsAafEEqa2hc6OGmRhDqPk6H2lPw3AvkuAd2F8+sDes5cLGEqyK6txUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQKp7kMM2kRamRj+ie5DRSpnFCuxoZHlYBJ622liINt1DA2jy
	Cp8TchBnCPCX3NX+i/NFYAJd3qbddknhhur+WaBeAQ7Ks64pIgKr1LyMM5+YZQOxTyAKZJE8/gf
	eD01uhPrxeulMJMQMhy9YlffKAjxkTYqbw2+driqv
X-Gm-Gg: ASbGncseQL/DIvoduFAJ7OAjnlDhx4HeuThARZTZUEWMK+gpWn6grtCcLEuUF/RZhmB
	umw+nuRY/qJBUGGW91ExXclPprnYQNxw02O8/kqKtmY9lyCGE6IAaCo8bb2MHSleEt9ZRasqD7Q
	WIcno1xOxj4F0DvXW6UO1Pkxu9WEK6jdu+MNJEDJFU6DfTeIyP3H5CIJvzntsY4sNoOdTYFVa9x
	+lLQA7KDaSTfOaxeZ2sh5ghpEclAuO/osz2liMxlo4c
X-Google-Smtp-Source: AGHT+IFDSFCq0edWCtHzT5OvxvY5tWpWD1aTjc3Lol46yrNUvieLKtXYNl0Pa+8dgZxjSHXFJ/lZHYpA827qlGdI904=
X-Received: by 2002:a17:902:e548:b0:240:6076:20cd with SMTP id
 d9443c01a7336-2467a3cf14fmr5726415ad.15.1756142669923; Mon, 25 Aug 2025
 10:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com>
 <aJ-ScOp3ZCG6PQmD@google.com> <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
 <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com>
In-Reply-To: <CAO9wTFiJmi7YzeukT0VtnpqcJcE3sSueO3owYUAd+H4wjcYZeQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Aug 2025 10:24:18 -0700
X-Gm-Features: Ac12FXxRIuAN942liX6eW3sy6FarCbSuSJ3avU2MB-V3vtAsi5N_-7cGnerDC44
Message-ID: <CAP-5=fWCGa+R1O2sL1anJGznkprQyP2RrsUZfzmrPJ2y-WsEvA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:17=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> On Sat, 16 Aug 2025 at 12:16, Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > Hi Namhyung,
> > Thanks for reviewing the patch. I'd like to ask if there's anything
> > else I should do regarding this patch, given that it's supported only
> > for x86 and powerpc?
> >
> > Thanks,
> > Suchit
>
>
> Hi Namhyung,
> Following up on this patch. I would appreciate any guidance on further
> actions needed, considering its current support is only for x86 and
> PowerPC.

Can we just make  TYPE_STATE_MAX_REGS 32? There's no reason to assume
the architecture the perf binary is built on matches the perf.data
file being processed by perf annotate. Given 32 is bigger than 16 then
this can just be a maximum value (a comment to this effect in the code
would be grand). In general, the use of the arch directory and things
like "#ifdef __powerpc__" are code smells that are going to break with
cross-architecture profiling.

Thanks,
Ian

