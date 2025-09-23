Return-Path: <linux-kernel+bounces-828013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4493EB93AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041FF446958
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53782148850;
	Tue, 23 Sep 2025 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1Aw0tWy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DF8488
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587059; cv=none; b=Bv4T+CMXHCzSBIk7ULMaFYyI9okV0uOfBKcvqNVRUM9cTxQp4abRIDYAcbuskJ71wvoEygy+fR5iFvjoLNPDDO6EJKtbqyk6By6VFMroLEsamJFY6nX73fuMZC9ynGhv+nZPukZHIRhH6n7TqKBosL9lWrxPIndP46iflVCTIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587059; c=relaxed/simple;
	bh=We+6Oo/B3It4pfhVAUGEgzbLb7NyYjOXynbtMngh/Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIutDH3BwJ5Mk77aJE0aI+Zp06AhLtTyXPpErf1vnfqYDUX7KjgsY7+B811r+iUEw0w7SQSIl7LI/HSZ6Fa80u82VARAoht6B4AQjyqyYsTiOCYN336RN3hzuRkvbaXrXUXafLSk8vatND9ljwnq1QR1c4gun3GnKGYzVW1HRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1Aw0tWy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso2162504e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758587054; x=1759191854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IqwzB6yl3psjgyq4ph4McKGH6xE5y0nJXDS5kOA8co=;
        b=n1Aw0tWy6ezBwRca2BUqtrys8An1lkYIYVMri7j5qMD30tMv94gA6jFrdEVMYXZ2Hi
         RG6M0KL92OBO9MoeuWEVCUGAvYftFOP1doWLBDksSfrhbI15SM8UdZSemGQwQr6/b/sS
         vSt3vAxnCkG6SAJjARozR7m0AWOnypWIndumVvGKlwDdz+jDZh+t2X5HOucjYJ2g30Zo
         e2uqieJFhSukkCtMzghq+HHWqWt+wfQRUgC1o8WquLyapS1ySHMDbg1cpgpJTgBBGLwB
         ciAkIWIiSft6IYW7sdr0bVMgSRXNroFdRxva6BrQCa0RtywA7OT1woIKYJFxAfxPRB2s
         QqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587054; x=1759191854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IqwzB6yl3psjgyq4ph4McKGH6xE5y0nJXDS5kOA8co=;
        b=pKSVduonmznd+q+bCUpS0ZwfLahUko/Djou4fWjCgGoInL1jqzrOF90ghRHiF0A5On
         CzZJWc1chvg1hYaeTYFmwW5bPZcdTihfKExt23XBGdoq3IuuxsdNIyPVXCwIrvjdjh5x
         M4/5+tZCtvMHO//8SLiA5VZYcLF9yG44lzDvxDMRpwHjEJNgIaeXRnB+Bz9911kWrhjD
         2UhRSxjT3Pfv2vt2WdbSlIIGlGZ61CJAsy8PDrd99BBbUrBRwlI/DQNF4sojZqHC2NBy
         LGOypN+GLRnlvJQBde0vpLnVkuyJ0ru57s9N5dSadUUyj86+ytpnIzcu6optqy7ZeyVJ
         g3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlF5os3LfkSeiBNwBTJ/yus190rEhPoxiYPnXTEftK7hnfP03mzE2pRMOa3sgVMoGHLc4ionEu8VSbpkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuHYeiykBq0Gj0lvxzGda0byYNE+rVSpruvRtHOtLVg6AFZxk
	E7i4Ikhw7Sfe/lY+BbIt6zIDcNR5zRXgcYIbV2PfXVhtHO8oVfCXQ2NrznGD8J5nIRRH5vcD38M
	VuV+B4aYErcCD+QeJWrI++PUmfWem6DodSLIX21A=
X-Gm-Gg: ASbGncsbQWfwHqT5aZFFpm3/mHTJnR9C9XoiuxIVe6TKzoqADyC6iugIu+jgIUzp/J3
	cnSYikUZ3aH+3deYO8+5HUXsuTY71hU0ysagUtPPs34BroMiVo73mPpInoXvyMGVWn31QtraMac
	aMPzfh53uoRIS8vxMMsMWq6fOuNpQuysP/t6bCJ5tggigNerhC/gChB80HhndTJ5OJyWKMzooLh
	F3TsNDupKANFhbr9Bv+/Jg3R+WVKqHtNu3L
X-Google-Smtp-Source: AGHT+IFdN2gHO4WykbivdCKetNJNZxMeVTvdLnoXGtLxAJC5ZsJVzBnaT4eywyMhlcKmiI+QyMamHNrqO7yCI2iAbzA=
X-Received: by 2002:a05:6512:450a:b0:57e:4703:3b0a with SMTP id
 2adb3069b0e04-58072cf6687mr123242e87.31.1758587053782; Mon, 22 Sep 2025
 17:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918075219.091828500@infradead.org> <20250918080205.442967033@infradead.org>
In-Reply-To: <20250918080205.442967033@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 22 Sep 2025 17:24:01 -0700
X-Gm-Features: AS18NWCTcK_8h024Wott-v_xedN8OzicPoyVhpMnQ9HLHwhEpS8zYovFK-qMvBs
Message-ID: <CANDhNCr3hAsJRSMx9-yHA6Jv6ASCgjqGH=vVO4JhRSTp2v+0xg@mail.gmail.com>
Subject: Re: [PATCH 1/8] sched: Fix hrtick() vs scheduling context
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, arnd@arndb.de, anna-maria@linutronix.de, 
	frederic@kernel.org, luto@kernel.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> The sched_class::task_tick() method is called on the donor
> sched_class, and sched_tick() hands it rq->donor as argument, which is
> consistent.
>
> However, while hrtick() uses the donor sched_class, it then passes
> rq->curr, which is inconsistent. Fix it.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -875,7 +875,7 @@ static enum hrtimer_restart hrtick(struc
>
>         rq_lock(rq, &rf);
>         update_rq_clock(rq);
> -       rq->donor->sched_class->task_tick(rq, rq->curr, 1);
> +       rq->donor->sched_class->task_tick(rq, rq->donor, 1);
>         rq_unlock(rq, &rf);

Ah. Thanks for catching this! I've run through with some stress
testing on this and haven't seen any problems so far.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

