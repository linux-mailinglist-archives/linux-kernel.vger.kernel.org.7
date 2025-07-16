Return-Path: <linux-kernel+bounces-733726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA7FB07843
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB913189AFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5F25C822;
	Wed, 16 Jul 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="EukPPG3F"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FF19AD5C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676693; cv=none; b=TtwacgcnS/l1v7SZVLdHP9F7z9lDKq5fdDPYWi+XjYODFrb+7gHqhB67oWYMFT5Ti4/dMV8Ffz9nRQdMLtLWJvt36A6wngD+piZLSVWZEhrEqItJRArXk0D9M5SjLCE0Yo30ir6S0yYm/NM32D3lkpg3Ig4AJNriUqfOioRGUvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676693; c=relaxed/simple;
	bh=kzXHoCSpbOVXPQ9SiOBidicmi4xne0SY+TF87c2chl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyo2tShNtP8e6jjQ7+M4mxyvJ6Cz7QuNT5qBdXdBxk6b8S1GIXeBiTtOIqWDxP7XTmRZM0Ws4OOTdk0x17ftKbWHLcWhxxmh/F+QeHN/hR8gzL+IZCQE0YfORI0dXeFYcjFGVc+qv5If0NXWIXVf018yrMEFlr++Qz9eB5kugo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=EukPPG3F; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d5d1feca18so676452785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752676691; x=1753281491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wIvZEA8v0YLh3sRmpgUJHIlxBcd3W6IKYV4LMYQwlsU=;
        b=EukPPG3FVa0ZBrIX/adivLW2lWSlG6rFhATgNhqW/idZJ/a7+r3VRRRjBd5lWv3T1D
         wOyc5WBd7QS6IQx5DBXev34DdHo9h8y0C7Maa9aVAFVy7pnzGrvqoe/AtyTqQhdUwX23
         /HGrwwjW9SiUHsqn47QzteVcKAUTAM+pgOi18snpoLdGkcNpLHb6A90VVY8rO5e69JLG
         RV+UNmZGk/FI0XYV1yCqzS0U2A7JJFcQ7cEKcrvv+9GT3/eB7x11M88Nk0RHL5GtRy42
         5BDgFwUwc+Uy007YGUSdVZneCL5ucgmy3MqKNyw+lIBzECgd/tr9DHWpUaSVwIzRumRk
         HTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676691; x=1753281491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIvZEA8v0YLh3sRmpgUJHIlxBcd3W6IKYV4LMYQwlsU=;
        b=dDnIX+CziMSkJ2+yg2DSIFGC0CnmcNSm/oVy10zPqRvxDC40tV0irClKFC0bD85wBK
         m43i8rA2OWLjiWB+EgH0yyOH/XpwXAnrQp2Imn78fLCeG45BqugJBiMDtgxu3r3fgaKV
         RhsI5ufLj6ewwRUwcV7d9zYZzUD9ufsiHFJYa+k+0ONRYpOuFKYlFV+YoziTshPc3xGq
         VGvJGKH6i+J9qF+/K2h+y6bxCzjqVq1OBuMX/gLkhVBankz3SfqQHE6GYk7qqju+UL8l
         LhsoJH3KDrd3Z6b165v7JKvDGHHqwFw9SP8Yj8M7PqT0gLF29eZYZCNsfaGl9leFSNjJ
         4qwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXelQwmLNyNbSkLe43nQykKM3hXpP00AVeJNQ6+uZ9yBCSYlEhZ7RerNATWSdy0Xn6a+lomsOxcp44wlNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywane3Y435z2GhOy1hcEsognkvm9mYcezhKLOoeWDKwCtLU2mEZ
	J0UDHx8rGFn4urGzMmj8hOB3W986s4M9stau/pzW/KKSuyz8vyvqSAqhx9mcsXoH2w==
X-Gm-Gg: ASbGncucU4KAXF7hXI25aforQ1lEQ4pPMnK3aXMdPEFC58XQPjGl7ndaQlCNXeM+ueR
	NVLM6tPP9P8W9Qrs9IwDqrJgsbFi8tDA++5br+gAq0KjnZJPScrwHpHOgzVjpdIXA/DvpVhsS78
	ngYc7s4aQcbbFhD/N+dK+74WEWgRFFpHuG8okZFYX63ULNgzd6GTldHntuFhQ6eQLDLVC3vn4Go
	LwmhwWrEngy1wEYLFE03DQzTNcL3L8PbiyDgoq80Mp+1WrWivjWE3KwoOFo8M3CKImKN/b7O97P
	TSrmucYTegrnb1PqiEbvdrXBJeOLhf3lAF8ZlmLORGfOY2S1AVseugQHmOsN+SDe3PEvq/L+9kC
	I2mMXGGCJmHx33R4JwV7BJac9vI7MZLzgKoOeXgjf
X-Google-Smtp-Source: AGHT+IEK8giyJdjpvdPkO8GcuyoFoEgcHl1mie8gpJP7Afsc4EOVD8KSns//15rf1GTD6PWvQ7Z39g==
X-Received: by 2002:a05:620a:7019:b0:7d5:c45f:c3c8 with SMTP id af79cd13be357-7e343350dd3mr368906485a.12.1752676690751;
        Wed, 16 Jul 2025 07:38:10 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e32c767ccdsm336633585a.12.2025.07.16.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:38:08 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:38:06 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sean Young <sean@mess.org>
Cc: Hillf Danton <hdanton@sina.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <ee8203fd-49ca-4106-b8c3-4397c933de46@rowland.harvard.edu>
References: <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
 <aHdzD7EowAKT4AhQ@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHdzD7EowAKT4AhQ@gofer.mess.org>

On Wed, Jul 16, 2025 at 10:38:23AM +0100, Sean Young wrote:
> On Tue, Jul 15, 2025 at 09:30:02PM -0400, Alan Stern wrote:
> > On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
> > > Hi Alan,
> > > 
> > > On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
> > > > On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
> > > > > [loop Alan in]
> > > > 
> > > > I assume you're interested in the question of when to avoid resubmitting 
> > > > URBs.
> > 
> > > > In theory it's okay to resubmit _if_ the driver has a robust 
> > > > error-recovery scheme (such as giving up after some fixed limit on the 
> > > > number of errors or after some fixed time has elapsed, perhaps with a 
> > > > time delay to prevent a flood of errors).  Most drivers don't bother to 
> > > > do this; they simply give up right away.  This makes them more 
> > > > vulnerable to short-term noise interference during USB transfers, but in 
> > > > reality such interference is quite rare.  There's nothing really wrong 
> > > > with giving up right away.
> > > > 
> > > > As to which error codes drivers should pay attention to...  In most 
> > > > cases they only look at -EPROTO.  According to 
> > > > Documentation/driver-api/usb/error-codes.rst, -EILSEQ and -ETIME are 
> > > > also possible errors when a device has been unplugged, so it wouldn't 
> > > > hurt to check for them too.  But most host controller drivers don't 
> > > > bother to issue them; -EPROTO is by far the most common error code 
> > > > following an unplug.
> > > 
> > > Thank you for explaining that, very helpful. Would it be useful to have
> > > this in the USB completion handler documentation?
> > 
> > I don't know what USB completion handler documentation you're talking 
> > about.  Is it something in the Documentation/ directory?  If it is then 
> > it should already include or refer to error-codes.rst.
> 
> I can't see anything in error-codes.rst or URB.rst about the possibility
> of retrying after -EPROTO errors or how the callback should respond if
> it wants to give up. USB drivers seem to do all manner of different things.

error-codes.rst is meant merely to explain the meanings of the different 
error codes.  How to deal with them when they occur is not in its scope.

Drivers behave in different ways because they were written by different 
people and serve different purposes.  For example, data loss in a 
mass-storage driver would be a lot more serious than data loss in a 
mouse driver, so of course the two drivers don't use the same amount of 
care when recovering from errors.

As for how a callback should be behave if it wants to give up, that 
depends on how the driver is designed.  There is no one single answer 
appropriate for all drivers.  In the simplest case, where the driver 
always keeps one URB in flight and resubmits the URB whenever it 
completes, giving up is easy -- just don't resubmit the URB!  This will 
immediately end all the communication with the device.

> > > I think that is why this driver code is so awkward.
> > 
> > That's what usb_driver_claim_interface() is for.  IIRC, the cdc-acm 
> > driver uses it in exactly this way.
> 
> Very interesting, we should look at re-writing this driver. Note this
> function is not documented in Documentation/driver-api/usb/

The documentation files are quite old and were never complete.  Nowadays 
we rely much more heavily on the kerneldoc in the source code itself.

> Thank you for your help

You're welcome.

Alan Stern

