Return-Path: <linux-kernel+bounces-881869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E4C291B0
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BD4E6BDA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB1230D14;
	Sun,  2 Nov 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WZ/EhAIF"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003261F936
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762099981; cv=none; b=fVMpcxHfzwLaRht/JkGcZlSjDWYSXzMJPwKK0EcPi4cDj9MkAYseIlhNqwkq15Hh04yc3CYDZhI43Qj+m7r0Q72MW3hvC26g8rLAMTtjesdQoikQ9O6ia/QRxaO1F1LmLaFatWG1PaWEEF1U9UCS0fSTCmi8Mti2w8vOqTnE0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762099981; c=relaxed/simple;
	bh=BO/j7N0IDWYCOEC3h7SRnqnJC86TVXmlOFAlu09y82A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COcVv0uMYBjh9SPWgKveEN3PqlfQvWMmk5HsYNPOd8eMBngC/1K1Ff2BUksu+yGl3o87TGeHHuVicFW+PHE5p/GqUm57ujWUbQdJj9PAOyo1ovOheuNQP9yK8bPc7b6O8b0WeBCIDmKdQtTxDSjUPQZsaNk8u9rnZYkCvJ3Qxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WZ/EhAIF; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-294df925292so32146705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762099979; x=1762704779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXWXoVbPyV5eU1syuugBzDzD0q+1nlVhslmOyClyUcE=;
        b=kRmua9b5GAQUrPyavE8kFLrqANInGR5q5HIoKVTumD77g7tqV0gOchsr49Lvsjd95j
         EIeqaHZzTl7nqX2mXngbujEYNzka6gkqbGJSTZgcc2HLMhO1rgh1OIXlLWfTf81GgboB
         VWSyvt83IWwYj0QT0Pl8GAJvv3oFqXcnTYau+/kjfWOEJhPB4z8Wle2jGmJvlndkBDav
         YEkaeHtXGurt5iTDXsuJHltMbWwgsoOqcREHut1Upn2MU+4xeUUVAOUeEwJQH35EAgpJ
         WILgCv5vidYRKq+glFgpDVVzhYld5lGMCYjUsLJoBKnvtK6awijUZWHKT0v2UIWNwAZp
         PPQA==
X-Forwarded-Encrypted: i=1; AJvYcCVecXv2IcAIXcAWb9S7CBUXxUOujfyWpDI09TGeyLMXiAXmGIGFzBgovXEfO2CQJIVnyZcs1ybE7EEhTi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAS+c7t5kBUxaVgcJvtJvnE4e/CAiPctsLLrzyoahI61KHR+pW
	iBLB0VGUnHvlIIcTX7yrH4p32A00xoXjbLNbd0s9NFqGo9nrgfCKi+hp109Gk6cEeETMFRDNShd
	iY7gld1d9/asX2CqypDqiRtkL+iVyn1QrDtgfooEsz9QAxRCTg0xQUMi+tg4FZueqoqosUbrvFp
	bBsbn99MxmAii/PIUXZC96BdyK89W4pp5HVM2v8qIe8yF7i8HQz2+lV8/MnxJQ++s2E9+OHX7Vt
	GWaQL4pxmdO5E/ccpTifc1k
X-Gm-Gg: ASbGnctUGDhpjtEeVxUw7pHKXcTrJev3FrpBVRx8g092AZvV8YUqgLx1S1Rg1qZXzwM
	0Np4KDWpvrzBThtN9AJcZmumh8lGce1Ll5sIV89xJ0hEb+rFtMUcfSkdl2PK7ovlHrYsBprsGG8
	jY48Rm6VaXvxnYJ65K1xlciNfX9yDQ7GhViO8hiKy4z2Gkf/4/8y916EAn6mfR6rZQBZ5/BnPjV
	v03rpKXAR5FyoMcj4akI/1EmQj1axIM+8skrvwM1yEGa9hd/QGGThc9XO2Y7SqIL1R8IJ/bV2Db
	C6COX0OxOO0+O4CE98AwJmx6ZIjS/AQOfq+xCmEMCMAkJ/F9PTyI4FMGL0JimbRdvT+AxhwtVs2
	GUHbJzv1bY6ufs0+Agve4fkkecH/lCDHhOsYIQMEQ2D41yRmal0b70Ou3cOGb3nEffIx8bGX1N1
	mWktxd3vn276q+rHvj/u//LJzS6JEqW0dAIq1mGRg=
X-Google-Smtp-Source: AGHT+IEK+A40U6dScRT6FI1caUNsXFRv8PUUQ6ZlxC/SZBgZ/2DRU+NrruycFpciO2otdO0QhwmYPJ6js6s2
X-Received: by 2002:a17:903:8cc:b0:27e:c27f:b834 with SMTP id d9443c01a7336-2951a52a983mr121633355ad.56.1762099979027;
        Sun, 02 Nov 2025 08:12:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29526982903sm7339795ad.45.2025.11.02.08.12.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:12:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272b7bdf41fso44931565ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762099977; x=1762704777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXWXoVbPyV5eU1syuugBzDzD0q+1nlVhslmOyClyUcE=;
        b=WZ/EhAIFUdcCkvMJBrjYbQ9EqzOyV40/ddKbHVX8QZctDA9IRyTNkILt2gpM4dmKNz
         s8K6XMzCnvR/3AuAQ/GPVZCrGmYTZgb0Wl/PaZi7yN9p/y135C/1cMf6pX+qGOEUx+U0
         R0+eQZMEaysTFa9YzbPYb3jns/pYJfwr56E5w=
X-Forwarded-Encrypted: i=1; AJvYcCWbbUR+A7hpKegdVqXN5gRHqI+AmiLk0Rm+KIhZvDMdCeXqv4p0bcf54JGdOfALgm1Yp3j+w4i7LdsZR/M=@vger.kernel.org
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr128650255ad.26.1762099977239;
        Sun, 02 Nov 2025 08:12:57 -0800 (PST)
X-Received: by 2002:a17:902:ea0e:b0:269:a23e:9fd7 with SMTP id d9443c01a7336-2951a3c0348mr128650015ad.26.1762099976810;
        Sun, 02 Nov 2025 08:12:56 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:a836:3070:f827:ce5b? ([2600:8802:b00:ba1:a836:3070:f827:ce5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295424bcc39sm70137005ad.17.2025.11.02.08.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:12:54 -0800 (PST)
Message-ID: <f39415a8-350d-4ceb-b36f-917f6f082454@broadcom.com>
Date: Sun, 2 Nov 2025 08:12:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: add brcm tag driver to b53
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101103954.29816-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251101103954.29816-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/1/2025 3:39 AM, Jonas Gorski wrote:
> The b53 entry was missing the brcm tag driver, so add it.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20251029181216.3f35f8ba@kernel.org/
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


