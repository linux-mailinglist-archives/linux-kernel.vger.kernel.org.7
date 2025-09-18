Return-Path: <linux-kernel+bounces-814214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85049B550E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FC91CC0E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079C13BC0C;
	Fri, 12 Sep 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmEeiPsu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862C303C85
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686809; cv=none; b=dxYH8gTTTKhQiragDxTnThuN2fGhMCwhp7bnN2jl+A00GMa8OmcNgG4HtCZ/AifMyWESNsNnxdwQJ3f7/Rv784y7rFCJa8PObkJLKEtkBwYvWJm4xcNJqWwoPvT6jtxjbW28o6M+y/yH+XdhRgXTlbQyvKooojSFqjw0qs+tmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686809; c=relaxed/simple;
	bh=3l449HK5NMkexamVRNEtGUCkmphtfcrXtQXq+LiZQeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FU3GhsSh3NPnfrvSY/EJpODs/TRxjiuEIQNB9R5omIqBKaTDes6Llfs2ajkCIlzWhL0DmK7kp0z8CimL9cjMj5TVGlLAAjxqQ4c66BrjXrg/yAeqn26kz7tg1k4UhSR9zHhsJflsJ4B/EpXEUAilLYAKiH6ZcdQcnLXTLMUY394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmEeiPsu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so17820325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686805; x=1758291605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmChZKjhh7WfaCiO6qYrnubA4AUjkq4py7dLEKKsD0M=;
        b=gmEeiPsu0A2ECPHnslD6nMU7a8HpEImCAT2kADomDXZ3Qo0/HU3Lhwxx/c8r3Ir2UF
         PDKiQMvH/UiMi6sQx0+kQxaOLMqLA4V5z/Ejv6DUUnE6LEv0+NO4X2K1A1ndc0MkKJ+j
         ZnyxeHzoU1W2d75gU95FC1LTAxxayDbhtf/77BsniFKx7aQTho9bMvYcYbyhNa9/g9nQ
         abkQFvttfvr++m8W7unHXUviB6UJ81GaLg/fF+lw8MfptZnanIemXWo4/w34CC+/mUSA
         nCjkfQ3z80/EOK5bpe4Dw+ghV4HTkb6XAevsL2MYPzbezhXc02TrzJmm5RRW3oRt+bxh
         LHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686805; x=1758291605;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmChZKjhh7WfaCiO6qYrnubA4AUjkq4py7dLEKKsD0M=;
        b=EphKL8QyGZACbD4BQZU1cZdLp31d0gwJLTxDRSAPMFt8khcvdP1cq/OUHvZfIVttz1
         SV36V28//cU0Bk14sXmr2kT+MDhyx2kdCJ7LnjjkLeiuXSA1i+DAUXlLVNLkPFGAYjUc
         t8D7cGua4aVmW8SSchyH7J4I+65PTkBZE7uVFAAdpdD7ndO0a+G//SPofZ7aCAhxOL21
         UTuuGzrRbM6D1+eiZofozuJYNsabz7n30zIIbbqp6fwvKQS0MAmyRBO8IsQ/7DiOS2Dl
         JwDbABJoOBC8IoUmRYH3r9qnWDZ6J0zrM79sO74YeTHZ/X8iMiZ+VPaOc/9WUtI2ypAj
         wCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXcx+d0zs0oZsVs1iCd+lcvcZXFTU9OFfm0ppJXxU145wO+JurEzyPzsyIWwtflxRIUdSh/hfN66NGvn5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsseAn5Wleyc0YuYlcDXjVAZvorYR8kguzDNfVcZNTOWjSt/l
	wTDLqH7yp25DJlqWL3ySaA5T01bDP88ekyGe3IoMr22AzVi57iBrDhrL
X-Gm-Gg: ASbGnctrA21ztAd1Oj7FDLg/ijar1i9Eb+VOvoAX4VAmgFXkWSJyLBKXmQwwbZpWlPj
	+78uG+j0TBPHutY7tSwfi86NK+Xu4seU/YUewdpl8+vlG76RwQWVB9CWvxC2a+I31mzh95pgqBu
	0CKNF2QhDZLb7TDDhFuiwxI01UeSJIcwMZa1JCVClejIgE7Xtzr21YBpCBn7oQQfradf5f4D4uo
	FnyETbD2EN3T19fo9XKS989jp0aT2LuYRZoATZys2YrKLi5tipFF1puBV3UsNSRSs0+9dVtB5Ag
	Wiwx+iYA9hc9uuppVdlSIcGmxPS2e4gGAp2WiBNd49Sb8A4lN+igV0lGi1NnDxAeG4Wv9G3SKtq
	pQ5QHECGrZis2Pofuqzd2R0NrCpkYqenYWJFTTsTasA==
X-Google-Smtp-Source: AGHT+IEKyinmwbN3yHvqC2TBvEPXOSoCWcr50U1b0sgHZon43u3EkY1RVzIl5661xTla3PsOT681zA==
X-Received: by 2002:a05:600c:5254:b0:45d:f55d:3478 with SMTP id 5b1f17b1804b1-45f211e610fmr36884815e9.17.1757686804707;
        Fri, 12 Sep 2025 07:20:04 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm63475385e9.9.2025.09.12.07.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:20:03 -0700 (PDT)
Message-ID: <c3d9cdfb-6cfe-41ea-830b-3ab0f6ebcd5f@gmail.com>
Date: Fri, 12 Sep 2025 16:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/38] arm64: dts: mediatek: mt6795-xperia-m5: Fix mmc0
 latch-ck value
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, robh@kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, krzk+dt@kernel.org,
 conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jassisinghbrar@gmail.com,
 mchehab@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
 kishon@kernel.org, sean.wang@kernel.org, linus.walleij@linaro.org,
 lgirdwood@gmail.com, broonie@kernel.org, andersson@kernel.org,
 mathieu.poirier@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
 atenart@kernel.org, jitao.shi@mediatek.com, ck.hu@mediatek.com,
 houlong.wei@mediatek.com, kyrie.wu@mediatek.corp-partner.google.com,
 andy.teng@mediatek.com, tinghan.shen@mediatek.com, jiaxin.yu@mediatek.com,
 shane.chien@mediatek.com, olivia.wen@mediatek.com, granquet@baylibre.com,
 eugen.hristev@linaro.org, arnd@arndb.de, sam.shih@mediatek.com,
 jieyy.yang@mediatek.com, frank-w@public-files.de, mwalle@kernel.org,
 fparent@baylibre.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com>
 <20250724083914.61351-21-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250724083914.61351-21-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2025 10:38, AngeloGioacchino Del Regno wrote:
> Change the latch-ck value from 0x14 to 4: as only bits [0-3] are
> actually used, the final value that gets written to the register
> field for DAT_LATCH_CK_SEL is just 0x4.
> 
> This also fixes dtbs_check warnings.
> 
> Fixes: 5a65dcccf483 ("arm64: dts: mediatek: mt6795-xperia-m5: Add eMMC, MicroSD slot, SDIO")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index 91de920c2245..03cc48321a3f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -212,7 +212,7 @@ proximity@48 {
>   
>   &mmc0 {
>   	/* eMMC controller */
> -	mediatek,latch-ck = <0x14>; /* hs400 */
> +	mediatek,latch-ck = <4>; /* hs400 */
>   	mediatek,hs200-cmd-int-delay = <1>;
>   	mediatek,hs400-cmd-int-delay = <1>;
>   	mediatek,hs400-ds-dly3 = <0x1a>;


