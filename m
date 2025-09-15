Return-Path: <linux-kernel+bounces-817170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC91B57EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D3781625A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77031B839;
	Mon, 15 Sep 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MC5zVDPF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F3324B23
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946019; cv=none; b=dn7MC9pQT2TMy6G1dZFUS+xCeZd0Wfd939qwLMT+txwOdrl5Q6aukEN4P4L3ZH6yHC8jQarxxyLsK5WEo8qnxXxhBq3qlvel/P5yhJiJxVazXouTjkiX/rqlrGkLCEolwtj4LOUOJE973lVwTNwglHzQjMDR+55YiEQmzODQLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946019; c=relaxed/simple;
	bh=KGdxWXfKLxUKbYRfztZbgWFxpRI2WsS7c/yogcfrqAU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=PfK2m8JXmo950AMiGozyXl4SD7Za/hk/vjy2S/ksDylHsn2aUfMeEPmfug7Esrfw1b7F6Q5dB+V/PZ1O+DV8cpbDNjygHv2fHoKWwFBApbg8dg7QC3O37aAybVuFnsByZRbwu9JgrrSZ7GvgB7TbUeSAVjiZ5aOw+KzprJQsmSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MC5zVDPF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e1a31c692bso100053f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757946016; x=1758550816; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HOBdKdBeIE5LskiTRckXQqXZ27Bu0OLdpEVHzR/yBs=;
        b=MC5zVDPFb/zXTSTGX7wGw1oz6rYp371WjrB3eqTAomnzgJV6e6c5nv2dy6Wa7pSDBY
         9aGCO6j9A/sLER/wghwFeRMj1PXTDq7zVgQSy7LPqQqT1UnHMakRyzZy8Q+JxTLR/dap
         v2qJfN9HzWhbrdyaENd1HD2HiLRc9+bPCQN9VcUb2Zpf58LbJgIk5dRG7yoIy9cWxqyB
         1DZO1XxLBSVhcrH+7czAWVsN1KNt7q5jc1AKWbXVfybX5vBVZoRutCcsA9nJnx64WcdF
         1Vd2cOCFRsLPfastHaxJ7JDjIbELKaax4h0wX/Nr5Ew37omjfuRy8WNmuzDJAuB1Filp
         c0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946016; x=1758550816;
        h=in-reply-to:references:to:cc:subject:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HOBdKdBeIE5LskiTRckXQqXZ27Bu0OLdpEVHzR/yBs=;
        b=fv1jo/BxQ3NKiqI3WsLkEBEh/npZekDC++y3UBAckt0f618WX80WrHHSV//Z5WaD5b
         JWpcvt6FfxeJfEAxoHSjX4e891Bu5o5V+GNvPod3btio3BczJFaS4D6GrhDLEDyo5Q/n
         NmYPik4Rb5Lx5pcyEFefyDUmeBKgWgwvnl8EM5oWVZtCtQqoRiuB1pHzR1VaDVBFE6RY
         gOW4spIuhSIs7NqbrgCsNo99EuliDYg8BokDG8Rn4j6U1QbITxAHSLy4JhjrctvkG0Fp
         3KxPvkhZPbbbdY72pmr0sVaQ+OWsR/I8BX85GSsCGy0qrIZNpG5mCXg0iMe03ATthm8d
         pByg==
X-Forwarded-Encrypted: i=1; AJvYcCVjKGK17XTpx19V/LIciktD/oCZx76pCPsapNQZZT+COXJ2riDuZwWwsgScvfKhCPmIi+U5iocYYcfa450=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg07SUxzB68+f4KkGVDLA1Hq2smh3Il/rNlc2rY2aj4tu+in/i
	ixPyO/VIyQdO3FoaGEoMQdpb/SV1t43qP0+3rCTavCoB43C96NyfLJZUTTFBpDf7I1g=
X-Gm-Gg: ASbGncsbFcPyUpvEe49r+6JhYqjybXOd55lEwhkcTS1Q3JkXLy1uVZRqS/jUiMjEvAe
	0IlYVtU2ZLzZwnEnv4chMcJL/Biua7UA9xBaZpLciSMkLkHzd8CO+l6tjMhgzo9G3kV7pWZk9Qv
	lhosPrveoQ+yylPrvr1EwNCXbcIzKblS6FEEvfwnATNXrRfAsHAFB19yvAKVvDihfoCVfHx9p25
	YlstJfqrq8ee/J/1E/JOH0iDt8UjLEQM0t9y8jNJrD8okPj7ZYRmJqbFWPIP34Rc0YxwJm96Tb/
	79L6y72EU/hOrG4ml3mtsJguXAOLshGWhMI6U/gfKHphbKtkuDsA2RNV5rsN3vCkxio5jpM1Dfw
	XbDupv6Y+fcg=
X-Google-Smtp-Source: AGHT+IEr9ywKHT8W8C37v/Lf/D76aQexJpKD96gz1cziMZ3TMNCvKPnp0aeaGYo/6Ls07zNiG8J5VQ==
X-Received: by 2002:a05:6000:2008:b0:3ea:6680:8fc6 with SMTP id ffacd0b85a97d-3ea668092cemr1775272f8f.3.1757946016139;
        Mon, 15 Sep 2025 07:20:16 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::bfbb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e9c2954b10sm6780169f8f.50.2025.09.15.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:20:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 16:19:21 +0200
Message-Id: <DCTFU1UCDSZZ.3J6L3T6TYTELM@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH] KVM: riscv: Power on secondary vCPUs from migration
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
To: "Jinyu Tang" <tjytimi@163.com>, "Anup Patel" <anup@brainfault.org>,
 "Atish Patra" <atish.patra@linux.dev>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Yong-Xuan Wang" <yongxuan.wang@sifive.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Nutty Liu" <nutty.liu@hotmail.com>, "Tianshun
 Sun" <stsmail163@163.com>
References: <20250915122334.1351865-1-tjytimi@163.com>
In-Reply-To: <20250915122334.1351865-1-tjytimi@163.com>

2025-09-15T20:23:34+08:00, Jinyu Tang <tjytimi@163.com>:
> The current logic keeps all secondary VCPUs powered off on their
> first run in kvm_arch_vcpu_postcreate(), relying on the boot VCPU=20
> to wake them up by sbi call. This is correct for a fresh VM start,
> where VCPUs begin execution at the bootaddress (0x80000000).
>
> However, this behavior is not suitable for VCPUs that are being
> restored from a state (e.g., during migration resume or snapshot
> load). These VCPUs have a saved program counter (sepc). Forcing
> them to wait for a wake-up from the boot VCPU, which may not
> happen or may happen incorrectly, leaves them in a stuck state
> when using Qemu to migration if smp is larger than one.
>
> So check a cold start and a warm resumption by the value of the=20
> guest's sepc register. If the VCPU is running for the first time=20
> *and* its sepc is not the hardware boot address, it indicates a=20
> resumed vCPU that must be powered on immediately to continue=20
> execution from its saved context.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Tested-by: Tianshun Sun <stsmail163@163.com>
> ---

I don't like this approach.  Userspace controls the state of the VM, and
KVM shouldn't randomly change the state that userspace wants.

> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> @@ -867,8 +867,16 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	struct kvm_cpu_trap trap;
>  	struct kvm_run *run =3D vcpu->run;
> =20
> -	if (!vcpu->arch.ran_atleast_once)
> +	if (!vcpu->arch.ran_atleast_once) {
>  		kvm_riscv_vcpu_setup_config(vcpu);
> +		/*
> +		 * For VCPUs that are resuming (e.g., from migration)
> +		 * and not starting from the boot address, explicitly
> +		 * power them on.
> +		 */
> +		if (vcpu->arch.guest_context.sepc !=3D 0x80000000)

Offlined VCPUs are not guaranteed to have sepc =3D=3D 0x80000000, so this
patch would incorrectly wake them up.
(Depending on vcpu->arch.ran_atleast_once is flaky at best as well.)

Please try to fix userspace instead,

Thanks.

