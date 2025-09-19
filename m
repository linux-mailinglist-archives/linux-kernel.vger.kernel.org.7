Return-Path: <linux-kernel+bounces-823974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD7B87D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16373A88FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D4023C4F3;
	Fri, 19 Sep 2025 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XDOcD0Mm"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441221FF45
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253976; cv=none; b=TtKJQjveoHNK5Bnt7KEkWdgqFCcqOBJooZ0fOwnjUZpe4HAJS2/4uf2EuH3uezr0F0HlElvuQb//vGKb+9LjFumFB3+zDSOpeGszT/wIpcVPMkCf61BINMpEp4H1Z7qM3QabH1wXtGhjhmo8D27W6Mo2vfz16fFR5hGyYDJ0pN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253976; c=relaxed/simple;
	bh=e7orafhGL8NNTW6PV3i8Xgn4yMxdxNj7zc2PLhkfasI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pStd3YM5B9B5eSpQ59RO4Qo71qoR0aha/cbR86+rjyBcYKFI13RkDOtjRjsMO3HPzdlvX6r3Z+C/Cn47Uz7cChpRjdaAdfh/6hWPrsmLWHOe+9vaHH8/LSXKaV0EQsF17uoBtsuBPaWCXkWEun60qM4JeGYxnBF5//S1eDl1tHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XDOcD0Mm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB40C3F731
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758253965;
	bh=zFuUJ3W1EYhS1B0NnuGLIFN93QGHvnRapzE2ABA5zAQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	b=XDOcD0MmyxfTUeW4sRHi64hJ3zwkJb8bvQaVSIkGLKlqdqv8fbC4QrxPUxwgmDvrp
	 rZzxee1hvW3z2pWv4utFYKOE4aE5vffKglO6KaeknV0QJwzweUEOMV21vjAAt5v2w1
	 nysmjBIPMGhGp+vv8tieHYaAxGudEpptpGTsDwQFD6PDh61gtLwv3fIFCiqDi9Ie2A
	 RShsxCz0mYr7j47OIbHo/tCWNZlBDFmTS0s2HuCRPDuv1ABGUcj60OBPSuQizz8RSp
	 npWPRiaffNcz0BtAwBkpp4G+A3EHd+z2q0ztQITlkNycxGwrXcNysLfc23CKvH/QMW
	 iIi4nS3I7vF0g==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-73436886a47so19820077b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253964; x=1758858764;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFuUJ3W1EYhS1B0NnuGLIFN93QGHvnRapzE2ABA5zAQ=;
        b=GKtSUy8dO85onh8puhgrsgLpGY1GDCxi5Gd1FA7RTi1HHOEcUco79eYHpuHFigQAB6
         fGyPLVPFfE/lS0sL8iCRWUZZRplw1i4MGCVHMR1xL2DhvMkurlA634Z4eheP/v3qrKoz
         3TO15chjWUxvfNOUHIEGgj3FjV17V7jF1HQpZSBYWhshwvNz3OsYfbGBDmFNjVRIG9wC
         Iduk0y2rdm3R/eGUeFtXtTINPUvmqsbqGF8npkaogGf6Jw6jQQKJU1Jz9ooTcno/EgWL
         xfWgJs9hdQbRffHj5o8zf+C/wORCF6OscHjXGPCyYR0srvCkUPSj4F5rKpBdjnN6ILpq
         iUkg==
X-Forwarded-Encrypted: i=1; AJvYcCX6SABsytdhTNmsK9k2wrRiAqeVAEB2/XAvX7xLb70ENhHfUgGZvzCg7+7/BtBY7QjsVVvjJi04y/vRxow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznr/tCfDu3s7q6CJa0SgVO0gpr8tSQcQHI5xY9bIR6zC6or9qK
	TNuHVWqGrIxxeC++cC1pUhUslB6LpjXk3mqV2mDPXduGXIsoyivOGGNgUAKUle2obt1LBVoLnKA
	BIabOBeojGQ/mI76xBGw8VSf0YD3HzCOqFBtTsnOJHLUO5gTZa30p7wZe0yauickTbAX5uVLF3/
	x/XEt/hg4IzYpxbLsZGGQK5bLVu2qEnh/u+KlONkykqf4Fca4KS3LVNB88
X-Gm-Gg: ASbGncvqHzvZ0xlBSNzQaYQPHOX3pf28iqtmi3DZmtp1ijf5rBX+9uB84ClyqM64cuQ
	SnMY1xkkegFGmOfgAINw/8ErLoG5ieWUKR6KBf6Pc7la3rhuHllzuy9VWg6EjEBeBC1m9+RUiX4
	aXKKzo6EyvT9iexVwp5ezY
X-Received: by 2002:a05:690c:7089:b0:72f:d215:60a2 with SMTP id 00721157ae682-73d1efe55f8mr15407567b3.7.1758253964618;
        Thu, 18 Sep 2025 20:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoDE4iOuJAvMN796AyOuuxLwQ2RrVd/PGHWd5TA99nvEtLMKssB0U4AiMKLW1dNxt/RwgXsV0tBEacYXnYXNc=
X-Received: by 2002:a05:690c:7089:b0:72f:d215:60a2 with SMTP id
 00721157ae682-73d1efe55f8mr15407487b3.7.1758253964267; Thu, 18 Sep 2025
 20:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Fri, 19 Sep 2025 15:52:33 +1200
X-Gm-Features: AS18NWC3tzDQkov7GjaUQ1s3eoR2riUt3sIYF2JPVkO9gqrM0KxZ1oITLKioKdI
Message-ID: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
Subject: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly put
 devices into D0 when initializing"
To: mario.limonciello@amd.com, "bhelgaas@google.com" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, 
	Jay Vosburgh <jay.vosburgh@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mario, Bjorn,

I am debugging a kexec regression, and I could use some help please.

The AWS "c5.metal" instance type fails to kexec into another kernel, and gets
stuck during boot trying to mount the rootfs from the NVME drive, and then moves
at a glacier pace and never actually boots:

[   79.172085] EXT4-fs (nvme0n1p1): orphan cleanup on readonly fs
[   79.193407] EXT4-fs (nvme0n1p1): mounted filesystem
a4f7c460-5723-4ed1-9e86-04496bd66119 ro with ordered data mode. Quota
mode: none.
[  109.606598] systemd[1]: Inserted module 'autofs4'
[  139.786021] systemd[1]: systemd 257.9-0ubuntu1 running in system
mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT
-GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC
+KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2
+PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
+BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[  139.943485] systemd[1]: Detected architecture x86-64.
[  169.994695] systemd[1]: Hostname set to <ip-172-31-48-167>.
[  170.102479] systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled
in the kernel, BPF LSM not supported.
[  200.503000] systemd[1]: Queued start job for default target graphical.target.
[  200.550056] systemd[1]: Created slice system-modprobe.slice - Slice
/system/modprobe.
[  230.922947] systemd[1]: Created slice system-serial\x2dgetty.slice
- Slice /system/serial-getty.
[  261.131318] systemd[1]: Created slice system-systemd\x2dfsck.slice
- Slice /system/systemd-fsck.
[  291.338906] systemd[1]: Created slice user.slice - User and Session Slice.
[  321.546200] systemd[1]: Started systemd-ask-password-wall.path -
Forward Password Requests to Wall Directory Watch.

I bisected the issue, and the behaviour starts with:

commit 4d4c10f763d7808fbade28d83d237411603bca05
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:  Wed Apr 23 23:31:32 2025 -0500
Subject: PCI: Explicitly put devices into D0 when initializing
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4d4c10f763d7808fbade28d83d237411603bca05

I also tried the follow up commit:

commit 907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:  Wed Jun 11 18:31:16 2025 -0500
Subject: PCI/PM: Set up runtime PM even for devices without PCI PM
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907a7a2e5bf40c6a359b2f6cc53d6fdca04009e0

and the behaviour still exists.

If I revert both from 6.17-rc3, as well as the downstream Ubuntu stable kernels,
the system kexec's successfully as normal.

lspci -vvv as root (nvme device)
https://paste.ubuntu.com/p/x7Zyjp8Brr/

lscpi -vvv as root (full output)
https://paste.ubuntu.com/p/NTdbByTqjR/

Strangely, the behaviour works like this:

Kernel without 4d4c10f76 -> kernel without 4d4c10f76 = success
Kernel without 4d4c10f76 -> kernel with 4d4c10f76 = success
Kernel with 4d4c10f76 -> kernel without 4d4c10f76 = failure
Kernel with 4d4c10f76 -> kernel with 4d4c10f76 = failure

Steps to reproduce:
1) On AWS, Launch a c5.metal instance type
2) Install a kernel with 4d4c10f76, note it might need AWS specific patches,
perhaps try a recent downstream distro kernel such as 6.17.0-1001-aws in Ubuntu
Questing with AMI ami-069b93def587ece0f
(ubuntu/images-testing/hvm-ssd-gp3/ubuntu-questing-daily-amd64-server-20250822)
with a full apt update && apt upgrade
3) sudo reboot, to get a fresh full boot. Note, this takes approx 17 minutes.
4) sudo apt install kexec-tools
5) kernel=6.17.0-1001-aws
kexec -l -t bzImage /boot/vmlinuz-$kernel
--initrd=/boot/initrd.img-$kernel --reuse-cmdline
kexec -e
6) On EC2 console, Actions > Monitor and troubleshoot > EC2 serial console,
and watch progress.

I am more than happy to try any patches / debug printk's etc.

Thanks,
Matthew

