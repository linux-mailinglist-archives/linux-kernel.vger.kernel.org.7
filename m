Return-Path: <linux-kernel+bounces-834961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD0BA5EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AE63BC792
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EF2DF706;
	Sat, 27 Sep 2025 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="fvlB+O20"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10962DF6E6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975067; cv=none; b=rVKNNA+URLEx09VA9xev35OHyZf5T6teOYAOZWbDrOLpaZPFoOleM1a3dU45mjpl8VaLc4F3dkls1va76mp9JDf/qQSrT3lBEG9D8uwy9Y34ETyOy4eeHUVlyM6FFx4jMv9g86T6TVquvR8DR8U8VJIGusP9XfbWrGVpQmY7wR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975067; c=relaxed/simple;
	bh=AmBkc3UhQ306d2EmHzcMKpQ/W7QMFuShZ/GKBPvKxN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpPnJf2S8bNsz+muoBg6moBFvSVGTU9kVNi5s7yyRKpISMbmUsGgDGI/2ql+JTKapopYlFuLvGJeVIbgQNP1gMNBs3yY2pjOQrbldaenZ1VLRNI6JHEwBB0bvN23QMEPmDATzbPDiDswzyX7Iem1LZq6CyH5rDsb6VKEg77ZQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=fvlB+O20; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42861442ec5so7586515ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1758975064; x=1759579864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LMcHh9fHWWYPwR3yo6MrWo6NftTMixymngCFDEN2Yo=;
        b=fvlB+O20g017MBY5TtKDYTWhro9d5PVFU1Nncq2vKxdhVzIHQDYUyHSxGjGAOy2G/Z
         IAo8UB0fCCSLVPC7h+VzZBYEAIDBKX2qVpkxqn2WoZ9RItDhukuccSxgGdMBU3OlY8BF
         c94bjo9ojSnRgfw+IxkkI3DxKe+EzNEqTldNtsTHhO3WmAoTjdpJcXoUm71HA7XCOJBi
         IUct5uTWJgPkRjm6T18/oWTpewhY9Kouahp42AtyV7R2aQXX6mbOKunW3A0uiF8fIleE
         Qz8j+RIoZAqRrO+CnVkWYwb/4Pr/rgPRgbpy2hc2TpySmjLnuaBdiQ4jbLIERWBzjBdG
         IRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975064; x=1759579864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LMcHh9fHWWYPwR3yo6MrWo6NftTMixymngCFDEN2Yo=;
        b=JJvOQWfG/s3yruAVA68qwtipgiIIIhZPJVM/wdeqqa10zRNSjTYM2haNbj7E4SQg1R
         ihn9yghAFG0lR5EsXhbGw0B/lnD5U941h8GK6NaLtPriutjO4lav+MF6kj82MgDJFJq6
         /6r3IMunVw5iZSnqw4KG+2YiVwBgfp+nKTCR3ysqo3WT5lMWYp0y7ReOX+mKkN/2oFKc
         p3r+w+145rmoP9foU30hh9mnNQqv5pyoHVv49aJxtlgoNG7MK7gmqWLz/qFMSPQjFMBr
         BY4q1jp6BA7YbcLhW3YD0sfcV7v4y6fnBFEr9MGM8OPFRilEZuKDq6uO5AiwzN/DNXFA
         M2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1KcfCTPKWK3kvh7PLAD0vt+/iyLJMKUo9/gSWZEBc5Pqcf28vUyfIBesT/E5uAJ/ZpfnWG/w31DHSax8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqlRD6XQEfOMpus2bZS5Dfqgsc3ag5egvN2Nw0C1KMST/XWXyv
	eIKLtIngQwdup2mAONqJsJ9snxDw/66qW7afK8MHjrQTjcNdNClUXi3R03GI/4Cc0qEqogWXNOv
	4ce87VQYFCYuOhJIyZ7P8uxpHyfFdNzkl8tsTVW+hIQ==
X-Gm-Gg: ASbGnctmWCp29l28OkaWt8TV5zlDAnXm3QiAtS4/T958pyhtrU3Ycmj0NCMUeKza2Vp
	rHgrp8OkNdTBF9QIHotfE803qrWh7pYrf6MUeKY4JCl5NyKPPXXtrtFd7rtyy5+SN2OQOgyK3JL
	oDUu2x0MM4Ta/3w5kXpVuzJfApHIkEU0RLm1Z+oeyVIuI9s14uNiN6yE3Qvt/7lUqC4WE9tUO82
	wjsRSguJdj6XP6RSPw/fRq9N1jO6jr8I/mEl3uXcfxCpq68Gcg=
X-Google-Smtp-Source: AGHT+IEB9Bcl9EXTyiVt+OXSI2WyMrjtJ5h1N08aPYMLGZaKrFFQ3zu9sTIGCjqdgWLVFwnbg63fUKWZJ2Tgqbwi5rU=
X-Received: by 2002:a92:c532:0:b0:424:771:418e with SMTP id
 e9e14a558f8ab-4259566e677mr142541105ab.30.1758975063920; Sat, 27 Sep 2025
 05:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk>
 <20250915-printk_legacy_thread_console_lock-v1-2-f34d42a9bcb3@thegoodpenguin.co.uk>
 <aMwy7pFM7EExLxaX@pathway.suse.cz> <CALqELGz4ug+YyBvdmPp5aHR3x4qUEp4u4cCpWLL5143VCrf3-w@mail.gmail.com>
 <845xdak47j.fsf@jogness.linutronix.de> <aNKtNP-B3a0UAjHl@pathway.suse.cz>
In-Reply-To: <aNKtNP-B3a0UAjHl@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Sat, 27 Sep 2025 13:10:53 +0100
X-Gm-Features: AS18NWDYf3F3LvwtjoNimZTTbh-t06rOsvxSqMf5GpErHPM5sZ0dL_WJcEhUrKQ
Message-ID: <CALqELGyr-wPSnWGGmHnkM3SM2h-OPYu_zfT8KZV7Jd4Cj-i-vQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] printk: Use console_flush_one_record for legacy
 printer kthread
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 15:22, Petr Mladek <pmladek@suse.com> wrote:
>
> On Mon 2025-09-22 15:33:12, John Ogness wrote:
> > On 2025-09-19, Andrew Murray <amurray@thegoodpenguin.co.uk> wrote:
> > >> I played with the code and came up with:
> > >>
> > >> static int legacy_kthread_func(void *unused)
> > >> {
> > >>         bool any_progress;
> > >>
> > >> wait_for_event:
> > >>         wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
> > >>
> > >>         do {
> > >>                 bool any_usable;
> > >>                 bool handover;
> > >>                 u64 next_seq;
> > >>
> > >>                 if (kthread_should_stop())
> > >>                         return 0;
> > >
> > > This changes the behaviour from the existing legacy_kthread_func. Thus
> > > allowing the thread to exit mid way through printing remaining
> > > records, whereas previously the whole set of unprinted records would
> > > first be printed. But that's probably a good thing.
>
> Good catch! I admit that I just copied this from nbcon_kthread_func()
> and it looked reasonable.
>
> > It does not matter. kthread_should_stop() will only return true from
> > printk_kthreads_check_locked() when @have_legacy_console and
> > @have_boot_console are both false. That means that whatever legacy or
> > boot consoles there were, they are now unregistered, and were already
> > flushed from within their unregister_console_locked().
>
> Yup. I would keep it in the do/while loop to keep it consistent with
> the nbcon kthread.

Thanks for the feedback, the only change I've made in my v2 from
Petr's code is to set handover to false in the loop. Otherwise if
there are no usable consoles, the then uninitialised variable may lead
to incorrectly calling or not calling __console_unlock.

Thanks,

Andrew Murray

