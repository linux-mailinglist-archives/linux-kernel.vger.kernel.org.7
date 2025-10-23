Return-Path: <linux-kernel+bounces-867278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64FC02173
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6305011F3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2018D336EF3;
	Thu, 23 Oct 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="AsXL/M0u"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9024333452
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232928; cv=none; b=X0+toGHRxCLmTc86mAF8VaCqd6DjlupQ+VNOO9YvClHCz8LchYOet4AkaApCKcdYT1xQEEj+H5QOIgZUQi+78btRTPiUUszCX1WoSwQAQHpD38TxnS7vbwHvrfypsq0oxIpoLKvp9j9lx3mcMzToHwe13q0P9e7X4gi/igx3HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232928; c=relaxed/simple;
	bh=ymtMjlagri0PWVaI7AGIGXeR+nrfbhsCLAyv9ishtgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFyATUNQc57TXvWXC2RR4snHK/QtY9BKq/qXQMkeZoimkrQMcmXwwoFwjdQe7CmZ/RvKQ33ym4CDD90D544551DQqf2iKI/4BMZyHI7PTWBqj4yiXKwsWkQadtPGhXRZFTxHWvBynItywENb7JXWWa6k2SI+Ikv4JYEXeRN1NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=AsXL/M0u; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-431da4fa224so10108005ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1761232926; x=1761837726; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHF65Fv8axMytx0LweuTSMSStHIAsHWoAQGHq/2CfNU=;
        b=AsXL/M0u8JBrkar3fpsx5KpbeIQ4RRad2hlz5DSUjFOkudWVozzfLV+/xeE+D+F4+/
         YXRNglcDF4X7kDA0dh8rrClbBAalhbsXADMGxoDQiljDJ/4pWXlMKmkdSfb0aiqZidRS
         DxaMmIlDn230FNBlZSAfAquvhDZP58CExAWFn95nSXiQeX99REVm0O6RMFda0YtyI+94
         u47LYfTCNUg0OxwcMDgXTAR468ohq/GW1PfjzNad/OPH+4uXrZRz6GfMhsl00Y3/has+
         NYhj9V5nXeArJs2vuvL5rVnD7EOUpwL77pgwJYLdN9T+6nFIMaWP2ZJN+vBdeaCR/24N
         tATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232926; x=1761837726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHF65Fv8axMytx0LweuTSMSStHIAsHWoAQGHq/2CfNU=;
        b=lBLpWado5G6quEtHg9wA/81lQxYG2qxTUCTXmlppBKs8FblPLg/RLi2wdUoJ1ULIK5
         9+vphXDQIj9WmSrcAqo2poJCinXAuAfNDqklFfZh0HEoToAenbjrTZXpKA0cgJQ1mm3c
         nELK1JM1H6AGhb94EnMcJC/s3ZsN+qfU9Cta2EXJc12z90J7l0UbLRwnjTnRNZQB9JK1
         tQTeYMIcWLmPy9ocJb21XIxO6/wFZ6WWSHNWhUMo40f2bnmm/pPvzapJXQG7c4ZwFq75
         OYMGvQlvSIvAs9M5ohA5MF/sn0PrkDUMP3Smy/C5YLftLcb/WhAhVIzCrSGLXqUX46pu
         leyg==
X-Forwarded-Encrypted: i=1; AJvYcCXU7qCMMfJ4Q4PPxAoBhVZMl0WfI6QEMv8rsffXsOC3vv2YVJ/L43FhZIximKxRakhoLbE8Ka/Mzjsnygc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvs4OfduTRmovFsxXrtF/x58vPPllG15LhFr/UnLgkEto8Y4A
	Ac8RfYPXIvvxJmJNhzXUSnMg8SG6O5TsTvX727n9d+6wNda/2BVpEQAIheon04ptX+QMoF1hZN8
	2DBYZyEOFKrsLqN3kLyJy4AecSM7xkAuWDz8VinJ8ew==
X-Gm-Gg: ASbGnctnzWSuQxduiHHseRp7Qd0tj+7mBQeJ/fqckbkMVWYJT8BGygMOUAkfIMmgIbU
	0BNGLg4BWo/7fA34Kb5Q/QqZJ5zM1jwW86H8bgLOtO29JvZEENhFC5yzsYkMe9UusO8lGbc39VN
	GBGt9J7+8U9KV0BEuHb6sDg8Ct6JVzC/D7uQoH6wRbddNroThxcUV4myQB5PL62c1n7xs2PLhdy
	hGNPnrg+1JuqSNIC7lLChPJUi8Ah7xJY71cy3F8PYCtaeV7gLmZZriKkQ==
X-Google-Smtp-Source: AGHT+IGYUTuNUmnpHV0ndfCt1MSS/3i732j0zswLjrh6RhWPTKjfVgZfhhjhg8/nps9HqCMYimoPfXbY/plwHV1Xe6I=
X-Received: by 2002:a05:6e02:152d:b0:430:ab80:66f9 with SMTP id
 e9e14a558f8ab-430c52081femr363194155ab.1.1761232925788; Thu, 23 Oct 2025
 08:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-printk_legacy_thread_console_lock-v3-0-00f1f0ac055a@thegoodpenguin.co.uk>
 <20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk>
 <87zf9hbvrt.fsf@jogness.linutronix.de> <aPpCCCIg0NafmwHY@pathway.suse.cz>
In-Reply-To: <aPpCCCIg0NafmwHY@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 23 Oct 2025 16:21:53 +0100
X-Gm-Features: AWmQ_bmzg6BSYeef7EbRBvyanMnSndZRXBl4kU8F06PJSuRRQtVhy5ATwVK77IE
Message-ID: <CALqELGyLNdqzoz4xYnUE9XYb3bGY4iSejBotM=imMbx9LbLg_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] printk: Use console_flush_one_record for legacy
 printer kthread
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:56, Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2025-10-23 15:25:34, John Ogness wrote:
> > On 2025-10-20, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index 6c846d2d37d9d20bad58c6e3a7caada3be9552ca..2665a7a59f03b3a357b3346de1735606e77c3496 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3644,17 +3644,26 @@ static bool legacy_kthread_should_wakeup(void)
> > >
> > >  static int legacy_kthread_func(void *unused)
> > >  {
> > > -   for (;;) {
> > > -           wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > > +   bool try_again;
> > > +
> > > +wait_for_event:
> > > +   wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > > +
> > > +   do {
> > > +           u64 next_seq = 0;
> > > +           bool handover = false;
> >
> > Nit: I prefer to sort by line length:
> >
> >               bool handover = false;
> >               u64 next_seq = 0;
>
> OK, no need to resend the patch. I'll change this when pushing it.

Sounds good to me.

Andrew Murray

>
> > With change:
> >
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
>
> The patch looks good to me as well:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr

