Return-Path: <linux-kernel+bounces-759414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C9B1DD3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0219F6272DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE7272E7F;
	Thu,  7 Aug 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISOlgKj5"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303742222B6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593097; cv=none; b=n0g3QGllN0FzCYfUOrDj9uUNhMYRjtV5H5d8E+yv1Qq8lyrOtGtXpsx0UpUcb0qts7hf+hogxT//ezHGn3fb1zFmgsxg/MMOCqmcFBjeAqz30siZBF0VN8rLg/Y6L2xSiq81iUxLpt5dC8cXaFsVhNT5w99AalCZbpu9hGWMI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593097; c=relaxed/simple;
	bh=MuhIPyi2F5+ipcNc957b0wI7HllbWh/lbIIst2ORD2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzB8ZqkuXCM1ui4mpm4+MfbpMY5CAB88tQaAKLu6VAou6QeD4yotZl3FjPiYOV7V8tNaF8arNmcMvsZT7RlxLlZDBfwrPxgAGd42nIpgKHsuK77hK/9dSUeBQuPw1ToxcZnfkw+TrX1PcwXFHpdisbdD+bIfOag5kG5s1Z9buHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISOlgKj5; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b0673b0a7cso58751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754593094; x=1755197894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=96362UVupe8COf1P6wW/mjtmbdG3wWxnQMi7BMOUIUE=;
        b=ISOlgKj5UPRwKsKRT0fvJs/VjevZ5F51s67VmcltqSE7U/yxGfriq2M79TbfX5nXPL
         sIhbMGHdBEo9QLD0dUFmdd6/PoI2BnTxbG3aI9tEHsRKfRFeOp//4yNWYRRs9mtmWWEy
         3d05ltVM9q0bi6kxh+HDAXVc4FF5xOl1GRozjkWV/vUHn/rdU1FDXQgBskJbIKZO6A4r
         7HMPcan11p92JOJpm8EGerNHUfpBw8+DT0RnJ8ahNIki7csClzFYxopx50rV9nR3VeIC
         Yic+1jlLMXOfVzGPh/j/savlM0vKk5JoNXPUPyX70liV54btLr1uMab7zKTo1WSofi6/
         fYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754593094; x=1755197894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96362UVupe8COf1P6wW/mjtmbdG3wWxnQMi7BMOUIUE=;
        b=kWs4pblYT2w1elZrlKXf4z7MGNtliQQ9YXSLvdfYHWbiwhOA6qf6XVxfITeTNpzzL6
         zDVStMn15gGBY/EcoldgrNzkYvY3NTzTX44ku4M+Kc06CED4U9A6PZBOqr1YK/ikuvQ8
         k1yHs1Z1UMxaw8kZCqdQEh2urECmnJzs1VkOTUUyeBsAn0xeLI1kgXrdTGSjrFJ1KzXG
         3BnPGWH25Ku3NcxT/N5b10841/WuAf3JKlWPtkGfMbRC6t90/Cr1dDlTVTvJTEP6TNhK
         b0ik8NufObybpyDkAWF3yd+9VgXAa64+HbyE4sCq4nE42voHuQTGSXvFROxVAfG278ci
         +R2g==
X-Forwarded-Encrypted: i=1; AJvYcCWcSQ67B2OJpNN6m/jLzRtVsj5B2hqjQImIK8t5Wn1580Cs1u5LPpKNK83CgTAsnPXua6Xhwfwzf+m24pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjeW7feSq25Vn12PBpAxa0etz3ZqQ9vpr2RAnMSpwzt5X6Bqi
	fBN2GLwfLbae5x3CYUoWssVGL4sGYaw319Sybph7gqBe7D5CzQqjBu1z1uN5ZUVdONjJA6cZR7d
	Gljz5up5YM5/aWlet6C0hkvijwdwz5uVhDuWL0rjh
X-Gm-Gg: ASbGncuaVtrbbe1kQRcBfW9B28fk/PFKr58h9TMgdtheJCClSxxxE9rezYyfFqJZpAz
	qVj8ety/OVp9VfrwuZUuVOOwbrGQnQ16ES51Ro8I2iA3c7RvwgPGm0MXd29vJvUV5JH9Ba1kiu9
	SKaX1l92GXwjJXOPQz6g3WX/hs/0vQNvKt201J7AQuFu85UOYxHLGy0a1ZMCPH6nDQoNlaSnr3e
	jPQUqHXPP0GAs4ZH6LiT7cO9b93KC/Hrxec
X-Google-Smtp-Source: AGHT+IGQv3PJBbuZ1uXQcTT0alJEv27zQP6RUhp/GXkD21PwsG9r1YtfOqnK9qoS+hDRmSRDSNYUz0kE+B4S+clok58=
X-Received: by 2002:a05:622a:a648:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b0af27a4c2mr270701cf.11.1754593093620; Thu, 07 Aug 2025
 11:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724235144.2428795-1-rananta@google.com> <20250724235144.2428795-3-rananta@google.com>
 <aIjwalITY6CAj7TO@linux.dev>
In-Reply-To: <aIjwalITY6CAj7TO@linux.dev>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 7 Aug 2025 11:58:01 -0700
X-Gm-Features: Ac12FXylmxDAHRXg2gQCPPXuwIGOmW7c0vzzAhp62yyDvoK-TIuMbTJEHyOdR6k
Message-ID: <CAJHc60wBNTP9SSt_skEXXv9N+tF_1RoV6vcQQx4hWphJF6EmkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: arm64: Destroy the stage-2 page-table periodically
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Oliver,

>
> Protected mode is affected by the same problem, potentially even worse
> due to the overheads of calling into EL2. Both protected and
> non-protected flows should use stage2_destroy_range().
>
I experimented with this (see diff below), and it looks like it takes
significantly longer to finish the destruction even for a very small
VM. For instance, it takes ~140 seconds on an Ampere Altra machine.
This is probably because we run cond_resched() for every breakup in
the entire sweep of the possible address range, 0 to  ~(0ULL), even
though there are no actual mappings there, and we context switch out
more often.

--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c

+ static void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
+ {
+       u64 end = is_protected_kvm_enabled() ? ~(0ULL) : BIT(pgt->ia_bits);
+       u64 next, addr = 0;
+
+       do {
+               next = stage2_range_addr_end(addr, end);
+               KVM_PGT_FN(kvm_pgtable_stage2_destroy_range)(pgt, addr,
+                                                            next - addr);
+
+               if (next != end)
+                       cond_resched();
+       } while (addr = next, addr != end);
+
+
+       KVM_PGT_FN(kvm_pgtable_stage2_destroy_pgd)(pgt);
+ }

--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -316,9 +316,13 @@ static int __pkvm_pgtable_stage2_unmap(struct
kvm_pgtable *pgt, u64 start, u64 e
        return 0;
 }

-void pkvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt)
+void pkvm_pgtable_stage2_destroy_range(struct kvm_pgtable *pgt, u64
addr, u64 size)
+{
+       __pkvm_pgtable_stage2_unmap(pgt, addr, addr + size);
+}
+
+void pkvm_pgtable_stage2_destroy_pgd(struct kvm_pgtable *pgt)
+{
+}

Without cond_resched() in place, it takes about half the time.

I also tried moving cond_resched() to __pkvm_pgtable_stage2_unmap(),
as per the below diff, and calling pkvm_pgtable_stage2_destroy_range()
for the entire 0 to ~(1ULL) range (instead of breaking it up). Even
for a fully 4K mapped 128G VM, I see it taking ~65 seconds, which is
close to the baseline (no cond_resched()).

--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -311,8 +311,11 @@ static int __pkvm_pgtable_stage2_unmap(struct
kvm_pgtable *pgt, u64 start, u64 e
                        return ret;
                pkvm_mapping_remove(mapping, &pgt->pkvm_mappings);
                kfree(mapping);
+               cond_resched();
        }

Does it make sense to call cond_resched() only when we actually unmap pages?

Thank you.
Raghavendra

