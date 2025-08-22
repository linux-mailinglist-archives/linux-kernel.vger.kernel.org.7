Return-Path: <linux-kernel+bounces-781085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D79B30D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ACD172B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936428504C;
	Fri, 22 Aug 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJzzj8k+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906D2773F6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836019; cv=none; b=J7s99cJOLHRG9F9q081tMzhB+eFd+HjTZMhQxz4AP8osZMTgA22AiUzXDUZSgeauZ8Iu+wbUiyXj3bg1IwEk+ImbZypxhVcnS8PA2aanUYXgTMYI+ayNzSkeydhW+ZLnRL2/7pxJUI6Bt04X1r2PWwqImY7SyjOHskbjqkC6TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836019; c=relaxed/simple;
	bh=yb76Z7Ykma61gCy+9MNVKgDDs9hMvaduu7vLFLdozcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN7wflLA82fAl9b0jocVBXHrn78FUiVc6vRPeCE+i/oaik98Q03v7tSQji7Ee6PouzJFo2XcrgfhfyyUA0G94cPoq2rEpuOV3IyA/pnWv572SxauaqtAaMOTfA6GnaCgX/v/kauBJbd6oUh5srlGNYBRUNOrIpe0ttS913puBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJzzj8k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE9C116C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755836019;
	bh=yb76Z7Ykma61gCy+9MNVKgDDs9hMvaduu7vLFLdozcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJzzj8k+eyg5znnUWq4fKHUKGoMsHjV3xLGW7k30rL8DTGzo4b9O0S2SL9yEBWtuM
	 sa76DGJTEliGt8Q7mKRW0aGgyRaIkWJ7/Gulb2bgFgzbZw6vU1wglOxcmVNU5KqdSF
	 M9dDiSIYUMXZgU7baK4c8BYQ3mG6sU3kISNznSISYN50ejJSfgj04sPWWz3CD1RFUK
	 wgLWd/wFp4/fc6BWXMAR2esakMFptRpPrDK6B9dp8dK2Gj1R/p5F+FP73LEQXVhymp
	 aX6UMcFbMD9/AdRuMRKBLS6xtHUD2RzOnnkOBD7z8f8l4ulLsDXA3vCBv66TG4GVcm
	 7Km5RRevsidHg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb73394b4so246050566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:13:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGeV4M55Y4jsd+usHlqM4BpdrcNABoUhNmT4NYygFLY5YUDPK1mSVH8Bt4/gUCfTRTTQkE75ghM9vjmkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFkhYSL2EAwnq8lDSxAFe0nlRyL8NcAfPB8bF/c4D5m5jbaL10
	KC+YeTqoUdUE4sylhO9vstuQXtUQQbBkmc+eYAraHmBmB1JOBpgZPlyNRbHQjYi/vza1nyI/328
	hd4cIa9S8n/q1R2syK6Nm/CoYoVU/X14=
X-Google-Smtp-Source: AGHT+IEFuMcrqOC0a5CuS2+a1amqyQQ3UsKWwufqZnldyK0rganAdUmsu3sfje9HY72xiVnlqQSe1dyt3NpW1FUyf7c=
X-Received: by 2002:a17:907:7e8d:b0:afd:d994:cb0 with SMTP id
 a640c23a62f3a-afe294ced48mr137970166b.62.1755836017510; Thu, 21 Aug 2025
 21:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820055700.24344-1-youling.tang@linux.dev>
In-Reply-To: <20250820055700.24344-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 22 Aug 2025 12:13:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H75tsJkHC9DgCOOBbFjbK--B_LRRCP5PcZr6nHqwKHL1Q@mail.gmail.com>
X-Gm-Features: Ac12FXxQ-yitmfFcJhpiv0kKjoJLco4W_rhyVcuIHjasvZBYLMaHXTbBasKgxa8
Message-ID: <CAAhV-H75tsJkHC9DgCOOBbFjbK--B_LRRCP5PcZr6nHqwKHL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Youling,

On Wed, Aug 20, 2025 at 1:57=E2=80=AFPM Youling Tang <youling.tang@linux.de=
v> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> This patchset implement kexec_file_load() support on LoongArch.
>
> This patch series enables us to load the LoongArch vmlinuz.efi(pez) or
> vmlinux.efi(pei) or vmlinux(elf) by specifying its file decriptor,
> instead of user-filled buffer via kexec_load() syscall.
>
> To use kexec_file_load() system call, instead of kexec_load(), at kexec
> command, '-s' options must be specified. kexec-tools needs to apply the
> corresponding patches. These patches can be found in repository [1] and
> will be submitted to the kexec-tools community later.
>
> The basic usage of kexec_file is:
> 1) Load second kernel image:
>  # kexec -s -l vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Startup second kernel:
>  # kexec -e
>
> For kdump:
> 1) Load capture kernel image:
>  # kexec -s -p vmlinuz.efi --initrd=3Dinitrd.img --reuse-cmdline
>
> 2) Do something to crash, like:
>  # echo c > /proc/sysrq-trigger
>
> Link:
> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>
> Changelog:
>  v2:
>  * Merge some patches.
>  * Add support for ELF format images.
>  * Rename kexec_image.c to kexec_efi.c .
>  * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
>  * Some minor modifications.
>
> Youling Tang (5):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add kexec_file support
>   LoongArch/kexec_file: Support loading ELF binary file
I prefer to combine Patch-2 and Patch-3. :)

Huacai

>   LoongArch/kexec_file: Add crash dump support
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |  10 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  57 +++++
>  arch/loongarch/include/asm/kexec.h         |  13 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++
>  arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>  arch/loongarch/kernel/machine_kexec_file.c | 235 +++++++++++++++++++++
>  9 files changed, 555 insertions(+), 11 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/kexec_elf.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.43.0
>

