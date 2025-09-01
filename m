Return-Path: <linux-kernel+bounces-793814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 757CCB3D895
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 647587A546B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16BB21D3E6;
	Mon,  1 Sep 2025 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV4flMyH"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B411C8604
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704050; cv=none; b=gTi+PfcM5jHeKhSi7XHvBukHcPz5vJu9lZxIM0swcYrLcsMfBO2WiNftvFOB7Dzg5O2J6i2NVKblXHkUPj0wFsBH8QY0/k9p7P9DIqXRtINPbsFuTCvv4D42O/k/ag//bUbPlaRiqnjoBhI8DCNcQm8qCtGBfXZq6njE9RkX4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704050; c=relaxed/simple;
	bh=tkBChYR4K8prjKACAdbWtOwcTV9LWv5kMgMrfH96fmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEZvOWgpAVRgzZj14FpbX5ZreQxRIX7xcFXqGqrN55pt8XroLa6Tc6KbNbkqnAh/nXbtVQgHzQDUE4KyHTyAdXiogXm/CgINtocDQYrPUoCtXDmucOU1JIjSQx4BdG+aqrMhjHyrZh+iJUOkyjP0gwpiCQW2PkY24/k+tq5Et7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DV4flMyH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so632699a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756704047; x=1757308847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wf6pebIPuJaWGNGVYougDPoqTbfqQo2QN0zscbx9wE=;
        b=DV4flMyHkH849fkb4BtEGxTEZb+KtEJsb0YvpP+V8Ug9rAi/3V1reVHMh9teG5BZeS
         59r5f9/3cpn5eIefmmaonaRRm2ORPmVjul8d9gTgAvSK7c5RvRT63LH6vgL5B8AI17Xg
         8rkXXVBsVwySJ0U+QC0yo6ZUj2j/qCZJ3sIf0xK1nMpGqWPZ+iXer5JKNvRRuuI8qtA0
         A+LwHm21y30HZeCGJ+mYxpgqJjHDtFpPB1uOI6AUGRz9xzoAMETGWYLj40JpaPNZSUbt
         P0GOC5so3i6r8cnVwfkY7PETI1+jy+2QbfETsHMun/Qhcg6p8EAEglgzUsg3nbBo6btM
         ZUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704047; x=1757308847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wf6pebIPuJaWGNGVYougDPoqTbfqQo2QN0zscbx9wE=;
        b=UV2abDpgrRge9TJtYnT5QPqvJV6m+wgwQPpGOrAbY6w34740qUtVZu7faNUamxwBoQ
         kTnSztVOCCcNDoL6+Bhe4LlU+hCXcm0Lmd0WuysO0z4+2P31UxMXTMsWzMyTzOyyRQzv
         +ayoac4G8o4arBQzjtU1yiighTT/5VsbILVoefM6OM4eioCuFjvF35Z4YgVe6XhjtmBN
         fTAzh3XTl734u9c03ciRIU1cl/FNYrF8nfT6LcEfV/ImfFPcMTLrUmUQ0e6bcHn7bE0W
         9SGjCDdDv6VgRa2I27LJlKtulIrHZ95P3Wyf53Br/4bGzEx//ZHolk7ZWkGP9+03qUWv
         IVtA==
X-Forwarded-Encrypted: i=1; AJvYcCXmbijJl6Lf/W7fbdCxqs23koG4OR0EpH4/1/4qiOA4FfDO7oFZuWD3D9tLPmXNq8P9mXVP8SJNkAqCLT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwRDGFzWJ0zYthGifD4xktlOknEUITCmTwLdeaiu6g8z8il18
	goLol8j7AJEww2W5KsDq29rTD9HticaEf4LZAguydWm0EwnCfPPb441RnhqSSU+DwGc=
X-Gm-Gg: ASbGncv4hGsoIY/06toM4dFrCXSXUUHyc4zBMB+S52Z1oY9s1P21xkcAWICkcNEb2yn
	3wRNpbLdq0jzXibi7IB5GVwaqCIZztyCB7YskuyheK8/RzdtvrpA0hH3CrgqXjRdtQIbI1iXw+K
	ZYqMRU+XiybsME0CbEHGLGnkldYZ3gE57lF7L0jjNkNR/myIzn4pIey52yVcYbp8rL4XdZA0+IQ
	y6szhXUNaxffUJTdSxk9NiJarLpr60WmKI4fFymFlVnEVe73wgKiiFPRBN243xIgFMLcBioTYrx
	KE7skM7w+KLNaOP/zTIBfCO53oYYkwqAEKqyYe3aUmQdLBR5zIFsQ1/cla0CsLZzz0qM6aM7CYO
	vZoi5gh9dyrfI5Fp0l2ki4wb8
X-Google-Smtp-Source: AGHT+IFiku1vWnikojoaU2D4teEQs5rxhjU+GtOPjQKLGItwIy20kQ8nIhlQ6l3ScSsZBAVpkdATyg==
X-Received: by 2002:a17:902:d2c1:b0:248:d674:2b5 with SMTP id d9443c01a7336-24944a3c860mr81521735ad.18.1756704047474;
        Sun, 31 Aug 2025 22:20:47 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067df2e9sm90187735ad.152.2025.08.31.22.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 22:20:46 -0700 (PDT)
Date: Mon, 1 Sep 2025 10:50:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dennis Beier <nanovim@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/longhaul: handle NULL policy in longhaul_exit
Message-ID: <20250901052044.qtjcd5q2ycch2n6c@vireshk-i7>
References: <20250830144431.159893-1-nanovim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830144431.159893-1-nanovim@gmail.com>

On 30-08-25, 16:43, Dennis Beier wrote:
> longhaul_exit() was calling cpufreq_cpu_get(0) without checking
> for a NULL policy pointer. On some systems, this could lead to a
> NULL dereference and a kernel warning or panic.
> 
> This patch adds a check using unlikely() and returns early if the
> policy is NULL.
> 
> Bugzilla: #219962
> 
> Signed-off-by: Dennis Beier <nanovim@gmail.com>
> ---
>  drivers/cpufreq/longhaul.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index ba0e08c8486a..49e76b44468a 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -953,6 +953,9 @@ static void __exit longhaul_exit(void)
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
>  	int i;
>  
> +	if (unlikely(!policy))
> +		return;
> +
>  	for (i = 0; i < numscales; i++) {
>  		if (mults[i] == maxmult) {
>  			struct cpufreq_freqs freqs;

Applied. Thanks.

-- 
viresh

