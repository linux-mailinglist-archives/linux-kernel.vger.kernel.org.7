Return-Path: <linux-kernel+bounces-856071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C5ABE300C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24D619C60A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5512D94AC;
	Thu, 16 Oct 2025 11:05:37 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217C261B60
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612737; cv=none; b=UxvPzYYrXpIwBej5iixQU26QN157McQueRhNMCO1+15txuNHnuOE99l4KGHN1uV5krFM3J3jiMfhWdGdxXNKSGUkoCawzLxBergkgrtlnEMarxLD1cY0BtcEcf30tQrnPe1o7/Y2IeP9gHMU/eb7TOTBHgqXdCE9AG9/V6zkooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612737; c=relaxed/simple;
	bh=jPC8Nx7wvkqWufAjN2EFZU8gEQG6OMWyfaBgrJ9pUfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXHgfEigNMNmEYW0Zj7C+d4i5NVd9iH2d9iZvZLraueumQ7aAma+0R9MHiweK7nN0l1aWK7HHSrk1M4rQ9mkzBxpTZHu3jK1BTjelw4+V8FJ/6EnIod2IaPzA4+1RCU2PmDchBw6xVpi//PDomcq8tKfHfJsXxjX23bA1zJdw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 16 Oct
 2025 14:05:22 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 16 Oct
 2025 14:05:22 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+af53dea94b16396bc646@syzkaller.appspotmail.com>, Ian Abbott
	<abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [syzbot] [kernel?] divide error in comedi_inc_scan_progress
Date: Thu, 16 Oct 2025 14:05:08 +0300
Message-ID: <20251016110511.3460094-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <686d5adb.050a0220.1ffab7.001a.GAE@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

> Oops: divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 11660 Comm: irq/7-comedi_pa Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:comedi_inc_scan_progress+0x1a4/0x430 drivers/comedi/drivers.c:563

Hi,

I would like to solicit advice on how to properly address this
issue [1], if no one minds.

First, I think both [1] and [2] problems are similar in the way
they are triggered. While there are no syzkaller-side reproducers for
either of them (even console logs do not have proper traces of what
combinations of syscalls provoked wrong division), the blame clearly
lies with comedi driver-specific interrupt handlers
(parport_interrupt, das16m1_interrupt etc.).

Syzkaller at its current state manages to fuzz select comedi drivers
by manually configuring them via COMEDI_DEVCONFIG ioctl. In the course
of do_devconfig_ioctl() and, for instance, parport_attach() functions,
specific irq handlers are enabled (parport_interrupt) and these
handlers in turn interact with async->cmd->XXX values such as
async->cmd->chanlist_len.

However, in the absence of ioctls related to cmd setup, simply
after a single COMEDI_DEVCONFIG, async (and async->cmd) is
initialized in __comedi_device_postconfig_async() with kzalloc.

Thus, when there is an irq is to be dealt with, these "empty"
comedi_async objects and, specifically async->cmd->XXX, are
processed leading to erroneous divisions like in [1] and [2].

The easiest solution, similar to one suggested in [2], is to check for
divisor with zero values. In case of [1], comedi_inc_scan_progress
would look something like this:

    ...
    if (!(s->subdev_flags & SDF_PACKED) && (cmd->chanlist_len != 0)) {
	async->cur_chan += comedi_bytes_to_samples(s, num_bytes);
	async->cur_chan %= cmd->chanlist_len;
    }
    ...

Any suggestions are greatly appreciated!

P.S. To reiterate, I've failed to reproduce this error and this flawed
analysis is theoretical only.

[1] https://syzkaller.appspot.com/bug?extid=af53dea94b16396bc646
[2] https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c

Regards,
Nikita

