Return-Path: <linux-kernel+bounces-749712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E6B151F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B2B4E1BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F328C2B5;
	Tue, 29 Jul 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BV4IAbeY"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4B340855
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809343; cv=none; b=e4HRi8acylXInjc5B/z+awmJUi75byi+6yqPxUahxQwrR2UvGPfcNNNhk5e5F9TgdZWLZEyTefRLTvyz5vOl/tblC3I6L8pBmpKweMypueQ5g7foFtdkodh/hwNxEWMYhTJIg3sFpySrDScmeGzfrGyG1MONI82S+FquphtRce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809343; c=relaxed/simple;
	bh=5dB0snzfm4ymOez8CHuvvgTkTx8tPHDF/A4QjoSuiGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFOon5nrpbjNuIE+jJvxgu42UKNrldppMcwQ782mk/wpZWIN8qPUGDKXxDefNSU7vwkkqASxdjYkDOPDjWwgp1xqnuajVl942J4A+txOPniUr8p2WWdykQMncPW6g6+qfQJCl/QV5tN6/29cDBSnDFo0ZDnoTgc/B0SOdwF36M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BV4IAbeY; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-87faacc4b8fso350579639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753809340; x=1754414140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2EqrBxQEvmex3RN0wG//hFRAOGyrRJo4Acf1BP8zXY=;
        b=BV4IAbeYaTP2IjJ+VdhJKVN6OkY6ezijME8jais4HarCMdR/0EPyen3+AGv/9AwLym
         EPcJ9QoLr1K02D5Y9IcAqG9szgh/u9USUVRsv+lR+b4LqORs9sbs9ggftam+68VOfs8m
         hiDrW0PFYlWrsSDWJSDi3DRIQ6gKeQxCK5hX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753809340; x=1754414140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2EqrBxQEvmex3RN0wG//hFRAOGyrRJo4Acf1BP8zXY=;
        b=RRj2LapqBzhqKaYT4WnQfVdLJ1z5gB0C9XzRiSxhX7vVVaxyFh5gm/DKUfGxNhQWAZ
         p3C963KviPrczDhgD81STy3yy3UslxUOxuoncKbCPAgTQkU3H+H718Y71NvgfhYg2III
         lbk3RRIPci3J/Pu6dMrJto7DUz07GAIkMHLHZFtradwjo1tHL0riyDSG6FSwZ2o3gYxX
         MAAS4kLNj9xDsjWt/YFKGdH7ekkUhlKsFPQw5ToqqGUucUTLca3T8PD4zr5hb+vtoxhh
         4coimUsM665OUtCLnT5c26zOCxLbSrUAye785bftHKxAk5RgkWD0GBlP6zBnbbfwssrD
         5PIA==
X-Forwarded-Encrypted: i=1; AJvYcCVMnVn2euQpiqMg2jhW7IEyTbERmxNvEMPOtjeyXSCR1k9Yh4LSJ38G7pZj8RK1TflaKox/5V7KAVKzKis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0T/JLd4ohc6yfmKiSAcrx4+r+stav/GlNIEeqxHPQF4VDRItB
	fV9j+WYck2UBnvhDAZ0Ry3HRB22fIfAeJrj2z7+pDj05KZsYuuaadzVnV9V+8U7vt9A=
X-Gm-Gg: ASbGncuVkHkUlqmr8SyrRJYM1CL9dafZJgQCkNPjrPMVF/iVfgNYk4kSQhYH9FM5u8X
	Dhq4cFOCq4UGZvKwMOaicsYfwmwRJBDLY3O4U2Dj9lbhM6pV1zqu9rn95n67WkyxBWlHYdXnw7o
	GKYQEsSYKb45Hr6qzZP7mti8XYFd94iqmjcoZOydT34Mc8ooJUQtmUvd0ixuw3KZ41smmU2JPCi
	adT3vx6s55ts31hIN/SBi8JfK2mlKrCx7MyeFLMu6ggdmDQ9tNBZICoK3xjOkrtGgKvD/ATyBGc
	K180qxx4tKOYXilcbrRQiWdAmSLabaH/q7ua3yJDWGCBiWQncTiVPo56tqvCgazDSaQ+uMnOP0w
	kgDtwA2OJgvk93AhOpOdDpRmnT8jYUK/k/A==
X-Google-Smtp-Source: AGHT+IFzgzeXQgtRqxHd8/6oDNF9NfVYk14qO7b93cmcGgQ5Th8u+vmcYVIp1yT2rMO4Q7lu3z3Qdg==
X-Received: by 2002:a05:6602:29d2:b0:87c:4412:dad1 with SMTP id ca18e2360f4ac-88138140d6emr52509239f.9.1753809337720;
        Tue, 29 Jul 2025 10:15:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91cb68csm2704148173.9.2025.07.29.10.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 10:15:37 -0700 (PDT)
Message-ID: <f145b475-5b61-4565-8406-98894e706077@linuxfoundation.org>
Date: Tue, 29 Jul 2025 11:15:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Code of Conduct violation complaint
To: Pavel Machek <pavel@ucw.cz>
Cc: "conduct@kernel.org" <conduct@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
 <aHanGu9nOGOegUg2@duo.ucw.cz>
 <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
 <ed6f49c8-d47c-4cf9-889a-76f6886e1a86@linuxfoundation.org>
 <aIXsYh9afmTxiqXF@duo.ucw.cz>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aIXsYh9afmTxiqXF@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/25 03:07, Pavel Machek wrote:
> On Thu 2025-07-24 13:18:16, Shuah Khan wrote:
>> On 7/17/25 10:32, Shuah Khan wrote:
>>> Hi Pavel,
>>>
>>> The Code of Conduct Committee holds these conversation privately
>>> with the people involved. Looks like you cc'ed the mailing list.
>>> Respecting your choice, we can continue this conversation publicly.
>>>
>>> Chose one or all of these threads to apologize to the developer
>>> directly.
>>
>> If you haven't already done so, chose one or all of these
>> threads to apologize to the developer and cc code of conduct list.
>>
>>>
>>> https://lore.kernel.org/all/aG2B6UDvk2WB7RWx@duo.ucw.cz/
>>> https://lore.kernel.org/all/aG2ClcspT5ESNPGk@duo.ucw.cz/
>>> https://lore.kernel.org/all/aG2BjYoCUYUaLGsJ@duo.ucw.cz/
>>>
> 
> Please clearly state what committee believes I did wrong and what
> should I apologize about.
> 
> There are clearly multiple actors behind Sasha Levin email address,
> and one of them is clearly LLM, sending hallucinations to the list.
> 
> Unfortunately, LLM and the human identify them in the same way, as
> "Sasha Levin". I am willing to apologize for the confusion, clearly
> human is human and has ethics, but I'm not the one who caused the
> confusion.

The use of LLMs in the development process and rules about such use
including how to clearly state if LLMs are used in the process is a
timely and important topic. It can be confusing when a developer
doesn't clearly state the LLM use.

However, as you acknowledged here that you couldn't tell if these
patches originated from the developer or not. In which case, there
are several constructive ways to move forward to clear up the confusion.

1. Send response to the patch and hold a constructive discussion about
    the confusion.
      
2. Start a separate thread to talk to the developer privately or publicly
    in a respectful and constructive way.

3. Start a Tech board conversation with the TAB.

You didn't take any of the above constructive approaches. Instead your
responses included personal attacks which are visible to community and
others to see.

The Code of Conduct Committee has determined these are personal attacks.
These are a clear violation of the agreed upon code of conduct which can
be easily remedied with an apology.

- https://docs.kernel.org/process/code-of-conduct.html
- https://docs.kernel.org/process/code-of-conduct-interpretation.html#code-of-conduct-interpretation

> 
> Please explain how to refer to the human being between "Sasha Levin"
> email address.

Assume you are speaking to a fellow developer and ask them to give details
on the nature of LLM use in the patch. It will result in a constructive
conversation for these important topics at hand.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

