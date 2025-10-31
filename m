Return-Path: <linux-kernel+bounces-880289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBDC2559A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809903ADAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA28234B40C;
	Fri, 31 Oct 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+ce4UTe"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8E3431F0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918617; cv=none; b=upaJeZF4cq0RA2SGm7MW6hw68tfelx/gBU1142pGByf1xedMjTShDjSMowCXqzIwk16Clspjxt24C8wbvD8JvqrQFUEHaF0B6WtmmQ6Jxobf/1yxG7QOp6Agdp66xNbYLbN73ESMTDtpgmOfWAoOJz4jx4ETfaeNgu8bRKQn0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918617; c=relaxed/simple;
	bh=sJK9ZeT3NeI+yYKJ/cWiElYXfQmjsmNW67JpnnKD89I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBOuFsSKjraPjYirEtA/vRqH9ogstGrM5uxDb/8BnM/ec9SrDt013PxQVyt50UbcvZmoBuoXQ/eOqVY0q65utqcWF0TMrSv1rWpVEApZTb997IJPi2qr3H1a7rvawWlChpHw1yCePPfToUlp+sYdf8ww/J9VawVDp8zmT5RRdqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+ce4UTe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-474975af41dso16777515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761918614; x=1762523414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OH6TtzH8OEdYvOB3XWCwPOSyqERGuFlVmCf8h/N53mY=;
        b=J+ce4UTeid7p4DBdewWfsPVn++ZnPGNLtm6Dh2/F74hbJEDctDNtrj3cu0GDjmNBVc
         9B7APs8IB0KJjM9keqb1htXl+ALZ8O8Eu4MhQyto9vr/EU3Nbuc+Qd9uF4Q+kc4bgCMI
         6By5kwCc8Azy/IRx3eQoTvNL32WZ6/lVBW1Rc8qyjkQj+YodVL76c0N4VNHYlxBNwxV4
         vvRKfiOX3kwINO5QqwzMPGPfTlxFXsqL5gaVVKHhjchvNODaQMziXDDR9rQTkHgG+Uwr
         JWt2+etM5oE2mHfDftxriJvF3+c12HhDoGWnDEij6cA/ukEINd1op4L803ZPOVYF/nPZ
         l3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918614; x=1762523414;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OH6TtzH8OEdYvOB3XWCwPOSyqERGuFlVmCf8h/N53mY=;
        b=lHQS0qoQ/7BhOEZLdA6i9RreuOEcwV1Wt+dukqC7AzCXlYSpXHvXANzTZzhNbM3GWO
         /anp3nd71aZYu96vzg6yv4guctt+NK03bdVNhQ7p5RXo51RupTn4ka5euLVQ5nuCKiUP
         wjLIuaTVXFaZfe0jfQT659iDInOJGbsCU75PkQsF56T+BFtT+Xeffdrhkps1rXiVaAYc
         NB9DIVEcc8z1yB604obHTkopAm73zREXqb0tpZI4aBOIeTnCZnDGHBiS7Gp8mMQQOhYj
         84CFfGBmJeKd/pMRjaiJABLlvo/1DbulkL8dZXfAzXT+mJBOuwbYDIzM0CCC/tW4Q4kg
         2z0w==
X-Forwarded-Encrypted: i=1; AJvYcCWoaApTzltZTIO7dpG7IVqNNnA+7HuwNMB7c56FPEwa6MRkiAiLNIvU4zi0KilORLYRMJiUbyOLm2tnoCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnZJv92O2jxaYiPdLuji7MoqVMJVtayOwe65VKErkzbzZBmrD
	44Y2ku2sgfU97fb4ozdPOQTJvpl/hKaUlib6LWNew15ZTgzGrtj/Flxx1ghmDo56Nng=
X-Gm-Gg: ASbGncv4IQ39od2Od0oEVR1Glx5lKtZWD7VD77xBVuPdZD+utrt8H6ZuEnUmRQxDNI/
	+aZ1JFG3UM5kboXkbjwiX+UQyHL5WOx+HPfB96lD79ke/EZwrcB+9KcBaa3t1E4tUSD4krdNVJ/
	4K7LNbt3skb9MW0igErWYhbveN4k8MIgn9z+o5wB5z2FUinZr+PGoUYsTWw/FEEvVpSOZVqWWBY
	A0aXn6kUXgaq0g6Ot/Bc8XM5IAAGVVwYXs1udwB2Kbx9IXCFlGMiVTTgHEY17d+FTFjW6xWjn6T
	NVW3cFkpDXkrdo+4/OB6kZBaluZTXud++PBLDgplhPrCgN+KPMJn0sUGTd5Fn3ewxUyXN7JFNTV
	Q7xqTo+yvSydo7DDFB3Ehz47hRSyAp7tb/km7BD4Ld6aMC9CpouUNxvz7JWcol1BYH+gE715mv8
	34WiysWh33qt8EJsLrpBTuphAeKFHkR5AeJK5SDKQb1A==
X-Google-Smtp-Source: AGHT+IHswv1jbMa6PmgS62PAO0+xDI1T2gX2fd6DNwet+e3yBeSvkacWO3qek5if48rbanP/YLfkhw==
X-Received: by 2002:a05:600c:314d:b0:476:84e9:b571 with SMTP id 5b1f17b1804b1-477307c2afbmr37052435e9.14.1761918613142;
        Fri, 31 Oct 2025 06:50:13 -0700 (PDT)
Received: from [192.168.0.21] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c114ca0csm4373033f8f.21.2025.10.31.06.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 06:50:12 -0700 (PDT)
Message-ID: <631e4da1-92a0-4d44-b92e-bdcc56196c26@linaro.org>
Date: Fri, 31 Oct 2025 13:50:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] media: dt-bindings: Add CAMSS device for Kaanapali
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
 yijie.yang@oss.qualcomm.com, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20251030-add-support-for-camss-on-kaanapali-v5-0-f8e12bea3d02@oss.qualcomm.com>
 <20251030-add-support-for-camss-on-kaanapali-v5-2-f8e12bea3d02@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251030-add-support-for-camss-on-kaanapali-v5-2-f8e12bea3d02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/2025 02:59, Hangxiang Ma wrote:
> Add the compatible string "qcom,kaanapali-camss" to support the Camera
> Subsystem (CAMSS) on the Qualcomm Kaanapali platform.
> 
> The Kaanapali platform provides:
> - 3 x VFE, 5 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE Lite
> - 3 x CSID
> - 2 x CSID Lite
> - 6 x CSIPHY
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> ---
>   .../bindings/media/qcom,kaanapali-camss.yaml       | 406 +++++++++++++++++++++
>   1 file changed, 406 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
> new file mode 100644
> index 000000000000..c34867022fd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-camss.yaml
> @@ -0,0 +1,406 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,kaanapali-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Kaanapali Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> +
> +description:
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,kaanapali-camss
> +
> +  reg:
> +    maxItems: 16
> +
> +  reg-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: csiphy4
> +      - const: csiphy5
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe2
> +      - const: vfe_lite0
> +      - const: vfe_lite1

No test pattern generator on this part ?

We have patches in-flight to add TPG so it makes no sense to omit these 
registers from current or new submissions.

https://lore.kernel.org/linux-media/20251017-camss_tpg-v5-1-cafe3ad42163@oss.qualcomm.com/

While we're at it we should consider adding in the other key functional 
blocks.

OFE, IPE etc, there's no harm in including the registers even if the 
intention and outcome is never switching that functionality on.

> +
> +  clocks:
> +    maxItems: 34
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_nrt_axi
> +      - const: camnoc_rt_axi
> +      - const: camnoc_rt_vfe0
> +      - const: camnoc_rt_vfe1
> +      - const: camnoc_rt_vfe2
> +      - const: camnoc_rt_vfe_lite
> +      - const: cam_top_ahb
> +      - const: cam_top_fast_ahb
> +      - const: csid
> +      - const: csid_csiphy_rx
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy3
> +      - const: csiphy3_timer
> +      - const: csiphy4
> +      - const: csiphy4_timer
> +      - const: csiphy5
> +      - const: csiphy5_timer
> +      - const: gcc_hf_axi
> +      - const: vfe0
> +      - const: vfe0_fast_ahb
> +      - const: vfe1
> +      - const: vfe1_fast_ahb
> +      - const: vfe2
> +      - const: vfe2_fast_ahb
> +      - const: vfe_lite
> +      - const: vfe_lite_ahb
> +      - const: vfe_lite_cphy_rx
> +      - const: vfe_lite_csid
> +      - const: qdss_debug_xo
> +
> +  interrupts:
> +    maxItems: 16
> +
> +  interrupt-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy3
> +      - const: csiphy4
> +      - const: csiphy5
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe2
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: ahb
> +      - const: hf_mnoc
> +
> +  iommus:
> +    maxItems: 1


This can't be right.

The experience we are having with Iris for example shows that 
restricting the iommus is wrong.

For this and future bindings I'm expecting to see the full list of 
AC_VM_HLOS S2 VMID targets.

The second we try to switch on say something like the JPEG encoder this 
list and its upstream binding becomes a problem.

- S1_IFE_HLOS		@ 0x1c00
- S1_CDM_BPS_IPS_HLOS	@ 0x1820
- S1_CDM_BPS_IPS_HLOS	@ 0x18c0
- S1_CDM_BPS_IPS_HLOS	@ 0x1980
- S1_CDM_BPS_IPS_HLOS	@ 0x1800
- S1_JPEG_HLOS		@ 0x18a0
- S1_RT_CDM_HLOS	@ 0x1860
- S1_CDM_BPS_IPE_HLOS	@ 0x1840
- S1_CDM_BPS_IPE_HLOS	@ 0x1880
- S1_CRE_HLOS		@ 0x18e0

The ICP mappings can come later if ever via iommu-maps..

---
bod

