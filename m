Return-Path: <linux-kernel+bounces-849160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700ABCF505
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01AF94E5F32
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D327605C;
	Sat, 11 Oct 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7rB2hXL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAC26E714
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184969; cv=none; b=eb2XBHTTGi+/OvYDT58u4yAFZMgp2NcXWR1ccNrF83v/KHw4EWVY+S4IOY8yIyWZ0rEyS6xPMffbzZs3xM5XWSQombSWZ1loO15PEJwX2b/Y5UcrfIMXJI93PXeVOj6Uh2sQKH6S6jVvuk6XnBNqpZAXkaYpOaq5GQ+wa+9oVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184969; c=relaxed/simple;
	bh=K9ZlGYLFyygWWlQdxL4k3DB105kYgCqHlL4sa73rs4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBpPPHIE4qOPtLChQ9alKEHYIxeCQj7Yw2CCBfMQWYSgsV3LtaWdnNfhyY1lz3qmKJDZF31XHjzeu+OBgrKXxVdsFwrauJUx7riUksQLHNzXNUTpZrx/IPPXI2RQCvilFBfAYRpF0d0618M9mDSVJrAJcrVyj7chQW07/wtVLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7rB2hXL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso26619455e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760184962; x=1760789762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESeZUlMWivezlE3DeTyuSwyLVdykZbSbBsQ6LPdbgI0=;
        b=I7rB2hXLuU7CFe5+R8xQOXQpkumabMvRefO44qtV6FQsT+CmXsB4eLOyk6byWrIgAf
         bTYVAcNGD+XOxMM21qOx636SJbXhOslgtnULK68DD0S5yzBuMEQJPnPCwPOAvuonPQxs
         c0wMi+8z/vEld8iqDblKV/6c0S03YIS0YTJTNsq2V0H4MZwagRoMI3deYeaDhrp1cllO
         Twbg5NTyQpVx13D19ZzgfeWd4Z4pDHkRlAKlL28/LH7xse/JPnyQ46z1ZC9AptBGJCxZ
         QHx/i+4wSTeHDE8tU86hen6x3tmzm3vYa58jl4/NXg9YXDoDDIgY4d5nZTuR8ao5Wvi5
         7oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760184962; x=1760789762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESeZUlMWivezlE3DeTyuSwyLVdykZbSbBsQ6LPdbgI0=;
        b=q1epuv6CLFk9Pf14RJSqtIbYxkk8m1ZHZjPcQAYxnCfR1wZkjAmz18ctL4rwCau15p
         a7osHAwSij2q1Ly3NXb4dyhuBHvjpA2BUzGDWMu9cU84cggTWxZCUP3rJVcvr3q3L8Eg
         aF6zOKPFcidcLc5Pwadso31T6LTqI6yKbPagZi/jmaUp3bcjTYT/IOX5aGt4R+UIu/DO
         uFVPot0uov8rN0E1kQOrRk+mlHOKkMf82yRwNA3tuIFId4zKCkwnRHHj64DNz6CordW3
         nWcDElfUaObeaZeGXcRcc6SkmYv9tHnu+vBtM025RFP8xnYhSVwcJM/riUm1YE4/kkvl
         a35Q==
X-Forwarded-Encrypted: i=1; AJvYcCUywZz2yOubnkTvFLVxPhFgmsNwqd/FDSLjz4pgD79wb/pG1KUSLUg/H3mJ+PGZwFkEIofQTPwKKNACpb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXtLMxms1CGPrEf1CLpM93UXXSvz3Zc7q0chkJ9Cc7/f5SIDL
	XYzlUXswuWZMNaxVKUoPJWGgKftbuqRkGayRLUmYkyzdq8wQb6+pntfyYeTsHEtdGvU=
X-Gm-Gg: ASbGncs/74vyc2Xz8hcsIfeTQFF54zVrccyQovxr3hj1tABaTn6fEnRYIO0/EvngvuE
	/cDhqRVpGFd+0HKiGZMTZENsndDF8pHwIVfItqaTuaw4ER1EpAdnMrezt4ATRd2SMHr5KzxpYkC
	5Bd5pgS0117EDNeejZT71uRvMGZ4lQxqx9ErlCq+E9mIjRj5o4Qk/mcCLCBv+2TDUu6GqP5a9aK
	CfJZoq7NyisJuE1R5EGS1SuufoveDXYj4AroIRdT/Z6++t4AtzL+jBCSlzXG6qEnSwoh01GhdAA
	KcCfm3YDS2DOg7onksTb5n2iMZmYv4DVCP718hWo8IdK8qIqWce7wflKCHW6FgGJa8iJm0d4kOx
	7HTti5HGiF/pschWOScYSFsH0bPcoKvHtXpCU+R7xFQMD+ARW8mV6
X-Google-Smtp-Source: AGHT+IF0eKdBuninlOSWd/RRES96gVi6uKKSkT94wSVAQclPilU8XlMKpntgxCzH3mwQj1GRHiXV8Q==
X-Received: by 2002:a05:600c:4ec8:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-46fa9b08d79mr103124925e9.32.1760184962016;
        Sat, 11 Oct 2025 05:16:02 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm93739915e9.3.2025.10.11.05.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:15:58 -0700 (PDT)
Date: Sat, 11 Oct 2025 15:15:56 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, 
	Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>

On 25-09-03 23:22:03, Wenbin Yao wrote:
> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> 
> On the Qualcomm Glymur platform the PCIe host is compatible with the DWC
> controller present on the X1E80100 platform. So document the PCIe
> controllers found on Glymur and use the X1E80100 compatible string as a
> fallback in the schema.
> 
> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index 257068a1826492a7071600d03ca0c99babb75bd9..8600f2c74cb81bcb924fa2035d992c3bd147db31 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -16,7 +16,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,pcie-x1e80100
> +    oneOf:
> +      - const: qcom,pcie-x1e80100
> +      - items:
> +          - enum:
> +              - qcom,glymur-pcie
> +          - const: qcom,pcie-x1e80100
>  

The cnoc_sf_axi clock is not found on Glymur, at least according to this:

https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/

And dtbs_check reports the following:

arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
        from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#

One more thing:

arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
        from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#

max-link-speed = <5> isn't yet supported and of_pci_get_max_link_speed returns -EINVAL and sets pci->max_link_speed to that
without checking the error.

So I guess fun stuff is happening based on that later on ...

