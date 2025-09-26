Return-Path: <linux-kernel+bounces-833463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B69BA2063
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F5E1BC431C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB532BA45;
	Fri, 26 Sep 2025 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqTe/4va"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352A1388
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845225; cv=none; b=VauvOwcG6jk3Xv8xnCUc9ckd7ZxsQ+St1r+WHW86YzwOnR5lxzf2EC1eq2l5k4viqVwv4sw7vZIUcVlzaoyGGu1mE6uaghFbQOgIGDY58VKXXF2FqDXMTmsiDKkIWHgZfIn9tA4tMphKqCQxbl98peu8c5e2k0L7WwM5H8HQveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845225; c=relaxed/simple;
	bh=+qqySPIS+RD9Ch2d8C6jpEJA6bex3TqAu323+T9ewig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugKevzT4ncNAl84XqHxzr9ooPXb+aAcXEcqv1SoqssRHEB05xEstciDVOYswk3ErVJsDYfRWX5eTph97HJwZ4+PIdnLxjCn5YKAGi+0X2R0giVllwnyzEO8YWL16j3siicvpciGiO+MaOTWoBAhHVQeNptBIllVjft5DytSXyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqTe/4va; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-36d77ae9de5so12143551fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758845221; x=1759450021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2nBwEk2eAXDcNki56ZRHE7qnCAvvWI6uqhPHOUuTEo=;
        b=GqTe/4vaIClwvyzoXk7STbvcVE9442GSI4dHdbcVugtrqpKiZagw4Xg8Yso9IwwzOU
         FyWq5iM2my5VD0sjRjBRK6gNQ/tPC0gRoqBPFmKJlOM6F84A91F0E7RNg1d+sB9y5fp2
         U4IUA5mMkf1rksyUepcpjiueP1eD+rwxncxAsKWmLuINh7GQFxBGjQliXdRXnjJImU9V
         26Hl6JzDAzwJSVvH1MHfBwZc26ZtL+jZCe41P29QHEmuW6JgsCe3NQbwApQfB4sQxVaC
         Sr8+WhrCtVn109PK2n2Tw5PkuqUpvLzyXPFi6ZeO0mKdJcwb2642WKoPOlNZbh8zz7z8
         2sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845221; x=1759450021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2nBwEk2eAXDcNki56ZRHE7qnCAvvWI6uqhPHOUuTEo=;
        b=rz9cEYRFCwLsOD4OBguvGFPPSBCrqMkMZZzpzTUcAjmsxa6ZkFRcsigOSdMKe4a/kv
         HvOawGWkfYPS8BRrogW/jv2wZuOYqgO2WyvrPE7B/uE+l6KstbI8axRKS3yTp6ijykVm
         5RAAe+kJJ/ta8cXU4w+bRw+PpmiG+JEmP702LqGuHsaNal2B7xATAJD1MQL4w1lg9YWg
         OKTytd42eSr2AA5KnCIsHr7d+rrtlOEoGv6s246iW6rQ1kmC1FP+tefiKHAtI5Ngf0hE
         mL4XLwa3Sm/5iX6iPm8ddCh9avxlxMAtYFjEbdbbmSR7Cu7YUDXRh4Q6PQJwY5k8dbEI
         HnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhPw+biqlxjffO4UOUkNzkipqQ3pG86KaXpk10syC8GtLCd1C5nZ7SHW0/OPYKN47z6JaiqPmfGI0qQOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3JbjNAeGM2OJ4DBb2wXLksbMkcF8FGmPBc2BBfdlZhwCgS8W
	1O+IfpFalQ9sm3vBfC3dkNgoL3yBK8c7UOu1AIrUgc7wHJ6VVacopQZQJw3h8YiLSKP9xuTgk77
	QjzdrhYspRRwRw/iTvf78NxZNuuCpmYOh0liChDg=
X-Gm-Gg: ASbGnctWNcTHo8F+t0dXcgTOQbTRpibj58qMQt+Qxs75+Xv4gZ5zTpWcMtMzOhNQKH9
	yWLPqBaTD3lrGK7hfYxjCG/giE38En/15POaFKm/E6bFd6wlDRQxGwciOWiGN8CJn2HE10n+BDd
	EJlSBIWMi25Wc0yXi7BX85C4XWtEWs+NgBN0nzVD+rWHsnGwWK4jC3E1r1BP4021DAl4khh9vTJ
	QaIimrAOMUMwb5oGREh7R9Gr5W1lALm28PN7Q8gXx8=
X-Google-Smtp-Source: AGHT+IEf1w7t7CWNT1vdPjMJPoB7Vai126p2EQGlhIzx5l+95YccPlzQLpnr3phwJBnv2/8dT6rFhSkXPgxvEBAE0g0=
X-Received: by 2002:a2e:9a12:0:b0:36b:9ecc:cb36 with SMTP id
 38308e7fff4ca-36f7f247ab7mr16169721fa.23.1758845220596; Thu, 25 Sep 2025
 17:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925133310.1843863-1-matt@readmodwrite.com> <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
In-Reply-To: <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 25 Sep 2025 17:06:49 -0700
X-Gm-Features: AS18NWDIx7wG2OEqajQZdx5uLcTNiTOxfc1iDY-gkBOx2dIyBQjYB9pypBFcbEQ
Message-ID: <CANDhNCqLqy8p+o9tPb87BWQpbFeVJ_xGUfRoEiB7_mEv-xKD1g@mail.gmail.com>
Subject: Re: [PATCH] Revert "sched/core: Tweak wait_task_inactive() to force
 dequeue sched_delayed tasks"
To: Matt Fleming <matt@readmodwrite.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>, 
	Oleg Nesterov <oleg@redhat.com>, Chris Arges <carges@cloudflare.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:05=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> It's confusing as this patch uses the similar logic as logic
> pick_next_entity() uses when a sched_delayed task is picked to run, as
> well as elsewhere in __sched_setscheduler() and in sched_ext, so I'd
> fret that similar

Didn't finish my sentence there.  "...similar problems as the one you
are seeing could still occur."


thanks
-john

