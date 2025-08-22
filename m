Return-Path: <linux-kernel+bounces-781350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2A4B31165
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1796418918DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD12EAB6C;
	Fri, 22 Aug 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmdAC+0M"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581D2E8E17
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850450; cv=none; b=FyDVHj8PDS6S4PkAFKeWQT3nNUELCSAzkmCoyblvA9unaotaz+mNaTyQWymA62JMku2v1+8AG0KCeveMV21Eg76Czv38QWoPpWgu/LgBFgyZY/PV4VjKkO9Xoef2qbor97nIhX+woa133CMHFupRllqRmbCg6MitZsB032qp6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850450; c=relaxed/simple;
	bh=ISKJzVPXu4k+ZO6I9/7b7/q2WElbo9A+JMC+LqnOasU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKwdol/YfemCnGk+O+A3FfWFzBf8DbXgxvGb7s2WfGMxZFYRDLvM4rQbiYMQnDdk++7Aoo1Y4uypC9OpOH1uJ76M92kKFbjuDupzTvBVMHCJkImVyamwtWYQVTr5V0gD2MgSh0yE4ArWEvojY6gKytJsLCvbl/YgDYF3e3haaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LmdAC+0M; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7acfde3so279457466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755850447; x=1756455247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPvTo2XEETbDk4TcDNA4R7e2eQHtVrkf9abfQlGJ7VI=;
        b=LmdAC+0MOvfF50Fuxs9TAbyHCdTDFlrQIbzbTUQ/F4/qTWpROoYBUX0dRV0vHEnGaa
         G2UdjJqlhQcveJELlToq5PXE/AzlsCnFZhyn0qOlRc57S4YPHuOMzwcLulZkD/K5potN
         ovOLU69OfOXyaZKKiMR4Ko6EQZFs+g2hi0b+MiCjS7mnX9EQneu/mNOe3LaBCtR6MqJu
         G/BFQaqrbVnEGxDpJtXbI8PiHN2nfAsEUWraAEfcKLrOd8JMtgBB4zJuITnTXcUDZZZ8
         laSRZFzGv003bbnZ6Wi5ZcR7mnXjq0sOf7K8yMbBpwuE2woAao252VKl6EINTL0uh43L
         cbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850447; x=1756455247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPvTo2XEETbDk4TcDNA4R7e2eQHtVrkf9abfQlGJ7VI=;
        b=E2XZroArevtFHX3xD4swHDisWnWSUCcrz+LJgISOv4XIx7a8Ztdw7rbU08/TuhYN8E
         ISmGJMrecOmm46SR9j/bnWT0Es9Wq5uDgZuFpHd9SXGGUNxRvaIhZnZAQoPrdY7To3Z+
         5TuSdZoExguZxUAwaZ+AfHMz6KGHS3JK/udm2MzOzvo/KqyOVd6GkqxCw00q0c3EUpXC
         xMRVFnreHYqQ1pU0nqn/GbY9hgfDwZRqQw8WDD3SLoRMhbM3M4hdhqQvXQuh1O8T+vZ4
         GuMxU2CXc2+cEqpC+gXIdjdSbz0n5B9DXgm7lu6KOa2MVM3ATq/5aDIisr/JhYphwJMp
         jDwg==
X-Forwarded-Encrypted: i=1; AJvYcCWb602Id+7xEz/07FSVp+Pwy/K2gOtVufjqbiQDL3LAeXl61pDgeP88H2E74P2PWCYVIdBDF5j910qvigw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdaRLHN+1O023Ka1jC5mRU0Ii1JInyi1iiQozOC4e6o0b1GWd4
	zFlUz9ND7TJgbVcPNMjutXiELy4LQUzQMzJXHiXeQ3cOFWpUNbWXrzqQBdtI3MG5ku0=
X-Gm-Gg: ASbGncsuM53SvNYhXYsILSyBCC/+hOnwTXbC/fRPYbbxIe0ZJdk8YAzfsRzK8gQClIV
	ijdQXg9KWTFvFcx1C3rTVZICLgKDtHcUejiYl4KDhCu6Kt687p5ub/hGXdBgFiOkAsA1SyVLkFu
	f4+fUzJiYPMC7Ofzueqz2TGTZOPCOVuDVFCJR4/oolod6IuKogXwzenFEUr9cmw06Y7b7/zp6hB
	j3/8oCM+sd2iddi1lUFek7JUeCoKhdcD5xaO9XxMqDDwZl9JYsDU44O3sxZ76aohfd562S3Zk1X
	rSfFjLvirxaLZDEhnzdGPS5s5SDiTjNomQ5ydF3kykdtA/Up1k7RMmJ7T+OdcrA3kl434s6Fnm6
	SYF2GVDA+9zpE/7ORS2fR4pLhBoQ5gxnz
X-Google-Smtp-Source: AGHT+IEGEVoS2KNiJz+rap9NchIlTHp1e7qqv0SERyT7o+gtgwKhQP2IflgiPn4RYqUiBzAj2fr7cQ==
X-Received: by 2002:a17:906:6a1c:b0:af9:9ab0:6f3a with SMTP id a640c23a62f3a-afe28fd7ec3mr185456266b.23.1755850447341;
        Fri, 22 Aug 2025 01:14:07 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded309ee8sm559576366b.27.2025.08.22.01.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:14:06 -0700 (PDT)
Message-ID: <720799b1-04ce-46da-b643-1adbdfc661e6@linaro.org>
Date: Fri, 22 Aug 2025 09:14:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] clk: samsung: add Exynos ACPM clock driver
To: Brian Masney <bmasney@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
 <20250819-acpm-clk-v1-3-6bbd97474671@linaro.org> <aKdmurrT1pFtLSI8@x1>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <aKdmurrT1pFtLSI8@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 7:34 PM, Brian Masney wrote:
> Hi Tudor,

Hi, Brian,

> 
> On Tue, Aug 19, 2025 at 11:45:38AM +0000, Tudor Ambarus wrote:
>> +static long acpm_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>> +				unsigned long *parent_rate)
>> +{
>> +	/*
>> +	 * We can't figure out what rate it will be, so just return the
>> +	 * rate back to the caller. acpm_clk_recalc_rate() will be called
>> +	 * after the rate is set and we'll know what rate the clock is
>> +	 * running at then.
>> +	 */
>> +	return rate;
>> +}
> 
> ...
> 
>> +
>> +static const struct clk_ops acpm_clk_ops = {
>> +	.recalc_rate = acpm_clk_recalc_rate,
>> +	.round_rate = acpm_clk_round_rate,
>> +	.set_rate = acpm_clk_set_rate,
>> +};
> 
> The round_rate clk op is deprecated. Please convert this over to use
> determine_rate.

I can do that, sure. Shall I also update the kdoc for round_rate(), mark it
as deprecated and add your Suggested-by tag? It would help other newcomers.

Thanks,
ta

