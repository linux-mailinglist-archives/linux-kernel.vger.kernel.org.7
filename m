Return-Path: <linux-kernel+bounces-812607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FCB53A42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B21481085
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302435AAA0;
	Thu, 11 Sep 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWnFDPBw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7F22AE45
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611282; cv=none; b=htzym7dz7KRz54rm2D6pyW8IJfUFdZ8jsEs80Ac+1MhppI5szALkhLXAYi6rxKNHUp064xJicZQeIQxI+3peWssCiXY5GIJp67arHtUwLiWfxs08H//M/hbax789keHTa6sp55VRhAzOTyJto5CzVJ1/eTflRJCu9C913thhDTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611282; c=relaxed/simple;
	bh=7rIm9WjRZd9JuaOSROjUnRkylLjDgnwq4rskGRGEbUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7CK4w5KV6ZjJ0RarkxynmSIQRYXb/gShaP90ugp/ub8XtUW0m9QCoYmK5/PWcz7B150Dq1hgRKz6YEs8lCsqUhgaXB6MDbP8yMwLRYBPj7uqcNp0IH3k7BoA/ohG/GHzhamwTzTV8wEluVl6pguhNjqdQTPiWyD8xOWp1/r9Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWnFDPBw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24c7848519bso9374965ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757611279; x=1758216079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vDDVkg+xa80N8UWuTp0DGWDueAKU9QzcFw4kQKYVzM=;
        b=ZWnFDPBwYS86eEUZhxFrYsyI38juewS3wdLQZ4qRVZ0X+qxuxukB6/HdfBi2i81H4g
         xw2/8PsL6F0jxPW+uM/PptU3djT92nrazAGI8rp+Yy32eHqbJoRnK0ezmSapEd5H79aC
         IvW+G0WLrKd/3B6wUkdrmIWsBlRGnDCJ2mX8VFdMT9s3Nsk6v2/+DEhN9udmLb3Ap7Ib
         5rxU94jUBbgrT36d6WR7+lfQHUpEBwyGFa+jX+aXzbnzueSJ+Rv5w8Kqe0+soyCHZJ5B
         D0m10vaL9pbDNEaQoNeWoJS/fOSlL/abVWylxqo6X/+DdGXldMxRF2mrgu5CDgcd8lX7
         irsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757611279; x=1758216079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vDDVkg+xa80N8UWuTp0DGWDueAKU9QzcFw4kQKYVzM=;
        b=QvgQtrHZjbYAAmLerbqc2oSjuFPIF1frmY70acWKaR3Nl2y5lT4hYVZkxMLQNBaMPr
         0kes3EoJTeXXJ9QHfuuJqfYWzZGFgHgKs8gNHemF2b6w/fvnm0B8wA2UAHUczEoE6uxi
         ViRJJ45RJvhuu2PKbkaJVGYRUcpx3aDcagrrMIT7WpozDPs4B7FRs+LV45E49h6nbjQ4
         27SEbRYaBUNT21Gj6rZe9WPf+OVTn6ZRoLHREVrpbvwTdG5bEIEPzWh5e0gXxiSBX/4e
         f1Vw7GPN8YGh1GR5Qv+XRFs0VKX/mejaaMYedwTXuT1pjPDradXNth4fUfvoIhvKxKeZ
         vYLw==
X-Forwarded-Encrypted: i=1; AJvYcCW8EdjE4reKMIdzcT9MBmY0hX0djkU6CHVzTM8qrFU6hOmhGmRgStHFhTWoeYS6YDT9GagyTS9vaKZg9D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEqP6aRXfBV4rawnDlJxguGbQOs9ugY10Vw0l7XViUla1qKaR
	CeqmX+Wwsq7YOTj13v+Z2Kuc77OWywvojA2M82yALJW8z5eMq6KQZX/5lUiWmg==
X-Gm-Gg: ASbGncsCLLdISvjkyICfKkypBb+E0NU3SzGBNDoY2jN1Q0CVvYW1R0JC2gU/2jFeqEb
	eT9xVmRwDK0NKptDqJ0/rPTsQiUMcMwXiImAvtRgLhvQh5hA6TOZ7Djj7dLZdPN87WLa7EgoW52
	F/l358LkbAOg+/iTXMQvVrGbo+lvyCv4F64aaqYDRhMLkk5I6l2wKkz0J3gRtpdENhzen5ayHna
	H/bIU+O1MEQjC6EbXhGEbpOQwOrDMDT+Q/ljXF/Tg7x93bL8yesNk//GfCr7OT2ehiIevilvw8k
	MrX66gVc0/utRABfRQg6XQIFYmZC3clA2giRBPOpQKEq8ErHqdF1BuDMEv0W5iBiMHrIv4hfPfo
	JjlhEczjOmcZqY/ME2gzfQV4+L+y4vcpGKDhGYC0VeVpUBk6AW66Klgjfz2jILYhi77aWaqE=
X-Google-Smtp-Source: AGHT+IGt11v43/OCzei9AUr8sE+gCMZP1QzI5b16NaBk0bAYGF3TuTg1wi96fzB1ckkChCMxeDmnqw==
X-Received: by 2002:a17:902:e78b:b0:24c:9a51:9a4b with SMTP id d9443c01a7336-25d25b8922cmr1844555ad.21.1757611278952;
        Thu, 11 Sep 2025 10:21:18 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53a1sm24890605ad.2.2025.09.11.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:21:18 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:21:16 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/decompress: Use designated initializers for struct
 compress_format
Message-ID: <aMMFDOdQzmnPdfmU@visitorckw-System-Product-Name>
References: <20250910232350.1308206-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910232350.1308206-2-thorsten.blum@linux.dev>

On Thu, Sep 11, 2025 at 01:23:51AM +0200, Thorsten Blum wrote:
> Switch 'compressed_formats[]' to the more modern and flexible designated
> initializers. This improves readability and allows struct fields to be
> reordered. Also use a more concise sentinel marker.
> 
> Remove the curly braces around the for loop while we're at it.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  lib/decompress.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/decompress.c b/lib/decompress.c
> index ab3fc90ffc64..7785471586c6 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -49,15 +49,15 @@ struct compress_format {
>  };
>  
>  static const struct compress_format compressed_formats[] __initconst = {
> -	{ {0x1f, 0x8b}, "gzip", gunzip },
> -	{ {0x1f, 0x9e}, "gzip", gunzip },
> -	{ {0x42, 0x5a}, "bzip2", bunzip2 },
> -	{ {0x5d, 0x00}, "lzma", unlzma },
> -	{ {0xfd, 0x37}, "xz", unxz },
> -	{ {0x89, 0x4c}, "lzo", unlzo },
> -	{ {0x02, 0x21}, "lz4", unlz4 },
> -	{ {0x28, 0xb5}, "zstd", unzstd },
> -	{ {0, 0}, NULL, NULL }
> +	{ .magic = {0x1f, 0x8b}, .name = "gzip", .decompressor = gunzip },
> +	{ .magic = {0x1f, 0x9e}, .name = "gzip", .decompressor = gunzip },
> +	{ .magic = {0x42, 0x5a}, .name = "bzip2", .decompressor = bunzip2 },
> +	{ .magic = {0x5d, 0x00}, .name = "lzma", .decompressor = unlzma },
> +	{ .magic = {0xfd, 0x37}, .name = "xz", .decompressor = unxz },
> +	{ .magic = {0x89, 0x4c}, .name = "lzo", .decompressor = unlzo },
> +	{ .magic = {0x02, 0x21}, .name = "lz4", .decompressor = unlz4 },
> +	{ .magic = {0x28, 0xb5}, .name = "zstd", .decompressor = unzstd },
> +	{ /* sentinel */ }
>  };
>  
>  decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
> @@ -73,11 +73,10 @@ decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
>  
>  	pr_debug("Compressed data magic: %#.2x %#.2x\n", inbuf[0], inbuf[1]);
>  
> -	for (cf = compressed_formats; cf->name; cf++) {
> +	for (cf = compressed_formats; cf->name; cf++)
>  		if (!memcmp(inbuf, cf->magic, 2))
>  			break;
>  
> -	}
>  	if (name)
>  		*name = cf->name;
>  	return cf->decompressor;
> -- 
> 2.51.0
> 

