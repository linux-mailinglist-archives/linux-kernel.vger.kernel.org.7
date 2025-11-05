Return-Path: <linux-kernel+bounces-887488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4BC38598
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5294EB16D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BE2EC09A;
	Wed,  5 Nov 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlRyZd8K"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4F3B7A8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385179; cv=none; b=dSU/w0Nh+cUTXIA+VPoDqu1Qxa24jwVsghGt0xPHcYt3ZUWVZnIbdAQw2DUQd1mpQ2iIMjiAj3reJjxNVDSeSl1psfO7YeIV8kqCMQihhqZSz0P76xORAaJZDhy9hDMWYCZmu5UtLPBXYvKQwTbOZJ+fvj38fRCpjrUavTWDFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385179; c=relaxed/simple;
	bh=76Ko3aEAcd39HFnHI+fvm/2EM0m7p+wcaSBvki+RPwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kqtWXubpfPEluPKzmkRjcxpvnX30lonoYXvbf1sxopdo/Qxg0LaWKgy3RNUrjqghHO2+yqceBFMWI1rmCBr40d1DV4TkpegTKjr2hkw8p8/hHEzRPtUTZCsf1JgZQa1Z9jNVY9xp+YBQooGRV2rfHJJmG5x1HlbRivFfo1+5Amw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlRyZd8K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so299267a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385176; x=1762989976; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8Z0B7nwEIsLaBDJzJVKobGRBR4nXJwMwbn5fWLylyU=;
        b=UlRyZd8KlH8ZlhRewTWWYbaCg+zUV4OxlvYWQxMSYxVlMtGzkTgbvbMUJFhld+8kid
         6KGWAzsa82vu9S2PTMIXfmr7yYtmPpDZmZO4dkIe8+qJ718eXFWbyrlVn7c3yUp1WsQs
         QEwkEe5LMn+uI3bHLhv5yCoFLuAxln42ppb1dyebJS1bRs564lOEq+0Iv14fOm4ykAwk
         Q16cc78JR5sNUB50SQYxyZufujJMNRq+WgUrOF9mqwwRvB/o4pq7iYXF0BMio3uXIAFU
         DkM+NVcy4b8Vl1NoPokWQVLguNE7LJrsCfww/kx7wEFaz3BAGiiXPhG9Gt1SP4bEcu5Y
         Jotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385176; x=1762989976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8Z0B7nwEIsLaBDJzJVKobGRBR4nXJwMwbn5fWLylyU=;
        b=ppRZt7GpMjIQJ+ciqn2n0FARMf7Ir/fHD6mvycixGrwcCphWQZwCIc7lHBHrchZqOY
         f9DeOLPXiHM7rMpUY0Usucn/+vPjk6sA0hWaL+DmzL3sM1iQ2p74G/aCyw/+/l5qV4S0
         Q29hCAWY6h0UkCAMO+WAOedPWfASGMfpsaPRDYX7SOKbqDMmDgWoP6JFpKA0pGRif8HS
         AZ6CES4r2/rEc3ZQA/9X/gzzZuA7nEjRdwktgSvKEN44JBZfVfzJN4RkdTbPsuEqBJeS
         JOaMxKs888Thbo73Bs0r5VxkEh7knyTR7Dha7wEIPgxHSHH+ErgHgqtmhQClviFDgmdk
         D9kA==
X-Gm-Message-State: AOJu0Yyb5Q2erp9JVydqfv1dUospor9i7h3ojXj7inq5y5MdLIHv3Vbp
	sESiKPKgcZXM755ggeWz0W0foTUK9YM7V7Fs+QHBfJo7CBbTqIX6qYA+hjcsWIyN
X-Gm-Gg: ASbGncuNkJx1nA285NwKrntHDu3xfTmoKWlLartpOSuwTThODrxiB0nf6dYTF4qvIrh
	bBsWzUVpuRzQ92ujcq4gJtbThR8J65L65HMeMGQLqDqd6Aod1hGTxZAfkfvUzcwQUH0z1ondwbN
	Y948BlPMMbqKflzOcbvhCS+5jSDxHdSe/f7wZkhy9Md9WWbZ8vVrFGCNivtI/lCpwp0rHMX6V5i
	39Sp6KXO2ycKqwCR3CTshh0LQwo2iYWVdJDYN3i8dHuGQhCsskYcywaOlcdCNk2GZXHFjblz5YS
	IHVVlBnxGi2rtnWUb3N/5G9KXsN+nE/qT1KQXEOkKzn0O7760ViSRl/of8cODNWPFhmlGM9uPlV
	Nrl6hYzXhK4Oboi6Wur0TJK/RsUM0lKnsxRindeC4JvbyfWiIs0LffLHHFsnfJXvS9H+vrj3GMN
	frOiVMjqsUtsCjZe1WWPGzR8Ri8oNxb718
X-Google-Smtp-Source: AGHT+IG/UPg6rWhIVUa4iEdsZPYjXjANlLUkRKnUPxLhygtE7EerWkPaXqaZnKahwUArBksgIbWYsA==
X-Received: by 2002:a17:90b:3b52:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-341a7002455mr5821239a91.35.1762385176395;
        Wed, 05 Nov 2025 15:26:16 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ba66csm4075210a91.5.2025.11.05.15.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:26:15 -0800 (PST)
Date: Wed, 5 Nov 2025 15:26:13 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>
Subject: GDB causing OOPS on insmod
Message-ID: <aQvdFfIhcMBpJdmJ@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm on a x86 defconfig + GDB_SCRIPTS + DEBUG_VM + PAGE_OWNER kernel. Running 
'lx-symbols' in gdb Before loading modules causes the kernel to OOPS on
module load:

[   13.627373] BUG: kernel NULL pointer dereference, address: 0000000000000900
[   13.627376] #PF: supervisor write access in kernel mode
[   13.627377] #PF: error_code(0x0002) - not-present page
[   13.627378] PGD 0 P4D 0 
[   13.627379] Oops: Oops: 0002 [#1] SMP PTI
[   13.627383] CPU: 0 UID: 0 PID: 279 Comm: insmod Not tainted 6.18.0-rc3+ #163 PREEMPT(voluntary) 
[   13.627384] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-6.fc43 04/01/2014
[   13.627385] RIP: 0010:__kernel_read+0x210/0x2f0
[   13.627390] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
[   13.627391] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
[   13.627393] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   13.627393] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
[   13.627394] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
[   13.627394] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   13.627395] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
[   13.627399] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
[   13.627401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.627402] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0
[   13.627406] Call Trace:
[   13.627407]  <TASK>
[   13.627409]  ? init_module_from_file+0x92/0xd0
[   13.627412]  ? init_module_from_file+0x92/0xd0
[   13.627414]  ? idempotent_init_module+0x109/0x2f0
[   13.627416]  ? __x64_sys_finit_module+0x60/0xb0
[   13.627418]  ? x64_sys_call+0x1a74/0x1da0
[   13.627421]  ? do_syscall_64+0xa4/0x290
[   13.627429]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   13.627431]  </TASK>
[   13.627431] Modules linked in: test_xarray
[   13.627433] CR2: 0000000000000900
[   13.627434] ---[ end trace 0000000000000000 ]---
[   13.627435] RIP: 0010:__kernel_read+0x210/0x2f0
[   13.627437] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
[   13.627438] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
[   13.627439] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
[   13.627439] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
[   13.627440] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
[   13.627440] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[   13.627440] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
[   13.627442] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
[   13.627444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.627445] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0

I used module test_xarray for the purpose of demonstration, but this does
happen with all modules.

I have no clue what patch caused this, or when this bug was introduced.
I played around with the scripts a bit and found the diff below eliminates
this issue entirely:

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 6edb99221675..8b507907e044 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -44,8 +44,7 @@ if hasattr(gdb, 'Breakpoint'):
                               "'{0}'\n".format(module_name))
                     cmd.load_all_symbols()
                 else:
-                    cmd.load_module_symbols(module)
-
+                    cmd.load_all_symbols()
             return False

Does anyone know what's going on here? And is this the fix we should upstream?

