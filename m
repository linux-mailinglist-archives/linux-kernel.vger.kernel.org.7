Return-Path: <linux-kernel+bounces-735225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC61B08C64
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EFA3B5BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98329DB78;
	Thu, 17 Jul 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="mq3KE43u"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4F291C1A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753798; cv=none; b=OptVQ1Kr345n4R4gDj9BTp1XtL0JYgafojOOiLUGnR9yD1M692ymuToDA62jcLxmj23jyEsU2vUPK5yJ1TWn3fx+1L2VFIKUD1Vg3KZI4JG068XTHSlZgr3nlc4ZfWtO0hFjjtsBly2GZjSfrrwih7mGhHrAWZ2a75DQ1yHS9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753798; c=relaxed/simple;
	bh=5sUyuEyDxYzNwvF/7nF2kx8JP8Y5SfRqqnTK/JmhFx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsuoYXaMz/UEDuDwLFz1ADk1rJrQX+WY3x0oJTQRb/ID+V8zH5H1YsSbaJS4cvKmgCWgRJthPs156q8z634ZgNxm6Hrp5BnYOkJxvjQGuhZ8QrobyYSj2oMQiMc7NRGhoVqXqOyfLRAaRXaN7RCyKYSYbolDkCVE8HSERpFxV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=mq3KE43u; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-87c09672708so4724139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752753796; x=1753358596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdczZfWBYlBsJGjMXmJfIpSAsQhEzzJLRKIMejj7UJA=;
        b=mq3KE43uyhw1GsptyFTVLpVa9Jhlih+m9VMpEpiZ1xVNhzKR5r+mqARyHz/vzdE2P+
         ox4CXBFfpczlr6eTRnqSRShuXFEeWRoTLohnWWTRcXM7UMwpYHFWoMwbPQWs1K6sT5BC
         hanQdTJmAxibrmv2eib/ckTIROTfzCv6X9zWb/sUXt8wZsOumYV0+240c/kkUq8bTdVI
         4HNB4NTAAR92Hcl1AmQSOALtd4XmK2AqLjKKbtOU0gv4cXK2e50hj+tA/nzmjR8nbS7z
         sCDqqNw+2/PO7RNE74IQZqf94OX92XI9+57mmsfiHx9SuFYTH/xyWhULiIZdJYv99zHn
         kLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753796; x=1753358596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdczZfWBYlBsJGjMXmJfIpSAsQhEzzJLRKIMejj7UJA=;
        b=h8TyNKYI49Afp7cpcEXK1oK/60fZWCcvswcvqnI0CtZ3Q1u7MmdZ7awrvJ3YpzOUXz
         583cJ5kr8VqA+5nnIaPv657sCLUK9BEHcLWn6SoJPHI1yLaWAQno37KYG+55AgF1R9Oh
         HWzJhfbYIO6Ap44t5qpIemmr9cWEA5KjZ+2dk8RC7ukY638jh7jps7XjqJqplMGLXHmQ
         c7htAijU6sUAt+IlO27TFzszLgeFisEG/nF+xyo6Vgzzoe5udvC0j4mam6HFOSJB6L2Y
         fOBJ4h/LUbSVV1tq/Hi/8+pKxz+vdQfbDniSHA2EmBFG8MP33fDeSwQ63Zz4FItOVgn1
         Ky4g==
X-Forwarded-Encrypted: i=1; AJvYcCXXC2JstsmkiTYJ4Pia9W7CFX2zonav+xWu/JXPSKUkUlw2EZQHMPNhAE9NAmHcPNkT23l2oUh27lAcwuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkoIwnroApuv2K8xX0ODcin4RJb+DJVvEOiOXJtHCOdj6JW/R
	+yMsjH29Y73zfKWldzcaoROViHj1C7gSydsqIGaZJ9+MB/T4YPY+0QoHFE2SY2thH67fJ/plJEx
	vksispX5sU26kvurPjUcdaepvkcshJjEOYtwu7AIkAA==
X-Gm-Gg: ASbGncuCGdlfsc2moeSXzkB5/ERmZTxHInHQeZ1/hhUDaJ6CSoJ4HN798UJnGbTQXkK
	5a0dS6R93RcYNRSrxJPSHWK2OqANZ1QY+8cM0jTGAMZi4OHFUvFUs3kxl3zCcX2EODPCsk4ZgP1
	3lKMhLi/ucfjZjyhhCL5OXv5ozKb8v9Do2vkjLFhxRRsjU/fKsW+YrcnL1r4ieex7L20HcdA5Eb
	nEyEpCsC1D8EM4=
X-Google-Smtp-Source: AGHT+IEIPZpywuhs1CvUOSh4UNExbMIYSBBP4YpBBndeSSlxDKRJE4v/uEqa/SeaPqJ739w3Q/p24P3FjwMeUrY6uKw=
X-Received: by 2002:a05:6602:6016:b0:875:bc7e:26ce with SMTP id
 ca18e2360f4ac-879c2519d3amr647026439f.0.1752753796201; Thu, 17 Jul 2025
 05:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <50989f0a02790f9d7dc804c2ade6387c4e7fbdbc.1749634392.git.zhouquan@iscas.ac.cn>
In-Reply-To: <50989f0a02790f9d7dc804c2ade6387c4e7fbdbc.1749634392.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 17:33:02 +0530
X-Gm-Features: Ac12FXzaP5e6ToyKGdPw9vauuEDoz4G5gaSf7T3TkFpqI1hEBh5Tf1rGli--9AE
Message-ID: <CAAhSdy0BvhZ_TsaKEK3j+0kNQYRekVyfHOFh=eAkj2H7Znrm1g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Avoid re-acquiring memslot in kvm_riscv_gstage_map()
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:30=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> The caller has already passed in the memslot, and there are
> two instances `{kvm_faultin_pfn/mark_page_dirty}` of retrieving
> the memslot again in `kvm_riscv_gstage_map`, we can replace them
> with `{__kvm_faultin_pfn/mark_page_dirty_in_slot}`.
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 1087ea74567b..f9059dac3ba3 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -648,7 +648,8 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>                 return -EFAULT;
>         }
>
> -       hfn =3D kvm_faultin_pfn(vcpu, gfn, is_write, &writable, &page);
> +       hfn =3D __kvm_faultin_pfn(memslot, gfn, is_write ? FOLL_WRITE : 0=
,
> +                               &writable, &page);
>         if (hfn =3D=3D KVM_PFN_ERR_HWPOISON) {
>                 send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
>                                 vma_pageshift, current);
> @@ -670,7 +671,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>                 goto out_unlock;
>
>         if (writable) {
> -               mark_page_dirty(kvm, gfn);
> +               mark_page_dirty_in_slot(kvm, memslot, gfn);
>                 ret =3D gstage_map_page(kvm, pcache, gpa, hfn << PAGE_SHI=
FT,
>                                       vma_pagesize, false, true);
>         } else {
> --
> 2.34.1
>

