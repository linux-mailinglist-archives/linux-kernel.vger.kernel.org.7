Return-Path: <linux-kernel+bounces-735144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA6B08B63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3DAA41FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE629CB42;
	Thu, 17 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm02R3gE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D629C33E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749759; cv=none; b=ePtiZTzu+gjmQLf13LyxOExc4O0IsUk0YbH4X+DR644IULjnr1kad4XbKFb636nk+rHHyI11um8x5JWtXvQztkzvO/iOXP6VZ6CphCcF+6E/ORWuHKEFxjzPze97f+FXu+0eCXnxUhbV7jal+lFdcaSCk5lBsxu5N6bWZctB/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749759; c=relaxed/simple;
	bh=gSxihFMQdPhp7IfEUpVtWMpenx++JDqChT8iAbuth6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFCZNxXgxooMT5G4M9Ts3xqvUw95o0vTvMhYjRzJBMy9kHvzyFLzB16Q4vmK15j2CCOSRPUeTXoEfjTO8J7EOYf0/fRQ66QAAsJ73t0mo10rObYIcWEGMtNA0Bof2QkR7vO9WwoYnVoAqGCRfIqM/1iKUPFejkKOhZR56llhXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tm02R3gE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752749757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
	b=Tm02R3gER4fpTgQy7CQgMuYvmxZs8k6ZznzYC2WmgFXdQM3nmnZ9jqOQSkTT4pUzCHG+gU
	UUCHy3GKz9ca3D6tW2EAyo5ljNoL/4hb6DMH6q7AxCiw3nzGtu0wZdtPnOPLA4JhKLfZLx
	w0P8PlyggRqROH4ojEZ1oDbgq8yIg20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-u-CJ9TrmOmykAFBx4pUhRQ-1; Thu, 17 Jul 2025 06:55:55 -0400
X-MC-Unique: u-CJ9TrmOmykAFBx4pUhRQ-1
X-Mimecast-MFC-AGG-ID: u-CJ9TrmOmykAFBx4pUhRQ_1752749754
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso6856775e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749754; x=1753354554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
        b=jRwLtxB6bar7sWqx3h9TKoKmkGX06Uy1h4OZoksExXNjy69DHFC8r+31bGYB0XS1Iz
         7mXU+/I0ZxWBkUgfFyWPTpopXe8dMKvTyNgjFdiaeDg7/Ie76J2MEvDKo4YIIZM0O4tJ
         9NHyU9UBEcu4UtdF/r9OnmIw3x2zgJ0RoBlyLtG7aPyeXNuggPpFTlfSZrH81Z9/Nw3k
         hSd/rT8heKOaxLQBtPgQvwBQusWyXdFUTAnRVW9F1m/NKkaSTnbvWqckcYsX6LN4QN/U
         cKYiHP9s25LqZORNjKjcF2jbdAp/7N+0dBi5jIYvEON/uyZlA9wgtjdnEcLRTTXq05Pd
         95vA==
X-Forwarded-Encrypted: i=1; AJvYcCWecQoZQcMfWlE7ItyJelXGATr5PuYNUG7dev1PU0m+BM7g54MN4Oc+uRAt2wzDNPThn9DmcHfMEr5Wvj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HgOCBjZ3jWl61L+L+KBpMjbyBsvmaBIUG0klzcS7XnZtTrQD
	6zzGg4b5FWNeGyDCZYBYYrFMZnQoKtRVVVGGhWG3Alm4js1wyKA36Br4V1JmALBZU4C8B2qAtC8
	283dk+D7OGLWKR2ZbGMqMAlC3fXpuY3zN/MyHSdDLInYDoFWgVIHixgCeaM25OB8inA==
X-Gm-Gg: ASbGncswPiaVHKlorb695i/UOAfnolthS8RRnll2XQE9k0VmNaUNY4jDNo7tSszB2T3
	kksWqQqrqmc0yJ0YbcQ+0KZe6EKmoZ2HIEzF51m6SZUB6sn47L5gWZqX4EMKoXGue9wTwYzrLc4
	sWAKNznCTR8IpCmIdkl82KkUsaUenX4f91LvcDMO6P/upL76jQRZB2eArSVGNchtclLCbbt7WHn
	UTjultB5iPhrVC+3zfdfYI/jMnWYkwvH1+BH8PHbPXlCiiuqM3Qa0r/uoy33UtG1YTxE2dKCUhy
	LP2+oDbeS/8AuICazV2HCaAJY/CGPDE23mbAnixf+ckPBK8eceDWOvWF86sr5Nt0s8+yAemqE5B
	z4EaiKUrvuJ4=
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983265e9.23.1752749754322;
        Thu, 17 Jul 2025 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hmzgeO6mfBS8jGYj9rG77mwI5Itg2IPeN3BeV/EmE/d7ghhRi3L/99no/15vSa70B3AChg==
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983105e9.23.1752749753937;
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f4c34dsm18920425e9.6.2025.07.17.03.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Message-ID: <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
Date: Thu, 17 Jul 2025 12:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/25 7:15 AM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
> expose the device’s raw free-running counter.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index b1e2deeefc0c..2f75726674a9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>  	return 0;
>  }
>  
> +static int
> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
> +				struct system_counterval_t *sys_counterval,
> +				void *ctx)
> +{
> +	struct mlx5_core_dev *mdev = ctx;
> +	u64 device;
> +	int err;
> +
> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
> +	if (err)
> +		return err;
> +	*device_time = ns_to_ktime(device);

If the goal is providing a raw cycle counter, why still using a timespec
to the user space? A plain u64 would possibly be less ambiguous.

/P


