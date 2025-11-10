Return-Path: <linux-kernel+bounces-893151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF516C46A33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 239904EB0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83630BB9E;
	Mon, 10 Nov 2025 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXwQMhzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B21DF258;
	Mon, 10 Nov 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778290; cv=none; b=FlUTp5WBjPxbxbsnE3/BmlOrFbD82lYCdoBTp3JGD40zRCKzrCjImJwLUP+3YmmHqC0gpzW+yCSLUF3WsdLxw5SSqVI5jsNeErlHZLyngNXUQLiW+gdd6cW3QKRq6Ud7f24IbpGTjW3/yBjHYYK/SwWZmOh0HVbrkY6uIy0FfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778290; c=relaxed/simple;
	bh=wekb0ApdWzJSX22h4xGJyCFoadtEjo1qoJp5BxzeNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MBH2NoZmwloEi62PcsZQ/S3eIarykuMi2C5KdLv0m1se2t/kOpLD+kIhPsqn12kK+Jcg6tOH2u8qZ7b/llTU3h+mloAMFDwlr5IeUMRBAYjbw8Xpol+DJu0j8SPoX9foo/pE2MiTWtjFtsiigmcvvx5f2b4Cw9Y+eYEVvqzWjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXwQMhzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5082C116B1;
	Mon, 10 Nov 2025 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778290;
	bh=wekb0ApdWzJSX22h4xGJyCFoadtEjo1qoJp5BxzeNk4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JXwQMhzXKBt19/EwUybFvmDfu8qaKbTpIHMOLvbQllFp5+ppQUblOgQAIYZmrvnpd
	 VzND5Yx4rPuRzYnCG+jPzjWNFLyZmXgnaFqavuYjypMqPEzNlfcnOn4k2JRbhQ6VcI
	 O493U4ck/x4DxP7cCs9YKjmK9XdSU5dSmjev3HGDptAJuyQdiil7jQEbydPa6WoVka
	 Z5/eQtA+GQOdfJmr5WnxqOWSu4TGz9J7Q71Y5cEybhb8XXteCeBYgJ13/5XAUHotQl
	 sjf8cZCi//ZyBhZ3vmc3/v2QJCmMHsYHD1xtHffOuYGT1hzRgTfooiUWgiGXAA/mTh
	 f3DafCsFZtJpA==
Message-ID: <39ae7079-3dcc-43a5-812b-a6c2b015270d@kernel.org>
Date: Mon, 10 Nov 2025 13:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: intel: Add Agilex3 SoCFPGA board
To: Dinh Nguyen <dinguyen@kernel.org>, niravkumarlaxmidas.rabara@altera.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <51ecc7f4eb7e419c00ee51fc26156e25686dfece.1762756191.git.niravkumarlaxmidas.rabara@altera.com>
 <1c879d71-a4a5-4241-a0db-bfd2c61bf32c@kernel.org>
 <03d6086f-0a84-4cca-b668-5b8902cd866f@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <03d6086f-0a84-4cca-b668-5b8902cd866f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2025 13:36, Dinh Nguyen wrote:
> 
> 
> On 11/10/25 01:53, Krzysztof Kozlowski wrote:
>> On 10/11/2025 07:47, niravkumarlaxmidas.rabara@altera.com wrote:
>>> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>>
>>> Add compatible for Agilex3 SoCFPGA board.
> 
>>>
>>> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> index cf7a91dfec8a..e706c4eff019 100644
>>> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
>>> @@ -21,6 +21,11 @@ properties:
>>>                 - intel,socfpga-agilex-n6000
>>>                 - intel,socfpga-agilex-socdk
>>>             - const: intel,socfpga-agilex
>>> +      - description: Agilex3 boards
>>
>> Agilex3?
>>
> 
>  From what I understand, the Agilex3 is the same chip as the Agilex5, 
> minus 2 CPU cores. So I recommended to Nirav, just to add the binding in 
> the Agilex5 context.

If that is not the same die, then probably should have still agilex3
compatible (you still can have fallback).

> 
>>> +        items:
>>> +          - enum:
>>> +              - intel,socfpga-agilex3-socdk
>>> +          - const: intel,socfpga-agilex5
>>
>> Or Agilex5? Decide. Cannot be both.
>>
>  From the explanation above, could we document the agilex3 socdk this way?
> 
> Thanks,
> Dinh


Best regards,
Krzysztof

