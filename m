Return-Path: <linux-kernel+bounces-830929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2FB9AEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01D73A802C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B253148C4;
	Wed, 24 Sep 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ilnq6lkI"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F621FF44
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733005; cv=none; b=pVPfu5ZDiThvpPpm6ie4mievuuZAR6koZRbDatlFanNLlJpszzvGN3N3jQJoqpjzhd06geC6/egmYioNV7aRTOKDf8q/L1Zt2CkzHZuUHn3kyMxluNiGt0e5P6NOpNvYr4jLDKs6uufw2grUPDGLVNneY5sfUVtrnw8oOPh2I5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733005; c=relaxed/simple;
	bh=NJFkjrhUsdcy8+rn6IOt2BrBbyjXFEMbFh4NQH7fzls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHfaiLYjATFKXvfjgrvhbfZvdYKp35Jv/3m+oKxkPguxeAiUpyoYrPbHB4M9L4RLPCe/Jdg8L6YIEahwmvZkMBKFKX+1GCQAf3XKZwrfoXURGX4S4ou732x5L7XHBQhpw1K84hrdgSeqPSpOLncyUNYtnXW3nuuZLQFmL7vd298=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ilnq6lkI; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8db958b5b83so8812639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758733002; x=1759337802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQQzEQlairAj51+ohta7VWgLRglW4GQMtLef+NgHrEI=;
        b=Ilnq6lkIreYeNvh6QcaDWO5gMaZIxU2FDQVNT4qS0SS0D9rSM1vuKG1ZCcscVyxf48
         +DtqDHDY9bJREL22aqaFmFjkp9sVW91uUO3W8Ve3tybFfgBoonfHuX/o8BOEna0DVtNF
         a8Ylc+TBfqHIpt9AMJzHSuN4Ulxz8mbTL0LOtnq/asQrSTSSsXktLUJuklcCFyljEzLK
         FRQwAxTfwCcXqhjJZJ+4QaOk5/Jhf4iAK0n7Mg0DMi5Ut32x3ZkTptJ8XplCIaQ7rhb3
         +DQSCtwy8gHTdiKv3Nc8kyX1zoXZKyILqZCJhBFhzWZvX2rX4vnWKvQi1W64Of3GyBUW
         YYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733002; x=1759337802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQQzEQlairAj51+ohta7VWgLRglW4GQMtLef+NgHrEI=;
        b=u/H1xZ4ODmEO80hMEMUlSjNAHm0MrtYasZQghYaZE/4aXqkhwJQSXxS3Vog4d8w6cU
         Fxl8PDhc82HnOYX/eTE/5F/sj0PW/JKs96DucxrwQ7uwUG5D3GQpRUsPrhZxyi5SMi3Q
         rYj2hO9hXqvA3LJPe9tCScasVTH8H771cS0kwZ/E9Z9yltCgIdjwbaXUp7e7LCmT2eyW
         ipDCRmt43Ji9OgCocSb6XaDTeAqkiNvSBMRgNb0PgbXqawQLLvyry5mp0YJo8TJXkV/o
         yx9ADhc3jpNOX5Xx2ce7CAUF3s7UUEZ4RSN0l6kgYJ/eI8t6WGNH2HDuyfcVeTEScpeC
         ToUg==
X-Forwarded-Encrypted: i=1; AJvYcCWnd3UszfB9+lVYdwFiVetVW+NxRLjxAnbaBTnrHwRgXyVNL8InBF06Z9POvEuoFoJvu+ype0n7z9xiMAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbfSc3BMv3vPV2lnfTd9RZsV8o2B6QINkyK1XQSVLKBRS0d50
	uspprD9vULZqYNGX2ipFo7cGlEtghY3FAi6ri2AkVpBd0/+fVK9hD15V5vCLCCYUrEw=
X-Gm-Gg: ASbGncvcatlhEJpF/CH8E/a0KeF87vnaTzZJlrwj/aey/JuAiBNim+nyKe/remyP+C7
	E8JSrm9x4iBFCK2Us4q19mI6aIWsEWvPDj98IuuG5kpJ/nbfiN+Et6UCW8Kq/LItq3HDBhQxJDw
	+a05RFNqHuDrayIaJsx+x7MAK2tFaEjuvK40d8Br3OZpA9Gqr+iVICsRI8a/Piki0eMHuaasGqU
	J9aek6Y761e3nOjyiPPp4fPnGAwOF1oUryK8ZXzuOJAwRZOlTx/qvhY3qzXzZXFFyYAGzl5XoDc
	CAkwgHFSZky0MQ9VITSh+jLlagbu5pfJaa8D20IPgcAooNjFlXab0aL9DT8iRWmO9mwCi11CWzL
	74GfZAZOjDxT67lVdrNtlfe70
X-Google-Smtp-Source: AGHT+IGBqrqJ6aGPvymHhMG99f/WWRWdd/TLY3Hx8xLtGHi9mUrXvTzfn7rPTbE9CvxrAKE0HVc8sw==
X-Received: by 2002:a05:6602:6081:b0:887:6854:b075 with SMTP id ca18e2360f4ac-901526045demr46544239f.2.1758733002472;
        Wed, 24 Sep 2025 09:56:42 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8db17087bfdsm205980039f.8.2025.09.24.09.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:56:41 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:56:40 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
Cc: pjw@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu-hotplug fix
Message-ID: <20250924-6e273138195103ca5b7912f6@orel>
References: <20250919132849.31676-1-danil.skrebenkov@cloudbear.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919132849.31676-1-danil.skrebenkov@cloudbear.ru>

On Fri, Sep 19, 2025 at 04:28:46PM +0300, Danil Skrebenkov wrote:
> openSBI v1.7 adds harts checks for ipi operations. Especially it
> adds comparison between hmask passed as an argument from linux
> and mask of online harts (from openSBI side). If they don't
> fit each other the error occurs.
> 
> When cpu is offline, cpu_online_mask is explicitly cleared in
> __cpu_disable. However, there is no explicit clearing of
> mm_cpumask. mm_cpumask is used for rfence operations that
> call openSBI RFENCE extension which uses ipi to remote harts.
> If hart is offline there may be error if mask of linux is not
> as mask of online harts in openSBI.
> 
> this patch adds explicit clearing of mm_cpumask for offline hart.
> 
> Signed-off-by: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
> ---
>  arch/riscv/kernel/cpu-hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
> index a1e38ecfc8be..3f50d3dd76c6 100644
> --- a/arch/riscv/kernel/cpu-hotplug.c
> +++ b/arch/riscv/kernel/cpu-hotplug.c
> @@ -54,6 +54,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
>  
>  	pr_notice("CPU%u: off\n", cpu);
>  
> +	clear_tasks_mm_cpumask(cpu);
>  	/* Verify from the firmware if the cpu is really stopped*/
>  	if (cpu_ops->cpu_is_stopped)
>  		ret = cpu_ops->cpu_is_stopped(cpu);
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

