Return-Path: <linux-kernel+bounces-786344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC3B358A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC60A5E6457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A3305E1D;
	Tue, 26 Aug 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHb1ZsGq"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14592F9996
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199884; cv=none; b=h4lNEYK4aRwwmOvHklFfDfrlr3SfS1eVjQkZUNHp0V5PmH4nq9jzGV0HXx/WqNOaErcB7EHzQfrkMUJQ67kmCGZeF9Da7bCJCGTwtmcmFH29CI5ARTQmmNm7xULWT6syL2a4anXTl4G/aUXcL9SMsAKZdA4CBHgZX+5mmOrUfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199884; c=relaxed/simple;
	bh=qU1FNAvLd80qOQlVY6xxS4NT8YfSf+GBVrPU98hM9wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQjA4eotRsT/NYCF6xx/HGPsW4+d4sQeLSJHUJrFtOClnkB4+OgpiwncsHI7t51NkCJCBaxjUQtC1Tbpyhu4yG8LtB55I6NX5w47bDQF1lu811qQN+KsvE0ZPTYUjJ8FfRqnQTOZbJP2Y2hUdrWlLQWiuK4FUOGPjN/58ZSsW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHb1ZsGq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c854b644c1so1727963f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756199881; x=1756804681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bARKiXzA6hGcwZbah7s5OpMlMCRfJH9Ze1dsDZvGjrI=;
        b=EHb1ZsGq+nG7yKedbabfcpe97VSgwZ3z2+XrdotQDz7w7jU9D/8ibhQ32ej9VzZrZe
         I6jBPbI8XEKg6WVYtRh4WUWWp20t2JUSp10B/s4T8ZIE2fj8VnMfdjdTaxNmJx/ICdbc
         mcpqf/KOyeGd1LECtN1lVRiz+YXZ1BKYTn6y3MWvvv/N3Tx56SyijMNNnzgqHqcKYKzG
         JLhegiaoQksqNH6+4jzKvtGBmeEIkGXTaxObYiem/H1AYTL9p2YFdZdm8zmmtO0xJPXZ
         faA/KqqkMUICN5z2yQVsFKRDKzTLvC7+LKoHoZQyA2K3aG0X9EIJ7P6z28rBWBfS22XW
         jeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756199881; x=1756804681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bARKiXzA6hGcwZbah7s5OpMlMCRfJH9Ze1dsDZvGjrI=;
        b=ejdCY3kxkmhWYmbyNnhdjHK1XyOPXTHJDzBIvXcvqle9x42BypLTAWAfP22hBaNZyw
         aTO+laqjZFJR1tiKKUky2BHBvHhlNPpTkaKggBGRxHs/wX1Xhn6F7kIJErJADgC2qTZz
         9iP9JHbPMaeHFA1nM1pqPKPR4hzPd8s8pH1a+lEMxQCek4Fl1jfTyD2ioubgrSHnSsOd
         3DXHqiW8RuSn6WqMVWRAQi+zgKIbLql+5By95basDAXqe6fyB2u1pGF+7/ZeB5M/+WYT
         tY1+48rMrgyr1c1Uc3tVqFDfqqH9V88vJFEZOo/wSZjuQWOfocmRWMMGg+UNhqjuEp7R
         EK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRthPqfe4UE9wV8i+hNMvxhZmkvcAB6nRMHqbmOOJbyEgVZuo2CbZocbu2KGqZ3rPVv1f7d2Sx4M140Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28xWF2fGDGxwcMxSuHsgI5K+HYWhSJCB7nzBpw4E53gOpl/jU
	Y/I+BNflaxfpCq7ekfKc0hv8jxreZelkgx/ZHsJJgme7XPnQOlkE2Kh/W4yx1ein8zM=
X-Gm-Gg: ASbGnct6SFSfD5knPEqVmc94mTimFqYV+4tuO9xm5QO0zFcmqetZc/M/76I480C7nju
	vx5gIACxddDDqYGDZ8owVgfojbbTOeTZZbzqzWQ4MMLe2HEyHPbGCcUoeq/Lhjg9wHh25OXJ4gP
	Cm8Hut3dXbw7sen0S53dGOuJ9DZgUY+waLH2o6WoOJe/rOy8ZorsycwPEU4prrSS6gkCk/SCzl2
	kIW7lREBhSgeRvY9oESjlzcPgtrGUnaH+stULu4Hhy3ueaIUv0+tw+KFzOFQkRjq9EgmPpCuOrw
	YOhqI6MNQpLi14iHInWamO0iNgNvLe6R9/XVio/Kv9HxlU84hwoeArrUbAcPCqMjyZhdi+mdn/o
	dVO3JmA8d6vc+ICdQqcC3Om1W2xA=
X-Google-Smtp-Source: AGHT+IGAZEs053vHudyipY3XTEBo1QStAY7/xTMg751YeNtyJEeHMj0XEwwbWsuR8ch7OFkISHSqhw==
X-Received: by 2002:a05:6000:24c7:b0:3c8:1df2:540c with SMTP id ffacd0b85a97d-3c81df25723mr6978339f8f.43.1756199881181;
        Tue, 26 Aug 2025 02:18:01 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753ae41sm142300465e9.9.2025.08.26.02.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 02:18:00 -0700 (PDT)
Message-ID: <ef2267d2-a6f4-4f51-be44-687a4074a4d3@linaro.org>
Date: Tue, 26 Aug 2025 10:17:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] coresight: tpda: Add sysfs node for tpda
 cross-trigger configuration
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
References: <20250826070150.5603-1-jie.gan@oss.qualcomm.com>
 <20250826070150.5603-2-jie.gan@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250826070150.5603-2-jie.gan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/08/2025 8:01 am, Jie Gan wrote:
> From: Tao Zhang <tao.zhang@oss.qualcomm.com>
> 
> Introduce sysfs nodes to configure cross-trigger parameters for TPDA.
> These registers define the characteristics of cross-trigger packets,
> including generation frequency and flag values.
> 
> Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpda  |  43 ++++
>   drivers/hwtracing/coresight/coresight-tpda.c  | 241 ++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h  |  27 ++
>   3 files changed, 311 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpda
> 
[...]
> +#define TPDA_FPID_CR		(0x084)
> +
> +/* Cross trigger FREQ packets timestamp bit */
> +#define TPDA_CR_FREQTS		BIT(2)
> +/* Cross trigger FREQ packet request bit */
> +#define TPDA_CR_FRIE		BIT(3)
> +/* Cross trigger FLAG packet request interface bit */
> +#define TPDA_CR_FLRIE		BIT(4)
> +/* Cross trigger synchronization bit */
> +#define TPDA_CR_SRIE		BIT(5)
> +/* Packetize CMB/MCMB traffic bit */
> +#define TPDA_CR_CMBCHANMODE	BIT(20)
> +
>   /* Aggregator port enable bit */
>   #define TPDA_Pn_CR_ENA		BIT(0)
>   /* Aggregator port CMB data set element size bit */
>   #define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
>   /* Aggregator port DSB data set element size bit */
>   #define TPDA_Pn_CR_DSBSIZE		BIT(8)
> +/* Mode control bit */
> +#define TPDA_MODE_CTRL			BIT(12)
>   

This one is missing the register name prefix, like TPDA_SYNCR_MODE_CTRL




