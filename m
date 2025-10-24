Return-Path: <linux-kernel+bounces-869101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C475C06F42
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8701C23660
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBC326D69;
	Fri, 24 Oct 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="DD7HA96f"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0D2DEA7B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319522; cv=none; b=qYptTgVJMWXj3pGICy50qGmktbv7QIEvhUwdHZuc3guvl7vsNEzYF89I1fE7CBwWudvT4QDs8PUAj6iQjq2SUcIk91O4WhsR8T9S/Rr6CQHoNIBIfDDgiwAXFin1rqaTIic7DihL8wL13amyvXD4yWDaYp8Pu2GpySHG1E4AKtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319522; c=relaxed/simple;
	bh=yd271BqGjeS+iBsD8ybvx85gmJGIuP9wFhL3YHDZT0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX8v+tZiGs/hfC3ZwMpgqbaoH2XsWe9oYRlcvpiPdOpNzaLufOow3K4jyxnqDEhAFIYTGVWRujBuJ6GzyBvuX041xkmVi59w0lfhzREtUxKbrnVPCqYG7AryLQg4q5hkFMyvjQs3QArPyvj6McdO8KEKyI04v10wzh2M6XzzS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=DD7HA96f; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-431d2ca8323so11452295ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761319519; x=1761924319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd271BqGjeS+iBsD8ybvx85gmJGIuP9wFhL3YHDZT0o=;
        b=DD7HA96fFpoqDKuEJ/GZweFag/WxtNAhY8VPxTVFkM4SFc6o+quY1hEaqC/uO4dUvN
         WXvIhthZqJzQ4dEm+pm9+s6y4RcGq9iCZk5py76kGBQvLJaeArat065jAC78o0vUifiE
         PnJJ68zyWejlPd+l4U3cLM2nx6i+Yh1tDvhWcpiWE+ohr3UxFfjRG9CPoMQeWoV80joK
         P7lSIVDyUESR21LzHdhTfLcni08lweSYv6dDBpI8zHhuwMfnJ1XdYn1Q3g9bu3v8fLlw
         YJXB8pO6i7K6aKzI4ZU8eCMEr4AjqzvPp6jY6um51nsOpZitusumpvDXKUkZHAGOHmRV
         XeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319519; x=1761924319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd271BqGjeS+iBsD8ybvx85gmJGIuP9wFhL3YHDZT0o=;
        b=Ohn1aJH0huo8xihMHzAqzXDqIqHH5QznKhje3G2qY6LRdjATsb8DtZUBYqoVXX8NxK
         nD1tVQQuva3BYPlb/JC+OHA/g2NsuhtseQGKQuSf9bkiPdMz5Dl/vRPQDm2qVINphxR3
         GJjCNlSmO1SAgIHalY+X7jy1FlrFvEyWZJMz7d19RLkKv9/C27X62x1rM0eRpc3un92H
         fn0X8pELHztk3vPN9Be/R7qs1jMrrtUrvd/Z0+rU+YCp5HNXzN54duJD39xPReVEYvIP
         TOFVjRwawmDT4f0avnNF4tBjf+DMegqH4vDG5HrmUCzYd2Kw0BRB0jG3wfEcUpqXLA88
         T94g==
X-Forwarded-Encrypted: i=1; AJvYcCXmeOVpbgLRbhCs4jWz9f8yWGb021cGkl9svjuktkJO8/5RYcjnR1L84vXYiKCuuZAk9vyqoPO71qgUx7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ucr9c3kUa+qQpEYiGB1ZXx4a4n/hOViKbGgn+lH0jSyL6UtW
	R+mmjy/BBrz4BYLv+kQLRNP8654sFWAO35xhvYLFFxgfiedsI4r02yETg9LJ1ZRO5I1ncIqGWQI
	Cm0SuxHDY4EGRCEYDG6H1fbMiB8mp4D/k8ySEoCw0jw==
X-Gm-Gg: ASbGncu7xSDjUSOXcaw+RDog7rM9NBL7JxNIfpRql6mIJcQFmfV3ESFD5dOGkOnO8ZA
	FUC3zqzABuUM0l6jrCkrtItGbw4Rm3hPc4lwiJ5ooM7r3aZ7loVrClrGSwcXXiVHSZDWk/UhaGZ
	0lDoSvZtlOxPHSoXWPSK4LGlx65lzx8iuOHKoTcfi3nlsj0CsXX2/r1t3hzkHl+Myt8J+/JUy1a
	PoowjAcx+J3nVK1kz/VyQTW+L0Uh6KTy/cE8uGwzRPIg+tWgb1nUOwa+NzDA6HAuBnDE6QC5exA
	lBBc31+Io86Os78SzQ==
X-Google-Smtp-Source: AGHT+IG1wtHjPkEbu0FQUk92/3c0w05Y3QVim5/4mMrB0XZ9bClwOntryLQ8t33SRrMWa1kUgX8toMC4K2lDPbh1b2U=
X-Received: by 2002:a05:6e02:1fc6:b0:42e:2c30:285f with SMTP id
 e9e14a558f8ab-430c527dc63mr348454435ab.19.1761319518490; Fri, 24 Oct 2025
 08:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhSdy1fCCdciZLqmoeWDG_QoOHDi9j0_ZZKYkpGJmWrf14Q-g@mail.gmail.com>
 <20251024133116.73803-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20251024133116.73803-1-fangyu.yu@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 24 Oct 2025 20:55:06 +0530
X-Gm-Features: AWmQ_bnQnnLktl5ci8mf6nQS2KPthEIzOPC5pFpxmUA9i0pi75M3qXGuzrrlyiI
Message-ID: <CAAhSdy3E7-uC=pwU3c93bj3_xykPnLUcDXgKJtJ0KYeL91tijw@mail.gmail.com>
Subject: Re: Re: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP
To: fangyu.yu@linux.alibaba.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, atish.patra@linux.dev, 
	guoren@kernel.org, jiangyifei@huawei.com, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pbonzini@redhat.com, 
	pjw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:01=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote=
:
>
> >> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>
> >> As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
> >> vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
> >> regions. Using vma->vm_pgoff to derive the HPA here may therefore
> >> produce incorrect mappings.
> >>
> >> Instead, I/O mappings for such regions can be established on-demand
> >> during g-stage page faults, making the upfront ioremap in this path
> >> is unnecessary.
> >>
> >> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table program=
ming")
> >> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >
> >LGTM.
> >
> >Queued it as fix for Linux-6.18
> >
> >Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> >Thanks,
> >Anup
> >
>
> Hi Anup:
>
> Thanks for the review.
>
> Please note that this patch has two build warnings, and I have fixed
> on patch V2:
> https://lore.kernel.org/linux-riscv/20251021142131.78796-1-fangyu.yu@linu=
x.alibaba.com/
>

Can you send a separate patch with Fixes tag to this patch?

You can base the patch on riscv_kvm_next branch at:
https://github.com/kvm-riscv/linux.git

Regards,
Anup

