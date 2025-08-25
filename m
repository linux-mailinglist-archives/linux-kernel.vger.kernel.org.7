Return-Path: <linux-kernel+bounces-785183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2849B3472A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396415E6FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC111713;
	Mon, 25 Aug 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="E6yCiHZX"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A0E2FF64E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138936; cv=none; b=NvrxhVilpqbSYQkPK9L6ltTpg4jKq9ibFA8BLIHx4yyp3Y8056awT6rmqo/oPaM+zolEcI0rjmaw0W35khI3aclPAjI3jgSHOkGC519ygYY5fvPq55i3SN1cul7glbIPjaWicPivpyZpaK2ymyXydJDOoofKG5lAn/FCGkcU1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138936; c=relaxed/simple;
	bh=JeuslXWF3RXWs7wR6we9lSHOWfjRXXLnSuu4MvbX5yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh+wGZyDS/OpbC+pVSGwJMVbKTsTi57fU96tqdcKz58/S/gQFVBfkYp0iNHwX+SnbA4YDryfWJ13zKNd22Q0q4IVZgjiWu7sF6hd4rlaDvgy+OKDq4ytEqY7p0si82FvJekzCe1oeDgsk9e3AJiL5Oj3BqxZA/h7JHzw9/+rYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=E6yCiHZX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432e91223so126197939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756138933; x=1756743733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gN8JTVN3UqrYbcE7si46e+ibxM+XGryuvpF6NcC0BZ0=;
        b=E6yCiHZXLXd/y1hXF2DqMCJ8m1O08w87Su9g5PH6mKTyrIK9QU0UQbRVJK/QSuxbLM
         2gw/t2g2fkmizWPCUic2tCwvNRVKx9EE4iyMzHSzmgc2VdPcHElHO9kiuF02QVko+WUb
         ehhJDWCQRJ06eMBbi4z49J983ttOZAfugUZUpvUZa0tCpKNCbkrBkanmrDh4dud6Ew2i
         yuw2OSRVmJxxagEIOV6DaxkSTiDyVKONz5cwkufYwFvAz8Kv5vOMs8syI6Cnj3sxDITx
         +aJSacFMUYu7SCxKosljIEtmK22+wgHGWjW6+q4iRYsUhNPxaevLJd/WANEH4M2/6V8c
         Lu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138933; x=1756743733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN8JTVN3UqrYbcE7si46e+ibxM+XGryuvpF6NcC0BZ0=;
        b=ocZVslMAz6ds0xB2qqIaEcyhhjD+XkNBPYU2w0xPXODYNCVvKtTFCKXLstOxj/IJBI
         p5mlEiAm4pBbQjBE0vj34OPPPrsEcoKyDDLm6yM4eqDFXpr4HS2petm1wQaRTZk1Ke1P
         dZEBsN7jBaiKJZqi3E9Jxo8ntW29hLmqB8UryQakofQ7MIV+QEkSX42bBiBExGar4Vyy
         dVur+WO+uzsdohQuCw8c0ozBs8OtFiV8DnEOf6qVQTP10Q4javRaeQvAL0+BESZWUxkM
         iduoExXpVg7YirHYeMxUt8v60c7FhzQhR9iW1k+7i22MKzEBWfMnwNMps3avtuAnFzV+
         FROA==
X-Forwarded-Encrypted: i=1; AJvYcCUS2aJufK3x6QuTDTdFvGGURFKCna6RJNF0U+iZbc1+Yd5NX/Avj4bidHzo3rEyL92ZruvpYHPDw7oB9gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpeUCj2GfeFjiMchl1dD+1OU9KlsVFmr4z0TAgEOr1zCP6pbWe
	uIEdyPmd/B+wkdgtsqUCkowTeYfPJw9s0gNjCe31J+kqfCRNGZGVVbYPWysOQ2PD6As=
X-Gm-Gg: ASbGncvjjbol/S5+9QWwdV4A9ChpGbhmGR6Q7EkEPcGHz63yJCQW1R07i7fxhGD7h9e
	3bWMbEF1UEF/chGSrslttzilN5g5J2UlxAK2ekNbXfMx5bJtxO4tZZzQEbkx5pHY1EkMdgXQYEE
	kEyP94/qnXvninvy5XxUvPcs1XMXeeXZz/Xtg4SbqBZFB00TMMN7GeVGIS4+o35mOPGgkSxWAIT
	+MLVn0hnRfnIPwGyljdpnosCGuTAPiJs3Y1rm/KW3nhKyoAp26pk2aetT7ozFmnhAafS/WaXg6M
	XgdQDPDIU2BIap3ELTpubej1BeYPWp/BGvZEZOJ8aNYLWMRU+g9H/iU/SvvArAn1v6W4F01bSW6
	S55gCZYFKxpPqgI988Xt8Jbtp
X-Google-Smtp-Source: AGHT+IHxDLcJHAYpyzsrbmn/aJb96iGEjJWm0YdiTY2GoeJB5NHC5Ix7Bwg5uxn0XGZ/yig4LtZaRw==
X-Received: by 2002:a05:6e02:184c:b0:3ec:40cf:2d37 with SMTP id e9e14a558f8ab-3ec40cf2ed7mr61486495ab.31.1756138933068;
        Mon, 25 Aug 2025 09:22:13 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4c28624bsm49231365ab.18.2025.08.25.09.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:22:12 -0700 (PDT)
Date: Mon, 25 Aug 2025 11:22:11 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jinyu Tang <tjytimi@163.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: skip csr restore if vcpu preempted reload
Message-ID: <20250825-69a3c8b588e0bb1fbb5b7beb@orel>
References: <20250825121411.86573-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825121411.86573-1-tjytimi@163.com>

On Mon, Aug 25, 2025 at 08:14:11PM +0800, Jinyu Tang wrote:
> The kvm_arch_vcpu_load() function is called in two cases for riscv:
> 1. When entering KVM_RUN from userspace ioctl.
> 2. When a preempted VCPU is scheduled back.
> 
> In the second case, if no other KVM VCPU has run on this CPU since the
> current VCPU was preempted, the guest CSR (including AIA CSRS and HGTAP) 
> values are still valid in the hardware and do not need to be restored.
> 
> This patch is to skip the CSR write path when:
> 1. The VCPU was previously preempted
> (vcpu->scheduled_out == 1).
> 2. It is being reloaded on the same physical CPU
> (vcpu->arch.last_exit_cpu == cpu).
> 3. No other KVM VCPU has used this CPU in the meantime
> (vcpu == __this_cpu_read(kvm_former_vcpu)).
> 
> This reduces many CSR writes with frequent preemption on the same CPU.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> ---
>  v2 -> v3:
>  v2 was missing a critical check because I generated the patch from my
>  wrong (experimental) branch. This is fixed in v3. Sorry for my trouble.
> 
>  v1 -> v2:
>  Apply the logic to aia csr load. Thanks for
>  Andrew Jones's advice.
> 
>  arch/riscv/kvm/vcpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

