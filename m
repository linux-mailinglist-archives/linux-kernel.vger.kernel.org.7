Return-Path: <linux-kernel+bounces-797629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E463CB412B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EC91B634C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94E12C15BB;
	Wed,  3 Sep 2025 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KoprB8mx"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407FF2C11EC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868546; cv=none; b=BpCNNffc+VYNgf7xkxczxTpF4P5OK55+/F3+UtBDoDWA6m73VMMtLHYF7ZZZSr8nbHd3jf8uOd7n81MEr5EaTCMXEmqljpFR0thQ7IJB4d17E2a/Ld8+iw2SMo+CBIKD4Cfy3bQ3S7XsnX/hxUwAQ1sEBkrQaFpWZ61HUUaPbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868546; c=relaxed/simple;
	bh=CCmrtHQ5/Qf/3xYkMKWcYE7l/AIidv/ZTRxCGLi3sqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZD/WOmY29VeujAHQ7S9mPR5AY71EVNd3k9PisEwRyXhgRiSTUptymiwosbEgkXi9W0kmbwiyK2+EFhbB3vwW2HjxcPcbFkWIRAtRkBFLe2Thl4GFkA1HppMm5kqbRIbJ2VGG1sjjm3rEoQ6GVUdPiRkMdMMl6iAXyFIP10zO4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KoprB8mx; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=isX+w1aFzVbrn4Ce/5g4IRvZrErGccZqzEtiZvEOUeY=;
	b=KoprB8mxeXimFmXxZztGdBzZMgr3tlMB2BKekvN9qZ+dnvZKlU26qQSsOGfJWdq7Uw5ut9
	Cf1JLuLQ2BfZ9ZrfB9D7gigjHSXQDOaWS0QXlJQHsxG1F1oCZpMsqGVR/+R7kU+LhGMxjf
	mbBuMsHH85j9krbvOhWwgtnlx4ir3Ao=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v4 0/7] Add kexec_file support for LoongArch
Date: Wed,  3 Sep 2025 11:00:53 +0800
Message-Id: <20250903030100.196744-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

This patchset implement kexec_file_load() support on LoongArch.

This patch series enables us to load the LoongArch vmlinuz.efi(pez) or
vmlinux.efi(pei) or vmlinux(elf) by specifying its file decriptor,
instead of user-filled buffer via kexec_load() syscall.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' options must be specified. kexec-tools needs to apply the
corresponding patches. These patches can be found in repository [1] and
will be submitted to the kexec-tools community later.

The basic usage of kexec_file is:
1) Load second kernel image:
 # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

For kdump:
1) Load capture kernel image:
 # kexec -s -p vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Do something to crash, like:
 # echo c > /proc/sysrq-trigger

Link:
[1] https://github.com/tangyouling/kexec-tools/commits/main/

Changelog:
 v4:
 * Add the character "kexec_file" to the command-line parameter.
 * Fixed the issue where kexec_file failed to load the KASLR kernel
   startup.
 * Modify the member name of the loongarch_image_header structure.
 * Modify the patch commit message.

 v3:
 * The ELF format kernel loading should not use loongarch_image_header.
 * Separate patch2 into an infrastructure patch and an EFI support
   patch.
 * Adding that kexec_file cannot load non-relocation kernel comments.
 * Some minor modifications.

 v2:
 * Merge some patches.
 * Add support for ELF format images.
 * Rename kexec_image.c to kexec_efi.c .
 * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
 * Some minor modifications.

Youling Tang (7):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add preparatory infrastructure for kexec_file
  LoongArch/kexec_file: Support loading EFI binary file
  LoongArch/kexec_file: Support loading ELF binary file
  LoongArch/kexec_file: Add crash dump support
  LoongArch: Automatically disable kaslr when the kernel loads from
    kexec_file
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |  10 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  53 +++++
 arch/loongarch/include/asm/kexec.h         |  13 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 114 ++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
 arch/loongarch/kernel/machine_kexec.c      |  37 ++--
 arch/loongarch/kernel/machine_kexec_file.c | 244 +++++++++++++++++++++
 arch/loongarch/kernel/relocate.c           |   4 +
 10 files changed, 569 insertions(+), 13 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.43.0


