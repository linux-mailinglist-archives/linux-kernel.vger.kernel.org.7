Return-Path: <linux-kernel+bounces-783229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A45B32AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9081FAA0A68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4624292E;
	Sat, 23 Aug 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2M9e4Es"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C51F4161;
	Sat, 23 Aug 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966906; cv=none; b=FGCfynqTyRSRMC+LCD2qxx0AvSnSAUrgF9sC8nFdXfcmbEw5ih0s1JJSmgyatwpq7/qMgqgjBTb9VP0e4kRuvq9WGTi8b2zQqcDTyhD2ck4JwOn24vYb9SPDoRZ5TxIaMtLtVFnhSX63+yyrwkvV5XIyKOn3wOMSCKomFmf3dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966906; c=relaxed/simple;
	bh=DPDtTcuBskg1W1btrqujpaiwu10iFm1YYay+tvV2FPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iresFNg6eof/OBMO1pjF41OeFFpfIEvA/PxohLE0HqWO8QOUkSFqx5wVMdmJbo42B1EZ0cgA7Q//DM5u38B/Fn3usQwpOmu9hGftBBp3IRITOvWXnmh6eIFp0EHle72xKYjl9KFqbxG5WIFu2++S64ljEdhXecXhuNsLeEFvOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2M9e4Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1713FC4CEE7;
	Sat, 23 Aug 2025 16:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755966905;
	bh=DPDtTcuBskg1W1btrqujpaiwu10iFm1YYay+tvV2FPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X2M9e4EsDHFKOGlr24f4WFlsXIirLYBnf4AcDXX5qnGpGf3SNf3Tl5RmlcDEZ9Wcy
	 N62DCDJwSs9+MN6Rtj7Kzze6rMgTpNZRs5pahzmtpXywrEAj9q7cf0TKGYjjgZgWb/
	 GPL5U7ykGqw1lDilf2Ud5T1SEHnDaUZwkDPrVBpsBTy+kz0DX3ljUx4ud2pDlnF6Qt
	 OnvZaINUAfII5QNLO2hLh1V34PbHVJx7btSN9N8kdz3EkAjeytWAniAl37MLzmD7il
	 RhGRMYYA1F3hkKWA/LhPnhlZmIloou4MYaLJrr8bU1IuJV9pHK49B+6p1O+utd2FcF
	 wD+efr99cQbXQ==
Message-ID: <088db082-f3e2-4e66-a2b2-374452184dea@kernel.org>
Date: Sat, 23 Aug 2025 18:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: marvell: armada-37xx: Add default PCI
 interrup controller address cells
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
 <175589786306.518460.17450425303264875357.robh@kernel.org>
 <962afcee-48ca-415f-9011-ffb25e082b36@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <962afcee-48ca-415f-9011-ffb25e082b36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/08/2025 10:54, Krzysztof Kozlowski wrote:
> On 22/08/2025 23:27, Rob Herring (Arm) wrote:
>>
>>
>> This patch series was applied (using b4) to base:
>>  Base: attempting to guess base-commit...
>>  Base: tags/next-20250822 (exact match)
>>
>> If this is not the correct base, please add 'base-commit' tag
>> (or use b4 which does this automatically)
>>
>> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/marvell/' for 20250822133329.312326-3-krzysztof.kozlowski@linaro.org:
>>
>> arch/arm64/boot/dts/marvell/cn9130-cf-pro.dtb: /soc/bus@f0000000/system-controller@6f8000/clock-cpu: failed to match any schema with compatible: ['marvell,ap807-cpu-clock']
>> arch/arm64/boot/dts/marvell/cn9130-db.dtb: interrupt-controller@1e0000 (marvell,cp110-icu): interrupt-controller@10: '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
>> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/marvell,cp110-icu.yaml#
> 
> Yeah, that's on me. I spotted now also LKP report about the same for my
> branch.

I fixed it here:
https://lore.kernel.org/linux-devicetree/20250823163258.49648-2-krzysztof.kozlowski@linaro.org/T/#u

There is no strict dependency between this patchset and above bindings,
but this DTS should be applied by maintainer after when binding hits
next (so linux-next does not get new warnings).

Best regards,
Krzysztof

