Return-Path: <linux-kernel+bounces-850984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD584BD4F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FDF58619D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86F2FBDF8;
	Mon, 13 Oct 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fZOuvW/9"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48546310764
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371042; cv=none; b=aFXbIu4yQJsO79+OUQNjhbxKQJd35rP8S6OF00x/ik7iAHleBh/27Jyy4q+u5LZSkwHdcVasdKUCch29T39C/qKDUYArY91itDUBLJxJhhtQV6T42IG09t8T0hYRpzQvpgSA5ivPjIPvTV01cUCUaJ4CYbBWy3+CozVZcYS93aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371042; c=relaxed/simple;
	bh=qYzNG9tt47B8bglnMgi2mPXGE79/NgDUjb8dqK1LBso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR3jp3uWLeKmyFojcmZSESLpqn982S+TOyj8wPuH2Mg2k81S5gQkACvHSb0OG4TTN1kHA0mdQ/z9JzmhEwvGMwdtjkG4hqt/rdmOTgcCILRWRY4OijFbOX4pbbBJMCyzpfrMOu/YzV1sa4U0Q1CCJVr6vcuWUb8d6VLddoWTgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fZOuvW/9; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-42f90b88beaso16511365ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760371040; x=1760975840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnQ3/YncMSuAlD2Cx5XdWo0bo54hv2NEfG8uAwAPs6Y=;
        b=OgHHzkBV1IegEpM0Tb/sNLn/uIsSHfQlPa7MrZ8iQ1fVQRdYCy2BnxY2bgO4Qy+W2z
         TatqTsj8U/9sgyJW4iApALbvUTeRe221IVcwdb88V0j5DWtYMM9Ly/hwuLWuq7dgZmDp
         HHCOlpB+EZw1HlmWnQHJ3vq9vdXZFA2x85TpR0Oo2M0CKVfyf3X3QZ39cDf7flUhdBYr
         4itgWjScE+jhAT9W3CMgd33yDU2b8g2D+PYRHktUrARlCBAVy0i5cRSve1TKiDFDAl4z
         bQO/gV8/oMCfCHXlqqqEq+rPVcTANomvz3hgj8v6FAfvu7oFxjNbrDemMGowRex2Zlqg
         Uk2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEUW+j/ToLzKfa5QZHUAYDYx1UepYTEz2ET0fPdRYA7d5CAXQgIosvukcbHH37cZ3ft0HneR4mS5LjZmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6NZcRBQQwPKUGmJzdWPIxLCE7pg2OshIc8KH6LaIdxC9u7Hv
	HkA6JqcjFOcVzDDNRRxUw+EcnQo+4OzUPLODWqhXsjq5t92WgBNPVe3mXNir21uenoA88Pjndj7
	3CIf1uejPDYP3w2roIAarzkhHUMWFjMVgiLYxA4Eb5872KV5pTDdFNNdmXPAb+psHp6cIwsisbV
	UdfuQVuJm2WMReXLAxugZ+toSdhmjJgOI1iibXwWknlg1DluEIiwjNNVNqLP2gvtxIfyj7tkXbW
	ZZicwp6XZJVW/RhyEYdKhpL
X-Gm-Gg: ASbGncszbWB1+sB12wIcO7NqW1mKNJ6w9EyILxrD63r/pcrfvD3oIgS14X4Mxzg6sHy
	sDRlc+gF5fqJZ/dfrhuVmz6Bt97ppEtsI8RPkY6LLsZi1cvn2TZSY4INXsxRfcc+vxLV41Btx8A
	cl+Z55nF8J31fGd1xoUO1IzPDxqUy3SJnuTJSZtUUDTBuyJJkcV5zmIqdv77GimyTbrL4UMmCgC
	yJY0oBhPEcPuzLNhJY9v8XwKP7vjl8CMdgMVi5Zrtzbm2t3oy9XDkGcOK7mrE41QGaElI/EL8i1
	XCDWDKlT4YKJn8Y5dSTrwAprntAjp+xXcjgMNNBFXqECRbbGgk8sjc99GdtLyIwa2nkZUTDyneY
	CeYPmqIViLhSnZT7a77/qVXeG+fqsRwgwb0q63o1WwO073H0evKnEAM7ojm0Msigy5XnB+YMgTq
	QAWWpzK7Q=
X-Google-Smtp-Source: AGHT+IE6anoptnpLAMyYN4hc1QIFg27/PsC3haetNNR/mPqbLNDxFBNTVoIHJXZAtAQJ7hcgegNegzgdo2u+
X-Received: by 2002:a05:6e02:3e02:b0:42f:94aa:ac06 with SMTP id e9e14a558f8ab-42f94aaaef4mr163551915ab.18.1760371040114;
        Mon, 13 Oct 2025 08:57:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-58f6daf4393sm802210173.17.2025.10.13.08.57.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:57:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78038ed99d9so11324536b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760371039; x=1760975839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QnQ3/YncMSuAlD2Cx5XdWo0bo54hv2NEfG8uAwAPs6Y=;
        b=fZOuvW/9StqLF2k/0Sw5Q1IuMGxqAhqZsao8Eq6vYzSzRgCD4Qqptr4H+bOqdRmZF9
         8MdoT/GgbgHYDrdG7jK/u6LPdt4HWdTmESlurtS1Q0wlX/g1j58L11Xr39J0keSCbjy/
         NBRQLu7jR+JKa0Op5TO6XrwvKxSgbfp9JzA4g=
X-Forwarded-Encrypted: i=1; AJvYcCWK9udhOoOHkztqbXI0phkrRo7lHXwC344xPC2p0ATusLQOn+V3yqH29h5lduBuu2l4rA5KUw1d7juo8IQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:1954:b0:784:7275:837f with SMTP id d2e1a72fcca58-79387435d78mr25333985b3a.26.1760371038819;
        Mon, 13 Oct 2025 08:57:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:1954:b0:784:7275:837f with SMTP id d2e1a72fcca58-79387435d78mr25333960b3a.26.1760371038330;
        Mon, 13 Oct 2025 08:57:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd851c2sm11892087b3a.81.2025.10.13.08.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:57:16 -0700 (PDT)
Message-ID: <e25bf5c2-c703-47d0-87bf-b5d9cc700cef@broadcom.com>
Date: Mon, 13 Oct 2025 08:57:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] irqchip/irq-brcmstb-l2: Fix section mismatch
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-6-johan@kernel.org>
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
In-Reply-To: <20251013094611.11745-6-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:46, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded so the irqchip init callbacks must not live in init.
> 
> Fixes: 51d9db5c8fbb ("irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

