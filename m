Return-Path: <linux-kernel+bounces-674883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B274ACF627
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C10B160CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D32D278773;
	Thu,  5 Jun 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EGXkBsiL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE518C06
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749146554; cv=none; b=LY20aJ6m7UEeZNrs50Hzeh9xtsu7il1sf/gdKSoeOKJMMoZDDYaADsG0EBe8/t03hRQymj+1kCzD/k77ZoSaNMtLdm9p8Wjgk7NHJd0pUDXC+8k452P4N4aGhA86IiU7t+GHbmidbKS19P+pinPJt3wMoQD+PaxWMBoY52HWgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749146554; c=relaxed/simple;
	bh=Qixvd4OhypbD8d/UbtBEp9h3rsuuLj4KcvcrC0o/m/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJKb9icY0ettfSW4aA5hCVYo9fL7JRaY7dYN3PRv9HykCp2VGmJAGrHUdqqrK9a9ozji/Ewjpu3gMzXVYqftU55K2isf+2NvjCrWdX8oK88U+b01mxd4OWmoZOv006rZNe0IQrZWPaPncqlZR8Oaq7wAroL0J2ImolK4+guWL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EGXkBsiL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1272283b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749146552; x=1749751352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BwlFuB/WA8JgwT54XR12ivvxbEoyZqbT8RK1LGV138g=;
        b=EGXkBsiL42X3wbnYJLn/KntMJ9sWLH9AOkbhtw/W2PnyTw9vbRt8FQAqbN3TfQFrIx
         kSri/r80tn4/mH/sZoZzE3/OsgUdXpoa7X8aaF/8FEWVFqPjTMVjJAPIbuZERADsz0tS
         vGEZxk9rr/97aNyKsbwgs0V+Ez3vv44ZZyASI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749146552; x=1749751352;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwlFuB/WA8JgwT54XR12ivvxbEoyZqbT8RK1LGV138g=;
        b=AA0Cyk83Gp2CZwh8Y7XVApBxeUILbWMwnnlVhyqUQMTsJNUqrT6vQ/SmrzpaoEZnuM
         hPSz8H/R+OIU/KnHzjiB5SVIeJQ60GfG8hOCXZ2f/e5e7n2CWvB6wgNvdl45DlGfy54L
         pR75iNc62jw0759QDOInlGSA6FAX8GA9gih+YEYDP1xPUSU4ptqQ3e5YCmJCl4U9tgPM
         yZdEiYtPowwNKUWqr7pwwPZdPI5r/wfbuexK/61F3rKBBSItGqJJ44X/Pr+jsyYKAEsG
         PSdmYOwwQj7j4BePZjNwixtXoKO90lhcpxPLBZciXi6uAc9ADGb88lOppKvnX8wf4nkk
         Kj9g==
X-Forwarded-Encrypted: i=1; AJvYcCUSbqCM9ignj/iAIsi+UbNHYDuoRytKKZJHlMKs6cOeq5Cwy0GDB0wqtINC8cV5qJIFVa8sclfeTCSJ/pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygwLpx0bggWX+ZDYPpsaTOk/afyfmYg8JIsLjCUB8xXPuakIz
	UCgX2WW/WaU/Dk9WAZtV3RAK1jm0jp/REzRg5hfCWroLL4pSLdrP11uTDFlfK5VKjg==
X-Gm-Gg: ASbGncuZdKp5kt/rbI09fySJUZp4aKDc9xzoYXWtaB9hwOR72knTJ3XQAtfC8x0N8+M
	N2cdf3/jxCHkzavqanExSpgdxUXARSm7zWTUiJoqrspyas6k/yJ4a/kUJe05AYOQ8tQo68qJyBV
	99lEdVQNBVEvn86zWulwzf8SQx2R3lLy044pn2Ujl4AfLP4KwZRzBlPhvK2ZSOdGh+HsfH98Zel
	J9fcBofUCW5tOneMQ7bLKWc4I2GlK9jOF/jMtcCH7clZGv8P/KfzHWA3UX7gn/LGEoL1hB8N8LE
	wHW0TN3c+8QBZVcOzVpYQNxskyjJmYgjsYJ2IUgOL7OojUbttvvXfziQDWYTCnXIIMkpgfzMX1h
	CmwyXdAuckTt9z/VoOTBnIPrQ8A==
X-Google-Smtp-Source: AGHT+IEIUa9PX/FUvJMVxiR3QvCiRLgr7dERa3ZumCVq2A2BQoxv4jgjwbyszorMPUkMHGKjETHTvA==
X-Received: by 2002:a05:6a21:6b16:b0:1f5:51d5:9ef3 with SMTP id adf61e73a8af0-21ee253296emr216532637.20.1749146552073;
        Thu, 05 Jun 2025 11:02:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7407sm13462933b3a.178.2025.06.05.11.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 11:02:31 -0700 (PDT)
Message-ID: <9092793c-cb9c-4440-b2b6-3e80216a737c@broadcom.com>
Date: Thu, 5 Jun 2025 11:02:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu
 tagged with VID 0
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250602194914.1011890-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20250602194914.1011890-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 12:49, Jonas Gorski wrote:
> When Linux sends out untagged traffic from a port, it will enter the CPU
> port without any VLAN tag, even if the port is a member of a vlan
> filtering bridge with a PVID egress untagged VLAN.
> 
> This makes the CPU port's PVID take effect, and the PVID's VLAN
> table entry controls if the packet will be tagged on egress.
> 
> Since commit 45e9d59d3950 ("net: dsa: b53: do not allow to configure
> VLAN 0") we remove bridged ports from VLAN 0 when joining or leaving a
> VLAN aware bridge. But we also clear the untagged bit, causing untagged
> traffic from the controller to become tagged with VID 0 (and priority
> 0).
> 
> Fix this by not touching the untagged map of VLAN 0. Additionally,
> always keep the CPU port as a member, as the untag map is only effective
> as long as there is at least one member, and we would remove it when
> bridging all ports and leaving no standalone ports.
> 
> Since Linux (and the switch) treats VLAN 0 tagged traffic like untagged,
> the actual impact of this is rather low, but this also prevented earlier
> detection of the issue.
> 
> Fixes: 45e9d59d3950 ("net: dsa: b53: do not allow to configure VLAN 0")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

