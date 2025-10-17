Return-Path: <linux-kernel+bounces-858424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E495DBEAA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71C1C35F04D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351EF29B8E8;
	Fri, 17 Oct 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JJyDyB10"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D129B8E6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718019; cv=none; b=OHHsmTzX7f/l+JdOXSxz3tW5wvOM8Xh2z475Wcqxff49fQdHq2lZoAw0pUHisjFNZF28RWXgpO8WLdN5WHqiTfvg2dW5inTPnjr/wHK4pNmxCMmcGK7Df38Lt/JKeG+vOGB2DJNjaPY/hnLMEKAxwgYudey3G1nnNA3U+9u+Skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718019; c=relaxed/simple;
	bh=51ie/4+FDOx0L86siBsGLHph63M5h6PAozXIjd28edY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHpj9jYlAJhHcty4LVL/5f0E2B7VtyOdk2BK2OkfkeslxUYNo96gEKnanOwfaCq123SiriOdJx11zU46l7FfVo8wjnLuvUb5PYaVYxssYWenHf0wgykNCPLxw5BSrg89dcMtQeGKL4iLW0vBi+dgINZ8/Wcqe0Ml85oWS1Q21As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JJyDyB10; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso6547785ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760718016; x=1761322816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLnYMiGE1i6wdt2kWbvCEK+VTfi2UEFuvCxtEUGWUPM=;
        b=JJyDyB10ySjPrQmCjTDGOeg956v64V+nGtHBrOPGIvn5+Cp9S/eEEYcDpScMQXGhKj
         XGfoskf+cVR7t8S1CIxTHljDY7XEGhD6q51D8vLvmh30dv2Aoviu7LsOMvOYU20bYrAB
         82ui9RgONM2ckrgOBPnTt6LB2pJDGSrTDzQioKTr9eQRH8vIQ5Q7UAgbe4OIiASLx81j
         15bgG1VDel1h3wz4cQyLAHdWXajlpHl7V+d4weKWqYEa8jPWBZ4BlybctadAemFr2Lbg
         4d5O2A485feifbJ7W/g17ET6g65W44oJThMHD9g9P9i5BIZIhN+/QoFmv5dEu5QxJIzM
         FygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718016; x=1761322816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLnYMiGE1i6wdt2kWbvCEK+VTfi2UEFuvCxtEUGWUPM=;
        b=L9kFXY+qukFzICGOn1GruXh5pnC+YUR3mqvJd0hwTp7ddC6/KpurUmZ6tyIufzy5/q
         QM6ld1uh8hEyP+XvWXEvVjzPxEoAbFtqlm/1+5eg31lsHuxY3lve0vnFO0URbyLT068r
         qc4pCQ4G8TUg+Fj0YdKEjHSPhDn6rqVsD747Zw3+BpmWWtKLP9IcoEolz7ko1mn3y6LC
         GBZeSn3M8HEVGvYnNhd20yynMNBvOoUEuMY/mzp7HsGhbWSykZLPMBahvwOM3WHmsDtO
         0bUPr2WqRsansYcMc0rG1O14CGeRHqjwl+d4X2mh8uXWmH0k6/kXff957Bzi1cs1yFag
         HNZw==
X-Forwarded-Encrypted: i=1; AJvYcCWzo0GKbpX/wDe7EmCjA1gQmxfOeA6EjwZb+BXTcLCMxgpjbUgtwV96GqvBMck7TLFIBdEawF09PzRi/UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBJgQg6eXZQprSalm1VBO+EXpbnaty508RZLXCj2VQlXIstbE
	eMEdCVTxvyrcdLenxmSfRRswnCkKQeUogoUxJW0tBP0zlGpXmTmAvU076uwBgHmaCd0=
X-Gm-Gg: ASbGncuD2sCeg7zMZwmHa2QgnxWuYEbeplfySpz3s/GTvc7JBUA/Q6tyCq6tU2dCOPe
	LSd1YAvueNVKvN8s5/bRw8P8wYn+yTck5721r1ZSaefj4uEE70xIa7nCuufB2Y0Dzq1S4wBgmYE
	la9ipm/gehQ2NT/d3rFcE/GJUhwqjFYYHRXWPy2++SXSuSK28PbLU8atQ+yUMmUap/M2I/Rw0d0
	gaRDgzsx3dPUZO/8Dd4RCQxtLxKHbnmAaHHqjHEuW8Vs9gmqq30cew35c1QAjwqfEnT0HUYX64r
	HDjBJFns/p5hlL5azm9IRLre5bEsIGf1v/cJj+zpWpFCv0DKzpERT/jBHk0Ot9F+KWoz8VkpPWL
	wkHWW1lqaBtuNj/amBTF+4iFHONYU3e8839RKof+WgL7r9j/6Jg4ZBvRj8Q3pDke8cXotkcZn4F
	6AhUH2CRMyoczB
X-Google-Smtp-Source: AGHT+IGx0p/Murx0/nwCjsggRoQIsfWi9xXyoIzQDYLWIYmSzYKlABJ6zEfQQ5rWYKVGG7cg4jaAGA==
X-Received: by 2002:a05:6e02:1a66:b0:425:951f:52fa with SMTP id e9e14a558f8ab-430c5275304mr65365645ab.14.1760718015987;
        Fri, 17 Oct 2025 09:20:15 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a95fecfcsm22608173.13.2025.10.17.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:20:15 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:20:14 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/4] RISC-V: KVM: Add SBI MPXY extension support for Guest
Message-ID: <20251017-cfdb6c77b74b87b784a3bd35@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-4-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:24PM +0530, Anup Patel wrote:
> The SBI MPXY extension is a platform-level functionality so KVM only
> needs to forward SBI MPXY calls to KVM user-space.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_vcpu_sbi.h | 1 +
>  arch/riscv/include/uapi/asm/kvm.h     | 1 +
>  arch/riscv/kvm/vcpu_sbi.c             | 4 ++++
>  arch/riscv/kvm/vcpu_sbi_forward.c     | 7 +++++++
>  4 files changed, 13 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

