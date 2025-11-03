Return-Path: <linux-kernel+bounces-883741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B52C2E3AC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315E43A928A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D52EE5F4;
	Mon,  3 Nov 2025 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E4icyLMr"
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E22EE268
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207927; cv=none; b=nK7za40VvKFRBM8U3goKqt0QnaTqnVCJBEey0uizsFQsDRtc2F7h2fpdKV8B3q0N7i2MCb3Jh7lwuK78wHdRWYX0/VBPNv3HLhwRKelXV4zXQRuWQBfnhEz78sf4CgguP0U0f7z/9soyd2tcpWiBxtmoZRMNxzZtq/amLXzUXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207927; c=relaxed/simple;
	bh=KNld0hPOC0rvgPmM+x1YqBqsiUtIYLq7mTzBOKAmv0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ0fYpJZD0GMjFpDhPDbaayM5ITT6+dkDAMHyp+2yx7E3CIsy9ikfMaZ29sFAzrqDZydhDxs6+E4Dz2lKAoTTXOoqo7VZhUMAHq2FB3Z+9p3S7XEH+sAbkBn1LoKkFSGo8OWWPuKGCEXQ1GlKOtHFvdV0IqPA5QCUc+MicF9sHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E4icyLMr; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-63e336b1ac4so7573944d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 14:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762207924; x=1762812724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIukxs2eDwE3mLXELpSXoxd+kJ/H0EaWzJP2uktACOw=;
        b=GtE6UiBD7HWDptE7W1cHdZ6ltXXdV3xMFevrcdcuSfljnhmEDSGtmmYg5fg4aQaAtP
         0ucq/+LrXH8i7BXKgoLBiN1TRtebQkQywmQboHHT+0Ye467eNn4byYxiYtuekrtuDF+G
         43DwE7VEo+juwuVleOa3DFlinOQO5V4bbe7E7G7zSYL3kr2qIyT9GVSMtpZZV2r5qYEy
         NeDFP3FfB/DMwp4GHtSmhtVJdt7B59uReMQhrNnjPogN9BRTEE4LH9L6YksMEuS/Wk57
         dGkhGJsl0r5+W5vwqx1oUOQbxWwqYoe+2UZ+Djj01LUS+gqR3VtCwxCaHLjU7NdocYQn
         BCeA==
X-Forwarded-Encrypted: i=1; AJvYcCXlwtD01c/NuHRBj7sCj51UCQLcpBxvyr+ZL+VOo4QfIrfkvARNSmj0RzvV70FADRoD+8hhmiiFTZ0cQKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3pmNFIHdsoA4XdC8FdpVsEApTuig9IrCgP4FvIGoAJPz4KPB
	jvFusFKjgSbZhQMxM3HsenKoXzX+nPoVQH5WlB2fRcgKAjmjVCGPd+3l7Iz+6UaCS4HJpIABB4b
	nx7607xNBh+VZfjYnEPdjEKnjRqXOJ9v7+aSDiB9tR7zQtvzbgQnxrBhYpL+h9AjiwD28u2sCIC
	ixOXecmLdPUFP5UmpgC5k5bGEaVqzfJyV+jcAx8eimdO1L1fZZXubNW/cfciiZHTwpd2PL3+eG0
	cmKWAgYpbFrCITEE2KrF5/s
X-Gm-Gg: ASbGncuOyRPg5gn9dPzIRN7mIxGRl+Ic7wjUdA/KU9YJXyFNm0LyJy7ff9IRL+WKsn3
	nQfse2ZQ+nbc7b/HCIQWVLZLD1zMbRzKfYktYAQJw1toi/+igDmQ60fgy495h3GV/h41uT2i+Br
	aA+F+pWyD8Z66wbq3CA/iNiPDcpk+0ikKdRKRG8Y62jbd69W/AKIpfuNM+fsED+q8XatBIID3jO
	fVnMHqksEAxRnOUtxGhIPGXQa+pTls46nXYYsI8YHo3IFN+eiIB6/6B8VloM48QuOI3DlmT8xKV
	15qPPDci4AOOxSfyIyBdIAo4KgpHT5x99G3q2h7RLopWEdVVlRxUa/oQzK4I6ZGMnN7bAeHPDxB
	FjImbr9fQdlKajLhYf0ndCY5SX8GAqifAZWgmPQ1HPpvD5yJZRbK/XLkBQ99wETJNjU07iBl5yY
	6EVingUEBHPn7az2rXb3DMh9+uZLz9ouqp270IpBI=
X-Google-Smtp-Source: AGHT+IFpHBLNgcMdvhmS/VyEGktkm5gq0VgAYPKbz216p/FFheUSeTNi7jvlXNiku0NNsuiyukBRxPOYvQ44
X-Received: by 2002:a53:ac4f:0:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-63fc75ac04bmr752748d50.33.1762207924345;
        Mon, 03 Nov 2025 14:12:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-63fc9425407sm16515d50.1.2025.11.03.14.12.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 14:12:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78108268ea3so5056722b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762207903; x=1762812703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mIukxs2eDwE3mLXELpSXoxd+kJ/H0EaWzJP2uktACOw=;
        b=E4icyLMrchO9kh82wzkDJRwJIIGED66UN7dERQjNCX+V2iZDAEc4otrtt3n5Qdb+lE
         RkTKTbzDlYvIeEyDYgvxbunk1+Q3cJsJhsu01nhLqcS9HGHGoUO5trLpBFs+apwsCDAi
         f4HMZPAblXIyuA0rA5+zSt8VCz4F4VLAuCABk=
X-Forwarded-Encrypted: i=1; AJvYcCUv3ywdmN3KGaddUXNsWFWeeLdLIShAvWpNfHmYBn6vrpptgRK97woKz+J/R+Ni/UjyePD9FufAScRQ8qw=@vger.kernel.org
X-Received: by 2002:a05:6a21:3984:b0:344:8a19:524d with SMTP id adf61e73a8af0-34e28829751mr1186793637.2.1762207903495;
        Mon, 03 Nov 2025 14:11:43 -0800 (PST)
X-Received: by 2002:a05:6a21:3984:b0:344:8a19:524d with SMTP id adf61e73a8af0-34e28829751mr1186775637.2.1762207903106;
        Mon, 03 Nov 2025 14:11:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893b60sm181227a12.9.2025.11.03.14.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 14:11:42 -0800 (PST)
Message-ID: <19e08c53-7e6e-40c5-9fd2-981675e85f26@broadcom.com>
Date: Mon, 3 Nov 2025 14:11:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Jakub Kicinski <kuba@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027211540.dnjanhdbolt5asxi@skbuf>
 <CAOiHx=nw-phPcRPRmHd6wJ5XksxXn9kRRoTuqH4JZeKHfxzD5A@mail.gmail.com>
 <20251029181216.3f35f8ba@kernel.org>
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
In-Reply-To: <20251029181216.3f35f8ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/29/25 18:12, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 11:15:23 +0100 Jonas Gorski wrote:
>>> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
>>>
>>> Sorry for dropping the ball on v1. To reply to your reply there,
>>> https://lore.kernel.org/netdev/CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com/
>>> I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
>>> which makes any consolidation work in stable trees very complicated
>>> (although still desirable in net-next).
>>
>> It's for some more obscure cases where we cannot use the Broadcom tag,
>> like a switch where the CPU port isn't a management port but a normal
>> port. I am not sure this really exists, but maybe Florian knows if
>> there are any (still used) boards where this applies.

There are two devices that I encountered where we could not use Broadcom 
tags. One was indeed a case where the CPU port was for reasons unknown 
not the IMP port, and therefore it was not possible to use Broadcom 
tags. This system is not supported anymore and won't be. The second 
device was an external BCM53125 connected to an internal SF2 switch, in 
that case, we cannot enable Broadcom tags on the BCM53125 because there 
is no way to way to cascade both tags one after the other on ingress 
unfortunately...

>>
>> If not, I am more than happy to reject this path as -EINVAL instead of
>> the current TAG_NONE with untag_bridge_pvid = true.
> 
> IIUC Vladimir is okay with the patch but I realized now that Florian
> is not even CCed here, and ack would be good. Adding him now. And we
> should probably add a MAINTAINERS entry for tag_brcm to avoid this in
> the future?

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


