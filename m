Return-Path: <linux-kernel+bounces-826191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08867B8DCC1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE83117D697
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E429E11A;
	Sun, 21 Sep 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLZ7+1rE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF302AD1F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758463417; cv=none; b=JfW6NzRjtr2ect2APzokfrS/Y5gVgBHmUtG50QffQxPnySwmgsXqWBgEpG1nMRdEokOGitOHVEyGMtKB3dcdVhIO6bZEaTOYHC7+gum5IkdKUaFI0UnY4Eaum4bXr3tf+IJr5pu9FPN9viGb4WxQXfwr635s+aLPOfIo4uckaB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758463417; c=relaxed/simple;
	bh=Dii3XVV3GqFGsvIpQHJXuB3JBENZx3cw7QxToan9g2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiQ25vbrFUBO9VC1OECJf4rHvetnX9eBNMlegkS1gZSLop0rUEfvnlK8jFEx0Aa++c0/oSERFy5ogYj6BcHtI/buFNB7vQdxptY4teC8LVFooRYQ6wF5qQwtCiRJE4uhNjp6Jcz7WkyEOXCgay5K7/oB/cCMGu5S6Fnd/9/TO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLZ7+1rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACAEC19422
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758463416;
	bh=Dii3XVV3GqFGsvIpQHJXuB3JBENZx3cw7QxToan9g2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GLZ7+1rE9YpZL9dDgv4EWsCmZtrfxY9jZ01tUHgxjrJzPBSEoeHMukNsYJTId3qzo
	 2XSMzvOkX1C36xp8+iXOUYul+NiR/W55AxzHiko6LlnVr6uKQByrwO0hvK7UB86jjE
	 57q2GDg+YZUNmknrJe9o+8IjrJUTRCr8GsiwTb/sCrUbCw42XBGOEuQiAsZPAzqcRR
	 svOXjyWynn+8zl4s1zWql2bCFPTwHLWUFniv2SQ0j0Y7TYaUBNuJkIQUmD6pZCq3W/
	 Gh6XjssCZOS8Qr6zItak+VNVkLJIelavMq/gQSNo11he3Kd4cxRRXozqZUegKf1Mfq
	 /B6b8P0eN++rQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b256c8ca246so410158466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:03:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWoTNM5xsFd3dLOcZABwBF3JM4DgJR8xSmTz1IcxYzmlvA7Hp6gx6wsMTiLuNQVezrgDylvw7xpbjitUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF1ktL0iVzP5Qg7k1hWknTo+0+fNIjDqFSE/n7h9hfwMlZ3Xa3
	bOAt6CTJEJ9EpOBn0x9vkm1Ex3IOvzj+rbg+lNkiBOpPCpkBBCRIaaIAxBR+rTUBBKYD21kpWjC
	GPnpXO8W7y4JGRl7zPwhXjkh6orK0ORk=
X-Google-Smtp-Source: AGHT+IEJY9pRCOQ9ba+DERLtt5IlKiSfTxj+DOQMubiAwVQ0XJ0uKpMlJPHMt7g8wlCII+jXBu1TfMjByYNPDasXSXs=
X-Received: by 2002:a17:907:9449:b0:b04:806b:c612 with SMTP id
 a640c23a62f3a-b24ee6ef5c6mr1122778866b.10.1758463415400; Sun, 21 Sep 2025
 07:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903030100.196744-1-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 21 Sep 2025 22:03:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5LnRruyzdxR26Sopot4HoAwsGJ=kQKr4D=gRmW4t1R0Q@mail.gmail.com>
X-Gm-Features: AS18NWDUaq5tytPXMFw7v4wdbczyDPhFJ5b_iiVJqz7-XJetSXZrcs_y8_quLOw
Message-ID: <CAAhV-H5LnRruyzdxR26Sopot4HoAwsGJ=kQKr4D=gRmW4t1R0Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Add kexec_file support for LoongArch
To: Youling Tang <youling.tang@linux.dev>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>, Yao Zi <ziyao@disroot.org>, 
	kexec@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied with some modifications. You may need to test whether everything is=
 OK.
https://github.com/chenhuacai/linux/commits/loongarch-next

Huacai

On Wed, Sep 3, 2025 at 11:02=E2=80=AFAM Youling Tang <youling.tang@linux.de=
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
>  v4:
>  * Add the character "kexec_file" to the command-line parameter.
>  * Fixed the issue where kexec_file failed to load the KASLR kernel
>    startup.
>  * Modify the member name of the loongarch_image_header structure.
>  * Modify the patch commit message.
>
>  v3:
>  * The ELF format kernel loading should not use loongarch_image_header.
>  * Separate patch2 into an infrastructure patch and an EFI support
>    patch.
>  * Adding that kexec_file cannot load non-relocation kernel comments.
>  * Some minor modifications.
>
>  v2:
>  * Merge some patches.
>  * Add support for ELF format images.
>  * Rename kexec_image.c to kexec_efi.c .
>  * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
>  * Some minor modifications.
>
> Youling Tang (7):
>   LoongArch: Add struct loongarch_image_header for kernel image
>   LoongArch: Add preparatory infrastructure for kexec_file
>   LoongArch/kexec_file: Support loading EFI binary file
>   LoongArch/kexec_file: Support loading ELF binary file
>   LoongArch/kexec_file: Add crash dump support
>   LoongArch: Automatically disable kaslr when the kernel loads from
>     kexec_file
>   LoongArch: Enable CONFIG_KEXEC_FILE
>
>  arch/loongarch/Kconfig                     |  10 +
>  arch/loongarch/configs/loongson3_defconfig |   1 +
>  arch/loongarch/include/asm/image.h         |  53 +++++
>  arch/loongarch/include/asm/kexec.h         |  13 ++
>  arch/loongarch/kernel/Makefile             |   1 +
>  arch/loongarch/kernel/kexec_efi.c          | 114 ++++++++++
>  arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
>  arch/loongarch/kernel/machine_kexec.c      |  37 ++--
>  arch/loongarch/kernel/machine_kexec_file.c | 244 +++++++++++++++++++++
>  arch/loongarch/kernel/relocate.c           |   4 +
>  10 files changed, 569 insertions(+), 13 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/image.h
>  create mode 100644 arch/loongarch/kernel/kexec_efi.c
>  create mode 100644 arch/loongarch/kernel/kexec_elf.c
>  create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>
> --
> 2.43.0
>

