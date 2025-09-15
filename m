Return-Path: <linux-kernel+bounces-816130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85179B56FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C1178CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C092B275B1B;
	Mon, 15 Sep 2025 05:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLgMo64b"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64426F2AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915613; cv=none; b=CR3qiv0V2LCR1fY7nIHPm8KRyrgmCtWxC4qQQUHTG5GB+oqulmpkaocsyU59dwIeKotIkVlD1VIwlLPO4N/lFeaPwD0F2g7zeeIBzrjCfOdpgKZA3XZeVnIUACeZnj1hUdNpTTK89PjXipGdVGNtkE4qAYJh5YCruL0nruMSoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915613; c=relaxed/simple;
	bh=JIF7wtlPlo7ensEBWZTrh6HhFvaUaAowbOa05FbDUnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuO3qgHCCA8/Kwn766oS/xz4KByHA+0vLvs2gs7t7ByCTACFE3KAMuohI8QL1Ui0jzx4xC97BGfL+pn4HmwyQU6bXt+jR3AA84wip1eddrcidQm9hd6ZoYL5eubnYYEG12vtU6l6SkS9naAGeTff6zFrXxJODaYlDasE35Goybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLgMo64b; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7761b83fd01so2020649b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757915611; x=1758520411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXozmDJ3HnlGu75CLn9cmOAS5UrsjMSL6Ugc5vl8nJE=;
        b=fLgMo64bjJDN8aDInzKl2wmL7bTzRvamykzapDgnZQ67SltrVl1GioYK4ezgeU5abg
         fSKDzlBIMisipcz3VML7KINz2/swhyhMQlNBO5F3ch7i+39vhqYG9MbIw9uYNDOoutFZ
         FZ4WT+sSYxCI9H4k7vtRfpLDdjkluwc1cQbvmcOTqv93oo61Rc9xXn6BI2lcMSJj50g7
         wt3g0nFVa5jhwJliMiwBMzkjiQJ5YRuEcw5guCDFtdM+O6C9b54tbhCTAPJRGiHtzKyp
         7/+dsiPb5f4l2G2yNg0wKMsIiPjU8bQXZPESTSFCh373/duukHWDPtnVsxSbE8h6609T
         8D5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757915611; x=1758520411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXozmDJ3HnlGu75CLn9cmOAS5UrsjMSL6Ugc5vl8nJE=;
        b=gctDNm9Q+MKurr8rNCovFpBGTvlAju8vBwnL7FKi4K2jtdjPybSFlXGVzIIdAxQvz2
         uafvQppKMlUKXjKw+S14jj/9tc/fsWcm8OrUE4/46glkMORZXM/2Dmp4RhVpuZCKk/Pf
         9S2m6HjmGWJDB0w2Mh5tc0beMBD47BiBGekmXckY+pW5qFMlJnwkH4OSgs0SBd4x/Jgu
         6HhHbEbvPkmumK6HmI+xMzf/cOs36IdFd1eBiZrZBpdeks8WwZrS/9RkdKnZiwQ3+Kwt
         IbdGX2/T4IWX1NTbZfEUM7ZnPErIeAnjGrEY7m4rLW6Z8EGISkei8k8yRujdmp1W1grU
         PdCw==
X-Forwarded-Encrypted: i=1; AJvYcCVW8MCL3d7B3KNT1+iL+bt33kkMtGibElNcoTwyEF7oU29eU/kqcldkkXLkYJ0oZJj28lneF55xppP73MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyF9Gu/xozWeRa4AdSFNXXA2qaYjU7XQncr7bC2BlCjKwOT7oB
	dydo3l2IyNvS+B+Mki1zNxvjgpGyonYSF6z4o4x7ZNlvsa3k139Eg6iv
X-Gm-Gg: ASbGncuJ2n96Wc/oLal4UsSHSOKOHXgCOU/gMA2xtoegF1gO2TwVsG9ICRd8fDMlObW
	RhEMHowIfjfElM3xnAxkenHkOpDQBWGLZGviNlJp1H8X3si4bSgeuBRey+jxHa8rog60YsOlefd
	io6tgh/To8NONFRehrl7c7RMrdXlVVrDhyXHfqfZ7VjYoqJlmjiYNRRb+m540+ZTXhv4fIeXgwx
	mYMZOJ5KRPBUZBw27wldKtcrWRqW5hU+oHrmPLeFW5flDRgOQAUv8lJnaOHtPWPZ1yeKEofB33L
	u2bMFVND9Vhw99y8nG0VZqmFSkb6fYbyAbldCAtLonqCc7P66/CtLdaxzlulVjBUfy1oh/vOFUq
	CQ4OVs+K7F9xCbnhkL5UjN+uI7W9vNVz0UdFrtSJTPBo=
X-Google-Smtp-Source: AGHT+IG9GD83InwBhFOW3NGAg67t2y+nz21UMxqm/mpb0uOARyNxtHSYfMypATTlZLh+C+BHHF2zLg==
X-Received: by 2002:a05:6a21:998e:b0:24c:f8f:2b95 with SMTP id adf61e73a8af0-2602ca0782bmr13719523637.40.1757915610927;
        Sun, 14 Sep 2025 22:53:30 -0700 (PDT)
Received: from [172.17.44.75] ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b3603asm11755559b3a.84.2025.09.14.22.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 22:53:30 -0700 (PDT)
Message-ID: <8fa9b725-5490-4ab2-ba0c-9923bd30c677@gmail.com>
Date: Mon, 15 Sep 2025 11:23:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: add bindings for QCS615 talos
 evk board
To: Krzysztof Kozlowski <krzk@kernel.org>, konradybcio@kernel.org
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingweiz@qti.qualcomm.com
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <4869bf32-7a0c-4db3-b3ee-4a237f20f81a@kernel.org>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <4869bf32-7a0c-4db3-b3ee-4a237f20f81a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/25 19:27, Krzysztof Kozlowski wrote:
> On 09/09/2025 14:52, Sudarshan Shetty wrote:
>> This adds binding support for the QCS615-based talos evk SMARC platform.
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> So simple patch and so many trivial mistakes which are already covered
> in documentation. Did you read the docs?
> 
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 03a7d3c92ecd..a5dbe6af68ac 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -952,6 +952,12 @@ properties:
>>            - const: qcom,qcs615
>>            - const: qcom,sm6150
>>  
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs615-iq-615-evk
> 
> That's enum with previous entry.
Ack, I’ll fix the commit message style, drop the redundant "bindings"
from the subject, and correct the enum placement in v2.
Thanks for pointing it out.
> 
>> +          - const: qcom,qcs615
>> +          - const: qcom,sm6150
>> +
>>        - items:
>>            - enum:
>>                - qcom,sa8155p-adp
> 
> 
> Best regards,
> Krzysztof


