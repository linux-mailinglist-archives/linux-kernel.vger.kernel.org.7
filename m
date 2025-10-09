Return-Path: <linux-kernel+bounces-847242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EF2BCA565
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E99B24EF221
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDE23B61A;
	Thu,  9 Oct 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iz1YTJdM"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2000B239E9E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029736; cv=none; b=rlk+AmQ5xFPsvjFi84G5Xy+9yDS43vzwj2TgNnTp4PVcU6qBC/C41JJKIJ/xf2KLs4XOvCyipTQqsNGXlVRR1GTTbVLaaho427Z5ROl33emz7zZ0jy4XpF0zZgysOIVKJG00l6Wsph5qMo5+dCQYrMWTbGRzRf2DDTc6+GONqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029736; c=relaxed/simple;
	bh=q+hqAlfgw+P6KkDK8e6HUhvoioMAEA24rF4jv+uYsac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmcxnaVJN9ISgR/4rVe5WoEcy6xCOJyx5FJFe6+oklbPBZE/vs5+eVt2sIcR7w4G8W0f3o6JDts9uQGZs5ipNwkovTTlunhXH2lVrttzqJ77iMquyOEeaVZZNJN/xBCkZmhbSqgGtU1wnT1yBOtLM/wzwIBqdAASzinmsgfrr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iz1YTJdM; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42d7ef9a402so8664145ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760029734; x=1760634534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=91IhoUqkbJwn/5huJM++DC3XaWSuratiU2ex4V2AW8o=;
        b=iz1YTJdMpGB2gX/1Xe44r+z4aJC7kLrMBtyr4Xf9K9DKGRaMU2R1gVWGRkGgDElLHe
         PxTRGA2bkbBl62BACo4HquHFtMgn/aoIQub4GmgFnFkAN/aBcBbxKUaCDnaIQYM1kBTU
         Eic2/OfD0psMmJOBl8TqrK0gQORICQ1PyPoXCDNmN8noOlCzoFK4JGYkg1rXKDUPnN9I
         Je29dGrDZLBtwC2fo5SKDcBRCteHtqAhoU9znlgxr7G8nRdHE9hL/7Y0HiWmXzI37BIP
         ZTxwvWLsia3Q2D0fZ07K6LGP1ePZPTFwlCb1EiTgRw4XrcSOq8lq/d7V1ksvhf6tl4Mt
         YCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029734; x=1760634534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91IhoUqkbJwn/5huJM++DC3XaWSuratiU2ex4V2AW8o=;
        b=N13WFD7tWgUbZ6P0obtb47bZiopebcwmieqEpN7qYgLAvRoeoK3Heo2PpdvPj3b7nN
         88V6ZD2oREHMDauwewzymZXGzIlWsaGV4NDR6AEjAnveUcsQj41lEZtk4IJn5qSOpUip
         SSiM08xv5U+WVPXGfryvXIRZ3ujg6xurZw4zwC+87ZY/3GkQv9WvVrPNB6dafirt0iEc
         dMSqTTCoOklhNyvf+L8igFLLHjUsQmZ7MrmQ0+TdHJsWnUk2EfeWjHInJcVRMHXVStva
         njqnv2AAvp+OGjVvbLbt3Pi0Tt55UcAiq4tX/SO/K7QYY25nPsL60Mlt8EVCGHNxkuyI
         xJrA==
X-Forwarded-Encrypted: i=1; AJvYcCWOZWUp+Yo22oFf21I+asmCpJCAAd7i7XxXNJnDQtlT0UwJ4ngSOExI3k7OzYe5WPWIJouuVb8N27HqPG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/cwVIHnVtfrUev++AK/NH1qYacR6D4yR6ulAL8SzDj/T2Fqz
	++oTj/HrsD1DCScWfYuqp3KraYqnefdahv93BSymfBaZmdCFvqmOVDFiOXd8Ryyutno=
X-Gm-Gg: ASbGncu66JRTYH4EKnSRtXQ8fVjlFjtTZNrKh85eM1yz5W7ifJDtA0r1TCggQDwO9Go
	YS7cPSoC+ACd5aUiQ2KxiACaGCd/z4p4YFmP+M2fFRNjkSNfZ4CJ/dEjShOeFFV0G0EnjnZnb21
	AjgHS3iWqXsZUuXcA0fQCjvCh03HTAi7LCNstj16+YgX+S+KLeZvu2phG0+sSDM2dPVbXl4xhb/
	rBkPNLMk0UEnSWsKNyVXHmFZNP+2OGpWq768gKN10LgKKxrofIE5cDhtv4gv4mErqzpz7LtGQjQ
	UwSa4PnpPMlljCENObT9EP4CQsjASIFMHvd11LJC1cYJQdSq04zFBTSYb4t+BBSzXWs2AFe98GJ
	farFn80StPu3A5ITwxwUh093YY9fzDTbz9NqCcWPJueyLwjgGYxHfeJBrjNI=
X-Google-Smtp-Source: AGHT+IEDDXGHje61KhPvVD0wQh6hKseH7rH+kzb8GOXQ5/O7/SNQ9iRGs3Q+ht0YPg3yhdWyjh27jw==
X-Received: by 2002:a05:6e02:12e4:b0:428:cd3c:6a3c with SMTP id e9e14a558f8ab-42f873dd4famr77561385ab.1.1760029734163;
        Thu, 09 Oct 2025 10:08:54 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90107a3fsm12115795ab.0.2025.10.09.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:08:53 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:08:52 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Charlie Jenkins <charlie@rivosinc.com>, Jesse Taube <jesse@rivosinc.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH v2 2/4] riscv: hwprobe: Report Zicbop presence and block
 size
Message-ID: <20251009-643d7302be8ec611ea622aff@orel>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
 <20251009134318.23040-3-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134318.23040-3-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 09, 2025 at 09:41:52PM +0800, Yao Zihong wrote:
> Plumb Zicbop into hwprobe. Semantics mirror Zicbom/Zicboz to keep
> userspace expectations aligned.
> 
> Signed-off-by: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
> ---
>  arch/riscv/kernel/sys_hwprobe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 000f4451a9d8..7a6ae1327504 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -113,6 +113,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		EXT_KEY(ZCB);
>  		EXT_KEY(ZCMOP);
>  		EXT_KEY(ZICBOM);
> +		EXT_KEY(ZICBOP);
>  		EXT_KEY(ZICBOZ);
>  		EXT_KEY(ZICNTR);
>  		EXT_KEY(ZICOND);
> @@ -293,6 +294,11 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>  		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOM))
>  			pair->value = riscv_cbom_block_size;
>  		break;
> +	case RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE:
> +		pair->value = 0;
> +		if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOP))
> +			pair->value = riscv_cbop_block_size;
> +		break;
>  	case RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS:
>  		pair->value = user_max_virt_addr();
>  		break;
> -- 
> 2.47.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

