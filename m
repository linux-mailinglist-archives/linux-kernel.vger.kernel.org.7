Return-Path: <linux-kernel+bounces-852023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D73BD7F62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA64EF63B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5CC2D94AF;
	Tue, 14 Oct 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUpSAt+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EB23817D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427432; cv=none; b=hTC/KFSkjtPN2puNn9iN+3jZaf7/4EaYF6VPGPwP6yGyN/kOpwFL/ziJEoIIkSFHS9zhhL/vWv2ZJ97rJipqhtMZ9Z+xuL5s+/wPSxMOAiBcX6tqeyKLXN4gNRkfKM0LjLH69cbHFeW1uqOxlOKnvuuq/EaaliQmG+82tEM2fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427432; c=relaxed/simple;
	bh=hProa4De93MHpNGZiuwWV3XfuaYyS/n9FFopceUyay0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPa6pVIQP1qLr0uCSwagSNlM+PyVzuHvFJHxW76c4OV7dKg8JXtgPittqCJdN/yrbMVyiSMNNOSORChAIMPiWREivLeLq4k7VqZQq8WI45jiM4Y5pLfajxmqcWP4EpOKIzrBkzhP9y0aSW6RRif+upGeTX9cnztxbHFwKzI7gAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUpSAt+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A728C16AAE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760427431;
	bh=hProa4De93MHpNGZiuwWV3XfuaYyS/n9FFopceUyay0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUpSAt+PAXBzfMtxIyX2upACTdV3FC/tPPYSnG8s19TtDm4B6J7jmRwRwcGlO9mwB
	 o9wsvfS3Lxch0/yH8NIjZVYafSAK+BMu5hjIM1n1hSBkvEOnULAWpHXG0JAnPoLUAA
	 zDgtL7N9ePAlZ2Rw9yOAQEK9JtD27vO4o2KZ8/bF9yI2Gs2D6Q2ilL6odykv8rwyI+
	 SahLoW1erQnkcZvq2+6KZ/lhQswHW6uC2R+mHKWEjV30XTW7Yg+4k/SFiX/1PksmjV
	 avRMqFmqYZ3qGNPJ57br0+95E8eYZd1IsejkaraVzkMVEqYBU8PT+s90leRxE4JlKg
	 VouKOaO0oSGEA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cce534a91so1374013fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:37:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEqAcqMR230D86Vvxo2f8vSqaUn/56hE/vNKfDmHDrOGNC2yqc
	X2P98qHvmSejbKfVBjyfhneADoqfPupwX2PzJPENaVmSWpCLOqULuT125+74L8lpaIF9rlnISgS
	6bwLCU74Sr7g0/JCQVXybdxiNMpzLaas=
X-Google-Smtp-Source: AGHT+IG/dMvHNYRvwpUwXTceftiOC3TIsATtVHIjkV4zfu8OBlyWGYJtKNs7wEN5TcaFfhHgV1hDzIkDPKICbkB79OE=
X-Received: by 2002:a05:6870:df93:b0:3c8:f443:c298 with SMTP id
 586e51a60fabf-3c8f443cc66mr2500479fac.33.1760427430454; Tue, 14 Oct 2025
 00:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013085718.27085-1-bagasdotme@gmail.com>
In-Reply-To: <20251013085718.27085-1-bagasdotme@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Oct 2025 09:36:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5Y+mgT7LuQZOkAf5Ptpf=Gn3U=6XgrXxoe=irQCBnHw@mail.gmail.com>
X-Gm-Features: AS18NWDUSpmp4_I3c-PxBd1LmVKh1y1aJwWS35tYs6OMPZNUeQEUhvAytzGqTJM
Message-ID: <CAMj1kXH5Y+mgT7LuQZOkAf5Ptpf=Gn3U=6XgrXxoe=irQCBnHw@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux EFI <linux-efi@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 10:57, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
>
> Since the Handover Protocol was deprecated, the recommended approach is
> to provide an initrd using a UEFI boot service with the
> LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
> approach has been no more than an admonition with a link to an existing
> implementation.
>
> Provide a short explanation of this functionality, to ease future
> implementations without having to reverse engineer existing ones.
>
> Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
> Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
> [Bagas: Don't use :ref: link to EFI stub documentation and refer to
> OVMF/edk2 implementation]
> Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> No changes since v2 [1].
>
> EFI/x86 maintainers: Would you like to apply this patch on tip/efi tree
> or let Jon handle it through docs-next instead?
>

Please take this via the documentation tree - thanks.

> [1]: https://lore.kernel.org/linux-doc/20250916073244.590483-1-bagasdotme@gmail.com/
>
>  Documentation/admin-guide/efi-stub.rst |  3 ++
>  Documentation/arch/x86/boot.rst        | 38 ++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
> index 090f3a185e1897..f8e7407698bd2a 100644
> --- a/Documentation/admin-guide/efi-stub.rst
> +++ b/Documentation/admin-guide/efi-stub.rst
> @@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
>  which understands relative paths, whereas the rest of the command line
>  is passed to bzImage.efi.
>
> +.. hint::
> +   It is also possible to provide an initrd using a Linux-specific UEFI
> +   protocol at boot time. See :ref:`pe-coff-entry-point` for details.
>
>  The "dtb=" option
>  -----------------
> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 77e6163288db08..32eea3d2807e1c 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -1431,12 +1431,34 @@ The boot loader *must* fill out the following fields in bp::
>  All other fields should be zero.
>
>  .. note::
> -     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> -     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
> -     loading protocol (refer to [0] for an example of the bootloader side of
> -     this), which removes the need for any knowledge on the part of the EFI
> -     bootloader regarding the internal representation of boot_params or any
> -     requirements/limitations regarding the placement of the command line
> -     and ramdisk in memory, or the placement of the kernel image itself.
> +   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
> +   entry point described below.
>
> -[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _pe-coff-entry-point:
> +
> +PE/COFF entry point
> +===================
> +
> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> +implementation details.
> +
> +The stub loader can request the initrd via a UEFI protocol. For this to work,
> +the firmware or bootloader needs to register a handle which carries
> +implementations of the ``EFI_LOAD_FILE2`` protocol and the device path
> +protocol exposing the ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.
> +In this case, a kernel booting via the EFI stub will invoke
> +``LoadFile2::LoadFile()`` method on the registered protocol to instruct the
> +firmware to load the initrd into a memory location chosen by the kernel/EFI
> +stub.
> +
> +This approach removes the need for any knowledge on the part of the EFI
> +bootloader regarding the internal representation of boot_params or any
> +requirements/limitations regarding the placement of the command line and
> +ramdisk in memory, or the placement of the kernel image itself.
> +
> +For sample implementations, refer to `the original u-boot implementation`_ or
> +`the OVMF implementation`_.
> +
> +.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
> +.. _the OVMF implementation: https://github.com/tianocore/edk2/blob/1780373897f12c25075f8883e073144506441168/OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.c
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> --
> An old man doll... just what I always wanted! - Clara
>
>

