Return-Path: <linux-kernel+bounces-735830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3236B09441
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347EA16C871
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BC2FEE25;
	Thu, 17 Jul 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RkmITqRG"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3E21B9C6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777900; cv=none; b=RgBG+flH5W+vtX55zcP0b2P6jQjd5Bfy90G/c8mCcXOZW4tNl6DwJEA6hwrDrv0QG17AV4YfkrjKWQHjPHWukhBrRiDZmknr05NCU7/oIMIE0go8+43JHVNm5CFkbqEtiBWDVAZa/J/4Yp5BPMwJXjdX9FPlPglW+E+LWnA8lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777900; c=relaxed/simple;
	bh=F1DDJInwpfm1dUWTY4Jp0Rk0EPOGCT8Y7sc3+ycg2Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjbB5KGVqS5rrGBEXik1/UVI3Dvdo5IWQUOE3SyF8DCC45AJZkSGe8CTTgmi6gWRR0wUcSzJohTsCMAeDM08qYdpnAj3YgpgPVykPAl8HJyTJO0ZeP3MWFzFKUO7oXbboONU2jgv8iGbqODndyKNPkp1nhk9gnOSJlVKh+VN+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RkmITqRG; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1283947b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752777899; x=1753382699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mgHUAOryW9rAxsp3zYVOYXXuH7UJEaVYk/LztMwbneg=;
        b=RkmITqRGo3KAdNZLAfX22GAACzo3xf3nLuPUrLSL58zLlnmmbuXTlajokd/qJHfmnA
         kPvi4baBvdJ9raoaDMsnuEaxWQtq1YmRUI5m0jX6o71+r63u/bnUnF+2yky6IMjyfYfg
         FAh9NqcdFHuKcNpIZogCXUZclI2fVZlNG+9pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777899; x=1753382699;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgHUAOryW9rAxsp3zYVOYXXuH7UJEaVYk/LztMwbneg=;
        b=vsqff6k4y262rUvsfcnxRBQ4NbnF/MOz3aVpbjTotOEBvoov/pB/+05a5BJRvWc9pA
         ownz6Vi1AoK9+TDM5o8thhPg3IGjMq0I4iqvT6wd2Ajkvp8nZjWMVNQO6aToRwE6jdBy
         wNL4w8hB3ClDn3U1gVTeysQY9C0SSxpov6pPNyer+xLMKHne1k3wwhS1Ta9FfzxCdUGW
         b8wSNVhblANBA5hwFOvQyrKUSu6lOQFBVkeP3XI3zzFlL2itCxJTm0pHE8MvZTi1no4A
         zEOgJZLpvxXTbn0hLuiYj7i3BSxYg1yKEvVbSX7tDckXYe2vejgLcObNpJUrSmCQFlRu
         yHEA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcBY8cgcJW5tjW+HnzYR9kSy35Wg9VOHp3Rw4fuiDJuB+iAmFDsX9AIS2EqeHaNsrSEYV8l9XkctvBiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEgvrJWIUbe5rBaF7Wga7KE9aP82yjERxjsrdh3IQrPutQKAM
	ye/vbgzHtZcNpR4SKNZtPV8plhFWPy8hDRmuI7hQWAvUa+9Dm3yIblQs4UqSwN9P+g==
X-Gm-Gg: ASbGnctZQg85edzW+AlfEffA8GcwEe4guUqK9eaxR3+Onttwf45M6kJLzAgsMPeIBON
	AnnsIMgJ0u40+N89JubKjH9Krz7TQqLf4Axqp1nDBUhejTO+xxBbGkMuaQmVxGCDTAkNWGSa8RX
	685/3z3TXgIW2qQpaeb2KInQYC4BjbttAV5p2JsMS7qBDW6R4Pr9HufK0Sz+z3iRsTfFhx+PT5k
	1QFUxKlkxShvAg/2aWQU8Z1Pl4SiQhyRgWmgC5fXhFKfEFaNeUArT12VGlsxfG7ZrK5oIb6z0yl
	COLdbSI52+axl8Ut/Gowvzgeo5rjKtt/hf6eCEaYKrL434a9IU9JgBYKg3+P22Kpt73AHztXXpz
	bsFmrX7Ih4K6blcDxuh372UUPetfNRDcGgSp0x+kn5tNsKuq3js6MikGan0/z9g==
X-Google-Smtp-Source: AGHT+IH1vMyJJntHyHuby26Y9kzZDqesLEeqdGuHVt9c0cEWqkUm5Ik8TmXnKXqv/RzKXZmaoVw8iw==
X-Received: by 2002:a05:6a00:3392:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-75722869545mr9946874b3a.6.1752777898554;
        Thu, 17 Jul 2025 11:44:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b6fbsm16368473b3a.84.2025.07.17.11.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:44:57 -0700 (PDT)
Message-ID: <b7ccb251-4ee2-467f-96ef-b35a3cedce58@broadcom.com>
Date: Thu, 17 Jul 2025 11:44:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] net: dsa: b53: mmap: Add reference to
 bcm63xx gpio controller
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-3-kylehendrydev@gmail.com>
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
In-Reply-To: <20250716002922.230807-3-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 17:29, Kyle Hendry wrote:
> On bcm63xx SoCs there are registers that control the PHYs in
> the GPIO controller. Allow the b53 driver to access them
> by passing in the syscon through the device tree.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

