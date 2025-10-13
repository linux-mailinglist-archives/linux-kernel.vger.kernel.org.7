Return-Path: <linux-kernel+bounces-850979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86E7BD55E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D4A5857DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5AF30C609;
	Mon, 13 Oct 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aYAu7Gba"
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD62153E7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370983; cv=none; b=eb07o9NJGx3k+Nc0xBQ/csKCZ0jwMjEUmdp2D+Uj53nSlMogvRI8jwiHUvwWbh0iIDjNfmhgOCVjhV2VXxgD7VS1tbA7e6ARZhbbq4oTmSSqPS4fv9BT8hSgyem3SPX7kOt5r8rnPlOb8szwyDp7dwIhMr3yj9pGMpwDaSFmDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370983; c=relaxed/simple;
	bh=pemIievJNNCJ1g5xdFFJ1javIILKcd6NEd/iXgi8QsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyDbOIEkzgg90dLoYUltTZRqLtR3zKqjJHD//fufKEJtY6AyklvVeVdhOXg+wlU9QmtCw4zP6d/CmzHJnUkGCCYCtTRLag2KG9P21y/eATuXvQfdyDHLq9gK+skIdDZMNvu8g84PHB6/ffjFjlaBlTKEU1JdaF3Drcq1h5tpbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aYAu7Gba; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-78af743c232so3945281b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370981; x=1760975781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U5cRT08Cc58tjcfZAhfVxmou6fbD5UUyDGJPQj/wOw=;
        b=rEv6ETo4Gn6bp/F5jtm8Yb37BfURLfRlLFZMAt65ze7nBv46oSYK8B6qqgvddpzF71
         brNi6exNXKq0PDfQ1q9uTB0AP+2ggaLIOMwV4zP2AM+ez66kcn2hheRVPJcKhfe61SuG
         Y6AKi8onYEKCSJd8+LqvaAzOOTD5yLpHZ02SQEHrGxaWbS6xcr+6jeMHs3rgTmZW/ytJ
         1AaKGaLD4sbrPv0hdyZLwaF/HusRIIoYld0JUSy2I6I3Ph5oOZCJN7EB3ubAzi5j6dNT
         NPnGYWK6wCjXIjd9KnS9To2LtagoU3nrYO50611vz7SgPzTpHHhYA0mFww1umRC82HDF
         6F6w==
X-Forwarded-Encrypted: i=1; AJvYcCXO5i29C/4hQmFwZDO1QX3sf/7tnKQSgDJ8kASPAKbwIFVk1xAFfaKJRI2yG3WE/xVvMdxdyxjd+hbZi1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdTm3wzbmwO7zN5hycGJnc6vMiGHkTNmoddI20A+jxpcy8tfH
	+ozq4bwOjqSXIGcZCD7tgbo4o9Nbdh2WgRvjMm9+PXBmDV5eDsZzK8XUJVZDzu8m4kHVO/k57Co
	zAC+J7PFep06zqZROVOVD7E9TXxr6sthR1xmkvQY6Ayrb/K/pAfLsnJU/+rSPG+K6IPY8dY1gIl
	eWqUNQ5mhxeQMxWOE9y4LQPnwKV1xKAE1gomPTpeVa5nRvcBqVhKVzHGfhRvx+Q3J5sYpFGyvad
	DTGqsVj3wf9Cov6+SpaaDSF
X-Gm-Gg: ASbGnctiHD6tybALXCpgsYrh7ngUsnzSyWQAAJ/2AKcpy9h0ql9s5yS/SrAmLbNmJH5
	8HE68HoEeEt7iKuH6frZIQxM+dls9LPPzha63r8JGWmVkB3TSHNk7x8KLjPv5/qwTziVp3UGcXp
	FKS+cySp2KYr4rzlF5cTeeX4N6ekc40wPOWaiOyq1ZRCeWtypTBLu9/4txwfeIM08jb0CoZLlWD
	9HXHvdkGX7UgO0KyklnilH9fJK4kYBD32a2J9B5Jy/DuJ+rQQfDlKcxrrYaURF7x/WohcMm9lmN
	vrU0Aw0BGsUSMulRFbUA9jOUnltv5F0R8l/v6zQ+N/YIjizuOcqu//dIQfpYr4SRfEWw51pnWta
	K9gXLZH4Zau4Uj7FfTH+4hObpR1iJMpaXS7NnWX/wl3KaO92Y7YcI7MMgKptvR2t1EXVit0u8hD
	xbeWBn
X-Google-Smtp-Source: AGHT+IEzbMMCk7XFJ/fwZfPxwzPWIiku6cau5xsxgYRC1LEvLKI7EOPdG4F4xEvfjribCoyibqQkU06twlB8
X-Received: by 2002:a05:6a20:1588:b0:249:3006:7573 with SMTP id adf61e73a8af0-32da81345f2mr27879831637.5.1760370980897;
        Mon, 13 Oct 2025 08:56:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b678df0fd68sm602214a12.11.2025.10.13.08.56.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3307af9b595so8085278a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760370979; x=1760975779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9U5cRT08Cc58tjcfZAhfVxmou6fbD5UUyDGJPQj/wOw=;
        b=aYAu7GbapWSGekXstZrLdAJ7lmUfTmtHUk5ZRCF2a6ZzxdSZDkG+VG06YaTYhD9fdQ
         8N0sdKX1s6zp6HkbAVCpLgoHdJoyKGPOK1YVhA1fTInoGGZ488Oq4Ly141yJ+6y4yoWT
         6W30pPoUkcSHjeK72StnaxUjqPb1+CY4FKpdQ=
X-Forwarded-Encrypted: i=1; AJvYcCXA1lxTthLlVzBvvUWre2NIDr/1IPXibzyWLYCEcMMjfBd+lLq5mnhnDecfOdmzz05iNpdNvZ+Wd+F7y0I=@vger.kernel.org
X-Received: by 2002:a17:90b:4f8e:b0:339:ef05:3575 with SMTP id 98e67ed59e1d1-33b513cd915mr31842492a91.26.1760370979089;
        Mon, 13 Oct 2025 08:56:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8e:b0:339:ef05:3575 with SMTP id 98e67ed59e1d1-33b513cd915mr31842461a91.26.1760370978624;
        Mon, 13 Oct 2025 08:56:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb72dsm12472857a91.14.2025.10.13.08.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:56:12 -0700 (PDT)
Message-ID: <bf25d367-e98a-4475-b09a-55d6d47e428c@broadcom.com>
Date: Mon, 13 Oct 2025 08:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] irqchip/bcm2712-mip: Fix OF node reference
 imbalance
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 Stanimir Varbanov <svarbanov@suse.de>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-2-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> The init callback must not decrement the reference count of the provided
> irqchip OF node.
> 
> This should not cause any trouble currently, but if the driver ever
> starts probe deferring it could lead to warnings about reference
> underflow and saturation.
> 
> Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
> Cc: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

