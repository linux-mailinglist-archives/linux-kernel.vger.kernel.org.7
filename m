Return-Path: <linux-kernel+bounces-772330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC8B29170
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 05:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64CBC7B12E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91B1FBCB0;
	Sun, 17 Aug 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtj5huLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393001F5423
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755402138; cv=none; b=aw26Q1Dl28TCILzZKZTJZBkIvKxmKKuoXRKwmO3ruBRVzQsqX925JRNZpmvSw5spr1BLdARHVtzPuaO7TW6mwNPwPr7zNhF7zNGGRzEFhnH3GYJC1rUMkol5brb9BIp8dVNWmdGPySRZcPtQT7W+V7n9shosgMwP6bS55ku//cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755402138; c=relaxed/simple;
	bh=0RK7oybG39j/BzocNbqy4mpNmNZxOo5/Ezo2Vuk9LOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1/35ACP7oH2ohP2q19YbPehyk4WCUX1Z4+vCotOzeRSiU6D6s8yJbmQ+mIW5PNFZk/n0+eH0Arm2g+FbBzMlpyG6XXkUVJOBoSJkHUGWV3lVp+zRNZi3jeWXeYOaNl1VwhOWxoIIevkiKAlGv7ElQqOiupTtEnKYj/4L5R6Z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtj5huLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4455C116D0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 03:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755402137;
	bh=0RK7oybG39j/BzocNbqy4mpNmNZxOo5/Ezo2Vuk9LOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qtj5huLrqLq9PZqGS9NV2KRNcai63H0aKe1uFpxPvxIiwsZDfQwywOEFdWiRSBxX7
	 spirLkb1pPoCL/R4QVFEQF9IMzc3DJWmqJjoA8gVIReY8K/GpYM9ymiDzSAncztT0Q
	 1w7olO5rLg9O9t44FHWE8cN7MjSgbhipZG0nPKbF4vqf+Yw70dg76ErTeJAuOqvyjB
	 LoZuo1ZcyEmK+qTe9+kZPo0wthgq/DJ8H92d8i1CPOA2041H1J5jPUnqcRsRrOHipl
	 PIppqwPDX2AJcVYHECkrkV8d7Z5mHaUtPBpBfvVtZM/DdBQObdb5cEbtwbUQPf9Kb4
	 K0PETbf902eWA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b5be5deso4040251a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 20:42:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTnbgwXpyvwxNr2slG9hvk9vnQxb4OEFX+JBrbfLtHoFjaHu0n2osIUVy8JQGRxuhDHVreP8odg2BUdVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8LDcsQ/BmI6rt4VWiy1399CNoc6KJboFySf9Qlk6uXlXvzC5
	x16kzPHPgGVs/1EzAh19pKThjL1g1OOSP17ta9bFuUP3e/MxoypalqToUOH+ZmSCUP77hh9BwcC
	E89pVE69aXLom/DRi7NzLhzj3x+ervEw=
X-Google-Smtp-Source: AGHT+IFBem0X5N5rrHNPoyjgpsHEbfGMj4eZD3b4gWF1FzyT3xN0jpZbWjI+FJ9IbxNO86/8kD6wXwUzeSs7qHNdcog=
X-Received: by 2002:a05:6402:234b:b0:617:fe86:6bff with SMTP id
 4fb4d7f45d1cf-618b0513fe6mr6495112a12.8.1755402136197; Sat, 16 Aug 2025
 20:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812122043.2462836-1-wangming01@loongson.cn>
In-Reply-To: <20250812122043.2462836-1-wangming01@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 17 Aug 2025 11:42:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6MunQ7NBcH2gUytoFyQTk8NpaZ9ZoWUyfQrSPmvubBNw@mail.gmail.com>
X-Gm-Features: Ac12FXxjtlZJIyQy_PnuNPhA3GQUv3sGESkFCR9A2gdlrilDcc-u2Q07VvWbo2w
Message-ID: <CAAhV-H6MunQ7NBcH2gUytoFyQTk8NpaZ9ZoWUyfQrSPmvubBNw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Increase COMMAND_LINE_SIZE to 4096
To: Ming Wang <wangming01@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	lixuefeng@loongson.cn, chenhuacai@loongson.cn, 
	Huang Cun <cunhuang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Aug 12, 2025 at 8:20=E2=80=AFPM Ming Wang <wangming01@loongson.cn> =
wrote:
>
> The default COMMAND_LINE_SIZE of 512, inherited from asm-generic, is
> too small for modern use cases. For example, kdump configurations or
> extensive debugging parameters can easily exceed this limit.
>
> Therefore, increase the command line size to 4096 bytes, aligning
> LoongArch with the MIPS architecture. This change follows a broader
> trend among architectures to raise this limit to support modern needs;
> for instance, PowerPC increased its value for similar reasons in
> commit a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE to 2048").
>
> Similar to the change made for RISC-V in commit 61fc1ee8be26
> ("riscv: Bump COMMAND_LINE_SIZE value to 1024"), this is considered
> a safe change. The broader kernel community has reached a consensus
> that modifying COMMAND_LINE_SIZE from UAPI headers does not
> constitute a uABI breakage, as well-behaved userspace applications
> should not rely on this macro.
>
> Suggested-by: Huang Cun <cunhuang@tencent.com>
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>  arch/loongarch/include/uapi/asm/setup.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/loongarch/include/uapi/asm/setup.h
>
> diff --git a/arch/loongarch/include/uapi/asm/setup.h b/arch/loongarch/inc=
lude/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..d46363ce3e02
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/setup.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_ASM_LOONGARCH_SETUP_H
> +#define _UAPI_ASM_LOONGARCH_SETUP_H
> +
> +#define COMMAND_LINE_SIZE      4096
> +
> +#endif /* _UAPI_ASM_LOONGARCH_SETUP_H */
> --
> 2.43.0
>
>

