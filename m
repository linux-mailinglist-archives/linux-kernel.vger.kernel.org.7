Return-Path: <linux-kernel+bounces-830869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF9B9AC09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127FA1643A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EAF30F927;
	Wed, 24 Sep 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Ry6iG2"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655B18C034
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728545; cv=none; b=ne4O/eGakO0kFXD1bFFOO+IspTdeYEUcnCh6RnNu17HVAdZHGxJjcjbukVDzjxKEMvxsINPgP3xzAt2njI6aSCztYG+CzeNz+CHcEericVM3At2HAuKp6lj9ZuAu2mBiOuce26CG5FYT/tOGTWeUFqTi8oBGCoTctJGG2x8od90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728545; c=relaxed/simple;
	bh=20vf8MIfcOOTOyvo/9xRmTDvKyBmElpBdVToJq0DjdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsiZiRoramoVzgI8utNwtwPOrixBTH14r+aUqF17JMwuzfyS1xdkopxJi+6Fwai4Ujwqwz6Vh7jLknnkdd/tZtK1cI9z0IBm2x/VHbJsHh7HHcx147ucYRzeMWf1CTyfE1u3upkdyDApAmM6buO/NiWuujxEd7MawRTRIK1uhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Ry6iG2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so3434f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758728541; x=1759333341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=J0Ry6iG2r/SifHFUCWPHtJZ3IX64ZxxR+0cnwmJiHyWVHvNoQFJzurF0RatrAlUlqV
         7iCq8Hu6S9A7N6sUoxB3NAwOm95kEetwkeyjBQYJuTeEuBL//z5VNbc73/U7JL76Pc35
         kpy4iFLJXY59QPX1vuNFF+X/c2chQu+g40z5rOkwiRKEreckxK3A/gGvWvobdu3nIh6T
         pNGkVDV4Nl5eEjCEemXAmoaATtddQww0uBod7gdb0XN5DZrh6NpJmdnpXbnAk+izvvNm
         f0Y3QmR5h9kBjNNk8rdRLQ1OHaND+i6ePj762aOpcwpcbdb+fcyHgjO2OfDnv9iIW/rl
         o6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728541; x=1759333341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=v9k925E8OwGya+Ot2fHWD2Qxq8KNmzECiCygN59+u2tav0oxPBxshgR49NpC8U0E36
         1AdPdha2zTi6L6tr/0D0bHn+fhFibIahaJ/101tWfS5X/STSFyR0szIJ9ykz0QdECsAq
         u/zbPggDZR2hjqERPEZa1ngnNQ0V6OhLuiaK3VsGfHZV7uIUm58gfiJgY6frl52dFeph
         atZ/om7pHwAMYVpjtghPSR9Fm9B/rZUnXIpDAdxYz817jSxOftD56zmIOI2Ur7laSbZU
         jS5AFAISOQU2wcGqyTHCkEkNRGzeTabBu58cgCLra534LS9gOtD0svf4YyBwfB8pye3p
         4CMA==
X-Forwarded-Encrypted: i=1; AJvYcCXTMENYsH9ktBVv7OCUba2U+KBGco2kzxjZ8+tEPwCeK5kVi6cnV9IlE36UVUkDnREZuMBHI6ye80u9sJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNYZDXLEKa/8WS22JT6RljgDxyyJmLX40XhMkVC7wY3Np7OlR
	iiagA/TSXDJbak3ZFe9CKRAsHNOXJ4TnRqXZpT2RZslUw7RaBwFjA120
X-Gm-Gg: ASbGnctbhy9/U9/AYrlYJDMqYTguOxuADuk+MkbW8wCeok4uAIQzFHVGaQSMj3RoSkx
	OgWTmR3DsJndrGORhq9GnW8kMtoXuCxiDzo4SfaZ6k48xP93Ds8xb1UupleUE85C2n1KRd4wZIb
	3aTYlnggX4AOsqd8Rc52rpM5AAZGpJZw9ywiTTrBzTTed+IDhZxAyv/+c8xQEc0H5UYsLNO05en
	OkHyrNGZOYLi6/4xsBAu2Y1sAA3Qei3fR+Hg+zSwRx5IX309WMIWhvtGfOsMN++VYVZG36LY6/4
	Sj1+ZvRzkF1qaYj/t4D6hXUZN+Ky13VGwGGw5g6wQGXfaaOYbGBkZtXjTr2K54JuHf4V9Zt7
X-Google-Smtp-Source: AGHT+IGLTOf1jm7exVsmcXsctHj+zPS0JPgI2KUuGj0PB5VIe8D8ekaVPCFkj/mn7VqohMIXLmygfw==
X-Received: by 2002:a05:6000:2404:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-40e458a947bmr353578f8f.12.1758728541123;
        Wed, 24 Sep 2025 08:42:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm36596225e9.20.2025.09.24.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:42:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 17:42:18 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: mhiramat@kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-ID: <aNQRWlNIno3ThMkv@krava>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
 <20250924062536.471231-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924062536.471231-1-yangfeng59949@163.com>

On Wed, Sep 24, 2025 at 02:25:36PM +0800, Feng Yang wrote:

SNIP

> > Hmm, can you also dump the regs and insert pr_info() to find
> > which function fails?
> > 
> > Thanks,
> > 
> 
> After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> Referring to the arch_ftrace_fill_perf_regs function in your email 
> (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 058a99aa44bd..f2814175e958 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  {
>         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>  
>         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
>         regs->sp = afregs->sp;
>         regs->pc = afregs->pc;
>         regs->regs[29] = afregs->fp;
>         regs->regs[30] = afregs->lr;
> +       regs->pstate = PSR_MODE_EL1h;
>         return regs;
>  }
> However, I'm not sure if there will be any other impacts...

nice, the test works for me with this change.. could you please send
formal patch? I can polish and send out the test [1]

thanks,
jirka


[1] https://github.com/kernel-patches/bpf/pull/9845/commits/11b31cd465a83b8719cb06331c8e81794cca40fa

