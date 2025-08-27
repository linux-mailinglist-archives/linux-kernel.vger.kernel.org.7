Return-Path: <linux-kernel+bounces-788104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D598DB37FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B51B683DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4834A321;
	Wed, 27 Aug 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhYxiaaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12933321425
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289889; cv=none; b=eYcWVKlACf3Fe6yNPZxBF7C6NlDmIanYV8XtEMxeTMuR3tVUffyt+FAII+9qSZvl9NuiR1tWj4c6iZyKIMUSdTvVhCe4SIKr8bcgNLJA0oEQKFlj4jIB45jElG0Up80e/QCJdkIjLDWv3/fZcA6T9e2SlKsoy1Lpg9RmiQXRoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289889; c=relaxed/simple;
	bh=2QgysAeAv4Fx8NZcG5VTBdcdLTbyERQ6pDohcn5Qh9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3Yq1UMyEjXUXJEyvXgwa2T9aaF6nFkO2S/vzdWwGG+lpE3o5P7T+q2WZJtXh5PoIrbq13jqC0ahjn6KdBTkEEZr+8ChBaStGi+rvbBZgMTe9eFThrVCoeMZKh+rFTyQ9CQ/33u+bKE8vQoZ1KrDCe/NpDt/1ZqOzekJAL1M/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhYxiaaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1238C116C6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756289888;
	bh=2QgysAeAv4Fx8NZcG5VTBdcdLTbyERQ6pDohcn5Qh9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mhYxiaaEN2dwPC1qSEJt4uM1aSvFjakNmLWqjOXsyE1VNvpruF3v+ly9LtCXRtt3O
	 cZlvamC0xs326zTYNsshL3h9Vk2sffuec2YVXPhpvnwt4vwMre/LU5WAmHY/cfy2DA
	 LX9/i2WgE+WNEmQQh82UtMF1FiIXVMpbqXU4b7P+F+TWcLGpIjhd3VAW8t077VEK+c
	 VzXnDl+x+PYcswHqJyL962HxzS++q5Cjc6hZdwhcX+Ts2dit7ARM+ugmP1AZA/EgFq
	 /MHmY4GoW7BiLQkJXCCSN33Q3F/8g1XOkPwzJjvuJGB+dm3h8TTh4G+OAKu3aGVtru
	 k20V94vgShxMA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61c3360bbaeso5468677a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVouYdgfcOp9ISdPw9/FYatZGJokc0Z/7q9Y6bfkZlauNO8p/FEk0uMciSGRF53L8kegpdJHcQle9ohi6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQtYYk+9tbj78OLmcwAy7YAxybbKPBS2bbuk4bHn7mh3DP1dR
	zANwdPdZDAQubcOuxFzGOnR7Hja/N3Kjl8pOMZOSXiDyyBfzXyEZ230f2AtKoukypSNB09ba01h
	R9AgQCUxW11i7C8GixscTz6b154OZwEU=
X-Google-Smtp-Source: AGHT+IGK3BfC8RRIrj7re1nqlK8QPZ17Lm2SFwVMLkmJgHyFGuzPTSLAqIG0ubvo0jWejR2dR1DfZY3y6MyugUF/UuA=
X-Received: by 2002:a05:6402:5194:b0:61c:93fb:a33b with SMTP id
 4fb4d7f45d1cf-61c93fba6f5mr4093109a12.21.1756289887378; Wed, 27 Aug 2025
 03:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826063956.6950-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250826063956.6950-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 Aug 2025 18:17:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7qjHk_E_SvM-OqRKiasvykoM2bjLJObCCDs0kbDSS3Vw@mail.gmail.com>
X-Gm-Features: Ac12FXznGeTE9uR7hSBOzXOsLDfCMpUBEKu3M0aWkOfm39tZzLqTQU31NPAPLCw
Message-ID: <CAAhV-H7qjHk_E_SvM-OqRKiasvykoM2bjLJObCCDs0kbDSS3Vw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Handle newly added llsc instructions for probes
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Aug 26, 2025 at 2:40=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> The atomic instructions sc.q, llacq.{w/d}, screl.{w/d} were newly added
> in the LoongArch Reference Manual v1.10, it is necessary to handle them
> in insns_not_supported() to avoid putting a breakpoint in the middle of
> a ll/sc atomic sequence, otherwise it will loop forever for kprobes and
> uprobes.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  5 +++++
>  arch/loongarch/kernel/inst.c      | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 277d2140676b..55e64a12a124 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -77,6 +77,10 @@ enum reg2_op {
>         iocsrwrh_op     =3D 0x19205,
>         iocsrwrw_op     =3D 0x19206,
>         iocsrwrd_op     =3D 0x19207,
> +       llacqw_op       =3D 0xe15e0,
> +       screlw_op       =3D 0xe15e1,
> +       llacqd_op       =3D 0xe15e2,
> +       screld_op       =3D 0xe15e3,
>  };
>
>  enum reg2i5_op {
> @@ -189,6 +193,7 @@ enum reg3_op {
>         fldxd_op        =3D 0x7068,
>         fstxs_op        =3D 0x7070,
>         fstxd_op        =3D 0x7078,
> +       scq_op          =3D 0x70ae,
>         amswapw_op      =3D 0x70c0,
>         amswapd_op      =3D 0x70c1,
>         amaddw_op       =3D 0x70c2,
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 72ecfed29d55..4026edea9bdd 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -141,6 +141,18 @@ bool insns_not_supported(union loongarch_instruction=
 insn)
>         case amswapw_op ... ammindbdu_op:
>                 pr_notice("atomic memory access instructions are not supp=
orted\n");
>                 return true;
> +       case scq_op:
> +               pr_notice("sc.q instruction is not supported\n");
> +               return true;
> +       }
> +
> +       switch (insn.reg2_format.opcode) {
> +       case llacqw_op:
> +       case llacqd_op:
> +       case screlw_op:
> +       case screld_op:
> +               pr_notice("llacq and screl instructions are not supported=
\n");
> +               return true;
>         }
>
>         switch (insn.reg2i14_format.opcode) {
> --
> 2.42.0
>
>

