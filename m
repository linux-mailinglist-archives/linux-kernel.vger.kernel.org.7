Return-Path: <linux-kernel+bounces-727020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5DEB01401
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E91A1C86780
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABB41E5018;
	Fri, 11 Jul 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S2T0UI7Z"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8619D07A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217464; cv=none; b=FVIFYGhpKgiOr7yGO+L+qF7itLvikTUQ8QOSdzGLFblW0dMOtY7mWPhmS+34SkHfybMSrXgALH+As93f5g0uCb1Ro4vmh2oplbnex19QC9LjwsNiFtgj1PZGmyHxa2TwRRoP/pC4GPX8BdQGwj5u45sKcz6D4mWT3Vu1cPYlNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217464; c=relaxed/simple;
	bh=Y2knosoW+4Nu7fAjfNCGSdWDubhgGsVxF8MqtSL31cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U7fhprzNMr4SCHcGVnT0g9uMc3C2OSun1mXTVAU+e1JdonN976qzOhDHgQe4odJZXwIOwNAnvmm88qcmGESlyMMs9OEXcLLr0Ap9zexjef6MBH3tqw7ccMA9xrTiP8i6S5TLRVMgO0oSQgRsqH1K7Wv0UNpTrKfMSTOET4Mdqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S2T0UI7Z; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso1641864a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752217462; x=1752822262; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LXIV2Gq9HLLgeJUYaj6Eb1VhhwLGzBLega5iQdaGc8=;
        b=S2T0UI7ZGgS8Rc0ksaYCYA4IHZD2oA5Dnnfcr4ALinA/fj43F7aCT+lWjixVqi9xJl
         7V5FTZOIeqJvfBuphWYZ7rWwCdWd7UmJnATd4aSOl/i3XKPuarL6DA0lhwxQ3JAACyMO
         pHln08eZXJLarcFVgdJEjXMfr0ygf6kqwriG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752217462; x=1752822262;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LXIV2Gq9HLLgeJUYaj6Eb1VhhwLGzBLega5iQdaGc8=;
        b=N+KLqCm5TCG77JuKdlQSOvb1heG74uqMr69PUwo4hJkA3So5f7WCFX+3G1XlDPiQtj
         tRL0YHzJVaXpXxll3Wo4hDlDT7sv4gB0MO/Xdp325GpSypeFO5YsW5Z4VJTxc3mlz8GA
         lsQ7Ip9NUrV9TZUAI+jUlDa8XRfR3v+sdsv060Hf8KxZQ3RK76Wmsiy/Q3stMUuE4JAi
         cDukZemQZ+zk37wFPzBfpbXevMaRg9rzWAW5fqfwtNV9r+D6b5h3Icv+zePs8wLuvYwf
         viUU1mJeV2DBeu8a6M0QKo/+LR12KALNW2piObRYY0mlLrNQSdgPuZR/y1cvAWXGwK60
         VEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa/y+YuTCwXncwZAvqdtE1VwDt6l2v9y072tIvdEEwi6b0SIRIBw4y2efYLe4B1aiCuoo9dtZ5VQWNCwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uCkN49HrX7nBDv0yRxGIVDjzsqzkM03nyARqr3kfeMAYHsFV
	GXEwf0hKJz32pIhR/XN2EVogDA0IfZRXsNlSnuyd0fTT5h2Eb/5874T88hky0TFjNg==
X-Gm-Gg: ASbGncs0HJNYHNwlJMmwwNc3sUti7l7lnF8y+qeAxwW5EpBalz6hwo2Lb25ZQFT5hh5
	EDeDs+SzpBbcJcI2OS2lkxy5mhfQo+QdBVKKukaovL1pfAdMm41YBT96ujL/oNDjh9b6v8f54ax
	gVB2sPPKnOP8JE466I0EOs3aZr8mAPE5pIn/j6gtzUBftvg2A5xdg/AjIHCzAtXAAgIROy4q0PR
	45K9zMZAyG/kHUakdfM3vLY+9bvUHZ2i2gbe4XVTH0lIClMiCY7oDV4y38CqZ0AKX1yc1QLlkOg
	zWjLdsLOIMKOTeNRsU0qphGPxZaC/i7x5cnTnm8YsUfYjwY24isgB1ajjRApYfkybxyxnBcZyEG
	em2O2G8wQiWIYFj8gU6FWq2pL
X-Google-Smtp-Source: AGHT+IGHuVtZZysdgymmFoLrlBJdG+mI3CBXaytS1FE7dNiWZCW+ndbBQD1raYD1f5BYuPW/9buodQ==
X-Received: by 2002:a17:90a:e7d1:b0:311:2f5:6b1 with SMTP id 98e67ed59e1d1-31c4ccddbd8mr3302077a91.22.1752217462338;
        Fri, 11 Jul 2025 00:04:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1248:20c:c8b1:669b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc3bsm7795159a91.24.2025.07.11.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:04:21 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:04:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We are seeing the same NULL ptr deref upon cdrom release, as reported
in [1] (Chris Cc-ed) in our fleet.  Currently on 6.6 LTS (could be the
same for older kernels as well, I didn't check.)

Phillip, is this a known issue?

<1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
<1>[335443.339262] #PF: supervisor read access in kernel mode
<1>[335443.339268] #PF: error_code(0x0000) - not-present page
<6>[335443.339273] PGD 0 P4D 0
<4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
<4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
<4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
<4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
<4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
<4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
<4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
<4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
<4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
<4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
<4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
<4>[335443.339367] Call Trace:
<4>[335443.339372] <TASK>
<4>[335443.339379] ? __die_body+0xae/0xb0
<4>[335443.339389] ? page_fault_oops+0x381/0x3e0
<4>[335443.339398] ? exc_page_fault+0x4f/0xa0
<4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
<4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
<4>[335443.339432] ? blk_queue_enter+0x5a/0x250
<4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
<4>[335443.339450] scsi_execute_cmd+0x65/0x240
<4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
<4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
<4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
<4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
<4>[335443.339506] disk_release+0xc8/0xe0
<4>[335443.339515] device_release+0x39/0x90
<4>[335443.339523] kobject_release+0x49/0xb0
<4>[335443.339533] bdev_release+0x19/0x30
<4>[335443.339540] deactivate_locked_super+0x3b/0x100
<4>[335443.339548] cleanup_mnt+0xaa/0x160
<4>[335443.339557] task_work_run+0x6c/0xb0
<4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
<4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
<4>[335443.339577] do_syscall_64+0x7e/0xa0
<4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
<4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
<4>[335443.339595] RIP: 0033:0x7d52bea41f07

[1] https://lore.kernel.org/all/CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com/

