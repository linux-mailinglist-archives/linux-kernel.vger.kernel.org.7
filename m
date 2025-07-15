Return-Path: <linux-kernel+bounces-732286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E71B06489
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DB47B3D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4D27A904;
	Tue, 15 Jul 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PxCgmUeS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310A277C96
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597795; cv=none; b=J1PUvq2i5lgHX46xWNHsWBOe8Hv0Mee0T9mRSsfiisXKhF+MogyN63JxIzZYL786k5plHK6i4v5CqfYsZxaFQI5Tu+umAzRuPrmE8D0Qt0jVJU65nn8U2j0oGLpqAJ2SUkOisOmOZq5yZg3OopKPzb2q0sATOwO7dBCM7SfsG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597795; c=relaxed/simple;
	bh=OZLBdP80AuAPBpQatgV4tnOFj5nsWaDVvWpCLDIyI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+vtfnmJx0ESke0CYILHZRGDFaiJVXPjLZMo3xWREljNxRa4V6ElWzy4ZTNeq3xdI5iA/x8ueLOHV+gT5AUUw9KPG6jDidDVTMrU0ys2RtMtguntVp3+EfxCRuuzsPgXVgbnDWW98QFhRYVUEs3+taGjjgHMqTqsa1ezrryPhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PxCgmUeS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso1185444966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752597791; x=1753202591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=PxCgmUeSQ/y2sJIlshryS4wP2WYpULbKVIppsJk9dSMB4fxUY4Ao//jlVEr50ePBw4
         Tu1VFJZgjwczUxMpIQJVo8B2GeHnJnBsfIqXTBiFfNgbibO2qthZAERx0PFGUQQiyC7s
         IbMilObDU4gUcVGPF8DC/nCwY8K85XJy+Qveg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597791; x=1753202591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=r10+Vhkq6fjXiU1pxDynKBAM6KbYQeJjRXAGxyO/OkejYCXZMp6JaJVw3nnZine36F
         Pfzf+f97tGODdogWL/OpBJd6qYFc1dtNHa2RYgGQ4VpDULMigSNcXrzg+UBj1ocxC1bU
         FseFltBabx/QyrRSoU7/QCJtUc8OR2OtogpkGX6pJkSEC8tIJ/XtN6/EIPpse3UuSNdL
         rL/mva+jOczE+XVCRBzzg9MDqkCMdGdoZd8Db7K3j78A+oH7KUNSJZaflt1iZnDrhXfm
         8AyJaKXaM30Gbs4MSxM2nZB8u/2rowTVnEkB3qOUyWjqvjScbgFmUTFEuopZVK8IaGaU
         TBrw==
X-Forwarded-Encrypted: i=1; AJvYcCWQqo1gm5vHMC1MJjYPmZAKUsby3EJnrMGrgs1SsN+B/H6hU6/CkF+cIcKn3XsKmpS+OJetsLeOdLvXANM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjML7gsNqIIpPZiZrLJU8RcVDQqjM2ccMLXtSqlHhKdsVeWXKb
	/Bq3/6C1CnlKv2WHAcBve5SjMFChrcsvtPHfGJjlMi0drAmNndWxpv8aoMN9Lgzegnophec+X2L
	GP3vn/8g=
X-Gm-Gg: ASbGncvN+gJgbfT8qQbPUZ7sJza/JxLvW3LUXHB1bFzgrlUsgnAD6d+5Tu/tXVPMF9b
	e5qNvB+wR2ULRHqV/Z2TtUIs57UiZUQ1JByI/5diFTV4z+LNUb/Def27Cnc44cB6wnWdO2FAbTW
	M7j3kdlDSuhnlcwnD38vWrBTJm7hZUGamaSsPI1P96/FAlYLAxIoB6sYSG/YJIZNRU7W7daNh2E
	zVZUUUZBl0mZa2gDYGEHA6tFfnSS3pIe1SImmtpJ148Djn/RqpbRpSWEZYtz77o/2/WtUnQ7pDD
	T0CBQ1RtOHcde1XHjXYKS5SqkHVphYX7nzqYhraHMtAFKlHlcJHD3zj77RiwqUkNinJraE7twrF
	EMlTsDsRGbtcrSkAdiTKtBxAqJcVZDzekdo4m9tsenfxDgLJoeKvoj4eT9t3hxyC/9UdC/NWf
X-Google-Smtp-Source: AGHT+IFQTdyFjAuD2CsbrJmq0cOUV2PAhNkGs+5nFrQf7bTULic7bh7soMaaQddUmWfPBZydSbDnlA==
X-Received: by 2002:a17:907:1b15:b0:ade:422d:3168 with SMTP id a640c23a62f3a-ae9c9b112a6mr16385466b.37.1752597791530;
        Tue, 15 Jul 2025 09:43:11 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bfdsm1010585366b.120.2025.07.15.09.43.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11728118a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvSo7ihUQPthNZaW2euHyCoETtb6eWT5CvNcxDHzhQdmTKz2ILc+ofHEYhwhgaB1S+PrqmDThK/H0SeGY=@vger.kernel.org
X-Received: by 2002:a05:6402:2686:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-61281f226d2mr26921a12.3.1752597788853; Tue, 15 Jul 2025
 09:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752581388.git.namcao@linutronix.de> <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Jul 2025 09:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
X-Gm-Features: Ac12FXwEFq81tRpxQQo-YtMJ6UxIp_wzb2appHmE6OGEEPULt8cuT-X-Zaqr3nQ
Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
>
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)

Yeah, this is more like the kind of diffstat I like to see for
eventpoll. Plus it makes things fundamentally simpler.

It might be worth looking at ep_poll_callback() - the only case that
had read_lock_irqsave() - and seeing if perhaps some of the tests
inside the lock might be done optimistically, or delayed to after the
lock.

For example, the whole wakeup sequence looks like it should be done
*after* the ep->lock has been released, because it uses its own lock
(ie the

                if (sync)
                        wake_up_sync(&ep->wq);
                else
                        wake_up(&ep->wq);

thing uses the wq lock, and there is nothing that ep->lock protects
there as far as I can tell.

So I think this has some potential for _simple_ optimizations, but I'm
not sure how worth it it is.

Thanks,
          Linus

