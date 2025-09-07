Return-Path: <linux-kernel+bounces-804713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A76B47BED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A138F17C8DB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A06627B341;
	Sun,  7 Sep 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhS44Phk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EE17A2EA;
	Sun,  7 Sep 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257646; cv=none; b=DykQbjU8/MrKDunQKPLF5dy2+fMNQrRIpg54wSHYoTQ3LQ2Mb+tDAzRB+LDCGbkXDkYbxP8KXDGkfSG0v1v+WljT8iRCB2uNPgeRmFsWO9OlQzBUrmPhh2Rb5hF81Psr7RqMbV9sTvkUOI+HgBSJoZueVxexiXPbWDBHrK/adoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257646; c=relaxed/simple;
	bh=ViqUPijdU48j18QgsErT7jw2tgGcDvqP1vUDdI0wC7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYk0VsKNXTdcFgd652aUp3mPpaYqQadtiiwHRbkNEW3+qOLi6Ep5ovIxFEMbRbIIEnDlO0eOuuCbbGxA9ZdYaTz6Yvuoc0QQ3KQ8dkPM7yb+cCWizrvC3+HN2895qOW0148dYGTSjIEWoGh01YGzh/+WqYNxAFs3+3I2TnSsi10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhS44Phk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E9AC4CEF0;
	Sun,  7 Sep 2025 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757257646;
	bh=ViqUPijdU48j18QgsErT7jw2tgGcDvqP1vUDdI0wC7M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bhS44Phkh8+SohlZZf8iubue5u0W4Jv5kDD0dhcAZygABtrANgiSY68bsu138z5Wp
	 sUqx1mU7ltdj+zmJUWJcuYCYLxBrYPjt39ZlmjZd/XRd6pGUlL2D3iv2gMQT59orrG
	 IDfCb0d4vJsV10de2fpJhd/lGYqXRG3b5FzhDx4t1V9DsM8r0tJiYFx2lTQYdIKrrY
	 dBP6zaxG47hSuDTkYw21h//YIHco9XG10i8djsSuBebNgBzAq5ht5a+lKWU3RzHzuD
	 9YrH6u/zVPqJSH/j+/S4rbJNhMWXQdeHdm+YXsnkh/RrGf4mff4y0OdP5tSS4Y+/vT
	 NTo2eLZKmGirw==
Message-ID: <49db9339-b2a4-4be5-b0ba-005b3ed493a0@kernel.org>
Date: Sun, 7 Sep 2025 17:07:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: fix typo in documentation Correct a typo in
 the documentation by replacing "abd" with the correct word "and". This
 improves readability and avoids confusion in the description.
To: Nick Huang <sef1548@gmail.com>, Lee Jones <lee@kernel.org>
Cc: Johnsodn Huang <kusogame68@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250902142749.13724-1-kusogame68@gmail.com>
 <20250903074205.GB2163762@google.com>
 <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CABZAGRHSVY3uneK7qb2nwDrjjRsLXzsm0mwQncU1iRZac6tAkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/09/2025 15:38, Nick Huang wrote:
> Lee Jones <lee@kernel.org> 於 2025年9月3日 週三 下午3:42寫道：
>>
>> Looks like you corrupted the subject line with the commit message.
>>
>> Please resubmit.
>>
>>> From: Johnson Huang <kusogame68@gmail.com>
>>
>> Use `git format-patch` and `git send-email` instead.
>>
>>> Co-developed-by: Nick Huang <sef1548@gmail.com>
>>> Signed-off-by: Nick Huang <sef1548@gmail.com>
>>> Signed-off-by: Johnson Huang <kusogame68@gmail.com>
>>
>> It took two of you to correct the word "and"?
>>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>>> index d783cc4e4e..d16c82e398 100644
>>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>>> @@ -41,7 +41,7 @@ properties:
>>>    clock-output-names:
>>>      maxItems: 1
>>>
>>> -# The BD71847 abd BD71850 support two different HW states as reset target
>>> +# The BD71847 and BD71850 support two different HW states as reset target
>>>  # states. States are called as SNVS and READY. At READY state all the PMIC
>>>  # power outputs go down and OTP is reload. At the SNVS state all other logic
>>>  # and external devices apart from the SNVS power domain are shut off. Please
>>> --
>>> 2.43.0
>>>
>>
>> --
>> Lee Jones [李琼斯]
> 
> 
> This patch was sent by Johnson Huang on my behalf.

The From is malformed then. There is no single reason to change it.

> If only one person should sign off, I have already discussed with him
> and will keep only my own Signed-off-by.

For simple one letter typo? And then you sent three patches one-per-fix,
which is way too much churn.

Best regards,
Krzysztof

