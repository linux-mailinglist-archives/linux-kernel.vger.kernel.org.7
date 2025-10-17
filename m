Return-Path: <linux-kernel+bounces-857213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B6BE634A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108805E7EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143825228C;
	Fri, 17 Oct 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VPH59p0c"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520DA21FF3F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671435; cv=none; b=PdV1ZwNUoWE8pINoN41vTtmFdUaiIWmk0LXx4gJ/wF6vax3v9065ZnhBuxHqAAhTwcqS2d0EWYvN4ahNlT7JAaX+4+uC8ajOVXHjiSMaaqz9a9hhz264eOy6Mkld+8pznA4riTqREVKPgwN4Sm9ZBNQGRydhVWOs8IYBgKOX40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671435; c=relaxed/simple;
	bh=nxjOPyq7o8O+c0jeIf8RgCVbVleVOizSHv6JGkn8fP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tebf4OceUjHvm0dK9F34X1tJbeu+fDjkItxUuPY/MnurnTKyqrbjjZ+zwC/0ggNc3nU65gp9egJkqOaNH18ghkDno5fg/T8vzoQt5OXKPiqwIj62LdZe3kRzt4Ia7eVSh+C+rpti8I88WJVL14TlFUQyg8W6VQw7h8kkwEzBHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VPH59p0c; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5818de29d15so1795211e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760671431; x=1761276231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgJbpEilKc76eN6ORe40tn9wWSRIn1nbjUiD28It3k8=;
        b=VPH59p0czOSHS0RL1EC2ApNNOWmyb4H1IoISge2HbT/tpRtSIjuVfYH5sbF8o3MJEn
         siN+ZvUTGkHpHxuh8GxBRn+ck4lhq4Pl6Ff8MfQCGJ8LPHWeZyCCLT0SQrs9wb0RdjBP
         ILtNG4EPfj0syJvflGOALJ+qAzlVZUdTZ6ObWXfidnz6ZG4+P4jJXdYENPaFoPaBlOrr
         A835+vMd2FchLzjgRO+gKxwIv5wNHv8cUHjwPOY4cfB2Oh8kuy6oWl9evkxpTzaSz+bt
         qMp/icukGEa3D2WjgPypYOPhZArE1av7zr9WFzSQOeJTxPNsDsEe8eZ/Ax8aF3Q7PLKx
         9V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760671431; x=1761276231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgJbpEilKc76eN6ORe40tn9wWSRIn1nbjUiD28It3k8=;
        b=FJvsjGlOY0Ue2Kga3qfXIRKrOq5eM4mMmHQ0JBy990H9jnoOvPDXjbOxtwGBiPxklc
         119exqBBQWwmQ1udfuAT+c1rv1wyCyolQWd98rqt1HxdhKYLP2P2Z96DDhRv3mtM8FEd
         TmeQ1KaPtcT3xJdIVQw0++87U6qWFA5GyMG/3RpvoNWlqqLcq2eBnGAs51WiaYjFsRyS
         6fIvpMNIuSKg48K5/DZRpFYJneUc++/MZRcZtPLUW27yJp19xevjc/usxqU4oKmU558t
         4INqPtcQONt3EYf+dlJ5Se7Uok5rE2F5I66mCEmWNJuudAmY84+28dXn+mZ2gcikyQY5
         zEDA==
X-Forwarded-Encrypted: i=1; AJvYcCVVbaGnvAfkZA4QCZMq5F2xN3Q2CACfUCuk9YxoP5C6jiFStdbmyKERy+rZdCTGwysk9Hq50sNgqhYIOwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSG+/Gf+OyWEnSdp49Indy4QwCDtexaC154vEMQeqYv8BFEB4
	eauX/w42XA8hVPbdkF0OSDEy6ncQwRcvs807b97uBM/AQHXYjlO3zr+jqe8A17FAZQtIS3VxjJn
	eceHkEnMBcoqxBb1xzmmEpz09mnO54QrKtG7bUtHtyw==
X-Gm-Gg: ASbGncu4CT1KORSQI1ss1dmyc/mAoepzzkwPRQWLDvRPlihxULHjS6UyQM+D8pO0bgT
	NvRBgFgmVadMkUlsXytlK7l/p8IKIv+o9c3xD09vIfMfzoLBNMZRGiI6VI/a5EtuMPEK0LZZXi7
	BA+WpTAOIfl53uWFIoyRkTuyvwvQbjiqKIMQbiDazMdc6W7SRYeAC3Qyspz7NvgBRrb9cq5PdYy
	E1JvaIdBAxxgfB2Ka0RNCwiS1SDg2h1HsK7/g+GT2HCT5PAHH2is95MRUZXhLGSvSF8gQxV
X-Google-Smtp-Source: AGHT+IElSKtdIpALk1nSLovdiSg+YYsyRQZSurzM1kakr9yrGs4N9sEcb79hjU8qjRKyDo4eqHVmU9r98WccWB5VKkE=
X-Received: by 2002:a05:6512:3f12:b0:577:9ee:7d57 with SMTP id
 2adb3069b0e04-591d85a2146mr785397e87.46.1760671431298; Thu, 16 Oct 2025
 20:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016001714.3889380-1-samuel.holland@sifive.com>
In-Reply-To: <20251016001714.3889380-1-samuel.holland@sifive.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 17 Oct 2025 08:53:39 +0530
X-Gm-Features: AS18NWAHiotLWgrvaFJ0yhxbbAeGChAh_woFA4Y002T2jSkQKffZFvzyYjf0LZs
Message-ID: <CAK9=C2W7-+UnWHZyTNkwTRy-=E5vjUNTjvq9PSCrLVZsY4b56g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Fix check for local interrupts on riscv32
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:47=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> To set all 64 bits in the mask on a 32-bit system, the constant must
> have type `unsigned long long`.
>
> Fixes: 6b1e8ba4bac4 ("RISC-V: KVM: Use bitmap for irqs_pending and irqs_p=
ending_mask")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Queued this patch for Linux-6.18 fixes.

Thanks,
Anup

> ---
>
>  arch/riscv/kvm/vcpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index bccb919ca615..5ce35aba6069 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -212,7 +212,7 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
>
>  int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
>  {
> -       return (kvm_riscv_vcpu_has_interrupts(vcpu, -1UL) &&
> +       return (kvm_riscv_vcpu_has_interrupts(vcpu, -1ULL) &&
>                 !kvm_riscv_vcpu_stopped(vcpu) && !vcpu->arch.pause);
>  }
>
> --
> 2.47.2
>
> base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
> branch: up/kvm-aia-fix
>

