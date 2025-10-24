Return-Path: <linux-kernel+bounces-868409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C9C05220
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7B1508720
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E213A30AD0D;
	Fri, 24 Oct 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO7pDRdU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4130AAD4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295035; cv=none; b=qJblFdgtUWN9MU1s0bM0dKlIHC+pM7Z5WCV5iXfw19MYc0pbb4yeJyQGE/DNKuurU7yFnnYK0qM/2fVM85AKzDxBnfvGy5zQdjtntBQz7RxGpIol2jqEb9Tp6+lIPGuOUagZbCHzpT6ZTtiWK6K3Ht4DYbpnRq4uKlkqAs2D1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295035; c=relaxed/simple;
	bh=GBY0sw1NoSYjfy/bezUKqsT9sskwBDR6r6B37VUaxUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9UA4RVgKyuzuasu7Ysz/xy0x+b2R958scDPcBf9gHjEtXkPdEAUeTxDWWlj7SndA6brWTh++QadVhkqSL8fNsxAdW9RSqPeM73+xWlvDLXJdV6O8fosuZW0uZNSy4RjV3ZTCFSAIf5GikDp5guAR+pwPx/d1wR4zMPL5ZtLbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO7pDRdU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so17503725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761295032; x=1761899832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdNfS0VkNtf/A4DiiWq6jRJ/bzfHVZsAPk9jCmjWmOQ=;
        b=CO7pDRdU+Ct3hLSi9uiz848CMAPEgsnMKZCgDJtU0o57sveI4DKSIIdTuDAU0NRWij
         CBzkQ988gvHDw7bKcHssgZy6U4D/14b+N2x1OWqS7NCsNhbs5zBVpgTnpCplS+6zbHQN
         peGTuIiRk0Evh52wUaAWZ5jbPiaFrC0eoGfqUxYMcWvqEEv0FU0ZQGq+yddZL8u7LPPk
         FVa2Ky4dDNJVO5KmcFhFeqSv0nzfUKadpakYElQmT7gs3SEFikjGjvwCnzDm3eDVqdyT
         pEj5BLZqxbPyn6qp6C61v9pDxHp0T+c5AgABg8u07k1CRVMte+oJGhbIe6f8P0InF7Ty
         /hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295032; x=1761899832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdNfS0VkNtf/A4DiiWq6jRJ/bzfHVZsAPk9jCmjWmOQ=;
        b=Pgp3n9GApE/ZCI3Sa00U0uj/lBrcHF7L75WJ7RRffJWT+4iqIkyIHTQUIbAw2pwEIl
         M0TdAJiuxn0G66XN8ydMBkaFiUZtkM+uOVpa/UhU252jlJTMvp4QjpIWqaxvgnA8LPjP
         N0X1PKT1ew+Y6TXYHIYxx1pr92qrXp6nvj4UmjIbNG3rucm6LkG/T9bESVKW1qTFf8dD
         sGf7+RDZXpko9vruTEcMSh7iK+j1xx050GqGQbwZ7bRcb0Ymn8KYdt6Z7qQJK8L1G+M0
         TsLddPCDoSsqYtwRJW93PjcoKDNzxj5rMO20kDoy/i3F+rW+WZKES4ln1HDlUV35Vgjw
         +jig==
X-Gm-Message-State: AOJu0YzXrcs2SnZmxMwFGBYPYLhdtGdiLCCw0ZERstMQpyPlNDqqWt7x
	JvcAWsV3P7YmHhD2FM8od8Q5ju9YB9vzjBUsX0oiJXj9p46iYp692E89
X-Gm-Gg: ASbGncudnM0PqdYz99jWm69mkoCM48f+agslwSkyWbaqfKD9p9S/3K0uzyK5q+/BvI0
	5/O6+Z8gDB8OmFi4IcqQ42aP1JCLt2oEfEAiue1N4YkmlRaRz93F309H/ByGdtOUq7xDNrLJO7i
	SoBr2qn7XSh/3RopZ2W+mt3w95Gg+P3fzicTdR3M17nuBzSKlpTnDm3mTEpwy9BYLNElEYANFX/
	bRRdWSLNP6kQNhBqWSZYZ+TiqUtXKRTzzTiNGfamXKCkiY5vOY6q+QiYvNFVL4l7b+8vHRgvKU9
	+XARol/iBtKHhYS41RfKkaSmvLzLBirgIj6qmO6Z9YJ9CvCMi9UhQhFZZdkeivLEaZr3rXr2qol
	GPjvaYGScPJk0VFf4vgD7MR9Q/uaM6aDgTwKw4Sa/pYExulZiLPkGU4RV/9bJx2affpocoTYokC
	KWA8OUwAkheH/0me6Wq0I6xKP5GgI7fla5GjyVxcVgjLuWWnj9gQEh
X-Google-Smtp-Source: AGHT+IEA74edq3+dyMLlgmnCRuVmLBdYX6fNhM1QDtL9saT8iC2ai8pqYwcC3APkrPNud5im6U2udw==
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr141029385e9.19.1761295031346;
        Fri, 24 Oct 2025 01:37:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm82671315e9.4.2025.10.24.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:37:10 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:37:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] replace strcpy with strscpy for safe copy
Message-ID: <20251024093709.5115f8b0@pumpkin>
In-Reply-To: <20251021145700.38374-1-biancaa2210329@ssn.edu.in>
References: <20251021145700.38374-1-biancaa2210329@ssn.edu.in>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 20:27:00 +0530
Biancaa Ramesh <biancaa2210329@ssn.edu.in> wrote:

A complete pile of bollocks....

> Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
> ---
>  mm/shmem.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b9081b817d28..6e5a5d6fc7e9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -657,17 +657,18 @@ static int shmem_parse_huge(const char *str)
>  	if (!str)
>  		return -EINVAL;
>  
> -	if (!strcmp(str, "never"))
> +	if (!strncmp(str,"never",strlen("never")+1)){
>  		huge = SHMEM_HUGE_NEVER;
> -	else if (!strcmp(str, "always"))
> +	}
> +	else if (!strncmp(str, "always", strlen("always") + 1))
>  		huge = SHMEM_HUGE_ALWAYS;
> -	else if (!strcmp(str, "within_size"))
> +	else if (!strncmp(str, "within_size",strlen("Within_size")+1))
>  		huge = SHMEM_HUGE_WITHIN_SIZE;
> -	else if (!strcmp(str, "advise"))
> +	else if (!strncmp(str,"advise",strlen("advise")+1))
>  		huge = SHMEM_HUGE_ADVISE;
> -	else if (!strcmp(str, "deny"))
> +	else if (!strncmp(str,"deny",strlen("deny")+1))
>  		huge = SHMEM_HUGE_DENY;
> -	else if (!strcmp(str, "force"))
> +	else if (!strncmp(str,"force",strlen("force")+1))
>  		huge = SHMEM_HUGE_FORCE;
>  	else
>  		return -EINVAL;
> @@ -5679,27 +5680,27 @@ static int __init setup_thp_shmem(char *str)
>  				goto err;
>  
>  			nr = end - start + 1;
> -			if (!strcmp(policy, "always")) {
> +			if (!strncmp(policy,"always",strlen("always")+1)){
>  				bitmap_set(&always, start, nr);
>  				bitmap_clear(&inherit, start, nr);
>  				bitmap_clear(&madvise, start, nr);
>  				bitmap_clear(&within_size, start, nr);
> -			} else if (!strcmp(policy, "advise")) {
> +			} else if (!strncmp(policy,"advise",strlen("advise")+1)){
>  				bitmap_set(&madvise, start, nr);
>  				bitmap_clear(&inherit, start, nr);
>  				bitmap_clear(&always, start, nr);
>  				bitmap_clear(&within_size, start, nr);
> -			} else if (!strcmp(policy, "inherit")) {
> +			} else if (!strncmp(policy,"inherit",strlen("inherit")+1)){
>  				bitmap_set(&inherit, start, nr);
>  				bitmap_clear(&madvise, start, nr);
>  				bitmap_clear(&always, start, nr);
>  				bitmap_clear(&within_size, start, nr);
> -			} else if (!strcmp(policy, "within_size")) {
> +			} else if (!strncmp(policy,"within_size",strlen("within_size")+1)){
>  				bitmap_set(&within_size, start, nr);
>  				bitmap_clear(&inherit, start, nr);
>  				bitmap_clear(&madvise, start, nr);
>  				bitmap_clear(&always, start, nr);
> -			} else if (!strcmp(policy, "never")) {
> +			} else if (!strncmp(policy,"never",strlen("never")+1)){
>  				bitmap_clear(&inherit, start, nr);
>  				bitmap_clear(&madvise, start, nr);
>  				bitmap_clear(&always, start, nr);


