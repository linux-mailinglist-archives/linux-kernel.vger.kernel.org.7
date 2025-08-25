Return-Path: <linux-kernel+bounces-784192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C92B337D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215CC1770CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23125296BA0;
	Mon, 25 Aug 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkflcGIJ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A2293C4E;
	Mon, 25 Aug 2025 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107305; cv=none; b=YAGg90CuYBejNVK9cZPtvhh1C6GIK8n+I0R/ZMvpPJ2wVjivZT1f8B9UiMJns5pidTEFqAsJfQi2S/EiBGhSqIzIuO59ZBB/4wvBzRFebYaQO1D2sn57qKB2QMFWD2edRow8f3/fnyvOo820yLwpwCtPA/3UMw8Zpa3BpYTKLdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107305; c=relaxed/simple;
	bh=8n8s0vL0czwCbBZJyb4R3SyME9JrMHVOESs2i7aHrl4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWpEF1VGlS9+V83dMEG0jgWF07evKLRdzFi15QLQH3IsrszoYCLlkckqw+cl7/idUyUMlaoFkI1cLtnbAiH9WcZ+UdOXt4pCvUxvu3NtVv6WxBBDyZPillhBUh3FqdUiaY3eky7jGGYrgiFNKHUjGar1IvMROFjGu/7DijcCGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkflcGIJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so1206562a12.0;
        Mon, 25 Aug 2025 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756107303; x=1756712103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvp5MBsT7YhMVkgGMIsz2MCxt+BzXm3dU8zTzzspkLs=;
        b=kkflcGIJ+cc5E0OOlI/iNYe6horzrNxxwhvxCmfT0TZGV9/ZxlJuZbJ05Gh1AdB8wP
         4NiQ7oKLzUFdTsGbfnBL+Zd8mJAqKzZX2QJ8Q4EkYJJRdADUrP8PPv01ELYy3G78enEt
         TGcMQoDSCqoNxzy22My0u8Fxw7KJgVtCq831jxObhePMYuAx2y9uCQkOQ969ICNs6E/d
         +5JT4zhMev44E1yBd2AgmFH5XucGkTb8/4tAVYRm1kbZJdey/lsWhFNL44ncDK0CThLp
         gOckbpI20merESoD5rS3LBQc/5aZpvimRekX8debwTCcZ2shRqhpvVmKFqVeT7jQz/L5
         oBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756107303; x=1756712103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvp5MBsT7YhMVkgGMIsz2MCxt+BzXm3dU8zTzzspkLs=;
        b=xJhvDnH91C+4AKNqkGD+veQWvQkruCZ7UBZ98Pai4C0eMaGB/vpmH67y2jFNlJAPbB
         Ay/Tv3bxWbqsQi0jBrwFLBXBSP2Hbe7Vn433ajO1x7jyAu0WDRI+l2eEh8bxMcpAuHyq
         MCBcn6RQxyBOtl3NVblUKrQDQVsfAzfVtIt4j2yfKHy6al6QKEjniGshE6z+S74plg/M
         Xtvvi+JoA3PHD1pylU9MnamMUKHL1irbIJjmAhw8y9+SkifVe9uaTaAmKrFp8Ic9Zxl7
         ry0eSSGj2oPas4ujOk4CRAlRmIDPeCLhWrySW6BngFRteCskeySqeeGtQDExwg+wjr+s
         jJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQwPTld5h2jbqEX5fnUOu9SgB+vsMBoL1XdW34PkFJiRG29869WCXk8USKhzDKncTt1O2QKxQUiPPLRHTz@vger.kernel.org, AJvYcCXhxDeibSI4bMqFU0ENBBfskc4NfrcaJG3VY8G6W9nBC9F5DN7UNvip9BeQafahVE7Tq+nLh+TjhAzw@vger.kernel.org
X-Gm-Message-State: AOJu0YxseaDCtz238Z+Tsrwir19H5y9GUiad8RImybqSQpAxU5mPoZSO
	imPVUTnfWVV2ZFJyIG4hoW2CZFEYbt8kTRuon/ZW2XWjrp1ZwV0WGscV
X-Gm-Gg: ASbGncutNTPilHJLxKuYe4etWEMMIfkHkLmA5lpnxiDojZkT1gaw0jgOkHyNp6dHND0
	tXl8SiWhvbDSHpRDTg3nVDE4MCpx3fRCRblR9qeTdDP4Mp2jFKN5sVCq+cKGiefYHiTxG4DRWmY
	0V8fJLYpO2IX9jfGmbrkbQKdPrC4vvLQGTsAnmx7eSyB/Ct8DXk9u21jl7spwyhzgl5uLCEIMSY
	uVos5dBpt1UkCfAXp/HzseGPauAZdzttpVN3nM/m8RvFpeEF396OxzU+jOvD/Q4zSiwzqtiK+NE
	Jc4jdYUHiJcl9WAP/Nk2Acu8P5Oh1sbnXIAyGDxppEDRlL97LOSMHRa8ya2HqdehCfubaZqDGP7
	lJFN/csLilRTf9kE2jVN35Q==
X-Google-Smtp-Source: AGHT+IEsuMQF9X71mGIcNScDFx9goLQ7xmHtthjhYeAIT6/QFur1P7fK5isGOF+ZbDuvxs+fIRAQtw==
X-Received: by 2002:a17:903:238e:b0:240:50ef:2f00 with SMTP id d9443c01a7336-2462eea80fbmr175765105ad.26.1756107303209;
        Mon, 25 Aug 2025 00:35:03 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24668880368sm59546745ad.109.2025.08.25.00.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:35:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:33:57 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	inochiama@gmail.com, krzk+dt@kernel.org, looong.bin@gmail.com, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, robh@kernel.org, tglx@linutronix.de, sycamoremoon376@gmail.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev
Subject: Re: [PATCH 1/4] irqchip/sg2042-msi: Improve the logic of obtaining
 msi-ranges parameters
Message-ID: <n7na4pl6xfhwdk3xq3ulwrxm5d32kdub44otuk7avwjgb32sjz@erqbkyzhohqv>
References: <cover.1756103516.git.unicorn_wang@outlook.com>
 <adb383f0f4a3cb588448a5a708fb7a907d5e9403.1756103516.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb383f0f4a3cb588448a5a708fb7a907d5e9403.1756103516.git.unicorn_wang@outlook.com>

On Mon, Aug 25, 2025 at 02:55:03PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Get the arguments of msi-ranges by specifying nargs directly instead of
> using nargs_prop. This only takes one step, unlike the previous two
> steps to get the values of all the arguments.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/irqchip/irq-sg2042-msi.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
> index 3b13dbbfdb51..5249afd93b4a 100644
> --- a/drivers/irqchip/irq-sg2042-msi.c
> +++ b/drivers/irqchip/irq-sg2042-msi.c
> @@ -276,17 +276,9 @@ static int sg2042_msi_probe(struct platform_device *pdev)
>  	data->doorbell_addr = res->start;
>  

>  	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
> -						 "#interrupt-cells", 0, 0, &args);
> +						 NULL, 3, 0, &args);

Why using a fixed range here? I see no improvement. I think using #interrupt-cells
is just OK.

Regards,
Inochi

>  	if (ret) {
> -		dev_err(dev, "Unable to parse MSI vec base\n");
> -		return ret;
> -	}
> -	fwnode_handle_put(args.fwnode);
> -
> -	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges", NULL,
> -						 args.nargs + 1, 0, &args);
> -	if (ret) {
> -		dev_err(dev, "Unable to parse MSI vec number\n");
> +		dev_err(dev, "Unable to parse MSI Ranges\n");
>  		return ret;
>  	}
>  
> @@ -298,7 +290,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
>  	}
>  
>  	data->irq_first = (u32)args.args[0];
> -	data->num_irqs = (u32)args.args[args.nargs - 1];
> +	data->num_irqs = (u32)args.args[2];
>  
>  	mutex_init(&data->msi_map_lock);
>  
> -- 
> 2.34.1
> 

