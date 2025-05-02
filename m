Return-Path: <linux-kernel+bounces-629085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89EAA676A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 01:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007549C09D6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017AF26773C;
	Thu,  1 May 2025 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="KQHA7qqr"
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1C224253;
	Thu,  1 May 2025 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142137; cv=none; b=EsoxmkUN6vlMtVb7g0FZ8WuF2krL2I6kSs+Ooj2U6RI6/tlaXt7WVPGX7vgh+rJSXA0fHBS69MNZjW0gwx+SAnZX1L45efHbd+ZryEtmxs3ZPocmN67ot3tQ6vZAFpSyH/ZGlE4AVdrewYlS6jdgwaYqlHoD3sqGk7lNVhQJrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142137; c=relaxed/simple;
	bh=p7fQDBwKEOcAhP8WL8RWsj0IlpjWdHFNxvJgQ/mzSkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AeyZv/X8C5jYkjpN0UvjacDxpk7J/Rv9K0ImBy5O0DOhZMfkP8sXmZ4Tu8tqn19Ve+6q7dedBpQ5Nx46FIVAyqIvLs/fNL4jWbIK2SM+pQaF1PJAT03aYd7ZOvBrCV0dhDZvsp8rpZUiOv/Yz/8DfHVPEm0/3/tAM3mTsBIglEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=KQHA7qqr; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BFCFA11FA;
	Fri,  2 May 2025 01:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1746142126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SSd/d4oY5sG6sC71AfIyUCv5ZFIzJDqINK1IEBxHgyM=;
	b=KQHA7qqrzWIoGBrgdbwVBkhPFK6dFDJdgj9AlXCRn4K4Ipu1O7Le9kptGyv4IeoPOsCzo7
	vmfzOwn6zpV+kBRJ/f7JiZUEmAHOW5FRTovCRrFlNKaN+iNlUulFLKWVrEO+EUEbb56a45
	fSvxcwe49iPADNHPLQtOyULMaxYy/DeTwvAwMQ+Rb/RIxLogV1x6bJUEK0T11MPZWUxZWf
	7rYKVsxt/cOmvGrQ7EhP1qpSHeWf2Wbq5V8bqt0Q2SCtS9mhlZfynaezAdDvJAxVnRni4C
	/JSdfTsN+hl8rzDHIRe27bQu0nSXudRgnV6Dluuu5s0qHWbjUev7NhZji9YAYA==
Message-ID: <47aae905-1a89-44aa-a31f-6cbfc0eb6726@cjdns.fr>
Date: Fri, 2 May 2025 01:28:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 1/7] dt-bindings: timer: Add EcoNet EN751221 "HPT" CPU
 Timer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mips@vger.kernel.org, tglx@linutronix.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, tsbogend@alpha.franken.de,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, benjamin.larsson@genexis.eu,
 linux-mediatek@lists.infradead.org
References: <20250430133433.22222-1-cjd@cjdns.fr>
 <20250430133433.22222-2-cjd@cjdns.fr>
 <20250501-ludicrous-idealistic-camel-7bf8aa@kuoka>
Content-Language: en-US
From: Caleb James DeLisle <cjd@cjdns.fr>
In-Reply-To: <20250501-ludicrous-idealistic-camel-7bf8aa@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


On 01/05/2025 12:58, Krzysztof Kozlowski wrote:
> On Wed, Apr 30, 2025 at 01:34:27PM GMT, Caleb James DeLisle wrote:
>> Add device tree bindings for the so-called high-precision timer (HPT)
>> in the EcoNet EN751221 SoC.
>>
>> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
>> ---
>>   .../bindings/timer/econet,en751221-timer.yaml | 80 +++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/econet,en751221-timer.yaml
>>
> What changed? Nothing explains dropping the tag.


Sorry I lost track of it, I will re-send with it attached again.

Thanks,

Caleb


>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>
> Best regards,
> Krzysztof
>
>

