Return-Path: <linux-kernel+bounces-893281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE109C46FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA1D1890973
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC73112DA;
	Mon, 10 Nov 2025 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja6I5AB4"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A7303A14
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781983; cv=none; b=WPkk7j0+YeAtuJpqLm1v8IAu2f8PQnHVqyJabJLl7N7ZVVvghbKaPqXGj+adRgp1neSXGqM1gRGoSc6kfFLxlLnDScfaVluv9BQBYG5nhYNe3jVOK20jhs/oghltKe4dqlWTnc6QkqfAkXDFrN86oKMhX8/jqoCxHX8Nf4Q9dP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781983; c=relaxed/simple;
	bh=KIyaQcieNZx0m1VKB7te1zIum+ypPg2/9HEF3rJmGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6L6io9QDptzZ/D0k0OK7gOygFtrxGL6w+o9XRJmLYXLpvYgf0Kri8ykTS2coZDn5T/+HWXCwQSENbyopEOFyZJpyKpM9VI5yD4CtO91ahsfJaASIqvn4u3IoHMrk36JKeAdo0oRmn4geI5VYDhPJ9IidIX8g7QFmFfHtLnZZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ja6I5AB4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so2146430b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762781981; x=1763386781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMnRxR0BMqk1VsIAwHoLT+z9GWmoNi179eBxCRdkG2Q=;
        b=Ja6I5AB4LF1BfOy7J7XB7J2cUUACww/D5NFuJbjcRPE0tmgqOR4rEkPHV8/PDzwyWT
         SuE9gYDFY7xDxG33hGtohS67bHhKa00DSTWc/YXNQuJtPbQTQ3tmfoediNTbEuPog1Qs
         nNUN07JFAmnR7/L/htpO7YeWViUk1gM3lTJOAJH+6xhHqrGkPPXo+UlCAevUSTdJpQJq
         UP1NbPjLP2jLf8CRBh4SQD3WpjSykGv5oqxSviKfBlVN3qSW46NeWj6yRI8Es6ZOlK45
         u/rD0H4eK4fObPXiQ7V80AlAqwtqHEC7fLif5IzClS82aJvRpFDgveoqR4F3gBE82cms
         rDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781981; x=1763386781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMnRxR0BMqk1VsIAwHoLT+z9GWmoNi179eBxCRdkG2Q=;
        b=KCzF+VdIw6BwlDOVY/8hOLPTF/txCPeSRJQQuXja3Vfb0Xhu4li2tMHgH9f73su7RL
         2NQ/yHcnq6a736gPrD/j3Icw2Vm6BPr0OlUUPd8ojOwOH1Etj1YXF5Wx009U9dfmuRLD
         So02slafr4CxrLh2exQKoOy+aPy1VGzzVfxIpcHwv9ruH702ntxW2jeiMzzWXzYM/NkI
         nLqZ1/Lb8QDZb0EAlcp6TbMKDm1anrftImVHw7VbFM7xNSSxJCidHXuvShMn0cJszYFm
         OX5N2yzzCjOHx37S+IVjj5H2/DHw2enSur3DGQDvp38FKlOvxR4QqaCRKL6mjpqPIkra
         gEnw==
X-Forwarded-Encrypted: i=1; AJvYcCVNGOkPOx9RVe6xrfJw2okG5koSLWdTcTrMgEzIMwBlmDqEmzJdSNKa00X01khbDC010s5LbAF/CJ4ozrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjfcaVS1iUGAIJiMhFeyVCwollIpvqMIm4RzhLNNUM5Oci2WV
	vQWlJHCWfCYROFEGingLCmlVjj9pZMKbyv+RCoHgcjZ7sCUWAxgEnhgb
X-Gm-Gg: ASbGnctclM+Ryfg9sxZED/twWfTqFEPRGb0nDz1vnSoPVzEHZTttoEPkp0iahXjEqIH
	Hf2icE8yQ2U/ErFIT0xrJUVU+hALkBsAQyNkr4XlnuRXl+dMxSpWgqi38Qczxf1e8hKO2jmRKqa
	xEj8bBqc7KJzL1lXBqtKcpJyGuE9Zzh92kcH4w59w7U0E2TzKoK1jcd+1F5qGnByhkJEkRQN2fm
	BumFFT4Ug7QBehrm7RWbMUHG0L0/TF8j+JewMx4t5Ipl/RlM0eJS3E6V2svbtuvWX4Nr2vQ0vOa
	6UnUx01R248sPOkHQVro5phcI+DUgcuPRwcVar1a707AJ7UAeZgA03acm1YfHEMhsdCoXLK71Bk
	DlrRpKP9PAVPa4aIk+hOPGFUQPNxSMvfM2C33u1d2rbDFrZXjvH3NNM8mbWyeq72a1jkIKGn5uQ
	RKldd1dPHN1QDpXA==
X-Google-Smtp-Source: AGHT+IF8Asxyw/Kg8HVr8186WlFqtrOcxhgYetF+4AdiWWiMDI2ch4BUjvo1UGexs09krCv7PQyhGg==
X-Received: by 2002:a05:6a00:985:b0:7ab:653a:c9f4 with SMTP id d2e1a72fcca58-7b225acd562mr12482447b3a.2.1762781980645;
        Mon, 10 Nov 2025 05:39:40 -0800 (PST)
Received: from google.com ([2402:7500:499:ceaa:cb8e:dff4:95ab:130d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd5c75bsm11842400b3a.70.2025.11.10.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 05:39:40 -0800 (PST)
Date: Mon, 10 Nov 2025 21:39:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debug: Fix a NULL vs IS_ERR() bug in
 __debug_object_init()
Message-ID: <aRHrGOKBi5UrlyGf@google.com>
References: <20251110075746.1680-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110075746.1680-1-vulab@iscas.ac.cn>

Hi Haotian,

On Mon, Nov 10, 2025 at 03:57:46PM +0800, Haotian Zhang wrote:
> The lookup_object_or_alloc() returns error pointers on failure, but the
> code only checks for NULL. This leads to dereferencing an invalid error
> pointer and causes a kernel crash.
> 
> Use IS_ERR_OR_NULL() instead of a NULL check to properly handle both
> error pointers and NULL returns.
> 
> Fixes: 63a759694eed ("debugobject: Prevent init race with static objects")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  lib/debugobjects.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 7f50c4480a4e..9587ef619054 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -741,9 +741,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>  	raw_spin_lock_irqsave(&db->lock, flags);
>  
>  	obj = lookup_object_or_alloc(addr, db, descr, onstack, false);
> -	if (unlikely(!obj)) {
> +	if (IS_ERR_OR_NULL(obj)) {

Ideally, an API should either return error pointers to indicate errors
or solely return a NULL pointer to represent a failed operation. Mixing
error pointers and NULL pointers can easily lead to confusion about
what each represents.

In this case, it seems that lookup_object_or_alloc() only returns NULL
when alloc_object() fails due to being out of memory. Perhaps a better
approach would be to return -ENOMEM in this situation, then change the
check in __debug_object_init() to use IS_ERR(), and call
debug_objects_oom() when obj == ERR_PTR(-ENOMEM). I think this might
make the code clearer.

Regards,
Kuan-Wei

>  		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_objects_oom();
> +		if (!obj)
> +			debug_objects_oom();
>  		return;
>  	}
>  
> -- 
> 2.50.1.windows.1
> 
> 

