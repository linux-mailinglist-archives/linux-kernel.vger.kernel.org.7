Return-Path: <linux-kernel+bounces-834561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55DBA4F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D5C3876B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69E2FFDDC;
	Fri, 26 Sep 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZkykOpta"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A71FDA8E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913528; cv=none; b=c0BcsRhSzMWH38qYoQ7PrpL63pEGgTmtBWK8W9hC7fz/KlsU+3TLtM4kpoLaNv7oeMU6q/ZIKIYVHVfY0B5NwulhfkguCvsZJ02Mfl+i070K4JyZvj8EV5b+gvSePXZLuoQdeO1VenFU5lcfpvXjTCq8vnwM09OLk8HdByvA/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913528; c=relaxed/simple;
	bh=9Lt8KDExfVqExqrpI+i6y+c3/qxojx1CeuJiN/abT8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLdl5DnJT5Lk3uJjdgVjesN8HvomIVuUuLfy0IQGy8RJ/oMOnefJMMHRBRz6pHtPbAQND17/OJQvuOYCFsglnAvZJUyJvY7P3QFSoTDPLPLnL3S7t2/nVWwtYisHZO0gFD7J0a7iyT4Sn6iDjEF0Cww3fS7iHO0zE89+GbThowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZkykOpta; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88432e1af6dso168176739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913525; x=1759518325;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dRmwJqq2SxsiFB6VEpR33/U1NputiwE3QM2SDlba7Y=;
        b=e48DlaJsNHCfceApbMzKmXzuE+H3qgddWK27rFLGQYjqvluCLjRDJXLY0UokJ1CUiE
         6SiZoIAjV1pvtHItBlMpXt01mzYGbEOxWnDhE6Nfb+BcvUeDo7QcZ24SREIIKm/Ld8xz
         TLPC2QQbkPYAGA1pX1Qb7avKZQLYhUkDtcFziUl8/TE67DBHDw/n/ga/py6YBlolukth
         QzZUJQxmeucCLkne3h6FdwbgnzUr9VgSnrXqVILI822VeHFB0IpdGNTBzVJHwEDVS1nE
         1uVoTHoTIzbwL+/dZqx0a83cPmVzvTO8sBsKv1ceTQw5/xiLdYcfgCqOErAe50gJeTiH
         RuRA==
X-Forwarded-Encrypted: i=1; AJvYcCV64ZrneRObYl6SH8lgkff1zrBrtzWh5jU5DbIJgx3dBGtqRRcuRgq1kFwvPR5dPBUbgynWvnAvJ9s2g0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7AsDYaaN7us58O2VlZH0MyNZKO1I3OWhr2LEYiTOTmffRsmc
	FXi4i4eeBmEvRaQegEpup0d5eKm637iRVc/7yu2VLgoE35/fbhS4qpSX1oLBM/6dZkFzv7N1nCX
	tBVvGta9TyXqmD+eLuGZVpYQdsxhmXYqtKa3x96JEeHMxQOfCxQeVJEUERje3o6jHYwkagmYc7m
	3m2HVRpxBFOK/uYRdNCsF/VvW+GsASFGQGXoH4P7ZdrZMdby4+YpzySrTMvSOp3mE61SUNqi1Xf
	XuYoa+6e4U5qF7lSqPxn1WY
X-Gm-Gg: ASbGncshnRTGlLYocbXB72fEAsEmVvkHJxAXsRtt55IaC22VkCI+sc7PypBJABvg5eZ
	gMkfr46VGn371oZjq5UdboUbjXu5SI1ynWHOLmDOGf1gu/KgnWQpXd3nMgq1KCT9L4rBgLnaqBU
	pgH3dXj4h/7K2X2kh//npqqKziB4HPX+87mHWn6zySNhSKbgGj/+NzAstc1ztbn9boSPICDjt29
	zsiFsLygDmxqbzTtj3Xh3v1qGerrcjMYPxaCAF8QRUoLDdytGrep+/y04Soe1GxjPn3rNmuD35Y
	7Y+xqHADFqXUW25Z3he8JPu/96PjG/APpe0AeB4VhGrYLOv+mHHcbwRHPB7LDQlqknZC/lauu5H
	xONuEq6ULtmV7FqWYJnMI1Hwch+noEUi2CwSiOl2D/m5dhVs9Bd+louGtL1sA9oqcgXR8v4M3vV
	3qkbEDkJY=
X-Google-Smtp-Source: AGHT+IGMNN+1oSqbdR3JpAhxQry9fTbVwKeL0ZqTzJkTPOWf+57p1D6nFzumH1pcvZ+Cafs4g5SXdg3s2+ua
X-Received: by 2002:a92:c532:0:b0:424:771:418e with SMTP id e9e14a558f8ab-4259566e677mr114771375ab.30.1758913525407;
        Fri, 26 Sep 2025 12:05:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-425bc0b5914sm3792245ab.11.2025.09.26.12.05.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:05:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso38417395ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758913524; x=1759518324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRmwJqq2SxsiFB6VEpR33/U1NputiwE3QM2SDlba7Y=;
        b=ZkykOpta6FP41DYY43K419pxvWAE1GBkpVo8mGEsBZ+bRyppVca8gCnU1x82F56AYp
         mL8OYgwsugvcTC1jbdRVSs+sngXsolDtQISBRja0bQRzNqE3buDaZmpOAoDk0psog9iS
         gguaLZ76bZoAaxb9BAOIYZ6Nia0QCGY9j32cw=
X-Forwarded-Encrypted: i=1; AJvYcCWR9LXC9rCs29BlJOcbGPDWXFQC7SPfZug/jWGZKDLfkyDlegHMoAs6Gb1alWl552nBuQrwkgGfO9HA0bA=@vger.kernel.org
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr86956875ad.22.1758913523902;
        Fri, 26 Sep 2025 12:05:23 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr86956455ad.22.1758913523442;
        Fri, 26 Sep 2025 12:05:23 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac9ae0sm60832835ad.140.2025.09.26.12.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:05:22 -0700 (PDT)
Message-ID: <a318f055-059b-44a4-af28-2ffd80a779e6@broadcom.com>
Date: Fri, 26 Sep 2025 12:05:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
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
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
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
In-Reply-To: <aNbUdweqsCKAKJKl@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/26/2025 10:59 AM, Russell King (Oracle) wrote:
> On Wed, Sep 17, 2025 at 05:31:16PM +0100, Russell King (Oracle) wrote:
>> On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
>>> If the "st,phy-wol" property is present in the device tree node,
>>> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
>>> the PHY.
>>>
>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>>>   	u32 speed;
>>>   	const struct stm32_ops *ops;
>>>   	struct device *dev;
>>> +	bool phy_wol;
>>>   };
>>>   
>>>   struct stm32_ops {
>>> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>>>   		}
>>>   	}
>>>   
>>> +	dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
>>> +
>>>   	return err;
>>>   }
>>>   
>>> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
>>>   	plat_dat->bsp_priv = dwmac;
>>>   	plat_dat->suspend = stm32_dwmac_suspend;
>>>   	plat_dat->resume = stm32_dwmac_resume;
>>> +	if (dwmac->phy_wol)
>>> +		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
>>
>> I would much rather we found a different approach, rather than adding
>> custom per-driver DT properties to figure this out.
>>
>> Andrew has previously suggested that MAC drivers should ask the PHY
>> whether WoL is supported, but this pre-supposes that PHY drivers are
>> coded correctly to only report WoL capabilities if they are really
>> capable of waking the system. As shown in your smsc PHY driver patch,
>> this may not be the case.
>>
>> Given that we have historically had PHY drivers reporting WoL
>> capabilities without being able to wake the system, we can't
>> implement Andrew's suggestion easily.
>>
>> The only approach I can think that would allow us to transition is
>> to add:
>>
>> static inline bool phy_can_wakeup(struct phy_device *phy_dev)
>> {
>> 	return device_can_wakeup(&phy_dev->mdio.dev);
>> }
>>
>> to include/linux/phy.h, and a corresponding wrapper for phylink.
>> This can then be used to determine whether to attempt to use PHY-based
>> Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
>> PMT-based WoL if supported at the MAC.
>>
>> So, maybe something like:
>>
>> static u32 stmmac_wol_support(struct stmmac_priv *priv)
>> {
>> 	u32 support = 0;
>>
>> 	if (priv->plat->pmt && device_can_wakeup(priv->device)) {
>> 		support = WAKE_UCAST;
>> 		if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
>> 			support |= WAKE_MAGIC;
>> 	}
>>
>> 	return support;
>> }
>>
>> static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>> {
>> 	struct stmmac_priv *priv = netdev_priv(dev);
>> 	int err;
>>
>> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>> 	if (phylink_can_wakeup(priv->phylink) ||
>> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>> 		err = phylink_ethtool_get_wol(priv->phylink, wol);
>> 		if (err != 0 && err != -EOPNOTSUPP)
>> 			return;
>> 	}
>>
>> 	wol->supported |= stmmac_wol_support(priv);
>>
>> 	/* A read of priv->wolopts is single-copy atomic. Locking
>> 	 * doesn't add any benefit.
>> 	 */
>> 	wol->wolopts |= priv->wolopts;
>> }
>>
>> static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>> {
>> 	struct stmmac_priv *priv = netdev_priv(dev);
>> 	u32 support, wolopts;
>> 	int err;
>>
>> 	wolopts = wol->wolopts;
>>
>> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>> 	if (phylink_can_wakeup(priv->phylink) ||
>> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>> 		struct ethtool_wolinfo w;
>>
>> 		err = phylink_ethtool_set_wol(priv->phylink, wol);
>> 		if (err != -EOPNOTSUPP)
>> 			return err;
>>
>> 		/* Remove the WoL modes that the PHY is handling */
>> 		if (!phylink_ethtool_get_wol(priv->phylink, &w))
>> 			wolopts &= ~w.wolopts;
>> 	}
>>
>> 	support = stmmac_wol_support(priv);
>>
>> 	mutex_lock(&priv->lock);
>> 	priv->wolopts = wolopts & support;
>> 	device_set_wakeup_enable(priv->device, !!priv->wolopts);
>> 	mutex_unlock(&priv->lock);
>>
>> 	return 0;
>> }
>>
>> ... and now I'm wondering whether this complexity is something that
>> phylink should handle internally, presenting a mac_set_wol() method
>> to configure the MAC-side WoL settings. What makes it difficult to
>> just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
>> that could be a "force_phy_wol" flag in struct phylink_config as
>> a transitionary measure... so long as PHY drivers get fixed.
> 
> I came up with this as an experiment - I haven't tested it beyond
> running it through the compiler (didn't let it get to the link stage
> yet.) Haven't even done anything with it for stmmac yet.
> 

I like the direction this is going, we could probably take one step 
further and extract the logic present in bcmgenet_wol.c and make those 
helper functions for other drivers to get the overlay of PHY+MAC WoL 
options/password consistent across all drivers. What do you think?
-- 
Florian


