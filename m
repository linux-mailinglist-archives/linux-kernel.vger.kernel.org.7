Return-Path: <linux-kernel+bounces-781757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45BB31649
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1671BC88E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E202327A3;
	Fri, 22 Aug 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="uczrKuiH"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D82D249A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862147; cv=none; b=OuK/abXgDA1YwVK6l5rYgvD8kMyN//J53EjUeo85LE0eb0jyRifiv6vepxyNt6ypFJ62Y9UDZfxElZ3ViNfmpOagP7bJ+b5dqnQfkDvyG4Ir8mhDjKTPkRjq00prZBi6+NP4w4wjFoPx+TgynmRWMohSr/tj72VFsnSAR/zFaCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862147; c=relaxed/simple;
	bh=74WLWB2wpFFNY5jfwXbte9fVpaHxcpj8qGdUfhbQV/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsFLm2SvAZY9CYrxiGWjkbNk1SINzL3xQHQgmNKOW/LnXCFSlCAZ4lMfnBPSnv5izg3NQOXfvdZsnX07iibY9gG5D0s8/PORxDtnBe4sBQ8qsEQABaRBZ955hb49Z95u1Kx4xwZ8U6L8SBiHq80NAofUKlDj6HtTVpF56ToYcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=uczrKuiH; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e6831f5ce4so7905905ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1755862145; x=1756466945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAj4MTsX9crtFaSUyO+PrnGMFjFfbBShLF1OedjML3o=;
        b=uczrKuiHTenWAgl7w12WD+sdSpNE8/Xed/gFkQ59lKvIG4wQfMKQLP1kmItdOjgYBi
         nAh1rm6cbOstc2S+qK5s4ZOLbhVD6hCV2DAbOQKrK0TYZ5A+DgGjQKFvDWMDsjgPM0vq
         rbzQod5I6k/ri9jqmIfvIMr8UrQmbklJcIV7IRdJOQ0KkNP5lZWYQy4rxnvKmy/TgTNe
         NizcN1r4rki7biKn0seg+KOQOaTt6f5Mn6Oh7/x9pnMDQq1++fGSClSqnQTCI0lkntHj
         TQusPC0rZpkNyZgwDvv77wNWH3gd36JyBnnm8I1NlaUMTjeeuXE4LEzpxkk4whaLs2NN
         YtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862145; x=1756466945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAj4MTsX9crtFaSUyO+PrnGMFjFfbBShLF1OedjML3o=;
        b=NFb7t/G+MJ66pIv522FqAOFpH7gE7om0aXa4u/P89Cnf/oGa8HguLcxkY2IF/PFa0s
         mOtk03I5usweJw3hqyhjHPugvFo6XsSwwqxoiUJyVEczCy0RBZto18L9twsaTD0yAEyp
         bLmNJSqgAk2vL3sUZAFLBeQtMKN/RqGQs0a7530nUNfDbbyWYo5i6NMGUVk4sbmxtTzH
         gMUKHhk0IIAYu/d1noGJ3Gbslscaja2E+9lCLWr5pJGzjPg/LTfbbgtt8AJ5eR2ywPLT
         +6PHa7BdP4xecLZaZiEhQ0iNV2xkeRhNP3IYxE6YBlZ+n0LhH/cLwxaYqrjRzxf8WuAd
         CxMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOZSktccjSWjkkrpV73hqjy/08VCdW+XnrmgjQMqZh8sp/KE+2tpX6yfvLOL5/83h4fMgvYaf46MCL6WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybF1ViBjbcE0ngFQpdvH99Zv728TJSuhDF9t/HQYkmsWF+0xDu
	LSh+22YyxZAUU9JcaoLNl9fkjKksm4rZE8ZCU9YKnlrYYLlqKXbn9Baw0pRp2fjwpf5KcI/djaX
	68Zhk5HKbh0l/vbAPFSmsiUg7aEtceQHY75h5caAQ5g==
X-Gm-Gg: ASbGncsyyZqigy5mechPmCdkQNA87Tq1PCebYw8CAGgIr0Wg8orBK7Si6w1le3H6BRW
	x+Vx/R6MGLNBQQmvjtr9P3r8G0NpUAapxRxKHGG1PkE2cp8rvAiu8m72umfs51E0JLlrREg43t9
	wk6Lr5Z8B/fvRUBwmGcRwUuFEpv7jYQVA2fY51aQunLeA/IHRjPimIBFa45sHhvza4h9EJnCK9/
	15kS26B
X-Google-Smtp-Source: AGHT+IFotCEaG3Imylyjy2m0DQxnH2th5L/KRoKnw2C+LytW2vVJKqgXGAwa/u5DAm0MxjMWmuNiRe1PyZgcFc/tw+c=
X-Received: by 2002:a05:6e02:2284:b0:3e9:e4ca:8f0a with SMTP id
 e9e14a558f8ab-3e9e4ca9b34mr9579755ab.25.1755862145223; Fri, 22 Aug 2025
 04:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
In-Reply-To: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Aug 2025 16:58:52 +0530
X-Gm-Features: Ac12FXzA7OqPPvuSEUi3YmGf4O7XQNOfsrf-wXEXFi1rcASEvUu6djRNFKE82bo
Message-ID: <CAAhSdy1OcQBgV6T5z0K5mMv9pr23_oVVEJpimdzDjgAN3BhYeg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:24=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar=
@ventanamicro.com> wrote:
>
> The userspace load can put up to 2048 bits into an xlen bit stack
> buffer.  We want only xlen bits, so check the size beforehand.
>
> Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Queued this as a fix for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_vector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index a5f88cb717f3..05f3cc2d8e31 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vc=
pu,
>                 struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_contex=
t;
>                 unsigned long reg_val;
>
> +               if (reg_size !=3D sizeof(reg_val))
> +                       return -EINVAL;
>                 if (copy_from_user(&reg_val, uaddr, reg_size))
>                         return -EFAULT;
>                 if (reg_val !=3D cntx->vector.vlenb)
> --
> 2.50.0
>

