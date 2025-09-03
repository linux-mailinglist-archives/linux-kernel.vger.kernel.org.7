Return-Path: <linux-kernel+bounces-797682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E0B41374
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ABB545D16
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FC2D3236;
	Wed,  3 Sep 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LX6lc/8I"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D62D3233
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872892; cv=none; b=gYkMn5rjKp2KYilO5ps3VyG8aG2DKutndvEBaMUZEryYXMHT5DyN6RTtGdMdnhraNDu4BbJOInv+YHycEz8zhbRdUt0vdsb8PKs5wlUmjxUnxLwLawRTGC5cimPvAd2joriIz18CwSxj+VuJna9c4NvLyXfACWy4C7v186Agoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872892; c=relaxed/simple;
	bh=pwpMnp02iR5Nb2xJei5nSyPw103lFtmOwIACABH/wec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4DHmfxby9v5uLNo8dGa4nKq0HnyJqKN0NMw8FE3kb9zB1B0OkcHlltnPnQHk1AgLjCc9ATdYKTdrzmltG/F948oDwgMHyi/RA8uFf9wp3W91uQf67MSAytJ8BpUW+6TzcPo9uRxgDr26Ut5PwdHCa3K8xvIO3YJ48rZ6u16mY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LX6lc/8I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3277c603b83so3764194a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872890; x=1757477690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3736M7NCTLnENtRRfPhfcHj37p+iIh+YlnUYDC/dTVs=;
        b=LX6lc/8IUF+pScPW4nmbhn51UMQyqKdHekTgDIDfQdbQ9lHh8iyUPz07ZqI9zKxsI1
         /O8a9768TVrLkQbL+3q4T7WmHl5xBKaQAT3WsgxsyPdFWbTKdwxXoIe9wIt282YRGvLB
         /T6wOd/GGB+5iVgPQ8Tn60GPf5pgzfLfOAldSZlNxcok2RcQj7MS9rbgrhcOzF6ns/2B
         G2dX28q+jGRg8TiC4lRYTp/tdiBPGGngqL+Z+Afnq1houfRnbvz1gY6JRAYDrTEwwiLt
         bBdzHv20KrimuzXdjnkQeAmzdiLZ5hK5hSzGlbF5leNJni23K+KJVmQKIllLIPA4DcZD
         EgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872890; x=1757477690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3736M7NCTLnENtRRfPhfcHj37p+iIh+YlnUYDC/dTVs=;
        b=O/ti2RgULXuC4QOjwV+GqqoWLKTR0QcofrKaP197sAGUW6MPWYQ2mbPmh1B9NmSjRT
         /1JvTCIz2l+8w9dyJpa6BTRjOIQHB52d033buwMa8dWmjAG3UwoyOz4Tcov3gr4/Y6V2
         DxJqM5mZAcz7zBX13q7caFzDjhH7+FCBCUUU6Xgf5fzlaa1e0KTzcv7DhWA3gRp+OaUB
         i3/aCH3BqWX922+vCkp70Y/+GTyZMpuJrLIWKbQXQhVyaAzhexkORgq/s1s3NFVBsGvp
         O2E/irmLGTrvLfzxhk3pEkCk19WsBTkZDSqoAYJBM3FVgLFhIVYY7IYsuDLlqEV1N4xa
         NnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2xZZw4A1nbyqO41quuDn7Dg3CfnXiKsbelcU4dQ3VTNAD0wnYHCqvTXR3STsljOg3Qfosg5WLMGx4VFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPxrfID61YdEYr/DCPx2DAbSJqiBjDMzwn8VBPzpjQVP2mD90
	f6ta/ppMGgmog1emTtrTBPGZ0BhF9KkY/ZYAncE00fTu9GFYw9LWySnnEjnY+MrWAUsngSD/gOS
	OmwkZ
X-Gm-Gg: ASbGncvXNZrsE2uM029NIz1FVIYC54r/05NJt06S6fHpuYXtVfhbrNDzQeKz2eUUE9X
	/U575bvwpcud3pljyjgdN1guMmYtAZfeVBT1K5XM9FHWsYsVppsmxmzUpu5Z3XwhMgkCynT+tgd
	becK7N/A1YU0iGSoWWFkGfZPcg/eZ46VaOPm/rAbfZ0sOYjyAf45y0iTbHbigcw9IZDxl/NSlD8
	/EOsvDf8Of37oNOr3UTdcEAzzdXC2mL2ExQTGQ0p+CDgU1BB4y4ja+3185SNdBMX5442MeQkULY
	JXlNkf1W3d8mse2NSr0F11Lu1PEx8/VFaNGfsytb1GstLfPUz/kYg8SrKFMkUuIuQH4Ksvsrzr5
	TaIpW1sKqkXEUSd87Ij08XLKpCsUFbp6F1dI=
X-Google-Smtp-Source: AGHT+IGcvj4f93HyRKYjmm+ix+F/dgYOGHgJhEHnb22iW86TWueIT+1XgMH2qdsfKMuWPvqAcJ0VJg==
X-Received: by 2002:a17:90b:2884:b0:327:ca0a:67b4 with SMTP id 98e67ed59e1d1-3281544fe3amr20695525a91.12.1756872890400;
        Tue, 02 Sep 2025 21:14:50 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d08a36b3sm4862695a91.25.2025.09.02.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:14:49 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:44:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cpufreq: powernow: Use int type to store negative
 error codes
Message-ID: <20250903041447.6t7q5ddoqwm3og4d@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-3-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-3-rongqianfeng@vivo.com>

$Subject is incorrect.

On 02-09-25, 19:45, Qianfeng Rong wrote:
> In powernow_decode_bios(), the 'ret' variable stores either negative error
> codes or zero returned by get_ranges(), so it needs to be changed to int
> type.

You don't need to mention this now. You are making a different change.

> However, since the 'ret' variable is only used once and can be
> simplified to 'return get_ranges()', it is better to remove the 'ret'
> variable.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>  drivers/cpufreq/powernow-k7.c | 4 +---

There should be a `---` line in between these two statements, you have
corrupted your patch somehow.

>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index 31039330a3ba..72430c3c5500 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -451,7 +451,6 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  	unsigned int i, j;
>  	unsigned char *p;
>  	unsigned int etuple;
> -	unsigned int ret;
>  
>  	etuple = cpuid_eax(0x80000001);
>  
> @@ -500,8 +499,7 @@ static int powernow_decode_bios(int maxfid, int startvid)
>  				    (startvid == pst->startvid)) {
>  					print_pst_entry(pst, j);
>  					p = (char *)pst + sizeof(*pst);
> -					ret = get_ranges(p);
> -					return ret;
> +					return get_ranges(p);
>  				} else {
>  					unsigned int k;
>  					p = (char *)pst + sizeof(*pst);
> -- 
> 2.34.1

-- 
viresh

