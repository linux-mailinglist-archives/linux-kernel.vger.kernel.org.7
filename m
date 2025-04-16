Return-Path: <linux-kernel+bounces-603867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2622A88D45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 22:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06F4189A5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825571E5211;
	Mon, 14 Apr 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yby1sByN"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95641B0439
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744663391; cv=none; b=Y92TxQuGYXmBnYRFFrMZWdgnsw4FXLVvhXlU1cXRwiUd53amulAbp9GSGCdFfAK9L7w2bWgX3PdskSMK95Km2NAuwLHBncxKkH+PcNGuoAL8aZLuZRkAecW4lS9SYD/C3TfdCJsz7O7NmeXi/5wJY+tmcaG0YqyC1qXqsIHti4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744663391; c=relaxed/simple;
	bh=9ColITbBrlH5DgQraUPDLwYtG/ZAx8A+hQdBqVFyDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHov2cuMkfzRJ1uwHATNyIW2S/VCdP5VfKc3Q0OhjeW2hWT5uVdYBMSdDNQBXDDnbDYZmVgU07a502kO/bmhn7Toj4l/RgjPuUjrEbqTtnOQf5O+YgjN9Wcl5VfjoM/toCAPk5MtaQwybqm3vN8oVSoPl6m2S++FjVDPmAAwiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Yby1sByN; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c764f2c223so1705069fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744663388; x=1745268188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aOkq5FSyDbUnW91R0wrHorOkMkgwDAeuLB8gRNWtbr4=;
        b=Yby1sByNa3CIuqjRhEvvmnQgRR1vFAdx4ivwvyJg/bDDCSRhVfO3nnYOxvpQjRO00Z
         36hL04Uk8zzj/v4bOvyWfYlizJra0JunrfIbbtI6McNHRujHIN0yaQuLLjBSzrGIa8vN
         6icbcnWqx3tteESEubr1/CiMDQZ3uxDTCM7j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744663388; x=1745268188;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOkq5FSyDbUnW91R0wrHorOkMkgwDAeuLB8gRNWtbr4=;
        b=AKM6t0uI66FJx/oXxqlxvgeU9M58XIeKMcBVfmANU6RZAyVUsqRudSQkgj4DAyc1b2
         uvjOq7pgVC3ey+lRrlj1XADHlQvkqpcjK+AwmhCE5iWfykktgkzoE3CZaicD9jxfA8IJ
         FjQJPzQn9neJlulT7SEOtK5osNzOPmH81kCbaBTQjmhjmsLOa+j8PA6BoQbT0lPvTx5K
         h66fNpexcllgseK4xDM2BthDucMM0FpSRUGl1hFQvRqeJuOCKASPoXdJnEzFsvHW2W0r
         WUUR3NfRm8WW8cexDCjPNnc9MQ+HvvBOgwcRCfn9Cd1rAPxuOhxn+e4HHARzsPZgWwGf
         Wv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7hpvL58OwZbLByVkWsqo5MdfTvQ4BV320H10NZqt2FhyzMZ7xcCYMOkO/j0pA9mEL4/cyzYzd/3DDKO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaKzjZaywY2PFokGBK4Z1Rtahxxf0TxqC4m8SNRcDKoWcKToE
	xsytWuw8yMRZzPwCpwFW152t/8WvRR1HZObyG5jhMxTgwvpDU8v2VLN849VGJQ==
X-Gm-Gg: ASbGncsuqJpzVXr0gmZTDHH3NIJqyRf+pNJYDuC34dCuRZ0BTj7LfhaujMx/mrdxEnL
	8g42Akp8DVLSbrWfIOz8e98/CDJXaVKBJNU4adR7cUTT9X23hRwOkU67n6h7nN+39cPEIlrhLod
	v5JTnE0NuPbBRL4Tg/Zyq7CWq85cB9zXEfSajIx5zRuLS54olfqOO6TkshsgtON1YYngrqfZsC7
	/ukdwfAgwbK/XyMAu14tTzog1lLj0BieOJjxCJf6TMCiun7jsIkCi9U4/w0JWOzX/Ybb8FONQx1
	KIpEcZi+T2UsE2v5BjrtNsbxowdpRsCoMtq/zNnq7M/zYtEX64lHZrgSNgCVpIRr4xykzGIji+G
	DDDH/WlyUqFKZXzE=
X-Google-Smtp-Source: AGHT+IGZxlvBBTlLGKx56wuZb5n432+A8U4G7xrFxe1WyLoZmAPyEhf/dxpWHvH4oPVEiCxDmNjF6A==
X-Received: by 2002:a05:6871:a582:b0:29e:67cd:1a8f with SMTP id 586e51a60fabf-2d0d5fc9e4emr7606525fac.37.1744663388577;
        Mon, 14 Apr 2025 13:43:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d0968ed148sm2521807fac.7.2025.04.14.13.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:43:07 -0700 (PDT)
Message-ID: <8f0f7a9d-c282-437b-8b9e-36277bfea055@broadcom.com>
Date: Mon, 14 Apr 2025 13:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: b53: enable BPDU reception for management port
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250414200434.194422-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20250414200434.194422-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/25 13:04, Jonas Gorski wrote:
> For STP to work, receiving BPDUs is essential, but the appropriate bit
> was never set. Without GC_RX_BPDU_EN, the switch chip will filter all
> BPDUs, even if an appropriate PVID VLAN was setup.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Jonas!
-- 
Florian

