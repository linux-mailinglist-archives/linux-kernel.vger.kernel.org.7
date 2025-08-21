Return-Path: <linux-kernel+bounces-779300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE2B2F256
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F51CE24DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9393D2ECD3F;
	Thu, 21 Aug 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rd2pzBlV"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A352EBDF2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764945; cv=none; b=jgTDluXRogQHo7Wg3Z8GYDLf7Qp3g9wgnyZbnrCBtO8tGEX2yN+4L3lNl2YkSXSGhMEq5fu4Pt1SyelPUC3jTy3E1CDyzHVRVARU2TQC2wekObY9vdsptz121VPxomVaRrc8ZwEyi73Q0rJXeR8jDiAIp78kGgUSdkrCNP+SEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764945; c=relaxed/simple;
	bh=4zag1nlA2ny1RAp8cMmtgrq3Hf1eTv7ml6jyEBqBIX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXCdmdlIlqpitlDfn7DMxz6E+0x/U0hMtIoCyEdv/Y2SMLrCNvuQlJmkVtsBFC9HWFhOc4R84++eyHJdf6cRVz1kUAHo+/S8WRGQ+aAv3geTMwDX63tWQEzdPBchBp8NO09gmKOcS5EGIC/2tWCjOErw6E93m+1nODMwfKYcfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rd2pzBlV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afdefc9b005so13198166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755764942; x=1756369742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XT+9a8dZc6CcvXzZepsQfZonqTnnksInThWm+Nbha0k=;
        b=rd2pzBlVvOdiWtn+dnVJ95EpMT2vPcpQckBH0rO/nWe/cGhFNhEvFsa9STMX6ETaTx
         APKOf+wBNC7H7sJDATmU/2WF21jhFHNpDFZaRzr48GMXnX5RTpkSUm18olZ3WpYwnWzV
         QUSFUJRIsgo1exnlG98xF31vPb10GUv7xelPD+MSBUbOXgmsQ6sOKX1wT5deqg7txxg8
         2z37i4M9SvtCOo+QeR6Ztor4AUu6IZAo86fw9GBk7FkQ5/COb5v4I8xTww7rY0tUWsxt
         H/i7yDQAA6gsd45FEGDCe3Tx877qnBj3ctUVI20Q3139t9rJf7xskHpzIjytAPlH9+DG
         D4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764942; x=1756369742;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XT+9a8dZc6CcvXzZepsQfZonqTnnksInThWm+Nbha0k=;
        b=MJIncUGAx33vTrjElRg5Kl5kxhAsHZiYNvuvLaKoYXi30YAxu0xz0N4ub5BG0Rkmkk
         kP9Ht0nEdy+XHZOvxTr0nHY1XKY6XM17B0hupsmZNqn5LeQSSjaYePMO7kvmu5ho6c94
         F4yOnEkOliM0NZFOCf4oPMkVaV0vqRcfV4GOb+a7+6MT5jIA7PfgA0RJuTp6TIylYQbE
         HF7BCAb9z2HHf+No55evL/nNH85ihGrwPxcq9/GkpFsKH4aPlNF9APoeMTLCpESaDBYG
         hBfrcQai7XSbDPRmMhjYRLzTtMZjr3cYl3aAtqCEMQ25hLinY2siq6xY8RzRPd7oFN/V
         ekyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSo8+y0TDJ/6EUzMmKPcXvj1gFu3mL+9y1pY31LwoSRX5kXwdog91xh6Za1n8c/I4bqye62SvucHe0xCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzotYvplFmFRoOAAXxx9RsHOsuJgN87qKtW9WkCr+nVpBGDqvS
	6ApYDsDHBzuqZAlEQr2WitGGu+wcCbLh2qsqOA/2qGSYYMdfVWDaQjPvJn9li+JOynE=
X-Gm-Gg: ASbGncumG+mleBIHsPSa7ByzXFzN+iqL0JzOh+de+fZG6Y9CNdtBy6PN5zZE3z3LxsK
	noUauXuDVZqgBdptVYC7tpsmOK0txx2jM5Jb86vfb7uYjRyaIpIU9enOEdf5W22cg4pLLOTkO2W
	rPeQ0rWVw03wLjgzuivjkM+11HQHktGmUVLE0jymfWYDhUnSxs5m0oQ+jY4w8pKNbhmnhn4bW0t
	zRr8bum2ZXRFrVnsvuzqIIQHeQzY34bOSIENXiegrS8bqlvxqT8difP9Ehgw7uc8MNJCMK/AP1X
	hGZwgQopYc3oX9hX3y6zuae31LcWZELm7k8h0Gib2lnme4CCO0kTK41Dlm7BRxPuKC4NgmVlTdC
	N+4TSgYw0S3wiM+T7djDcwc3D1G0ZStP3rBqekrwYIss=
X-Google-Smtp-Source: AGHT+IHUT+pHfpmntUXj9uBUGhsiBcXhCpz8NqBaqPJXee9T83AmytajEw850sVhRqSbUCYA/OYJMg==
X-Received: by 2002:a17:906:b283:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-afe07b82e55mr60442566b.6.1755764942021;
        Thu, 21 Aug 2025 01:29:02 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded537f98sm347074266b.104.2025.08.21.01.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:29:01 -0700 (PDT)
Message-ID: <a59908c9-38d8-492d-9e3f-5560d272689b@linaro.org>
Date: Thu, 21 Aug 2025 10:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
To: Cristian Marussi <cristian.marussi@arm.com>,
 Deepti Jaggi <quic_djaggi@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
 Nikunj Kela <quic_nkela@quicinc.com>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
 <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com> <aKbTKq04umCgS_eL@pluto>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aKbTKq04umCgS_eL@pluto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 10:04, Cristian Marussi wrote:
> On Wed, Aug 20, 2025 at 11:44:26AM -0700, Deepti Jaggi wrote:
>>
>> On 7/30/25 14:30, Deepti Jaggi wrote:
>>> From: Nikunj Kela <quic_nkela@quicinc.com>
>>>
> 
> Hi,
> 
>>> Allow multiple SCMI instances by extending the scmi node name to include
>>> an instance number suffix.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
>>> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
>>> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
>>> ---
>>> Changes in v6:
>>>          - Dropped 'this change' from description
>>> 	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com
>>>
>>> Changes in v5:
>>>          - Added Reviewed-by tag
>>> 	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com
>>>
>>> Changes in v4:
>>>          - Dropped 'virtual' from subject and description
>>> 	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com
>>>
>>> Changes in v3:
>>>          - Added Reviewed-by tag
>>>          - Removed the patch from original series[1]
>>>
>>> Changes in v2:
>>>          - Fixed scmi nodename pattern
>>>
>>> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
>>> ---
>>>   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>> index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
>>> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
>>> @@ -27,7 +27,7 @@ anyOf:
>>>   properties:
>>>     $nodename:
>>> -    const: scmi
>>> +    pattern: '^scmi(-[0-9]+)?$'
>>>     compatible:
>>>       oneOf:
>>>
>>> ---
>>> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
>>> change-id: 20250728-8255-scmi-ed963ef8f155
>>
>> Gentle ping!!

You cannot ping gently while screaming!!! (you see how gentle this feels?)

>> Could you please review the patch?
>>
> 
> I thought this was already reviewed/acked and merged since ages....
> ...also the wording-change in the commit message LGTM.
> 
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

It was. Twice! This is just unjustified ping.

Best regards,
Krzysztof

