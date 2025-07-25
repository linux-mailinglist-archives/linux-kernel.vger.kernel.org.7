Return-Path: <linux-kernel+bounces-746376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C2B125EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53141AE2F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C425DB1D;
	Fri, 25 Jul 2025 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="grTo9X7P"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479125BF1B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477078; cv=none; b=Gjo/Nu1+7kzndVGJxTsS3bQ6Ss70b6qqvFJFi/UEBAWusLTBdanUU3yOoyGeCrZUe6yEqSi7WsYUSjLU07OYLtxZTNB9Y1Wb8gk4hjHIwz6Renz/LPV2NE48g4DZyexXbdplNMwAiNASGON6hNzEQqjmpVuGpu1VZM1NBcnek9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477078; c=relaxed/simple;
	bh=k232VtwVVZG2FzWgQtBvQ1fahoflcx7WLbYbFpJ1VHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6R8hWoLdvyPy2wWUxRm3HpdAGnUgkp4rUE4MteFHxOsG8RBd8UStTJylA5e0Dyu+3VLsVslZvEDqv2gR/RXKWj9QCL+4dyEJEW6bmtb8LObEyj69xcK9drnjusibZ2Y9N0IQMt+zjf1a6I5eZR/DlbaYjLgsn6X0hQs6TBoy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=grTo9X7P; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d5d1feca18so244435185a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753477076; x=1754081876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0linhnc6R4emmot5qcWK/rphABGbjiM80Hvs52mvgpw=;
        b=grTo9X7PKi8x+wY3BMwvXvHiHfEph5Xj3DN4ypX3+IUngowp5OPMe41r8eyzeBvSBD
         UC4ISeJmgm9z4lq1Z8fHCYogxtTC0FC8wbzfgL9OTXvEn9FV0A9mmHtHxm12dJdYEUZC
         qeOeyeR51kLrdp6bRsYaao0khpc8RagrJwB94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753477076; x=1754081876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0linhnc6R4emmot5qcWK/rphABGbjiM80Hvs52mvgpw=;
        b=C+1PbQzW6Rbv4oim/4veI21DYdvKb5sXlx8QUrNnzzs73RHPNNVDxgPMRempsT5PKi
         4WSmat3zIq8CZiXHG7dfKDgjOmIhMjpDERyBzGQkRHN5I+yv/uvOoXo+45DHuMWzGj9R
         XI9pMn73jfLu/lx10LpYIewqhGWpF0Sy2dxnIS6MOQtYtUGFuyluZU77PEBmDLX8fXA+
         2dqsWR6ayvstJziejSVeFyyM4YEUod8n/IXHAF/zre/NNXa1xBXL/iW9fpHuckMksvFa
         s2SpjGOJ8X5GszmNym7E97JUEmIsdL18qXhUCqy8lGRRPoi6vC5ull30ekYxwwKkpODp
         73/g==
X-Forwarded-Encrypted: i=1; AJvYcCWOYNJho+VOxwN/hSFC9KQ8AfiQN0d3sVKN98MjdockhY+9rT0G6fngTG2j718woIVHh6ESvfUSITWpvTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp81fPjb0fIaO6BifIguGXnqTEp56nwS+EBoMsHI0S6KtAolnO
	oCXpJi3DbYZzFESDxCu9HXjw2mWFBHLHbHNTM78/pkaYhOMI1D/+qCtzuKLAFmBgLA==
X-Gm-Gg: ASbGncu0WPucLgKtWxepkh845VU7Yy4+VTZbVsR+cK9zeR2OUf7pxH9Mf4AbneP97xu
	ODHjLP0PRAyx8tVafGay8Q6B7SkOxBAOkh2TwJq6dtGemTkZs21ENI+49N/f3w8fg67HLz4qtgj
	BbHegHmQj4+d3s075a2GBJqHQY52z9e9ahBy/MgO2VuKXAFZOcpYakgJWV4HP9SL7gVcmnm01xv
	cK1nIkDMdBWX7NZSx1D9LpTeoLMizv3tDPR6mizrrCifPQZU1UgfMNDjY65huxKq6Q6i734lyE8
	ogjIK3MplLv6t4nEuVGwbi0hJfdyOuU/iPASEUTHiiYayMvbPEndsV+svu3nwnP5lo4YwdYVU3m
	68dUpmYxdCPraP3EMYgqmJRvs/kOLYyijae0qXCGkWpgU4mAaIiUXsdT3i3lcMA==
X-Google-Smtp-Source: AGHT+IFM/h8z9wxWmVisKKuJLLilE16LMHU69yVSgZxmcR64rBzMd6QSyjirXwAAUfv3FWcEqWULIg==
X-Received: by 2002:ad4:5dec:0:b0:707:151d:3234 with SMTP id 6a1803df08f44-707205a9d4cmr35292276d6.30.1753477076161;
        Fri, 25 Jul 2025 13:57:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70729c92aefsm4282516d6.100.2025.07.25.13.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 13:57:55 -0700 (PDT)
Message-ID: <debca09a-7eb7-47c1-9613-74db49f423b3@broadcom.com>
Date: Fri, 25 Jul 2025 13:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] net: dsa: b53: mmap: Implement bcm63xx
 ephy power control
To: Kyle Hendry <kylehendrydev@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
 <20250724035300.20497-8-kylehendrydev@gmail.com>
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
In-Reply-To: <20250724035300.20497-8-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 20:52, Kyle Hendry wrote:
> Implement the phy enable/disable calls for b53 mmap, and
> set the power down registers in the ephy control register
> appropriately.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


