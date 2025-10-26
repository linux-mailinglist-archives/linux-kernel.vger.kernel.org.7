Return-Path: <linux-kernel+bounces-870581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607BC0B2DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6F03BDCB3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA592FFDD3;
	Sun, 26 Oct 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LorHSvIc"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD242FFDCB
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510110; cv=none; b=E0jj6KNdFgurBCj+Vt1CI96f2ExwvxH0Iij9nw+nJdbWJrtDqysgWIF/z0njnH3Q4LCRmwYpL6zgDAKAoC7hJ6ZZ1OsPZhb6ANLKLkjfko4s09frB4eWA/seTME8029JXPwSQhkWWRqNw2lQ8XknfpbWzVLFXOKUJhLWLn2FnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510110; c=relaxed/simple;
	bh=4tSahBmQN6jMzP2JQ5nDoVOyrZcYN3xAPDSgMy6+xo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbOdpQCRpgOUHTKRKYjjRCGn545JMSfV9qUDphUvfZH20iXrEN3KDqf8G9bUPFx9X6LMxAFmBckrTTFjWn2IiTPBkwGnZiKHcRtytViqrMaFdTzC23QJ7GQsDMzJtqCe8YfoQCmFMZthZGxDWEFM/i33Eau8qd+RY+uW+ThsUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LorHSvIc; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-87dfd3cfafbso40187556d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510106; x=1762114906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVS6LiUU36AQl8NmfGBhHoZlr4o5V+sFm0sfdWcZXDg=;
        b=UR+Dn83f+FKJWAf6MqqHqfBQeN0JcgU5tAUVd4HJHm+pQBfFUSnf8cD2wMNto+Ik7m
         gUJuUGmyhiKomjFiKLTTYG1stwk0QwsKbwah7r2nftdX1BGuTSkkGYcNVDYg5CKvKy1I
         po4/Cyl761hX6xLvBr3MZhJjbTm/iaZnpYAOrANmvF6iCsFqvRomGJpHQRzJfYg7oUeE
         JOCSF8kqvTq6vQcqJhvjVrVhuP4BNra2mnpzonxJbvhjV8E8nQ5PTUmQWYXh899CjakC
         uQnqCgMk6XKunOFFJQbqcvet1tXXjR/eqd+9yieFYHR6ca2iZBOR9sT9yB+aCYi9UhRe
         DAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZqiZYFrpEsAmtzpm616AvMn57ywg/U/QmSCd/69wi0mVC3IWLJj6AQ+ZSFgBwGpqxOB/wdmalfqIJ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFS+ZWRPyPasCwjg1tNVc066HNzDr2KDihnWtnq7pAS6ahTe0Y
	inxGg2tegScw626Mf5ZdMiS/++1y8m/xGGJPMiTjhuex0VCLRHyoRXnsWPsBq7xhAMouIIXJMjm
	BxZelQzNSzLiOgbJXyej3my2LsgBpCOrgrv97O9kkj/J3ub8/1M/4flCXj5TRNa+gMUvmrJP6+9
	H620J/pjxYqyomwJe+LC4wY19DNSJRTi5QWVwoGDB+Mwxw7aVkq38/ElrHOk1tdAJ1qlpAowP6R
	aaEeERIu0VtQ0H0oSpzfE0l
X-Gm-Gg: ASbGnct21Qk8QvwAyZijZr8rLNbYtfOajZjupygUJK8j1qLNUIUzShE4//wzT+NKq9L
	SUFg47r2CAj08cX5GDZCudt6yYIDYv1lpJTArc9Uii0X29upQCsWLDpQU4Q0bX9PmclCbhslcH/
	FyBJgxeBsxISOQB2qr5usQTAhU2bFAYH+XxZK/U71C+WQKvrUO79PjbYZE/lANAz0BLFfK2QdS8
	61D8KTH+J9WAeoD0wX/nx9gbuGE9IMe4wsLU5ykGOOvYPtXSRBLDNzkQhjFGfD7mSPjhET1cF1z
	fe7VQgw4V/VKFV7H3qDYv2FOPi5XJpI6e/qFNn1U0FzYrg24RIU1TIbY29DcJscWfdk9Y/eopn4
	QjPkjZjGrEwO53DsMMv1+Qg7mUWgRWvHFyWWmFcA/N9SJ2mHKwHj6rWgL/E0pQH86i/wMoTQflX
	mJjdRtRjZXFn0uSjKpoRQga0Q61GbgVsn2L4AAe6U=
X-Google-Smtp-Source: AGHT+IElqFRz8QtSuUf7cbDQVJ2uVT0NcoIMoOGeSjUIlO7En0gyEghCoOz791scOcCy9tjJqekZ6unKtPNV
X-Received: by 2002:a05:6214:8017:b0:87f:c46f:8c95 with SMTP id 6a1803df08f44-87fc46f9017mr64074406d6.37.1761510106444;
        Sun, 26 Oct 2025 13:21:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87fc49c2772sm5683896d6.32.2025.10.26.13.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:21:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a27ade1e73so2507267b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761510104; x=1762114904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YVS6LiUU36AQl8NmfGBhHoZlr4o5V+sFm0sfdWcZXDg=;
        b=LorHSvIcioOq2Jr4Qudbto7UAIxpJQNsCO4fC7nPgIkZ5H79ludiB8lnuvuKfAaz9f
         /V565ASwK24BB4ATbK9JHJYy7I1wZ/Iqkv99lSCS+O2JqcUICJPAMzLQeKDwqpjdOXiA
         AVeXAX0MoLfrpKOX/y2NPI4LdLhLo6Z6iyArU=
X-Forwarded-Encrypted: i=1; AJvYcCU5sGY/oCBZXbB5s/k7xa0Us/GomDebWhSn1PsQ6INeGz8+xTNyaTCWWJ9RLLQgOFc0VjDezNLpDtXjdRw=@vger.kernel.org
X-Received: by 2002:a05:6a20:734e:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-3412fea07ffmr6653458637.20.1761510104275;
        Sun, 26 Oct 2025 13:21:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:734e:b0:341:2fea:6b5 with SMTP id adf61e73a8af0-3412fea07ffmr6653436637.20.1761510103855;
        Sun, 26 Oct 2025 13:21:43 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049290sm5593723b3a.34.2025.10.26.13.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:21:42 -0700 (PDT)
Message-ID: <88c3c5a1-1b51-4b08-8b01-803659e9b1a0@broadcom.com>
Date: Sun, 26 Oct 2025 13:21:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: broadcom: bcm2712: Add watchdog DT node
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Lee Jones <lee@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Willow Cunningham <willow.e.cunningham@gmail.com>,
 Stefan Wahren <wahrenst@gmx.net>, Saenz Julienne <nsaenz@kernel.org>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <20250917063233.1270-5-svarbanov@suse.de>
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
In-Reply-To: <20250917063233.1270-5-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/16/2025 11:32 PM, Stanimir Varbanov wrote:
> Add watchdog device-tree node for bcm2712 SoC.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>   arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> index 0a9212d3106f..3094a8e69f35 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
> @@ -243,6 +243,15 @@ uart10: serial@7d001000 {
>   			status = "disabled";
>   		};
>   
> +		pm: watchdog@7d200000 {
> +			compatible = "brcm,bcm2712-pm", "brcm,bcm2835-pm-wdt";
> +			reg = <0x7d200000 0x308>;

The register actually spans up to offset 0x600, so the register size 
would be 0x604 here.
-- 
Florian


