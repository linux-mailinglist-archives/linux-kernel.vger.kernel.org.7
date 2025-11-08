Return-Path: <linux-kernel+bounces-891201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF9C42238
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2ED24E9118
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57A28134C;
	Sat,  8 Nov 2025 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e7cwbkzO"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0638DF9
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562530; cv=none; b=RFlnjV2lhXbpY1rmo7yauaqD8VQlmhoAzSZx3jm2zsQe+hqUjdwlgLj+vxAsCRK74fZClPkOkx02MplZFSbqhS8EAoqWciDgUWp1pH6t0Q5UY/3hM8iJjzSXj9RtFmNrB6Ooc/TdXE112QNIgENh0Zu7hph20dngoAu2OXTur5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562530; c=relaxed/simple;
	bh=RqSEmsSrmn3ekH1xzszFwWtndwtsf4LaLFN7cIC+PjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahujtE0ZhoMOexligTHbQUb2mvir0iOWKjzCE61lrXLj1oA1BpCMY8wgfcvNrjNvRuSwXw+XowcE32ulHbkUkjoVxJ1+Nl6AY0T5W73KFGtvCPIyUpprblhS6YVa7O6janRLJDJcPVN1OjQqOV8GFF+4NWJaNpBaS+tZ7L6CfbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e7cwbkzO; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so41576239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562528; x=1763167328;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZgSG4cT9Tkyb9tLiGAUt4a6iC2Esjg2UMSFHBvmT0bs=;
        b=FJB/I52sv5cUAfeIWdwI0kmP53uFvT8/fUwCL7uevTLOxjxZmbf/0W0wKQUGfoO+qo
         fkhxWkvQ8CI/go300HRJVPOAOAZIami1cLTJuKpaxVakwRHEQmwdDRYcP2p5InAPCcMR
         Sy3ZFk4NOpRkm1oWmAFqntOPJqjgVbSPYNa8n/pA5uN52QvnH5t31RBeouaW3CprA7m8
         /GqJWcMYOE+9qSWe7L+6wMY35BwXRB1YMpwoT30YDKDrfUSPQGsadKN6ZCVvkXgInFiO
         hTEUC+B6gWOKQuBk8JeuAha1lNUTcLA/RBX1NllqaPzWBggNXTCYHcxTl8w+kwfD8soB
         Wf7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIgQGxyeYDZiwkx9My210/sLWWDDUx3hOi6YRgZlQF9bMpz551PF7i8UIZQaC9nSWf6nv5/lEqlguwVGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSZIe4U4E4bt44mW9260Wc1o6A5R70Jvsa/mTbZ9yPPM6TNUm
	xoF831Yr4f578r2TZBDRsLYCpFLDZlEFznnFNfLR3Q8dH2m1Y1IYDOBSTHd/1vyehcdbGF7Tq8H
	ztMzjJ6kRVJE5rAxq6TP19U0XhPlECfN6p5Mgcmy9h0ftkbR3bJurIgW6fsnbbYJXWBPSOPeV/+
	cxFadx5dvNsYDDgb86VxRNnlyTRu+sEz2gMjB5o0iAkKNfF/cLo7oT4M/cmYbMbHRH0Lzgp8val
	UXkZfiBOkbIB6y1qze6QRaK
X-Gm-Gg: ASbGnctHISRU1uCP688/qWFzX7hW8AW0DurlokNPlb1aIAo92g3MUJFT0Nzus48JVKT
	x4A1q39ONhzozSCFlqgKMMSeCRGiEqDEnl99QKzKI0P5xLY9lBocmbDs97+19yT72to+mMkVmJ0
	vZ1CnOYGoTYhe95OzynF3nOADj7pN7qyqViXj7DRB3y9slJXo5GDvR1RU8spGV09HndAdP2k2F3
	Uwlyj7e0r77yc5BCfcgH2DnduVZXQw9fOVFfXjVYE1HRrU9XeGITxtOmPVnvlf9Npjd/pUckJqe
	udSFPxgJ7NXyIH+L08qAtysx+EgGLPwaFI6A1zWdbUC0/qCviVtWKUC/w4lXlKx2ycOUbGEmFWi
	Unw8a/o+1SgUTFrg3N7leUETOrbZCeM2X4t4xchWVAHiU8I9ZJv5cKmbj3SO5fOZ6PK8LBFZEoH
	QyWlCJWAJFpuEoEyW8zE6648dM/PBsC0HUN/TGG9Y=
X-Google-Smtp-Source: AGHT+IE3JvaWHpeFuS3RsJmGkVEo52r+CQF4YlyW9YyiupNrajYdLbqVeR9c7esgR5Tab1Dx2SSdyzKcoEPK
X-Received: by 2002:a05:6602:6d0c:b0:945:ab97:6bbc with SMTP id ca18e2360f4ac-94895fa8c68mr171562439f.6.1762562528495;
        Fri, 07 Nov 2025 16:42:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b74676a695sm755815173.9.2025.11.07.16.42.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:42:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c28cfe8573so2493463a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562527; x=1763167327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgSG4cT9Tkyb9tLiGAUt4a6iC2Esjg2UMSFHBvmT0bs=;
        b=e7cwbkzOYrUoiKa3DmW8/49w7ohObnksKJDbe+dw+knl8JHoObvZvHtNWQN/ccTcp/
         MZD6Y4hDWqKdXzuBN3DR4/3ebIYsRpStiBJRpXimxGpEGw5DxRP8SQ27pphEjemYlYTd
         E86OdvaSstDeleJkCNE3bAUcROzJKJQqk9gCg=
X-Forwarded-Encrypted: i=1; AJvYcCXHMxoRar6QEE+Qrbp4CDPBnOnJGTyT3yDX5OQe67Mh2Uz9DzS4ITzOfC0g+X10nGeZDNwF2XxkIiVptGQ=@vger.kernel.org
X-Received: by 2002:a05:6830:2704:b0:7a9:13f6:360c with SMTP id 46e09a7af769-7c6fd7b1312mr674691a34.18.1762562527613;
        Fri, 07 Nov 2025 16:42:07 -0800 (PST)
X-Received: by 2002:a05:6830:2704:b0:7a9:13f6:360c with SMTP id 46e09a7af769-7c6fd7b1312mr674684a34.18.1762562527328;
        Fri, 07 Nov 2025 16:42:07 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f0bb55sm2401864a34.3.2025.11.07.16.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:42:06 -0800 (PST)
Message-ID: <748b8fe7-8b24-4f71-b5d6-d295709bfbee@broadcom.com>
Date: Fri, 7 Nov 2025 16:42:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] net: dsa: b53: move writing ARL entries into
 their own functions
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-4-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-4-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Move writing ARL entries into individual functions for each format.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


