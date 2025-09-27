Return-Path: <linux-kernel+bounces-835086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B028BA6384
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B8F17FE38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F832367A0;
	Sat, 27 Sep 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sv/eboVV"
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BA4C9D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759007067; cv=none; b=STk5Io/VUR4DK7MjbXRO0XrJUEq6jnaGIku1lds4jE9omAkZ6mjqTU/LgVAerMJzwlosWSdNpLB/42bgv56j1bv3sbTquRxKKZ8lLXejedry0XyLb88pYYo2G7+NvhhPkyTOmWgNwEUMQRQa+cHvDtchFGcTxanog++Q86wZWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759007067; c=relaxed/simple;
	bh=6DUrXw5DoWEcEIwvp4TMjoeI4MQBulV9VLtVwtSyCG8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z1RLB0Y3LZKwfiJ1OLia5Kh2bCZNr1jSZ2tDodtgoCl50SCR3fgIml/7tBNN80mNXsf4kCKPkPMZ7japNFWMOHFQ5PaoEfLivHfQYC7EmG/fu/M8oxvdWZnCg0oZAcYTgYlNCyWFi62ceMi7e89geRcg+kSegNbkxWdFDGD7cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sv/eboVV; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d603acc23so31946307b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759007065; x=1759611865;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oc5vo+Rb9ClONgmTiHxfZM7CLOGpUGWCRjHz3GTHRlQ=;
        b=EulE6gBgrwj39izqMdbxHuDLzIGEuPs/BK7EqzIrh/saFN25Zgi0UMM3Ek11nMWh0I
         0mXFnTCTGwOmBlnuJCNRskWzq4g6+JoINKUA2197G+80V7y1s+Og57FWXenjbVwvSqdk
         BvT4sh9XXB6HuesOnjS/qHUuKLzI3GqzOwtf14uW/XtfKsz+OTWzlmjXGPplL6BLQHXU
         eoCrlIwiFw2YattJXR9IGjA2fYNqfw8E3vTB2eUGXvfN8C5Hi3Tt9LiROXha979LLWDb
         AkfrVQGqDBGv7w9xwl1iRHmAfoAigLxRWDTcaB1JxF+0+Xlx6E5OG/d5FkhQ/uIIkIz1
         LntA==
X-Forwarded-Encrypted: i=1; AJvYcCVJiP4L564g7yBRNeRLgx3G6xofnwnTxtIV+W6EFDwfRV8f+xOZKj9PfU0kFd9Z3UFfau3RMCbfHyogx1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpK/y4ZtItjQG+qTSgjLnpfj4UQnK4NYvE4nTDGZSzTMpLElM
	ufQdxEw35HGFMblvKoQynxA1TTzH0r6oiyIty9U7dHRj984rHzk84j50kTS5VQV8yLbMUwm9nAc
	i8N0o36jyyyOcCfDExrWe3yhpo3UijUhSa3AMy0Tm2P45gi0eND8DifwJK0hxGl+BXIlIGaQfl1
	nCsnltg/dNPwt2ANLjPUpPu3ROnRdx43h+u9L123zQWwSEYgchNhugsLA4f34WyrDTrfEdIpgKR
	e/o+Xzp0F7l3EkfNZyjoR7S
X-Gm-Gg: ASbGnct3vbt2CPM+0owme8bWfbNT+qrsmz80fs4cubSQc70bLC44fwRb4WLDRIPpJiG
	mLwPy5vRw9swOrmxwn2Ox5vhGabwulS4J0Nw/UziWjN5AVnrUhbbqtT49puOSmHyjmMOb2Lgan8
	049hKTfkA9plSFkuB0YacDev3wEQ8bHP20QkNZCGZbQKHUxcu2tkLxFERw3yH4kwoc/ppl9X0FO
	1ohnvLwj7E/ETBysx1zilbZfXgV8/e9r1x/T/o3E+4LhgSEBwzAO7AwmYIlxubZH/up0g78Nrbx
	nFd/V/2VBsdIqvNRt4Xm+31BwsNWosq3yXMUFUxlTWvo7/kJ1HETbZ7EuqSGvv5p2whBBEBtmK2
	0ls7dusM7KB9qaDlZnDX9hE7NyuYDi/Kml1hjXDaVPA/k6oIuKXKUlASn9Aeox+VWpgQ4nu+kA8
	VHcSuHc78=
X-Google-Smtp-Source: AGHT+IFpp/2pWQnSf82uVQsJoKp7MMJf3Nj3+IKU3G+nm57/5BP2xJ5a+Zo9R9juhm8D3hGqRhoio+E7YVfY
X-Received: by 2002:a05:690c:586:b0:749:17fe:9644 with SMTP id 00721157ae682-763f8b4da15mr124060367b3.4.1759007064978;
        Sat, 27 Sep 2025 14:04:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-765cf0f6599sm4042457b3.15.2025.09.27.14.04.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2025 14:04:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3305c08d975so3702770a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759007063; x=1759611863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oc5vo+Rb9ClONgmTiHxfZM7CLOGpUGWCRjHz3GTHRlQ=;
        b=Sv/eboVV0D2rmXYxcpqA1A2vNwHfECB15bL6hMAp43XckKRWHDpI6/G2aVQPyCDG9X
         fgce3MiELIIcu8cJwOfC1ww8MfIl5OU8GbDcErGEQZBOJIDgpO0XfS8Bwl8rRDYnLxlB
         9ojTIXZuFtcLJkV2xvDvr35Q9t1AhI7QJajpA=
X-Forwarded-Encrypted: i=1; AJvYcCXEFKeIUXyK4che1XreE+y0Z9qKoX+7DWZ5GExARLtH02wGLnnMr4cavLkaVatMei+KJo+ntcyqMiz2M7A=@vger.kernel.org
X-Received: by 2002:a17:90b:55c6:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-3342a2bed9dmr11453766a91.18.1759007063471;
        Sat, 27 Sep 2025 14:04:23 -0700 (PDT)
X-Received: by 2002:a17:90b:55c6:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-3342a2bed9dmr11453750a91.18.1759007062992;
        Sat, 27 Sep 2025 14:04:22 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a3afe09sm4481311a91.1.2025.09.27.14.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 14:04:21 -0700 (PDT)
Message-ID: <34478e1c-b3ba-4da3-839a-4cec9ac5f51e@broadcom.com>
Date: Sat, 27 Sep 2025 14:04:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Simon Horman <horms@kernel.org>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <aNbUdweqsCKAKJKl@shell.armlinux.org.uk>
 <a318f055-059b-44a4-af28-2ffd80a779e6@broadcom.com>
Content-Language: en-US
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <a318f055-059b-44a4-af28-2ffd80a779e6@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/26/2025 12:05 PM, Florian Fainelli wrote:
> 
> 
> On 9/26/2025 10:59 AM, Russell King (Oracle) wrote:
>> On Wed, Sep 17, 2025 at 05:31:16PM +0100, Russell King (Oracle) wrote:
>>> On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
>>>> If the "st,phy-wol" property is present in the device tree node,
>>>> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
>>>> the PHY.
>>>>
>>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>>> ---
>>>>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/ 
>>>> drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> index 
>>>> 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
>>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>>> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>>>>       u32 speed;
>>>>       const struct stm32_ops *ops;
>>>>       struct device *dev;
>>>> +    bool phy_wol;
>>>>   };
>>>>   struct stm32_ops {
>>>> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct 
>>>> stm32_dwmac *dwmac,
>>>>           }
>>>>       }
>>>> +    dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
>>>> +
>>>>       return err;
>>>>   }
>>>> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct 
>>>> platform_device *pdev)
>>>>       plat_dat->bsp_priv = dwmac;
>>>>       plat_dat->suspend = stm32_dwmac_suspend;
>>>>       plat_dat->resume = stm32_dwmac_resume;
>>>> +    if (dwmac->phy_wol)
>>>> +        plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
>>>
>>> I would much rather we found a different approach, rather than adding
>>> custom per-driver DT properties to figure this out.
>>>
>>> Andrew has previously suggested that MAC drivers should ask the PHY
>>> whether WoL is supported, but this pre-supposes that PHY drivers are
>>> coded correctly to only report WoL capabilities if they are really
>>> capable of waking the system. As shown in your smsc PHY driver patch,
>>> this may not be the case.
>>>
>>> Given that we have historically had PHY drivers reporting WoL
>>> capabilities without being able to wake the system, we can't
>>> implement Andrew's suggestion easily.
>>>
>>> The only approach I can think that would allow us to transition is
>>> to add:
>>>
>>> static inline bool phy_can_wakeup(struct phy_device *phy_dev)
>>> {
>>>     return device_can_wakeup(&phy_dev->mdio.dev);
>>> }
>>>
>>> to include/linux/phy.h, and a corresponding wrapper for phylink.
>>> This can then be used to determine whether to attempt to use PHY-based
>>> Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
>>> PMT-based WoL if supported at the MAC.
>>>
>>> So, maybe something like:
>>>
>>> static u32 stmmac_wol_support(struct stmmac_priv *priv)
>>> {
>>>     u32 support = 0;
>>>
>>>     if (priv->plat->pmt && device_can_wakeup(priv->device)) {
>>>         support = WAKE_UCAST;
>>>         if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
>>>             support |= WAKE_MAGIC;
>>>     }
>>>
>>>     return support;
>>> }
>>>
>>> static void stmmac_get_wol(struct net_device *dev, struct 
>>> ethtool_wolinfo *wol)
>>> {
>>>     struct stmmac_priv *priv = netdev_priv(dev);
>>>     int err;
>>>
>>>     /* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>>>     if (phylink_can_wakeup(priv->phylink) ||
>>>         priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>>>         err = phylink_ethtool_get_wol(priv->phylink, wol);
>>>         if (err != 0 && err != -EOPNOTSUPP)
>>>             return;
>>>     }
>>>
>>>     wol->supported |= stmmac_wol_support(priv);
>>>
>>>     /* A read of priv->wolopts is single-copy atomic. Locking
>>>      * doesn't add any benefit.
>>>      */
>>>     wol->wolopts |= priv->wolopts;
>>> }
>>>
>>> static int stmmac_set_wol(struct net_device *dev, struct 
>>> ethtool_wolinfo *wol)
>>> {
>>>     struct stmmac_priv *priv = netdev_priv(dev);
>>>     u32 support, wolopts;
>>>     int err;
>>>
>>>     wolopts = wol->wolopts;
>>>
>>>     /* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>>>     if (phylink_can_wakeup(priv->phylink) ||
>>>         priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>>>         struct ethtool_wolinfo w;
>>>
>>>         err = phylink_ethtool_set_wol(priv->phylink, wol);
>>>         if (err != -EOPNOTSUPP)
>>>             return err;
>>>
>>>         /* Remove the WoL modes that the PHY is handling */
>>>         if (!phylink_ethtool_get_wol(priv->phylink, &w))
>>>             wolopts &= ~w.wolopts;
>>>     }
>>>
>>>     support = stmmac_wol_support(priv);
>>>
>>>     mutex_lock(&priv->lock);
>>>     priv->wolopts = wolopts & support;
>>>     device_set_wakeup_enable(priv->device, !!priv->wolopts);
>>>     mutex_unlock(&priv->lock);
>>>
>>>     return 0;
>>> }
>>>
>>> ... and now I'm wondering whether this complexity is something that
>>> phylink should handle internally, presenting a mac_set_wol() method
>>> to configure the MAC-side WoL settings. What makes it difficult to
>>> just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
>>> that could be a "force_phy_wol" flag in struct phylink_config as
>>> a transitionary measure... so long as PHY drivers get fixed.
>>
>> I came up with this as an experiment - I haven't tested it beyond
>> running it through the compiler (didn't let it get to the link stage
>> yet.) Haven't even done anything with it for stmmac yet.
>>
> 
> I like the direction this is going, we could probably take one step 
> further and extract the logic present in bcmgenet_wol.c and make those 
> helper functions for other drivers to get the overlay of PHY+MAC WoL 
> options/password consistent across all drivers. What do you think?

+		if (wolopts & WAKE_MAGIC)
+			changed |= !!memcmp(wol->sopass, pl->wol_sopass,
+					    sizeof(wol->sopass));


Should not the hunk above be wolopts & WAKE_MAGICSECURE?

-- 
Florian


