Return-Path: <linux-kernel+bounces-664763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3857AC6039
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 05:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8659F3BFF62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 03:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDD19DF7A;
	Wed, 28 May 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxwDB50Y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539271C84B2
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404064; cv=none; b=ENGjKsgvoPMqemMEgXbm7DvITX8eysi4ZOTIx+i+5/aOSKrfphvWQnLS8SE3PSOAVxPy5tQcYfmgPlIBC+dPmAP0MR1AvYt6/ud7PCSKwwSYzzHWOekvAgigNRgq0AS7IMGpbYONqxkkuwHMjTQ0jZMUfLrFm9Ryy9vXgun+mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404064; c=relaxed/simple;
	bh=0HTZFtHMrvPYujqgmjuwhl6vU5hlKIj8uruAkgobmM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw2/ev+Ia/LiBNa+MYct7unv4N6Y6nScgKzjS7UNhqjUJz2cBhChSlC8ZdrjysOhq4Eaq9LPwRAO48XjqZRIJdJ5VobclNlZ0L3VHmkWVvkqpw8wmR/3mg9P1EaLwnAT8mtYluzlecgvbQljnIfgQXGx0hO0U2FjjtT83EWPCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxwDB50Y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23211e62204so26567355ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 20:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748404062; x=1749008862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h+9g0jjRqmhF0kN4jpC6BzKtxGKIexmnwr+kN5DjlRU=;
        b=vxwDB50YWJ5P8J4Aqvo9CBsmcbDt07Tn3knKGmQxmGGCNrt+4QYwF9JNIqPCRJ9ChM
         fTKBVqsnUDtuSvWFMkaDVCeM3W4F2Dtlp0EoCM3+0IeHTys+qKkc7D96JhGMzCkIGYw4
         +A1l53odIboduFEjDOZSgRcp/7X43wrgmQrY6q+8Wmp2AQD2+7Vri+TPzietMvOy8/aE
         ek/mYLsiWRQBe5w92B4Nog9oQpYxArnTsB6UKyuGEhkYquvMEtr9ek7K3m7MmRJgmXcY
         RWecShJQr9jrB1dYcZIKC6t3fQ7ENGfJ1HPQZVgb5FjY0bqGjk3X3JZh8K00ANDJh/fM
         yC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404062; x=1749008862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9g0jjRqmhF0kN4jpC6BzKtxGKIexmnwr+kN5DjlRU=;
        b=mr6ZxH7JidiPO7lxJJa4ge5NMDJaN7kAEJKefiBfh17zDTGW0LjQetHQ94gnbQ0MVm
         HfIdM9iHr/pcs+iaUEcNUj4y/WY9nvcv8F0TWUt4vRf4109TtLagC8DR9vrEBzaW9LXs
         03IUwkk7GKEc2yDmlf9xUKeSej8pfosEYeS0FkRrBk67VKLc5o+Q+b7U8qob3ahUu37J
         TOsxosX21OwEIQegJpQ9uBcgA272aRMRNXjLw1Gm4yP3mZMxSAJ2pnQLInKZuuZEPELx
         LbuaIIeKeM2TQEY+0xzmxIA8jB5G2MmerL0j/CgWkpDkDtM873ZyyCgGOdjjOKYv+tGg
         MTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT3RBw8ZXlo5Nj4Qk0pmCe9lAXFXtwk30gU7Rp5XyKGIwO6KZcBalY4mxtOiAXHvwD8dcDvVFMTzJWUUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3qnFUtcJkcq8OMtZsxOlVcR267xzPOIzceH1xu3UjkcshQT0
	c9HwQHTVishO1GrfindV5UgNuTxCM00Tuq9Zsk7dseS+95htEjjAUF/epx7/SYFSiQ==
X-Gm-Gg: ASbGncssJCmfpSFsJtb+EJGnvcoIWw3BgMCyvCg01Qu38LN2hU0Eu2SHVL/0xm5iB33
	WMBTD9Hx3lvBht6bARl0IPYU5vmRztLGXFZ2OQUPaA+ZNNPmB0KVusUbrP5PmjJHUZjePU/ngAp
	uN+I7QxeZa/BQ4WRS3yPI4m/+aizXgArHXV/DzmB9wt5HWOBqtTskszM7Obo5mCP14PkwKh2lLQ
	kSQVfTTgL32AvbxPEFedksZuPt0GqGVIsNVtUl7nLGpmxWH7zkjbCPbxAIyD3Dn9+HuYtajEbBR
	/FvQEFYD3nObRTlzyIEmRAwq1Z8mARkF7FFPvjI5WZy7VhC1W8nwb+Bz9HSHGhSmucRsiVAKIA=
	=
X-Google-Smtp-Source: AGHT+IEUi6A5S8uES4iHZMououSHKnzCTcxXGhYKA42ZvuULMyc2nhVY5fjwE6TvUPYSQWctHRzSFQ==
X-Received: by 2002:a17:902:f686:b0:234:a44c:18d with SMTP id d9443c01a7336-234a44c034bmr78425935ad.22.1748404062477;
        Tue, 27 May 2025 20:47:42 -0700 (PDT)
Received: from thinkpad ([120.56.198.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d3590bf8sm2056925ad.129.2025.05.27.20.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:47:42 -0700 (PDT)
Date: Wed, 28 May 2025 09:17:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
Message-ID: <rvfkojyooqg7unr4i2izx4hmb24ppsx7tn65pbtfmlbrga76iu@dvsg74hlspzu>
References: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>

On Sun, May 25, 2025 at 06:04:03PM +0200, Marek Vasut wrote:
> Add the ability to enable optional slot clock into the pwrctrl driver.
> This is used to enable slot clock in split-clock topologies, where the
> PCIe host/controller supply and PCIe slot supply are not provided by
> the same clock. The PCIe host/controller clock should be described in
> the controller node as the controller clock, while the slot clock should
> be described in controller bridge/slot subnode.
> 
> Example DT snippet:
> &pcicontroller {
>     clocks = <&clk_dif 0>;             /* PCIe controller clock */
> 
>     pci@0,0 {
>         #address-cells = <3>;
>         #size-cells = <2>;
>         reg = <0x0 0x0 0x0 0x0 0x0>;
>         compatible = "pciclass,0604";
>         device_type = "pci";
>         clocks = <&clk_dif 1>;         /* PCIe slot clock */
>         vpcie3v3-supply = <&reg_3p3v>;
>         ranges;
>     };
> };
> 
> Example clock topology:
>  ____________                    ____________
> |  PCIe host |                  | PCIe slot  |
> |            |                  |            |
> |    PCIe RX<|==================|>PCIe TX    |
> |    PCIe TX<|==================|>PCIe RX    |
> |            |                  |            |
> |   PCIe CLK<|======..  ..======|>PCIe CLK   |
> '------------'      ||  ||      '------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/pwrctrl/slot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 18becc144913e..222c14056cfae 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -4,6 +4,7 @@
>   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -30,6 +31,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  {
>  	struct pci_pwrctrl_slot_data *slot;
>  	struct device *dev = &pdev->dev;
> +	struct clk *clk;
>  	int ret;
>  
>  	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
> @@ -50,6 +52,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  		goto err_regulator_free;
>  	}
>  
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		dev_err_probe(dev, ret, "Failed to enable slot clock\n");
> +		goto err_regulator_disable;
> +	}
> +
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>  				       slot);
>  	if (ret)
> -- 
> 2.47.2
> 

-- 
மணிவண்ணன் சதாசிவம்

