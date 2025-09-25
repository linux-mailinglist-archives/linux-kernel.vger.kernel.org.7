Return-Path: <linux-kernel+bounces-832139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC716B9E748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DC4258D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EF2D7DD1;
	Thu, 25 Sep 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM7nNPhU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F31ACDFD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793248; cv=none; b=SCVtvbJOEJSS74TRce9vTqrReX6bn8UpZ4VVSHUZGhzd3vfQqEq2jaafpzG5SfrQnj8ClsIXq03/HEe5zhLAZHRBAV9SStCu26ce9Rp3dsR281ZzWflVIYsZFN+VGnLwHRc0x9x7wOGDIZLA+jeWXtC0FepmqGuWF0dGM+fYLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793248; c=relaxed/simple;
	bh=Ismx6yKHMCrWAtzO1V+zHu5cuIvgP8WRaG1URDkbiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g3iWmtQqwD/8DSAymE8lJSD3FO7txQEt9Y25U+mXH4NEkac7BbHMf5pi2yu292DVnQZMRHoK69xhQiUdQKI3i7Xr5jvYfyEBydyPqdqYuZ4a1lK5tCBW1l5/ayOwoWZq96u6N/1v8AQOZYaHSvxI3DG0wlXCfFnizx6GzrVSTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM7nNPhU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
	b=VM7nNPhUVAk4Qs0rVVAmraMhV5ziteRXcRsjBOLHaOMjjc4E87QalvmqJGk16mNJNiamkI
	G0nfyRFDqsYqlKa7KOo9/qpKA6HpgANVOxoXFUzqXx9DPlTy1Ly+Zj4v/b+iTGEGTtGxKA
	T8tqfyY1zfmDcaab4okpd6icCpps9dk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-P-oAwXuMPgqvOEvanC_87A-1; Thu, 25 Sep 2025 05:40:44 -0400
X-MC-Unique: P-oAwXuMPgqvOEvanC_87A-1
X-Mimecast-MFC-AGG-ID: P-oAwXuMPgqvOEvanC_87A_1758793243
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso741559f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793243; x=1759398043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OC7o0y5NqDwPgeMke0PyEOvsv7ZIPwi/d2lkMqYclw=;
        b=ZkI3Krfycnp0JPIIlFD0CJFO5DkYr+AdbSZPNRg5A+pX47+sEmxosCzoMSsmu7lWeh
         W12BiZilgc834vn877QUcin9R+WRIJ6pLTIFdsHN2fpZgB5tRM4+oBo2jLa0A6ey70Vx
         w8UWpEZI7e8OsqXLR5rvdJY4XEzcQpOZ60zE7JdWXToM8SVMnO6xB69SIED+vfD1SQw1
         TWco1gnZR+gJPwpmfm2IgVk9PMkJkMD6qQUvdFMADqc9Bzhdpw8jQNPxKd5NRzR60fIY
         tBCeAIdspR4p2EApovCUDAHHC81drtPf+rtm4nIhseuCbLG4RYSqpPXWpqeNsufmSMpQ
         U2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwhr8Fzd6LD1T+iLVe5E/1Zc620cwaUljG8yuRrGnJJQ6zx9tuksPK6dYRFd9t0+dGyk/YIG02xNtKOOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF56lxJNFWbdAsG7ZnVAftf6tJPWswur5CHVRtEK+4t8V9q5GH
	TjrXswlsPUTZUZzdySp7wWUJVB4Qvu84XiFyKhTZJkpmJQhgPdix4/MQnOEjM0oyjG/5V+e9VzN
	oL2Z/eVw7OWiV8q5EqIc/Kd1hcxCzRwBK1T9SKmrqme9MgAOFirNnEkf7WBopwoEGHA==
X-Gm-Gg: ASbGnctta1AFvea+hf7oRoU4Z7olOqkpL2G1L1vIIZjuTiwk5f6Ks32WdSYoVgzkyDj
	yz6iqG9UtQXcokFJQait3ulrloyQTQyAOswKaufzU9P2/pE6nPAa+0XtySWJ/yegnoMCGKenGzV
	SDS73XaT2JDpqmmcVWD8kPBX1tKfT4Z1TMfoN3AiJ9xvORNyYpJNRqKDTIOWPwqCNEFOKtdiXPF
	M9+fxJXKo4vDRbc87QwdHQCig/5bzKZfIXJ1/1urBrUBQAzfMR71hMEokGK7xDM75kmH0QTVzSx
	adj+7XT9NCdDfBn4wM4DO0ljOUPbNbiBY0pc5SoHhI3pxdD42CbzgnwMA1N+F5P87APjPQJ+hN9
	0z8ujoig8itw9
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786408f8f.32.1758793243370;
        Thu, 25 Sep 2025 02:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxeBRnYoMGSl0W8MRr9kJ35noutUmBpUjFhjol2reKWsJgQ/uDYSHftZAJXtiFbd/sSnPig==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr2786379f8f.32.1758793242960;
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9e902sm25724495e9.5.2025.09.25.02.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:40:42 -0700 (PDT)
Message-ID: <cd1c6040-0a8f-45fb-91aa-2df2c5ae085a@redhat.com>
Date: Thu, 25 Sep 2025 11:40:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921214440.325325-3-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 11:44 PM, Halil Pasic wrote:
> @@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>  	rc = smc_llc_link_init(lnk);
>  	if (rc)
>  		goto out;
> -	rc = smc_wr_alloc_link_mem(lnk);
> -	if (rc)
> -		goto clear_llc_lnk;
>  	rc = smc_ib_create_protection_domain(lnk);
>  	if (rc)
> -		goto free_link_mem;
> -	rc = smc_ib_create_queue_pair(lnk);
> -	if (rc)
> -		goto dealloc_pd;
> +		goto clear_llc_lnk;
> +	do {
> +		rc = smc_ib_create_queue_pair(lnk);
> +		if (rc)
> +			goto dealloc_pd;
> +		rc = smc_wr_alloc_link_mem(lnk);
> +		if (!rc)
> +			break;
> +		else if (rc != -ENOMEM) /* give up */
> +			goto destroy_qp;
> +		/* retry with smaller ... */
> +		lnk->max_send_wr /= 2;
> +		lnk->max_recv_wr /= 2;
> +		/* ... unless droping below old SMC_WR_BUF_SIZE */
> +		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
> +			goto destroy_qp;

If i.e. smc.sysctl_smcr_max_recv_wr == 2048, and
smc.sysctl_smcr_max_send_wr == 16, the above loop can give-up a little
too early - after the first failure. What about changing the termination
condition to:

	lnk->max_send_wr < 16 && lnk->max_recv_wr < 48

and use 2 as a lower bound for both lnk->max_send_wr and lnk->max_recv_wr?

Thanks,

Paolo


