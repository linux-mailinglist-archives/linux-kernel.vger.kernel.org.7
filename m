Return-Path: <linux-kernel+bounces-817470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28BB58296
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D242A0FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA6228151E;
	Mon, 15 Sep 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ekDTUz/G"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5E27B50F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955232; cv=none; b=RTvAe5l+jigD0KwM5qIV8BVnjhglqjUJokLz4w1au8zx8BFxhNbCQ98xaU6PKc3e3LJa4O3D3RIUTqDreoFWROpI2GUr6fZrwiUvJ79lGtO4fdS47oznNV7dNHxSyUefZDdvm0qYkAvB+fpk+dsuXCKc5Ile2K+6dyrb2w2/DWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955232; c=relaxed/simple;
	bh=eQheW/NnDP7guj+7l+7Mvt2Ajz9ShwwmKhblUZw5QxE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qnb/bj8a7Txa7FHaX3dhHHnRYuKKv9VOuRw+YY7V52t44ISKu4Qch92kwkpVP9x2QrVmBzel1UnER9nDg8BWXfL7qWUCoYcSfAfwFpjg96ZtK89sssk1HY++T/6gI4F9zSvEljBvBCNF2JFISLABdrmpJSs/pC60bmR4WQtiEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ekDTUz/G; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2a662690so3375615e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757955229; x=1758560029; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMjc1jYjo0pPUV3IEMrRaUWcTH6UPkM8lTmOpgavsDM=;
        b=ekDTUz/GPCnZtGIha/0/tGJCQ+oYovdEn5KcjlpRnn5/k8e+1uBQzp19sNoYfEDyrn
         R8e6SSjZkIb1YVhz5g3kdWa3Bx5DbcnR8qsLxUspgnRfUl15N7kJ//07ABcvygWmx0BX
         w1WhJHOraTOmrmac+kuweyH1w+XIxT7oyxru9+ggqZSc92s0h5OKOIRjla3jAppznQv8
         is6+1KgzrfhZlzTDtCzDdCnhWsBWdyzsahzOxx0qTpdWJjMdiE2U5b2hPhCbjiUPlyoo
         coODBL+b2v/TwZ05PlbAppEoZvROQSux7Qw1NQPuPSXkA26oXitc/nxoVBWn3JtAu7gk
         pWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757955229; x=1758560029;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMjc1jYjo0pPUV3IEMrRaUWcTH6UPkM8lTmOpgavsDM=;
        b=GrYDCRZrz7bj0ZxK/IZ/4llb3zzXjhmEQG5jBqB11W0K25hmPV/qguvPQmUFPdubUb
         1NkqjBJ1rP5M1PJ4SoGKiByVZp+7kR1CzwsBLc8cTej8CY/GkZxp7Pprtkp8nFhgmeX5
         72IM1ejdae+YSjvTpEo7pHlhZqXFpN0QlhH9MiukRVPU2kk2I3eldyOau2X1+R41oMLk
         GsJcg3wpPKT3QmoEdMTApNxPeXztdwkZUqX7+tAIaV8ED59QtQCROHOeT4gDbzQ9mV9W
         s066vK2955UXhYyvXYPjKxsuBHJXt7chH2w1mOtGJdE14rhFzITGltvo6bpi5/4+V6gc
         ERhA==
X-Forwarded-Encrypted: i=1; AJvYcCVVaX1WikHmVmi9T9I4t+R9GvyKpqteEq4GEsrZe/gW9ATILxC8PA+jOpWVuf8xrwXvE+uUsZfxMUBauCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3XagPyzRL8ouikcN3F8chPWwM9+UWBfg6BW2F4jkVHP1regz
	QX56U6luBNSyVTh9bI00zMdiIkY1rxqiMYmGqqB0rdjRNvQxtksOKIoof9HHZfHA5MY=
X-Gm-Gg: ASbGnctjJ6PGNKGDg4BEi9aD7Du92B6e3SISaJd3tS6khvXPMUuOHLcJzlOktE60qym
	xNQG9udddZE5wU/9hwfd0eDE6bpx3FWCl5d7KXB6d3u9uAsn/Zn8RLHoeo/o7cRhF1IPK7m24GV
	IZH5FOOG055u+pPiiN909r+zIzMof0eSleUXceq/jK9ApYWaCbOHqNHrCxjdqnSL1U+8wx7BlBw
	EG+2hRKREEv9aaJVaiZdAIA4DD7J5Qhcqxb1g6zUmjaut/VJp0rTwX00OXToFMFiN8uBy93b2pt
	J9irEg9nlpeyxUlZ8L5xY1jgLfkYQC2/tkX2iHiPIom/HG2B5dsCjPNEg7GRMGgRz9B365NSE9j
	3w5ofy/+5y/JGsVkvHD2znQ==
X-Google-Smtp-Source: AGHT+IEBYG+XYWr4vSIUvW4i/gC6ebTomXgFIobLIBRml4hWNT81ZQCvn/NDrF/4mBzDZAjMlg3idw==
X-Received: by 2002:a05:6000:2008:b0:3ea:6680:8fc6 with SMTP id ffacd0b85a97d-3ea668092cemr1990129f8f.3.1757955228923;
        Mon, 15 Sep 2025 09:53:48 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::bfbb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ec22b16adesm726619f8f.13.2025.09.15.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Sep 2025 18:52:56 +0200
Message-Id: <DCTJ3N8W4PCL.9XCHFVGS62SF@ventanamicro.com>
Subject: Re: [RFC PATCH] kvm/riscv: Add ctxsstatus and ctxhstatus for
 migration
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Tianshun Sun" <stsmail163@163.com>
To: "Jinyu Tang" <tjytimi@163.com>, "Anup Patel" <anup@brainfault.org>,
 "Atish Patra" <atish.patra@linux.dev>, "Andrew Jones"
 <ajones@ventanamicro.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Yong-Xuan Wang" <yongxuan.wang@sifive.com>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Nutty Liu" <nutty.liu@hotmail.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250915152731.1371067-1-tjytimi@163.com>
In-Reply-To: <20250915152731.1371067-1-tjytimi@163.com>

2025-09-15T23:27:31+08:00, Jinyu Tang <tjytimi@163.com>:
> When migrating a VM which guest running in user mode=20
> (e.g., executing a while(1) application), the target=20
> VM fails to run because it loses the information of=20
> guest_context.hstatus and guest_context.sstatus. The=20
> VM uses the initialized values instead of the correct ones.
>
> This patch adds two new context registers (ctxsstatus and=20
> ctxhstatus) to the kvm_vcpu_csr structure and implements=20
> the necessary KVM get and set logic to preserve these values=20
> during migration.
>
> QEMU needs to be updated to support these new registers.
> See https://github.com/tjy-zhu/qemu
> for the corresponding QEMU changes.
>
> I'm not sure if adding these CSR registers is a right way. RISCV
> KVM doesn't have API to save these two context csrs now. I will
> submit the corresponding QEMU patch to the QEMU community if
> KVM has API to get and set them.

I don't think it is...

> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Tested-by: Tianshun Sun <stsmail163@163.com>
> ---
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> @@ -489,6 +489,12 @@ static int kvm_riscv_vcpu_general_get_csr(struct kvm=
_vcpu *vcpu,
>  	if (reg_num >=3D sizeof(struct kvm_riscv_csr) / sizeof(unsigned long))
>  		return -ENOENT;
> =20
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(ctxsstatus))
> +		csr->ctxsstatus =3D vcpu->arch.guest_context.sstatus;

Userspace can set guest privilege mode via KVM_REG_RISCV_CORE_REG(mode).

This does propagate to guest_context.sstatus, which is otherwise
internal KVM state, so we definitely shouldn't expose it directly.

> +
> +	if (reg_num =3D=3D KVM_REG_RISCV_CSR_REG(ctxhstatus))
> +		csr->ctxhstatus =3D vcpu->arch.guest_context.hstatus;

Neither should userspace be able to directly set hstatus.
KVM should derive it from other userspace configuration.

What isn't correctly reflected in hstatus?

Thanks.

