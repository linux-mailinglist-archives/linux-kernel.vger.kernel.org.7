Return-Path: <linux-kernel+bounces-888462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A22C3AE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E619349F86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0932AAC0;
	Thu,  6 Nov 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILT1IGrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC23191A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432073; cv=none; b=P39blm0imiIgKZzDv2PN7DlPumd0o97juNY7x9tvOv7775S2aMsuz4Ig5oRM6jABfB8QKQbyhlTgorFXb45VvWtL4glq5sya09dudGNHWISBW25vlML7lR7f+pBYvmid6ZEy+B4Ge1P6PmvfhZkmW5ISO6Q4/kl2cEMghC7kOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432073; c=relaxed/simple;
	bh=sm/KEkDKVz7vizhaeMVvJjcOC3jXdbItHDrSAh+s32Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMydll4zvcW5eYSRM+dTNAHrJiG+HT7SHpnuQRJ84+rzE0JuiVaG8IqwaqQRKG0ersanTV6E39XVAU0VgD8PQ+xKZcgW8hzglKekTi77Njea3MWuYbL7RzIxO6HFrqMi/YUN/8ADYODIz8fpsH47REPGiBjk7JlQQCBF1cZJZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILT1IGrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD74C4CEF7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762432072;
	bh=sm/KEkDKVz7vizhaeMVvJjcOC3jXdbItHDrSAh+s32Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ILT1IGrLAYWOfXBvB4nwal/UeIfixWNtXGoFSvifgSWFrxPrHrr+jjvrVDbnxGlTX
	 WNm++JnHuK89c4BGwoIPkzN0CTTYS5eeqZbxtBVBEhRErHK0KwbCfHlS8mHI24fBnW
	 S+wxfCm2DeOC8W7Svxjan4jXILutqd+0I7APAoCLBK1/vQNfMjhq34ahg2QxZU0f2f
	 4BR40Wn2VSQbg0bUoNBF0YrdFemd6Js2Ci4deRbczKwGFBmuUwa0ehwAWj40h8TwIg
	 gth8M5oMAWKvjNPSjV7Z/2Lwtdi4HX3vvrL5228q4UNnwtt4SQ7D+qMf4ERVc7qLGO
	 WK55Mq1NtHIQQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso1417319a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnHY5r0fuLvT9/TeTGP+PY7IqqIpOw//OuU3b4M+8ATRjwNKYoTNMzWWN3V8er7FAb7ymzcRX3zEC6hy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7wOOPWPbkfSxVfI53gd5TJJGDLfWHWfPfFwHe/gxZ8uuY2pS
	Ohb/KNkwpvT4bLDYn8hG0+NlZEsK5loT57lv0ukoZH0J9IHvXV7jaeVX2TrVsCXKq5xyi15Ailw
	eFbB0istxMfu3l109feDrIwIo1xdrUFU=
X-Google-Smtp-Source: AGHT+IFESibQa1gcJX7J+Cs+qz1FciOmFCrI+QgcI9cbug6Igg0lCqc39uumUPK1urXvMah7dkzf3k9m9UonBj3Rkuk=
X-Received: by 2002:a17:906:f59d:b0:b70:50f1:3daa with SMTP id
 a640c23a62f3a-b726564af26mr735644166b.57.1762432071206; Thu, 06 Nov 2025
 04:27:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104114659.1562404-1-maobibo@loongson.cn>
In-Reply-To: <20251104114659.1562404-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Nov 2025 20:27:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5mzkpbZMmxtmGh3S8MAeWnn_Pfe6g-ZqWOER=oeOZNAQ@mail.gmail.com>
X-Gm-Features: AWmQ_blSEGRj-hJ4TXNc9b5AG3hqN2wmBcLXpbd4AuxFaGRrZc68C_g3pt6cP54
Message-ID: <CAAhV-H5mzkpbZMmxtmGh3S8MAeWnn_Pfe6g-ZqWOER=oeOZNAQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Add delay until timer interrupt injected
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Nov 4, 2025 at 7:47=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> When timer is fired in oneshot mode, CSR TVAL will stop with value -1
> rather than 0. However when register CSR TVAL is restored, it will
> continue to count down rather than stop there.
>
> Now the method is to write 0 to CSR TVAL, wait to count down for 1
> cycle at least, which is 10ns with timer freq 100MHZ, and retore timer
> interrupt status. Here add 2 cycles delay to assure that timer interrupt
> is injected.
>
> With this patch, timer selftest case passes to run always.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kvm/timer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
> index 32dc213374be..daf1b60a8d47 100644
> --- a/arch/loongarch/kvm/timer.c
> +++ b/arch/loongarch/kvm/timer.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
>   */
>
> +#include <asm/delay.h>
>  #include <linux/kvm_host.h>
>  #include <asm/kvm_csr.h>
>  #include <asm/kvm_vcpu.h>
> @@ -95,6 +96,8 @@ void kvm_restore_timer(struct kvm_vcpu *vcpu)
>                  * and set CSR TVAL with -1
>                  */
>                 write_gcsr_timertick(0);
> +               /* wait more than 1 cycle until timer interrupt injected =
*/
> +               __delay(2);
>
>                 /*
>                  * Writing CSR_TINTCLR_TI to LOONGARCH_CSR_TINTCLR will c=
lear
>
> base-commit: ec0b62ccc986c06552c57f54116171cfd186ef92
> --
> 2.39.3
>
>

