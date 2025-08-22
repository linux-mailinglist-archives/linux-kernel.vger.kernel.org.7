Return-Path: <linux-kernel+bounces-781745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C77B3162B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8965F3ACA61
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B1B2ECD3F;
	Fri, 22 Aug 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="H4/Z6Pby"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D12327A3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861414; cv=none; b=b2P/QrP0VepBroijMHPhmmnKWvckBvWguSocBOxHVojJ+el0kzfEW7/rPavxR1MxQLZPDQtPZib9VphfDaQKdy4m4N3ESy2hmuL6YmuMvWfHUvkKHpy+Jkz+bIMtElIntPArDkhbtFWJwMRh65/cSsHoMADjROR5LJ6iTZvfkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861414; c=relaxed/simple;
	bh=EnVRyJysqSZwi8MQGqg2qst/Kg6P27YOfLXyF05YSm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9ue0vn/uISigbC/iSyJUn3r2LRd1LChvLATehzyYJXLlXDJzpj/OVc4OOI4+xRjf03OzsN5R27f0zp3aS7bI4xo1iwciyIo0nooey/EY7WHrHv4rzQMhaZc0TlnvC/sumnrRKPJ6+vYHOI11JWyBY9Fh5N/0jOjyorAOtSIcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=H4/Z6Pby; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e67d83ed72so19353045ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1755861412; x=1756466212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q/jRAhPC0Tmtp2ISTMDpD9VBCqxj20vPKIcSTLHsWE=;
        b=H4/Z6PbynrbE5e9mnQqSLoQ+BkUjEcilLRbMs+pdvSn+g+L11VnGuSPFqLABPJhTap
         eUNjp9a+f1B1rm28mqtECGzv+YXMTfSPfmrpXxZ1ggQn4+oksA01Gp3v82vkomo3/wgK
         UqG4t5rYJrt2x4xP8TLG0PatjNS2D7lRGlIF87rPoB+R3xodtMFOxj+pQho1lqYx05Su
         uDCysfhRebe1OTfEFFAoXwT8DwaL+PpdHD5vvveiqebtsgSKuXiVtJtouHkPMqBMlJH0
         hWtPt9w9fhwcMRcLFZeMgx4hRZ5fO9XTYJ/4Wl1bvF30iDoCETZv514NcBPxmp4745cD
         mY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861412; x=1756466212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q/jRAhPC0Tmtp2ISTMDpD9VBCqxj20vPKIcSTLHsWE=;
        b=DALsA40Fo6bbQaxM2Gk0NreN31bbcf3EmuKiz+L8riiCv+rMqo4gIIajcCd9HDXDGO
         N2h8k6Z+OFKh5t3i2mnrs0Xuyu3HoJcHZvw/dShR3BbWA6YIQFmXj8QJ+hEiVSQ1OAz6
         4/L2puT4wne8M2kVF6NVnufL+lSofM+1vFGZ1OXSFkQAi9I+iIawESBoOAHaJRw5szDZ
         8nT734jH9m8hHQ1r8EOo9p067kdbsJIhkp75sTCxLyFbDMAj7SBQ3N+xr9LUsiN4iYs6
         FccnAmNkzZnLIpCjFpumx2HOIUf7/jnzItNXBAZc4tNJA2UJWszDQlP0cJbflL3nvaL7
         8w3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL4kG/khTqyy6KhQE5fP2C0Bs48A5Ezulm08jQG6avFVVGPpYntE37xDxfHbzHV50BJmxJTGwMZf8TGMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3MGrjJXK26CD3/5JSKjCxLLR7slTjmKljzcdktJvwln6lPpc
	ySKWYR+uTZy3/o9teZuFBZ5coQ9bvHGMPj0bpGwsC5z0a8SeJ0zvvX3Ye65DZcKxI8DIXq+AZNw
	R72/nfNmidhhqkNNUucqbdMZr2xqoFI+wybaZjupaVQ==
X-Gm-Gg: ASbGncvo//mIcOBH1tdAE9Ga58nRH5xFf12udlLBGQ9ac5b/LkEdchwFVRyA3jMnjFl
	TqaU4ENgQUmWMYMnhjwJEBbxBp7x7emsFWVkzO+gRYzfYnGUNkmuM4GYrXKS1SS6yUtbqD+PPQf
	klugeEBMoHOLmW2AFsx8+RA9VhHymuGS3VaLvQqHaHXaHekKqoqzQs5ejUasUn7yEovCzqVU89u
	/Dt5qI+E40hWoOT6R0=
X-Google-Smtp-Source: AGHT+IEf3catLTwMZg08ITt9v+soiykhih7JmD1rfhONXLyWgFCvIw5fWgoyzMygsiEhsdJqKvljnLxwiGXIRXDHO7Q=
X-Received: by 2002:a05:6e02:220b:b0:3e9:eec4:9b7f with SMTP id
 e9e14a558f8ab-3e9eec4a13cmr7393215ab.30.1755861412296; Fri, 22 Aug 2025
 04:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49680363098c45516ec4b305283d662d26fa9386.1754326285.git.zhouquan@iscas.ac.cn>
In-Reply-To: <49680363098c45516ec4b305283d662d26fa9386.1754326285.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Aug 2025 16:46:39 +0530
X-Gm-Features: Ac12FXydDmBYaqaWI2oDhvXmh2nBQ17DyRxWSqA9fqFJ4rPMhrjf4Rw1RRPXrJg
Message-ID: <CAAhSdy0kpxEhz8AAiUUXapsEEGo4aMsDpSyMemr9khdYfy0OAw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Correct kvm_riscv_check_vcpu_requests() comment
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:00=E2=80=AFAM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Correct `check_vcpu_requests` to `kvm_riscv_check_vcpu_requests`.
>
> Fixes: f55ffaf89636 ("RISC-V: KVM: Enable ring-based dirty memory trackin=
g")
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Queued this as fixes for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index f001e56403f9..3ebcfffaa978 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -683,7 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  }
>
>  /**
> - * check_vcpu_requests - check and handle pending vCPU requests
> + * kvm_riscv_check_vcpu_requests - check and handle pending vCPU request=
s
>   * @vcpu:      the VCPU pointer
>   *
>   * Return: 1 if we should enter the guest
> --
> 2.34.1
>

