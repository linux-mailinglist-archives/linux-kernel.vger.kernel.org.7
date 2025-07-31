Return-Path: <linux-kernel+bounces-752350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7060B17479
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F8458621F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA01223DED;
	Thu, 31 Jul 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOcWYbjw"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA0156228
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977529; cv=none; b=ZbOJ+KeRyrloYj2igTUtpekbO0uJ6cgGR0rpuANmTZnQR6J58pDBEF1JDFCzni4Ab0kJe2Z5rLy1n2fSCjsqy8IgkVc+A5kLtZbwKSdWwTRtCbnkoxceAhmikqYTfMOuGNiUCibMsqk5EozJeaqy+Ev/t9lObPicSy3lirCym94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977529; c=relaxed/simple;
	bh=46dKdG+aZDW+qpAv1rqLDC/pwg2hGavXZ7hqkKz3nYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBYvxeG2m13/LcD26BriSIvaH3L6LhyaYXRzkpFL+r5I0GlWx+g+ph4oW1YLM/Se+NXWMOXC7vXPEwSncOtlXIYA0bAGo/6W8gRo+JPm6PoqyofBWLN4U/Ykn+fDmgKZy1CWWhhgO41k0WkFfepSJLLHWB106ZHkP8RFmiZ1IcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOcWYbjw; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so376965137.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753977527; x=1754582327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awhIJS7cdjgUxEct8Phfjco6UcYl0OeJVp0tQ8Q8jkM=;
        b=NOcWYbjw8sddr5gem9Za8F+fHETEneaiM7myBOErYUsyHEmHheA9LkrieQSLEJC3aP
         frbU1wvE0U1fRPCETh9hAYdFO8Xx8ePHh+/5AiMy2D0aVnv4z0dLfJRcnAfKjRUa+Au5
         qazPA2DdURR67OL7e/0m5/VSkHssEKi6Flc4cwREogWXuPUZS1G49lNW9A8sG+HgwX+e
         +yms3262iOiWJlCDv756qjKRYVjlEZk1tcOHh26rNsDbJdC2MlzekOl7qfqn6R/2BZMe
         cyw8p/tzuBEBPkS4TWx1JBS5GwGOf1MLJuDQFF8mn4GZGRq/3nCdNepiyLOcKWCknGFh
         ivZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977527; x=1754582327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awhIJS7cdjgUxEct8Phfjco6UcYl0OeJVp0tQ8Q8jkM=;
        b=AxfohsC2rWesrnideOx8oFPqWpj/vm85Xl4HGsdGeiEshDQkez5nfLgGIiV3cIYqea
         OYM+wFS3LQMKS7+5X402z/V8AOGOY3BaZlUovLTSRY0/Azv+MNmJ/yHPI7GVCvwYSz6t
         3/lAWhd5jOpjekVUOtyv1NLu9XUfNMvcgIWhsXOyEP10Pm+puIPOyXWbK/tF3HGouVEf
         ba4PtborBiFmeksa1O3O3fL1BXYz+8amqrqkC9pNa/Aul2ttGf+vxtsyDv905VhvZ8Gw
         99WvpWnMr03/oV+Eoy7u/A/iIZdIhy98kHfcHl6DFIHzdELNZ9LuC+yyB2K+lo/iLXP+
         7RDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcSmB3/SMrRBTVH/8PFMxF48AeLW1Q7tYjB9mqQEL7gotBK8zZZoM1SI4V6dUavDKEIoI4kQPfPptJLlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2KolLiMenHoKKkdS3FuqUYktZqIGg+Gl2bHESnua7gWmoNbH
	TUHRmLuMPqlpGuXaXR9o8hkuL8nbtGp5HICC/MRQ+bwqv0AznbdxjYkH6ULUAU7ljaQ=
X-Gm-Gg: ASbGncsmBHmN4GshwUp8TO5ZnJvx1OYGHXrVMlYLkA2IL1+tXIx93wTlnEoIeXM5z2a
	0qn0MdS1ONWGV/flWfm7PQa+JySlf0cm/LlYtX7ZEcSvH66BnRNIrvnxWxSEn3by+2AivOg4B3F
	nhji6akUNGoD/e2LlqsVhzj/iE2BZs+PlaV0gHO8ps3BcaAmOg97zm/jUTb9RxJQaXxUxFnk3qP
	RVqhqfGPdoFoGgV2n4FuB3Nk/n/EeN+TmQ5McdXiG9L3wbCGZZHuNtB/W0JSG0KVp1lbj+B5opO
	BXEPP4K3OrTtg6xucUJJcd8kirS5S14sl8Z7t5zVJpNFmKnqdKqs1zynutLMrUWW1CebpyBPHPU
	fcwpPZH49HUIOKnekYYNUewVHclyBh43wKOBklA==
X-Google-Smtp-Source: AGHT+IFaTZ7Nhu+be4TDEAEfweuDLzckzke57mSUiLDaG292YOCBw+NN54Llzx5T9jpZDMDjLrT77w==
X-Received: by 2002:a05:6102:b13:b0:4e6:fb90:1e21 with SMTP id ada2fe7eead31-4fbe7f1af52mr5076369137.2.1753977526996;
        Thu, 31 Jul 2025 08:58:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fc0d1c4b98sm376631137.3.2025.07.31.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:58:45 -0700 (PDT)
Date: Thu, 31 Jul 2025 18:58:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: lpddr: Remove space before newline
Message-ID: <d7f12483-4710-4c6d-bd9f-1abcdecc9b36@suswa.mountain>
References: <20250731095247.2165158-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731095247.2165158-1-colin.i.king@gmail.com>

On Thu, Jul 31, 2025 at 10:52:47AM +0100, Colin Ian King wrote:
> @@ -321,7 +321,7 @@ static int chip_ready(struct map_info *map, struct flchip *chip, int mode)
>  			/* Resume and pretend we weren't here.  */
>  			put_chip(map, chip);
>  			printk(KERN_ERR "%s: suspend operation failed."
> -					"State may be wrong \n", map->name);
> +					"State may be wrong\n", map->name);

Not related to your patch, but ideally there would be a space after
the period.

regards,
dan carpenter

>  			return -EIO;
>  		}
>  		chip->erase_suspended = 1;


