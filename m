Return-Path: <linux-kernel+bounces-744637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E00B10F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8893E176E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BED72EA75A;
	Thu, 24 Jul 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aIpu+8i7"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5F274665
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373378; cv=none; b=qAJn+gvTWPYinmxT5gusIPacgZZglGBB/ZHmepaRYNh+ZpD1MP/fpKyxscjjeqWVKOSZvpfOvNo5Fkkiv2T0C2ogsjj1jX1yrxlkj8nDNOweR7fREC8XPMCk3NzdmZsMEYwfRnxlXCy6Sqcov8lI6h+Yn75mE6PViRzOEJmVves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373378; c=relaxed/simple;
	bh=xm6y3ci75bhH3x8DxR5bTY16RFuyEAG7cGVm+SOWZos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZK8CTsrpnICvOa0FLkgu3h5ud6PtsmxEyHMMVb6TgQTR2JbXZOL/P2j/6DXZ6IDsVPFRZ1v6CQ6x1zq/iT859NNCYZanBWK9NkmnCVhayIUo5zI8eKy8Z48fwRd9lruvQiA76KjBGioMmdzg/desIgwkR6GGP1v9lXOftnOqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aIpu+8i7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e34399cdb2so118709885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753373376; x=1753978176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJZHsH9Ufl2WGz/OOiNcXZ7TFbhzQw0DIf+bVCuVLo=;
        b=aIpu+8i7WYY4v0MyK1cYPRqZk99aU5e8e3sgEua8tgp7nfTvaVF+Zdc09lfQGLb3h+
         NQUeteEw7WH03kGrDzLE59250825eVYxY22nYdbQU6ukGmtdfF79OePF4xwgXXJvw+iw
         C/zOY2h2tdsY9JsVI+dKFhQ6FUBjZt82DC/XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753373376; x=1753978176;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lJZHsH9Ufl2WGz/OOiNcXZ7TFbhzQw0DIf+bVCuVLo=;
        b=LcauyPg9FJ/0fmUZz5GxMKyCCHNLYGTs0uF//R8z3r1mxVcT1ox57w7H3kXbM/44Fk
         nbiWr8cOuW7JeoMv5sVw+0BjTR+T41fvVlRUj5JKzW6qgqdwU6S210JOIdcKFHMVHzRn
         75LGLy2as1K1AT1WC+9Ech3w2r1PQeY5Z4DIgXoW7aHbJfGCU5/sCx3ut2P1ePcL9KLZ
         oSiLbaxsIAg1jXHsJ0RewiFzHOR4/4FV71VAW1Ev+Ru/6HRk36iPtXor8cuXNEH4jOYS
         gBB2SfLF7IbCU3QYrHPZEsaKYQe1RqeWsbwpUZnZ2Z6yShCXTdDMpIIDmLmU+1YoEJfj
         vU3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDMRBkTvGmWe5LNHdU+K4+3RGw/bP/6UipB5jj/SOmvQXKBdHU92q2UwdW9V378P3y/lCEcFieEbgBY8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2L1+Nw8Pp61i3QgzPqgxuVkbqBVw1yuFuRLlLggaRs9clT/Ew
	HA4shQ9fLDnF3tRg8asVz8w5XQDl96lXKN+eQxB2x3FY8LNLmKkv8gKCFICSx5yAyA==
X-Gm-Gg: ASbGncsVRaJ8YZyCM2FcQ6OMX0nbgolV/6U6ZYHNMf32qv9lV39jWSDGQtPlQQ27lu7
	PbcXeP2nbjy3z0NljOzRk/erDa8uYc3arbqvSVCA4ByT4bgchEfZ+QlHjGxgjo0ZzNSrHBEcbeu
	i67uM5UfczO962o4oXWVVKqVRzupw0cusApcSrUPsymTAnbv/Ek9RQZaA41otzCLuxroN7KYh/q
	9LT9ECktl9IU+u1pdpubMetgrcuqTfOp6bX7MOmnIv4oTnobMfBx8Jbzjji5mP8XtlAX0r7Mwjh
	AFLrvlu3XmEu+Mz0yIV/HIZATztrhZ/BvuN7PHRJM7dRwknPsMIMvCqOR3axUfwECtg461si741
	amsKy05UNAxRke4N5gOH3rZBk6zs0Wn9uMDmYwDcDjeuAC2zLwhe8opvSzvF3FQ==
X-Google-Smtp-Source: AGHT+IFdQDkzPbRSR61ApMn60ItKDxXbCWOjw5MYMVV7wSDRr7UJUNJU26q9tcM3DDOBVEiMsU+31A==
X-Received: by 2002:a05:620a:9369:b0:7e6:2915:c127 with SMTP id af79cd13be357-7e62a1d4b07mr774778085a.50.1753373375556;
        Thu, 24 Jul 2025 09:09:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632d51ac1sm135257685a.1.2025.07.24.09.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 09:09:34 -0700 (PDT)
Message-ID: <660d1cf3-1bd2-416a-b5ac-8dc87a87b4e4@broadcom.com>
Date: Thu, 24 Jul 2025 09:09:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Detlev Casanova <detlev.casanova@collabora.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
References: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
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
In-Reply-To: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 07:39, Sebastian Reichel wrote:
> On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> stability (e.g. link loss or not capable of transceiving packages) after
> new board revisions switched from a dedicated crystal to providing the
> 25 MHz PHY input clock from the SoC instead.
> 
> This board is using a RTL8211F PHY, which is connected to an always-on
> regulator. Unfortunately the datasheet does not explicitly mention the
> power-up sequence regarding the clock, but it seems to assume that the
> clock is always-on (i.e. dedicated crystal).
> 
> By doing an explicit reset after enabling the clock, the issue on the
> boards could no longer be observed.
> 
> Note, that the RK3576 SoC used by the ROCK 4D board does not yet
> support system level PM, so the resume path has not been tested.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY clock")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Hoping this does not regress other Ethernet controllers and boards in 
the process...
-- 
Florian

