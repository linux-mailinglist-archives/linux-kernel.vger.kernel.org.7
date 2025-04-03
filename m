Return-Path: <linux-kernel+bounces-586830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29146A7A477
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CC1174BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031824EA81;
	Thu,  3 Apr 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aS1J+6In"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7924C08D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688735; cv=none; b=YB+bSqcVJmqLI9KoTBUfMMuI2KxiOlEb6aOGQWnlmFUYIplQgCpgy9cj8Nq6z5ofKWfHDmKilNXkaOSkZ8qDQYU4gQXoEekc7in6TEHcGRwlyGW0BwH28eRjXlJjcwt9iE71/WJHKf596MJHftKFvcQa9lxRDGNDCxKbJmxajaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688735; c=relaxed/simple;
	bh=A+Lel6IHf1SA7pqmYqtp68uK+wMFVZXoOP4AoaCI5+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlVpKx1O1jg5CyFs7FiB9HFz652yUJOsknp/aWLbDvr7p3v9O4PtK1KDAhmfGHMny8LfhPdqyCZ0JGKdlzW7xTtETrYzy4uj9JdYgRTvMTVBHVSxnfanJG3VnxYt+b+7K1OHccW/H4RKsEx0XkYq47I8ohQ9ajxjAbMug19bZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aS1J+6In; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so14794555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743688732; x=1744293532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xputbu+L50TVmPeLZA4wC/2iYu4yZ1vw4fcvrK0E968=;
        b=aS1J+6In8SIZTu40UTVD7quWlEcJVyOaGUcvKRsGbn9rES9ewSWeqc9c7UJHMQX8bA
         AUG8ev+VByGy7cKkungPUVmNusudYrFtgapRQI3J/TggSFGFhXzddzLrMqNdk3AtatxT
         SLkl2TVQfSbznvT/dwVU/akmUe+wEgRvm9I9JHxscNbqNHzdBqZqhf/aH+DZvmx8t1HU
         Djda+DcvXz5bg82QwvOysxTFGQL7Ix/QH1Y07rc2571B+fQii+TMralyhLDPTxWRTSiY
         X5grAUxTx0VMiWptncwwk5mw/MNwdnizekoZTOrXp876qAL8Hayiy+RJkphZdgyLTU4i
         sEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743688732; x=1744293532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xputbu+L50TVmPeLZA4wC/2iYu4yZ1vw4fcvrK0E968=;
        b=TI5VGAYFHNilLeByDud+Iz1A5PKLfp1kO5xzIJDiOuqsV4MVTErqDSZJo502IFVw2c
         Vpp2WfQun0XpNBsGKeKq5Ne778AWPBIhZjDEkvO/lVnbJF6arVINgbzxOtdxwYA6SQKy
         XQxU3Yl9kSh7RJkEPY/mmMw7qCE4SOwwsoDNq61jKocNnIdP6RWG4Nqzpt/0JkT0iDsL
         UNYplJKsLBTwJo1c7NjzYrkCHe0olymjktsiPA4CwF/aN8FbNpI5RT3os5VzFvdwiVGR
         4bCSYkldW6Tyi/dtG8HszpbrpWpk9KgMTzrfpgsLEva6PhrgI3QgAPoQNWMQDabKR2P5
         h+9w==
X-Gm-Message-State: AOJu0YzeV75m5jd53KtDHkh3T/Ikx0ZJGXPXQfNxcVTQKuZ9Gk2KA9hD
	Nha51a1M1+SkN0gbq1i3QQRkC2FxYLZMDP03OsFKUuWWHBmURBiOkCZDDP+W5B8=
X-Gm-Gg: ASbGncur+oFHAcgu2LCT+6/uR2n3BsGFO3DQW7HLDi1TEnaBTGIVWmEoutb+3/jHvs+
	UlimjOaYgD9NZ63dHfLdqxKK/zR2Onyq0dV/YKe83+Y4h95E8WmTnDkWLJcUP3UHjXN3VOAY15L
	OpRNEVGl81R6sHo3g0Y2ZcnzJydv5TBCqMWx0BPlxTLuEnbdFSp+Bx/d3CLqpYHOfk0PFrjL5uD
	TTi1iwUDdGw1bshaZNhbgBpSc8LysZhWyGZ8xaNCEMN4NvfXdfEJH2itUOgQgcL51XLbXLsEELH
	c5YtVhBbhFDYlfY/Hv0WpKfYBf6J/CTlT6QMhvTeSW1/1z9MMzqqmR9dVAJMsMI=
X-Google-Smtp-Source: AGHT+IF0twF+XfQ6I0zawjZ9LR3YXzzzbsfSkujpWeLdNuazgB1Cz7ouIQG+MqGXymikjZvbz4gzwA==
X-Received: by 2002:a05:600c:1ca3:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43ebeed6dd4mr33206165e9.7.1743688731755;
        Thu, 03 Apr 2025 06:58:51 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020d62fsm1898773f8f.79.2025.04.03.06.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:58:51 -0700 (PDT)
Message-ID: <32a5a804-21ae-4555-94c2-9835a86f0a7d@linaro.org>
Date: Thu, 3 Apr 2025 14:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] nvmem: patches (set 1) for 6.15
To: Greg KH <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
 <2025040143-espionage-poison-2345@gregkh>
 <47a3a851-f737-4772-87c6-98613347435c@linaro.org>
 <2025040230-showoff-spray-ac83@gregkh>
 <283ac88b-c8d4-47c8-9ff7-935770eca566@linaro.org>
 <b6e7abf3-b263-410a-8f4c-eb9a8e2efa2b@oss.qualcomm.com>
 <e8c91706-1a94-4e3d-b2a9-9d670021bbc8@linaro.org>
 <CAO9ioeVYYy-10ZBmNLMzZK2+mZ5mKf_ZtGwRVf__Dg8GA=Sf0Q@mail.gmail.com>
 <56cbe0a0-048e-45a2-87f2-e2515c7e7414@linaro.org>
 <139a5c4c-b984-4e32-aefb-81dfce2ea0af@oss.qualcomm.com>
 <2025040347-isolating-eastcoast-bfea@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2025040347-isolating-eastcoast-bfea@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/04/2025 14:52, Greg KH wrote:
> On Thu, Apr 03, 2025 at 12:38:03PM +0300, Dmitry Baryshkov wrote:
>> On 03/04/2025 12:35, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 03/04/2025 10:31, Dmitry Baryshkov wrote:
>>>> On Thu, 3 Apr 2025 at 12:27, Srinivas Kandagatla
>>>> <srinivas.kandagatla@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 03/04/2025 10:25, Dmitry Baryshkov wrote:
>>>>>> On 03/04/2025 12:18, Srinivas Kandagatla wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 02/04/2025 12:31, Greg KH wrote:
>>>>>>>> On Wed, Apr 02, 2025 at 09:19:17AM +0100, Srinivas Kandagatla wrote:
>>>>>>>>> HI Greg,
>>>>>>>>>
>>>>>>>>> On 01/04/2025 20:18, Greg KH wrote:
>>>>>>>>>> On Sun, Mar 09, 2025 at 02:56:50PM +0000,
>>>>>>>>>> srinivas.kandagatla@linaro.org wrote:
>>>>>>>>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>>>>>>>>
>>>>>>>>>>> Hi Greg,
>>>>>>>>>>>
>>>>>>>>>>> Here are few nvmem patches for 6.15, Could you queue
>>>>>>>>>>> these for 6.15.
>>>>>>>>>>>
>>>>>>>>>>> patche include
>>>>>>>>>>>       - updates to bindings to include MSM8960, X1E80100, MS8937,
>>>>>>>>>>>         IPQ5018
>>>>>>>>>>>       - add support to bit offsets for register strides exceeding
>>>>>>>>>>>         single byte
>>>>>>>>>>>       - add rockchip-otp variants.
>>>>>>>>>>>       - Few enhancements in qfprom and rochchip nvmem providers.
>>>>>>>>>>
>>>>>>>>>> Ok, I wanted to apply these, and tried to, but they fail horribly
>>>>>>>>>> because:
>>>>>>>>>>
>>>>>>>>>> Commit: 1b14625bd6d4 ("nvmem: qfprom: switch
>>>>>>>>>> to 4-byte aligned reads")
>>>>>>>>>>       Fixes tag: Fixes: 11ccaa312111 ("nvmem: core: verify cell's
>>>>>>>>>> raw_len")
>>>>>>>>>>       Has these problem(s):
>>>>>>>>>>           - Target SHA1 does not exist
>>>>>>>>>> Commit: a8a7c7e34093 ("nvmem: core: update raw_len if the bit
>>>>>>>>>> reading is required")
>>>>>>>>>>       Fixes tag: Fixes: 11ccaa312111 ("nvmem: core: verify cell's
>>>>>>>>>> raw_len")
>>>>>>>>>>       Has these problem(s):
>>>>>>>>>>           - Target SHA1 does not exist
>>>>>>>>>> Commit: d44f60348d8c ("nvmem: core: fix bit offsets of more than
>>>>>>>>>> one byte")
>>>>>>>>>>       Fixes tag: Fixes: 11ccaa312111 ("nvmem: core: verify cell's
>>>>>>>>>> raw_len")
>>>>>>>>>>       Has these problem(s):
>>>>>>>>>>           - Target SHA1 does not exist
>>>>>>>>>
>>>>>>>>> Looks some of your scripts or b4 is picking up
>>>>>>>>> older version v1 of the
>>>>>>>>> patchset
>>>>>>>>>
>>>>>>>>> None of the above patches have Fixes tags in the V2 patches that I
>>>>>>>>> shared
>>>>>>>>> aswell as patches in linux-next.
>>>>>>>>
>>>>>>>> Yes, that looks odd, it looks like b4 pulled in the
>>>>>>>> wrong series, yes.
>>>>>>>>
>>>>>>>
>>>>>>> Even that looked incorrect, as the v1 series only had one
>>>>>>> patch("[PATCH 12/14] nvmem: make the misaligned raw_len non-fatal")
>>>>>>> that had fixes tag. Not sure how these 3 patches are tagged as fixes.
>>>>>>>
>>>>>>>> But, that's even worse.  Those "fixes" are now not actually marked as
>>>>>>>> fixes of the previous patch.  So that information is
>>>>>>>> totally lost, and
>>>>>>>
>>>>>>> Its because this patch("PATCH 12/14] nvmem: make the misaligned
>>>>>>> raw_len non-fatal") is taken as fixup patch and wrapped into the
>>>>>>> original patch ("nvmem: core: verify cell's raw_len"), Also the sha
>>>>>>> will not be valid for linus or char-misc tree.
>>>>>>>
>>>>>>>> again, the first commit here, "nvmem: core: verify cell's raw_len" is
>>>>>>>> broken so much that it took 3 other changes to fix it, which implies
>>>>>>>> that bisection would cause problems if you hit it in the middle here.
>>>>>>>>
>>>>>>>
>>>>>>> All the patches related to this are enhancements to nvmem core to
>>>>>>> allow specifying bit offsets for nvmem cell that have 4 bytes strides.
>>>>>>>
>>>>>>> Specially this check is also an additional check in core to make sure
>>>>>>> that cell offsets are aligned to register strides.
>>>>>>>
>>>>>>>> While fixing patches is great, and something we do
>>>>>>>> in the tree all the
>>>>>>>> time, let's not purposefully break things and then fix them up in the
>>>>>>>> same exact patch series please.  That's just sloppy engineering.
>>>>>>>>
>>>>>>>> Please redo this series completely.  I can take the
>>>>>>>> "new device support"
>>>>>>>
>>>>>>> I can send them but its going to be exactly same series, I dont think
>>>>>>> anything will change as all of these patches are enhancements and
>>>>>>> there are no fixes.
>>>>>>>
>>>>>>> I hope this clarifies a bit, Please let me know if you still want me
>>>>>>> to resend this series, which is going to be exactly same.
>>>>>>
>>>>>> I think Greg is asking to squash the fixup into the relevant patch.
>>>>>
>>>>> Its already squashed up in v2.
>>>>
>>>> Then there should be no Fixes tags. Is the series that you are sending
>>>> visible somewhere?
>>>
>>> Yes, there is no fixes tags in v2 series,
>>>
>>> Here is what is sent to as v2:
>>> https://lore.kernel.org/lkml/47a3a851-
>>> f737-4772-87c6-98613347435c@linaro.org/T/
>>> #r01449e17cf6f9396967a822a0460ad4b1245e914
>>
>> LGTM, thanks. Then I don't understand what is causing the controversy from
>> Greg's side. The only piece of information that got lost is that Mark has
>> found an issue with the previous version of the patch (I'd have added that
>> information between the tags as you've squashed the patches).
> 
> Yeah, I'm confused here as well.  In v1, there were 3 patches that were
> marked as "Fixes" for a previous patch in the series.  In v2, no Fixes
> were marked at all, BUT the patches were still in the series.

In fact there was only one patch with fixes tag in v1, not sure if b4 
picked up 3 which is the part that confused me too.

> 
> So what went wrong?  Was the v2 version of the original patch changed so
> that the 3 other ones were not needed somehow?  If so, why were they in
> the list again?

I have captured that in cover letter:


Changes since v1:
  - Merged fixup "nvmem: make the misaligned raw_len non-fatal" into
   "nvmem: core: verify cell's raw_len"


> 
> Anyway, I'm confused...
> 
> Please send a v3 of this series, NOT in response to any email thread so
> that b4 does NOT get confused in any way, and I'll be glad to review
> them and apply them to the proper branch after -rc1 is out next week or
> so.

I will send v3.
thanks,
Srini
> 
> And document the heck out of what has changed in the series in the
> different patches please.
> 

> thanks,
> 
> greg k-h

