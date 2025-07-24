Return-Path: <linux-kernel+bounces-743762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37BB102F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E997D3B3D00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437EE26FA5A;
	Thu, 24 Jul 2025 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsKqa4TU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B62272E43;
	Thu, 24 Jul 2025 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344583; cv=none; b=VZ65HRAdczEzkXMhci8i8wRfSdpgOrZxV5GGO2p5EN6Q0WpRIch+bS0jhHmZyA3yU6UN80KHvVlv1+7Iu8Gqe/tYsGB/0xUYzvhoK+a+ws6nYPuHp1yRd5VS96xdJk+VX8TwUyOFhOPBHNWevW2kcPVICtd2QF8g0ZUqLQNh004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344583; c=relaxed/simple;
	bh=J+e0/YX5TuvDUu7nG/EdllqV7j18ePW7fJkME0Q1od4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR4mhIGgGieQO+qVQUqI9FOVhlK4yz5POf4YvJnI3oaRGxUPv/nLB5j8nhek4lztmZawNdvzxdaR8KFoU9xwt1oTpaF82xW9dyj0pVxa9AeX0lwskckUuFyjJijB3UFXztZELvEZxsGPPUDDeptdNwQQUMYCjqEWBiF3eJG29rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsKqa4TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E82C4CEED;
	Thu, 24 Jul 2025 08:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753344581;
	bh=J+e0/YX5TuvDUu7nG/EdllqV7j18ePW7fJkME0Q1od4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PsKqa4TUSqX2xZA+/s3g1TpdFihf1LAPkHvDh5ndkl7O1//kxXR6obuNhx8jaDV/o
	 LLPCkP73OdYsUiio/Y1U3z+HHI0w597M8Gph4poSbSo6yUfLZTSiR2LAo6oag/HSuH
	 j/B81eLfl8XpDn7ySic1hDfyFuGiI7IZ8UtUlrg0XLxwUPg2g/BEGAX2o+JaI1Vc+E
	 dIQ/uSCY61i3tqHO5GDI3HpcuY0cqPdlrCquuXs/iWoYWCOJAkRFT8NquWs9ZDYfzF
	 ik6sc5Wl1kImszdja9X70QD39/e+hDViTaNfqGkRVh0aVY0pu9gyTylSghdDrvXjlK
	 FzEBvW9rIdEAA==
Message-ID: <1e9de035-9d32-45d1-9f11-33c3439143be@kernel.org>
Date: Thu, 24 Jul 2025 10:09:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
 <20250521063347.31578-3-friday.yang@mediatek.com>
 <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
 <7421d8f4f3d5fdb392f46df93bfee21a97cc2e1c.camel@mediatek.com>
 <633ea291-2e02-44be-bd03-220634b3c62d@kernel.org>
 <d7e6e9f9da7adf5c806f29c577f6bf51b35fdeed.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <d7e6e9f9da7adf5c806f29c577f6bf51b35fdeed.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/07/2025 09:59, Friday Yang (杨阳) wrote:
> On Thu, 2025-07-24 at 09:08 +0200, Krzysztof Kozlowski wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 24/07/2025 03:49, Friday Yang (杨阳) wrote:
>>> On Thu, 2025-06-12 at 17:16 +0200, Krzysztof Kozlowski wrote:
>>>> External email : Please do not click links or open attachments
>>>> until
>>>> you have verified the sender or the content.
>>>>
>>>>
>>>> On 21/05/2025 08:33, Friday Yang wrote:
>>>>> From: "Friday Yang" <friday.yang@mediatek.com>
>>>>>
>>>>> To prevent handling glitch signals during MTCMOS on/off
>>>>> transitions,
>>>>> SMI requires clamp and reset operations. Parse the reset
>>>>> settings
>>>>> for
>>>>> SMI LARBs and the clamp settings for the SMI Sub-Common.
>>>>> Register
>>>>> genpd callback for the SMI LARBs located in image, camera and
>>>>> IPE
>>>>> subsystems, and apply reset and clamp operations within the
>>>>> callback.
>>>>>
>>>>> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
>>>>> Reviewed-by: AngeloGioacchino Del Regno <
>>>>> angelogioacchino.delregno@collabora.com>
>>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>>
>>>> You did not respond to previous review. Sending the same while
>>>> ignoring
>>>> previous review is obvious NAK.
>>>>
>>>
>>> Apologies for missing the message. In the v6 patch, I replaced
>>> 'pm_runtime_enable' with 'devm_pm_runtime_enable'. You pointed out
>>> that
>>> this change might alter the cleanup order and potentially introduce
>>> errors.
>>>
>>> v6:
>>>
> https://lore.kernel.org/lkml/20250408033206.12176-3-friday.yang@mediatek.com/
>>>
>>> Therefore, in the v7 patch, I reverted this change and continued
>>> using
>>> 'pm_runtime_enable' in the SMI driver. However, I did not include a
>>> clear description of the changes between v6 and v7 in the cover
>>> letter.
>>>
>>> v7:
>>>
> https://lore.kernel.org/lkml/9f01a9a4-89b2-4bfc-97cd-827be989ef16@kernel.org/
>>>
>>> In the v8 patch, I have added a description in the cover letter.
>>> This series just add functions for SMI clamp and not change
>>> anything
>>> else. Is this acceptable to you?
>>
>> That was month ago. Nothing form this thread is in my memory, nothing
>> is
>> in the mailbox. There is no cover letter to find anymore.
>>
>> Anyway, you did not respond to the actual comment and you send the
>> same.
>> Now you respond... to something else still ignoring the comment about
>> fake tags.
>>
>> I will not be wasting more time on this patchset.
>>
> 
> Changes v7:
> - Remove the 'devm_pm_runtime_enable' change.
> 
> Above is the tag you ask. You are right, the 'devm_pm_runtime_enable'
> tag I mentionded in the patchset v6 is truly a fake tag. So please

This is a function. Not a tag. I asked about tag.

> ignore this tag. What I intended to explain here was that I decided not
> to use 'devm_pm_runtime_enable' to replace 'pm_runtime_enable'
> functions. Unfortunately, the fake tag didn't explain this clearly in
> the changelog, which was my fault. To address this, I updated patchset
> v8 to include an explanation.
> 
> In patchset v6, I replaced 'pm_runtime_enable' with
> 'devm_pm_runtime_enable'. However, in patchset v8, I reverted this
> change and included the reason for this decision in the changelog.
> Apologize for the delay and the trouble again.

Nothing above is related to my question about the
fake/invented/questioned tag.

Best regards,
Krzysztof

