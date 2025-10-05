Return-Path: <linux-kernel+bounces-842392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86795BB9ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 664884E48C9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7481C6FE5;
	Sun,  5 Oct 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b="bNE4tHb9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF915464D
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688201; cv=none; b=WWjwcjUTIlmhy3wD/8WnHPc6SG59TSwt54bTCLF77Fv9tGWZrLG3Yr/RORXiWQgRZJyPfKlPbrVgxpP+RIllMKK1HWfG3XS3zcsgeimN51SztKBZtGpgyphSG/QPXoN+dkUB7Lccl8519F2wjnAsBXSyPWbbSqprdwa2BCqJY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688201; c=relaxed/simple;
	bh=073gtXhGn2a7mGt2xSj/xZO/K9IODlf7GU9z5wX3ljY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ea3EHHz4b3/MsXqRCu+vCnHwsexqGVFv9RAd2gO/6hCYx+Yd+SsQQNWVvVa5saYVpRfMqkd7uhqy0eP33J8bSCQtIk05/4zeBNqF6ogj/mkGLIaKF+NnCI9NA8DX0GGzEjax4crXOcNomSfixm8JMBYFbcdp3G1u2m09DkRcoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com; spf=pass smtp.mailfrom=it-loops.com; dkim=fail (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b=bNE4tHb9 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-loops.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6234907a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it-loops.com; s=google; t=1759688198; x=1760292998; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qJbSpZeSVQuzgXDZzZDcQEtgwR4/Hwxwkl09lqiA398=;
        b=bNE4tHb9loDg8dbJQxZXwQbzuZ+QGm5Oeh3LnR3VaG6Dftf5e9d8Bxuk63EbrJ95Xb
         u7SZ+46yXgbpU2N03aWYZLD5hBUH4e6nNaqcBiIBo5XLINlj+IBFiNo2IrXuVqGdFXJV
         ZZ1tPp5lyC4z6GrG5J+0s6vBRqGmmkY5cd7LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688198; x=1760292998;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJbSpZeSVQuzgXDZzZDcQEtgwR4/Hwxwkl09lqiA398=;
        b=CrTaMpe1lwY/PHKHkCZzkhVg2grCuwUHXLwHTF9V4mkGR1F+ALSVa83FbS2TGDyYEC
         QVjoEYuNUJYrp5dvSoqffNYokLJqhDddnpLjUd87RHQcng7/JAkXvzniNJfulqt1Kab7
         j2e62oyHgxfd+MAhPMfGqKUA2Qcqp6lhqPVx/SG6UAEWItU0nLr+O97gzgHLcMgi4rLx
         l/jGlfcyfsyMlkwisoxg46fuBSiFf5aBT/GxMYnoW7d+h/5DgFArRyS1lElRbteeFowZ
         j3HQi2BRNHnhWCH4IWAFUTVo48An0V75ywg6z3jCjdGM1TmQF2kjl7hGWDD5eoNZ55i2
         Ioqg==
X-Gm-Message-State: AOJu0Yxog/Ie5/0g4PlVrogyIB3NwmtLVgG1tURQXxRxWi3sd3lGTf9q
	GFKCT3V84g2Sy8yW674dxJ5wKRKfL29PeNiza7DA7xDvArpNLLaZsZmzHQvKeC50Ubk+HRkC+86
	fCBIBjP2qykSkMy8tJWSqt4BtukeW3HpHjWkrL6STvHeHeYncLbOnxY0=
X-Gm-Gg: ASbGncsKPzlKQz6vTWkhK5WIGYj1P7TRljsjdqFPDaAHRIKN8+DBANJj+r0p4avvlhd
	cqwOHV9WJEbLU7/yHqibBQVq3oQzcNUJBCtSQh7U9OgrZE29J5jalF44baJd1BfoXPQNKF+5Kee
	XEN4lr/TEZvciJ1AgEArEtA0HRJ8BRY8j3U2fB4v7hU3BRCEGS9BM77tqeTzdzJ4vbx7+bQpDus
	6dJT8s3OuZiL9JYibghk5sSK/HiCsVa9m8VyiENRr8=
X-Google-Smtp-Source: AGHT+IGJxJ6joQHmJMPYTPGJ/ZH1E/Rjyx2dmK6DGF2zsqOGWa88o6OPEFkvmzNXUXfBUEujj958g1lQS2SPzWEDNso=
X-Received: by 2002:a05:6402:1e8e:b0:639:4c9:9c9e with SMTP id
 4fb4d7f45d1cf-639349014d3mr11154635a12.10.1759688197669; Sun, 05 Oct 2025
 11:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Sun, 5 Oct 2025 20:16:25 +0200
X-Gm-Features: AS18NWAS3CSAKcplCGxTJkoOBbRofYke6nVDPJTSzgEbn-7SkWjRHlkKQzIHixw
Message-ID: <CALG0vJt1D_yK89cRT=m=1uH=cffgkzZ4f69M3MUgp2fP15P1Cw@mail.gmail.com>
Subject: [Regression] kernel panic after resume from hibernate, with
 thunderbolt dock connected
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Good Evening,

After upgrading from 6.14 to a 6.17 kernel I noticed that my system
had a kernel panic after resuming from hibernation with the
thunderbolt dock connected. The caps-lock led kept blinking and the
screen was blank.
I bisected this down to a change between 6.14 and 6.15-rc1 but since
there were a lot of non booting configurations between these two I was
not able to find offending commit for it.

I compiled a minimum kernel image, with the main required drivers only
(nvme, fs, lvm) but no usb and thunderbolt and was able to reproduce
this issue as well.

What I did see in some debug sessions though, was that reading efi
variables was not possible after a return from hibernation
Okt 05 13:33:05 arthur kernel: ------------[ cut here ]------------
Okt 05 13:33:05 arthur kernel: [Firmware Bug]: Page fault caused by
firmware at PA: 0xfffffffee7e64514
Okt 05 13:33:05 arthur kernel: WARNING: CPU: 2 PID: 12902 at
arch/x86/platform/efi/quirks.c:747
efi_crash_gracefully_on_page_fault+0x64/0xd0
Okt 05 13:33:05 arthur kernel: Modules linked in: snd_seq_dummy
snd_hrtimer xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc xfrm_user>
Okt 05 13:33:05 arthur kernel:  snd_soc_acpi_intel_match
intel_tcc_cooling snd_soc_acpi_intel_sdca_quirks
soundwire_generic_allocation snd_soc_acpi x86_pkg_temp_thermal
intel_powerclamp sound>
Okt 05 13:33:05 arthur kernel:  cec intel_rapl_common rc_core
processor_thermal_wt_req processor_thermal_power_floor i2c_algo_bit
processor_thermal_mbox igen6_edac thinkpad_acpi intel_pmc_cor>
Okt 05 13:33:05 arthur kernel: CPU: 2 UID: 0 PID: 12902 Comm:
kworker/u48:159 Tainted: G        W          6.14.0-33-generic
#33-Ubuntu
Okt 05 13:33:05 arthur kernel: Tainted: [W]=WARN
Okt 05 13:33:05 arthur kernel: Hardware name: LENOVO
21HMCTO1WW/21HMCTO1WW, BIOS N3XET61W (1.36 ) 06/09/2025
Okt 05 13:33:05 arthur kernel: Workqueue: efi_rts_wq efi_call_rts
Okt 05 13:33:05 arthur kernel: RIP:
0010:efi_crash_gracefully_on_page_fault+0x64/0xd0
Okt 05 13:33:05 arthur kernel: Code: 00 00 76 08 48 3d 50 2c 7a 9d 74
0f 5b 41 5c 5d 31 c0 31 f6 31 ff c3 cc cc cc cc 48 89 de 48 c7 c7 a0
72 28 9c e8 ac 51 01 00 <0f> 0b 83 3d 83 a1 db 02 0a>
Okt 05 13:33:05 arthur kernel: RSP: 0018:ffffd2f14b52bbc0 EFLAGS: 00010046
Okt 05 13:33:05 arthur kernel: RAX: 0000000000000000 RBX:
fffffffee7e64514 RCX: 0000000000000000
Okt 05 13:33:05 arthur kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
Okt 05 13:33:05 arthur kernel: RBP: ffffd2f14b52bbd0 R08:
0000000000000000 R09: 0000000000000000
Okt 05 13:33:05 arthur kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffffd2f14b52bd28
Okt 05 13:33:05 arthur kernel: R13: 0000000000000011 R14:
0000000000000000 R15: 0000000000000000
Okt 05 13:33:05 arthur kernel: FS:  0000000000000000(0000)
GS:ffff8e7fff300000(0000) knlGS:0000000000000000
Okt 05 13:33:05 arthur kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Okt 05 13:33:05 arthur kernel: CR2: fffffffee7e64514 CR3:
0000000100333005 CR4: 0000000000f72ef0
Okt 05 13:33:05 arthur kernel: PKRU: 55555554
Okt 05 13:33:05 arthur kernel: Call Trace:
Okt 05 13:33:05 arthur kernel:  <TASK>
Okt 05 13:33:05 arthur kernel:  page_fault_oops+0x6b/0x180
Okt 05 13:33:05 arthur kernel:  kernelmode_fixup_or_oops.isra.0+0x69/0x90
Okt 05 13:33:05 arthur kernel:  __bad_area_nosemaphore+0x18e/0x1e0
Okt 05 13:33:05 arthur kernel:  bad_area_nosemaphore+0x16/0x30
Okt 05 13:33:05 arthur kernel:  do_kern_addr_fault.part.0+0x62/0x80
Okt 05 13:33:05 arthur kernel:  exc_page_fault+0x1c9/0x1e0
Okt 05 13:33:05 arthur kernel:  asm_exc_page_fault+0x27/0x30
Okt 05 13:33:05 arthur kernel: RIP: 0010:0xfffffffee7e64514
Okt 05 13:33:05 arthur kernel: Code: ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff <ff> ff ff ff ff ff ff ff ff>
Okt 05 13:33:05 arthur kernel: RSP: 0018:ffffd2f14b52bdd8 EFLAGS: 00010282
Okt 05 13:33:05 arthur kernel: RAX: ffff8e78c29f7e00 RBX:
0000000000000246 RCX: ffffffffc1291ef8
Okt 05 13:33:05 arthur kernel: RDX: ffffd2f140ed72a0 RSI:
ffffffffc1291ef8 RDI: fffffffee7e64514
Okt 05 13:33:05 arthur kernel: RBP: ffffd2f14b52be10 R08:
0000000000000000 R09: ffffd2f140ed7258
Okt 05 13:33:05 arthur kernel: R10: 0000000000000000 R11:
0000000000000000 R12: ffffd2f140ed71c0
Okt 05 13:33:05 arthur kernel: R13: ffffffff9d7a2c50 R14:
ffff8e78ce70b180 R15: 0000000000000000
Okt 05 13:33:05 arthur kernel:  ? __efi_call+0x25/0x30
Okt 05 13:33:05 arthur kernel:  ? switch_mm+0x2c/0x60
Okt 05 13:33:05 arthur kernel:  ? efi_call_rts+0x11f/0x350
Okt 05 13:33:05 arthur kernel:  ? process_one_work+0x174/0x350
Okt 05 13:33:05 arthur kernel:  ? worker_thread+0x34a/0x480
Okt 05 13:33:05 arthur kernel:  ? __pfx_worker_thread+0x10/0x10
Okt 05 13:33:05 arthur kernel:  ? kthread+0xf9/0x230
Okt 05 13:33:05 arthur kernel:  ? __pfx_kthread+0x10/0x10
Okt 05 13:33:05 arthur kernel:  ? ret_from_fork+0x44/0x70
Okt 05 13:33:05 arthur kernel:  ? __pfx_kthread+0x10/0x10
Okt 05 13:33:05 arthur kernel:  ? ret_from_fork_asm+0x1a/0x30
Okt 05 13:33:05 arthur kernel:  </TASK>
Okt 05 13:33:05 arthur kernel: ---[ end trace 0000000000000000 ]---

To catch the real panic entry I set-up kdump and while it triggered
during testing by manually creating a kernel oops I did not start in
this specific case, so sadly there are no real logs of the kernel
panic available.

The hardware being used:
Hardware: Lenovo ThinkPad X1 Carbon Gen 11
Thunderbolt docks tested: Caldigit T3, Lenovo ThinkPad Thunderbold 3
Dock, Dell WD19TB

Since I am able to reproduce this with both thunderbolt and usb
removed, I think the problem lies somewhere else, but right now I have
no idea how to debug/bisect this further.

For testing I tried the current MASTER branch with the same results.
Please note the issue also happens if you hibernate with the dock
connected, remove the dock and boot-up again. This works fine in 6.14
as well.
I even tried downgrading the firmware to an earlier version, this did
fix the issue either.

Kind regards,
Michael

