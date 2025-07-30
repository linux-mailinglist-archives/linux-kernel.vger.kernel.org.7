Return-Path: <linux-kernel+bounces-751326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB2B167BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9DE5465E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE0221F02;
	Wed, 30 Jul 2025 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2H8v1pqI"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062717BD3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908326; cv=none; b=SCC+ZeWX61YMa63JulkXdhGDyESwn/MDvHaGkyOsasvnsHSn2ZxZvAlpOFym4Lf3n3ehT52xwMqSwa6iszsZYfdRPm/x4jkzwkPvkJ+Pgxk41XYma89LdIyyHLZqAdDsH4zSuh9JbqHLO8XkfLsjduPDREfAE2J3l8F28hPiNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908326; c=relaxed/simple;
	bh=jWWojrki7Bdjp6IXZ5FLs6NvsW5N3XjHDGupr3F5zy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQoXteKIssG0uAah+89cameEggcq5W6RbeAUrEQ9OtostbOwClWiW8RKSL3TPRy63YU0+CRgrxJ4w+/ryMjE/jBKUxDVha3dlC4rhbl/+w/4A7nI4i/gxx3nG2Tp4uwyyAOcsPb8In9r0fu7Q8CMxZyTZ6jHsMwYsNokWwnwAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2H8v1pqI; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-88ba6bb90d6so702600241.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753908323; x=1754513123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWWojrki7Bdjp6IXZ5FLs6NvsW5N3XjHDGupr3F5zy8=;
        b=2H8v1pqI1T/IS/yWS5pRcEwIZ9UmACifqouKT0Vk2x1VYzrYu00KJPvV2TioD98LPY
         jpkxfRi8jfGZJun5kDfkWmduN0j2ht6qqqiHoqeSXNk2boVwqHBhkjG2PqKfvMy2GZX1
         tk2qBTI6p/rLVRgCn4TXHnaIz21SvZDNnK887oAWQlN1CQlaTBEh42LfbfGDDOqsvzeW
         ErLeK9oMnpCGkUSW+7XRv9SQjpWutajPwrUMjAMdqaS+JSfASHY+T/cPLxgcVdC8kGcC
         eN5AQNGevrzgukmzS5zv1T5O7GnDQhfUhx9/JcYeowFnviXOROgCNM8xI8wO4/ZNN47+
         dnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908323; x=1754513123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWWojrki7Bdjp6IXZ5FLs6NvsW5N3XjHDGupr3F5zy8=;
        b=RAu73h1Psp5qeKKvokrq3It+voK5zCIYvA1BpjDpUjHpAgemXm2dE1+QpA+7bwFJv0
         ssaLbwyiN1+3/ZcqlS6qwWhmiueNDOJ686AXffnIKwY1g4kQnlsUQttKAf+gpLS6FYog
         NfBx0oYAgjPBA9HeCxM6b8IYRIeJonedlllIDxgD/bcZiFgdLEh2RTL+nQw9JKhsMeJ5
         Bnw9fbRs6CV2pkSM0SFsQBhYAPoDDSZshMjX72fGq7IEzqAfvViYndWzQG9uUdTG2Xk/
         lbo5Xj0Jxu4Izs41/KYNefJMyqndDnVoegsz8MMRRlSlVei/2Uzc5Huvk7fU7sQmCJih
         P9jA==
X-Forwarded-Encrypted: i=1; AJvYcCWsxhdbnoB5vvu6BHVvyvqG408zXEHB5W5uO4cof3S6sCTJGe0PxaGh9id2DvARrmnlbRl3OY/quuJNWuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMkwkb388buP2QrLNJY1t0mSxcW9BmNPzJ4L1AM8eGYLqtB5+
	NsiOVKxT4Y9qWOMVsembrSXSqw1fpA9Gkc1v+ZDJ7cJuRiYDhcOueWnLDc8qGKX2BvySSTqs+qx
	8Y/nlVFyteBJdb6jBh6NkmUtXa9G7k78WHdrrTlnu
X-Gm-Gg: ASbGnct1uks9/NqtRLNzTrgpKmfKcb6V7yEO50t9NefYyAvcjzsolrYEb87ldUTh2c8
	PYHpYxvyA3wch1d/LTDA1I+RaWsBlZBYI2rsf3Apbd+U7jUk1VA8ox8FbwomlopgqbqVZVL8rAs
	wO5dBUIu9Zi2SLkQmaPxATY+CzHOuz5i0nb+eP9Esj7BfCfhFGTHeQKKaP0rEVEu2zVqVpTPM6E
	cxdE4Q=
X-Google-Smtp-Source: AGHT+IH8/U6JMfqcjO154ECWbOMAqkb2DK3l2TsUoDNfev7MejOE5ivl8dmZFrd5hgg0lQjQZd7+ItqmaxnHg4/9eqM=
X-Received: by 2002:a05:6102:610a:10b0:4df:e510:242e with SMTP id
 ada2fe7eead31-4fa77918fbemr3650621137.5.1753908323367; Wed, 30 Jul 2025
 13:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722201339.1198239-1-blakejones@google.com> <172e48ee-7d90-4704-ad29-476fa7ee0aab@linux.ibm.com>
In-Reply-To: <172e48ee-7d90-4704-ad29-476fa7ee0aab@linux.ibm.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 30 Jul 2025 13:45:11 -0700
X-Gm-Features: Ac12FXy2rzb-gTobQgj3VGs9VrbT4kp1NR445A3sp0BvCSxQ-wh1VlkM3YfK6BA
Message-ID: <CAP_z_ChAL=+aPKOF8Oc7r0TwLuXxp1qsGibwBMjJ-1K+OnhP2g@mail.gmail.com>
Subject: Re: [PATCH] Reorder some fields in struct rq.
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Josh Don <joshdon@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,

Thanks for taking a look.

On Tue, Jul 29, 2025 at 11:36=E2=80=AFPM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
> Could you please share the test you mentioned? I would like to try it on =
a
> Power11 system.

Sure.

> Also, I noticed the patch doesn't apply cleanly on the latest tip/sched/c=
ore,
> since the CONFIG_SMP ifdefs have been removed. Could you rebase it on the=
 current
> tip/sched/core tree?

Oh, sorry about that. I'll send a rebased version shortly, and I'll
reply to that thread with the source for my test.

Blake

