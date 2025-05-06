Return-Path: <linux-kernel+bounces-635775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA3AAC1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1451C1C21ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8A278762;
	Tue,  6 May 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIgIjiIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7020C028;
	Tue,  6 May 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529008; cv=none; b=QbnLQXjjRpFsp257DPtY9oE1CDQRX+Z+RrOHewXjwR+z6WsHKJj5ikzDrqCfhMwKZmrCzTZibwWMvi+GRL+QAQPmoaHzoqEDS3PuLCNLCVySw6fEPB/dFHLG65Eia8dxhLCms0+VKxnh0wliapaFnYU+i/Ivf9ZDLQcpmMEEd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529008; c=relaxed/simple;
	bh=uaUIXUgof7mjmO4nZshr4Eg1/ZNO0weUmIDfkhKCFq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvM3lHB4DRyPsiwPc2GvKWjw9xfKeAHfXe9WYHxZ0ebu92VeKnBh8nQPgc1sNPqMPZUVbxY5NOLrScmr7zJfLb3GxQdFnSxdgnWIzRBGAIzwUNybDdSCyC+8ng9xHseWiIXym0tO2ghbm0BQpRsJIq90y3IH7pix4RStmitwYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIgIjiIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFA6C4CEE4;
	Tue,  6 May 2025 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746529007;
	bh=uaUIXUgof7mjmO4nZshr4Eg1/ZNO0weUmIDfkhKCFq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZIgIjiIy5u/3y+BYW8fxmO99+L6XmmnUmUXTMo4kIRJyK2GJomQJr1hAT02bWQNyO
	 TXpQN7NRlAz/RaOJEC8O/Fs89NLIamBZn9mRXTSxd6nVBFvxf0GZiwhgB6ecYpvTrj
	 XHccCeQgHl8pJRwRUOLRUW3hTudfcsr8vPtrCpgmQJbOdhfdlv9+wq7DRXCUf/nbXC
	 uyUPZ+M6X0+YxrDwL5shzZlegrv6yDpW0YWsj/8s4Yu505AUwxQf20KfJugZgnSZaw
	 m+bG1zu3Big+0i2BGbNwwisQpqXBlsYi4XhbH3FgpCe1r/XFW0XFPgI23r8VS5Mxbf
	 VNITG890C/xbA==
Message-ID: <78797f80-bdd6-49ef-b1cf-ffe4dc1dc5f6@kernel.org>
Date: Tue, 6 May 2025 12:56:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] of: of_cpu_phandle_to_id to support SMT threads
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, jonathan.cameron@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com
References: <20250502161300.1411-1-alireza.sanaee@huawei.com>
 <20250502161300.1411-7-alireza.sanaee@huawei.com>
 <20250504-acoustic-skink-of-greatness-1e90ac@kuoka>
 <c2ace0e9-6565-44c3-84eb-555707f84509@kernel.org>
 <20250506112337.00006918.alireza.sanaee@huawei.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250506112337.00006918.alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 12:23, Alireza Sanaee wrote:
> On Sun, 4 May 2025 19:52:34 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On 04/05/2025 19:51, Krzysztof Kozlowski wrote:
>>>> In the CPU map, there are two cases that only one occurs at at
>>>> time. 1) "cpu" = <phandle>
>>>>     2) "cpus" = <phandle> <index>
>>>>
>>>> The first case addresses non-SMTs and the second case addresses
>>>> SMTs that the variable must be cpu(s) with an index where we later
>>>> look up the reg array with that.
>>>>
>>>>     core0 {
>>>>       thread0 {
>>>>         cpus = <&cpu0 0>;  
>>>
>>> Not so sure, dtschema says only one item is allowed in the phandle
>>> and I do not see here binding change.
>>>
>>> Although this wasn't even sent to me, so I'll just ignore your
>>> patchset.  
>>
>> Ah, there was no binding in the patchset, so that's why I did not get
>> it. Makes sense now, but question about missing binding change stays.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> There are some existing bindings in which this pattern has been
> used, so I don't think I am changing binding really.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#:~:text=cooling%2Ddevice%20%3D%20%3C%26CPU0%203%203%3E%2C%20%3C%26CPU1%203%203%3E%2C
I do not understand this - it is not cpus phandle. Please respond to
specific comment: how many arguments are allowed by dtschema for cpus?

Best regards,
Krzysztof

