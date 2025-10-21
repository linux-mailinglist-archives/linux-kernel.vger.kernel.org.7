Return-Path: <linux-kernel+bounces-863543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF2BF81A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848C40066C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E734D936;
	Tue, 21 Oct 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="qZrqNO/I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9434D91A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071809; cv=none; b=iipZC1FCgBbCyrZ4Fe8nmFsqQUID4YRlQ2MnW9CUBQPGZgxPrtslkrVTe4naqksK91XkOgORgir2c8QE6fDLAMRa3MfybFFGWErLK8DEPGNZijwewiDUWaEkf4Tt0F/qBHZoo1Sxisbz3nmxAZ78fKIJj9HgGH4UzlK6Gh05ZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071809; c=relaxed/simple;
	bh=+P4ANvuSavfcnKH62tr+Cug3Rf+Z+UGRmWABjDVFotA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTie6iTapUfKNWytuHQgIuBCRv31w8/SdCaXRAwfCSydWs2Pp1eqy+IkgjBwryktZ9iEC9vBcdrrIfqVDGm8MvJfKpgNaO0ObwBLQClmIJmCfPjhGlH1RsI4H4Rg+5QnwVCVefPsJFLgvFq3zFVJSBONGRlPTkx9GWqu7jGI+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=qZrqNO/I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b303f755aso63677445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761071806; x=1761676606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/31NMDpjYxX79hD0m9CWPcEz0sXm9H/7kszN6l94dI=;
        b=qZrqNO/Id9RifjTaQmi64699CqsnWL5aNkrIB2GhnYzKq/eYuNLbuap6xnkWnCafVs
         oDWZVpmg+7QLw7q8v1Hd+250HDb0LcxLtGuhi7UqzRJHRRzMbmaT+MnOB9kzsxHu5gcp
         Crgs9iBXLr6Io/kZE7LY8sOVkiK3ed7+z0dM24GA8X14Ny1x2JZfZtJNAE5IjfjglrFk
         /0BdXgNFapMM2Ve2ze9fzPr5acDC63z8a/NT93HLxXGTHUnx5OUpFIAWKDwjMLE7B7UG
         XyX+MC7BCq91v6+NwweVXLNioQII1KpwKaQin5Er3r5wz1G1yGs2C2neT9BOt1HevCIV
         9ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071806; x=1761676606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/31NMDpjYxX79hD0m9CWPcEz0sXm9H/7kszN6l94dI=;
        b=cn1dpT5wXddsBg1KVqJOnObHWqWbFdxvPozgshpd4ymRiT8lBbTDT/oXVJF+9mPZ2Z
         BAiGAd1a/T7iMK2dylx6SC8rm//F2qmC4lGFW+uDOxwo4VrTMSZwRBXibw8n26beZ6Mb
         nPeSmC1CbGBKQ9KclGPo7p6QrhQREPjHSpPytuCo0uQkSnRdbg2nIoPB+G1C86cvR6QH
         Ze/Ma5wLlG/EknFjIGgaX9Sd3HmNP/cEtekK3EM1khxYBaIAo9ovL90++0XAKgyHW8iJ
         5oGKRleCDd1wAI2OTb1DckOymucRwFMkLPTE5abfLzj3rIeCl6B5KPu3d2FzYyYYmZAi
         fwOA==
X-Forwarded-Encrypted: i=1; AJvYcCUX6D8NDf/FylMmQuSx4yXsAHYFruw469/ZCARZDo5qbr1zmLsjrNrZdRH6wFOd206GhhBm4A9tgaibm2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oLgjZuuxMIRBBYkxm2QCY5FVq86HsUuEwFqnHZ08Jahnxgl+
	Hx45n0YTjNyBECdpr/2p7VgvVfk24Q877gUHo6BF4X47GLpUEc+P/QkRvc4+KpKaGmk=
X-Gm-Gg: ASbGncsaCos6oPG+APq8XBbTeCqleY4ohPW0/LnUedwM7ACoshGvG07ldV8OD+akB+l
	XWO8WwQchI4ij5mnr5rOtV+vL5UXlWY71IFXfZ7u0ccIhm7dt7SzCEq5PIn6eXna0cpBTlphUZr
	x7tiXhg4G7M5JXv8W+GrV72xF2J2Fbv0xTi7Eikht16Ym9q/iMOk2APYMDe8FTEyQnOHA04x6So
	+QPAfMpDw8XPepoyTu6on/yAAMa6lC0SeuKLzAE3gG/zE9dBjUvhMKlqF3vW5CTRzNkCAVxjy4h
	Nq8+DSDjKzM1MzuLUpHESdRSBcKUjWyGXvCjvV+WjnE3T5Kj7Dgo7DlZrzZuFQK4alijbak9Azo
	75ajMiQ+ReusQOn3wbHfiv3B0/D1+a8cERJFn77irpZGQNvjJKcKg2DU2kZvUlVtCvLGe06EyUN
	f5bXzA5hUaWBEWAXg=
X-Google-Smtp-Source: AGHT+IHuD5mgeD886pEcOy41CAh/C4EmnxTay38r/3oLMR6ZOooN7HM0ZxHB9uqLJmXa6KYTzdPWRw==
X-Received: by 2002:a05:600c:811b:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-4711787c803mr131576495e9.12.1761071805713;
        Tue, 21 Oct 2025 11:36:45 -0700 (PDT)
Received: from [192.168.0.101] ([90.242.12.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427ed3fsm6714205e9.1.2025.10.21.11.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 11:36:45 -0700 (PDT)
Message-ID: <d9c16e9e-8321-41fe-9112-e754445d8bb0@ursulin.net>
Date: Tue, 21 Oct 2025 19:36:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-fence: Fix safe access wrapper to call timeline name
 method
To: Akash Goel <akash.goel@arm.com>, sumit.semwal@linaro.org,
 gustavo@padovan.org, christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, nd@arm.com,
 stable@vger.kernel.org
References: <20251021160951.1415603-1-akash.goel@arm.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251021160951.1415603-1-akash.goel@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/10/2025 17:09, Akash Goel wrote:
> This commit fixes the wrapper function dma_fence_timeline_name(), that
> was added for safe access, to actually call the timeline name method of
> dma_fence_ops.
> 
> Cc: <stable@vger.kernel.org> # v6.17+
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Fixes: 506aa8b02a8d ("dma-fence: Add safe access helpers and document 
the rules")

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Apologies for the copy and paste snafu.

Regards,

Tvrtko

> ---
>   drivers/dma-buf/dma-fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 3f78c56b58dc..39e6f93dc310 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1141,7 +1141,7 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence)
>   			 "RCU protection is required for safe access to returned string");
>   
>   	if (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags))
> -		return fence->ops->get_driver_name(fence);
> +		return fence->ops->get_timeline_name(fence);
>   	else
>   		return "signaled-timeline";
>   }


