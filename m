Return-Path: <linux-kernel+bounces-776992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4AB2D3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DF758446C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005EE2C21FC;
	Wed, 20 Aug 2025 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AEh2Np3O"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C132C11DD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755669461; cv=none; b=gk5UiynbyJGR0Yrl05DXUOQkPgFEFIem7mWZbZEt6SFS4VYNawO5kx0BY9TYr/gximwk8jWKRORGP4dh2w9qZTK1yNQCAm4h4AV1dco5P48rLq06QHvu4rLN4H21HekRyCZKreIULpKddNug0JUMwWNC61wE2fmnn402VTQYufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755669461; c=relaxed/simple;
	bh=5WVSSBW/HOjzUzX3mU5w5ItKnTvEL+AwWRxnfZ9paXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcnbZ+9MfJO0duoFlbJxZI6l+sreLrW6UiuYdWyWg2hWKcYemSQ03nAl7HtFKK2OHouEQhW7OftIfVgIp63sGbfDdlS+keYzTGknHrQrUk1T2KcNN1K40t6VX8BV3Alg98GIEmUfFP1CcZ7Xc4J5qtt0Ja1J0w4JWB+HT4JzdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AEh2Np3O; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IX26plY5Uf29k5UnA4HhqtwDMo5fxBKoNIkZeiD/EKE=;
	b=AEh2Np3Oz59nRp6/JITqRY8s8f8om5cxv0JtivD/ElFl6AgojeMV5ozdg6pMHUmeDwofC8
	FvnqQpIgkN+EPUWW0LVcjaWFrKzos/SchN+hfv+yGxZzXh2Jbiuvc+VZHIYS0wY4OWFzZJ
	TAOaUH+mBqNs72xkVDJkKoCJ1agSHx0=
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
Subject: [PATCH v2 0/5] Add kexec_file support for LoongArch
Date: Wed, 20 Aug 2025 13:56:55 +0800
Message-Id: <20250820055700.24344-1-youling.tang@linux.dev>
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
 v2:
 * Merge some patches.
 * Add support for ELF format images.
 * Rename kexec_image.c to kexec_efi.c .
 * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
 * Some minor modifications.

Youling Tang (5):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add kexec_file support
  LoongArch/kexec_file: Support loading ELF binary file
  LoongArch/kexec_file: Add crash dump support
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |  10 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  57 +++++
 arch/loongarch/include/asm/kexec.h         |  13 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
 arch/loongarch/kernel/machine_kexec.c      |  33 ++-
 arch/loongarch/kernel/machine_kexec_file.c | 235 +++++++++++++++++++++
 9 files changed, 555 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.43.0


