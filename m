Return-Path: <linux-kernel+bounces-721687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E04AFCCB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E29D42702D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957982DECB9;
	Tue,  8 Jul 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekqT1Fqu"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841472DEA9B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982743; cv=none; b=QeZntJjfbxOTF53uUr8d8L6XgHQAj5jHkTgAN4T4/B8W8TCb9UOA2yx+vwIjmrFf8TLT9PI+qsYYosQOutWzVZq3qXdXme+sjS4/SxMpwPnYYFBImJXQotY8fqK4NPrLEGUkR3XkqR3KgR31F1PfBtP9dOPL9b+9DBDr3w9Z924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982743; c=relaxed/simple;
	bh=3/g1rFk3NJEWn4denA9eBbo22aVvLNbSQN7LVC2D/m8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WBuIYi+1qyiVbOM/m6zYP4+T022pzNS4g6mYhPGWZQQItn98avyZ2wCyBjj0o6uvPORcvn6Iy8RUb2V4bEsNa/s769PzLe3jWyQ5NljkwAtKP6hh9pQWXrSZHOo/rjtWHgT/efVihRQinT7eSoQasgZyhDzgzBEGAh5R9+c8V0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekqT1Fqu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34ab678931so3109292a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982741; x=1752587541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CK6vEbbhNAxWWV4SV3M70K2QlHYmbtzjgbxyw0MIuUw=;
        b=ekqT1Fqu4vyDfHG5Or2LWvcHXJ8+fiNRvM4p/mh0VR93rWnIkGV8dBIcv+SKkQYWv8
         NnvgBiBa5ccaNhH4oW7/DMrXYX2CsZ2dOrWs6Kz8x/9X8aigUt9mI8+HmbQw7JN0kHCK
         q2NH7PBjpDmbYtu/kK8UAg6QcH3PdKLaf/duLEgR8nbm9y0nWRCWbbIDTwMzHD+3y5P+
         IFhMCIorK7xENceUzurQDzv+HXjY84HQ6CFWtQ/veycWkPPuVsOotsiNa51TqhA9mdtd
         hY0bLR9OatEmX2YKwunXkr4OzYbOuMJuR67yhw+Rq4UUzmi7yT0jsCPvTIF4Cgq9b8XI
         ZAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982741; x=1752587541;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK6vEbbhNAxWWV4SV3M70K2QlHYmbtzjgbxyw0MIuUw=;
        b=aMYgM6wKZzfFtZ3/qu8piw9iYUzAaKWMCvtl/IeEsjtdMROeVFzcZ6mQFXcI0VvcCz
         ms+fi0XSpe/rz7i+yZWi91PzqKYxT5wZKqgzooF8S+75XmIamGPLz+JBUNZJEt6Vz25s
         NGFd2FTCIojIDXdWDT6Bxtngxz7pEVEn69/WEMBS9TvLU1QZzBgmbaIt6t02IEjNyOzo
         fq9TAuYp6310PVGBTbkpYU64c2lyx3w3K/R/zUHXdE059iAYrRvQLn8yaOYhBvGDPF7q
         qKFh9hLIYfWDmsxLzHM4rp+JdHqrIYA4aW8R7HTkJU3TttFkLnzr63l7CuPIooEznXE2
         m+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4QwXUEy7Zu3NaeCfBMQ4agxDGrny/GVdsgzxCwpC09LY7oZQLV7bnF3bZhhjz3tlgBLhjoW+ZYvbC5YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMfcUrnbxzxMraUpQnsCSdvAshwFyj0K+bpdh9+xI7b7536tp
	Y8D9UsD5/H6N0mfNUFV7TsDup+ZvXB8BZ/RUoOubVJSFoBAhfDFDijXLBtRAstgvaEUThUvL+4g
	Gz2mRwX9FAESTWyo/aGanEcXjKeP/Fw==
X-Gm-Gg: ASbGncsFX9v4BQ0tA5ergIw5tqs5ThSnarYHVCp9yrEDeAL0vVbeuvsx9wGGi8j6crr
	bG6BDDct9XxpdT0wAnQ5Z29FXI1F17/SIUYjAyJfn/t1wCraKhpJfSp7Z3xzBua13peg7Aqg6d2
	REKVO0n6/pPnNPxb9fnCBJyC7bbFj1VJ2hgHlBc9v2ZEUKue+O50NRO8uksoYN+rly0NE+LL3I3
	8w=
X-Google-Smtp-Source: AGHT+IEj/5jlgWc/fPP+L/dBTh5sWN0KcsabhNA8vdKTnbYNXYtORk5vIGYAxU+RZlKNXRRvcGl+wgDuh43UBUt/1jg=
X-Received: by 2002:a05:6a21:4612:b0:220:3024:3d05 with SMTP id
 adf61e73a8af0-22b1bc58967mr5520920637.16.1751982740094; Tue, 08 Jul 2025
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Tue, 8 Jul 2025 14:52:07 +0100
X-Gm-Features: Ac12FXzyNW8BWW8z8GMQ4lxKVdUEJ3JWNIQeGt5xGVXNZl53U0W63dhY5K6m2H4
Message-ID: <CALjTZvZgH0N43rMTcZiDVSX93PFL680hsYPwtp8=Ja1OWPvZ1A@mail.gmail.com>
Subject: [REGRESSION] NVIDIA ION graphics broken with Linux 6.16-rc*
To: bskeggs@nvidia.com, airlied@gmail.com
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,


The machine (Atom 330 CPU, ION chipset, GeForce 9400M graphics) works,
but graphics are dead. Dmesg shows the following (Linux 6.16-rc5):

[   34.408331] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   34.408351] #PF: supervisor instruction fetch in kernel mode
[   34.408358] #PF: error_code(0x0010) - not-present page
[   34.408364] PGD 0 P4D 0
[   34.408373] Oops: Oops: 0010 [#1] SMP
[   34.408383] CPU: 2 UID: 0 PID: 583 Comm: Xorg Not tainted
6.16.0-rc5-dbg+ #187 PREEMPTLAZY
[   34.408393] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./To be filled by O.E.M., BIOS 080015  08/13/2009
[   34.408399] RIP: 0010:0x0
[   34.408414] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   34.408420] RSP: 0018:ffff88800378bc08 EFLAGS: 00010202
[   34.408428] RAX: ffffffff82071c60 RBX: ffff888008e6f000 RCX: 0000000000000978
[   34.408434] RDX: 0000000000000020 RSI: 0000000000000002 RDI: ffff888008e6f000
[   34.408440] RBP: ffff88800378bd18 R08: 0000000000000000 R09: 00000000000003ff
[   34.408445] R10: 0000000000000000 R11: ffff88800378bcc0 R12: ffff88800378bdb8
[   34.408451] R13: ffff888007dad9c0 R14: ffff888004285680 R15: ffff888007e671c0
[   34.408457] FS:  00007f2cc7b2eb00(0000) GS:ffff888149ecf000(0000)
knlGS:0000000000000000
[   34.408464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.408469] CR2: ffffffffffffffd6 CR3: 0000000008a08000 CR4: 00000000000006f0
[   34.408475] Call Trace:
[   34.408482]  <TASK>
[   34.408486]  nouveau_gem_ioctl_pushbuf+0x10d8/0x1240
[   34.408504]  ? nouveau_gem_ioctl_new+0x160/0x160
[   34.408513]  drm_ioctl_kernel+0x7a/0xe0
[   34.408524]  drm_ioctl+0x1ef/0x490
[   34.408532]  ? nouveau_gem_ioctl_new+0x160/0x160
[   34.408541]  ? __handle_mm_fault+0xff2/0x1510
[   34.408552]  nouveau_drm_ioctl+0x50/0xa0
[   34.408560]  __x64_sys_ioctl+0x4be/0xa90
[   34.408570]  ? handle_mm_fault+0xb5/0x1a0
[   34.408578]  ? lock_mm_and_find_vma+0x34/0x170
[   34.408587]  do_syscall_64+0x51/0x1d0
[   34.408596]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   34.408605] RIP: 0033:0x7f2cc7d2f9dd
[   34.408612] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
00 00
[   34.408620] RSP: 002b:00007fff6a501ee0 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   34.408628] RAX: ffffffffffffffda RBX: 000055c7792b3f78 RCX: 00007f2cc7d2f9dd
[   34.408634] RDX: 00007fff6a501fa0 RSI: 00000000c0406481 RDI: 0000000000000011
[   34.408640] RBP: 00007fff6a501f30 R08: 0000000000000978 R09: 000055c7792af740
[   34.408645] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fff6a501fa0
[   34.408651] R13: 00000000c0406481 R14: 0000000000000011 R15: 000055c7792ac700
[   34.408660]  </TASK>
[   34.408664] Modules linked in:
[   34.408671] CR2: 0000000000000000
[   34.408678] ---[ end trace 0000000000000000 ]---
[   34.408682] RIP: 0010:0x0
[   34.408691] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   34.408696] RSP: 0018:ffff88800378bc08 EFLAGS: 00010202
[   34.408703] RAX: ffffffff82071c60 RBX: ffff888008e6f000 RCX: 0000000000000978
[   34.408709] RDX: 0000000000000020 RSI: 0000000000000002 RDI: ffff888008e6f000
[   34.408715] RBP: ffff88800378bd18 R08: 0000000000000000 R09: 00000000000003ff
[   34.408720] R10: 0000000000000000 R11: ffff88800378bcc0 R12: ffff88800378bdb8
[   34.408726] R13: ffff888007dad9c0 R14: ffff888004285680 R15: ffff888007e671c0
[   34.408731] FS:  00007f2cc7b2eb00(0000) GS:ffff888149ecf000(0000)
knlGS:0000000000000000
[   34.408738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.408743] CR2: ffffffffffffffd6 CR3: 0000000008a08000 CR4: 00000000000006f0
[   34.408750] note: Xorg[583] exited with irqs disabled

Unfortunately, bisecting is not feasible for me.


Best regards,

Rui

