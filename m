Return-Path: <linux-kernel+bounces-877007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A8C1CF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FC91889CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52533596F1;
	Wed, 29 Oct 2025 19:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5a246xF"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7337A3C7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765200; cv=none; b=uG+dTipFLHIEQkyOukrTSbVKEaCx5qIGzeH1ACr1ziwmx9oViHdW32yHYNaoDvrOb+EjZI9Lg82htWXxaiGdAe3sq8uqPSevWU4O+8hc8XDwrloBefhSmq5ym9p+eAL/EaalWXPffGMB0CqsB5k3dQOG/MA2qoXUy421WKtkdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765200; c=relaxed/simple;
	bh=wEif+tTm6FsxcGvUKSJGTziV/vmWVR60M/4mstU6Isw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noc3TKwXTx04jyp3YT1JC5+i+ChM3s1HaF1JH49KiwFFTOL4oItzAapxh4RcrZE5rY8oIrENyHXVwWJfPreC11t4t2pw8x+iMrpDXzic03L76GJD9VcyT/cU5Hlvdtyi12S/lLRgc8UHL8MFNnTcuXYM6zdTLDmBbUVO3igqoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5a246xF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d6984a5baso43158866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761765196; x=1762369996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+qfBJph+QzP7zEO2xurOi3YHAiU2v7oOmqUh3rS5iw=;
        b=z5a246xFNBKl0JrYg6/Yj378Z3Pur4rhlMd9ALQ8juhkUurMeew+DrCMWjs95DRuLV
         yVWV9FTHWyAkPQ/aEsT3yRa2s/WTEY5UmsyLQhddTqlUDqtPRHgHGgTv5ngEvoI7n5FN
         e8h89Hippg6wtK6XO0cyJRH5jgcq3Fa3zxSE3UzeRUpqLMxzPtM/ZM9jrEw/goN9Vcah
         5cWn+uIphjFTJPoYg4tYA6Ssuyzf1z5LQXkm98lW8bjUmrp23gfDrVkDoEmObDamA8Ut
         K23ZRtmpbLElfp1He+NMgZjowrO3mTrtwNntdpxvHcU14hmTO+Bz37Emf78wM7SB7F8l
         dsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761765196; x=1762369996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+qfBJph+QzP7zEO2xurOi3YHAiU2v7oOmqUh3rS5iw=;
        b=qa2T409SoAGNcElPbaxbXlLu7GlFF+N15aX/n/eIXQXvgKmux54+rICCMlKYsHkEtb
         oa3qIYgsX4k2Z6izwu4Ed5BpGUuxeIHLjRza9NQH4B3aPSm72eRnsIdJ8kjKRLU7zdLW
         c6HbOctwvFnBdfYBroLIATQPlO+KWRnA3rw+IBlUvPFFo6oxyWUxt66ANz5vxx0N8FCc
         TiOe6sQAxyZvvQJtLe7w052ZFC0z5vBJyYGD61skHpviNXhzv8ExLNVdomsvtvghTkXT
         sqJdbxcDw7zDemJ/WAtJCJVibnqx386pZdPgFWh5aknxhaqwyIDIrmxRpVpuu9E0RB6V
         iDGg==
X-Forwarded-Encrypted: i=1; AJvYcCX66ddxM3BiUtK3YZxodKnnnX3bHj67ZGlPrMnsLIuYrPv5xm5DmHqT5AHMvv23IMDLwVFzRL1BNDvyrmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSTbRpQ+WBiy4baESTjxsve7nfOKCh9UJIyc3l+MmnnTclrtr
	VEvxQwov6hklKW8gy2IBbkm61IhxWfBufUcDIFuj9wQ+Ph1c2GLz28usuY/LVU55+LoTZsMyDrl
	/m6kHVZOh4IT76HO/gTsT3t1JjQ2U2D2PIhciwovZ
X-Gm-Gg: ASbGnctXmpuIS87bSkZXpq69fDlbHn+b/P3XpD8Oz0aIe6LV67TSak1NqAY+5yp/xfr
	yMFt02WEatBSTWAFgIcXyIXLTVE/sFGzTfx2B0siBP+vfyWS/TJ5HqTX5EAr3J9JLQDdY6fwTeW
	rzwXWLKGUhQIwA/LaNb15DjyLa66yTDtu+rOtGuceW+XokzupDil7jVyuQJyKoA7udLCBacr2hK
	t4P30blJAeiDj6uIDCo3RfcCvUdT4S4QlL/zlOUV6S5Rt0wQ/H7pGSWZ8GsOaEyzFktveKDbuj7
	By45qsPUvUz+SGROCnEKkFAt
X-Google-Smtp-Source: AGHT+IG9lCLMP3WfzOeKrHYSNdioOLgkAAqKOazze7+9Yf0+DlHRVe9LT0b9LEsvpp89kkNVkaZRIPBBdyMoM/Mr/Gc=
X-Received: by 2002:a17:907:1c91:b0:b6d:55ee:506d with SMTP id
 a640c23a62f3a-b7053f41498mr24589166b.65.1761765196287; Wed, 29 Oct 2025
 12:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <CAJZ5v0g37NNj3inHcrZG8NHeTAGAncLAY7t9Yj3bTAv7GgAQJQ@mail.gmail.com>
 <CAGETcx8ZL3jAwFRxO1B8SFSWmC2jCitc9_61hBG-N2AvzRQv7w@mail.gmail.com>
 <CAJZ5v0jiLzMvwBfcXKJEOMqa_U=6OeWymnBCBdxYfcgU+7P1Aw@mail.gmail.com> <CAJZ5v0hpG19Tj9qmTkXQ_6N+wTSBD4Lzx9UvFwTh3WtUagCOGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpG19Tj9qmTkXQ_6N+wTSBD4Lzx9UvFwTh3WtUagCOGQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 29 Oct 2025 12:13:05 -0700
X-Gm-Features: AWmQ_bkCmls2aLGFF9xK6RGfFtDPVhNHDC6lphbGJiwg0qAFzWRlaYZ5LBG7r90
Message-ID: <CAG2KctqoOPg4E6dN0UCjkTF8w0hC7FUwfYOWkw+i37G8OxcttQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, tuhaowen@uniontech.com, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 6:23=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Oct 24, 2025 at 10:37=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Fri, Oct 24, 2025 at 12:47=E2=80=AFAM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > >
> > > On Thu, Oct 23, 2025 at 12:43=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > >
> > > > On Sat, Oct 18, 2025 at 1:39=E2=80=AFAM Samuel Wu <wusamuel@google.=
com> wrote:
> > > > >
>
> [cut]
>
> > > >
> > > > If I'm not mistaken, the mechanism by which one more sync is starte=
d
> > > > right after completing the previous one (that was in progress when
> > > > suspend started) can be designed differently.
> > > >
> > > > 1. Use a dedicated ordered workqueue for the sync work items.
> > > > 2. Use a counter instead of the two boolean vars for synchronizatio=
n.
> > > > 3. In pm_sleep_fs_sync(), if the counter is less than 2, increment =
the
> > > > counter and queue up a sync work item.
> > > > 4. In sync_filesystems_fn(), decrement the counter.
> > >
> > > The problem with this is that we can't reuse the same work item. We'l=
l
> > > have to allocate one each time. Otherwise, we'll be queuing one that'=
s
> > > already queued. Right?
> >
> > Of course you can't queue up an already queued work, but there may be
> > two of them and then in 3 above use work0 when the counter is 0 and
> > use work1 when the counter is 1.  No big deal.
>
> Moreover, sync_filesystems_fn() doesn't use its work argument, so the
> work can be requeued as soon as it is not pending.
>
> Now, when it is not pending, it has not been queued yet or the work
> function is running, which is exactly when you want it to be queued:
>
> 1. Use a dedicated ordered workqueue for the sync work items.
> 2. Use a counter instead of the two boolean vars for synchronization.
> 3. In pm_sleep_fs_sync(), if the work is not pending, queue it up and
> increment the counter.
> 4. In sync_filesystems_fn(), decrement the counter (after carrying out
> the fs sync) and complete the completion if the counter is 0.

Thank you for the thoughtful feedback Rafael.

I agree with these points and will incorporate it in v6; this approach
seems more elegant.

> Of course, the above requires locking, but I don't think that the lock
> needs to be spinlock.  A mutex would work just as well AFAICS.
>
> Thanks!

I'm still thinking this needs to be spin_lock_irqsave(), since
pm_stop_waiting_for_fs_sync() is called in an interrupt context and
needs the lock such that the abort signals don't get lost.

