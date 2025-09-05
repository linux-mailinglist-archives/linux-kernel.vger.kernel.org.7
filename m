Return-Path: <linux-kernel+bounces-803362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B764B45E24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18F45C8225
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12728302176;
	Fri,  5 Sep 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QgDe1SiW"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820431D72D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089764; cv=none; b=o5Ny3m3DBvY2nvfSiyYMjEsuamlwvlarrCnGCkN72oA4JNBIjyht6GZrxbYkL1w6vZgoHbmkTkOresiGzMLzklo8uOcN+VcEW7j82sWjKnUU5arI+LrU4vpJmTm0TBFBi13IaslFIVzmoBd+RjDlmd7g5X0KhPebKUqV1le8UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089764; c=relaxed/simple;
	bh=VCRprQuG3eJRVmXySnm1RY2bxZG15OWhzU4Qo2J1MAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOCSNZU3vUuY9jyX5fuburmqbO1oPpIGZJnQFcCgftypfUHNj6xW/+0slFK1YIwcP9MCh3bwIeY7M/u65QWFesOaCuD8EWNVHchJsLWg8KOqDLmDlLlDtoEgUJbNNbvCcvhHikaXJDISzGQ6p6Kwou8npm1CxZkJsvNDJxyDP4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QgDe1SiW; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3f663c571ffso24513345ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757089761; x=1757694561;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDcBS9ZQf09+Sv5HM5XXuVUarA2h0FYbmVQTBGicKGE=;
        b=YP+CpriQQ166wvwtO4fIy8y7mZHb2l9PadwkwMTG4y/a6iVJZI3ykA6VCyDNUOgLC7
         OsPMmz+sPsfuYzYyU2ykBGevpoKTTNp9ZoYRXNiZ9JZnOIJe9xMfjHbwNQFxP4/3cZkh
         9ExP05zkwEvKohArrKtKGlzUIrXnhebP0m1WaIukKQRcXKwC61s4PIjcWiPMDt2m7w/g
         dDWJsjL79iiokthdjVqv+XuLFy+R6JOE/AhQKNxkBDg9dvRONk52qMmVnNEK38lhe+lO
         AAN7BWwLJtXAGw4bqgmbGGDgAGPRdR4WdfM0ZFLxlZUZBAW1cSeeBN+1GeZMqUmTwga3
         E/aw==
X-Forwarded-Encrypted: i=1; AJvYcCWD28TgiCxPJ31pW+O5qvReHxk1mx6TJJ4Llmx0HwPudJuownhfjrSRbR6q/F46rF4Df4dTAhD5CjmQLYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypwgb88qcdbybo/R33Yby5dEn07pbs89hcRCG0Vw485ugMPJLJ
	UBe1Gvx9QBFepyiWfhIULJLFmro6Jr1K0TGzRGCJkB0E21CzWv/7C1MwAxPvnqAVL5QE4mmDQ2T
	6mWmun0pplV5bnDG14FDJ9Xh0SraEW9E51lYPSquKxHy0J2TLm3h9xt22b6gb09XF7C52xL2pAs
	EdiULK5dENK3vFrJjSmbnmBYykYqQX3SxzAku+YBUgT9y/zvS45CllznS+SQ7ISbc4qx2IhjcQr
	rQEjGUEiDRR8PXKG2WJeTg4
X-Gm-Gg: ASbGnculcitiU90v1jWYN7/cg2YilCeNNSo4MgtHoJsuGJSIMBbmEIztKk0nn4q+77X
	Z+5UlWQ+x85aFc/Kz7WhaNMqwGf8nFOtFGXU0SCx0yzC37+Gl5RighDS/ZWQweFBFg35Tb9p5fd
	PrBPz+EjHWjVnCNDuGPRV1/qWE80GGQztn4V8xMwm4y6EgN2QMBPRSY6+CKg1kCxU+f+vFR2WFL
	77if1D9wcBiE00LSgoeze9oYnEgoLCfWIMCNDo46SMB/L2JlCJElbsv6ceEwr88FO5SFUnswTEP
	oUCgIoN21DE+u/fTWnPP0hBDBVEoL1VQ1gI6nWMOhaVWxlJ7S9mObiF8SeYmZXVvKDgohl5KYVo
	LrYVKlau+0AUq4RJeMT/8T/vsJ82ffUcMnwIx1zv9syb5pYOGDY58dWYtD3d3JRMdfk014whxxy
	hzacHXm54=
X-Google-Smtp-Source: AGHT+IECu4EI9p6aUovsMZhh2O7Z3TYqOoUEDvkpKMoC1jpWXa2OlQnDjfyRlL1mgaaQglyYxUMMM4/Cd1Yv
X-Received: by 2002:a05:6e02:17c9:b0:3ec:df8e:6ab5 with SMTP id e9e14a558f8ab-3f401aee327mr349922325ab.20.1757089761549;
        Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f65ef02a67sm6380955ab.27.2025.09.05.09.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b32fe42b83so39151611cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757089761; x=1757694561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDcBS9ZQf09+Sv5HM5XXuVUarA2h0FYbmVQTBGicKGE=;
        b=QgDe1SiWPhWHACS5nyG2miIBgQ0gpfwVl9zJpxC2T4gs+puDvapUKXdx/pBHv32/wR
         YQyAo1o4vMcK3B8L1Ia7gNZXssBNezhMc0nmNQVRzhrWjSxuVQM/bR4O9CSUzXNL6fts
         X3A1ug+gu/CN3PYukv+cX6NFwIqoFo1IqU7H4=
X-Forwarded-Encrypted: i=1; AJvYcCWltwCcTEfWLeQuZh+f7nvri27ALqxBqxkjKg4C3hCrvCMFIabwWriRl7zIwamSMB3sf3JSI+csoKjYZqQ=@vger.kernel.org
X-Received: by 2002:ac8:584c:0:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b5edd3ebd2mr29216581cf.81.1757089760506;
        Fri, 05 Sep 2025 09:29:20 -0700 (PDT)
X-Received: by 2002:ac8:584c:0:b0:4b5:edd3:ddde with SMTP id d75a77b69052e-4b5edd3ebd2mr29216131cf.81.1757089759779;
        Fri, 05 Sep 2025 09:29:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aabb8288dsm497299885a.58.2025.09.05.09.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:29:18 -0700 (PDT)
Message-ID: <5e97121a-01c2-4a5b-a7bb-0034dc344768@broadcom.com>
Date: Fri, 5 Sep 2025 09:29:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] net: dsa: b53: fix ageing time for BCM53101
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250905124507.59186-1-jonas.gorski@gmail.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20250905124507.59186-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/5/25 05:45, Jonas Gorski wrote:
> For some reason Broadcom decided that BCM53101 uses 0.5s increments for
> the ageing time register, but kept the field width the same [1]. Due to
> this, the actual ageing time was always half of what was configured.
> 
> Fix this by adapting the limits and value calculation for BCM53101.
> 
> So far it looks like this is the only chip with the increased tick
> speed:
> 
> $ grep -l -r "Specifies the aging time in 0.5 seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h
> 
> $ grep -l -r "Specifies the aging time in seconds" cdk/PKG/chip | sort
> cdk/PKG/chip/bcm53010/bcm53010_a0_defs.h
> cdk/PKG/chip/bcm53020/bcm53020_a0_defs.h
> cdk/PKG/chip/bcm53084/bcm53084_a0_defs.h
> cdk/PKG/chip/bcm53115/bcm53115_a0_defs.h
> cdk/PKG/chip/bcm53118/bcm53118_a0_defs.h
> cdk/PKG/chip/bcm53125/bcm53125_a0_defs.h
> cdk/PKG/chip/bcm53128/bcm53128_a0_defs.h
> cdk/PKG/chip/bcm53134/bcm53134_a0_defs.h
> cdk/PKG/chip/bcm53242/bcm53242_a0_defs.h
> cdk/PKG/chip/bcm53262/bcm53262_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_a0_defs.h
> cdk/PKG/chip/bcm53280/bcm53280_b0_defs.h
> cdk/PKG/chip/bcm53600/bcm53600_a0_defs.h
> cdk/PKG/chip/bcm89500/bcm89500_a0_defs.h
> 
> [1] https://github.com/Broadcom/OpenMDK/blob/a5d3fc9b12af3eeb68f2ca0ce7ec4056cd14d6c2/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
> 
> Fixes: e39d14a760c0 ("net: dsa: b53: implement setting ageing time")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

