Return-Path: <linux-kernel+bounces-832740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C30BA037A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F027B560349
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92C2F617C;
	Thu, 25 Sep 2025 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOS89OB8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD72E2DF3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812879; cv=none; b=EUpKP1t4KLQFnxArZ74yKYJqDqnkE2HYfmUx+JGpnXcAdhtRpKtMvkTKahrKbCHsk2AUtusLrV0GrFvh1D5N82HT8id5Dj3agypEIt4ddcMRv4cYT3g+bd+DpCf9VkUz61FwgWf7F2I8DFOoD3VPJFdPygNo2nrUFIJ7tgal8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812879; c=relaxed/simple;
	bh=PwfgS4qfIfkc+imXtu/sSZXrBqwExZR+rgZwO0IBYGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfayII6m+az2yIKUCTB26196ia9qnlglr0OJqWIk+z6vben3LEpVQiNPe1vUEbOw8lrjptraemGzIYOjVRMGVAb7eXUO7ylsla7/gL+xqcOjHufizfc1ZpYCAUMBJrX8drPUtngzikzA6/Wl/hJggHzLHU5Em/aIfXvzOFnashk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOS89OB8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1165858b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758812877; x=1759417677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jE5cIH8mYsDicp+BwKdnhTTJHAMEhvsJen2js1pJiH8=;
        b=NOS89OB8QhgwX7LkwleAPOmUqR7YMHjWOMKiWPH4Xrg2/5PNpKvgPqvK8fbjkBK2+R
         3ty/DNv/6qItYt0g5KH2hC7swFJa2orXFscTjT+11NqJfp4tiORGHloMCrhQOpK2TX+g
         vpTlsfvylAWX8BNr3EbMxCDma37slkMJr6APSAA/N2ud5/g8rvJdauOEe7prdR0H9it2
         NseZ89Ia3w3M/ElW9RwCAZYToE+6p6pqIUjxDkPjZiJKdzQAU8+QA5Lm+xTlPhSvp7We
         GG3+tI2YAQ8ZpL8yEFE6cJIY5RriJpIQaUD+oZH3t7wC3MfqtLbLhi6KhXyUoVOmXHqV
         SR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812877; x=1759417677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jE5cIH8mYsDicp+BwKdnhTTJHAMEhvsJen2js1pJiH8=;
        b=Sb9P8bmqIMZ5khWuAL5UgpT4nTcV05N/R/9gaYJg+67LR8kcG3LbviX25liDmP7xWx
         ukVJUDQeKmMOJGhSQIju0aIgLiR5q72LdBjR9LbExgA4XCPAfuQg+bzIZ9B8fU6pLOWT
         xHw17DxAQyRAGiLhBogXKt5BlQIylDoPWZuE86WzTiBSSQUsrQpFE7kHdemRDZ7iitRd
         f61UWyKIoBohHcIPYS/Gk77W6txJek9FWzLKQTVW4AiuamesutkWzR5/8GJ8ZwEuwq+0
         hgayzjn/G+KCalI3W9YlD6i7WKXN1jwuBRKol30RE0Bjz2ewFvcTeVPDdURmBfTKWjHd
         azow==
X-Forwarded-Encrypted: i=1; AJvYcCU8mgNw/YiyHa0XmM+iEtWEmileP2NLb27ykFZ6mRelcGK5xFkqYmDyxf2WzY/6iSfmF6VAhRla7jyZbJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10ehaSNFouljUF8hdEB9MMzHh8C4r6vX6UHmYDSPtVDxMYJss
	7lLzIThO0qWmU73rWXFyyVbDUQCuBTB6v+t3yuy1OM8CEht6TSjqtOfo
X-Gm-Gg: ASbGncsWJPjd5oo66afR7HgrnpQ20z8xL63Euf7YMyhhkDbzR6IqQug+M23wVQXTY6r
	8lvaJgpGoG6hNKMCz4rVMqCP1WzWcz5TDUYXE60w8mhfMS1aPuJTGLiGASm/aK8jwCB2BHlmy0d
	xEI/wSYNFRjBNDrOttB3Oj4HrdRUbMcRzOaNs0/nHdKWVs5FpCH3/VZ94rmXU0TxYSc0rnL9Fbq
	ZtTbNRAZ1EK9Ml1awSM+hM+DbFMn0sg4gw6PVG8WofWcfgccdstZ9ZlV+KVC8iK2ZbLIaJR4bCb
	0KzClSfPd6nSSwKsnbrCkU8PAMDzR+BtB2Q1+iBhdMbYB0yMetZ0Wl0HjDrupifAmkNYkMudv4C
	zQ4agYzNXArt8d6v46U+/GMJ+LzDPHtnCmM4=
X-Google-Smtp-Source: AGHT+IHxwbqMwtSUpRB97Nr0rknalbSvu7cUrpdQGoGrEFmAeq73TNUTzNKC1zhtc24Ag7rMTXMpnw==
X-Received: by 2002:a05:6a20:9188:b0:2e0:9b1a:6417 with SMTP id adf61e73a8af0-2e7d37fba87mr4692452637.53.1758812876869;
        Thu, 25 Sep 2025 08:07:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cb975sm2506233a12.18.2025.09.25.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:07:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 08:07:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: add MP2925 and MP2929 driver
Message-ID: <ae5ad599-e857-4124-b6a0-61196a763109@roeck-us.net>
References: <20250918080349.1154140-1-wenswang@yeah.net>
 <20250918080603.1154497-1-wenswang@yeah.net>
 <20250918080603.1154497-2-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918080603.1154497-2-wenswang@yeah.net>

On Thu, Sep 18, 2025 at 04:06:03PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR mp2925 and mp2929 controller. This driver exposes
> telemetry and limit value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

I'll have to drop this series. Reason:

> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2925.c
...
> +
> +static int mp2925_write_word_data(struct i2c_client *client, int page, int reg,
> +				  u16 word)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VIN_OV_FAULT_LIMIT:
> +	case PMBUS_VIN_OV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_WARN_LIMIT:
> +	case PMBUS_VIN_UV_FAULT_LIMIT:
> +		/*
> +		 * The PMBUS_VIN_OV_FAULT_LIMIT, PMBUS_VIN_OV_WARN_LIMIT,
> +		 * PMBUS_VIN_UV_WARN_LIMIT and PMBUS_VIN_UV_FAULT_LIMIT
> +		 * of MP2925 is linear11 format, and the exponent is a
> +		 * constant value(5'b11100)， so the exponent of word
> +		 * parameter should be converted to 5'b11100(0x1C).
> +		 */
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    mp2925_linear_exp_transfer(word, 0x1C));
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +		ret = pmbus_write_word_data(client, page, reg,
> +					    (ret & ~GENMASK(11, 0)) |
                                             ^^^

As 0-day rightfully reports, ret is not initialized here. Datasheets for both chips
are not published (actually the chips don't officially exist), so I can not figure out
the expected behavior myself. FWIW, available datasheets suggest that the bits are unused,
so if that is not correct please provide evidence that writing anything but 0 into those
bits is needed.

While at it, please also provide evidence that the chips exist in the first place
and that this is not a "let's see what he accepts" submission.

Guenter

