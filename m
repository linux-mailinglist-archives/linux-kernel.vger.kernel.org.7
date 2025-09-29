Return-Path: <linux-kernel+bounces-835739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545F6BA7F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5D81760A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0A218AAF;
	Mon, 29 Sep 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKKZ9zOp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0981F462C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759121677; cv=none; b=NKN7DtihgQ1e4UfWnkqao6Pnwi+w8kXm4T2eajiEHsuZju9WoNkChmYHDZr6UClmJe5hj6c3LSyIK7KBhEpgtUjs+NDVS85AhoJuTLVTn+wJMnZE/odwSydiPp67KI9ee6RM+1YwY3Et0QPYuFJJPSSe4yyfPgD3Lti3KASegAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759121677; c=relaxed/simple;
	bh=xSspKJ54Bxlkmwcu2AMNYc4Jg+Rq35XtdgNjnFRQ6AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsPyd/UbWj0XRMcQzSLteKpmQpMMce6XkoQKYOL8b+CfwPZQRgkS+jc+ewfyeSHg+bN9dB3MKxUjXicQjZi/EgaanYgdGDwYJ7Djdn7A1ooTEXbE34P6qJx/EWrajCo1qmH0UZUG9IiSyocU/+M3IbeS/NCxNDiRnGwl03xUJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKKZ9zOp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso948708b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759121675; x=1759726475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiGEc+bWHibq3FL8i9zZEO5Fku5US3xDhKukJhzni5k=;
        b=CKKZ9zOpfbtbyX542FTzltHwKsaKvVA0AN37NMIAhA6pyefMWyjwBqnvvhU9wwdGOj
         3UlgKoCxS89UNuas6dhdzkFnBEk6NrqIRMwMW4r9n655eHigJynTZFntSK/Wnye8wCsZ
         5Vh7jpPf9VlWRUZv8h9QA3WBY9RBE1s85MYXcenavtMVVIffZC9KbFnumVob2xztSNTC
         baqqLhMpoIUav/ax5h08o+gQtdendnNl742V19lc980b+YtLnmmbfhA59jasl7x8OeXL
         bWy89GLT5GTXQJynFiymlLuQ5zWgUxVDegtc6LPKco3M3W84QVMC1wSSdh2Fskb4xvNJ
         isUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759121675; x=1759726475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiGEc+bWHibq3FL8i9zZEO5Fku5US3xDhKukJhzni5k=;
        b=uFvKC6N49MxRYR8ctY2upGgz7MEfvytiwos268JeG3124dmf25C+R9Fd2MGBOJ2uY2
         L0DVazKDB+H1RpsOU1kFAIW0gP3/rVc9DrQiti2wFWpkmkwAEwYeoJV8QplyRwJHLecH
         aYm4fC2S44S6JHq2m0I6YJsc2xBZIdKs9XbC6zq6a/jUMzNkHxQLnwWthV1j3FF7Jzyf
         Rm4pAnqX20wWuHM6KKQCyWvPhzmsAeVwwcXzU04BoXbchH0+xuXTkRKfY185Yt1BmpUq
         BF/b+/GrHZdG6vMs6tE9ANALA9AGd6dGdTq3sNibTch4kMUQ8Fv46zu2uoNMVahdb4n5
         NJdA==
X-Forwarded-Encrypted: i=1; AJvYcCW30PpZ2QyD4awbvYDBYFjdIVwY0CIXjGuUejpStbRv10nr9hHAmU15l2JggtKNcVRUWIBHYXX7J1GVOmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRNDHkDyypOMTTJ90lGOnc/5cWjgPUKxinYpx6+qA7vahx9tB
	mZQbGcfbLyfkXTtKorqtCg8FzYdf33F7WVMD7irXpPogPBFItRZs8HiP
X-Gm-Gg: ASbGncvomjOF9OQm/2zySCU7SEmJp3gPoF1P86N4DbTKKKwkdXDxKdTjGWI2mncU4Ls
	U+Ewh10pItSp+LJ2hGwoLq1yvAuWhNeLZxbZuaosiOCDWGL5DoESuFdlGT7BUF20XWvQEAk+mqn
	LYhLBJLy0Z8tH4i+L5Q7HwpGfw9CZquDF6nlY41IM+H7/ZF1ThONCoYeWNVK2Y01lwSb7852qDO
	VkTJVO2biMC0oIjHJ/DsYCOS+joiiX7G+qRQYAwkwg0hytFD2rgsZU3tpmDUJT0z3LPa/E6lxnZ
	xbgiOMZWQzKzVlxFWBI2E6TMhb7GbNCXrKNtfoUmlFMB/akd2aawBPwbNaiQrSPKyJ4qcf7+QJn
	KKndQcDhpAFZwwMuIS3fLK74Y9lauVYanycSMmDxC9wMnHal63t33rtlByvrvpI9LrJ8FHcfNPE
	frpt6Y1RHL
X-Google-Smtp-Source: AGHT+IHlnIMKveRuj+7NJDShOnf/WRzuKghr7uizOQzNqC04F7WkjGrUa4ubUJ/Uj9RfnZMzr1+iOg==
X-Received: by 2002:a05:6a20:244f:b0:2df:b68d:f73 with SMTP id adf61e73a8af0-2e7cdd9aba1mr20672654637.34.1759121674981;
        Sun, 28 Sep 2025 21:54:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:78a6:bdf8:e03d:d9ea])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5574e99sm10062601a12.35.2025.09.28.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:54:34 -0700 (PDT)
Date: Sun, 28 Sep 2025 21:54:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: pengyu <pengyu@kylinos.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, legion@kernel.org, 
	mingo@kernel.org, myrrhperiwinkle@qtmlabs.xyz, tglx@linutronix.de, 
	changlianzhi@uniontech.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty/vt: Fix possible deadlock in input_inject_event
Message-ID: <dltckle3ksus7qojkpiirvush5khk52o36yhqnlfpiymrjjwzt@ev46jjxjhi3p>
References: <20250928130819.383808-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928130819.383808-1-pengyu@kylinos.cn>

Hi,

On Sun, Sep 28, 2025 at 09:08:19PM +0800, pengyu wrote:
> syzkaller testing revealed a potential deadlock involving keyboard 
> handling:
> 
> CPU0                       CPU1                      CPU2
> ----                       ----                      ----
> read_lock(tasklist_lock);  evdev_write
>                           input_inject_event     write_lock(tasklist_lock);
>                          lock(&dev->event_lock);
>                         read_lock(tasklist_lock);
> <Interrupt>
> kbd_bh() / kd_sound_helper()
> input_inject_event
> lock(&dev->event_lock); // Deadlock risk
> 
> The deadlock occurs because:
> 1. Both kbd_bh and kd_sound_helper run in interrupt context
> 2. tasklist_lock is interrupt-unsafe
> 3. When evdev_write holds both dev->event_lock and tasklist_lock,
>    interrupt context attempts to acquire dev->event_lock create deadlock 
>    risks
> 
> Convert both kbd_bh and kd_sound_helper to use workqueues. This moves
> input_inject_event execution to process context, where it's safe to 
> acquire locks that may be held by code using interrupt-unsafe locks.

So if we ignore the input code and instead look at the send_sigio()
(which input core ends up calling) and do_wait() we see that
send_sigio() disables interrupts and takes the owner's spinlock
before taking the tasklist_lock, while do_wait() takes the tasklist_lock
first, without disabling interrupts. This is root of the issue as far as
I can tell and no amount of changes to the keyboard handler (which is
just happens to be in the middle) will not solve for all potential cases
and code paths. 

I believe either do_exit() or send_sigio() have to be changed to fix
this properly. 

Thanks.

-- 
Dmitry

