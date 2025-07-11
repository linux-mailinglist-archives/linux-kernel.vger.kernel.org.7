Return-Path: <linux-kernel+bounces-727607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B6B01CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37691894FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B002D77FC;
	Fri, 11 Jul 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="V+b9QMDX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5092D23B6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239132; cv=none; b=rkoRwWO1cZ7q/M4t1NxvLsbblTY4FVqySvwAN9qWXXadxZN2GvbknLmX8aosbWP3cXbuNuUGMtNoajacUcD0I6IkhleYZSLNgUeKe230wbaJln7+65aviJjqXVAnBDwnS0Wj9m5sCpdbeu17CxxPlQkPtIH8Nq9cOS/WpIxoEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239132; c=relaxed/simple;
	bh=xmlK63TB2ec5pcs2W7lC+3QxW8QbBDUxKyEAsD/Q4Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbki7sqjz1rMgiv+Nk4UMBpK8QXhVuowFEc8bWztfljGnUhxeDJm35i6DY+XDSl1nr4AQX29awM+YFQebtEjXZ6XwnO+hCoPyOIc61YE0og8O3TZNUi1Y301lknW6dmoijT7OJ+dFKNDEC1oliDK+3Zdg9+QIQ8JG46ciat+bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=V+b9QMDX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-875f57e0cb9so168860139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752239130; x=1752843930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJE3CLjEeonNUb8mT2xwmsMp3adhwfxqmRNHfpesc2o=;
        b=V+b9QMDXhZYDcnq3D7/UBAtZoBZl7U7BGcLYJkLrpUhPKIHaPmgj8JKX0g5uy1UvIP
         VkkWpR32WEFGU7+ZQenvMjSpd+8BbvPBZaaOD/DhusmlSHQxSGbij9Jv2V9k9BBWo07W
         avnkLNFfDwZRpZ1JFjsCeX2qyYrinkUlEU8lq29YrmfWnkV2D9PkpNs6St5+JvmSrAUK
         PkPL7Hey012cgBc5TdDmBffkZ+58qEq+0LZ5GsmsYVMi1X+3G1R7XIQ/0+pD3t8+436F
         qt2iZ2cwxjHQanJDZ4fanHrsJOcJDgfPdhaJAkyxLkLT8warnW5Ltt1PkGt+q3H5lYCH
         J7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239130; x=1752843930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJE3CLjEeonNUb8mT2xwmsMp3adhwfxqmRNHfpesc2o=;
        b=kjMNzomiL+OijMpj1xZOY8cAy7titWnnT7BVpHy5ZtfXkbsI8xaxjl5X9S3mexagtG
         9hclqmofps7PwsXBQWxfBNXoX+LtdZjmASmgWde1nwBGgSN2MMbVYK6yylC1Uczxe99i
         0/6loswXcBAuxu5FvWQoY9bC6YI0Gqv0GGibaltwOvuj8aCNyfFnagVunPirE4f4lCUQ
         SdanUzFgbW6JCMYSYy+wHyU3H7hmNlMbqkDaJ5GcT3ONWVPek5X5YakakhqvbSYV0woW
         j8p+sX2LAXP9EYu5Q54psZo3b2r9IzSuC9djcr6VotcNRNnLp1ng/J4cnA5XFPJGz0cg
         QnAA==
X-Forwarded-Encrypted: i=1; AJvYcCWczQOKBq73pBgEmHpv1UUn5gHKBdAl6sBa5DCIK3OB2MjOs2IXmOjZV18b3RoDqZCHtt6hxoJ1Y5tHbZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrTCK3TCqxKQ4PwVM8VN116lli7hU3r5ICf9pf/9aXlkCCWN6
	8YnEENwg7Ui2N7u3IzRDid/qH23hegSFUH7Di0tHYJM3dqBew6yOppE72zR32TRAz9cd+/kK/Tb
	Kiz8HTCKog0av/EMBsi8JVQcQjUQxwWp78KmtBlXZq58z7DtnHecK
X-Gm-Gg: ASbGncsshgXdjC+j7A3OPCfe9wP9cMd9Z3vCxbIHlnj+PMeU+nKW16QOXeZ8st7C2xy
	3c2XBKq/NMc2LUJItulw80ubMoejWNNzSFAmWdL/gnmsRRKGhOh3oXnKawqruqgN8GDZDFo4Y+b
	ut8/lS6NC3WDPCbF8QahHbXjHkx68IGYd8RP2vgm2UymXwYElphb+XPI93HeEhwLW7VmCckZcL0
	Vo3N7ER
X-Google-Smtp-Source: AGHT+IEPU9SyMA3ByH+HpMG+YsQr79SQw8svyUaMdhj2IE3tiGFc6RjWYvNGPYPV7cSMIf3tPt5HkTmZtilB6ri5/o4=
X-Received: by 2002:a05:6e02:2682:b0:3dd:b5ef:4556 with SMTP id
 e9e14a558f8ab-3e253341fe2mr44338105ab.18.1752239130172; Fri, 11 Jul 2025
 06:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707035345.17494-1-apatel@ventanamicro.com>
In-Reply-To: <20250707035345.17494-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 11 Jul 2025 18:35:17 +0530
X-Gm-Features: Ac12FXwUE-a6Xf4G6F5Wb87U6THpUu9QoAOdL2yGtZJMrmr3dB1cTnbnWmVVvS8
Message-ID: <CAAhSdy17yUD=7aMcX2VuFHm+1-TQ6jhwsnPJAQsGS_AmmP1WCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Few timer and AIA fixes for KVM RISC-V
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:23=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> The RISC-V Privileged specificaiton says the following: "WFI is also
> required to resume execution for locally enabled interrupts pending
> at any privilege level, regardless of the global interrupt enable at
> each privilege level."
>
> Based on the above, if there is pending VS-timer interrupt when the
> host (aka HS-mode) executes WFI then such a WFI will simply become NOP
> and not do anything. This result in QEMU RISC-V consuming a lot of CPU
> time on the x86 machine where it is running. The PATCH1 solves this
> issue by adding appropriate cleanup in KVM RISC-V timer virtualization.
>
> As a result PATCH1, race conditions in updating HGEI[E|P] CSRs when a
> VCPU is moved from one host CPU to another are being observed on QEMU
> so the PATCH2 tries to minimize the chances of these race conditions.
>
> Changes since v1:
>  - Added more details about race condition in PATCH2 commit description.
>
> Anup Patel (2):
>   RISC-V: KVM: Disable vstimecmp before exiting to user-space
>   RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC virtualization
>
>  arch/riscv/include/asm/kvm_aia.h |  4 ++-
>  arch/riscv/kvm/aia.c             | 51 +++++---------------------------
>  arch/riscv/kvm/aia_imsic.c       | 45 ++++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu.c            |  2 --
>  arch/riscv/kvm/vcpu_timer.c      | 16 ++++++++++
>  5 files changed, 71 insertions(+), 47 deletions(-)
>

Queued this series as fixes for Linux-6.16

I have taken care of the comment on PATCH2 at the time of queuing.

Thanks,
Anup

