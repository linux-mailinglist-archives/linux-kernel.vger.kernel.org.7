Return-Path: <linux-kernel+bounces-729312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D0B034CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2862C3AECF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3A1E04AD;
	Mon, 14 Jul 2025 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/Qou3DH"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768074207F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462623; cv=none; b=CwQBBLMmoikH9TlR0WCgw8tJYtMMslaK47iSDoY2EEJkVvZmBX/SZKdDxEL+zlhnCAZycJxtLvPrs3MIm4hBpPSrKb/jlKNi085oXBrV8UL3O0tUEoj0w6X+0FVjf6MgvGGXZHvq/RfQgBAsUg/67PDCprcxqUxOtk0El5sWdiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462623; c=relaxed/simple;
	bh=ywQmz3e1eVX7b09bE/5CTX6J9OICTgqMVa7qavO+I4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDdlq7EdS71u9AJbnBBm72fRF0tET/2RuJFhpD9XvOd4UdV/aOps/eeB/AI3YayTINlhTiYHBa1PYPsgG64OfiZ8YGkLkMltfD45+0jCCkqsJyuVvP5WESw7bTej0i0wf2fukVoGdJrfukfxMGXveRHVP63ocIWX89I8Wvel65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K/Qou3DH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3121aed2435so3380202a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752462621; x=1753067421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95Vogbb0qg/Uf39RM5XboqDl+ZGozs6mtqcGMHZEHPY=;
        b=K/Qou3DHNNOdxhwHvFhpi7Bo+GJB8TfLvB14ppKxkGk2/gI/5Fc+u5rfcrmwLtKevP
         ocMoRuZhV3GBoZXg6s4OJnEglvtRJQ6zVKazhy48pMO+XXTnKfSUVsih2m53E6OnJs9L
         9Gds9v+gJq4r2ePaY1v/6Lqlkz6tDDkgyjvfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752462621; x=1753067421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95Vogbb0qg/Uf39RM5XboqDl+ZGozs6mtqcGMHZEHPY=;
        b=sLGpCHVCsbRj85NchSa3s8Q4qG2aI0MY25HpO87iyONLSp/P3+RZkp1vmIblMeOdWi
         SeJ40faVZqsE56rI30GryrFANK4uaVgTI90lVaOW3lKsX2np7HDNyEKkR56nUrg/9h5+
         OOBeskbQjknGJmyNgMr7UsFKFfQVKkZSDphzGC6+IhKdJgpny/FxAtfgkVM6YcugUCCH
         NK050rfXfkOacLldXw/N312BTho4o6mMNKy2p72tDolITBF++SLV5MI85APAOxbJy562
         Oz3ecjbiZCOgonUa+oyZPmkNKAPQ7Oqk1S9hyTYLtQq0QT7+h2tv42V/tHSyLDbrjGv5
         Rezw==
X-Forwarded-Encrypted: i=1; AJvYcCXjHKroH9GqNnvyRRcEt3mVjtbNJgRtvKvrAO9IYmOV6/Rx97A56Tbomt52ypu/duMdup/XqnW8nsZXoOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qBxoNqKuq0L8+CYtFsah50GeDUzVWf3HjdH1M9qCGap8294g
	1IodCEQz4VzBjICnIu3L5NxUdv9zakZSo8nksWK7HcGXMNDBitqnyg532NkYTEkC8w==
X-Gm-Gg: ASbGnct1VXF260wfRjAe+sVfhbyGF2H6qol6rER2ne+LXetxAsrEZOQLOjsNB6POhIa
	v+WVNJkzYR+a9HKYDuG+kNKMo6Tlt8ZEPPJrR8QLyTR18mnxcGGPwU2KJAKoMwgqdCEgZ8hL98f
	LVDrZ6a557wKbnaoPDoyMgcfg1621VyCTYHsfTYHxQtMuPx8DaknBBAfWjdz+spzIDM9ME94qHx
	FGgvhbfzbOmXGQuKimx6SyLBfQIEL2h0pfvO7uZOPKBZ5V5v/bWtC8VApdXfKz2A2TiTcnqqJ03
	4k+N7PaZCymvtD34ARrr+pbBjkHy9KbDBvFgeonlNtS/TWde5J/kc94zxjpj0gGbCAnBy+QpDOu
	ldOdINg6pkQ7FUdnb1FIM5Gxa3g==
X-Google-Smtp-Source: AGHT+IEveKuLKj4Gu+ICh4tWMQ+MM45ThPP40mEavJ6mWn6e1RtgfDK4zbwQaaO1FFLFH9EPbZnTkA==
X-Received: by 2002:a17:90b:5645:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-31c4c973dddmr18866812a91.0.1752462620660;
        Sun, 13 Jul 2025 20:10:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d84e:323a:598d:f849])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286b4asm89402095ad.46.2025.07.13.20.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:10:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:10:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHF4GRvXhM6TnROz@equinox>

On (25/07/11 21:46), Phillip Potter wrote:
> > <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > <1>[335443.339262] #PF: supervisor read access in kernel mode
> > <1>[335443.339268] #PF: error_code(0x0000) - not-present page
> > <6>[335443.339273] PGD 0 P4D 0
> > <4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > <4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
> > <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
> > <4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
> > <4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
> > <4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
> > <4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > <4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
> > <4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
> > <4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
> > <4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
> > <4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
> > <4>[335443.339367] Call Trace:
> > <4>[335443.339372] <TASK>
> > <4>[335443.339379] ? __die_body+0xae/0xb0
> > <4>[335443.339389] ? page_fault_oops+0x381/0x3e0
> > <4>[335443.339398] ? exc_page_fault+0x4f/0xa0
> > <4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
> > <4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
> > <4>[335443.339432] ? blk_queue_enter+0x5a/0x250
> > <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> > <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> > <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> > <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> > <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> > <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> > <4>[335443.339506] disk_release+0xc8/0xe0
> > <4>[335443.339515] device_release+0x39/0x90
> > <4>[335443.339523] kobject_release+0x49/0xb0
> > <4>[335443.339533] bdev_release+0x19/0x30
> > <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> > <4>[335443.339548] cleanup_mnt+0xaa/0x160
> > <4>[335443.339557] task_work_run+0x6c/0xb0
> > <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> > <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> > <4>[335443.339577] do_syscall_64+0x7e/0xa0
> > <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> > <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> > <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> > 
> > [1] https://lore.kernel.org/all/CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com/
> 
> Hi Sergey,

Hi Phillip,
Sorry for the delay in replying.

> I have not been aware of this issue until now, as it pertains to the Uniform
> CD-ROM driver, wasn't copied on the original bug report. Happy to do some
> debugging by all means though. Please could you give me some more information
> about how you're triggering it - i.e. is it particular discs? I am grateful
> for any information you can provide.

Doesn't seem to be specific to any particular disc, all sorts of
external CD/DVD drives that people attach to their laptops pop up
in the logs, e.g.:

<6>[333586.844993] usb 3-2: Product: Portable Super Multi Drive
<6>[333586.844998] usb 3-2: Manufacturer: Hitachi-LG Data Storage Inc
<5>[333587.915913] scsi 0:0:0:0: CD-ROM HL-DT-ST DVDRAM GP65NB60 PF00 PQ: 0 ANSI: 0
[..]

<6>[ 66.541922] usb-storage 3-2:1.0: USB Mass Storage device detected
<6>[ 66.542114] scsi host0: usb-storage 3-2:1.0
<5>[ 67.561667] scsi 0:0:0:0: CD-ROM Slimtype ES1 7L0M PQ: 0 ANSI: 0
[..]

<6>[26205.264565] usb 3-2: Manufacturer: JMicron
<6>[26205.267414] usb-storage 3-2:1.0: USB Mass Storage device detected
<6>[26205.267857] scsi host0: usb-storage 3-2:1.0
<5>[26206.329294] scsi 0:0:0:0: CD-ROM hp DVDRAM GT31L MR52 PQ: 0 ANSI: 0
[..]

And as soon as people detach the drives from their laptops, we get
the NULL queue dereference:

<6>[26369.017083] usb 3-2: USB disconnect, device number 2
<1>[26369.346200] BUG: kernel NULL pointer dereference, address: 0000000000000010
<1>[26369.346209] #PF: supervisor read access in kernel mode
<1>[26369.346213] #PF: error_code(0x0000) - not-present page
<6>[26369.346216] PGD 0 P4D 0
<4>[26369.346221] Oops: 0000 [#1] PREEMPT SMP NOPTI
<4>[26369.346226] CPU: 4 PID: 1787 Comm: cros-disks Not tainted 6.6.76-08054-g1b09a1d2f6c9 #1 (HASH:42d6 4)
<4>[26369.346235] RIP: 0010:blk_queue_enter+0x5a/0x250
[..]

The device is detached already, I assume there isn't much that
cdrom_mrw_exit() can do at that point.

