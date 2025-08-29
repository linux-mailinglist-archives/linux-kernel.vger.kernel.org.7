Return-Path: <linux-kernel+bounces-791114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEFAB3B218
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BD91C8742E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ACF28371;
	Fri, 29 Aug 2025 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCWX0dnQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0D13C8E8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440967; cv=none; b=Bdrw/GKedbAVzXDXEPpEtjoM/v2ASp2yGb3240yp4PgkiX7/2vdh3OaYzXfoieGyoSBxYvGUXTZHOyFdjz4VCal7zqd1UXMRRnndZ4sEN0eWVIv4LLLww0kvF1LJ18W4rdGPMh7AbVYFzBom8cfr9rsj2WBiJlWIUKzLDEWARMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440967; c=relaxed/simple;
	bh=Tkvu8pNkFd205YZuldCAgZ98rpKB05AIMFFpdMprdno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIL0FM+rMs28lO+Aj1kPtsf7qkX7ltZGB5j86hnRJHt87BV7bKSEQStVER7qOiFw5TlLkHNFTnxnG5wCRB63+kFpmV29Lnfd7T+YEdJU+Cuhd/xFkOggact8j8A04cWGYYKf5PDDBO8PzxkNaSdpR9xG8AFIEFeQTnPC5IonAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCWX0dnQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445806e03cso17796935ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756440963; x=1757045763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLIksirgxElP0838CFgIqzzpTLOypIpRJfIiW6HAyvI=;
        b=NCWX0dnQnDZGg1sslxCpu1fSKGSiTTgasT7DMqz6M270ixe36/wWnRYIvmVOxDGqoP
         lMug9d3wiJladlgvz0eSRGv+R6kxKWjF0PRqW8ZY0EHtfFfAJIQod74KsRpMC9tQhLNT
         kxos1waItqg/ZYesRFJiAbl2+2PWPd3khNsCZW/qO9HXgAJPSG2lkYq8UIAX207xgHqv
         U1ihRt1yAwrNz+qGPMxJ54v71CWb2Tr8Pf0pjClhWMnNQWcW9jgwoLqMO06jICk2PD7J
         cGSoD6Bo/n3tJj1VIZTZiVBYzfauC2YGpVimft3z5wWKwBhzmjGNWcbDcgilRoPMiTI4
         +tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440963; x=1757045763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLIksirgxElP0838CFgIqzzpTLOypIpRJfIiW6HAyvI=;
        b=nhd4PT+98C9BLoP1wupBY68U/8ZPged3ruzyKFvZrtO53PlB8fIMlRFh15hpL0KUmn
         eixpA7q40zG9uJdodtqu0ehaasCZe3F3pcU4dV1LUUbk6DnyjiSxqCYjpDnhvmYQdw9n
         lkB6pZEHk9jC+CZe62dhSIEZqTIOP+nPSuCSb8Ykln9pbyZcdfS4xevvFXUTFKjkyNqw
         y3K00vohMplP7ZBeJkgfKOKQQoGUJVtGi+wsZDQBvdRdpRNX66KhyvnlexcweTStmI7g
         u4TISJ17FwHNmLCnYWcjM/Im+G4P2JiTUwlbeILMkSWOinw/4El+2YnU87X+LKqirm6z
         S3kg==
X-Forwarded-Encrypted: i=1; AJvYcCXS8+rmiEf9LLvnWOYc7DgGdw0JkjJHU8X1sC1x35sxggpyQsHSbbFvziqdVFmhO2imJc3niXqSDp/bLls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAS9P7cA42mvOEym64BSthjlcVyFLwKhSE9ufFVJmw5jyVueF
	MG8nhu4hytJfirUvPHsqzECU8TOtpdusx/61rtZjdee38XdlQ2zdbizSI47837jelb4=
X-Gm-Gg: ASbGncsAKmfFAlfw92RwcyGYai8cVbjvtZ3xJ05EHGle+fppf1XIPUw1pRQnY9JYzfb
	bSI6jfIbGN1u5WXVsA6YpqmilxybyhbDdJ38IVD9HE10aOmHQ4nGHnC2DLRz21fEg+uuFaKIkDg
	MmDSNum6Bty3CbBK07WoKJT3kpSWGGwIcWmW43KeESJJXEXElyIB77esUfGrO+TSyD1C1lgH/v/
	2+eB77AiBJpFomUCGZ+0mh3e1NhtN2J+ZNo4kY7H5RELxvOvkS531adS0JfRT5EXtHfIIa5vdl4
	H6IchvIXBjc8FhRByPFm3EIYPaDDC/zF3nllRxdLEKP5f8W2FNgrA9C3Qj6UhVISfxl/luMPPfF
	gk1hOpIm5g1c9/TEQ8PDH2Bd6JvuAzaUbSHyDmM7B0W5lBQ==
X-Google-Smtp-Source: AGHT+IFTtyPlxhHuxI/2IH3LiGsWs9ydV529VJDopa/F9yT/ZDbBcbt4dqu3BSsOo/zOh/nC4NEfwQ==
X-Received: by 2002:a17:902:ef06:b0:242:9be2:f67a with SMTP id d9443c01a7336-2462ee0bec3mr338420325ad.11.1756440962736;
        Thu, 28 Aug 2025 21:16:02 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065ad9c0sm10691895ad.125.2025.08.28.21.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 21:16:02 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:45:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dennis Beier <nanovim@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] cpufreq/longhaul: handle NULL policy in
 longhaul_exit
Message-ID: <20250829041559.jzdb5stfvlpztcp4@vireshk-i7>
References: <20250828213427.27593-1-nanovim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828213427.27593-1-nanovim@gmail.com>

On 28-08-25, 23:29, Dennis Beier wrote:
> 
> Resending this patch to include cpufreq maintainers.

This should have been added ...

> ---
> 
> longhaul_exit() was calling cpufreq_cpu_get(0) without checking
> for a NULL policy pointer. On some systems, this could lead to a
> NULL dereference and a kernel warning or panic.
> 
> This patch adds a check using unlikely() and prints a warning
> if the policy is NULL, then returns early. Also, the loop variable
> is now declared inside the for-loop to match modern kernel style.
> 
> Bugzilla: #219962
> 
> Signed-off-by: Dennis Beier <nanovim@gmail.com>
> 
> ---

... here. Right now if we apply the patch, it will only contain the
top line.

This is what I get now if I apply your patch with `git am`

Author: Dennis Beier <nanovim@gmail.com>
Date:   Thu Aug 28 23:29:36 2025 +0200

    cpufreq/longhaul: handle NULL policy in longhaul_exit

    Resending this patch to include cpufreq maintainers.

    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/longhaul.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


>  drivers/cpufreq/longhaul.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index ba0e08c8486a..9698d56bfe6c 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -951,9 +951,14 @@ static int __init longhaul_init(void)
>  static void __exit longhaul_exit(void)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
> -	int i;

Please don't make another unnecessary change along with a bug fix. If
you really want that, you should do that in a separate patch. Also, it
is just not required.

Add a blank line here please.

> +	if (unlikely(!policy)) {
> +		pr_warn_once("longhaul_exit: policy is NULL\n");

Not sure if the warning is going to be of any use for the user. I
would just return silently, the module is going away anyway.

> +
> +		return;
> +	}
> +
>  
> -	for (i = 0; i < numscales; i++) {
> +	for (int i = 0; i < numscales; i++) {
>  		if (mults[i] == maxmult) {
>  			struct cpufreq_freqs freqs;
>  
> -- 
> 2.50.1

-- 
viresh

