Return-Path: <linux-kernel+bounces-893440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A315C47674
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D609618877B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54AD31283C;
	Mon, 10 Nov 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="RFfe2ZWV"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81862313E18
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787157; cv=none; b=ufrFvggkQPU6fT3/WyJhjii3lGKkIjM1GmLRdUjRzUBOYexX4ICz6oxKxHWpCXiA9WzNsuXnz5Q+mScfxDfs3S+mf7g1PNrvKKl7tW+tuJUMFn8PcuSlFr872nTzXGdqzAJ/RN3ytxe/GR8k/oMJ22qcu+olMMm5gW/eotAePmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787157; c=relaxed/simple;
	bh=ttMGV4ji7PEauoV/o1iK6oxHp8qZmD2Kij9bYr2V9XE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aF/TvyRFe/gu5TdfARsZHAX10vZ4liCUd+Oe32uTajn/p0xYv4g2DSrzLtRH2uHuoCCtuJeoy3Kx5sQDgAaqTLBGElH1WcGWsoekaidBlBmkiCPIYGSsTk6M0h0lbhVvXdmK7hLnpteArX2KS9KmV1y9Y5Hh6LMn6p6nPsdAGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=RFfe2ZWV; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45033024e55so832475b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1762787153; x=1763391953; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lipY9QbVC+MroILyK555ciCKhF20zonjS3pDPXtaDU=;
        b=RFfe2ZWVUgZFY0nfHB3CT0roOQw9iXxEGr7W0AxhxjYWBCksrTC0NlqBm/vglYZOE6
         P1FZD7sQ0jCCC5Dfv5+temeztaeA6nW2RXL5MKC/5APUAcf0SLO71/0KH15wHAOBVTX3
         MdeDGXO3wUUtDG2H/bTlFWjI0P37PmN4tRTCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787153; x=1763391953;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lipY9QbVC+MroILyK555ciCKhF20zonjS3pDPXtaDU=;
        b=PLa13aXgVfcV6KtfRV4d0yqISatocJE157DNOB3GNsSrtDosc2O8W9tPqNu6GhwnZT
         1OLtHHFA/eZ7x2WCXEIngyiOOdiKfrx4iK0pZGQnrK3+Iz9AmG7XUv/b37Huy/ahOPHg
         T4Fkh9+D6q/iw1BgoWHAmsX9Hbf0ic6cuW62mN8+5OLT4VamH2L6OjcNQ3K66fM9A0I5
         /SIELQyLyGzWzQv5/azdbiXrqSRsN26cNSpgQVWA6dIksP8A/r7mXPgSUf5HG8UEab42
         EUO/gj9mPSJwg1qLwu5axbas6fNzyFFoVb7aLy22KRU5o/YlU1Y13i/YA6ufQrR0WMmX
         tN2w==
X-Gm-Message-State: AOJu0Yzi4OR6rzpPzLMNihuFZRsdc0j8fa85zYV5ipGV6maGDb4hJv0B
	Ju0fCJFQ53oggVGjlydQ4pNb8oyc3EZ8PelKb3xQ34TnsnSlS0CopDW1Bo8UXG1bnXstyBY4xIj
	lpOPxhC/wLl63HABNKAWXwsi7rj637SU6+PyrXKMYC4/0Bsks4McV5QWOog==
X-Gm-Gg: ASbGncs2d23Til9bEYO3s4nD7TR2BQcXZgN4NYxjy3vht2NhLHvHI2A6pKaNxtSBC48
	nmBfISfyrnkeLpGOhZlD3FLQG4YuRMD4LmAaAr+MbO6hJ9K/XvUTeVQj3DBnzyoZ/WdlDCoKrZL
	dd0vXnR6zFS4IlDnfPRSaY35xX2j/aPEBNW/jXAv6EBoivZEZ9DTQDCt0Qe4/ZwkH9GIVCo29Bw
	NoLjaZXs9XwdV38/5zeG+qAu2MXLi/dc5a/W7/+BmQ61KHpbIhtA0bmXJKRDU69JfetRxBd6W9X
	8hsnCMpXZT8G7ATZqi/RHLSXbZLttazfNiG6/Ao5J210zP9ORCr2
X-Google-Smtp-Source: AGHT+IFan1SKZkegWjFipuqrmBsPPn1L4WMTGDRVH9+b6sgbYyCnCxve3NhDkBtS0E0yYGbrdldI8CiLci1LPoz0e9Q=
X-Received: by 2002:a05:6808:1a14:b0:450:c09:92aa with SMTP id
 5614622812f47-4502a170764mr4818520b6e.12.1762787153521; Mon, 10 Nov 2025
 07:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 10 Nov 2025 10:05:42 -0500
X-Gm-Features: AWmQ_bmOZ6GPZybsHZWCOdfXcI4U6R6JmF1g-mPLfzn0Y85G-uzU-0CE5bPwbtk
Message-ID: <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
Subject: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am using an ASUS Pro WS W680-ACE motherboard with 2 x Samsung SSD
990 PRO with Heatsink 4TB NVME SSDs with BTRFS R1.  When a BTRFS scrub
was kicked off this morning, suddenly BTRFS was noting errors for one
of the drives.  The system became unusable and I had to power cycle
and re-run the scrub and everything is now OK.  My question is what
would cause this?

Distribution: Debian Stable
Kernel: 6.12.48+deb13-amd64

Drive information (for both drives)
-------------------------------------------------
Drive1:
Model Number:                       Samsung SSD 990 PRO with Heatsink 4TB
Firmware Version:                   4B2QJXD7
Drive2:
Model Number:                       Samsung SSD 990 PRO with Heatsink 4TB
Firmware Version:                   4B2QJXD7

btrfsd scrub configuration:
-------------------------------------------------
stats_interval=1h
scrub_interval=1M
balance_interval=never

Errors:
-------------------------------------------------
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868055, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868056, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868057, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868058, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868059, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868060, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868061, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:30 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868062, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:30 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868063, rd 39712434, flush 583, corrupt 0,
gen 0

Prior to reboot:
-------------------------------------------------
[/dev/nvme0n1p2].write_io_errs    0
[/dev/nvme0n1p2].read_io_errs     0
[/dev/nvme0n1p2].flush_io_errs    0
[/dev/nvme0n1p2].corruption_errs  0
[/dev/nvme0n1p2].generation_errs  0
[/dev/nvme2n1p2].write_io_errs    130766017
[/dev/nvme2n1p2].read_io_errs     137924767
[/dev/nvme2n1p2].flush_io_errs    5054
[/dev/nvme2n1p2].corruption_errs  2216
[/dev/nvme2n1p2].generation_errs  0

After reboot + scrub + clear counters & second scrub:
-------------------------------------------------
[/dev/nvme0n1p2].write_io_errs    0
[/dev/nvme0n1p2].read_io_errs     0
[/dev/nvme0n1p2].flush_io_errs    0
[/dev/nvme0n1p2].corruption_errs  0
[/dev/nvme0n1p2].generation_errs  0
[/dev/nvme2n1p2].write_io_errs    0
[/dev/nvme2n1p2].read_io_errs     0
[/dev/nvme2n1p2].flush_io_errs    0
[/dev/nvme2n1p2].corruption_errs  0
[/dev/nvme2n1p2].generation_errs  0


Smart tests (short/long are showing successful for both drives)
-------------------------------------------------
Drive1:
Self-test Log (NVMe Log 0x06)
Self-test status: No self-test in progress
Num  Test_Description  Status                       Power_on_Hours
Failing_LBA  NSID Seg SCT Code
 0   Extended          Completed without error               16373
       -     -   -   -    -
 1   Short             Completed without error               16373
       -     -   -   -    -
Drive2:
Self-test Log (NVMe Log 0x06)
Self-test status: No self-test in progress
Num  Test_Description  Status                       Power_on_Hours
Failing_LBA  NSID Seg SCT Code
 0   Extended          Completed without error               16369
       -     -   -   -    -
 1   Short             Completed without error               16368
       -     -   -   -    -

Justin

