Return-Path: <linux-kernel+bounces-762999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5FB20ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E94188261E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2742EA745;
	Mon, 11 Aug 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="ChgTAk6L"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAE24DCE6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925506; cv=none; b=jwzd6TxHsbEKuW8qQ9Metm+xAXgC+DdQWPS3wShqqfYkqSVwH78/3KRktLtPo0QdxITbfI3jlrQiEZDyeYKBEootY7Mmqpvc6PAd5EqvDRmksBbQwE93Ek0pk5iu2EmlyjBXwajZCI//Riu0QOnJfXxVrMtrwbJ7h5wE3vfg3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925506; c=relaxed/simple;
	bh=lopUpO8AlILP6yQA7eYjzAMv6pOdDrGS1/G4hb0eS2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZrw89nua5XAV9x9eP2PlMuFW2tV6oYB2c3QIMRvQabCTK4WY/+P7wikWF0ioPmmVt1+hUKucsojVP7tVov3WE8uSvQ+ihQtJ6zjf2loX6O783z/QJeHOQrLsBVBSABUrl91eUcd6K0X1m+DLNBVUrY/bqsyundNd1tHMksl8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=ChgTAk6L; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-88ddbdfc234so3328738241.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754925503; x=1755530303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3cN83hbz3/wbXvsSgM9D9acZ78Ipe3e/zyObUe8NXs=;
        b=ChgTAk6Lb5wcA8bZQSglJyGuf52ali+OtyzYa1pOjurJy2G5zcNBj+slkIcZRvPyXK
         tqEEsL1EjTPteXudPPNnTBOpphx1lWzsgg7OlnzeUrI5XYCkotZ/H3RgQXntRevXMQI/
         eZcr0rqxopfdwwsaqb5aMb8e62Hz3JpYIWOLNGVS5TwY/xPKW8apCUWjSnMcr6BvT4DR
         43jXy/UZCtm9bkZeXHzfIpBn3LJFQwpkj3Q50hylvxiF0/vPULBSIecICHDhkE28OF3V
         0wFOPWRYgeCgYIgyJtL3hGXhsD7Bfye14fZUNl9HbIUX1qLPm3AWXg1fC7KndULXpQC0
         VRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754925503; x=1755530303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3cN83hbz3/wbXvsSgM9D9acZ78Ipe3e/zyObUe8NXs=;
        b=ZMM7kFgzMlpBmC0Y1D+iGO6eoq2+3uV1T80SDN0yXpId45L41lMBWau+QsgejiEqg+
         ZiqNEG5O6PbXnvsN1wSWX3MSMezRxRPei6AAIfMxK+O1BrOk9zqTNaxC0fstmXYD+Fzm
         mMd4TUc4+LbNPd5A4vq1xS/spOMdXV2ntwM6qEzLtBHE6TSryAa8vlhPqOttZBiCNIrI
         13iuzHdu23nKqE4Nl9/6P+xhUFx4MYML/hg5FPWctHOfg3KVhruI+dzuPAUq4SuxlcT4
         nR/R7/jBmghMitrQ0JEf7qbQOCMKO876sbZwpL3hDAoctO9zHdrdRYojd09hNOpposYO
         EcBw==
X-Gm-Message-State: AOJu0YxU3KsE6L2K1XR4lm6uiPdmUDfuo3mb5NXQK/GsqugqVmIVOjIc
	zBBaoUdYajGtMp72dIZTx3JpOmXAGa42YbZIeW+CdSZ4NTtA4wLNWyVklfMGz9eSAl5hDJRr/1E
	GIKUoFCX36ILW5fwNE33OCfKEBdYG/0hSGY15yeC63g==
X-Gm-Gg: ASbGncuhqkc69KNaYpkmJoa7x8MY2FBxeoNkGaOKRMkF/5+svZdGS26ID1dBqR/M12K
	ukFBo4azC8okNUsGWjbB45RQYHgvhCoWRdIiOLzBdQV7kEkR5IvqsHKVFLMAR5l3a1pAHWdYzrK
	wx5tX35NeHiANar83YCK9uTSbjSOP25yGKkzhgizWSJRGBMvztZkXVOVdUpMI6xfHQNZG0fMgDK
	GLTwRsQ
X-Google-Smtp-Source: AGHT+IEAyZ8rG3/BvdqEccF5il/zjHHBwHC2+zGGHvDSgxR6itSB9skJJt0JgvxBTy87l0X7786rmTyB8gLzGZDp05I=
X-Received: by 2002:a05:6102:5108:b0:4fb:dd4b:26cb with SMTP id
 ada2fe7eead31-5060d49ab6bmr4535085137.8.1754925503023; Mon, 11 Aug 2025
 08:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811063352.1770-1-wangfushuai@baidu.com>
In-Reply-To: <20250811063352.1770-1-wangfushuai@baidu.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Mon, 11 Aug 2025 08:18:07 -0700
X-Gm-Features: Ac12FXxXyEahCu3pp1aY4hKwnpItf8sYWxyu9pOb6rZA0mGYeIFUty9bJ1jWqhw
Message-ID: <CALSpo=b4dO3B=U5+cfc3P0NnrtMf7_FJv6+vOPHCS_ezZR2XJw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Use for_each_online_cpu() instead of for_each_cpu()
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ajones@ventanamicro.com, cleger@rivosinc.com, 
	charlie@rivosinc.com, evan@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 11:34=E2=80=AFPM Fushuai Wang <wangfushuai@baidu.co=
m> wrote:
>
> Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
> more readable and equivalent for_each_online_cpu(cpu) macro.
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  arch/riscv/kernel/unaligned_access_speed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kern=
el/unaligned_access_speed.c
> index ae2068425fbc..5e11b1bd9b2a 100644
> --- a/arch/riscv/kernel/unaligned_access_speed.c
> +++ b/arch/riscv/kernel/unaligned_access_speed.c
> @@ -150,7 +150,7 @@ static void __init check_unaligned_access_speed_all_c=
pus(void)
>          * Allocate separate buffers for each CPU so there's no fighting =
over
>          * cache lines.
>          */
> -       for_each_cpu(cpu, cpu_online_mask) {
> +       for_each_online_cpu(cpu) {
>                 bufs[cpu] =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_O=
RDER);
>                 if (!bufs[cpu]) {
>                         pr_warn("Allocation failure, not measuring misali=
gned performance\n");
> @@ -165,7 +165,7 @@ static void __init check_unaligned_access_speed_all_c=
pus(void)
>         smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
>
>  out:
> -       for_each_cpu(cpu, cpu_online_mask) {
> +       for_each_online_cpu(cpu) {

Good find.
Reviewed-by: Jesse Taube <jesse@rivosinc.com>

>                 if (bufs[cpu])
>                         __free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
>         }
> --
> 2.36.1
>

