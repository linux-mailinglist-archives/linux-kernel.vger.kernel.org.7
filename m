Return-Path: <linux-kernel+bounces-807240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB2B4A1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55B37A24A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9FC3019B3;
	Tue,  9 Sep 2025 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znGGJjSt"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA046257853
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398747; cv=none; b=fFW4q3GMuD8dbEvCYv7JfVyAlz9e0cSazs+kOdu8sV2T6QUFawJ+g+1EGOYHQY+8jLTH4AtPisWjwGzIt7op5X/ZG7N1MvR3ASe1LJ+ipDms7/1C8OZ3OwhMDHJ8+DiAy44mL2DvF0pxaBkqxLrUza/lZCwypcpVttoHsQfecBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398747; c=relaxed/simple;
	bh=L1VXCUHFXkUw4WZkL8qpqYcrzAFyAOw2NAFSE0iyzC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI3z5/LedNEaTwCX2DzM81CthC4he6MeEbG/3eZfNfEmHbRJpA+apx8Bdmn0WnDbNp+0HjcOUd+f8HGYcVfLexlQS9ti6pb8z9ZFcvHCw17LIlRoQSipFQGIEFEaJVph+ukhdBAyGiV391LCbBJxFLWdpzRwbztGucDKw1prMYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znGGJjSt; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-53042807be7so3977626137.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 23:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757398745; x=1758003545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jk+p+zHJ4oke51qSESVQoUfFkabu9tf2MtR0ttT0epY=;
        b=znGGJjStIbyu4g3gIg+UdnXdDE5akf3+AmbtNDGVZ305SG9rhIrPr4yX0hhw4BFXvk
         2cm8S88GyNtfOxBysBUj+EsKzaObFhdGt+TvWnDWRUJQGlvUOkDY7QixIvF2wzF+6eOM
         BY4jF4zt784fcBb37xGjM7+ovGL9W36SCSZb5LmpiNP0K2VFX+dnj9uku7JwrzJPRoom
         DBPJ/fk+7I0sII3rQunjawQwSJON/6SDOgmrz119v1VN0KIDhp7+N8KF4VcUKn/wCX/i
         fRavgYq6hbZQ8gTEa4jOTq4kVOFG8TWeNqVab/IgQYjHY4ZoFfJq0N6PFMqeaRsmFvUL
         lVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398745; x=1758003545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jk+p+zHJ4oke51qSESVQoUfFkabu9tf2MtR0ttT0epY=;
        b=EwLk+zd9XVlQbq4a7NTXpUzZAMAAHQt29Pk/eBAHiTagMiHZkacy6at7eZVmwqOvzs
         /UmO76aUTSw7uCo4EBhAmR/j8JI8OCRhBUJbVSVWb9YYCqUcfWrH7wX9x1PgNZ84rOkW
         SWxssyRIKhUYSciPKDcNp5GI4lCo1wkCqgVVrUIGL2sio9gIITG2dD8A1gXnfoiBpyDQ
         f9AUeiWst1A5bkunbKzF3BmkcSYasI0Zurmoqx+QP3dXPN6tGTErNCwGWzcJ29tputc8
         xul6HFRNhv3swpztjdChY7S+Np6ax7Pxol/didKa21IEqUFNPkJ2bryYWqYOp6giEHoc
         tRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8iqMH/DHpfn6L/QYWunVWWg3xsehXKhp7OTSJXguczwEaAfQPEa8E7dr1+xzgQUCtT+/CH1Xv/rSVXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBP9Iz3GOA5Tr+H0Z04QsQRbQwNnWfo3laaN2/P6PndBIMOSG
	W8nqzU2msGXt5Sb5GrCQtLXdJgRk92qeLEYI2Zet4qbPs+RpCGH7HWaaitMLu8C2ggqKdng8/aa
	p6yo32Co7Hg2wIAEptsYc1SXM6keKDdSy9KENATz6
X-Gm-Gg: ASbGncvWsvWbcFmdbqTjZKPgyxhAjX9EX/Oi2pS6XfbeEehTgtjAjlloitunjRpvdl9
	xpSgBl9Uf9nxm8Yu2hCIaWuN9khMuVOF3TWZTnvSqcykX27HNI5YvqR4bQpBFnu8Fzg1G5NTXPk
	fo+Dt/JCAzonXcnunDGGiihkcXsnxOj3VpESxqPiVAIl1oQrEBEtugEwkNyp+ynCTWhSIvvMMea
	fyylpltIPAH
X-Google-Smtp-Source: AGHT+IHQNH5bxNKrdTFAvr26RVQCsobnfCMGnFcjjLcgm0Ualx4aeMZlCbit4BGJSHXpfyWIckep63sdStx2kGUzgpc=
X-Received: by 2002:a05:6102:4a92:b0:522:826e:7bfe with SMTP id
 ada2fe7eead31-53d1afa279dmr3179250137.5.1757398744489; Mon, 08 Sep 2025
 23:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx_C_UcjjPOfUip=L28P3PWjMvmSc4nZJ5ML=tScUXfk2w@mail.gmail.com>
 <20250909024538.15946-1-tuhaowen@uniontech.com>
In-Reply-To: <20250909024538.15946-1-tuhaowen@uniontech.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Sep 2025 23:18:27 -0700
X-Gm-Features: AS18NWBpIhGUkBwXHz5Cxh0u45kdsxsLpNLylrw97iJA-XyLjU8bAzSiD3rZzTo
Message-ID: <CAGETcx-mA1kBw+r+tJOdpdqKHZQfNHvA-JS8wXc_ZHhj23WtMg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Add configurable sync timeout for suspend and hibernation
To: tuhaowen <tuhaowen@uniontech.com>
Cc: huangbibo@uniontech.com, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, rafael@kernel.org, 
	wusamuel@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 7:46=E2=80=AFPM tuhaowen <tuhaowen@uniontech.com> wr=
ote:
>
> Hi Saravana,
>
> Thank you for your detailed feedback and suggestions. I appreciate you
> taking the time to review my approach. Let me address your concerns and
> explain the real-world issues I'm trying to solve.
>
> > This doesn't really fix our issue where we want to abort suspend only
> > if we have to stay awake. If there's no need to abort the suspend (to
> > deal with some user/wake source request), then it's okay to take the
> > time to sync and then suspend. If you abort the suspend, it's just
> > going to get attempted again and in fact waste power.
>
> I understand your perspective, but I'm addressing a different class of
> problems. The key issue is user experience and system reliability when
> sync operations become indefinitely blocked.
>
> > I also don't understand how your patch fixes anything. If anything
> > this makes things worse because the user might have expected their
> > device to have hibernated only to come back hours later to see their
> > battery dead. And even if the user is actively monitoring it, you
> > still need to sync the file system fully before you eventually
> > suspend. So, this doesn't really save any time or the need to sync.
>
> This highlights exactly the problem I'm trying to solve. When a user
> initiates suspend/hibernation, the screen goes black immediately, giving
> the impression that the system has successfully entered sleep state.
> However, if ksys_sync() is blocked (which can happen in several scenarios
> I'll describe below), the system appears to be suspended but is actually
> still running at full power consumption in the background.
>
> The user has no way to know the system is stuck in sync - they see a
> black screen and assume suspension succeeded. This leads to exactly the
> scenario you mentioned: coming back hours later to find the battery dead,
> but with the added risk of data corruption since the sync never completed=
.
>
> > Can you explain the actual real world issue you are trying to fix? If
> > it's the UI hanging and not responding to keypress/mouse move, then to
> > me it looks like those should be marked as wake sources.
>
> Here are the specific real-world scenarios I've encountered:
>
> 1. **Device removal during file operations**: When copying large files
>    to USB drives and then initiating suspend, if the USB device is
>    removed during the sync process, some filesystems may not properly
>    handle the device disappearance. The sync can become indefinitely
>    blocked waiting for I/O operations on a device that no longer exists.
>
> 2. **Faulty storage devices**: Slow or failing storage devices can cause
>    sync operations to hang for extended periods, making the system appear
>    unresponsive.
>
> I've observed stack traces like this when the block device is removed dur=
ing sync:
>
> ```
> [<0>] __switch_to+0xd0/0x168
> [<0>] iterate_supers+0x88/0x118
> [<0>] ksys_sync+0x48/0xb8
> [<0>] ksys_sync_helper+0x18/0xa0
> [<0>] pm_suspend+0x260/0x3e8
> ```

This seems like a fundamental sync issue you are trying to paper
over/work around. I think the right fix should be in the ksys_sync()
code.

> In this case, ksys_sync() is permanently blocked and will never complete,
> even though the user believes the system has suspended.
>
> My timeout approach provides several benefits:
>
> 1. **User feedback**: If I set a 1-minute timeout and sync doesn't
>    complete, the system fails suspend gracefully and returns control to
>    the user. This gives them clear indication that something went wrong,
>    rather than leaving them with a black screen and unknown system state.
>
> 2. **Prevents false assumptions**: Users won't mistakenly believe their
>    system is suspended when it's actually consuming full power.
>
> 3. **Allows recovery**: Users can investigate the issue, safely eject
>    devices, or take other corrective actions.

If the user has closed the laptop, none of these will be noticed by
the user. And the laptop will still consume power since it's not
suspended and cause a dead battery hours later.

> > However, if you are really set on proving the need for a timeout and
> > implementing it, you can always add it as a separate patch after our
> > patch lands. You can set up a timer to call pm_system_wakeup(). Or
> > just grab a wake source after a time period.
>
> I appreciate this suggestion, and I'm certainly willing to coordinate our
> approaches. However, I believe the sync timeout addresses a fundamentally
> different problem than wakeup-event-based abortion.
>
> Regarding your concern about sync completion after timeout, I want to
> clarify that in my updated implementation, I've removed kthread_stop() to
> ensure the sync operation continues in the background even after timeout.

I don't think the kthread_stop() is even correct to do. You are just
randomly killing the sync thread where data structures and locks could
be left in a bad state.

> This means:
>
> 1. The suspend operation fails immediately with a timeout error, giving
>    the user feedback
> 2. The sync operation continues running in the background to completion
> 3. Data integrity is preserved while providing responsive user experience
>
> This approach ensures that we get both the user experience benefits
> (immediate feedback) and data safety (background sync completion).
>
> I believe both our approaches serve different but complementary purposes:
> - Your approach: Handle cases where wakeup events should abort sync
> - My approach: Handle cases where sync becomes pathologically slow or
>   blocked

I'm still not sold on the timeout being the right solution to your
issue, but I'm not going to block the feature.

> Would you be open to discussing how we might integrate both approaches?
> I'm happy to work on this as a follow-up patch series after your changes
> land, or we could explore a unified solution that handles both scenarios.

I think a follow up patch is the best approach. We'll give you the
APIs to abort as needed (timer in your case) and you can try to
convince the community that the timeout is needed.

>
> > In fact, thinking more about this, you are generally having a problem
> > with suspend taking too long to complete. Doesn't matter if it's due
> > to file system sync or anything else. In which case, you should just
> > use a timer to call pm_system_wakeup() and not fix just file system
> > sync (which happens to be the current long pole).
>
> This is an interesting perspective. However, I believe filesystem sync
> deserves special attention because:
>
> 1. It's currently the most common source of indefinite hangs during
>    suspend

This is not a reason for special casing for the file system.

> 2. The consequences of interrupted vs. timed-out sync are different
>    (data integrity)

Not really. You do realize that even in our patch we let the sync
continue in the background, right?

> 3. Sync has specific requirements for background completion that other
>    suspend operations may not have

Not sure what you mean.

> I'd be very interested in your thoughts on this approach and whether we
> can find a path forward that addresses both our use cases. I really
> appreciate your patience in this discussion and look forward to
> continuing our collaboration on this important issue.

I don't want to block your effort, but I also can't support it. So a
unified patch doesn't seem like the right way to go. As I mentioned
above, I'd recommend building on top of what we land.

> Thanks again for taking the time to review and provide such detailed
> feedback.

Same to you!

Thanks,
Saravana

