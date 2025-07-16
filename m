Return-Path: <linux-kernel+bounces-732874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032AB06D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2593B5612
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0702727EB;
	Wed, 16 Jul 2025 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ZQwB5Pdq"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA47E1C9DE5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752643219; cv=none; b=iFfbXzQEethoh68Asigww0w9Sn7aVjCczCPHayzV2XXpbZxrIt1Q5zGSbPxSBIdpwCtyDT6ShxGIb8ddAHFe9+sL0I4Bl5cqKn/WZANdp1HVTiAXUtLg+83KstfT7CwHK9mEdXdoF9mG6d/jDbIasgBkWk/YhCpg9vOisEO8xSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752643219; c=relaxed/simple;
	bh=/ktSjyUZX0dfbAs7P4VFPYdLWMzAPv8W3aDVhnylNsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD3ddi7CF+LsPFilORNxMOdI6p8z1dd5OBmofFR4dStrv/Qr86zYUkE0jeIxJxZzFSR6y/6RHxM5DJGeoCh32nV6zQovjUKYYYVQg5YWtFFPdxSp94tAgIqHRO2vgXDVogglwAnhLyKJsVPTlKQQDUiyJPnsMA/1OYAVBToEoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ZQwB5Pdq; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2d111fefso53386005ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752643217; x=1753248017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pr0CgkuBDoCBojEhq3SOwjdkjudDtqxy7ZuiK0Se4o=;
        b=ZQwB5Pdq4vJHgFysY0APTd6kt8YEFn2dLjZfKMCPeKy+wAJx/6s+ka87efhvbXn02D
         0Pp1BlNjf2dgR9i892l7XI20jExfW0bqj+wMqkJwsLZF1Ku9h2wTNEbi2TfA4PGc1ulh
         nFED4houCN2fi5B90m0wnt+q8ufPMWOC2hWZ+Px8MKdG7qh+StYJYcb8AaScVTo6hly1
         JZRSlirkouBPh6fwY9O5xX859cO/4DkVTTmcxwzDgMuXpS4WR4szvN1833symUG9OSdm
         kIpVAzuq3lRjz8oQezaOmVnJg2sb+/QJFL4DHyaURlJsjQbWestJeXEAghbgvWnbyAag
         IIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752643217; x=1753248017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pr0CgkuBDoCBojEhq3SOwjdkjudDtqxy7ZuiK0Se4o=;
        b=vZZvE9wEteCKzpj1/DOoMiVyYdxM6Twf4NL4N/YG70obayXcgmCu8JlUwyBhChhetQ
         piek1rtzAylwaX+2vMlwMDrO4fo+IWTcptBXAZsl5s9EMCSk0jty42ZMbpT3o6Hp8KCS
         lcS49/98r/2JEz0p/C/vGxf3fN2bsWzlq5V/qhettldNqHE4vAbDQLGhyXIGlUT0O1NQ
         v20E99k/NA0qPks720IfoMqXHdwMmsU7aL6iVvYnhKRh3k8v9DOIB08va2lVndLYrIMV
         bSebXu+F/uRzD68/UeOO0lM1d0FHUjfRRxycgA/tKMdMd3JrjzhlJuhCN06xkZh1B291
         E4/A==
X-Forwarded-Encrypted: i=1; AJvYcCWfdXjjRf/vnE8WhpTkcQRN1E9ZIYaTvkOWMUGG649G6U+AJPmtQ9t3svt+LcOiOOU2ImhnASdCVGJlNW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5FLLipFfdirKrRQBUS5SvuoiKbvbvz8quxhQ36/D0iFQKcico
	MrUt0GO6NcCFgNCDwqvAxF/ibI63LNJlb6E6cjyZqbzb7yB2wdpRz5DXDyhVMqeCR8Fvpj6E81F
	O5bqQ9plg94Blt2dqnjwjrKT/gm9dXRqm/501MeXVBA==
X-Gm-Gg: ASbGnctGcsN+vJ5zUHZByHZksBLK0w5s7P8SwFkY78KnSBUolrzJyLH1ZH765hAdsWo
	GjGxc/pUJIzP4kORuw0mEpKWHM/vTmXAuaCJgB7L5f9paTt4Q/rtFDm+kL+hJ/tFVM7O/LiFJ82
	agu4euqOxlzGVPcT5bMCttuk9EvtR/8Nzw5ebCr6vixO+G4ydXMbgsSSwxjkHUTJgGXR05f4okC
	ZEOXQ8+6rikNYU1
X-Google-Smtp-Source: AGHT+IG8QMvIrF4Nh6TtjPYY/OImrdrVsXWR40Aodp+LssWG0nbwGxcm5vyJpoaN8ajvyQHU4KVCDRQEYdjX4PMmHto=
X-Received: by 2002:a05:6e02:1c07:b0:3df:29c5:2972 with SMTP id
 e9e14a558f8ab-3e282da9cd2mr14405455ab.9.1752643216752; Tue, 15 Jul 2025
 22:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714094554.89151-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250714094554.89151-1-luxu.kernel@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 16 Jul 2025 10:50:05 +0530
X-Gm-Features: Ac12FXys72h69btMJ897A7pa9H69kTczP7dldA--hcTTkswEbCjKDSzqpxxAxFs
Message-ID: <CAAhSdy2XEyphi5K1xk29JXY991aie0LA5YF2zRbgA_8imSjXQQ@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: KVM: Delegate illegal instruction fault to VS mode
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: rkrcmar@ventanamicro.com, cleger@rivosinc.com, atish.patra@linux.dev, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 3:16=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Delegate illegal instruction fault to VS mode by default to avoid such
> exceptions being trapped to HS and redirected back to VS.
>
> The delegation of illegal instruction fault is particularly important
> to guest applications that use vector instructions frequently. In such
> cases, an illegal instruction fault will be raised when guest user thread
> uses vector instruction the first time and then guest kernel will enable
> user thread to execute following vector instructions.
>
> The fw pmu event counter remains undeleted so that guest can still query
> illegal instruction events via sbi call. Guest will only see zero count
> on illegal instruction faults and know 'firmware' has delegated it.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 85cfebc32e4cf..3f6b9270f366a 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -44,6 +44,7 @@
>  #define KVM_REQ_STEAL_UPDATE           KVM_ARCH_REQ(6)
>
>  #define KVM_HEDELEG_DEFAULT            (BIT(EXC_INST_MISALIGNED) | \
> +                                        BIT(EXC_INST_ILLEGAL)     | \
>                                          BIT(EXC_BREAKPOINT)      | \
>                                          BIT(EXC_SYSCALL)         | \
>                                          BIT(EXC_INST_PAGE_FAULT) | \
> --
> 2.20.1
>

