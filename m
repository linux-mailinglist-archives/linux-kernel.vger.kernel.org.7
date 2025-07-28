Return-Path: <linux-kernel+bounces-748525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10291B1423B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4C13A741B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F1275B09;
	Mon, 28 Jul 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCJGtZs5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94378F3A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728838; cv=none; b=J+44x4oZeEdnYN2yQgOPptdqkwscKHlzQvJcM/DmzTC8dnbdBgy0OhXJ1Zwz78BD3vJS8Hf3j8RW0eBDlTnYml9ma/dQ9bl6ThkU4QtJwqxoCwZOjBzNsDs65xLgs4nrf+QY20mb6/M14uK/WawUV7mlAg//POvqU+cs8SQjIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728838; c=relaxed/simple;
	bh=lkpX40Be1iPj/ILGvqUHD+ZPLvj4gBNuMUzfJoFdVbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahvddBaKueyuOSIV03umnbNAbdSqm1S20DvjYvtnUwtrcWgkwnOFVjSTGjT8thg3Zht6Yyce8Ei6g5N1UQVhjAqgGzPT2Uo+v7k6cSmKwtYIMAIgL4AF0kp7B2VvhFvHK+sZmACzoLh4QAQm0+O7QzhPcCEeKJML+ebE/oyUhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCJGtZs5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso50918685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753728835; x=1754333635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2mmj693l0jXSLhGLWNPDSNMUvi9J/Ob3dq0ELmQUR4=;
        b=bCJGtZs52EmgOVzuhBF2WITv0qTRxCLfxbHKrIdq8btBlJ8yypna0772WnXV+L7c0b
         ae11Uwcp9QLaUqtSSDxrTs5kIoT+sqEh3DXu/hZ68QVViJMA1eCCp/AGYcwkzW+HrIOA
         hDhqOkBsbzzGiAa5lsaPapuamuCbCfYwxUeIz3LRcYha/6/QHoaSB8iMehmoqn1G/jpH
         AFQAGsbnMlFz3/bRUuJdZi+2XZB0vJQUGU1A1k0Q4bdg0oVblBHaEdWf7B5gI6u8fUhZ
         MunkgQkvq6Vz/8SlaPVr6/qQcshNJ5xK7udRel22WeAP714ZWe7idL7Epvne5elMZaTa
         QXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728835; x=1754333635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2mmj693l0jXSLhGLWNPDSNMUvi9J/Ob3dq0ELmQUR4=;
        b=M3m+uKBWDnqJpcv5//wq5cL8SeI8+kHyjxZgVRnQQ4Hsmsr4hY/e6K8yl53TCU3RUd
         OYEtjXKU8b7Tafk3fMSHxDc7HdknWpHOokkmn59pq9umkZ8sI+n0H3D0V1bvVLftXo97
         DYTHE5wkvvXW1/gIJ2QqtpgmwyfsyuU//QHn6MzEmslzFWmUhQ9cqCHekSEGVKpW+yzV
         tnfVsFyJtaQfR+G6SPpzrOF2DXasU4JXBksrdsXRXQA5P3YVVG6xcKoRH4X/KkeYCVWQ
         /PiF+XJDOG0/7uYKsZUtaexP0TDos94ylhnBO8KtC5bgF2Sjxf0afzH9DLihuhtVmWOS
         snpA==
X-Forwarded-Encrypted: i=1; AJvYcCVeTGKAgoL620h+xMIJSH7RD0LZvNzvgmVRF2uVs5/rBbPJeQh1LTR8dWleN8foPqycuAjRfJoQv3NxzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7IeYetZ8d1qtolXb6mJtaVkYRuvTSPPF48hSJeB0ORT3i+oV
	imIpNPSMHA6S9f9nlnfcme7aAbxRyXJIt37aqp1Pay7e8KQZrvZcstwt
X-Gm-Gg: ASbGncsIlF0hFzfjkWVLRAjvfj+EtyLEwyNJlBo4cb8pPD3eR3QV/DQ9+uPsWMof5Rp
	aZ1h/JGgHqbE6KonVQz/ED6gWwWUYZaqarrJCjSYZf1B0lDClCsOJQB2eAt9WGlELt00UYHzXNk
	NaHktemi8691RbxoDT3YY4nQvog9DQEMvbjHWhzLItAv2Iuz5tJcqMqj+iKyWFzKTmeMmkNfBtM
	unA6TM7LNVpZzcCLe9RHpHowquZTKAaci3hjfHheTzkpz0H8FScYiwNcZi5/Vs9yZc66xjb+jll
	IyEnV0wSjRSq6jcIkSkG29eN27iaDzfq5ukCklMajILdAiFB1NKh4lGvhywtiG0kDXnYUj1ljIG
	Q1xWokrlBB0tmrLbVESacd74YQkFyj6UmX5JOgoUIi1vjtJ3QVyJBweCc6t+M
X-Google-Smtp-Source: AGHT+IHqTsTpA5tlZyL4WvAL61122t6dmEgzCs0VxY6V/yE5yEe/E2O9fHr5WaqbBSXW2eU+UMxVsw==
X-Received: by 2002:a05:600c:810c:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-458765475bcmr113432065e9.18.1753728834982;
        Mon, 28 Jul 2025 11:53:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587c9155a5sm99741715e9.19.2025.07.28.11.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:53:54 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:53:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250728195353.631affdd@pumpkin>
In-Reply-To: <20250727123458.GA16775@redhat.com>
References: <20250721130422.GA31640@redhat.com>
	<20250727123458.GA16775@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Jul 2025 14:34:58 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
> fit into u64 or div == 0. The former matches the generic implementation
> in lib/math/div64.c, the latter doesn't. Perhaps we will add a WARN()
> into the fixup_exception() paths later.
> 
> No need to use _ASM_EXTABLE_TYPE_REG(), we know that the target register
> is pt_regs->ax with offset == 0, so a simple EX_DATA_REG(0) should work
> just fine.
> 
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Link: https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  arch/x86/include/asm/div64.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> index 9931e4c7d73f..0bf2c6afe66e 100644
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -79,18 +79,21 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  
>  #else
>  # include <asm-generic/div64.h>
> +# include <asm/asm.h>
>  
>  /*
> - * Will generate an #DE when the result doesn't fit u64, could fix with an
> - * __ex_table[] entry when it becomes an issue.
> + * Returns ULONG_MAX if the result doesn't fit u64 or div == 0.
>   */
>  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>  {
>  	u64 q;
>  
> -	asm ("mulq %2; divq %3" : "=a" (q)
> -				: "a" (a), "rm" (mul), "rm" (div)
> -				: "rdx");
> +	asm ("mulq %2; 1: divq %3; 2:\n"
> +		_ASM_EXTABLE_TYPE(1b, 2b,
> +			EX_TYPE_IMM_REG | EX_DATA_REG(0) | EX_DATA_IMM(-1))
> +		: "=a" (q)
> +		: "a" (a), "rm" (mul), "rm" (div)
> +		: "rdx");
>  
>  	return q;
>  }


