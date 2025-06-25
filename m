Return-Path: <linux-kernel+bounces-702176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF97AE7EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1730A5A001A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11527FD74;
	Wed, 25 Jun 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfvJVGp3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF31280CE0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846763; cv=none; b=Gn76DbIRnyzyvgIJ6rDz0UM4hrgKnpBl3//HfZw+9/wo7vuHiGvK1m4yh40nmr4GQTGe2SBxmcVk9c1osby7dgNDkHC3mTh5pQcQ1h/KH4tLScMicnenyn7ATfJ8B092DlP1cHQvczvPurntr/4X6k292g84bm1NllrX21Ub8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846763; c=relaxed/simple;
	bh=rETTiKlx9Yq3+PDQAIMBB+ZMyTfACLEpmK3go+sZBpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Weexz+UaP6m3JNvpnrD0bkgTn3uAg5fhp+ISHJ/yOTB3HHhJbqu7RavAqAa4Ef3mlEwFTxFiYJVLvjUN5nA6lzXb1I6XyHe0d5gNP2DhZVGj3ChCGsdWBYuAUwW9HFN0oRWi53x5VWjKXI6gNnTI96V2UnWrVMWdHTst6pt37rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfvJVGp3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a528243636so928098f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846760; x=1751451560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Ll2qquLfGh6XGelYBblYLwfpUh2cahEoEgX9BFfgbw=;
        b=NfvJVGp3TubCBf0g17UIMvrTcf99TG1Iy/OWDOJVBHJWMEvOATSV4m7+tsuqSZMCGs
         +zTix8YwH0DcLlV8ZmJiVtg5tkSsuiRGQd0SJSvnsXkEzRHNVvUOMMZweKlXsrE3jgOI
         IRxggfxwBCpYwnelbVzcaw7AEuB2OUGaBFXFxB09e2C2LFT5OnzKAKWqfuva2PAjRezD
         HHZPKHOyesb0lghoUsH4AYnw+1c745eVBaeh1E59CFdvcP2wpehRKbqRRglEnZ9CuqIu
         SQEeW+m6lke+WceSEqCuCf8q3nzFQEoDNaZKfvbq5Fg6yHkC2XIC5UZpCkyUTv50NWV/
         etmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846760; x=1751451560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ll2qquLfGh6XGelYBblYLwfpUh2cahEoEgX9BFfgbw=;
        b=Y9ZtjzvEwDcA35JSk9Hr2+oyVaWaaAwnCMaQpt07pM1XufweNVZuILrLYAtWLTcZyG
         xe0nxmMkM2UZfJGxGQVhpTRwgEttJZ/rMc+YLP0r6Y6APtNYUtPYgV6dJDVPjxtm5gQh
         PXL1uQ62KE2hDgJ1kkbXjTDKKFTJlddTj2L5dRWvPBodk0Gu7YB/7pusqwdt2l7j2/6z
         HD9d6OLi25l/43bplvVshyCcuchTHDL6dPOQiH8ljx8d71kXeYKmXh+FduL1m2FvW2s4
         ArI7CEupz16RYVvBZ1QREEOloJRLAGMTvQPQffkGnCtHP18C9JGD3SyV/uH95CkTr7EC
         F9cg==
X-Forwarded-Encrypted: i=1; AJvYcCVr4bXzdMuNUh8hcsjozWdtzYY9gK1Q1ktUz7mF2B9XRr3oSazGNZ039YHr7QxCK/L9hP1IoOjbujiXkjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DhOn4zSsJriLa0C1S8UTdVjIS5Oc6txgG39Q02dN1hGTr1H2
	rHrKFGk11bD2fPRFV2xO8a0KNPZ1y/7+Lp+34bpwKcAPUW14A5nHTzAsoxhHri68u1g=
X-Gm-Gg: ASbGnctYRvPWtru6Iz0iOrj/hDIvqVvzZTt6FHbSnyHLBowOI4wQv3Rc2UldObXoZ1+
	RWLb3TrYeoM7K8Zk08WfHZxtlHRIAXKo/VB8itiJtuJuxUVzWV617wi9MlgreCKrH8iUBu7Re+6
	fSqi9sUQvzc1nwV2BskFZ7glyXiWOmAFUaPlktwIxNqnC5xgpjIUg4VXo0kV2EiQdzueAgmSJDx
	NRgnK8RR19ylDkHvTVo2H/qRNfKGNxnHXMSBlOYPxy3ncHcYjDhJt+LKo2HWVLpOIE/kzRGfXqj
	x7MuYWBd65HIY/UCY1OBmIs1xe4mPmNohqf+t+YBjw14KcQ3gXNQH/CyMX/3Aq4m2mU=
X-Google-Smtp-Source: AGHT+IG4AQnRsnaojqWPjOdW6AAh68yC766lGy7h0in8xaHoSs5FdnvmUELehZ0zifBrriq6WAa6Wg==
X-Received: by 2002:a05:6000:2c0f:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3a6ed6746a1mr1929543f8f.52.1750846760466;
        Wed, 25 Jun 2025 03:19:20 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234b1b9sm15217565e9.11.2025.06.25.03.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:19:19 -0700 (PDT)
Message-ID: <884e86be-112b-44dd-a827-30355a5fdba6@linaro.org>
Date: Wed, 25 Jun 2025 11:19:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] spi: spi-fsl-dspi: Stub out DMA functions
To: Arnd Bergmann <arnd@arndb.de>, Frank Li <Frank.li@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-3-e7d574f5f62c@linaro.org>
 <aFrSgJ5xZfccEX9x@lizhi-Precision-Tower-5810>
 <290fc244-e88f-47a3-8dd3-0ec27eb5c60b@app.fastmail.com>
 <0c6c78da-575a-4d29-a79a-3903aa801b42@linaro.org>
 <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <0f904f12-295c-48fe-96c7-c64c461cdbbd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/06/2025 11:00 am, Arnd Bergmann wrote:
> On Wed, Jun 25, 2025, at 11:19, James Clark wrote:
>> On 24/06/2025 6:16 pm, Arnd Bergmann wrote:
>>> On Tue, Jun 24, 2025, at 18:29, Frank Li wrote:
>>
>>> It would also be simpler to enforce this in Kconfig if we only
>>> care about users that use the DMA support.
>>
>> But most of the devices supported by the driver don't do any DMA. That
>> was the reason to stub them out rather than add the Kconfig depends.
> 
> Ah right. So even when running on SoCs that have a DMA engine,
> you can end up not using it?
> 

Yes

> In this case you could have an extra Kconfig symbol to configure
> DMA support for this driver and use that in the source code:
> 
> config SPI_FSL_DSPI_DMA
>        bool "Use DMA engine for offloading Freescale DSPI transfers"
>        depends on SPI_FSL_DSPI && DMA_ENGINE
>        help
>           ....
> 
> 
>       Arnd

Wouldn't that allow someone to break it by disabling (or not enabling) 
that option? The driver won't fall back to the other modes if DMA isn't 
configured, it just won't work. In this case it seems like it's better 
to depend directly on DMA_ENGINE because that fixes the randconfig 
issues, which is the whole reason for the discussion.

Would someone really want an option to disable compilation of two 
functions if their DSPI device is one that doesn't use DMA? Seems like 
this option would always be on anyway.


