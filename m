Return-Path: <linux-kernel+bounces-794156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E0DB3DDA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789D61882F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAA3043C0;
	Mon,  1 Sep 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ne7f7yqD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2953043B7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717755; cv=none; b=IfPjnQyPzAE4dCYKCmmD/cWLCHWN0rHVnygqXtykr0eJ2YlJ5jbxOWk8sS3iayPl5OKjnOYQ1xtM7rfc25E8WO2s85OA/fJ0E4tsiw0YJHeMd3VocHNtknVihMjSbDhZDaTn6ywRIXlU3DJShyeMsWEOYURDZMK/2iC8fj7Tes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717755; c=relaxed/simple;
	bh=PHiUvICP0aYOlnmmgLUBKOKa0p96Stm0kjepB/azcGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8iDLeYPYBVMsr3TTvhwhTiSlbXgUpyMF6AkVXdsF2bMQMF6Q/Uj4vR2Re6pdbbyUY2ZT15yEzeqgbykILpDflgemYaiGO4ZrZdqhoGNjdMTQ/5pWWXxaZjprGlgAM5mnPNzu10mBEi+GsRM1X6ukVyE87hqHNSujTkahAqUiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ne7f7yqD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so7932825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756717752; x=1757322552; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+Xo4tkbFhwj2dkE+zxlT5qS+Qcu77hpuQM/6Wfp1/E=;
        b=ne7f7yqDpf1iX5VpqbqMCjmJ18NrJwPJq8MibfKyMhdjdtynmvsyVKEb/YpNPqbDBE
         jFJfMaHP4zETrTygboZu2nTeaT7PaLd363uWE1M90OZCrvfZVUCYVb/udXmpjQ4TcTxf
         tcni66ehXbo5B3mCl3rtCQjiFnTgDQk4QRr8QEJ9oVKHlCELqB1MqWAbVLWWKQlwBlIf
         YvWEvKHL+T4IB4Xj2VNsagIVQ/U4jz/k/5EWcZzz9pGLlidXVy2oIMsMNQLVApyK9cEs
         ouxTYPt7XalW0iNWZuoNmMwOmfqDZT0fmewIibTtaydTX3bALtjmIUTzomVLzIKtCGiQ
         71vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717752; x=1757322552;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+Xo4tkbFhwj2dkE+zxlT5qS+Qcu77hpuQM/6Wfp1/E=;
        b=lhhaOUs6E0jVOEJKqbX5HtkVfDGgfdxAfRglVlvlPNAJJXYh7Hi4b18HzwaNQP/p3a
         DYYZ0stdeZP4O2UjZvP69beTpBMiIj5+gUPQTFcl3a/7yVvRDyhgObv53poVQcIuPQua
         hr7DHZkndsPOBwwoaLIOh+E7As2Ld+jLyRIbYAggdOOjIZ4s7enTVxFCm7JTvpvqp+QV
         bSVxX7wMlKq7TxoUFPfR0mP5DSJ2teM9noqagX4i1mDBc4rg1yIRq7jp3UETDCdkNlPQ
         8sk7jnPAvj2b7lWWy3t65YYPQkkvoL2PonL0HXsyfiMX0vEt+V+KcOl1++5H10otnk6Z
         hjow==
X-Forwarded-Encrypted: i=1; AJvYcCU1ijYRHmU7TIEqpJTZ2BLGAwwzTipA0gH7yfhuvuHyx7zyN0q57s5Xk5JUF6oGj8VTGic1r7j3DcBq5Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0m+PNVYIMxDMrn442nkSk+BY57QC5PiMCZx1LIzwnhqMZKH8D
	TzecIg0uprqdtWE6Bwj/F7kMDj4h0upt/sEuhjjSy086JvziL+jqRQL3C7y5OSLS+tA=
X-Gm-Gg: ASbGncsE0ObWKPhPTfgUHEY7Ramz52Y9x2s3AnWSL2JvqbWGBiLMg3OiWWMhtzHrKFl
	qA1EKyRHAEdwr2M7oCCTANxqfivQISXVAjMV4DYoON4kwO7yNeH2lIrR23RDbgIZx5bCwk70nP4
	c77h8UHSEdPfg8O0oZKMaQUvf3n+ExHJEiUYQxtyzTxhfVaICVTLPsIH4uJcgW6cs9P4TBYry/5
	ctBrNjNQKUDvneEI1ezVv8Dbd20da7bxmfmOTW44osHFnzZLKaN1+3thfTkhl+bA+uSIf+qKX6m
	62vFLChJUB6oDDQecI1l9S1mcB5ghqqVTKpgz/vWJgUol7AqHWpki6VtOanfcUlNsJUiUtwLtZA
	yl0znIxV7uveOrX/dkX1QUMExby5QRnSC+RIQaA==
X-Google-Smtp-Source: AGHT+IGQBSkz2khdRsQAv7vacSGMiUv3G+dZ9L9wmpydMb3GXDxwfB16QPW8+IRZec1HkLE7lP8j4g==
X-Received: by 2002:a05:600c:1e8f:b0:45b:8067:d8ac with SMTP id 5b1f17b1804b1-45b8553362bmr52083795e9.13.1756717751775;
        Mon, 01 Sep 2025 02:09:11 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm6940335e9.1.2025.09.01.02.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:09:11 -0700 (PDT)
Message-ID: <ce55ed06-7326-473b-a2f9-40b0bc61c396@linaro.org>
Date: Mon, 1 Sep 2025 10:09:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] spi: spi-fsl-dspi: Stub out DMA functions
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-3-3246957a6ea9@linaro.org>
 <20250829142636.7nv3ylyck5yda3fd@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250829142636.7nv3ylyck5yda3fd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/08/2025 3:26 pm, Vladimir Oltean wrote:
> Hi James,
> 
> On Fri, Aug 29, 2025 at 12:46:45PM +0100, James Clark wrote:
>> This will allow the build to succeed with !CONFIG_DMA_ENGINE, either due
>> to a randconfig build test or when the target only uses one of the
>> non-DMA transfer modes which this driver supports.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
> 
> Sorry for not paying attention to this previously. I didn't pick up from
> previous conversations what problem this is addressing. I built an arm64
> kernel with CONFIG_DMA_ENGINE disabled (by unsetting CONFIG_DMADEVICES)
> and it got built successfully. The .config is attached.

Did you test with or without these patches applied? It's only needed to 
make the commit "spi: spi-fsl-dspi: Use non-coherent memory for DMA" 
build because that's a newer function that isn't stubbed out like the 
old ones.

I originally tried to fix it in the DMA code so it got spun out into a 
new thread, which is probably why you missed it. And the commit message 
is missing the reported-by and closes tags which I'll add.

> 
> Please post the specific build error if you haven't done so already, and
> give a reasonable hint at the technical motivation in the commit message.

The reason we saw the issue was a randconfig build. But it's possible 
that someone is building the driver without DMA as well, hence: "or when 
the target only uses one of the non-DMA transfer modes which this driver 
supports".

The new commit message can be:

   spi: spi-fsl-dspi: Stub out DMA functions

   In a later commit we'll use dma_alloc_noncoherent() which isn't
   stubbed out for builds without CONFIG_DMA_ENGINE and results in the
   following build error:

     spi-fsl-dspi.c:(.text+0x644): undefined reference to
        `dma_free_pages'
     m68k-linux-ld: spi-fsl-dspi.c:(.text+0x67a): undefined reference to
        `dma_free_pages'

   To continue to support devices that only need XSPI mode and so that
   randconfig builds work, stub out DMA functionality in the DSPI driver.

   Reported-by: kernel test robot <lkp@intel.com>
   Closes: 
https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
   Signed-off-by: James Clark <james.clark@linaro.org>




