Return-Path: <linux-kernel+bounces-803073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56922B45A37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1555A79A0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC336CC7C;
	Fri,  5 Sep 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WDor94x+"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169F36CDE9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082115; cv=none; b=HDfTyjC5FbF8paJ/X1MJEHXOcRf52Uw9Z3WNRZ+UR5eLn7s7kU5Cjlq9lWAffg1r4oUQwariPnpUmoAHZHuf+m2kEInB2KIpmj7pUt8M0VaKqHQS4tEtc3D9aWcNxEEHXi3Amp180rpX/ZSY3hHwZLgsFkJCd8D9xoSfydrdMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082115; c=relaxed/simple;
	bh=oxUImwhK8PCX5aXJPu6YXlDrtbpPUKA4Yd9Mnt3Xf38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENStYHnUglFehOZmDMjUcUMIG11YRs1wOjqiHJiOvXVMpNYIBM0SsPHYWvvg70jQ4hDbEfWxX5Hl5LPekDWUsxRWHORWRIrrVc7ree1Z7mEbvZvqxBIm47N1YM37c5eaafzreXGv4RwbcSXK9C8o1geoOrPLNXIIgxLEeM/vcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WDor94x+; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3f30b2b2d46so18844165ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757082113; x=1757686913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAIXNF/yhxj3WIda95HMOmBhnbf7MpGftHHpVlcqDy4=;
        b=WDor94x+a30PsCd8eKo7y/hwzZozoyy8N/X/5ZTOXIR21HkIsfU4ybqfFbznbM1QuV
         hOoIv9ysNc9EKDDIjQ9bLXrEgncDt7LE3/++NPrcbeULM5on6bYbRLB/NABybZa6dvyC
         iqioslBMr59lrmupnf6ZxnaNSWOxTiDYcdWi6Rv7bs3rEslr3ydWd7gCfTcnT4JlQ4Gu
         5vnIVerOkndj4PI8QEksNoqXFgRZmRz1zcefZVBLz3knON8w/hJGmZh2kFXo7GtoXGea
         OKvuHjcSaxqDVCwJl+dfoqBinYSL7lsIOxwXq+GMJmkp3GsWhn/7bilHmiPAjY0RrjbG
         ky9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082113; x=1757686913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAIXNF/yhxj3WIda95HMOmBhnbf7MpGftHHpVlcqDy4=;
        b=bKT4eS+4ITqUyg5g2THu/b925JvA0XramLJcaNQa39aRPatI787cVu4oY0Uw8jd49W
         c7rdIqXg/nUuwmi9dZ36tyShc2dw9CGqSdtt+DWAaDWJbg0leB+u/++jsrwl5LARFtcZ
         hTQtKvN6p1NNt5eCJ+2yfCtGa5WT+2DRKpIaOEX5Wr2xJzEiTrTYeQhis0bfXqYjfyDI
         D5ZY4c1j7m9QRWE3CaYyNFqzp41ui/e+3Zw18ukexq32uQobil2aDFHIYtVvvRphdbFr
         hlT9NRL15LWNEsoZsCXDM5w4qLBLc6YfGaBM8j9fNQ28qSO4OIuJvH4A52C+VuHkXIj5
         ZKMw==
X-Forwarded-Encrypted: i=1; AJvYcCXabigaIOmtPBGh8Crb7xGMX0SeaKdyECgzU1vKvE2xbpAe9KA2M3JJ+grPMP0wCSOTDt0BHkCoxXdW1yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJL2kK8YzZZKZ2RhKm7BPUR69uSazEDsLOHcxtFybta0jyXshF
	RO80nXskkTcvYUGSETka1PnlJIb6uyR2wQWshs6nGvDaSWZX9fuIbcDUAJaFGDGoLTA=
X-Gm-Gg: ASbGncstcJdGwGt60xZpZQr+1uaNshGv9ATc32CDe2wR4TlW67CVYwQ2bnsleREG+jh
	sMUgXDy0gN7mUR6NTv3GnwJJ/KUy0diqyATV6jjPzpczOSXHPbJA81G1D81fNzSnqxKPAFb/2EE
	itvGOgKaBJHvzuJB9xzlezKdusaBQgzTF+PFhkWxoT4TSmMDH1v7PqDvyFXxDbKMOXn+ymFNjg+
	gnkwZmrN0Pu/fEv8D3+CGcPp6aeMqt7Ibb2oNX6MYgv0VkbcM94ieiMyDCE6GOoMAsgTLF7d2H7
	xJbBog1uUV1fu6L0JuSmy4PpxAqF0vS8yG01uWBLMT5OPXfwzhODGObYXcTSpG8wxtMT2G2dEMc
	b6j2e1Ilu6EEQcMCBRUuRt0WL
X-Google-Smtp-Source: AGHT+IGf4qxxSXO6iewjkiZTlmr4yvaEZFX/IytJuUl4Nj32J40fOreM/84N8MX0m+sgaZr+dqFiDw==
X-Received: by 2002:a05:6e02:240c:b0:3f6:6198:b39e with SMTP id e9e14a558f8ab-3f7b6808028mr57130415ab.0.1757082112699;
        Fri, 05 Sep 2025 07:21:52 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d594fsm6185353173.23.2025.09.05.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:21:52 -0700 (PDT)
Date: Fri, 5 Sep 2025 09:21:51 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 5/6] RISC-V: KVM: Implement ONE_REG interface for SBI
 FWFT state
Message-ID: <20250905-005c0bc3e16e909c5d91eef4@orel>
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
 <20250823155947.1354229-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823155947.1354229-6-apatel@ventanamicro.com>

On Sat, Aug 23, 2025 at 09:29:46PM +0530, Anup Patel wrote:
> The KVM user-space needs a way to save/restore the state of
> SBI FWFT features so implement SBI extension ONE_REG callbacks.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h |   1 +
>  arch/riscv/include/uapi/asm/kvm.h          |  15 ++
>  arch/riscv/kvm/vcpu_sbi_fwft.c             | 197 +++++++++++++++++++--
>  3 files changed, 200 insertions(+), 13 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

