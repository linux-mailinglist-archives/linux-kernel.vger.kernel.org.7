Return-Path: <linux-kernel+bounces-889358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2623C3D5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF6C34E5DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939032E6BD;
	Thu,  6 Nov 2025 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DANDgZ+l"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99D32E6AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461253; cv=none; b=g71lo/4EuNg2r/d4bw8nTg/uG4LLDEv4osqUF/aKayqkIRg1dwMvC/Ir4jflvhHYbypX/KqQNsErhWoPij9YpliB6gx75N18onKoXATJL/0gmk30tiHIFZMsBX+Xdtmg27/wOyXIXV7ICz4aybGjig0tI2l3lT3SWmJmfRbXSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461253; c=relaxed/simple;
	bh=6EYQTYVE/8/8+6LqWi+B6QjStsG0lMlB/gZzewfvXFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5kxzel9USwwC5qdP7Va33iJ1F0T878/LIuhWRnknxfit/VzTetg6jxeanPpuxaB35GdHR94iU0jHeSqGK/EmWsV1XVYPsj2Ns9j6h/l/8YNz3t7TCyC5OBAJMtDCesDWuvhnW/aRVXuBXlYLT73MgoIJF7bW4Kykaqnsuo+QXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DANDgZ+l; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-4334f402e17so197455ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762461250; x=1763066050;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DzkV34otxN0ctVlzxZXpqYiYjaDeaTvbElNgle63bc8=;
        b=pnSw9MtLWlI/xcuwck+bBTj0WnP5J7uAuI0Wz/8gSh4xTJW40Q8QF+RoXNn7MuGGCp
         EOMRIefqLl/JGeEpS0bF+JPcmPiLrwLVJgN765AeXzUVI8Zg6LLUs4WvRdIbSJwGWWPJ
         /QsVlMy8Bw1NbE0VsAtjDy65weYi4oL7JhFK15C90/31YTk/iLitIiOCjHJRt4gtJlzv
         BpGziFz+X7yB22DpdpmC5rqtqBVq/31M0tQmdvXWE+AgUZWnntw1hMZZHi0BvhDaEU8B
         SX5vH5NfjikP93nyddhTk+CUBSbRQOiGgk9fcllmZbr+36fLNn4KN7A7+y5e7EJO1A89
         GmzA==
X-Forwarded-Encrypted: i=1; AJvYcCWZN1Sa8vKKMkX2QfqwUx2CR4sY3DHa3Rf3YIBgx2rvPUpA2mgxppXE1QSNZlyYwJr9yaYwPQQB7jsgFZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFs7SyZ/jaUJmoXsmyd1epYZbPsPX4YEhoBin8WgfKupOWbsG
	U/1dBYvvOMnbCXJeo/+bNpe2dSL4lxJa54gf92jysmcHQiaK47o2ow/JWg9vq9mtbLYx9fk4cSO
	jVyJLlSBzRfWsTaY6Q9T8twAADxSJkApFWt+yVZQruwucCBX/1B7e3+JVQCPQJj2i0eaXJgBlii
	5BRdPTT/1MbTM+YMJY7Z4/ijXM+ulxUY0S8ghZoOKi16eS6/ySsu70cCAbwAZ+wIGTYyanWwQe4
	phWPNsfI/q2AuuGmkD2L9bn
X-Gm-Gg: ASbGncuFg+RT9D9j++arjqpEAyDHCHtV4L0HINFcj2NXu0BvTZV7JZEOe2zUfJeMyAJ
	pm1hHp0rlKw6hGBJwY17qRXHIu14kLxTDgdKIjJw7pjh8t7RfTP3+hdH0LSChSO/88iEKZ1lnUW
	ko5fQybxSQf0XrdcvO2TpWKQ1L7vW+rFQxJ61EVL7OXONtsADadpy0TdYAMhfnWxSw1LqRNsEav
	qcCu+Z/mJL2iNRo4BcySAn6NegQo9qi2y+uwdgayKhnnkJp9fOf9Zbq9SKjT5LE5KwaF4cMTLKF
	hSvqyKXd32Ymg4MmS/j1zqPFtPAkTgnpQTy8xiAHWjhhTnaUWy5O/6wao8tnjvAv86TLhVhWwNp
	Y0Z1VyUVuWhU/E754XvZuHcPFqNp5E4PLCHBKYSUG7ylyw2S++fBSey6cw9nKbJoeOeZyoNuvnp
	GIm4UzRS6SHIuPxo2SFW5t0IQHamHEzzb4caQOyC7PEw==
X-Google-Smtp-Source: AGHT+IF8zwqg8U8dPuzhD4Fg0H+AdVY0VgXRSl4MOojUzS2AtNJdAM6eQ5TQTnX51pcYLeydTB/cxF1pCLiH
X-Received: by 2002:a05:6e02:3f08:b0:433:3192:49e with SMTP id e9e14a558f8ab-4335f43b8fcmr11778915ab.19.1762461250540;
        Thu, 06 Nov 2025 12:34:10 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f45705fsm2738755ab.11.2025.11.06.12.34.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:34:10 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9d73d57328so34033a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762461249; x=1763066049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DzkV34otxN0ctVlzxZXpqYiYjaDeaTvbElNgle63bc8=;
        b=DANDgZ+lEJQM7x/a8fUxFjWhS31ALEgzMjyMZupHMEohB/WMPKC4ejtHEKcd/3dEaC
         +DCH281wf3xrHmCeEC6QysjxyVwMX8ZuxSQRhKzI/53626FPoHNdOjGq7zNXjJNXxy/e
         NF4jPi8rRJbIltaORobmPqrBFdN+v58xHu/o4=
X-Forwarded-Encrypted: i=1; AJvYcCX3dUSGBLctY+4a2pS0Aod24UByDfJJ61U8VBEFHPUERmBRuJUCGO9T/Uay/1j3wKmefpx1dyMZjwLHqGE=@vger.kernel.org
X-Received: by 2002:a17:902:f54b:b0:294:fb47:b62b with SMTP id d9443c01a7336-297c03be1cbmr9200355ad.21.1762461248975;
        Thu, 06 Nov 2025 12:34:08 -0800 (PST)
X-Received: by 2002:a17:902:f54b:b0:294:fb47:b62b with SMTP id d9443c01a7336-297c03be1cbmr9200015ad.21.1762461248558;
        Thu, 06 Nov 2025 12:34:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ffsm37038865ad.21.2025.11.06.12.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:34:07 -0800 (PST)
Message-ID: <c6aafc19-a3ce-41b3-b3ba-f82494f9c9e9@broadcom.com>
Date: Thu, 6 Nov 2025 12:34:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hwrng: bcm2835 - Move MODULE_DEVICE_TABLE() to table
 definition
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>, "David S. Miller"
 <davem@davemloft.net>, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@axis.com
References: <20251106-crypto-of-match-v1-0-36b26cd35cff@linaro.org>
 <20251106-crypto-of-match-v1-1-36b26cd35cff@linaro.org>
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
In-Reply-To: <20251106-crypto-of-match-v1-1-36b26cd35cff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/6/25 08:31, Krzysztof Kozlowski wrote:
> Convention is to place MODULE_DEVICE_TABLE() immediately after
> definition of the affected table, so one can easily spot missing such.
> There is on the other hand no benefits of putting MODULE_DEVICE_TABLE()
> far away.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
--
Florian

