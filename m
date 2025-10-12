Return-Path: <linux-kernel+bounces-849413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0610BD00EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A153BA94A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAB26158B;
	Sun, 12 Oct 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ5ZgK0v"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417F23C8CD
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760263254; cv=none; b=plCITkM098GUzekgbkQwYxYGbvty0QDKP9BkjyOrk9MxaLeukFnvOZY8Qz1YLUPJ2uRqTkR96wFFqUg2R3czNhDAvlOsh3QuxMMcXMwU8PEuiJC4fOeX0Q3+OkBwh61hJ36w+T1LleR6z7ETFmprVDjunH/LQGbIBRKAQqSNhpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760263254; c=relaxed/simple;
	bh=wpudRJHbEioQuN4UauHS/1tEcButeCyDUb6TAxiOlnU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XBpXn+tKW9i8ncmOeWE6IIbhmE83FCefBNSU/H2sZ579qdHLwYl6L556lbU+p7PArlsce/AsBZ4u5Ae/6lr6I8VoJmOTXACU8mbLZ6ywwuqxcB/02VBtbcnjUs/viFdg3UiIHjyri72b5b5NXI4dB+cuZMWUPoIhH6RyfQZqcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ5ZgK0v; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782e93932ffso3033693b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760263252; x=1760868052; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOHaWmiMIWsfnsqK/UODnLWGPAfQByTmpbDvN/YjQjo=;
        b=mQ5ZgK0vYLsWwgunAf9+8sOq+X0dHRStZZZojOQApVeoBlhwy3LIV0BErAmZiOs7uw
         d7pEZZ1sEGQIXG/Fm64onJb2VtQ372xXdQTjNeAeimIzONJgjfDaChe09VzN7QPJeu1+
         oHv8tRjCLjXdBgCPNIzs5S6fmW8hdNs9mUAI1q/fRTqWNSr4FyGdEFpu8CgZL1TKUIkA
         S+KjPOIg0TB7E+M/8RcK88jVe9kPZZ3cSzPWsHHTD98U8jC7GZwuXavF/x+Hq4MshY8U
         btyLoyOLZFi8kNMxFp+CsedT+5auyYeplWRtzfOv8HyJ6PW+kJANvk900sQM/v7cvs9d
         gjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760263252; x=1760868052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOHaWmiMIWsfnsqK/UODnLWGPAfQByTmpbDvN/YjQjo=;
        b=wykpOYTcs/mie0++4VzM8GoPfAkwCY+xQg19OtNRM9N7t/oG8Dt1UIFXBQYRBzY7b3
         M8j6PupJYetgc8YAYgy2wAeTddRrh0TafkBNayib14kuhxf8+Bwl/Pdlv/rVMbpkcbY1
         xD4uiHmmIR0dSXVwovuusC2/jJjgsigQth0uitGi1W51p3XdY6qeKoOsMUTuht0MVfyi
         8Je21nC7YiuMQBZmIBubWM0j1IqKH3HH6+34Ty8SYJgsbC7Yt68rmqbAG2Fs4UjAk7k8
         NAsLVMMAh949t/iVKtwbOeauSuL2TE8FrqBTb4QbnE/y/Hoj0h3jgCa9oblPCBcbrkZ2
         o5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXi2Gu9OM1v/juJArk/XOucKgeFysDJiMKdhn1+ndE7phhQ0mOVjTgJzHKT65GXqV5ptKuJ+QfdhcTw0zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiiHJDOG/OsLy+Mc5OzAOfRPS4fBm4bdakamFqWyuyejo+pNF
	daSM7TcyXNCh+wZ7GVPwPba1mizBsNRPOsO467+JnArGWQSYawCar4di
X-Gm-Gg: ASbGnctgUcvjkZjSnMZSlkmBnUm3fXZ4usmA2qyWFMXmx9VeFyOGd0Sm2U7+HhAtRUL
	At/Eo3RuI1Uc/VlU0DSmBP5nrq6vZv+QTJXWsMYLM8/cYR+yPFk75QX8p9WtzbiLBETwPMSlD2d
	WF0ofL2A4EQMfHWD0Xa5c4gfDwkS+hGG63VITOCSZ6p3kGE3jWmwwV2HD2oaMJP5kqo8TYvmw8S
	6xB4fpfFF8eDPIpwhtm1scJZrOjoP3QgdfPF9n1LVWJXKvQoVtNLUFaQfMqVMBNLvN0y3CaqdaD
	di8eXOJnxJP3qKQcXnj0hXRHGjqF0XppMUNHTlywkx0/ucaSYclRJTVT7rODLoCdBVEWhOpwGpa
	kEPOtIu1t1Sd71dGceioFHD+kZtPe/AokuSqiwR7E3dOp/9s851vAD0p2vgA=
X-Google-Smtp-Source: AGHT+IGR0V8U3XPFSEQ92xPF/qaoVuLh0K0KP8mjdP0djmlSm75II8OCfN78JtkG44a0dNK+bpvvEw==
X-Received: by 2002:a05:6a00:180c:b0:781:259b:b5f8 with SMTP id d2e1a72fcca58-79385ce2732mr21092716b3a.13.1760263252060;
        Sun, 12 Oct 2025 03:00:52 -0700 (PDT)
Received: from smtpclient.apple ([103.142.140.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b820asm7979898b3a.67.2025.10.12.03.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Oct 2025 03:00:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] RISC-V: Define pgprot_dmacoherent() for non-coherent
 devices
From: "Han Gao (Revy)" <rabenda.cn@gmail.com>
In-Reply-To: <20250820152316.1012757-1-apatel@ventanamicro.com>
Date: Sun, 12 Oct 2025 18:00:36 +0800
Cc: "Han Gao (Revy)" <rabenda.cn@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Atish Patra <atish.patra@linux.dev>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <031395FE-C51C-45A7-85A3-CC4A25EB6066@gmail.com>
References: <20250820152316.1012757-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On Aug 20, 2025, at 23:23, Anup Patel <apatel@ventanamicro.com> wrote:
>=20
> The pgprot_dmacoherent() is used when allocating memory for
> non-coherent devices and by default pgprot_dmacoherent() is
> same as pgprot_noncached() unless architecture overrides it.
>=20
> Currently, there is no pgprot_dmacoherent() definition for
> RISC-V hence non-coherent device memory is being mapped as
> IO thereby making CPU access to such memory slow.
>=20
> Define pgprot_dmacoherent() to be same as pgprot_writecombine()
> for RISC-V so that CPU access non-coherent device memory as
> NOCACHE which is better than accessing it as IO.
>=20
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
> ---
> arch/riscv/include/asm/pgtable.h | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/pgtable.h =
b/arch/riscv/include/asm/pgtable.h
> index 91697fbf1f90..00d8bdaf1e8d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -653,6 +653,8 @@ static inline pgprot_t =
pgprot_writecombine(pgprot_t _prot)
> return __pgprot(prot);
> }
>=20
> +#define pgprot_dmacoherent pgprot_writecombine
> +
> /*
>  * Both Svade and Svadu control the hardware behavior when the PTE A/D =
bits need to be set. By
>  * default the M-mode firmware enables the hardware updating scheme =
when only Svadu is present in
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20


