Return-Path: <linux-kernel+bounces-855848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48EBE2798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D503E4BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFD3191BD;
	Thu, 16 Oct 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ovYtCXYA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF96B2192EA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607749; cv=none; b=hBppxR0UjlgTx9WKE0hAuN20AHROh7o9uj7GHgr4hi4/jGVNRzeBUAwJxsHIChQCguFVylg5gBj86w3BXCpjD3PstbqMa7gLT0fdYuEbBUDYf03+fK7n8D5t1C0ABHb16ZgoJV40SJK80uWQYu4bNAKQQmI5BeyuSvs/iUiSuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607749; c=relaxed/simple;
	bh=TJql0MjlEkwtBqWMGqsTiMFcJvnVskrr/wExZvOMmAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzUeOJa0VB8DlxnJFSr57LyMP1JVZObu1RYMhXSRjpp8nVghPZCvZ691HdLTPGGhp2P/mFOEAuM07h/BzVsWenIPPoAK5wqXaCYvIBUmWk3E3/ejfabfdsbmFsrNr7lfmy3JwySv4S1Zilg3Dlh9GtpqK+Rmq+M5enHSCtAeRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ovYtCXYA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso517972b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760607747; x=1761212547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XT2WFxsGOH83YnSrOTwI7TIxuKSwIlmbX1n8UfKEr10=;
        b=ovYtCXYAqfWsKhOfcBA9yxBXJwbS4gehvUGTzor4oLgqb4kdSkM85P3qeRZpByL6Xr
         +6aKoAnBmsABh40hGijspdQzuCmTp0kuvzM7zA3pa27kH9JPd3zBhl2rQn0+XwwfPArP
         dYtv4tQ3xgWNje2B8EDfHdZ2+dxNLTB4i6UzvoKLTr1UzUv2rDNF6BD+8Jzd4Jad1GEu
         gd5mkS+e4kqyb7dj6iTAfMVMebi2pY6K0li9mu7Q4T8zfgj639u0lfuOp04EmvkbJlz+
         XEaD9mXpijB3Z1opoXhmnOEszUqadiKTabW9MaFRAHOT4JX6POCOMP7ywS/U2gPH7WLp
         P8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760607747; x=1761212547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT2WFxsGOH83YnSrOTwI7TIxuKSwIlmbX1n8UfKEr10=;
        b=bfe6gI/73oAZ8AVBqFm+sWxFz48aRQdbkhRufrlf8qeDzB5hbcblXkI4Ov0OOStU0w
         2vYAbSV64RnXdx8bZsl9nGMgcY24IpQ2nExPmlHub0G16rGauoAipz00XT32yd5HqZIA
         jJ4tOLAP2oIH5iccIYshe6sj0KXnQ3OOHQEyMBBEi4Z2iTE2bI8aLKpJrtyWr+PGq16U
         yS7lWKhXi+2k74ErhNy1WupyL5riNKuWjOM/kbZqVwLsf+ei57PBLeke7ilJeUH5DzKZ
         H6t/24iZ5KGNehmb4DuNy4St4Bkhoipi7et1nfPf7Ymo7XvV+CaVZUIK3AqyR2B3rvC+
         lihQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1rcAVtJzrg/A0UnS/RAqbh5L8LKEdBsLp5g+HimQxi+LOewlcVU7TyWJq2Z3FYhMrtf2D9uerCujPIf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTnAuPuyH8bwkL1vxTpM0Ejzgz1/iNIUx1a/iz8uMsr9mhp/3
	gGdab/rFEFZcj+0tW5WKIgkHgfl5IDGTh4EOPl7bFelaru49hhN3LVFMVBpi6+IoUJQ=
X-Gm-Gg: ASbGnct9TwJDSTXpwIB8Zq0HDYJjxaI+0RlBRp7rDA/lMK0Eaoz+xJqvG5DvT+uY5Vl
	dLZP31zsxISlg0mE8UarozsAaJbVA3weCmiQyHbWJsfiDh6xVU2998EnQ15AnWxjKto6KiEFbrm
	8RdIUJFpAHNkikbM5MzKTFR6LNIP3X9g4Y0F1vwpfNelEMWE5CXHhxmd1hg9qcEted8chhAMdPD
	PzaQHHEP+x6nAz9DGmgX1qJ9zPBynXU6UFoSl8fK1ZhdLf5ZH3Jpgmn0qBngBX83B5pgWO6AkGw
	SHVmI539A9INekO1kQ5I25vHDbxkK015nkmGPz56K3XMh17t6BT6aR/LNQdLJlNQ6IjE8GEWGPB
	ek5Hb6sc1ufRiBKQbmIoGLZX9kv89vItgq6ytq1Egb5VtHv0UQ/y9ipnr0p1wRoMqeXmSPvxTMA
	0UeqPeLEPXu7js
X-Google-Smtp-Source: AGHT+IHCkThTNuYCNDPFDMoaZ326MNb+xnCy44BX/ER0JzSky2C3Wp9VABYjJvXunm9KzBwzZGmmPw==
X-Received: by 2002:a05:6a00:179b:b0:782:2b62:8188 with SMTP id d2e1a72fcca58-79387242eeemr41932448b3a.15.1760607747335;
        Thu, 16 Oct 2025 02:42:27 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d9932edsm21496728b3a.73.2025.10.16.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:42:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:42:25 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: KVM: Fix check for local interrupts on riscv32
Message-ID: <20251016-7a89633477ad3dd0ae6eb969@orel>
References: <20251016001714.3889380-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016001714.3889380-1-samuel.holland@sifive.com>

On Wed, Oct 15, 2025 at 05:17:09PM -0700, Samuel Holland wrote:
> To set all 64 bits in the mask on a 32-bit system, the constant must
> have type `unsigned long long`.
> 
> Fixes: 6b1e8ba4bac4 ("RISC-V: KVM: Use bitmap for irqs_pending and irqs_pending_mask")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
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
> -	return (kvm_riscv_vcpu_has_interrupts(vcpu, -1UL) &&
> +	return (kvm_riscv_vcpu_has_interrupts(vcpu, -1ULL) &&
>  		!kvm_riscv_vcpu_stopped(vcpu) && !vcpu->arch.pause);
>  }
>  
> -- 
> 2.47.2
> 
> base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
> branch: up/kvm-aia-fix

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

