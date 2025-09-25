Return-Path: <linux-kernel+bounces-833221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BDBA1741
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35A3627B87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5262749DF;
	Thu, 25 Sep 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QZ6YCRmE"
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CB271475
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834254; cv=none; b=CfYEFYLRdPGBXbuvu/cfFfZ5HXlu06CVxHU2ZTnJwc5p5KRVqiT+qmdTm3q7solMI8BvGF9UP5O3SOX9LUQT3ei+k4C6yGAAvfel5YB3v6vPacwb4oomX8MPpnrJepSz2fZGUcSJKmZyVmRdeQvTFIEXh6IJG1j0WfJZUZp8G4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834254; c=relaxed/simple;
	bh=MyJ1VklW6yICDJYnRu7RAt7IyiZwj/0uBSjmy+BA84A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lxh3U0JU1BHCFAjeTzw0uqtrfL/xoLN0vT4kkmuXMJYc4ULRC0+46GQciUfvecPO9Dt8xStWG9w9yvy5ayeFV6zBH/tv8e0yRVHsbcX7urteE3mTFe9BXaloUUC5/6jqFF2LkRC5/7elqkQybXN9YxTrQFqIGTsdCqTP0YAeYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QZ6YCRmE; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b55517e74e3so1522129a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834253; x=1759439053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz7G9/EUJnkW1Chp9iRbyaB6CAs3zBGi/9nIuJuFHpE=;
        b=oEGbis/8GrLnn3oouS5ErFL73BKSoY7YTB+qz6BE/g3fOYbtjXjcBw4FTGKk8cXKoe
         8CM1FWMA39OIFOC35oKIKc6XtlItcLDBTmk2bv+zV3hv/XuQEr32OgN6LrB7qyYPekp4
         mYP03OkhVFuAmlJGQMO8nV8FOYwBAZftHG7EMz5Hm/pe+WGv/9xLJeX11TqIw37FY3G0
         95BJKYnae7an5Z6QWCda4/Z0vvNRY6KfiVs5S5k4GZKgfwgbfz9KpI210ZwQibJIiOSW
         ARWKqzb0365pGGYAG9xfToNyQCfy0eeUHDlXLPkU/I1sO+8umLGYxLOsPxE7ST2gw80w
         CZmA==
X-Forwarded-Encrypted: i=1; AJvYcCU2hJX8tJoGdoj/mE0FSeG3e6S0C2MJfdhlEGOd7Rwm4gYWfsNAUSmzYKnFmqGPs72jQaaKilwLPX6eA90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjPuj3FZGaUHFePujkoUgpnQRGSy7WHZuVvDg1Azd0jt24LxC
	YlbZDggzhdv9NTYrxijLC50uaIPBQ1lSADjOuRU1YQq/gAv12YlS4UqWSvDt8cseNkHblz70vMc
	dGSu44fJz0KhwI6LwTfA0yKJseIWvf98IuNzqVsn9ijXfJKvA6Op1JgKvlS9f4XNlKrULPeU0yu
	5z9VJkYBTYz6sFMMdLIkQZjhB70wy1BCm+1/RYxFumcviDjdRfRy5BYONipiFxcRFyrXDcghv4j
	Xd5xT/uQGzWdcQoLKARiTgs
X-Gm-Gg: ASbGncuPMrb+DMzfPWZMt6l5PviY05I7Ydm/hCnzB1fi4R3+ikr0LPwr07Z0nypM996
	WFSp/0hcI74zkFJC/28MA8p1ECdsgt/D/ijkQKsKRDa2F3wfahboTiPa1yLolgzeF3olUA27kU0
	yzxWI9bGftkRuGhn6HyBfgq7aPFb6cIUvCmVN0ZBze/66B2oACsT4Jv7TtT8394Cm8mVExpER2Y
	PPb47Zj4hUssygrbZVK27Mj9+0+HX2ga9cBopWMQoM+REAEKWE1cW+IstZLrCBR5wmw3EmvW0uk
	pjf5X4dtqaBWCHZxqurgrDoWmM3jxze1wwiL1vVvus9IKSig3hyDxSECdIC2Cy9TN0Fq+TBADZZ
	V5pJ9ZmtBnfZ7g6A2LB9I18ab4nFYwKfy0I/FtikVu8v25fj5eYX9BTC+jhKorGr34uH/wOtzmq
	tHDeHq
X-Google-Smtp-Source: AGHT+IE1vRUKhz3HJeRKBeI1TAhfR/429+pOgVsxjQz0Y3p4Dsm0b85vN685TvqqnfuUE2smi3ZNQ28WogDT
X-Received: by 2002:a17:902:e78e:b0:268:105a:1214 with SMTP id d9443c01a7336-27ed4a5a6d2mr47227155ad.33.1758834252575;
        Thu, 25 Sep 2025 14:04:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed66dd03asm2262635ad.23.2025.09.25.14.04.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 14:04:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1963306a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758834251; x=1759439051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jz7G9/EUJnkW1Chp9iRbyaB6CAs3zBGi/9nIuJuFHpE=;
        b=QZ6YCRmEjbFtb6SKHAgg5HSQDthamU58dUZrQHSj6ItJ0Dcab63aasxExuY84zPDvQ
         KyNwkE7hezoDyUruWlJJjfV/9PyEVI/gyQbDA5+lZ3IjvV3fNyRBv3Uskb6gjLeZZB0G
         /kJW6x3px3pb48i12Dvx3t95Hk+xiR2IAESpE=
X-Forwarded-Encrypted: i=1; AJvYcCWv9BTo0295Eo8ZCxQMDPx6kX3FoWgIlNkz+Ibdk8xctu2eXSwcJxQG8Cw7/hkt4XSLfp1gtMCDLlu/Kg8=@vger.kernel.org
X-Received: by 2002:a17:90b:3a91:b0:332:793e:c2d1 with SMTP id 98e67ed59e1d1-3342a2e560cmr4911988a91.36.1758834250920;
        Thu, 25 Sep 2025 14:04:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3a91:b0:332:793e:c2d1 with SMTP id 98e67ed59e1d1-3342a2e560cmr4911968a91.36.1758834250532;
        Thu, 25 Sep 2025 14:04:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57f56725b7sm179631a12.54.2025.09.25.14.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 14:04:09 -0700 (PDT)
Message-ID: <7eed7848-b3ca-4415-85c6-7267c91560a6@broadcom.com>
Date: Thu, 25 Sep 2025 14:04:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 0/9] clk: bcm: kona: Add bus clock support, bus
 clocks for BCM21664/BCM281xx
To: Stephen Boyd <sboyd@kernel.org>, Artur Weber <aweber.kernel@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@riscstar.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
 <d36c5597-e26e-4ddc-93b3-222d8b40dab7@broadcom.com>
 <175834646902.4354.13114906749225372224@lazor>
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
In-Reply-To: <175834646902.4354.13114906749225372224@lazor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/19/2025 10:34 PM, Stephen Boyd wrote:
> Quoting Florian Fainelli (2025-09-04 11:28:34)
>> On 9/1/25 10:07, Artur Weber wrote:
>>> This patchset does the following:
>>>
>>> - Introduce support for bus clocks. These are fairly similar to
>>>     peripheral clocks, but only implement policy, gate and hyst.
>>>
>>> - Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
>>>     and update device tree bindings to match.
>>>
>>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>>
>> Stephen, are you OK with taking all of those patches through the clock
>> tree? Patches #8 and #9 have a dependency on patches #2 and #3.
>>
> 
> I don't normally do that but sure. Is that a Reviewed-by?

Sure, let's make it official:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

if you prefer that I take those patches through the ARM SoC tree, that 
works just as well, I would need a suitable acknowledgement from you to 
do that.

Thanks
-- 
Florian


