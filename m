Return-Path: <linux-kernel+bounces-738237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AACB0B636
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1100D3BE27C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1720010A;
	Sun, 20 Jul 2025 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="wAVf/WuK"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089CF43151
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753017361; cv=none; b=qpJBi1fLXP8/pxaeqQnSQalptaoE+8BBBWqS+h6V5/o8uyg3X5fZSC7/jK84KT4pVHJ9kLjeuKwfCbUM1Unlr1X5p6dTDC/Nn7kL/pSU0nqQZR9OzqyD7EUWjTmhf0TnyDHLKmN7ExRNomD7uw9iw+Tz3ceTTTGA1WymX8FSY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753017361; c=relaxed/simple;
	bh=aJVelaIFqucaE2gGcCv6+lPUFTTN43XFZjliD5Z/BnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqypV7t/MaS19Z6/rQsvD5RftNmzDRf+zOsbxXktq5zqHTBDLdl3NJ++YV240VwK+ej+i1vRyp1RposPa5nUfWTPZ/ZGTi5U5uHnWPnzaWqMTZAAMWqb44k2Uy0+Y05WJBbJk0pYhTY3Ai3EwZTLusVA1Ok3m7yyiY7SrG7R4rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=wAVf/WuK; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 22382 invoked from network); 20 Jul 2025 15:15:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1753017350; bh=ttk7fb8XlaFmqm17AyNjg98kleNuPOap8ewNvEIirYU=;
          h=Subject:To:Cc:From;
          b=wAVf/WuKhzI2Wh0Hwa1XPCceRe9snvZfE9TgVG0OSy6EOX2sCrh+b4serMD/0eyzJ
           lNsq15mhnTACay4MQc9TRCUxa4/cTZlY5FL1a7ksnCYlwJCS17BnWaJt24ISdI96kw
           oZa/XKrl7wag8k7O/qDQHaCCSu41gNKkWaGoZyIQJSVX/uyVkq0EItxw8z7PBkLscu
           dgESmGZTDw66Z/MUmAOcfko8q9OhNQNLK2sFgm8n+bewOtJoOXRfcuSugioZD99wRs
           gtx3YytjvvSLUBSlq7WRPxJjASIW/o8ZLEvNesOP7+XLx4yzETGv4wBeSgYG4RJOqN
           HrGxCQSlshwpQ==
Received: from 83.24.129.157.ipv4.supernova.orange.pl (HELO [192.168.3.246]) (olek2@wp.pl@[83.24.129.157])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 20 Jul 2025 15:15:50 +0200
Message-ID: <fcedccfc-c921-4afb-92d5-5f5e0a60d251@wp.pl>
Date: Sun, 20 Jul 2025 15:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Add thermal sensors support for MT7981
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: s.hauer@pengutronix.de, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 angelogioacchino.delregno@collabora.com, rafal@milecki.pl,
 rafael@kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, matthias.bgg@gmail.com, rui.zhang@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 lukasz.luba@arm.com
References: <20250712195904.6988-1-olek2@wp.pl>
 <175250104102.2052726.927170028799402599.robh@kernel.org>
Content-Language: en-US
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <175250104102.2052726.927170028799402599.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 73e3bbc9459faaf9a42a9134af578f24
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [8eLC]                               

Hi,

this is a false positive. The binding patch [1] is already queued for 
6.17 :)

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-next&id=8749c54202df93af2a01c15865b07eea1e64b6d9

Best regards,
Aleksander Bajkowski

On 14.07.2025 17:24, Rob Herring (Arm) wrote:
> On Sat, 12 Jul 2025 21:59:02 +0200, Aleksander Jan Bajkowski wrote:
>> This patch adds support for the temperature sensor in the MT7981 SoC.
>> This sensor is exactly the same as the one in the MT7986.
>>
>> Changes in v4:
>>   - sorted bindings by fallback names
>>   - dropped accepted patch
>>
>> Changes in v3:
>>   - added fallback in bindings
>>
>> Changes in v2:
>>   - added fallback to an existing compatible string
>>   - removed second patch as obsolete
>>
>> Aleksander Jan Bajkowski (2):
>>    dt-bindings: thermal: mediatek: add falback compatible string for
>>      MT7981 and MT8516
>>    arm64: dts: mediatek: add thermal sensor support on mt7981
>>
>>   .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++------
>>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 31 ++++++++++++++++++-
>>   2 files changed, 47 insertions(+), 11 deletions(-)
>>
>> --
>> 2.39.5
>>
>>
>>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> This patch series was applied (using b4) to base:
>   Base: attempting to guess base-commit...
>   Base: tags/v6.16-rc1-8-g95a042a0c8ec (exact match)
>
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250712195904.6988-1-olek2@wp.pl:
>
> arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
> 	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
> 	'mediatek,mt2701-auxadc' was expected
> 	'mediatek,mt8173-auxadc' was expected
> 	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
> arch/arm64/boot/dts/mediatek/mt7981b-openwrt-one.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']
> arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
> 	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
> 	'mediatek,mt2701-auxadc' was expected
> 	'mediatek,mt8173-auxadc' was expected
> 	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
> arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']
> arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: clock-controller@15520000 (mediatek,mt8188-imgsys-wpe2): '#reset-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/clock/mediatek,mt8188-clock.yaml#
> arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: adc@1100d000 (mediatek,mt7981-auxadc): compatible: 'oneOf' conditional failed, one must be fixed:
> 	['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc'] is too long
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt2701-auxadc', 'mediatek,mt2712-auxadc', 'mediatek,mt6765-auxadc', 'mediatek,mt7622-auxadc', 'mediatek,mt7986-auxadc', 'mediatek,mt8173-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt7623-auxadc']
> 	'mediatek,mt7981-auxadc' is not one of ['mediatek,mt6893-auxadc', 'mediatek,mt8183-auxadc', 'mediatek,mt8186-auxadc', 'mediatek,mt8188-auxadc', 'mediatek,mt8195-auxadc', 'mediatek,mt8516-auxadc']
> 	'mediatek,mt2701-auxadc' was expected
> 	'mediatek,mt8173-auxadc' was expected
> 	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt2701-auxadc.yaml#
> arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dtb: /soc/adc@1100d000: failed to match any schema with compatible: ['mediatek,mt7981-auxadc', 'mediatek,mt7986-auxadc']
>
>
>
>
>

