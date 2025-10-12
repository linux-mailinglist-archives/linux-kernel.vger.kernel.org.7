Return-Path: <linux-kernel+bounces-849386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88FBCFFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 08:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53DC3348DE9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 06:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CED213E9C;
	Sun, 12 Oct 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzU84/YN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858878F51
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760249516; cv=none; b=SLl89VThzTrgam9KSQW4JkkLOTgGTVh9Kmx7bVrXTfEZPKIE+EdXPIbTf9DtuVESewXudh5IxrFShouE5eQyh3JHxV8HkYy3mjIOMJjZn8Ecc2waOrlu2bKMaIRcWvP+k1mv75jFpcI4esVpO1lPf4SzRTwK8fhmje7K6awUYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760249516; c=relaxed/simple;
	bh=5ola3YDxnYdWqEmDLUEc5xfcVUT9cazJU910mw2Lbgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR2uZkgzWLNXe/aPeBHg8WYykq4tbSR0wZ166EXo/fmPHsUrp8s9sHmYzopb5AZBi6ojeNS1y4DEiVENeZxpQMa7Yn1dzu2/ON3OoQ+FYFuC8lGR6SAxxEPuP/stMbEumuC5BE0APLVZ3UpgmZdILBZ6m5EjfhIYE/onwjb+BjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzU84/YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80101C4CEF8
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 06:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760249515;
	bh=5ola3YDxnYdWqEmDLUEc5xfcVUT9cazJU910mw2Lbgs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rzU84/YNrD2fWtDD/A8jNqlT+n3IknG2aNgbHc30iBGsUbymW8vDEQhzCFIN0qj5V
	 WfJGTL4YjoEA8I+BPMe1Jw6AccxJjU1UgC6bnuylNFw4sEWDu0X6Q3M98FdXcBFBzj
	 6SHJegyUA0VZjmnKoj1C8Un0FEoErYfRkM6pcuR6WMF1ULhkQrKx9AzK7qupKPE/WH
	 JpHGZrNYSCGqZ9eEy9C5K28Dtf9xnxkCM0zQx7FPQsQPBmI/mgn7owmH2zmLsxfkoL
	 hDmmByqEhiorgZIpgMy3LPLyYyTRRSdpOpavoT6jLBCGxxkPBWmJkMPy1MA8CHy0cD
	 XVOFlbuPhneMQ==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e2e363118so26730845e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:11:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV42RYu8kQxklpXSdM6uD5tJys0qC0teWRe2YPfpfCPJ4zzaSVus2rNuSvA3s9eCuvLX2l+vMyyCieOxVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDu2nURjgEej2XWM9rdqwvsMnE2h4MfB9byVOGTencxF5MvBU1
	GGl2gccurTh4RpFETAcRtKmKYYEg//MLd8c3b7B8EVQv6Fx6NIK1dAnFnKNdIxzPhaY5adBemoS
	xxrdmoj8xElW++whDDrj/G8waIvrALNA=
X-Google-Smtp-Source: AGHT+IEKlteG9lfVBg9j7ASH6OTe/Dfj1NndFuZm+KdXyn0SVroBvLiRXYmPyV6peIPu9DVdV+AM6j/uCc8jUqMSTVQ=
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-46fa9a8638dmr118651305e9.2.1760249514038; Sat, 11 Oct 2025
 23:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155746.1558731-1-guoren@kernel.org>
In-Reply-To: <20251011155746.1558731-1-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 12 Oct 2025 14:11:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEGWrw9ERRLYYA@mail.gmail.com>
X-Gm-Features: AS18NWCt3-Wrv4mHE1rXWP8VmFtwVh1Eop_f8YJ4Ep4VwD8YYMjDGc5QM5wrH6o
Message-ID: <CAJF2gTRfLzrqHoYrexS55AT3sjn5VbbNKf2WMEGWrw9ERRLYYA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add pgprot_dmacoherent definition
To: samuel.holland@sifive.com, david@redhat.com, yongxuan.wang@sifive.com, 
	cuiyunhui@bytedance.com, luxu.kernel@bytedance.com
Cc: paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	palmer@dabbelt.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Anup's patch has solved this:
https://lore.kernel.org/linux-riscv/20250820152316.1012757-1-apatel@ventana=
micro.com/

So, I abandon this patch.

On Sat, Oct 11, 2025 at 11:58=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> RISC-V Svpbmt Standard Extension for Page-Based Memory Types
> defines three modes:
>
>  Mode | Value | Requested Memory Attributes
>  PMA  |   0   | None
>  NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
>       |       | main memory
>  IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
>       |       | (I/O ordering), I/O
>
> The pgprot_dmacoherent default uses the IO memory attribute if there
> is no asm definition, but IO is not for main memory according to
> Svpbmt rules.
>
> This commit corrects pgprot_dmacoherent with the NC memory attribute,
> which satisfies performance improvement and prevents using the IO
> attribute to access main memory.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 29e994a9afb6..2a84479de81b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -654,6 +654,15 @@ static inline pgprot_t pgprot_writecombine(pgprot_t =
_prot)
>         return __pgprot(prot);
>  }
>
> +/*
> + * DMA allocations for non-coherent devices use what the RISC-V architec=
ture
> + * call "Non-Cacheable" memory attribute, which permits idempotent, weak=
ly-ordered
> + * (RVWMO), main memory. This is different from "I/O" memory attribute w=
hich is
> + * intended for MMIO access with Non-cacheable, non-idempotent, strongly=
-ordered
> + * (I/O ordering), I/O attributes.
> + */
> +#define pgprot_dmacoherent pgprot_writecombine
> +
>  /*
>   * Both Svade and Svadu control the hardware behavior when the PTE A/D b=
its need to be set. By
>   * default the M-mode firmware enables the hardware updating scheme when=
 only Svadu is present in
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren

