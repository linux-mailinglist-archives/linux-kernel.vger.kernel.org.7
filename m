Return-Path: <linux-kernel+bounces-722917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F71AFE0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8FE3B7262
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0AB26CE18;
	Wed,  9 Jul 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUR2g5Ak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945326B750;
	Wed,  9 Jul 2025 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044253; cv=none; b=u8DARMv9e7BfAr4s6vPBPPnWoJOeFaKWE9eJ8IRMQ7sCmf00AXf92AgeB4h3We/2P1GuKBT8qjLhZVF29QrlsxpG8qI1fQ6ekNby5gdi/aL4RbM+BNzwn1RCfdwnXPxPTmIf5ULpR3Cy8DaDBp8sAIStLXXfqcSjydxpRU9C7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044253; c=relaxed/simple;
	bh=rtYRw+LTgfTwBVULhsU7xwpSnhKJzHyXcNVWLIZtrmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwBb12OIP9llRwS3oI3mk41NtaY07TtBIM1B6ePY5Vaci3mQFplb37BrHEn/QMlRbfmD88S71krTQ8A8T7r1LCsZDdNP5fhy/thZNOQOa9lyXpXyTTZQ0Rfr/Zr1klJYAi2UbjfHJpdprEf3U+UVg6vrd2SnnorCt+TcYSOKYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUR2g5Ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08D7C4CEF0;
	Wed,  9 Jul 2025 06:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752044252;
	bh=rtYRw+LTgfTwBVULhsU7xwpSnhKJzHyXcNVWLIZtrmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pUR2g5AkzJwUSMAEYZF+t+qEIU17RWnTIFcNOnRVSaWdF4EaAsafrtQ36Vc2AV0bx
	 TioOSo2xa/1NuJWIjoilvtYw4HDyIYr8F8CXrYVpMOQlgAWg6jMSA3UA/xL3pVwDK9
	 VKGi882MfVzRCwVXWbqHFvqf2vWsMypk1nH3c7VqAk5uvN6SgckPu2DcRjzUl3RL1x
	 FljHl9lz/RyWZcmP+XVbr4b6rc6PqzEf3cI5KkRQi3Yx8EZewsbXtRYtbz8ofv7OMD
	 0CebwbpsFDSvx7zf+c4lSCcC71OxMgEmmTkP7UmDWtg/7U+lpb5AJHE3D0GtKTkJAS
	 XZ6hf0x9SiJaA==
Message-ID: <738c1951-afbc-4cda-a16e-54a5055ca7c8@kernel.org>
Date: Wed, 9 Jul 2025 08:57:26 +0200
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
 <8b8a58f0-9e18-47d6-8382-1d16d630ea15@kernel.org>
 <dff1a4d6d97d7d3d55c4bd409780d2857ae070ca.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <dff1a4d6d97d7d3d55c4bd409780d2857ae070ca.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/07/2025 08:05, Hailong Fan (范海龙) wrote:
>>
>> OK, this is a valid argument, however we still try to unify the
>> inputs
>> so bindings can share such pieces. It is discouraged to have similar
>> devices with different bindings in only one place: clk26m -> clk27m
>> or
>> whatever other number.
>>
>> Common is also to name the clock input based on the purpose (like
>> bus, ref).
>>
>>
>> Best regards,
>> Krzysztof
> 
> On the MediaTek platform, the main SoC clock sources are typically 32K,
> 13M, and 26M. This is why the terms clk32k, clk13m, and clk26m are
> used.
> Specifically, clk26m refers to the system’s 26 MHz clock source.
> The clkxxx naming convention is intended to indicate that these are SoC

But it should nnot.

> clock sources, while also distinguishing between different clock
> frequencies.
>  
> Therefore, using other terms could potentially cause confusion.

No, you don't understand. This device receives some main PLL or ref
clock. That's the only important information in the name, not its
frequency..

>  
> For example, the ADSP clock sources are ADSPPLL(800MHz) and
> clk26m(26MHz).
> On other platforms, the definition of clk26m in the Device Tree Source
> (DTS) is as follows:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/mediatek/mt8188.dtsi#n328
> The mt8196 platform uses the same design.

So you add poor code, because previously Mediatek added more poor code?
What sort of argument is that?


Best regards,
Krzysztof

