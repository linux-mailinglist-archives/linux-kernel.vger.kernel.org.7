Return-Path: <linux-kernel+bounces-867274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5FC02158
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842975020D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E31474CC;
	Thu, 23 Oct 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="IoeEQV1t"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5683321CC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232885; cv=none; b=GtF1EhF/J1Cje5pkJ+g5Fsp5bCf/yxMRtwb1YeAFrW3QxP+fO2H6W7Jm1neJVneT8mnxm9etpc4cAx/s1xPBqasAtG7DR12S+tCtrNRacl9Q2beNmWASMEkMKf685dsLb4u6NviHoSQg9qnfK6evNsIKyHGXfGyLp8h8LCvgsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232885; c=relaxed/simple;
	bh=CGISLCO6vtKrWLEE0J1rr2/FzdKkOGoQWqx53TjAihk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaSsz4ed+5kHdR9yhU+Zl13CdoJM0zSkwU/ePhC0Z3WyclqaF/Z0eePf+szlDtQkmHutrsm9OTqSFvidnaO1wXuGD/rWzAJ2T4Qj94kGQkj4FFzQgO4MfvnLdeb0T53iF7/H5lA1WDEmKeAHSFLQ0EdlmWRFbdEJvSqD9z5qZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=IoeEQV1t; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-940d27610b8so33713639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1761232882; x=1761837682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eTi1JnqCKHk9CMi6oZs8NpNwJOlI22nEpI+ixQdEx4E=;
        b=IoeEQV1tecaH4z8hrPBkGLlPNb+XtC0iNWilokub6Hso3qz3jyoGzUiF9wqIwnHnvz
         VrmmD/kQY5Q0omCIkm2dEWKaDFccxP8EOyUWwjzKBjGBTGqNxFPt6Q/flRUWWmEzkzgO
         aUj1yosxHFRmx8WdKwrvbtYctkL1v+XyDoLb/glwb86HiE/n1RNmQWJ7Jetf/jR15ElR
         bke0H1lYTdNoUfeBkpEqR2ntj5K09Prpk74sN6L1Hp30Hw8g3wbASY/nSKxtUCe2fSr2
         59Nr8jKPfyo65zZQlRQxyIdlWXmk6eExk+45Xf+t4Rdg2E4tZP+uujZACpB64I9Sm6eX
         vW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232882; x=1761837682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTi1JnqCKHk9CMi6oZs8NpNwJOlI22nEpI+ixQdEx4E=;
        b=mVHnPXnMqEmA4vZp1vVlM5ltukXVO4m2Sgj0WR/d2xl5cqGwaxD3IBoxnE2tcBz3LT
         YOCQBHTxMjRHw13OcRroqhASWcwGf0bnqHoQF5mqCICVKsB2FvDs/VYHHGbZe+oIGTvu
         QJggY1NsOHc9xETKvbvXOXDbt7J1Eo1usEx3kD10VxLxL7psDNM1I5/uFOb+A2z8CgGE
         qkUyb8gBMTUS8JBRiEDxxbJoOsooF+egUAlOFNkabE66AArMAPrZV5XnO63gSuYfun0E
         G/IHrshlW0zYsX81VbWYrrrZrTl0Qz9GrlSrxqk9OUmLwEzX8KGvl3Xs9p6YmVhVz8xI
         AM/w==
X-Forwarded-Encrypted: i=1; AJvYcCXR6uEgnFH8y7KD4mPTPoEKG7ZoS8QgSb6RcJI0lDfcXKp9FEAih98RLAePKCgXXG1YoCkwBjABvzaCvYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gS4y8FYzXRztaTGqDK/mxXzmZC+UbWl1ELgS4nfV5p0okoVo
	ADKMQJQYNdDjnOgcRhBM410ROHzmkC9UAID58eCtemkCnCG/eJF/ExJ6dtBA+O/fQSJ2RjCRVnf
	SvHpHZ2S47ROGcazbo0UNKErxOs5QPTg0gdi/dM82BA==
X-Gm-Gg: ASbGnctIIqR+7CEEF+coo1g0CFoPWihGCXiPGd2AYJw8R1dFPFDREhmJ+glD4Us6COY
	mwnsUzdm22CJqKj73UVedUejE5Ce7pEELk22rglGjndpkyYGDsXkoroMCWkTtvtyMJQpFoqPSM0
	JG7xZk5UN/f8WcpO5wO3o0e3ZEWYFyn5VLNKoZvVVOfvAnNInPtOLVNjlmSAcLtBQubXpJKxSIi
	yGu0GoL2d9+a2ZPJI1ehG0QRZuAV+gniJfizNTv74Hl586RosndqdBVUQ==
X-Google-Smtp-Source: AGHT+IEcTxhl1si9kJX0DM7rywKfW7m2SfbjsObGtiwxypKDvFzMXKuyZB3SDip0x3INk6dXj2IZwIAa7Xc+NtZO05U=
X-Received: by 2002:a05:6e02:16ce:b0:42f:9e92:a434 with SMTP id
 e9e14a558f8ab-430c52b5a2cmr294238555ab.21.1761232882405; Thu, 23 Oct 2025
 08:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk>
 <873479daeh.fsf@jogness.linutronix.de> <aPpBpzjm2TpnbiNs@pathway.suse.cz>
In-Reply-To: <aPpBpzjm2TpnbiNs@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 23 Oct 2025 16:21:11 +0100
X-Gm-Features: AWmQ_bkO5iqCfHeoevc0uL9QstFNAO4q1A9bGHqZLSvgrLITC7sFb5IzT9adu4I
Message-ID: <CALqELGypz6m5JM3ht5kzGCLA=dq7WRTBWw8yZfQxoydbccVWhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] printk: console_flush_one_record() code cleanup
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:54, Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2025-10-23 15:24:14, John Ogness wrote:
> > On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 1c048c66d09919967e57326e1732bd17c10f3c76..6c846d2d37d9d20bad58c6e3a7caada3be9552ca 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3142,31 +3142,33 @@ static inline void printk_kthreads_check_locked(void) { }
> > >   * context.
> > >   *
> > >   * @next_seq is set to the sequence number after the last available record.
> > > - * The value is valid only when there is at least one usable console and all
> > > - * usable consoles were flushed.
> > > + * The value is valid only when all usable consoles were flushed. It is
> > > + * when the function returns true (can do the job) and @try_again parameter
> > > + * is set to false, see below.
> > >   *
> > >   * @handover will be set to true if a printk waiter has taken over the
> > >   * console_lock, in which case the caller is no longer holding the
> > >   * console_lock. Otherwise it is set to false.
> > >   *
> > > - * @any_usable will be set to true if there are any usable consoles.
> > > + * @try_again will be set to true when it still makes sense to call this
> > > + * function again. The function could do the job, see the return value.
> > > + * And some consoles still make progress.
> > >   *
> > > - * Returns true when there was at least one usable console and a record was
> > > - * flushed. A returned false indicates there were no records to flush for any
> > > - * of the consoles. It may also indicate that there were no usable consoles,
> > > - * the context has been lost or there is a panic suitation. Regardless the
> > > - * reason, the caller should assume it is not useful to immediately try again.
> > > + * Returns true when the function could do the job. Some consoles are usable,
> > > + * and there was no takeover and no panic_on_other_cpu().
> > >   *
> > >   * Requires the console_lock.
> > >   */
> > >  static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *handover,
> > > -                                bool *any_usable)
> > > +                                bool *try_again)
> > >  {
> > >     struct console_flush_type ft;
> > > -   bool any_progress = false;
> > > +   int any_usable = false;
> >
> > Nit: This should be a bool.
>
> Great catch! No need to resend the patch. I could fix this when committing.
>
> > With the change:
> >
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
> Thanks for the review.

You can also add my reviewed-by with this change:

Reviewed-by: Andrew Murray <amurray@thegoodpenguin.co.uk>

Thanks,

Andrew Murray

>
> Best Regards,
> Petr

