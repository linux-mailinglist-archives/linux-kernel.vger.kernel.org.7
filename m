Return-Path: <linux-kernel+bounces-773905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25EB2AC19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B496812D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9B23D7EA;
	Mon, 18 Aug 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZohjIzNQ"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EE35A2AC;
	Mon, 18 Aug 2025 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529137; cv=none; b=YnysyVkKD/XDKK4IG04wKGFZ1GoPLT3kxIvc+F7SmfokQmnwrIO+oNYjmiDw2XGnfZ3jiAPXgbAmlHYotUopms+w0zTa/p6W5FAZG5VHSpHQCx7QZWVHtIdkepEs+u3bDgK8ywiRbRMaX5oIPzGfTG4ymPmU5nyoXZFxBdsQmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529137; c=relaxed/simple;
	bh=sj/oXfDVVXELOAADYk1HnGfq6Lc0xGCmRN8XpZzZMCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0JQ4E7qMRPO4ujumqn9Ahy7jmvb2Lwxx5Trle+VcLfWTcl90OI1Fmd2yY/8c2alkfboeAH0DjrwOO5/vsJgByFOVlhZmz8sLhRNUf8QFc2m16o4DDcDDGb16bYzaZ655437cEHlTk2LAZSXMNJCJylfUdcX2gBxWCaUJx9KLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZohjIzNQ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c5G7b537qz9t7s;
	Mon, 18 Aug 2025 16:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755529131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=It6WsGpfjWI4leoXs05vkzx9/2tYzuPt+sPubFhfa+0=;
	b=ZohjIzNQt2wCVmQYGFKOP73CFbd6Ia0/eaGon8+3QyJWF1qEjO3Ww3UY5k/frrG/RiYlHC
	Gr/S+lyczLT2Knd0qczhXn2tzrfObKvXItL8eQzz7O9RPyaQPSIUX7KqRjmRAiS8+ojZVD
	ZoWeeH3G1LHZgkLl4EMyUwrAnIXGI7B7xOJovQFn/i87Jqfbt2iUsSGfvI3M/CKVSe7Xbn
	TntQ2bHdqBtkddu2hZyQh9+9v0E5mC2zqzqyc1zXrro52VjACsNYWZdaQ6tlahOzvvTLJQ
	dJsvfcKTHPaAo5ex3L0T6ZMJjiunz6u30bzxbdbIfeZeyGk72zL0/3jinC4YeA==
Message-ID: <d1510b98-5094-4eec-b81b-55d0ba3e1b4a@mailbox.org>
Date: Mon, 18 Aug 2025 16:58:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arm: dts: stm32: Drop redundant status=okay
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@dh-electronics.com
References: <20250818143730.244379-2-krzysztof.kozlowski@linaro.org>
 <388e6f81-383b-4b39-9b75-8d2cdbf95d37@mailbox.org>
 <259e72c0-b69a-42d4-aec5-ad8a6e03d416@kernel.org>
 <651df530-797a-45e1-b199-917deda33222@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <651df530-797a-45e1-b199-917deda33222@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6nsdwhcsnfm3nimas3f6jx49wjpdyxzm
X-MBO-RS-ID: e1973190b65b1be2432

On 8/18/25 4:56 PM, Krzysztof Kozlowski wrote:
> On 18/08/2025 16:51, Krzysztof Kozlowski wrote:
>> On 18/08/2025 16:45, Marek Vasut wrote:
>>> On 8/18/25 4:37 PM, Krzysztof Kozlowski wrote:
>>>> Device nodes are enabled by default, so remove confusing or duplicated
>>>> enabling of few nodes.  No practical impact, verified with dtx_diff.
>>> I assume the "no practical impact" means DTs are identical before/after
>>> this patch ? If yes,
>>
>>
>> No, DTS cannot be identical in this case because one had status, new one
>> does not have. Practical impact means... visible impact in practice. How
>> to say it more clearly?
> To illustrate: this is "no practical impact":
> 
> 
> --- dts-old/st/stm32mp157c-dhcom-picoitx.dtb
> +++ dts-new/st/stm32mp157c-dhcom-picoitx.dtb
> @@ -691,14 +691,12 @@
>   					interrupt-controller;
>   					interrupts-extended = <0x49 0x00
>   					reg = <0x33>;
> -					status = "okay";
Sorry, yes, this ^ is what I meant and obviously wrote too fast and too 
inaccurately. My RB still stands. Thanks

