Return-Path: <linux-kernel+bounces-774853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E905B2B85B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FCE580079
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B025F984;
	Tue, 19 Aug 2025 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NNOW1dDN"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F63451DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577517; cv=none; b=Dz0L8gfR+Dv3Y3yzgb4Vl7eHkFAvvdHEwUFvYnwNZz6Zei0xOK4M1lLYaw74B/ejFtSHEy8arizL/tYhY9YNV/JyVOU5f3Fi8oMMwOw+U/IqDzdomylcOPm5hbxgEd5URQVj2hO7uqilzLmMhACVQvJa6xacVSgt3np29wX1or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577517; c=relaxed/simple;
	bh=o+uhgZHnwmlv4SFLXrZCsBXHw6Z+Ig1wv1N10D205SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIMgzdU/5H5wICBr1I3NHkxWIxwUpIWjO51uhsBRtwjGOJAQVtcUW8YYTPQTDQe3Nbnc6hPNi0U1ZUa5t8l/721uHZHSfGYP2dJko+jaLiaayFVO7SQXtiWyO8fYgKwsJQQYtBIoLkLmHoxbKHfNtc/+LxVsPmOKHad3hyKXgis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NNOW1dDN; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b474a38b25cso1230639a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755577515; x=1756182315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65Uzbt8ZenEFcFURL2MqIdAtkcFnwdoUoUCUj4Jj5Bo=;
        b=NNOW1dDNBo/FO3NpLVwrJZEJJSGxKLWz87n0+JiVDLLbjDZGbAPL8uDW6CC2T/s8CE
         aKpFLQHnw6O9nTJbB305zQE2n0/FC0cWWxTtQ7fOjEAlOErbsQbXoStn72Kx/3b+X8eP
         wt2HfyyQUjIkc3NJJEutE6Kca8J6/ch8PKevtFFyPCwR2wPMCjs4qjmftdD2kEpeBXo5
         JItzEzBL7Ivo3NB9wawdL0rUh4eQiEoGT/eIgGJHIeK13fiph0iAY2FpeW+QfW5sR16F
         jAx51UvPzunGyEexQje6/CrmQ674Xu2OqVln6VgajNYPNqo6cdKXNz3/LrsVRhmd8ll3
         8iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755577515; x=1756182315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Uzbt8ZenEFcFURL2MqIdAtkcFnwdoUoUCUj4Jj5Bo=;
        b=B6XKIT6JYjQXx0wv/6gU2C/AVo5UTIphxHjhQ67xRhwAOnzcGk52YpK4nUjvusWQWA
         6aH6MEplZ6rg0FCbFBuM4oFVr0kz8Pdl3dVSEAm7/cLpmNpQPJsJTUhA4RgMZah0/W91
         JrgRYy6BdQXrhnFLWxMOETpXCVZG18wTnp3FPd/QSP2TR5A8EiLyRPpzhGXaH26q+HQe
         6jIynhgTbY++t/ACUU0txf6wOq6wvJcvK75zk4f/xDaMStG04teMSy/I4rModWiWaVfm
         3HCOnQhsjVVG1H6XOOoI8jxBEEPUzqqI+Ga3tVmDRv7hCOf3FxDQo2ftwt8AwSYPQBPr
         ngDw==
X-Forwarded-Encrypted: i=1; AJvYcCUIBA9NuSGoHqjZnxbn2+jGavXzhm/CFnuOLGPretigHwMEjXpJhFZL99mOLBloyeOUDPjq6IlUpG0loCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoDW9My/KVTJAdEszQE4eYaapgfpFBDmQIMTvZ3dKK3QReGUy
	/xjcI3fvXqNwo0lsGxA44nCT6lky+n2uRaCbslLdc0/XxUPNm/0IksOvFzMhfqTUodQ=
X-Gm-Gg: ASbGnctWS836Q3AvyZFlBi0IaQHPUERgu2nIIJ32bxf7PTlWfyy6kKvNtB2b4V4GZix
	HVtDSRLZ1X8jC6RZIlW1QvLcASazY4RErTMv5DWkIRHGerSmdAkuUN2T8JTZbZpXjv/pWRRspOD
	vCRPQ3Ke8+3WgsukToTNthG1hzWeLYFrteIqzoai7weHLaydgCIJbYtgpC3lf3udMoDbR7Yyayw
	cElyWFIZXVZ9uJqHLT3xYkP2P19hFKSOCY5WJsp89sVepDyyMhkgIytT6CuXDWlkWYebtPkIMMp
	Et9eQGS43g5n44oIVDlmeXzWYzqT/PPsknNszzRJc+Wbf67UkfsDMNPI016o3AG+fV+L2lLabj8
	xqouqafmW2Y0b1BG1gVtMWbsNqE8=
X-Google-Smtp-Source: AGHT+IF2A+y+SDR52L5ETqk7iiqm/dYRVBF8hu1uj4PHA6PM0xk2a8CSw259kIHYfi9AilP5yR50nQ==
X-Received: by 2002:a05:6a20:3d05:b0:240:11b3:bef3 with SMTP id adf61e73a8af0-2430d4a6febmr1790210637.38.1755577515368;
        Mon, 18 Aug 2025 21:25:15 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13ebdcsm1154638b3a.47.2025.08.18.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 21:25:14 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:55:05 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Message-ID: <aKP8oeKDwXGMmonO@sunil-laptop>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818143600.894385-2-apatel@ventanamicro.com>

On Mon, Aug 18, 2025 at 08:05:59PM +0530, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
> 
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
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

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

