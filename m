Return-Path: <linux-kernel+bounces-889376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003EC3D6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6236D188D49F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748E5301460;
	Thu,  6 Nov 2025 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B/u5nQYC"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B22FDC25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462277; cv=none; b=rJZg+Of319tuHRPjF+mJ72/LEKfmWKqhbphql8cNaSoB52usArns7WtNbAMCcT6hEJ6jVYGdJcr/XHkiEMVkCffNK3bXHZc+3lcbD2U57qJCKV2AoTYkxzt+zkUN+nEos/oKNC7e8XEQ9xhT6VN+nSEJ84QLmgraWqhwkpE46l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462277; c=relaxed/simple;
	bh=9t3pSv0xPJZOknrNSk7qhoIPhDn3JeVjjG76y00eFN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iNQ1zqBsvOgrbW6gYgAvETvOFHeKw9V2WX7GPJ1CGVB0zUJrljJqVecD17YPl9hT0MIGXqj5oOgbJYK+1uZWItnDpxTKX1kfU3BoVx8Ylf354KfP39jz8vklYpA0XUyN0ra9282QeoZIp7RNR2FWoTF1Yx8M6fv8qVvCcYMVfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B/u5nQYC; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-431d65ad973so230815ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462275; x=1763067075;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaaO5Vz4QQWSkxbqCuHg6fzGeHTGukM8RnsOYsz8pwE=;
        b=hC/ZvQt45gIvhIw1pp/qY29iKnFF4xla82EBLr+ke9z8XYY3RXAZuW9rlEVkcfeNzh
         zxMWwIMqlS05PoE8n310T0XP8bvJZMOyJiHzOGfkXmjzDnd9QBJchQPww26s+tkSl+yS
         VmF39n3B0jrymRh6LdFDBl9/FgzPd8N4Iq6oUuwHieGw6v3AXKV7KpKcDtodXeTjbm3g
         Nhvj78InvLWCmr4h8r+IbPFwrfgh+FFzBMjmf1nYT7cwSVgyOjsvorWtqN3BybiGYc15
         TY41GEkatDT27tLoyLJg3S/NKDcy2KoDsynsve0XE9ojCxwXMLSnj11vcEZgc1Phd9Tq
         Cb2w==
X-Forwarded-Encrypted: i=1; AJvYcCUBe9fvaiKRfoQ7JMnLQuEcfIpzoyXr5sy9ws5TqMkasjDyxJEBPdZv2pALuv5GMeyMD7xAZE+2JmDjwzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKq9lUdQQLAmTXfX9Xn3yHnIdfNmp8g11GvBuHvUBTqzgxW5kq
	cjfz9gLy0hwAkxXGzkIuJmIF+NbmYj8rxRu/rl6AAdQDtdC9U14zsAOwcuFbwE27usll7x5A17M
	nBSWE6d8shGgUYqXCMBmRL9TR2twLt6sdrQzI3/FaASa7CkfIBPFriQlg9EPxWLzRCqGMmVAA2A
	/19Nd1TbXp6Plvc17bI4xhb+0jV3xNnelNCEuMSy3DXYOaGBhDvsyhSFFIkicr481qqkt6HXHOi
	2yACIUJ2aaFYj1VWFspWd/s
X-Gm-Gg: ASbGncvKlIzUe4pZtIscnK6Wk/zctrVnOMCc9YS+7WsLfJkPHsxd8YG82OEXS2ZqQmZ
	MkppRWpe+9DZOsH1UONBVCJzdqzrzsxvaUicX2MH3bZv3tSv28Xg99s1lhL/WSgc4OEJUTeZ5D8
	ZMZtCJ6uXWJzg8r/0Fifv3NwKZ5tzsl4ZArZJYV6UvepsWTDQy6RFnZ+xPVOPggtqA2THMnvLzt
	5uSlYPtIQM17SW1g+oyHpImNGSTSsa1l5GlpXWHxvQOsmp9iTlVehilKlxOaY/oqyj8m2Serro6
	2c8xuDXtQVXb4GTUZ9F1s4VV3hUTjA572xcrl01mbDnKZlVtWqEeU+aDpJeuUxubUcm5ZQXgLAZ
	e33oZPkVzL+FB6V/s2jtq6WJ102aejLiMo2f8+G9c59oyyvRXJ63q6bZr4nXuZwHnCdsgB0PqWG
	e8GjTkGTL+YkdxqBrgSmTm2tsQFPLF2J1YYtW5HLWcWQ==
X-Google-Smtp-Source: AGHT+IHSfEB/dMlowZRIKu6vEciVgzFtTyB6JFgcrsrajE/ATz1B1VBKTWtsPusbG/SqlhHerk5/GHoaOEAB
X-Received: by 2002:a05:6e02:1c08:b0:42d:8b25:47ed with SMTP id e9e14a558f8ab-4335f3a6760mr14625345ab.6.1762462274761;
        Thu, 06 Nov 2025 12:51:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f45c116sm2726005ab.14.2025.11.06.12.51.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:51:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso164140a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762462273; x=1763067073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YaaO5Vz4QQWSkxbqCuHg6fzGeHTGukM8RnsOYsz8pwE=;
        b=B/u5nQYCk0tGbjp+cHCw630C9ATe+8JjhrRBCLYpZjfvDvVlCfNSOsEaZvEhmRmImf
         Tcsdiv2jOoBoaWIHoZUfZN5lLDlCgTDSWJLFbQeOSMyfgbV+HcNc2MZeSQ8Frkp1tbM9
         CSKI2mtrOTQOO2JCh4vawTxuO57zWp+Y4yLQA=
X-Forwarded-Encrypted: i=1; AJvYcCXiQiqjTaCE0I+H6V5riiPRFSUCNjeRf4f6ZVtSm7pvQfRiFIAMBNv5SrpUDd1VDa87AcJRWVQsWFJDaZs=@vger.kernel.org
X-Received: by 2002:a05:6a20:394c:b0:2f9:39b0:fd88 with SMTP id adf61e73a8af0-35229745d5bmr1072791637.21.1762462273477;
        Thu, 06 Nov 2025 12:51:13 -0800 (PST)
X-Received: by 2002:a05:6a20:394c:b0:2f9:39b0:fd88 with SMTP id adf61e73a8af0-35229745d5bmr1072772637.21.1762462273108;
        Thu, 06 Nov 2025 12:51:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c6951633sm513373b3a.0.2025.11.06.12.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:51:12 -0800 (PST)
Message-ID: <af73cda1-b1a3-4b06-ad70-84f59b0a4527@broadcom.com>
Date: Thu, 6 Nov 2025 12:51:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/irq-bcm7038-l1: Drop unused reg_mask_status()
 function
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@linutronix.de>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251106155200.337399-2-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20251106155200.337399-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/6/25 07:52, Krzysztof Kozlowski wrote:
> reg_mask_status() is not referenced anywhere leading to W=1 warning:
> 
>    irq-bcm7038-l1.c:85:28: error: unused function 'reg_mask_status' [-Werror,-Wunused-function]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

