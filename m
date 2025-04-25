Return-Path: <linux-kernel+bounces-620374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E160A9C9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734E89C7D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905B24E4A4;
	Fri, 25 Apr 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VBh7Zsan"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B224BBEE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586326; cv=none; b=NXDd+I9vmW0uVqPARPTv9kht8t0kHGfhU5Y5sBCYYE+9qbcNkjOWU1Rc8FWPuW5EJxL9WPVHWtKHtX6MG5NnnzLXjvDlugIsBIVQfp8Xdii/vPBoLp62xbBsbeVQIeUVu+LiKHaDWU1cBfgs9ZoOCx7phBbLE4vX85S8jLQkLBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586326; c=relaxed/simple;
	bh=sDGtqm1V//9UtS2zFSvlXkA7AXbkU/KZKXPn8F5C724=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIRIvp9MSj82kS7sQgqiBuOB/hkP+8Yhswzca08+W5S2d5UO91vzTYywHO3RnlRwz4xZDhcCCVuj73wKWph0Bt+FzRXdr5ug8AjXHQktmU7f9qL27wFiu5IsuGq2Mj2lRNaHS/iqL93X0+vMaG/4z1UwvxgJF9cOeZxmZT5IaQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VBh7Zsan; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so21148735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1745586323; x=1746191123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mI4EMCjudvPEsRjkDPJuXzQzHFYKmrud5DGT+FL6aYw=;
        b=VBh7ZsanftC8Wk6x2g7MYzJf9uWLNm1/ukm+IVE06Nzh72R1bgRo7JotbgtROnhpJg
         JBsL9/QoAbzeOucCM+beFkCq0scStKjZnK2UuXyFa1tH0SFfV0NocXqIul188wyulDCL
         w5be+PceYbONFWZBRaIKHVnA/bA2USyG+9/z9+I5/CK8eyTWtCsgTT+DVIrz6ywS5ve9
         x+kQkdMF4r5Gy0b3bpAwUziOZvmbebfSd/WalfjkqiUohcLvyr1NlrpJKjEpdzspDzel
         a1xsWNWLnG83q4wWUeCnmYnCLemf538hu2bnJXX+uMZ9tZPJ4Rym18TRGVIbqLFy0s8V
         CXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745586323; x=1746191123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI4EMCjudvPEsRjkDPJuXzQzHFYKmrud5DGT+FL6aYw=;
        b=TssGmacrowTSHNavrDsAJbaqyatBxPTRxEgfZ9RXydSMbNVZC87iNqFp7vN/zS4Tx4
         5/FvoBkN3k7DCTnNKsFpzxnz+jE0565Nyt7KesochGO1UIJIHKqvXUggoly9/ej0g8Oj
         V4hcZf6uWvrxs08/zLlm1nhg7jg+t7pxN4PefucDyqJ0jsrloSkS9Yl9NyPY5BaqmrVb
         4obRb0lY1PRo4P63suj3Q7DWwnOJoI0Fs0bGIXXDFpBzv5C8SPrxTz40luV5XuZSECEA
         ExRuhqJVUEAoJFTVzgLGSwtAxxVskE/zepMraZZkAMD2LPony5eKDFHv2eQy5BeD1L6I
         0Q1g==
X-Forwarded-Encrypted: i=1; AJvYcCVlShxMqmwW3U9Zl5p0Co4yy+4aES/CO/md884rnPP2qRrfPXN19Yz/sXh/euGL5FF+/PV9EyLej75X9z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDndH+WWjEocieSRRtWlNAOR23xOLzBMOJPiAmD2hdvyPpVqM
	ZP+RqlBsXHuBUqT28r4hcBY6lktguDiyufAYGLrXrvp2eJr6Q0JPMF7vnbS3uag=
X-Gm-Gg: ASbGncvAQPRsrfqsZBU5SHRyBqCe6+Oo51cvxqdVesTD+lM/btfkmZlJ6nT7OkguUyE
	d5ffkqxY25rXRnbRZpkAcbP0thWR7uMx0yVazl+hdNAh5sF3ua9H/Qfc5fZjFp8d8+nf9n2RiW+
	TZLC7nAQV4q/LipahPCOHwR6NnOozWuzQQ1F5VwoNJAto/0Tami9hgvuO5uQl43mTFD4v1vmowx
	Pt+p9nFAWzppKmYP0rD8tRdKlsORBz2V/vN136NmACDImwg86b/cwvAd65TQHlyI7PMND5KojQ0
	2VQcVV70cPEadee4kAYT0lpT2wEH
X-Google-Smtp-Source: AGHT+IHHErR6NhpMN/Sy9UBcv9Lon9rgyckgM6zPHQxQJs/5oK9vVCdwR1q/Yg1TRreW6QGAYcjYIQ==
X-Received: by 2002:a05:600c:a06:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-440a65d8e66mr16975955e9.11.1745586323513;
        Fri, 25 Apr 2025 06:05:23 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::f716])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2dfc2fsm55718985e9.33.2025.04.25.06.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:05:23 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:05:22 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH 3/5] KVM: RISC-V: remove unnecessary SBI reset state
Message-ID: <20250425-adf6ca95915c46a5403fb742@orel>
References: <20250403112522.1566629-3-rkrcmar@ventanamicro.com>
 <20250403112522.1566629-6-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403112522.1566629-6-rkrcmar@ventanamicro.com>

On Thu, Apr 03, 2025 at 01:25:22PM +0200, Radim Krčmář wrote:
> The SBI reset state has only two variables -- pc and a1.
> The rest is known, so keep only the necessary information.
> 
> The reset structures make sense if we want userspace to control the
> reset state (which we do), but I'd still remove them now and reintroduce
> with the userspace interface later -- we could probably have just a
> single reset state per VM, instead of a reset state for each VCPU.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_aia.h  |  3 --
>  arch/riscv/include/asm/kvm_host.h | 12 ++++---
>  arch/riscv/kvm/aia_device.c       |  4 +--
>  arch/riscv/kvm/vcpu.c             | 58 +++++++++++++++++--------------
>  arch/riscv/kvm/vcpu_sbi.c         |  9 +++--
>  5 files changed, 44 insertions(+), 42 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

