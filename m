Return-Path: <linux-kernel+bounces-830937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC528B9AF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1B524E29AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6286314B71;
	Wed, 24 Sep 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frDBIijd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F12E762D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733281; cv=none; b=tDYRJ2NTaDjzmfk8kVdhVkH8vilpLfuH6On2wfmkwXCGQUBRKtvsrPlnralkc0LZnxY9q6zVy5T0dXei526WH+nFkt46ZYdi2myb2qMUS1OCdai5LXtFv0bpPN0zZyB5D4yi+2L/l5hYd+LiHls0sCp4OdhSs+9DUMaZlZFaVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733281; c=relaxed/simple;
	bh=v8yS+jmMPbFJAT7+dfq+ZTzJJiT7Lh9KVUZfb/qNyWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3uXgYwYGGKw6PVExlUV5lXREy7i4xdXbRQsfdvwMgBIarQGtSSCdNfQuZkJInN0zrVsoJYzCvS5Fnb4PL7aWwqcwvfd0+a826FWACYpJO97dfUHe8b8WoDczlZZ4Y0vEVFpff65sibCIjbrCnJUPzBBzdW5r9h1vvRw4ETZGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frDBIijd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso111055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758733277; x=1759338077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb1Ytn+s2dBu+tB6z44h+rNvHohDKVN/ISjnJeqZ824=;
        b=frDBIijdKHxPLnZ1SSGjC4nlcRd6BLO3Yl3T1shJLv7lwuMMxGlPqu78LOhzkyqdDh
         6wTvlC//xAXbuZV1MBHGeDeHONmfW7VSgi+Ltc2Wjampt8cKRud6ibbMW6RGziDCjG39
         ClwlJtdCEogwMl0Z15vTMLsMVT7lKMFbs2ifT7sfV9bub0BminHsa9V/+wM/IrG0TxdG
         ZKpV4awizHB57W9X0q/Vn6fE4YA4Ndvmh4VI4S8ahfIxhlVwjOGIVR1A/oe4R4+CgGN9
         d8UnkTr9YbdHaFCK9ihuP7nycMowYsx589k0zJYoJh6dPoJwvjYTjMbpP0sVrTx3x0qg
         Q/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733277; x=1759338077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb1Ytn+s2dBu+tB6z44h+rNvHohDKVN/ISjnJeqZ824=;
        b=ipyJoMnMGb8/jZ4SPXjiIymGWTrI6gYq8L00L+G0E8WlcFe/jl6lpEpOizlAiB6NxP
         F+6Nm4p7kZvJLjz1/8qJkOdt5ku+9YQD9/VoxRP5Al54gpSlzeUi4oayeTo64YX3d4h3
         NBkLnUOERjiE3rLViWO+4DRokFbgJo7Ry3HxgTeZDacydUYXncQb/YxUxdwC4qMn6FiV
         3i0aYw8eoM4gW2+E+CqjPyAGsFQIqY+nTuHCgA6j8n8kPBXQh+df/MzeJ60O04AdrSid
         YUDyKzsoYpaWnsVZ2Dw0eW8Ss02tI0jllm1SeghUFXIHySNWZXdlDNGHV51j9ZJn/Hyg
         oZmw==
X-Forwarded-Encrypted: i=1; AJvYcCXmxjfpOMyvIdIa0Sz40Au14BBgnpaqs0T4PUFcXEbvuy04oVkHmkR+ix53UR/O08OPe3gMf94NijHVaDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygPLjNofgl3b9LaWGcVR1qaL3sZ3gy6LPrpkY4HsNc7oMU8GO
	4ncD7Gx3gRln9MaLlYnouePaXzuJ5J/CLRj7oH96O8cL67xfKK2PQzZT
X-Gm-Gg: ASbGncvEqU88uzMYMwVx6E5DNsE3/7UNvuRZLJCUhjS3dgiPsaynS3BUAqAOfRGXOEW
	fW6wtUkErChj8Mj4XzCjLfD7D+exU82lfZv2TfZwTFbF3T7YlwpGOpyVyVIx0NCD/ijrEC00Hm/
	UVCE8hg3W4QnY7ZNgNDLZvltPq81TbU7WVcmBBKYJ4GYkMO9oLnIpujFhK8l3l6UkbszBfOq9ur
	t3sdOzHMYUEQsD4vYAHZjI8yp55oWYkmdW/d+l73Xar5iHRzZVJRoIyWmTuJ7/6oNM9OaMbnej0
	6RMBRq3nHFQm5PJvPE51wo4P9do5Xh/PF/TtREJW0XOheHR6A/pBwetV9ykixA6DbTgezf6qPTl
	kDNSMxSaYOLQ55YMBvhhQHuTTxE9jk4Y+gFIK5uyb8IpX9tM+KjpStw==
X-Google-Smtp-Source: AGHT+IGuVO19RegLvgYvdtil4v4o1WifBE24BkssKL5llgP4b9PHI/slKUeCYP2I53rQ3oYbANYa4w==
X-Received: by 2002:a05:600c:1716:b0:46e:1cc6:25f7 with SMTP id 5b1f17b1804b1-46e329b4039mr4550345e9.9.1758733277071;
        Wed, 24 Sep 2025 10:01:17 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf53cesm31045345f8f.59.2025.09.24.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:01:16 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:01:13 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Jorge Marques <jorge.marques@analog.com>, 
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix big-endian FIFO transfers
Message-ID: <ikwkapgsfntog67hwi2aapdadlq2wy7oydjz6i75gbhgxxd6fc@3e3lxh7xkgy6>
References: <20250924150303.3601429-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924150303.3601429-1-arnd@kernel.org>

On Wed, Sep 24, 2025 at 05:02:53PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
> 
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
> 
> Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
> to use non-byteswapping writesl() and readsl() with a single element
> instead of the byteswapping writel()/readl() that are meant for individual
> MMIO registers.
> 
> The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> implementation, but the generic version that was recently added broke it.
> 
> Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was a recent regression, the version in 6.16 still works,
> but 6.17-rc is broken.
> ---
>  drivers/i3c/internals.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..0f8a25cb71e7 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,7 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
>  		u32 tmp = 0;
>  
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +		writesl(addr, &buf, 1);

Hi Arnd, thanks for catching this,

Indeed, writel and readl are byte-swapping and the patch introduced a
bug. At include/asm-generic/io.h:

  __raw_writel((u32 __force)__cpu_to_le32(value), addr);
  ...
  val = __le32_to_cpu((__le32 __force)__raw_readl(addr));

While the writesl/readsl use the __raw_* methods without the byte
swamping.

Can you fix, as Nuno pointed, to:

   		writesl(addr, &tmp, 1);

as in the original drivers, and adding this information to the cover for
further clarification.

Thanks,
Jorge

>  	}
>  }
>  
> @@ -55,7 +55,7 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
>  	if (nbytes & 3) {
>  		u32 tmp;
>  
> -		tmp = readl(addr);
> +		readsl(addr, &tmp, 1);
>  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>  	}
>  }
> -- 
> 2.39.5
> 

