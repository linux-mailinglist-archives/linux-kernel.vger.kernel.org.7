Return-Path: <linux-kernel+bounces-674398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 705CFACEEA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF2A1897CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C978215077;
	Thu,  5 Jun 2025 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVYVEI7b"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFB211299
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749123745; cv=none; b=RQ4DZr6cmcZo4298pNPhqTSO4XawZN7JfImIgfSp8Gc9qW/TEasXJTh0pe3CkmP790iptUpTvi40qd8g7J/WlxNa8DvgcV1suhmg3ys+Uq5dl/NGG3sk7WiycRpDxto44TLdOzHVh02mbIoYnHNWmnYzrjMTsgZpn3L/984RF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749123745; c=relaxed/simple;
	bh=tcyk9qTQetzx0XsOFkVzNzkoHqecLKNuQJsJIydNEdw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GV6Khnjbx/zr7qKnZTpzZqBzagFd8TAkZduJoHlr4Ot2M2rg4lkI5/6AZXj+28UCWw+py8KfUcgHcrt0L3dF/+x6807CEhhyaSCi+1DUyp5pDfSVw1EJ52LpF4dowT9qVZ5l5bKLobWRJR5NJRyD+ysplau/FaWyyLwmRPZXAY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVYVEI7b; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-528ce9731dbso266972e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749123742; x=1749728542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Gghaebtx5yqlNAd/7YBW+FJ3u/GC+efBoxp5Mj6d/w=;
        b=ZVYVEI7b//mAvbZMlsEeJJLMTNStUH9QrBKr8rcuhZWsz8KOnzIm9+OsVWjGVIzb3n
         vZsWWs190ulTf8YcDzHgczVh4ezry0ShtlYGv3t1k4/6UfH+6zUfYkjdKmMibcVRzXJ6
         A8Q6E7riS8SVVcC8BnZZ1mZPNKSsKVecmMAlrdQoTAoj4qRurlwkeRgDfejYVAV7POwu
         lYGKjsr2qtzsaAZG/w4wz1U5Uif/p0bByxZY5FjgBpc1J7D6p93P8cHvtzZ794IFcUdo
         58bXycQWdd4SQ0YsFiRaFmS2uMDmsFCd111X4wq5Y7jslyobpifcAUAadKxIdYNIE8Uw
         MOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749123742; x=1749728542;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gghaebtx5yqlNAd/7YBW+FJ3u/GC+efBoxp5Mj6d/w=;
        b=HzCZrdJWUTpyAKYvrUI4P3YcoUn7Z7Cf+E22ibjP4ZClEJGYIIqHt7cDSD6IZiFqO0
         xX9bqBMhk20/hlxsAi7rhs4NAxRDQd52vEtX5ImLzhXGVR3aPx3OwEK6J/eFJDjcK87c
         DD7USJV1Pp4cd5H/wnUW4+GDwgnswlRZYOj+/G5gEObyPbl/8ZK2LMbD2fvjA/2pAuI/
         KQjC8YewXmttFUkZlEk1hwp5KGFdDXxZIbtWMby0IR7jI7dUf7lQnyxuGZ8UiiyA3jzD
         NSo9bPzZJf0tuHsQ4clFG2j91etZek+rxUgFr/DatOJxMGaCku0gUzROPzOrYQsSutNo
         szkA==
X-Gm-Message-State: AOJu0YyxkmsHpAwkAJrCCJ23ftkbRj6t3BOcsUzxqwqKY2rtpaoLtay5
	7YBJFFGclQJyg00WkCAyppwXXqO1uwsXNN5h9eoS+MtVsDMaHR7tb240GvCmat9xDMq3ujewhnk
	dLruoVRJqB96HnrbBiQqCpsU6wADBZJKNJMapRUt7sNQSTp4I7ush3PQg8g==
X-Gm-Gg: ASbGnctPW3GaM8pBSH+41YKhfNzTTENz3jkyIuYg1t0LFrmMFR//X0OXiL/apPnlt/1
	iWKcdSyTLQm4Ig0COfASq7KnSvfCrnfDzO1vm2NlTGX+j9pWBjMo6xl5mnPpXK19arMrZW+/MhM
	taKxcfzAGX9SeU6uTur3CwWCYY40eGd1riYe4yvoTLQq0MEiIF4ZGmoNZcEpWE/eSjtU7+n31eM
	rj2
X-Google-Smtp-Source: AGHT+IGUzV04DfkxsbKWgGN7nUKIFtTlgyyP/relgKDePkaP0Mvt9Iv2QzOEIT+pnvo5d2eJy1yJxRPb7c2w+72/iDI=
X-Received: by 2002:a05:6122:3c8a:b0:52c:44a6:4801 with SMTP id
 71dfb90a1353d-530c71a28ebmr5254427e0c.0.1749123742002; Thu, 05 Jun 2025
 04:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 5 Jun 2025 17:12:10 +0530
X-Gm-Features: AX0GCFtZCBp6S_imm54IT1hXZI7I84zYQY1NEskPK0o6HVT64YDd6F47_jzNMiU
Message-ID: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
Subject: next-20250605: Test regression: qemu-x86_64-compat mode ltp tracing
 Oops int3 kernel panic
To: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions found on qemu-x86_64 with compat mode (64-bit kernel
running on 32-bit userspace) while running LTP tracing test suite
on Linux next-20250605 tag kernel.

Regressions found on
 - LTP tracing

Regression Analysis:
 - New regression? Yes
 - Reproducible? Intermittent

Test regression: qemu-x86_64-compat mode ltp tracing Oops int3 kernel panic

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
starting test ftrace-stress-test (ftrace_stress_test.sh 90)
<4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
<4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
6.15.0-next-20250605 #1 PREEMPT(voluntary)
<4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
<4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
12 e4 fe
<4>[   58.998610] RSP: 0018:ffff9494007bbe98 EFLAGS: 00000246
<4>[   58.998715] RAX: ffff912a042edd00 RBX: 000000000000000b RCX:
0000000000000000
<4>[   58.998727] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
ffff912a00f2c8c0
<4>[   58.998737] RBP: ffff9494007bbeb8 R08: 0000000000000000 R09:
0000000000000000
<4>[   58.998748] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff912a00f2c8c0
<4>[   58.998759] R13: ffff912a00f2c840 R14: 0000000000000006 R15:
0000000000000000
<4>[   58.998804] FS:  0000000000000000(0000)
GS:ffff912ad7cbf000(0063) knlGS:00000000f7f05580
<4>[   58.998821] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
<4>[   58.998832] CR2: 00000000f7d8f890 CR3: 000000010124e000 CR4:
00000000000006f0
<4>[   58.998915] Call Trace:
<4>[   58.999010]  <TASK>
<4>[   58.999077]  ? file_close_fd+0x32/0x60
<4>[   58.999147]  __ia32_sys_close+0x18/0x90
<4>[   58.999172]  ia32_sys_call+0x1c3c/0x27e0
<4>[   58.999183]  __do_fast_syscall_32+0x79/0x1e0
<4>[   58.999194]  do_fast_syscall_32+0x37/0x80
<4>[   58.999203]  do_SYSENTER_32+0x23/0x30
<4>[   58.999211]  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
<4>[   58.999254] RIP: 0023:0xf7f0c579
<4>[   58.999459] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10
08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5
0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26
00 00 00
<4>[   58.999466] RSP: 002b:00000000fff98500 EFLAGS: 00000206
ORIG_RAX: 0000000000000006
<4>[   58.999479] RAX: ffffffffffffffda RBX: 000000000000000b RCX:
0000000000000000
<4>[   58.999484] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
<4>[   58.999488] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
<4>[   58.999492] R10: 0000000000000000 R11: 0000000000000206 R12:
0000000000000000
<4>[   58.999497] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
<4>[   58.999534]  </TASK>
<4>[   58.999579] Modules linked in:
<4>[   58.999895] ---[ end trace 0000000000000000 ]---
<4>[   58.999892] Oops: int3: 0000 [#2] SMP PTI
<4>[   58.999997] RIP: 0010:_raw_spin_lock+0x5/0x50
<4>[   59.000008] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
12 e4 fe
<4>[   59.000010] CPU: 1 UID: 0 PID: 339 Comm: sh Tainted: G      D
         6.15.0-next-20250605 #1 PREEMPT(voluntary)
<4>[   59.000014] RSP: 0018:ffff9494007bbe98 EFLAGS: 00000246
<4>[   59.000021] RAX: ffff912a042edd00 RBX: 000000000000000b RCX:
0000000000000000
<4>[   59.000026] RDX: 0000000000000000 RSI: 0000000000000006 RDI:
ffff912a00f2c8c0
<4>[   59.000030] RBP: ffff9494007bbeb8 R08: 0000000000000000 R09:
0000000000000000
<4>[   59.000040] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff912a00f2c8c0
<4>[   59.000044] R13: ffff912a00f2c840 R14: 0000000000000006 R15:
0000000000000000
<4>[   59.000049] FS:  0000000000000000(0000)
GS:ffff912ad7cbf000(0063) knlGS:00000000f7f05580
<4>[   59.000054] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
<4>[   59.000059] CR2: 00000000f7d8f890 CR3: 000000010124e000 CR4:
00000000000006f0
<4>[   59.000070] Tainted: [D]=DIE
<4>[   59.000080] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
<4>[   59.000085] RIP: 0010:_raw_spin_lock+0x5/0x50
<4>[   59.000101] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
12 e4 fe
<4>[   59.000108] RSP: 0018:ffff9494000e0e88 EFLAGS: 00000097
<4>[   59.000117] RAX: 0000000000010002 RBX: ffff912a7bd29500 RCX:
ffff912a7bd2a400
<0>[   59.000179] Kernel panic - not syncing: Fatal exception in interrupt
<0>[   60.592321] Shutting down cpus with NMI
<0>[   60.593242] Kernel Offset: 0x20800000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
<0>[   60.618536] ---[ end Kernel panic - not syncing: Fatal exception
in interrupt ]---

## Source
* Kernel version: 6.15.0-next-20250605
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 4f27f06ec12190c7c62c722e99ab6243dea81a94

## Build
* Test log: https://qa-reports.linaro.org/api/testruns/28675335/log_file/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4whKazVqJKOUFD08taHC8XHRq/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2y4whKazVqJKOUFD08taHC8XHRq/config


--
Linaro LKFT
https://lkft.linaro.org

