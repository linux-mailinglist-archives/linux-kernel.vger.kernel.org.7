Return-Path: <linux-kernel+bounces-892819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5892EC45E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0A4EBEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844272FB978;
	Mon, 10 Nov 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgH64gcS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A72F7AAC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770039; cv=none; b=tWc/SZBjCRSAuZGGyfQxS00jku6IbirsLCjGyuDiXmiUz10D9HaPPfG/nNivKWj3Ci3/axAkRb+Ru3GRJcWRu7CWlfx5UMReQ88zmGaAZxlBGSwJLoceeL7gZnVi62Yo+kY3WFAOC6U1LkZwGHzw9IIWK4du+t9PYqILecIIEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770039; c=relaxed/simple;
	bh=NwuE0OymVSZ9Pgk9z4LwcFOxB4oAvyBUKaNACTeODX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhSbZEol7HB4uiaEdJPgqGkb0zrn5BCO5MDc8BpPWuQvLh2WJJRwz1FycaUCqbv1ggzepW01Bs1hdzbWQGYsx7kIxWf62vNT16yJOSMjr6Ik6lbTnsZrlUSQcDWzE+s0ysmd5vjHsc7VK0q44HSlwYgt6RIFdnU+fFG91oq/owg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgH64gcS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47774d3536dso11504175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770037; x=1763374837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHN6hT4IBJzArtDOwYIufgC/ZHeLt/dXS4u8pqqIeWA=;
        b=IgH64gcSLPPAGDGicIAciGdy5cZdAb613AYJ/+Ui+EHrNfsBZzxzrVD9zmNijjCbr1
         8FXLdU6R8v2Wc7VlIDGx9ZntmSdg65xKYXqenKZ3EsLGJ8Ref1UIdGwOkxNnoquxaI5d
         dSGLCxKA0PTFVB/SnlTUXvS0XNWILHQj0/y5KafOaP1lS/EAEgJnLnVr68XHvgDVTahe
         IrOauZRCF3qKXgsDUaUMMjrxlMGIFF2u0akRPRz0/LeBZju3ePgmF1Bo9hdpRo1jjtHn
         XqjbwIrchn9cYzTRLRumNwlL7/EBh+0QlZTkwja0vX+urixmuggPfWhwIEXU7xE9tQ0N
         FySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770037; x=1763374837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHN6hT4IBJzArtDOwYIufgC/ZHeLt/dXS4u8pqqIeWA=;
        b=Pz7SJBYNEFlw2e+EH4kFeQBmoj8ELOe5DWHVQak25fhLmAVBeKfIWk7i11L51X3SKE
         meXFhL5ZkXavxM8yJ4nuLmrcukii1tMuJ9a26llC9tUe6VQUnjDXdt3jczJHD04qblsz
         6Rk1J8yizyIGLKAxBdD/QqJ3nxr09jRfLmascUcA9BCT2cTPWVC2ZeHZCEpRd51GBLo2
         4U9jGeT72bjM3F5uY580GIGfW/MX2vJWFiayNO907FZrR4IoYEOn2X3jB3+fMnetgz+x
         lgjtGD8Z0o2OLlfy6AGAH3XG0F/Xxoplu7EmHZkoni+Hvg8Kz4Cz+jgDs1KnV6AJoZIH
         xnmA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3P2CCswmomgEeWEt3b9D4dol0vU1olHzSoN05fHlf1uG0bgRRrtTKZNxwV230OKvu0z/SyrrB8X8cp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIMqA7mOW6JmaCetpeB0vb5HeM2My2g7b1P9uEIsyGbXoI5en
	dfoUYkB16SBLBEDGh/mEUVn7nD7dW386cmHHQIzxBjqXijERy7Kl5Vdw
X-Gm-Gg: ASbGncs+dmGGoTsv2+akASRuSjBZpp6EFyJFYJ6OPNSVt2iFtgkGIOABMiFu73R9Gsw
	nKOI7gBO+FLIQVF41SeaVvUQdGPEz/UPZRNSCCnUUu0kKUI5fG8PGaIZV/LBlxPB/E64orabB78
	snI6Mmz0Z8einJusipKI/2C4k/bNczMPJq6oa5t537XR3aUmD3oi9wMYZYKxwwh7xZ9N/ulQ1H+
	l9ouqJT8vfBT2vRCBzX+Z09M2QjYF7w24NDLjjRy5c2foBEdXSIqR5h5MieL913bYnRb56A8B83
	JDsXfTaAQYgccOJxQryl0RqROQENvHbmFqKjTFl52OMkCkmFEUX1m7xBRUWbyhimCzkFrDLi2Br
	esreY9wjfJQX6effNtUaLfH+9UpUn+4PMrcTSs8EF2f8RN0nH0IwyQ8h0T4VNUup/Gp5HE/ORPn
	kxXydns0Fu5YNwa8O2iRSbrj5mdqg5O76olydvyHJSX/Yu6vlMz569zEDTf3IGR4h0HoBPqRXg7
	Co=
X-Google-Smtp-Source: AGHT+IFP3O2YUEuoot/+M0fJaUnySlBCmO85Z/WipYoF1i2pacbVS7QKl7uZsAR7sKgw63LPBf7HNw==
X-Received: by 2002:a05:600c:3b01:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-47772deb36bmr71489405e9.11.1762770036422;
        Mon, 10 Nov 2025 02:20:36 -0800 (PST)
Received: from u67f9ca6e60d851.ant.amazon.com (54-240-197-232.amazon.com. [54.240.197.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm24159885f8f.44.2025.11.10.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:20:35 -0800 (PST)
Date: Mon, 10 Nov 2025 11:20:33 +0100
From: Praveen Kumar <kpraveen.lkml@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 2/3] dmaengine: Use device_match_of_node() helper
Message-ID: <aRG8cVly3b7sR9Vw@u67f9ca6e60d851.ant.amazon.com>
References: <20251110085349.3414507-1-andriy.shevchenko@linux.intel.com>
 <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110085349.3414507-3-andriy.shevchenko@linux.intel.com>

On Mon, Nov 10, 2025 at 09:47:44AM +0100, Andy Shevchenko wrote:
> Instead of open coding, use device_match_of_node() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index eb27a72cd4c5..e89280587d5d 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -765,7 +765,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  	mutex_lock(&dma_list_mutex);
>  	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
>  		/* Finds a DMA controller with matching device node */
> -		if (np && device->dev->of_node && np != device->dev->of_node)
> +		if (np && !device_match_of_node(device->dev, np))

I see a difference in what device_match_of_node does vs what was
happening in the previous check. And, we have an unwanted double
check of np.

int device_match_of_node(struct device *dev, const void *np)
{
        return np && dev->of_node == np;
}

Instead, I would recommend,

        if (device->dev->of_node && !device_match_of_node(device->dev, np))
                continue;

Regards,
Praveen Kumar.

>  			continue;
>  
>  		chan = find_candidate(device, mask, fn, fn_param);
> -- 
> 2.50.1
> 

