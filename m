Return-Path: <linux-kernel+bounces-805018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E443B48308
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A589189AA41
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9B22069A;
	Mon,  8 Sep 2025 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ruVnsDTU"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CB321C195
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303476; cv=none; b=oWz1HZm7vQutfQKDcZ6LHqv5BxXeEIy+1ta5nKuaIqNnuTjZ1B5eLC0VlL8d+8x3EdrzUsVSjYrDZ5vDF+kk7BzPHnaRV553riR+bRrzjZDrbAj0FuGU/d3zCL9HVFS2+12GtkaKtuDevt8oOYGXoNnK2PIj9FnckDvnlzcP2OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303476; c=relaxed/simple;
	bh=VklWpKh2I9KYvBx6Az/wIjIwP5yxfg17gFuk9AVjD3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADaaSGOLc3efx3kPG2L4FDNOq2xRSHQbmB1Px2J9MHSeRCo+k7PZ5+gJT+5aQFtTEh2R9uSy8Yzd88g8iXnU/Ww8CDY9j4TVW+cvZqxs0mO7Jee/2Nmg6UZt39z6aFPWrFwvtrv8I+PUmzdQaRbuDM5WRysUq5R5ZTZ5gtFWWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ruVnsDTU; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3f664c47adaso19851395ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1757303473; x=1757908273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq2toZ1MStoLsAaQpze6/oEBhlqrv8NRJsOlpJj3oRE=;
        b=ruVnsDTUrIQaiy6i3NMDxQoBTecEAwC2aRjExdIeXR8ew2Vxjs+R60+/jxYhnzkGUy
         RRMFrRc9JFWnhiurb6MG5sbe+yc7hQf0kzCRivy/pJpiDCEZrzk/TJw9FrBRdWZ/zfxH
         +AI6AvNZ5IFb8DWwX6enEamhGHPmimmyct0omVGOkqa10FW555IA2niOek4969zG+MxS
         jzuYK2fFovbxXzlOFsvdosEHpE3jR7KXaCRKNKY+bfuk6CwbgZ3Sd0MrAYk9UH8BbGbX
         P0oZeX6z/3aso+j3/QUIf8eGPkmD5RAcUziS9teZQuvFH2iD0cyCZtrhvXp9M+fcHvGV
         I+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757303473; x=1757908273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq2toZ1MStoLsAaQpze6/oEBhlqrv8NRJsOlpJj3oRE=;
        b=o+QWS3tq8prRKDI8dULzLdmm5BAvlbCnjQ3rY2gU2H9r0xMcORUW8Lk3dQZ1B3Pzi0
         U4p+CuwJcQiPmADb3RdE0duScBsrh7n8VA40Eym8ETZp8xVMKvUYyHfWvufdzVtyd7vJ
         2WvrhCdQvPh9XhMR6Tslxpbc16BSNUgjAh5HqsWuDTNXw4Rk67AHQ+ndkHQTL1U56WQo
         58IZaHtIvGm3Ut6ISOlwonKQ/QminltrCxXYbniBC1qHKSu4jaHA22KqoeJopbjvb9yA
         wa3c/v9wCJ8Sd7b35QohXq4QRxnk4r1pRtZmZIH9Bvn8QFFyhDk+RECR2ml/ALDaBYn5
         TAHw==
X-Forwarded-Encrypted: i=1; AJvYcCWDQMaIn9ktGTVIeSmDSr4IeT+XQW7y8eO50lZh7LjPIl80fTAVB81ln3FleBfd1VLcr+q7zB6OWcS3Xjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1iK/fjR0bqUaq/eLYJ/g074btoPzhTJsliuaUudzbYdeCwVw
	DGoR7znyAk/5RH/k0avZrsT4ZXlaD+VItz/rVzuVM+LAeT0HlnaAcOtJgEe8md5flRLv7MuDXU5
	KV0rO6lNT58qyq5maJYwC3Vm7eyMa480rwszvblZgwg==
X-Gm-Gg: ASbGncsxd0rIEteqFPsIpaNf79uqzOmtzOoYkwms8KwmIcJ6M+gpt3LWpBpStfNXAWF
	KxJTP8KGp8GkZglCXk4mtm8nOQSWwPCQXsT5oRZUGuNpgqSQMtBOCRpglc4lZhuTddbYroGdHYK
	b8RnS4EM+nCcJQXKsdhZSCLULj1YognoJ/ShhX24vyPE077ZXv8SJfwKy1lu18B4yzRYnCgnAhk
	1x6T6RZyrdWgP4PctlAGRFKP2jWvg8V0VCEHS8nPMnRs9ztBp8=
X-Google-Smtp-Source: AGHT+IH4WAwWrAnnu4Rq1LOrwKuZ6PLy8v3SBH2WLczbYxVUoFRkmc/aL1MGlRWWeIeFxAJfFISceCNUeP2fr23Ivao=
X-Received: by 2002:a05:6e02:1d9d:b0:3f6:80ec:bae with SMTP id
 e9e14a558f8ab-3fd853158bamr95133955ab.21.1757303473045; Sun, 07 Sep 2025
 20:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
In-Reply-To: <20250823155947.1354229-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 8 Sep 2025 09:21:00 +0530
X-Gm-Features: Ac12FXxdad2U7i621spIzbFw-GpwyPTNC5JI8CApKugYuwHXgesJ9uOvv3sJqD4
Message-ID: <CAAhSdy1jAmCeqWoPi7QpuzW4stH6U-Z0pSHmyC93jBYbSr6_xw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ONE_REG interface for SBI FWFT extension
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 9:30=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series adds ONE_REG interface for SBI FWFT extension implemented
> by KVM RISC-V. This was missed out in accepted SBI FWFT patches for
> KVM RISC-V.
>
> These patches can also be found in the riscv_kvm_fwft_one_reg_v3 branch
> at: https://github.com/avpatel/linux.git
>
> Changes since v2:
>  - Re-based on latest KVM RISC-V queue
>  - Improved FWFT ONE_REG interface to allow enabling/disabling each
>    FWFT feature from KVM userspace
>
> Changes since v1:
>  - Dropped have_state in PATCH4 as suggested by Drew
>  - Added Drew's Reviewed-by in appropriate patches
>
> Anup Patel (6):
>   RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
>   RISC-V: KVM: Introduce feature specific reset for SBI FWFT
>   RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
>   RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
>   RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
>   KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

Queued this series for Linux-6.18

Regards,
Anup

>
>  arch/riscv/include/asm/kvm_vcpu_sbi.h         |  22 +-
>  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |  15 ++
>  arch/riscv/kvm/vcpu.c                         |   3 +-
>  arch/riscv/kvm/vcpu_onereg.c                  |  60 +----
>  arch/riscv/kvm/vcpu_sbi.c                     | 172 +++++++++++--
>  arch/riscv/kvm/vcpu_sbi_fwft.c                | 227 ++++++++++++++++--
>  arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 +++--
>  .../selftests/kvm/riscv/get-reg-list.c        |  32 +++
>  9 files changed, 467 insertions(+), 128 deletions(-)
>
> --
> 2.43.0
>

