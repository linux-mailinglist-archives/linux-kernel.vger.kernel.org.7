Return-Path: <linux-kernel+bounces-771398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D14B28678
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6231CC7390
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F32566D2;
	Fri, 15 Aug 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lDtY5kvo"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D20220686
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286620; cv=none; b=nIGl1BEIR80gS7fXHGeuJB1qUicft7xHNs7dLkBO901UYp5O07/Q9ypvPnMAw3JgHapeFh/yRR8Igvc4714FB6y/JG41a914aEhwMMMNlXTdabXF5NuCLo9vl7LA3yNmUY+lHpqbZpdOxKCxS+YA3cv5UmZP+IYC3tx9LAArUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286620; c=relaxed/simple;
	bh=TRnuJeJdiiXVSPt5A38b/HSMMuCr/JcWKJo0VgtOGZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN5hYQ+RmyO3NYA2PlozI1adQYb8Xzwgzb6SsjlMoYKdFrXNAlZ9WJCfZXMXOdEUr5gxWUSzzWWp8pBSaVQehBj9GcnvDPByqDoWTY5aU44lZwaugiakRReJjhjx3URxowPsMgIErxcQ9Cg5o2WIo/57+jaMQwHnYJ2YGSE1wak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lDtY5kvo; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88432d8fdd6so76061139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755286618; x=1755891418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DgASsy61mSObI5Zc/GrPmOkK9c4HSQIjPYfhAD6IUY=;
        b=lDtY5kvowA3DJCu5srHnylxJwPLwBCbwyaOVIacpbMx/9+QyQmxCdE9Q9xfiIMj4Ez
         9lh627g2D/owPQYYotbarJPU4bNY+/LJLczNluWmRe56pkICs+9qK2ZDuimR53eecORv
         93011szCbeR9ehqvCvL7TfahNDQZZdSTzp7u4h8TIR8Pa9V9VrpDwKdu/98G1DtHFhye
         /Nq5PZqmdO1J4zPMDoSXGMxrE5/6QeGw1nAbVNcWlnY/B3Ctk3mIov9WkoRsQZnuJSG5
         TU1FSa6BR2nlbbArjuad5VDQgOWfkxcRiUuGmSZP4eXNQDpZbwVFod4suvdN1FakGTUU
         xp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755286618; x=1755891418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DgASsy61mSObI5Zc/GrPmOkK9c4HSQIjPYfhAD6IUY=;
        b=u2ekmECmJiyUImR6ztrB2iDCIHm6GqT0mfxj4NMcwYwf63Z+zj/J0MqCkWQMpbDhVQ
         9mafwKhulivPatIFk1VwyibnJBnzNTPJRa0jxeSo2oSrFXgTk6s9UbQw//r4zGcdaOQR
         zFVcq54XHosW88UBwmzcl0a1Ikvm7uIfUrlULOddA9y/gjDqNbInSAAWmnlzDOXR/Ovn
         FxuLCgMOxwG04nDJLte7Bed5i0i4p5EhBi2r+CO7jLfTNuY/NeorulNsHUTp65puBltY
         9CJ8f943EyxGxu8bQXMXvMY9MBjM2fGOcyBOdY+ERf+IM5Xendldb5asWZzomxMYyRmo
         cApg==
X-Forwarded-Encrypted: i=1; AJvYcCU/kgqERnpAOAIrnSX7iiJLf9A8IKcblon+qeAO2MY/WXl1rq7N6WbMA1yUpoFhP2N+ojkL7c4HyJ7x+qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvT+Z+/jpG5wC9QlWT2RNVrZvwjk4w6PiDsXfdqhWHc/rZQb9
	PIHRWjOQ2jwVN8+IAZqXM51yy8ZxnuQbcELYHb0E8x7ByBJCcjrT+tthwNrLD2X4vsM=
X-Gm-Gg: ASbGnctcvCzrc9CM7CV89Yuv1T6BQQRD5YM00JDe4WUrzVW8XwIvwXNmq4KFY2oBnru
	UGO79yWiLlUr3hs6iXikY1MjxIipAjXweP61AfaNRIC9YgF9hg5FoLGi5jd/0PE+TUPIYBfW570
	b1k09a4Cghe2Gry1FfBnXPFiU+RqybPBSAjo4PUIusgnZbuFsDRmf1a0IEU4MPujGcRQPjfSxfc
	Pialtz58aQNVXlhzW1hD6EHbYpDAircub41InEYlW3Tyb1JcXFnzXcnhp1npDbNoOTS7qpzTH5r
	A/KfvL7EwcNoMNfvf0VwOfSH5t5O6VwZYlwN3LIcgayZWXoZCNRedY2QHhqCi4WluEaSyUu5xcF
	0lLa42gXQOs/VKxC29i3yzM8W
X-Google-Smtp-Source: AGHT+IH50HAImdgEzMYWVcKbXBtm0Htc491sbSs2fh8HxUr57vHHb8MC8O7OYnqjBnPqId7Doh1Eog==
X-Received: by 2002:a05:6e02:180a:b0:3e5:3520:4a75 with SMTP id e9e14a558f8ab-3e57e9c4f1dmr68415975ab.23.1755286617859;
        Fri, 15 Aug 2025 12:36:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6cef44sm7903315ab.48.2025.08.15.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:36:57 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:36:56 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Message-ID: <20250815-770a166e7b6f890d714dd4dd@orel>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815161406.76370-2-apatel@ventanamicro.com>

On Fri, Aug 15, 2025 at 09:44:05PM +0530, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
> 
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/acpi/riscv/cppc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 440cf9fb91aa..42c1a9052470 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>  
>  		*val = data.ret.value;
>  
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>  	}
>  
>  	return -EINVAL;
> @@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>  
>  		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
>  
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>  	}
>  
>  	return -EINVAL;
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

