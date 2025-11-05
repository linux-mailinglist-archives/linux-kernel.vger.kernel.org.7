Return-Path: <linux-kernel+bounces-886808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CBC36915
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B91A24CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46A3314CD;
	Wed,  5 Nov 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGJdaz1Z"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2B2686A0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357443; cv=none; b=b3Z5KIXRn4QXsTLrDrXkW5+F2nCmwGbGjz1x5I6Wt4bKtgDCtQTPFaxrQsNesq65wUaYgHdqBfrYvcmVS0zmgWa1yb3Dcz4dC+Zhy7Dij10Zykh4BiweBt/ZCJf/XCp5MN7Yr3aQrBaPm+WzJc/TVt0gx+PPQXlh1qlXdOXBA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357443; c=relaxed/simple;
	bh=sCTIQJdNjjajAv8x/JfOJ97BJ2l4jqRvj4Dollk9KWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxoX6yhUx5YXrysVVsnb/kURAwgkujJYuk6FOdtaqfNB44rqhXdGGRqhdTf33KXPp4gC9p2zXK+H5dDBec6WR4hgsEVlX94qhNEF61oZgyFhFJL4F96gRshShtN8ZgtnobaJQszcRB1Zg/BacwbfZ47WCfi/TVaJysHGaPeVeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGJdaz1Z; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b4f323cf89bso482112466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762357439; x=1762962239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSVtmYaRorpLg3ihHdyCGNJLkC8P7NNl8FUvIMwjsNY=;
        b=zGJdaz1Zg9tc+ro2vdqsNCQWmgo/lkindTPd4ZPGMQDcBqCS2VyQik98ntMyGQMaEl
         jIRpBZZjib9N1IQKHb3f0dtBidc8eYQoMzcKFPOGpvQujsFdOgCExQqk5aGQe6cP5BvO
         L4jLDVmrbdg1LpG2zAlhvHBirXCNUMK1vWOyZLtCGSy7EyBhePFvu2JyBLCT9kFYFkfp
         v0XZ1lCLBfDPxttB9jLevnwrn9Qr4b63RQixJEt6GWU69IEyT5nPrP440GFXhKO7tiHJ
         1vQTC+3O/SfCwqeBIYVUeSFc+men3Z7Kvuqm9qAAH9aymChbLsnGVwrbo4G2Xg6GcKnH
         oWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357439; x=1762962239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSVtmYaRorpLg3ihHdyCGNJLkC8P7NNl8FUvIMwjsNY=;
        b=O9U8HOfDIbhh9GI9yZ2kalnNYCyPorid0689S0xgbyP68wfDp/M7SWHjhVs0D2RiI+
         9QX9C+oBkMfEqtHdUdDrTBAQOSAlcyrph7dVdyZ0QzDLcny740K2mx4coGyMQyclqPI9
         FMTQ3bQ3a+kVAGJxgaGx1bdAnWvBJhhU+naNkM7y44ycrdP5ATayUmpboXaKl1y5pe1e
         rBsV/AT0xU+RjUOO8IdNvl8TFGvu3OXCZol9UTOOpQQFSQ3AgCHVo080JLmDnZJ8FYMm
         d2kPkjJO/UULwEajuEkNhOS3dvQ6HQvjVvyVA8lz4VVcKAyjvDm0hlA4mYy8jxMv0QwD
         T/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxGDt+1H2QuoUvgYjeICV00qo/1Wn4+niVvNp2xfQiEVDHtXmyyr/xYh7uLVW+AlP4n+55nsqR3WmXaXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeoalg3mHFYX5O8sa8ZZI8++J9wSw/qqVPi5WHVCirqaR1ztKB
	oUtMJtl1obnaiKJtQQmtu5I9okTWHAI2JAX3jxY/0MziTXXcCJo2MZf5EwLubJzd+5c=
X-Gm-Gg: ASbGncu9hO5601xuL9RZHytbiVS+yajvzOcOLALgS5sACJLuRbtmsRLEPJCPYx7xK6w
	PJcMhhhLQpWMYUJ+4wxmOr6OPRh9xPyJxWsCBoEXLqSDEYvjxHqFXHK6U5Ho46LC4rRq2azInQk
	ED29L86Hk3B7OnIloQJN1xa8SxmOkn6glUy7CVmaP+ZlPnqrDlfbL4NvxN+unnNZDDSPcOlpacX
	ajmEcHXlYsXGQKoowGXHgv2C7w8QwwBHn32Yla9QsuyiaMle6rUZUIPcYFIMLtiL35psN6l3WJ2
	pWC8VZcyF0SbTJaUGAHDSpbDMri/kOvkEDVqI7PYDfkxvHcA+UeRlkoubMFJdtJu4p/rO6OyPFO
	UohzAbYX2QmtA25+iTAk1BHQlGydL0yoYh0QT8Fdgun6x/1S47MY3uAunqshYTciPUc/Fytp4Uy
	ZB6t83kiMc+ude0C+LRfNS4oU=
X-Google-Smtp-Source: AGHT+IFa7/X97763xpJ1l9X3Sq82I4dFTfY6YWJOkY+3Eh/I0wcCHNCHX/dwcVa4BdzknLf2omKPmA==
X-Received: by 2002:a17:907:2da5:b0:b42:f820:b7c with SMTP id a640c23a62f3a-b7265586f9cmr328010166b.41.1762357439537;
        Wed, 05 Nov 2025 07:43:59 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f8c5bsm514160166b.20.2025.11.05.07.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:43:59 -0800 (PST)
Message-ID: <0be97b27-4f8b-4d22-a653-154e87ecbc78@linaro.org>
Date: Wed, 5 Nov 2025 16:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/28] spi: spi-mem: Create a repeated address operation
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-2-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> In octal DTR mode, while the command opcode is *always* repeated,

this info is wrong: opcode can be repeated, inverted or a dedicated 16bit,
so please fix this to not mislead readers

> addresses may either be long enough to cover at least two bytes (in
> which case the existing macro works), or otherwise for single byte
> addresses, the byte must also be duplicated and sent twice: on each
> front of the clock. Create a macro for this common case.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/spi/spi-mem.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 81c9c7e793b6ab894675e0198d412d84b8525c2e..e4db0924898ce5b17d2b6d4269495bb968db2871 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -43,6 +43,14 @@
>  		.dtr = true,					\
>  	}
>  
> +#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\

I find the name too generic. This is an macro for 1 byte addresses, right?

> +	{							\
> +		.nbytes = 2,					\
> +		.val = __val | __val << 8,			\
> +		.buswidth = __buswidth,				\
> +		.dtr = true,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_ADDR	{ }
>  
>  #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
> 

