Return-Path: <linux-kernel+bounces-722918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E66D0AFE0A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65211C271E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7D26CE15;
	Wed,  9 Jul 2025 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpIWlexs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B378F36;
	Wed,  9 Jul 2025 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044379; cv=none; b=XljwSP6bmFOu3c8Qfgk4VlcHga1bVAmUiireYZD+tb8lbbQscQP2B6HseglSGl9nkb1Hw+5cCFw9UToWmoukrmsn4Vfh7DuWf3GvgaXX7RQLd5wZOa6jRfWXJOzwgRWoZABGRFNSsF3rwhchF066JM9Mk0bfwGyXKXSvTwZ2+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044379; c=relaxed/simple;
	bh=YlqJmXdkohNFHXYMBpBaX+PVFLgGz8jmw+qFDTmc/nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5ITyxSRUF5RsCFdHTWplxpcRf4xfqSzlKlIJz7baeApAq3dA7JpMj/Ncws83pfeCIis4TaS3qLPhr11dMCy0qNbnKKTAzJOKhlC8mT+88b+IowVwE34KHVdjr6rYeE1MtfghTo//QbzrWcwDSAaELLZKf3YFkNICN0EiWepW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpIWlexs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB3EC4CEF0;
	Wed,  9 Jul 2025 06:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044379;
	bh=YlqJmXdkohNFHXYMBpBaX+PVFLgGz8jmw+qFDTmc/nM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bpIWlexsjygi5fpwUefLkBJCyw8+pGqTQavsSu3PUnNkQ7DAAkww/DXagNBPRSvCX
	 EmSylVEJpycqIGB34dJJGmpoU2deRhRAC/PmTVSgAt14BiZ0K88IfviaX0U0vOaEb3
	 4hD9Fsuk7lTnZCjOgsmf4UgcZRRkZoDW5l7kO2Qyir1Afxjvp2Lb1D68hotDPW9181
	 uFxlULKicrO+nlngPaQL1A8h0upF9Ndzwzbglv2zUzInxDfEOdX6Hrk/X6ZLieMrbl
	 hPeSlF2Y0gU6l6jWySsmKr9Wq2/Dxh+8KpxwgZUhuX5HIb46bkdo0jJn4+W4IIT4P9
	 SNQvHFzTB8Vjg==
Message-ID: <fa1b8e02-deee-44e5-a6c6-52394fc071a4@kernel.org>
Date: Wed, 9 Jul 2025 08:59:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
To: =?UTF-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
 "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
 <tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "sound-open-firmware@alsa-project.org"
 <sound-open-firmware@alsa-project.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
 <20250703075632.20758-2-hailong.fan@mediatek.com>
 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
 <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
 <85ca4ceb29caec9acbe77a3d67e3bc57b0b0aeb5.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <85ca4ceb29caec9acbe77a3d67e3bc57b0b0aeb5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/07/2025 08:34, Hailong Fan (范海龙) wrote:
> On Thu, 2025-07-03 at 11:05 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 03/07/25 10:08, Krzysztof Kozlowski ha scritto:
>>> On 03/07/2025 09:56, hailong.fan wrote:
>>>> From: Hailong Fan <hailong.fan@mediatek.com>
>>>>
>>>> This patch adds mt8196 dsp document. The dsp is used for Sound
>>>> Open
>>>
>>> Please do not use "This commit/patch/change", but imperative mood.
>>> See
>>> longer explanation here:
>>>
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst*L95__;Iw!!CTRNKA9wMg0ARbw!g39q48fUCsDJ5PETUtQ0PK0Bkwf0Ce1F_ZzJiEiWMzuybWQ0dSPzblvLlJ-4saWTSoJWuS5imsXbpdgLBvUy4wxw9C5w7B4m$
>>>

Fix your email client not to produce such junk like above ^.

>>>> Firmware driver node. It includes registers,  clocks, memory
>>>> regions,
>>>> and mailbox for dsp.
>>>>
>>>> Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
>>>> ---
>>>>   .../bindings/sound/mediatek,mt8196-dsp.yaml   | 95
>>>> +++++++++++++++++++
>>>>   1 file changed, 95 insertions(+)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/sound/mediatek,mt8196-dsp.yaml
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/sound/mediatek,mt8196-
>>>> dsp.yaml
>>>> b/Documentation/devicetree/bindings/sound/mediatek,mt8196-
>>>> dsp.yaml
>>>> new file mode 100644
>>>> index 000000000000..68f594f476e8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8196-
>>>> dsp.yaml
>>
>> Wrong folder; this should go to dsp/mediatek,mt8196-dsp.yaml ....
>>
>> ...but then I don't get why MT8196 wasn't simply added to
>> mediatek,mt8186-dsp.yaml.
>>
> Yes, the first version was written this way, but the maintainer
> suggested the following, so I'm not sure which approach is more
> appropriate. Could you please provide a final recommendation?
>  
> v1 link: 
> https://lore.kernel.org/all/a72988212d0d95bfe76eb9c53bbdb8c57c989377.camel@mediatek.com/

You linked to your reply. What does it prove? You are the maintainer and
you gave this recommendation for your own patch?

>  
> comment:
>>
>>> ---
>>>  .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 96
>>> +++++++++++++++++++
>>
>> Don't grow dsp directory. Either this is remoteproc or some sound
>> component, so place it accordingly.
> This is a reference to the approach used in a previous MediaTek
> project:
>  
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dsp
> Do we need to move all the files under the DSP directory to the sound
> directory?

No.


Best regards,
Krzysztof

