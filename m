Return-Path: <linux-kernel+bounces-779826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A362B2F956
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F24614E600B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB43218A9;
	Thu, 21 Aug 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8eGLnw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508A31E105;
	Thu, 21 Aug 2025 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781571; cv=none; b=UxttbEqIQBTu4UHXIz3HLDs9TiP3l811sNqpyzrm4JRNOJcTr6+WIiskHa3a2iQhpshGA7gOZFEtuCRzGe7eamsKQCeiCu0kZadRnCCeQWY7bCG/KoI1oCSlvZcWC8E26Fg6kS97isuBO7fwXSzWXQebu2yip8K/qx25+KLjcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781571; c=relaxed/simple;
	bh=gRwq2s/V2iE6bhB3OOT7BCHt4ZxoyBZq2/8tIc8uFrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSNEURYLHZMgV6h7eAYcX69xK6ArG/H7Jgql2BgKfEeeISIdr+FdbUvkTF8d3P1ltcB8YJGQC4dKM7G11l3K7OILf+uiqn9JKuQxlbFIDv5lnZRgDk14xuqRZhZ/Qcx4sN0DHY2IkGA5C9M+G7iIq5EHFnHTLPGQ5ETAIpIT2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8eGLnw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55E9C4CEEB;
	Thu, 21 Aug 2025 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755781571;
	bh=gRwq2s/V2iE6bhB3OOT7BCHt4ZxoyBZq2/8tIc8uFrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o8eGLnw6hM3k1j8cqMWWe/72qKOeiA/0/SKtmpr6s9mTYjmanUScwq/pyEjyb6biF
	 V61CCyvLJRZzLAclm7QvWElEwcvtB6redG/PFTKx3FMTmrJh6Rgv5QzvFTNnp3aTJh
	 aw0l9rTm0cUL1IBvbzF/OSgLy8oRQEpyonnYd+tJkSVttqj+VcE4RrzgIBv1ZQ0Tef
	 i9Jq7ETN0LyMIbJy/6oBwF8NSkknsWPWz74Z7ltIY6ZZANIa4R+uMdyXaAm4sZkMci
	 RBR/L0EbidrqxO2+rfK2HJOF/DbwfK00wmlsai+915ro7hL3io27ThbojBIG7Y4utH
	 PpoBKjVdfv1Zg==
Message-ID: <86ca694c-a034-4291-a2ce-303895522156@kernel.org>
Date: Thu, 21 Aug 2025 08:06:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: amd: acp: Adjust pdm gain value
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250821054606.1279178-1-venkataprasad.potturu@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250821054606.1279178-1-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/2025 12:45 AM, Venkata Prasad Potturu wrote:
> Set pdm gain value by setting PDM_MISC_CTRL_MASK value.
> To avoid low pdm gain value.
> 
> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
> ---
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Changes since v1:
> 	- remove pdm gain adjustment using module parameter.
> 
>   sound/soc/amd/acp/amd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
> index cb8d97122f95..73a028e67246 100644
> --- a/sound/soc/amd/acp/amd.h
> +++ b/sound/soc/amd/acp/amd.h
> @@ -130,7 +130,7 @@
>   #define PDM_DMA_INTR_MASK       0x10000
>   #define PDM_DEC_64              0x2
>   #define PDM_CLK_FREQ_MASK       0x07
> -#define PDM_MISC_CTRL_MASK      0x10
> +#define PDM_MISC_CTRL_MASK      0x18
>   #define PDM_ENABLE              0x01
>   #define PDM_DISABLE             0x00
>   #define DMA_EN_MASK             0x02


