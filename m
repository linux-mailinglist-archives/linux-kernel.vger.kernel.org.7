Return-Path: <linux-kernel+bounces-896810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02099C51486
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0B83BA836
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E142FD7D8;
	Wed, 12 Nov 2025 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzQ10Xgw"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F12FD7A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938122; cv=none; b=YgC5Ppih9A45g3nsMy0h6wecq17jvvI4ks5jq/4l/z0WE3qgGSX6kz9CHUwRQ8xNYHyf44N7nRiryW3h0W2iAlWjSPMHsSSUQoxAHMWiqZvZyQA8UZeUdUNY/ZnjwmBR9CM3/tYh74038pB/uszEB2nIcBb2XE4HVEywCMGvff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938122; c=relaxed/simple;
	bh=5zFi3prT/tb4/ZOKQXyzm6NJkVjt+9gP5ezapBHafdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juU7GUcjYJE1vWORon32bvaExW/9348xyN0W0RKHpXG6HOOdHLRW8kfBfYw9OXpgkNp/wUCAR4wo8IFkDotTpjYxRQO2zPpSFzS9sV++NzoZt2qV6EJIfp6/FqLfNavAumBBUGIxZxz8SpOOKcPtb+vStqPBMNlWNL37V9droPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hzQ10Xgw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632d9326so3617045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762938115; x=1763542915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66JkoVBXRt3KXq4mIKfXgWIsRIseUDoE8lmCrVzLyy4=;
        b=hzQ10Xgw52eC8WkD3lapBPNn1UIDBCd62s596/euBcNJFUkNCyH6ezkAclNJZRAU4w
         0a6i5TOVuwa76CnEa4NBru8WepjhYui3aMTADDPqV5VzxAjqjNuF1acpI9w+gJFGSiko
         35qLmYrLBmQhqOtY6f6A6dHeIUh2m62rCLYWEWAXSEriTH2jj9UZlQOHfM5doRid0e7g
         wil/pAa5mkD7J5/HR5oEagK6CAE4tVYtWb5+C1otjx1oHT9SQCP+LhHkc6fWq/c9pTio
         biJTuc6h7GQp3mnTPLMTCwkzx0K0Zsa3KM8P1alISsC8c8w/hjIzHsOfnhXt/yl693J9
         SK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762938115; x=1763542915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66JkoVBXRt3KXq4mIKfXgWIsRIseUDoE8lmCrVzLyy4=;
        b=Q5v5TOmIILLNI82rKqyWz+QhDmsAwjbKMhr4IUy90q9qbb5+3uOMEdKQWul+8tmBag
         bHeoDkCDkwD/54fdEiap1u73dpa9CqZGvRp5y3VLfld/jzmqCYLikhwnrlMifjCmqiiz
         p33nlM5n+CYNggF93tAXiYZ1LXSRHnSeb1bzl/0GQOaGydy23Bqjz/yquOJiSC0Tbgax
         vuSqNWeW0P82z65pC7/hlkIjz86XLlDKgriQFpzjcU14SbwtSFg3erS0aagcTPbZ8N/+
         U//Vt+cFX49i7leONXXIk83L5nMSTYgtPFjyM/WDwxpYIuMkprS4N+sBQyZbsOB0kztv
         Gexg==
X-Forwarded-Encrypted: i=1; AJvYcCUGqNeN7GDLsTdflbdtr+NE0bjCg8zzvOicKqNJXQWJxw+53pifPizMQiXecsqlM9Pmp0OqTCMv9GEgY0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmREKUAtghMwY4zLlSu2eoPQwyZJ596okhY8/5DWfV9BVWCRfV
	12Syn1tMSC5WTU836HuteKUITlWB5EA7s6Tlqw+fkma1hZ20Ibn+MUdURniTEfbHwqk=
X-Gm-Gg: ASbGnctBAKbFI0FL1X8hE/GTNWj0QcBY6CmO5RlqyjPm5r0u+jPFhLWLax2ST/1+XLs
	ash0cT+RwxXWna0F9oqh2TEPF8hn0WZqxf5AmtPTULxPFgUA2XSFmY1ILebOUuIrIR67j/pXFVI
	Pj47smvu36WQm/mybQ7ohcWb4kU6h28g9J7RR3vhXlFDK3ElGkNwrji1B6KnVWo/KY1sOuz6vz7
	e8prNlbc7plJBUhlGRNa3te9kPzB7wFfD1IVx5/8tp5N5WefarGr4egs/yKG+6H15wR16Kf2uzG
	jl+cLTu6Uym162IR8gOO1S5RScj1qNeSIkDnk1XfMGoV3u7QAthgxZwe4j0OJx44vqViBsRTHA5
	JwffgAz7AASR3qf8XjS9wG39b6VBu+cA7lgtCrkMp9Glywzdm1xgiTeKGs6gyEizmKqI42jdBn4
	39bSV/OA==
X-Google-Smtp-Source: AGHT+IEl9hg1Kv37coDTdY5hfywj5TzhKzDMoQuXuH/tP7xQz/4t5TIbX/bOlblMbh1MgqEKT4WInw==
X-Received: by 2002:a05:600c:35ca:b0:477:7d94:9d05 with SMTP id 5b1f17b1804b1-477870b4610mr22199385e9.35.1762938115446;
        Wed, 12 Nov 2025 01:01:55 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e442c2sm25971505e9.7.2025.11.12.01.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:01:55 -0800 (PST)
Message-ID: <60625b83-aef6-442b-8b38-558c3751c4a6@linaro.org>
Date: Wed, 12 Nov 2025 11:01:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mtd: spi-nor: micron-st: move set_octal_dtr to
 late_init()
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
 <20251112-nor-v3-2-20aaff727c7d@nxp.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251112-nor-v3-2-20aaff727c7d@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/25 8:48 AM, Haibo Chen wrote:
> Move params->set_octal_dtr from flash_info->fixups->default_init()
> to spi_nor_manufacturer-> fixups-> late_init(), this can cover
> all Micorn and ST chips without repeat in each chip's flash_info.
> 
> With this, we can also remove flash_info->size if chip has SFDP.

you could remove flash_info->size when chip has SFDP even before
your patch, as params->size is first initialized with
flash_info->size and then overwritten with the flash size read
from SFDP.

So this comment is misleading and has to be dropped. With that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

