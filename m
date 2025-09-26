Return-Path: <linux-kernel+bounces-833793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B780BA316E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7608F1889B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD652236E8;
	Fri, 26 Sep 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odRhdtWc"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E1155C88
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878111; cv=none; b=TOL1cMmZzFhEeumcAOhOfssEeeRmDPj8fQo4d41Xz7dH/c3IvIMyzIManLKzZpGp4i8trEgbcM9/1fNbjOf52mmNbmmnx0J5xSGW6idK9REKDaB4lL/Uc5cNpYLXjhfvXE+vrh9bBvYCPHg8e6xAfShdFMkrcqcrYx11S9CtVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878111; c=relaxed/simple;
	bh=TUFDRPK9OZWQmZ4Io6Lu4cMxFKXBj/5zzJ9fa5uYkLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4BdDJQMyWBvuCpFQHZdb0YmHXTrTWhXw0fjfTy69yAPjlFVwrBLuVwqI/+NOU/tlLQv3EvY6Jc6BFuRbCyZTtDClo44MHRJBu0xwPeIO1xzb9tqexTjv0adt60wNqjbgxamIbo9tj4glAYOJ9brkxhPDHw0WUIQgfE23J417bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=odRhdtWc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so423469f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758878108; x=1759482908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFTjY5/OntfnPss18xMJfKbpZ6ztPp46Q2iJkWHJLes=;
        b=odRhdtWcmyjJzDq+4robwRjA7HdxMSBLQGQNJhWqgJ4cKlZos6MhVBpsSni9P4Rk0O
         1oejhDZZAJBy1Ca8fVUthLGzuFh/BYnzYNyNLnBb1bCvJj9IXUd72mGSD0CCaLN42nI4
         oHsze61RC+7DHvBN3lMWmtIJv3jGxcNEP6GEWxcOTNZAL9ynjSZl6JZo0cKHg81paI1k
         ygusMKdV9fB/4LCJU4E0cDou9fE9gvldJUyqLET11EIEyDBOIdD2I+cGIczrRxJ0CTJ0
         TFGKHNqT0ZjBjMTvT2xddrvfzp6Tje4v20Je6lQWWrWOPMf+uUDs3bDpj5ROu4N8d8jo
         mSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758878108; x=1759482908;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFTjY5/OntfnPss18xMJfKbpZ6ztPp46Q2iJkWHJLes=;
        b=czPGijHeomg8SslbMYQJFifwg5grwnjO6yAvSHcDfzPBRMppbizhcVhge/mCUr7hVT
         +Y9UKNrhRrdNr8T+gtkJdtNpgCv/mefWfkjBaiYhoMNcW2S0WII3UmVqGxzt1MZO2L8f
         y8I8dTMdwLAKkHwhJb6mkxX2fHyD3aiXw4IIDM8XWvDBTLp+KIaOJ774rcQC+TkCt31p
         uDCMSzz5jLnAE7ZC51eoqTYD9mIhCGrIo4SF7Pr7kw/sCcl0VdVnox/8ti7BOF5f/Bb9
         5DiAe78K16tKD7F5WhvRkSs+cYdbBM0Mi9EdJAZjR1GOugpI8pSDS+DodV9ebiNA9dUS
         +BBQ==
X-Gm-Message-State: AOJu0Yw/JKm5+EGtZeMw6YeqIDldzurFubBnnE8RLtP4hFo0rhlobufy
	9FthBKklWZ35UZ/VJSFXvkR0teaGJcc2Bo/CGjk1br/cy/yCkGcr6YyA1x4npn4kekc=
X-Gm-Gg: ASbGnct/3sZY7vJ75jv7hAPHLUOLNCRy9POWhuWdglvoKiATIEkIEROxEgVineEE4be
	D25K3jESBzS1bya38jFmSfuSy9mIppf3C8FUHyS1A4XQ+qdN8yYFBdTzgr4uWbclcAtvjQjZO8J
	FpIZ5AVF17ZJsYvricWdLJEqdVNY7ffKuBrKdty2BYF0Rzo0yKQRbRts7SyotxTD4i+wWkbFjQI
	9EB5sEm27qprLwZDN82pPQCXeu1SDHTUT5lBUCQcNJVsVq7txmJKFaZKA6j1FDuwEOYkh5K2FS3
	o8XEXEZw4NE5167lorfZliBNdC+0zEeT4XFvTProZ7Do8nVL5GSGm2wVutRzjaJJs/Sx+tyBJsT
	32hjIpiWMUvrr9hxBMkNX1xsau9X7NUWLTk/wbwMKBkI=
X-Google-Smtp-Source: AGHT+IEVX7V7+nffT3CJ9dpetDYPOn1G7WuDY6pTt+HXts5dckr78/uI1tL88mQFYL4fesUlu07JBw==
X-Received: by 2002:a05:6000:2585:b0:404:ac77:6598 with SMTP id ffacd0b85a97d-40e429c9c4dmr6196945f8f.11.1758878108352;
        Fri, 26 Sep 2025 02:15:08 -0700 (PDT)
Received: from [10.11.12.107] ([79.118.185.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fe4237f32sm6185169f8f.63.2025.09.26.02.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:15:07 -0700 (PDT)
Message-ID: <586c85d8-7638-4e52-8f96-1aa4640afe64@linaro.org>
Date: Fri, 26 Sep 2025 10:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] firmware: exynos-acpm: add DVFS protocol
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
 <20250924-acpm-clk-v5-2-4cca1fadd00d@linaro.org>
 <03cbad1f4f311727b4dce9c969404e2bc138c556.camel@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <03cbad1f4f311727b4dce9c969404e2bc138c556.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, André!

On 9/24/25 4:24 PM, André Draszik wrote:
>> +	unsigned long (*get_rate)(const struct acpm_handle *handle,
>> +				  unsigned int acpm_chan_id,
>> +				  unsigned int clk_id, u32 dbg_val);
> Everything seems self-explanatory except this dbg_val. What are API users meant
> to put there? Maybe some kerneldoc could explain it?

I don't really know, there's no documentation. I can guess by reading the
downstream code.

Grepping the downstream sources reveals that this field has a value
other than zero just for the edgetpu driver.

Looking there I see:
#define TPU_DEBUG_REQ (1 << 31)
#define TPU_VDD_TPU_DEBUG (0 << 27)
#define TPU_VDD_TPU_M_DEBUG (1 << 27)
#define TPU_VDD_INT_M_DEBUG (2 << 27)
#define TPU_CLK_CORE_DEBUG (3 << 27)
#define TPU_CLK_CTL_DEBUG (4 << 27)
#define TPU_CLK_AXI_DEBUG (5 << 27)
#define TPU_CLK_APB_DEBUG (6 << 27)
#define TPU_CLK_UART_DEBUG (7 << 27)
#define TPU_CORE_PWR_DEBUG (8 << 27)
#define TPU_DEBUG_VALUE_MASK ((1 << 27) - 1)

And then I see methods like:
static int edgetpu_ctl_rate_get(void *data, u64 *val)
{
        *val = exynos_acpm_get_rate(TPU_ACPM_DOMAIN,
                                    TPU_DEBUG_REQ | TPU_CLK_CTL_DEBUG);
        return 0;
}

or:
static int edgetpu_vdd_tpu_m_get(void *data, u64 *val)
{                                                                                                                                                                                              
        *val = exynos_acpm_get_rate(TPU_ACPM_DOMAIN,
                                    TPU_DEBUG_REQ | TPU_VDD_TPU_M_DEBUG);
        return 0;   
}

These methods are used only to be exposed for debugfs.

So it seems it's used to __get__ clock rates or voltages, and that the dbg_val
acts as a debug command that also specifies a secondary ID, TPU_ACPM_DOMAIN
being the first.

I find this a little ambiguous, so I refrained myself from adding a description.
Since I can't tell what it is, and whether TPU is really the only user or not,
I propose drop the argument or not describe it, as I already did. What's your
preference?

Thanks!
ta

