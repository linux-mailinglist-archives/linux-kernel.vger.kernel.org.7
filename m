Return-Path: <linux-kernel+bounces-818180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7AB58DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A852A6304
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40549286419;
	Tue, 16 Sep 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OQMWBI5E"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C425743D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001114; cv=none; b=dP9JzVTXiav1XntPde4/dIMm52e4oyQIBCqxWYC2Ok23jt5hjoJiMHqKEDqiwXDbNDbWUF49GxfrJZvU9EQvcYdJBH3/TBraC3nbhNwntE6XTBLqRzRFdXYluPU3SRBd+kO1UjsCXxB50tyfAuANJouEzxAK9SdQsLDRsqXpog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001114; c=relaxed/simple;
	bh=elFH2RTS4MKhtWQfI9FXcnozyv3M6+q7/HcBhns8DiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9CC/+kC1DLFrek1tVYzava/75pVfBcycSQ1NwdY+JYkRa4MAXwn/xYz5s837cmWRmpjeTLCTJ5oYY+zBHIUfWMoopRX8ReU3etxw41BUv9j9wbvTHknXy5fVEkDImcz2xs870qBvnuYL9vEfkV6ARVZ+b4ABFzSqy0GkGUzM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OQMWBI5E; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-42403719ae6so10298195ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1758001111; x=1758605911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+WY6S8XVjX9ojiFBX/w421kmUHPYta2U/tJO3CWfRQ=;
        b=OQMWBI5ELyJPS/7v+XYF55o4HJLTS2/9kYg6fViLGXQjczyLbAQNZ47SSigQaj3P4Z
         LWVw4ctzppabfcj/JFQfDhHgnhTjVjiDDd/HOzws87QUYrMyeckFtI4LUuFGQ+5IYxKY
         yzeOmciZtpY7sbcsEBQKxK+cepD+ZdaCgxIxq1iuRKxso8F7gR/3Iptucd0Kw4rXiTD/
         YTllpqU0OXIhmXTNQ1amSXyKbhC4PXrdyKCKm596vvD7Kiohl5pUA11ARB+D3J9+hx3C
         QRcNkZvMwcQeEiv/aZAKiL0tc3I0bnWJcraEndaSVYptvTfVoXxNZ2wExiBho+gTv9o6
         3adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001111; x=1758605911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+WY6S8XVjX9ojiFBX/w421kmUHPYta2U/tJO3CWfRQ=;
        b=WNt+6Q/TcdqrbtrCtLXhRkKAH4buwyjKU/3y9RC54h7dZxxBNGCVRRVbrlIKwQUfx5
         x8tFYJdXu0EyWokZipZMVeS2H8P827A4ANBVGVeZ1l2I8/wjYIubeNjfAh7LMrx9MLIH
         QSnLyV9ay6GkuFaNI3fM9fKkLzhJ8ht6R2JVJA7FJ3MBHeK2HwU1HIl/aJ2tLTl9u36I
         VDJu/CPbqPuC+wVFOIu9CS4GkGYH1OXy1lXr6uTWY4GGRkGUx8na9v2nr5qK9i9AvtBG
         WbHAtcqUK/62ZvnVt+9jD+sP6I/YD0rv97o1X5+vpX3QCYe57KffiWVsj5heKHDZd+OQ
         dXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVyHPmaSQsUdeLqvdCpw5cZM9gnPOwmk1hJRlp7OBgYUa2WDY56D1BfixXynhU011xHjJ96yyTmvVTKbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzuBSEHf2Wx4Zlb6l8+eBwewiByZlwfnk7VxOrrADPcfB+Wvf
	yR/MnRsGTLhHCWfrL94RQN58qjgTaBcXenorjzcxn1Fz36P6jajuKuahEq0lQgjR9h4ZP77WPtC
	6cLISQwO6xWdjbe5lFkvJMS+HkF1OHDxZzQjBpGSwoQ==
X-Gm-Gg: ASbGncs9x+Q8+HWbEIfRcyfIWJ1mIev2TR00Ru0Qr+9ahGxk+RtktORHFXt/tlZLKmN
	di9L/RtlKrcUukCB73KLUcqPyviMNHwa/GL/CswuOHTvrcg3LZ696djYQTtxQgQS6uicynVJ4pi
	lmo2WfBClEcLT//3BzRDF5P090FFdTcoQOwcXK1hMTRXTskBS3ugYNTsLykEpgXRWjJNzoJtKDX
	XFS/8mVoeGdQ+Z7xRjEtNT8NNpwzF+NJkVXrKVhq2AkGPe8kcw=
X-Google-Smtp-Source: AGHT+IHEt+IV7wo/STForhbe+5Ighy2VX2akKFvAUd+sccpOkUTGCayf1IFAZQMilDDqxxtkhwZJapH5I41ohgtHAys=
X-Received: by 2002:a05:6e02:19ce:b0:412:fa25:dd4e with SMTP id
 e9e14a558f8ab-4209d40ff57mr142917585ab.1.1758001111530; Mon, 15 Sep 2025
 22:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915053431.1910941-1-samuel.holland@sifive.com>
In-Reply-To: <20250915053431.1910941-1-samuel.holland@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 16 Sep 2025 11:08:18 +0530
X-Gm-Features: AS18NWBBYp29jcrefVqIqieCZ6Bs58izD3mGRcYk8wb5X3Ucta-UItSPTxLvHGw
Message-ID: <CAAhSdy1Gg+k5U8WoFGkJvv+0TSg9mrSVCj4JTHay29uUc1_exA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix SBI_FWFT_POINTER_MASKING_PMLEN algorithm
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:04=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> The implementation of SBI_FWFT_POINTER_MASKING_PMLEN from commit
> aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLE=
N")
> was based on a draft of the SBI 3.0 specification, and is not compliant
> with the ratified version.
>
> Update the algorithm to be compliant. Specifically, do not fall back to
> a pointer masking mode with a larger PMLEN if the mode with the
> requested PMLEN is unsupported by the hardware.
>
> Fixes: aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKI=
NG_PMLEN")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> I saw that the RFC version of this patch already made it into
> riscv_kvm_queue, but it needs an update for ratified SBI 3.0. Feel free
> to squash this into the original commit, or I can send a replacement v2
> patch if you prefer.

Since this is fixing a commit in riscv_kvm_queue, I have squashed this
patch into the respective commit along with Drew's Reviewed-by.

Thanks,
Anup

>
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwf=
t.c
> index cacb3d4410a54..62cc9c3d57599 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -160,14 +160,23 @@ static long kvm_sbi_fwft_set_pointer_masking_pmlen(=
struct kvm_vcpu *vcpu,
>         struct kvm_sbi_fwft *fwft =3D vcpu_to_fwft(vcpu);
>         unsigned long pmm;
>
> -       if (value =3D=3D 0)
> +       switch (value) {
> +       case 0:
>                 pmm =3D ENVCFG_PMM_PMLEN_0;
> -       else if (value <=3D 7 && fwft->have_vs_pmlen_7)
> +               break;
> +       case 7:
> +               if (!fwft->have_vs_pmlen_7)
> +                       return SBI_ERR_INVALID_PARAM;
>                 pmm =3D ENVCFG_PMM_PMLEN_7;
> -       else if (value <=3D 16 && fwft->have_vs_pmlen_16)
> +               break;
> +       case 16:
> +               if (!fwft->have_vs_pmlen_16)
> +                       return SBI_ERR_INVALID_PARAM;
>                 pmm =3D ENVCFG_PMM_PMLEN_16;
> -       else
> +               break;
> +       default:
>                 return SBI_ERR_INVALID_PARAM;
> +       }
>
>         vcpu->arch.cfg.henvcfg &=3D ~ENVCFG_PMM;
>         vcpu->arch.cfg.henvcfg |=3D pmm;
> --
> 2.47.2
>
> base-commit: 7835b892d1d9f52fb61537757aa446fb44984215
> branch: up/kvm-fwft-pmlen

