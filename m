Return-Path: <linux-kernel+bounces-883681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D54C2E0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B06A4E2169
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3732C0281;
	Mon,  3 Nov 2025 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="frnItTGW"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29963238D42
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202872; cv=none; b=KeZ5/5JsfFuiL+xrKIwNaVVIazSk7DCYr81gAL2qFxuVIFXukIGKMOw53ghrNiqtAGezxMhNvCMerBxNsB+WJKAMN79Q60DY4Alik4a6PnxQvA6Hr+W75uDx85yD5yeukM5rI6Uae3mTD3lvjma8QLsj8lv9Obp6wD15RvdNUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202872; c=relaxed/simple;
	bh=a+vN09clVIm5tcOtX8Gar8O7sWSsGJBH8NFznjlbuLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoVffGbTcGwIKugWdXZ0Zqh41xFchpA06SxKrzvk+7uKoFuXTD7SjqTaSRf8r9sX9rguaGBfYU1DQfXd6zzMzg3KpjLCg3dDMx4dfwq0q8gw8L29lCMLObsib6RCRAeNULL9RCLEOekg8AD7nwpY4Wc0EoYnUifJNIos9K7hi8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=frnItTGW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so101826b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762202870; x=1762807670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+i+icE8IiyClGUVbQkBzxyTYknJ8/f/9xuIDF0CulI=;
        b=frnItTGWBoCkkJM13i5I2O93bpMuEk2yfFL/hhn2wgUCDdit3uF+Ya+mwLvf1cptKA
         NdLfPXPxU7+xOyQfNOHNBRO2O88vnkM8wg0D+bEOWObAietBKXQ/YpWgS6PRj9XakEXF
         0uU5t9fktMIuIvPfoDfJ8tvHAr7MtqipnpmghWD5LSoyiPn3tjoOSmkBvUS7uxQF6j+p
         MtwETHdsG2SGDS+uHqej3Yp1O6hYpJSj+Q/Itfx3mpXcbQ0M+WRNzAXmuf16fzVX1VeR
         v3DApY9vOAfqcebzpmOKls2k+T2OD2YONoO55vMBU096S3BF04Fx3W79qiRC/kUTl06V
         fQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762202870; x=1762807670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+i+icE8IiyClGUVbQkBzxyTYknJ8/f/9xuIDF0CulI=;
        b=WtnO8Yb8WAOj+n5XYa3JHy8RaqSzqV1gd6103GFfD0dPK4dQaZFehiIa0pSmgwkFFv
         w+CtrIt19kkO8ItRzjJ9af1nB5ASdCQJm2QK2Ju6K4+eS9YF+K42FUlZKErq227G8j7O
         glvGfhq4GOpFb0i1oip20C3Sm65I5K1Xn3upVE0IYJH/V64A8K1bUbheEGsZdjQblTEB
         5HdOZVqas+xUsckS6ux6StHy+1WH5Ix/eJGC+oPOTEIAYUK8LjcMtVq729/hJVfuWqzc
         6ERaoUDli+WmHQsog4uY12KxKQ20bBqsFKfN55vPCLUBHYZRgoClIXduULNWm5L/RJQP
         Um+w==
X-Forwarded-Encrypted: i=1; AJvYcCXWqW8tbrNLdnT7ovzXFc+745PAiK3F2wCmzfupRvUR4gQ7xD2544e9xtYBjt8mUkrPCjdA2lerJc5M6TM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2pGpe2HBIdE2zITRYAiKtU4l3f63pd2iJa++QCPfdg2qDbmEF
	WJyC31eNR7PuMuOTPrVXQhKKBfVSfovPJte+Cg12ZHHiiHGqxrlPVWEuYk8t+D7Ck2FK0tORUcG
	G6wik/c8QU4g/LRQCEoghVgTPsTNLBSLO4PcUKvp9/g==
X-Gm-Gg: ASbGnctYZ3PWJHgDjV4EQWJ/q+TGSScs2laWQEbRIDsWQUU7ojLk+vB2x/6Wgh6HHHv
	lMxC+9RSXVWtjhk7pAfu70FbJcbvWxmkULk56+QaMohC21XgZe/unvBOobxVhROanWJ+Z0Z4Wnk
	wXBCfBwCZZgjuUR5/omzDAPpyZn7rTNiYu0opc8FAYxEAlQrq3n2SOy0ZsOzCjDiY4zKFojiGub
	H5XFC3Pxf48Wh9rS223w0ePSZHA9lgy+1G6JQEDdQPue2hX5V3FkUx4YxjyUwM5YllURoCmGYQ9
	d/4GfLm5As7yypK7778fLvD31KCQ
X-Google-Smtp-Source: AGHT+IH9W5Yz0Du9VH7KHBKlBV6mxFdT8/2W8B6DMI8gR86YbjrXYjVZeItEyfgxJbcb8qFJyg3Aepo7OAlVmh7HvH8=
X-Received: by 2002:a17:902:f684:b0:294:ec58:1d23 with SMTP id
 d9443c01a7336-2951a3a3eecmr89081495ad.3.1762202870213; Mon, 03 Nov 2025
 12:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904170902.2624135-1-csander@purestorage.com>
 <175742490970.76494.10067269818248850302.b4-ty@kernel.dk> <fe312d71-c546-4250-a730-79c23a92e028@gmail.com>
 <5d41be18-d8a4-4060-aa04-8b9d03731586@kernel.dk>
In-Reply-To: <5d41be18-d8a4-4060-aa04-8b9d03731586@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 3 Nov 2025 12:47:38 -0800
X-Gm-Features: AWmQ_bmchfvPvbc6j7bPb8NZmMiCt-7TsMmgFjMHSv2mTVxvDRP5RDGTV2htgSY
Message-ID: <CADUfDZqHbfAQXG8j2W_GZrxFbYSQQeo9sYdzMEYLQTsuCR+4=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:36=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/10/25 5:57 AM, Pavel Begunkov wrote:
> > On 9/9/25 14:35, Jens Axboe wrote:
> >>
> >> On Thu, 04 Sep 2025 11:08:57 -0600, Caleb Sander Mateos wrote:
> >>> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creatin=
g
> >>> an io_uring doesn't actually enable any additional optimizations (asi=
de
> >>> from being a requirement for IORING_SETUP_DEFER_TASKRUN). This series
> >>> leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only one task
> >>> submits SQEs to skip taking the uring_lock mutex in the submission an=
d
> >>> task work paths.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [1/5] io_uring: don't include filetable.h in io_uring.h
> >>        commit: 5d4c52bfa8cdc1dc1ff701246e662be3f43a3fe1
> >> [2/5] io_uring/rsrc: respect submitter_task in io_register_clone_buffe=
rs()
> >>        commit: 2f076a453f75de691a081c89bce31b530153d53b
> >> [3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for IORING_SETUP_SQPO=
LL
> >>        commit: 6f5a203998fcf43df1d43f60657d264d1918cdcd
> >> [4/5] io_uring: factor out uring_lock helpers
> >>        commit: 7940a4f3394a6af801af3f2bcd1d491a71a7631d
> >> [5/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
> >>        commit: 4cc292a0faf1f0755935aebc9b288ce578d0ced2
> >
> > FWIW, from a glance that should be quite broken, there is a bunch of
> > bits protected from parallel use by the lock. I described this
> > optimisation few years back around when first introduced SINGLE_ISSUER
> > and the DEFER_TASKRUN locking model, but to this day think it's not
> > worth it as it'll be a major pain for any future changes. It would've
> > been more feasible if links wasn't a thing. Though, none of it is
> > my problem anymore, and I'm not insisting.
>
> Hmm yes, was actually pondering this last night as well and was going
> to take a closer look today as I have a flight coming up. I'll leave
> them in there for now just to see if syzbot finds anything, and take
> that closer look and see if it's salvageable for now or if we just need
> a new revised take on this.

Is the concern the various IO_URING_F_UNLOCKED contexts (e.g. io_uring
worker threads) relying on uring_lock to synchronize access to the
io_ring_ctx with submitter_task? I think it would be possible to
provide mutual exclusion in those contexts using a task work item to
suspend submitter_task. When submitter_task picks up the task work, it
can unblock the thread running in IO_URING_F_UNLOCKED context, which
can then take the uring_lock as usual. Once it releases the
uring_lock, it can unblock submitter_task.
This approach could certainly add latency to taking uring_lock in
IO_URING_F_UNLOCKED contexts, though I don't expect that is very
common in applications using io_uring. We could certainly add a new
setup flag to avoid changing the behavior for existing
IORING_SETUP_SINGLE_ISSUER users. What are your thoughts on this
approach?

Thanks,
Caleb

