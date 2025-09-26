Return-Path: <linux-kernel+bounces-833462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F1BA205F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C121B25B62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058678821;
	Fri, 26 Sep 2025 00:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiPchGwC"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD610E0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845157; cv=none; b=cgEL7Eoi77Mj+r1JL6/NGqySBz0MLb6w7pmehglhKB3rux/eYwQ5GYAY/fq/vysjvY4OeJL9Lu2YFjlB3Gcneq5vALbs/W4B4kQ3ITPC2QklDCqruwgHkBRpvLbWzoGfBlzBqjf0zGu+AEIdJOuHOoukh3zsU2kgsVUy0sBxoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845157; c=relaxed/simple;
	bh=mkisGz3UU5OhYClBkPSgDD1nrC4IgdFnh7r/UhmAJXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOmdXq0P2Dg+U2BlJtlDZwIvL/7w7J18BXLAE01vNgQP9uuuBqPciArmiB5P39ai3SRsxIudJTpcu/+PUf8KqMaNlv3IrnLdr9Gypm4p17XypVbanK6QhoPYT9UAfUvX+MydpxoxzHqiP5niLBqeVeSnvImNLZGRmLhHyaxeDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiPchGwC; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5797c8612b4so2118709e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758845154; x=1759449954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp5tcC8TMHe2cJtq+fJR2KXIS8K2iwId/v9FeWmSi5Q=;
        b=QiPchGwCWFSNOUIZ6eHze0L+1onG3JWIeyzndENlaELKuwcVGeRfW8fXSRM6GVi411
         bPTVF4HUSD5TPeY3wJLxqvah/ohNIyGe0iddSQ5mwMSUka/aT4UDcNfig95hb8RlQK3w
         6yYEN2rxTL03xUHH3oJ1NZmZPeHkQW0nEH99hspfIYvkNroupFySzW0tTYs1ykDCJ0sz
         NBgwfPwbiawic4955i0CdqABeHF3SMIx5hSRqLGiD0BUrAAIznCpCglsTdCrNSaKFuTQ
         8HZj6Rf27v3J0R7vEVM90gCuqITlwAtyiIsYsC5cyXwO+01kRjNhrXzAUxtc8Hxny5u9
         NchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845154; x=1759449954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp5tcC8TMHe2cJtq+fJR2KXIS8K2iwId/v9FeWmSi5Q=;
        b=aELLWnPqgHBDq1zOY0dOX93OjxNlChMzUVO0/QtSVZAleSX5oP/ghrzoFmDafL5vjr
         iuRWUoC1Hr0eACrfO5HgtNq8ArtGcCUHhQZn3l/7kdEPb8Z9kQiEIU8Qk4n+HZHHAuwQ
         S28tX3lOdNCT2Mmn0mag5F78Dgh8Ml9W+inEWzk+cxGy0KM/o+O0Lw71jkhJ70QON951
         q/FQ28w2fldvAikcpP/nVTKlZ09r41GdcAIelVes7lPmoN66jIycZEdznsSyYBv1xTpV
         w295H3Ih9v2+GhV2l3VVjuRtEsOAsed1n1FSIZUitvlYJJpo+Dd3J8+0uQJQ+L9dclkN
         Sf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNJwkNM+EYpFCGRJb6h0FWDn1WJuSWSLVK+YYi7wZMevHMgEsUW/cEbDtHoAVF97U/8fptr8pJVX99qiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZku57GIHQa6nitY10GQsJdJ3JdlwmBheL3m8rFtT2Vs7Holzy
	MBywQzZAEm299Cu9zvboVr41YjWorHe9HW1RLTOysIx/2xa+pArdX5rvAaj2wHRg6K60us4283s
	DjdVUTwaTOzhjodhhBfAJMR/56u+Q89MGCZ+V1ms=
X-Gm-Gg: ASbGncuvWv6cbciC/nSvdlNcS8MKq3sYJFxY7EUtqw/m4KTUNT/K4i1A8QYFJMhVg9t
	6qwj2LXeVu2iny8GnLPe6i+xPWDOwZ+kTISy2Er0GrMFmmrvaYOFviEpae/5QLYsC+SwyAefIr4
	2N3RP8D0Qo3q/QMHtkXD0384z0CTw+P59wOm462tLF7f73pmX0xguCRoTv3YC9i28eLvZlt/zR+
	f58YLssBzuW4m+bJXoFL1vYG5YW9pxcU3KTiCTBxwDHulQ/PqOOCw==
X-Google-Smtp-Source: AGHT+IECFDWxoexEEw8mihr5z2g02WUmVMaFysoilJ92DTUBSLarKqHikWFEw7Ks29UnfgFLHaKltBp25icjbttX9Jg=
X-Received: by 2002:a05:6512:3e0f:b0:569:f345:4dda with SMTP id
 2adb3069b0e04-582d25845eemr1726529e87.36.1758845153512; Thu, 25 Sep 2025
 17:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925133310.1843863-1-matt@readmodwrite.com>
In-Reply-To: <20250925133310.1843863-1-matt@readmodwrite.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 25 Sep 2025 17:05:40 -0700
X-Gm-Features: AS18NWACyca0qGov86B7zy0-toK5Y5ugLlWv9dV_b-Di8Fm9ztljutU8zvbW05M
Message-ID: <CANDhNCr+Q=mitFLQ0Xr8ZkZrJPVtgtu8BFaUSAVTZcAFf+VgsA@mail.gmail.com>
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

On Thu, Sep 25, 2025 at 6:33=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> This reverts commit b7ca5743a2604156d6083b88cefacef983f3a3a6.
>
> If we dequeue a task (task B) that was sched delayed then that task is
> definitely no longer on the rq and not tracked in the rbtree.
> Unfortunately, task_on_rq_queued(B) will still return true because
> dequeue_task() doesn't update p->on_rq.

Hey!
  Sorry again my patch has been causing you trouble. Thanks for your
persistence in chasing this down!

It's confusing as this patch uses the similar logic as logic
pick_next_entity() uses when a sched_delayed task is picked to run, as
well as elsewhere in __sched_setscheduler() and in sched_ext, so I'd
fret that similar

And my impression was that dequeue_task() on a sched_delayed task
would update p->on_rq via calling __block_task() at the end of
dequeue_entities().

However, there are two spots where we might exit dequeue_entities()
early when cfs_rq_throttled(rq), so maybe that's what's catching us
here?

Peter: Those cfs_rq_throttled() exits in dequeue_entities() seem a
little odd, as the desired dequeue didn't really complete, but
dequeue_task_fair() will still return true indicating success - not
that too many places are checking the dequeue_task return. Is that
right?

thanks
-john

