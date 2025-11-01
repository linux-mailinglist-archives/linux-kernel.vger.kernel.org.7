Return-Path: <linux-kernel+bounces-881441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33418C28366
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F72A3BA5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE11F2773C3;
	Sat,  1 Nov 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF0EYwGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22158275AE8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016151; cv=none; b=kzyAIJTqwEq2Vr/+St8SXqNopPxXXkktKNUcLUH1zrS5uc/54WOTqyM0s5EWROWS/U+VjL+1QYpJlj96eEJInmMy8n9zef5yL20k0/8xL7DrN1LZWNqINHrDTi32F4Cobo2u4iz3f+arJZtdY78dQf5stMTBX+6xvQoIDdVjXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016151; c=relaxed/simple;
	bh=sP80vbxc0GNP/r5uXwFDomQ23UoJ4yroWxjXP3XmNMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ivcen8YQ3oEBBM5pGBLalJiziDPZVwOiqtrcpFggfSDKH806Ir91CBNhgx8T7tHVeW6+yt0eLfXaUUKcogqQLBsJdiUbYrA6Ds8PqGCIKdwfhDg1iA3ca2r16bMxpDKgcinh9R+yus5UJGvzqQ6i+oJ+9/HlZXYGu/L/zm282rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF0EYwGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5712C19421
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762016150;
	bh=sP80vbxc0GNP/r5uXwFDomQ23UoJ4yroWxjXP3XmNMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RF0EYwGkYWAviePjW7xN/OJRvwNhbqV1hMMNIs20gYmgWjrUhX3VTiMTlz9ZOCZ5B
	 NXQkgiqk8kYiwPDsvTA0VFMALLKyf5rQdgj/CBG1sTE15ccibfrhS1g63ZlKX1lHKM
	 7UL3/hfHnLT5czan5cp/tcrvWDt4uWQ6UuGsdc+QEdMaz7s1qTGKGYYXQJYBe6vVca
	 z1o0oo3gMr4PFJwzcE+qRl/dEms8SbUHTB8ZwVA2Uf/IDxdQO9JDrNb7/WRWaVtzGH
	 71Lh5gelYwPa5qTi/Hg3BmeOn0k8gVwdT2WJ5JcjHGb8oMfT8U2c1Ut/j9b0mZ+sFJ
	 GEsrrsx0XoT7g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378ddb31efaso36250181fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:55:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkyl57fcQK4zTYjPcxuPMImLa/BeIQTAlEazr/IoujkZOuPjOF6qrZ7hJ1zAs2Hq4gpVA5SqWNgsEnYmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkE3vH5R6UTf5muN8I+Q2WgWwFzl4m8V7nIEDoanHC+d8+MGc
	9/ZJsTmmZbj03QezJ13u5Z9EDqo4ZIoo22OfXe4ES5u5dWh/bnjJK5dvMUQC22FtOs69j1ZwCA2
	kB6gsDbPvOoa5Uj9ExQOsr/NnIB1Zwgw=
X-Google-Smtp-Source: AGHT+IFzm6byOVEcoCYQ/cLxtsweQADoRZYzXMb1uWfsMHcHS2qxBFBPxKTICmebgyez5+m6RGoVxWrnW9Pxli+8r4A=
X-Received: by 2002:a2e:b8cb:0:b0:37a:2c7d:2d69 with SMTP id
 38308e7fff4ca-37a2c7d3241mr5473091fa.40.1762016148544; Sat, 01 Nov 2025
 09:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
In-Reply-To: <20251101-kbuild-ms-extensions-dedicated-cflags-v1-1-38004aba524b@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 1 Nov 2025 17:55:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGy8s7Cc=aycKymv2d5wEZFL5J5_HxWyMb-QYDXkUrU9Q@mail.gmail.com>
X-Gm-Features: AWmQ_bnURnp_FaiKs8-FENuEErFxDHIc7i6dKr7lAYFTzEG_ElUiaSBCxPBJiyA
Message-ID: <CAMj1kXGy8s7Cc=aycKymv2d5wEZFL5J5_HxWyMb-QYDXkUrU9Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add '-fms-extensions' to areas with dedicated CFLAGS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org, llvm@lists.linux.dev, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 17:36, Nathan Chancellor <nathan@kernel.org> wrote:
>
> This is a follow up to commit c4781dc3d1cf ("Kbuild: enable
> -fms-extensions") but in a separate change due to being substantially
> different from the initial submission.
>
> There are many places within the kernel that use their own CFLAGS
> instead of the main KBUILD_CFLAGS, meaning code written with the main
> kernel's use of '-fms-extensions' in mind that may be tangentially
> included in these areas will result in "error: declaration does not
> declare anything" messages from the compiler.
>
> Add '-fms-extensions' to all these areas to ensure consistency, along
> with -Wno-microsoft-anon-tag to silence clang's warning about use of the
> extension that the kernel cares about using. parisc does not build with
> clang so it does not need this warning flag. LoongArch does not need it
> either because -W flags from KBUILD_FLAGS are pulled into cflags-vdso.
>
> Reported-by: Christian Brauner <brauner@kernel.org>
> Closes: https://lore.kernel.org/20251030-meerjungfrau-getrocknet-7b46eacc215d@brauner/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I am taking the original '-fms-extensions' change [1] via a shared
> branch in kbuild [2] so I would appreciate acks. I plan to finalize that
> branch so that other maintainers can safely pull it on Thursday.
>
> [1]: https://git.kernel.org/kbuild/c/c4781dc3d1cf0e017e1f290607ddc56cfe187afc
> [2]: https://git.kernel.org/kbuild/l/kbuild-ms-extensions
> ---
>  arch/arm64/kernel/vdso32/Makefile     | 3 ++-
>  arch/loongarch/vdso/Makefile          | 2 +-
>  arch/parisc/boot/compressed/Makefile  | 2 +-
>  arch/powerpc/boot/Makefile            | 3 ++-
>  arch/s390/Makefile                    | 3 ++-
>  arch/s390/purgatory/Makefile          | 3 ++-
>  arch/x86/Makefile                     | 4 +++-
>  arch/x86/boot/compressed/Makefile     | 7 +++++--
>  drivers/firmware/efi/libstub/Makefile | 4 ++--
>  9 files changed, 20 insertions(+), 11 deletions(-)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

