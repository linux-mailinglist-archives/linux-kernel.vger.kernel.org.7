Return-Path: <linux-kernel+bounces-783785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C395BB3326A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 21:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C32520678C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21021858D;
	Sun, 24 Aug 2025 19:48:38 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF157260B;
	Sun, 24 Aug 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756064918; cv=none; b=jr3dg6rE+4UNt7Gc8S9aTGNeIr/U/TQmRvJmUmGk+KVe4tc0ySfOAV4+a3bYgdEwT0w+LijJvxZIoAV1lHnwrmQwDcTvWx+s+CHo/qls50+ubZ60RMvUwThCWp5zhuTj9+s8sA66ybxI5eWQJkZ4rxh1uV5CTzrP7j6mabjmhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756064918; c=relaxed/simple;
	bh=rLvvj/4nnkpq/qznVE44J68fyks0NqHJP8bfYOXtcTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txxmumwqhOU6dgF5LuxUyeJ4Ih8grt0DccZetwbajZbHCDpQqkV1Ld2Q2hle5dGal5y3VBL9nJnhtdXvo8kPiWaq005O0z9veGtB8fKeG52XO0EBgvWpHxztQt5wKnzNgSoRv1ocgn2yUYyccu3QV2YOp/vY692b6F2BoehNtCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.216])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id CF33EB4E0003;
	Sun, 24 Aug 2025 21:48:24 +0200 (CEST)
Message-ID: <44585871-aabe-4d6d-b4c9-17d9acaa8063@freeshell.de>
Date: Sun, 24 Aug 2025 12:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
To: Icenowy Zheng <uwu@icenowy.me>, Hal Feng <hal.feng@starfivetech.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-2-hal.feng@starfivetech.com>
 <3c2b62e219e50555319da369cafa9a8f79eb71e8.camel@icenowy.me>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <3c2b62e219e50555319da369cafa9a8f79eb71e8.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/24/25 10:14, Icenowy Zheng wrote:
> 在 2025-08-21星期四的 18:09 +0800，Hal Feng写道：
>> Add device tree bindings for the StarFive JH7110S SoC
>> and the VisionFive 2 Lite board equipped with it.
>>
>> JH7110S SoC is an industrial SoC which can run at -40~85 degrees
>> centigrade
>> and up to 1.25GHz. Its CPU cores and peripherals are mostly similar
>> to
>> those of the JH7110 SoC.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml
>> b/Documentation/devicetree/bindings/riscv/starfive.yaml
>> index 7ef85174353d..a2952490709f 100644
>> --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
>> @@ -33,6 +33,11 @@ properties:
>>                - starfive,visionfive-2-v1.3b
>>            - const: starfive,jh7110
>>  
>> +      - items:
>> +          - enum:
>> +              - starfive,visionfive-2-lite
>> +          - const: starfive,jh7110s
> 
> I suggest adding starfive,jh7110 as a fallback here, as it's the SoC
> best known to most softwares, and JH7110S shouldn't have any difference
> to JH7110 other than binning.
> 
>> +
>>  additionalProperties: true
>>  
>>  ...
> 

NAK, it is said the operating parameters of jh7110s are distinct from
jh7110. You would have to show that it is safe to operate the jh7110s
with the operating parameters of the jh7110. If anything this would be
the inverse, some jh711x (or even j71xx to include jh7100) common
description with fallback operating parameters? And to add this common
fallback with jh7100 (?), jh7110, jh7110s  -E

