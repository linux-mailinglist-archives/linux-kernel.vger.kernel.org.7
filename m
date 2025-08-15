Return-Path: <linux-kernel+bounces-769975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81941B27588
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C83A036EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E53FC2;
	Fri, 15 Aug 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VU5gT993"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF31684B0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224270; cv=none; b=Jz2YrdDLyakOBaGmw16u1E0TPuH0yolbH+Wjf5Y/HtQF9MCNM+IGdWRBYUKomPnoNN4KVw463BAynguB/vabFi809OoduSBcnK6RbHVjUsT8VBaZligoF8n4lCL+MwQiHPQKzeaoOffQ+NKXmPPAk/9ZymA0euh8Ff+X5DeprKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224270; c=relaxed/simple;
	bh=lk52J0Uc343UQCNUNYTsVfTDarayzuZ7wcW0s1BxKjg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=lHvt8PT8VHGNk3qapGkXMmMkjiD7+Dt/qL3ntzXHPjp1VGnqrxEfvc/lfTdJ7NLzRbFZa4JJFGwQ5kpj7gX8fcuUK+7PD1GJAyBzT9vOOF03MJllXmh9vVL5+BWzaFfMIQsYajqYXp0Inhw6qdVj0zuScr6TNORfNGAZjgEa9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VU5gT993; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b109bd63d0so20051111cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755224267; x=1755829067; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSxf7UlJQmlLXMw9jvLqBPpP7B2L5P9wYGG+RXrP7Lw=;
        b=VU5gT993K4qEPzHpId+TndwamlYQEbi58V1/Gond+qLrgDp51kWuHEBbT1eOl6vJbl
         Sjqxs+gsCCP3Kl2kXvoZQBYS3EN7rGBYhyQXK2Hay5B4AbGicZpQMdwYsbO9oBGKI0Pq
         D/cd9XDWemCOHHkHPrI2wKUFV5EUEShWJnl3VKfCKrhliqOI83CNKWmVi+r9IN1OPkpp
         8NbjNk8Schg9QbJ4/tAPJIHLIIpWkti5dn6VXYjBamrTwsXLA9rk0zqzLb2evkjmV0GO
         XDoqsvlDNaGRmqeCc7Z1uuXIjsbN6VhKrXSdJ7JuN7t6DhmUhaEdsi+QyufvuPrE4/oW
         EhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755224267; x=1755829067;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSxf7UlJQmlLXMw9jvLqBPpP7B2L5P9wYGG+RXrP7Lw=;
        b=m/sjji2xg9wZ/3PFZ3nMLFCDK9ustaLXouZn7oTUYbWaYmZsUvTGgk9NjCi/oWLem2
         koazUSmmiXwGxLI7tYVHlFxtarHSSS0zItxRmbsdoVLPykmmGI9rys6E9NnP3axTVeoC
         P0NFlLmPcwW9I3ChVVx6r+tVV6OjPeC69IX+Fd8AfW7BGMC5M362O5fu9Oo4XlZranX/
         15WdnycsIpUPifA5vUMAGoXqqXWPBOr9iyndqUE3duNuwpsZn2K8pjROZDgVgobE+OhB
         pdqJJ/3ZkmNEZz+LhkISUbAlpYjTQ4HDDMzyBWuuRBB5V/ElAafGoajon3sj8SJ7oqch
         OHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlrSAhv0Ltnj8V+CgVSNS05f01bKi9YCwytUbdp7eQ48qQFd6gXc7jc3meaAqqFVWOoBMuB4nGK0CYEHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OsiUhGDg0Uh1s9mSunqFJSZr/iBU1kU0rGGFIfJ18zvCeeAL
	n62zfgYo8HxpHEH8UZiaQvruiMyTQvIdaXdnp1sjanx4nBkovD4OqM7xiZzIPu4/jg==
X-Gm-Gg: ASbGncuGuml/vIlISOxviPHUjkHN6od+fHbzQ6Nec6suE2ayhJvl0ZY7rotEzmpYk2x
	04bIqqLAB+QDyvJiilqLAEsiMz3teWbnGTO5TBsKw6BqWSu4cav4GE/6wYHqH9IgEaupbVlyOpV
	wajy4jz6AdYrht5avH9twROh3wjD9Xtrbtk8bGFv4/Ku9L/Hf41guQiJR8OLWdBG3ucVBpmokIa
	Imj2fYXOrhdUTtNd6SI5CjSa0RAVErHRQP3nwyNLnQZivREvf3NTtW+e0mc34vLg7Bk1fSUbnxS
	JrDzFZi5I0X1RLzEJHkTqqq7frQXHd7hy/MxKRj+m+v0dAXYB6nC2CtMNA8jQ0o5Xhu0frcy1uG
	38gqeULE7ukgUKMXmHgbweIHhXqi1acymJkJT5wIeXrnm5G3Z+6TfFF/Cm5q0873VGao=
X-Google-Smtp-Source: AGHT+IE7FsKdjkWaA/MA6K90th65aqefW4rcAK+p6mE5Jd5wbV1f+HqjWxRRPBgnpG58ZsEAGXc5fw==
X-Received: by 2002:ac8:5a93:0:b0:4b1:103b:bb80 with SMTP id d75a77b69052e-4b11e2ca21bmr4717481cf.62.1755224267278;
        Thu, 14 Aug 2025 19:17:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11dc91b5csm2100881cf.27.2025.08.14.19.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 19:17:46 -0700 (PDT)
Date: Thu, 14 Aug 2025 22:17:46 -0400
Message-ID: <8ab2084cc35ddc9f2a4796ff7cd88954@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250814_2211/pstg-lib:20250814_1158/pstg-pwork:20250814_2211
From: Paul Moore <paul@paul-moore.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: Re: [PATCH] security: min_addr: use max() to improve code
References: <20250814142653.283355-1-rongqianfeng@vivo.com>
In-Reply-To: <20250814142653.283355-1-rongqianfeng@vivo.com>

On Aug 14, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
> 
> Use max() to reduce the code in update_mmap_min_addr() and improve its
> readability.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  security/min_addr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/min_addr.c b/security/min_addr.c
> index df1bc643d886..50035bc9281c 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -16,10 +16,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
>  static void update_mmap_min_addr(void)
>  {
>  #ifdef CONFIG_LSM_MMAP_MIN_ADDR
> -	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
> -		mmap_min_addr = dac_mmap_min_addr;
> -	else
> -		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
> +	mmap_min_addr = max(dac_mmap_min_addr, CONFIG_LSM_MMAP_MIN_ADDR);

It seems like the umax() macro would be a better choice here, yes?

It might also be a good idea to explicitly include the
include/linux/minmax.h header in this file.

>  #else
>  	mmap_min_addr = dac_mmap_min_addr;
>  #endif
> -- 
> 2.34.1

--
paul-moore.com

