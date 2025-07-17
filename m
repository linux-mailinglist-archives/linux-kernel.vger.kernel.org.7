Return-Path: <linux-kernel+bounces-734730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96266B08570
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9018A1C24A74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D6421A426;
	Thu, 17 Jul 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="iELNt2Bi"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737017B425
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735019; cv=none; b=pDorxxtZjm66wNm5zwMjzuWzR2Q7zMOXf0PjIt6mJSAQBEzaxnaSQHwdJ2tGVIbcpMfd/TheQOjaFVR80FtPdRFTWR4Clbgc33g+NnKPBWU4/2+n5Y2pExN6A7kcS/yOja+GjU32JHPEIRTr28EftlhlTWezzyI4+6fcwQjJaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735019; c=relaxed/simple;
	bh=Welx8XGSpuRGUGp0SNNFwqELTB4iugyo2NHdWQcA1QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8e1EPYECHDAonIJUAy2YNV+q+zpY6w/dcuzuhh0Ss2wHKaTubO/UXmoN7U7ThUuS4QaBUkOs2P2n/IERk70Mv27nC/4P3rpuhet0zkLHEPJwcUsZNgqZ6WYOY0pVcwNYyrn8VWEc6LEqz3ADdYOpwK64kkHrjkH0qVNtCdcuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=iELNt2Bi; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87c070b2dfbso1893339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752735016; x=1753339816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRP0QV8PsF634DZbiH7Bzk9P/KhNWvkCg2Ntb8AXlf8=;
        b=iELNt2Bi7b3tUfdHlRSWYiB5jKpjTGAVQDjdTixuYPvz0o+1UNoXcujbQsuk2ej3IR
         QrcVzXPx9K7yKmT5QvhLRuF4ERzJaTCcixq5UK/buZ7oq/Vb9s+Vl/J3TYq/79Ee2ARJ
         7Dxa7mzQcN3WYVd9Ki5ffENCsX/OsE/PiRQ85X995a/jLsYGEzrI6UJreyTFR+0TavFL
         cJZKrlFB+KeNEe3vpCLLJ3znY3psmTWgaCAKRHFFGVvuZ3osxEQEzwGei1Jbh8YAKK9Z
         9arXMqCh+07xbI8cj/DIs9lHDuA3R036kyFznQJZxRBx6M9FH52X3cR/qmQfs0CveMHh
         SvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735016; x=1753339816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRP0QV8PsF634DZbiH7Bzk9P/KhNWvkCg2Ntb8AXlf8=;
        b=aVIBXiyWgKLWGcQJITqcYss3S8Qm5QJya5vLlBUXq2KHS5x0af9Yf74Bjb1PplTfGT
         aZnvghaGbsjuy71ytXI+Uhf/Ok0A4M3vSzKPX8LB2XUNtoSHpZeeJMSAjXTbO4hcmeRn
         Q5peCnUevvX0whmd7QRV3qORnZX2VWreB5ERGzORI4Mb5d8Xisgh/Qhji12xjMtgyroF
         Ox21piRLjilJkVRdf4vffqi0BI+POwh46c+mhGCfbR+TXm8ur7ssIhUxydXIZkAVABU0
         zZb41lG8icUtMXU5V0UZMBlEweh/Eo8Wx7cjuCCIr4Iwrc+iYTzct7zjAZA2xLCrFVo7
         tfgA==
X-Forwarded-Encrypted: i=1; AJvYcCXTmFTYyg4O3Qk8Sc5m/JmSbtlU+xdnuxlzFggwl6bLNmQuqyc8RYsQ79GE9cRCR84qWsuugsbjgq9dRec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0yD8A9CwxYaAqAMSslXayRw4xPc/NPK3qY0EK2hIMgajKURi
	gY1lKlv16NRelQUb906L9XmxGZ45SvYXM66RPyvT121YAjOmSfW0opUvYUSPoSAebPZqYHTFdVB
	6mF7MSs3baywhD7bBM7g3PfcmyKTogJxdiyC2qqsoQA==
X-Gm-Gg: ASbGncuJlF76FVcb/nue2BX/fwG0/KIiVHya4DVz2po4Dkag26W/ZT8XZQNprXjpBxz
	c5o8E2fa8Zp4oPcJMBYXJtWlSFM0lyvxghqsfjHNHd0yArWPA2wTj34TFInJv2SBYWdgCUpvaE3
	3QYABxtYNCFNLo33IQYKGc5AGawH2UEnb89JxJNoVGx+9E0+zwMyoSpv72kpLXaInP2Ka9w6rDf
	EWU8n7GBl4DTEbi
X-Google-Smtp-Source: AGHT+IFZ8nvXjCaZDaRw8/yf5Mquo02OxAogwOkqoPvU2H/adfyL7R+G1wf2juDA3dRWlbOsvfGrx3RO4c7yvPjrEd0=
X-Received: by 2002:a05:6602:b87:b0:873:3691:6fb8 with SMTP id
 ca18e2360f4ac-879c2a9ce57mr522646239f.8.1752735015916; Wed, 16 Jul 2025
 23:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <230d6c8c8b8dd83081fcfd8d83a4d17c8245fa2f.1731552790.git.zhouquan@iscas.ac.cn>
In-Reply-To: <230d6c8c8b8dd83081fcfd8d83a4d17c8245fa2f.1731552790.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 12:20:04 +0530
X-Gm-Features: Ac12FXxjsfWvqdAAcziMJWepGgazwPrr9F7mVz3S3QUEnBEAVtT1PWIUTzHtpEM
Message-ID: <CAAhSdy26sV0SKjzKJoWF9vH2gLsBnqRfV1rCrWGokM0E=w0nJg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Use find_vma_intersection() to search for
 intersecting VMAs
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 6:43=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> There is already a helper function find_vma_intersection() in KVM
> for searching intersecting VMAs, use it directly.
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
> index b63650f9b966..3452a8b77af3 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -487,10 +487,11 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>          *     +--------------------------------------------+
>          */
>         do {
> -               struct vm_area_struct *vma =3D find_vma(current->mm, hva)=
;
> +               struct vm_area_struct *vma;
>                 hva_t vm_start, vm_end;
>
> -               if (!vma || vma->vm_start >=3D reg_end)
> +               vma =3D find_vma_intersection(current->mm, hva, reg_end);
> +               if (!vma)
>                         break;
>
>                 /*
> --
> 2.34.1
>

