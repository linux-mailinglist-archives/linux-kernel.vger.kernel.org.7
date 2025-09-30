Return-Path: <linux-kernel+bounces-837725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F1BAD0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C4C323484
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFA2FB0BE;
	Tue, 30 Sep 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="ylO9GGE/"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F356B81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238478; cv=none; b=sSWBZyyBjZ1HmeCSdjbvZ8n971sOLUp4MGg4YWl8tcyDOWoC4j8e8rSpxhVSIxgd/3g+GwC4W9vKVwbAVxzv+5BCC2JrqVqmr8jgkyxyG4pf/lddQF8sSd50+Czmjt4VsJgYb8jt8xKqTQfW5tcCstgO/BEbPU2Mv8C4d2Hskdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238478; c=relaxed/simple;
	bh=MnbXTrT/osZlvFYEt1Q1HAo0yBmq+gaa7vG40qeLrXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ0PoYQyfHa4Jw4siABhwOI2fvKMKo8m+VV8CmAIjeFsJC+X0MDNPh0HvhWwlpSyBpuhNjpYIvEpb2wu6eoK7Ue+1UqHRn8Qy74bEkh2vPyyMld1smbP157Cwp/R+ID8Yrk693+PmLENN6JvTJiqv8Xp++OnRkAbO9HWnm/8qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=ylO9GGE/; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92aee734485so79694039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759238476; x=1759843276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jcJmveinxh0ufmLvJ8ygHeakYJgMcsZcEPwnrLGF7U4=;
        b=ylO9GGE/Bej1vtUDk5FGEw4Pt4UYkFlwVDsXy+xYT3f5oa3MNjT7m1B5ja4/ob+lUw
         gd5WlTfk12EwZ7707P+JoFTNpKiHxWVI1vzZ87l6W+dCX+rp12NPUrHaiQz3Az+stvhv
         mm0/3i8pHZ9i4l2oH8UWnaOyHa38DsGEGdLFvNXfApo33yxgXWY+sXCQ3abaa5uUV101
         VJnXpzOLwuN6CHw+xg6gpCzp09LEb2aNhHWErsoV3YFwVG7FfNicfUW9LIqY3vC7Ku/L
         y1SDy7nZDqoOwOz6TQY6+aGRnXhqCwftBS8tGnnlOJcw1rYJ+TWZ4Hq3u4tt9hFpbt2N
         55Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238476; x=1759843276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcJmveinxh0ufmLvJ8ygHeakYJgMcsZcEPwnrLGF7U4=;
        b=bzmnidXQpUkTRv4OyCqTeoR1GhxYtvka0XFluX6bRAYid+REF1Brz8NAvj+SXpExdt
         ENbdTkZ/r5i0SqYxzKu2Gk84oDscfq4MC3hez7CnNJWbvxuhBOuHSu11rHwM5wHqYmpv
         zponfV3ohcD8qNwK816kMXhg5UJcdgI5CIdak4KlVueQ4828KVnEhOkhM+JZOiIELjQj
         CDyCQQrIsIQOL99fjbPedZATm1ytn6BTj1PdZqXEewClFScdA46rF4EzY/YFnPyUH/Pr
         W4MUqKUa7tVAVA4bM0y/2i2/f5OV1VXVkdsHoEnGd/D4ctKofnoRFHMFDZgt9DB/3YEn
         256g==
X-Forwarded-Encrypted: i=1; AJvYcCVQWBIwJOp1knIeSim2Dm/A6VuVMr+BIyPIMoE0Jjd65HH+aOZtSM9NRr63VunSRb4h5lHt9pcErwpw4OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/95UtUSt4lpj3p85Mmj7cgTcVTercyKFuTXWbLNhOFE5jWVHO
	1CJ2V2pa60zg9+ImfQLcvRYzkew6nrbO8yrrbkc93smD2WLSdttcs3DpNUbX9N0KRqYlzEbmSm9
	qNZ7StT8IWWEZTPrkiPMrEQh3zMo2ouTloPJFattGgA==
X-Gm-Gg: ASbGncvyrDoYz7T8rbQ7RUOQy064ea2Vxw4OJgpPag8gDA8aYqNxcSUljV4nlm4CjQS
	rq8CfPJwtBtdb27dKp9m9p1DzurXK4F1QPX3nXCxcGjRisjyMw2FSrM9hyJwZrAqA7S8Bdji4f2
	oPTPoNiDNLw73pvr4SvJ7mHGtn1FQC3Evje9BpSoilR6oUPV8zYgXSVoclszKvIGbxp5tNn/Bx3
	Lkl50dO5tRy3YTWNfddXIIsrKu+n5oQ3gwju/WxxoN8AcNB3aPC3iqG/Gnhbltr
X-Google-Smtp-Source: AGHT+IFLqhCJwi4LDt1CbGkrlXyQhmYF5Sg6Ua+a7EdvWtrjKr9Cd5rjPYV3dwtHFTEX9mO5lwhcDP1CzLN5owAnUbg=
X-Received: by 2002:a05:6e02:1a82:b0:42b:2f98:3fc2 with SMTP id
 e9e14a558f8ab-42b2f9843d3mr126138655ab.17.1759238475804; Tue, 30 Sep 2025
 06:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927-printk_legacy_thread_console_lock-v2-0-cff9f063071a@thegoodpenguin.co.uk>
 <20250927-printk_legacy_thread_console_lock-v2-1-cff9f063071a@thegoodpenguin.co.uk>
 <84qzvoje32.fsf@jogness.linutronix.de>
In-Reply-To: <84qzvoje32.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 14:21:05 +0100
X-Gm-Features: AS18NWDGBy1rHVVZg09_gmncr2DTh5wAi0bXpf_kPCM6Qsth4fiEVjFJyapVIVw
Message-ID: <CALqELGwttee-TmN6=0YGD2kKpzAQOuw_niDRQHVPRD02b-25ig@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] printk: Introduce console_flush_one_record
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Sept 2025 at 13:54, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2025-09-27, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 0efbcdda9aaba9d8d877df5e4f1db002d3a596bc..060d4919de320fe21fd7aca73ba497e27c4ff334 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3161,6 +3161,100 @@ static inline void printk_kthreads_check_locked(void) { }
> >
> >  #endif /* CONFIG_PRINTK */
> >
> > +
> > +/*
> > + * Print out one record for each console.
> > + *
> > + * @do_cond_resched is set by the caller. It can be true only in schedulable
> > + * context.
> > + *
> > + * @next_seq is set to the sequence number after the last available record.
> > + * The value is valid only when this function returns true.
> > + *
> > + * @handover will be set to true if a printk waiter has taken over the
> > + * console_lock, in which case the caller is no longer holding the
> > + * console_lock. Otherwise it is set to false.
> > + *
> > + * @any_usable will be set to true if there are any usable consoles.
> > + *
> > + * Returns true when there was at least one usable console and a record was
> > + * flushed. A returned false indicates there were no records to flush for any
> > + * of the consoles. It may also indicate that there were no usable consoles,
> > + * the context has been lost or there is a panic suitation. Regardless the
> > + * reason, the caller should assume it is not useful to immediately try again.
> > + *
> > + * Requires the console_lock.
> > + */
> > +static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> > +                                  bool *any_usable)
> > +{
> > +     struct console_flush_type ft;
> > +     struct console *con;
> > +     bool any_progress;
> > +     int cookie;
> > +
> > +     any_progress = false;
>
> I would let this be a definition initializer. And then place it sorted
> by length:
>
>         struct console_flush_type ft;
>         bool any_progress = false;
>         struct console *con;
>         int cookie;
>
> John

Sure, I'll update it on the next iteration.

Thanks,

Andrew Murray

