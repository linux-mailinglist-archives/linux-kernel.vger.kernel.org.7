Return-Path: <linux-kernel+bounces-852153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BFBD84C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0192C19218D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338B2DF71C;
	Tue, 14 Oct 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgaO6zD7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769322DCF65
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432084; cv=none; b=qM5AudUyM9zJFd++uXGNHnVwDSIktc7geo2O1F8Y4hPKizllDWC/Tm+F8TCJPEyEyqnC/6HheLpWiGshvycpb3hQFeGA2gQ4rlP2Z/S93bFwUd13QRzaMAqRpbqtmOB98oC29XSS7SD6vcoXkraM7XCga1rvNEXkGTeqsH8kzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432084; c=relaxed/simple;
	bh=7x1ksEGRUIlN/JRIZWql+/rRJiRrxtl9r0MDlxoj8Co=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dYPEEVBmbYctDjqM22amnyY9yffuLNq9EIFv+I182/kzw2Oy3Ny2kfNa179djqKA5wnHlpVuj20eGy1pVk8/r8ef3p9qdolXcmHZhQj8WvqNvExhw41brUDXMWyqWodflTMGBGnfUJ0rgIEabZ+wpBN9op8VQR/3YryDPx/E8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgaO6zD7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4041268b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432082; x=1761036882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISi9f6KzQSpnphkygLBuAPANu77cvnhCFWLhBPhHgsY=;
        b=RgaO6zD7JIq0U1oTpkDVKzmcZUfv7rs1fKBnpjk22jmaEJeOhOopafaZAqyFnmyEhH
         AGRlxGAZ8oyhvit0nMn7qf4QrELfs4w6o3YMAIQYf5et4EmHgEJsDuJjZPk9vHVkR8Qq
         tDN4faYddijCXim041/EKruc2EiJuki368SkZLekMxUYssjkvzpt27/+xV07/CL4uk7J
         WpEILnCEl6K5rvoc+py9mTY2zYnWpddaSWY7n5/ge29ZQ+IMqVwNNYQnMzn4MWvIn96u
         ywCsstlWGSYIlKdYoEAWqPebmtROZ9qYtKHsPwDynY+c6XMIw411qIDc982ytjKffXQo
         hbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432082; x=1761036882;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISi9f6KzQSpnphkygLBuAPANu77cvnhCFWLhBPhHgsY=;
        b=CxHhBCpmg7URi0hCcWE4k5uo+vpqm0QIE36Fg3BFiOV4Uh3VyjMZW+328r/wpP5p4J
         FW6GVK0bLoAEMEf6+FTLoBTybI7mnsUUuE2MK+NPQzOtvlDBe0V7Uc/2i7QQcLjU49hU
         Jba7EDshRtJNxIEIqcuQVSeaTJb5TINrOaFjQtKBBysWLyVbPxgSsHkNL9SmbzQ8Ugsc
         kgz345EG8hxIWNcS9hY62qjGvQhmK6A7vFpHaxvNK4Tjfrg4eEMfiKvGHdDYPyIzqT5R
         pJIeqxMwQEpCOP1K2xHQDqBbVBV//5JFItD4bBhx3O4BSL1fiPQawYTS5k2slbWP2QL9
         rBeg==
X-Forwarded-Encrypted: i=1; AJvYcCVo9DkVRwAw/xlQMDtjDagMc2KAqzwcaYnp2jh9nukrG9xJ32y3wAhXTYbQ12ZoUqx5ZF+KZCGU4lDh0mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHPvVK3KpakLwazhH2X+zUMJe30OwZ2yqz0f29mFEwjqsdBIA
	PVuJtuUYiNZ5tYqU+ovY5cPa93UtP+vilDoyY4QZjbTYd1CKyrOWSDQC
X-Gm-Gg: ASbGncuK24jyk+Tfhef9FgNc6v023pHDpQyofe2WrF1Pu40pAmHMpI61YekBfL0M78M
	TXFHlVD26vCgvbC5faqUviJG/vfduW38by+CSxd8J55R5KTODYN6EnFzRoLMj12FNBShidLQh/G
	ClddJVAtQPmwP+OWU5Y18QJhpJxCp+ANgIlDZnfYGTv+2ui0x8iqmv/Cqu2dvvVm072YO5aiv3M
	eG1JFirSoIj8sr8TdT1G1okaJpZ1pT0JFLsiLwlM0FGAaKjosATglVf0XiYbQpPlTUN88e1ustT
	sfvQNJW2QkF7kJMhcyWX+NyZqey3AsWWWr4Pua+KBOi3fStYY7nuGZyvL/+XydFvVndOdUJgC/7
	23RAU/z0veSpxGbaRi9M2k2imYLN8ibl78gpJSQFvLRq6G/L9a00Fbw==
X-Google-Smtp-Source: AGHT+IGqTpN25zTj2NoGAGnl9jeNvvTw7CBNIuJy1oxy3KZR2C7Ji/G8drrYLcEK31MzNn+ZS3y/Fg==
X-Received: by 2002:a05:6a00:4fd3:b0:776:12ea:c737 with SMTP id d2e1a72fcca58-79387e05323mr21822249b3a.23.1760432081535;
        Tue, 14 Oct 2025 01:54:41 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b060b66sm14499599b3a.8.2025.10.14.01.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:54:41 -0700 (PDT)
Message-ID: <8226884b-96f9-483e-bcee-466ff3e04b23@gmail.com>
Date: Tue, 14 Oct 2025 01:53:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bo Gan <ganboing@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: ethernet: eswin: Document for EIC7700
 SoC
To: weishangjuan@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
 anthony.l.nguyen@intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jan.petrous@oss.nxp.com, jszhang@kernel.org, inochiama@gmail.com,
 0x1207@gmail.com, boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918085903.3228-1-weishangjuan@eswincomputing.com>
Content-Language: en-US
In-Reply-To: <20250918085903.3228-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 01:59, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting clock
> configuration, delay adjustment and speed adaptive functions.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/net/eswin,eic7700-eth.yaml       | 127 ++++++++++++++++++
>   1 file changed, 127 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> new file mode 100644
> index 000000000000..57d6d0efc126
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/eswin,eic7700-eth.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/eswin,eic7700-eth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SOC Eth Controller
> +
> +maintainers:
> +  - Shuang Liang <liangshuang@eswincomputing.com>
> +  - Zhi Li <lizhi2@eswincomputing.com>
> +  - Shangjuan Wei <weishangjuan@eswincomputing.com>
> +
> +description:
> +  Platform glue layer implementation for STMMAC Ethernet driver.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - eswin,eic7700-qos-eth
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: eswin,eic7700-qos-eth
> +      - const: snps,dwmac-5.20
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: macirq
> +
> +  clocks:
> +    items:
> +      - description: AXI clock
> +      - description: Configuration clock
> +      - description: GMAC main clock
> +      - description: Tx clock
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: cfg
> +      - const: stmmaceth
> +      - const: tx
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: stmmaceth
> +
> +  rx-internal-delay-ps:
> +    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +
> +  tx-internal-delay-ps:
> +    enum: [0, 200, 600, 1200, 1600, 1800, 2000, 2200, 2400]
> +
> +  eswin,hsp-sp-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - description: Phandle to HSP(High-Speed Peripheral) device
> +      - description: Offset of phy control register for internal
> +                     or external clock selection
> +      - description: Offset of AXI clock controller Low-Power request
> +                     register
> +      - description: Offset of register controlling TX/RX clock delay
> +    description: |
> +      High-Speed Peripheral device needed to configure clock selection,
> +      clock low-power mode and clock delay.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phy-mode
> +  - resets
> +  - reset-names
> +  - rx-internal-delay-ps
> +  - tx-internal-delay-ps
> +  - eswin,hsp-sp-csr
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
> +        reg = <0x50400000 0x10000>;
> +        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> +                <&d0_clock 193>;
> +        clock-names = "axi", "cfg", "stmmaceth", "tx";
> +        interrupt-parent = <&plic>;
> +        interrupts = <61>;
> +        interrupt-names = "macirq";
> +        phy-mode = "rgmii-id";
> +        phy-handle = <&phy0>;
> +        resets = <&reset 95>;
> +        reset-names = "stmmaceth";
> +        rx-internal-delay-ps = <200>;
> +        tx-internal-delay-ps = <200>;
> +        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
> +        snps,axi-config = <&stmmac_axi_setup>;
> +        snps,aal;
> +        snps,fixed-burst;
> +        snps,tso;
> +        stmmac_axi_setup: stmmac-axi-config {
> +            snps,blen = <0 0 0 0 16 8 4>;
> +            snps,rd_osr_lmt = <2>;
> +            snps,wr_osr_lmt = <2>;
> +        };
> +    };
> \ No newline at end of file
> --
> 2.17.1
> 

Hi ShangJuan,

I'm active user of HiFive p550. I'd like to test out this driver. Do you have
the device tree section of phy0 for Hifive p550 board? Or it's optional for
p550 board and I can just provide an empty &phy0 node? Regarding hsp_sp_csr
node, I should be able to use
https://github.com/sifiveinc/riscv-linux/blob/b4a753400e624a0eba3ec475fba2866dd7efb767/arch/riscv/boot/dts/eswin/eic7700.dtsi#L167
correct?

Bo

