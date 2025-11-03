Return-Path: <linux-kernel+bounces-883382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A801C2D3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95D0F34B4A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7397230DEDE;
	Mon,  3 Nov 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GopdNs/q"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE4319605
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188559; cv=none; b=mkTfOWFx92IKDgJlu8UV9GFRdjCraHUTP1OUtfjvHmsqanLCHo1efSZUvT7hULVP6/KNam/qAEGgpsRoy3wO/FEEH6IVZCYIJNYCv3O4EBD+q79vzz3hmOCH2iRWHr/Mv05vzNVGZgMAVvhVLRjf1K0UymlkaUbZHMvvKQG1GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188559; c=relaxed/simple;
	bh=ehGpxSuBgfBOKgPeo/kH+fJB9QB6yqngXkefpVgDlXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CB8jzJzy3qqHD4C+zH+XwR+fdP7DFfe3fy/u2J4Wy61iVk7+SkwMw1h+fb4h9UVIXQG9kcu+8TAVZ5JeIGeSS+hGhnkK+IDfoVXBoOzasF/ZX6X9xpWjSNiOVwW+PFwZk6kbwcHDJzrbRb0wNnP1gR9v3kfHjqlx7oOFN09Kjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GopdNs/q; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-29555b384acso21681825ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188557; x=1762793357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgUwdfuZpXqy9lYjOTOW63pOPjpSJgOLcy0yCGYOUWw=;
        b=M4my+QF8WUkDfbqMnbhC42vvv8Fv5HyrBz7bRkWeuUfyF9+wJzv7cJfFk26l3VZA33
         ypZ23WtDhxO85b4iwpNc6wOjghvX9I/ip/dCZdcrpHwy3IyyXg4nQaHxDO8OJVTytIVI
         pfcUGg9YEICzkEhPwE3mnSJDXLyJRqkhRS73Xss2Wqv58LjnARY3mw0P7PryoHSkeURM
         d3A93CoPERlyUpRoNlbJ4rV1z7/K3y0yUSMTVLQZXZ8v5i/WcMrOO+Xy/1rNWcyW7w0J
         4T4UlSB99+Zk1klNtawqHhV4OglfG6K9PzQQz+mkINOk+WlkFxpZA/tcvEhKnYQlmTM1
         PTNA==
X-Forwarded-Encrypted: i=1; AJvYcCVg537d3Dl09exihOtaVKq8fXCqjPf/r4sGT6KZti5/deF8pCOyCdfHUBMJoMpYVu2FwyJpb5Eu2pB6EuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeIYSmIqh5kFa7OxkFlqEUSPMV0hzVyKNt4PQpzsXypcF7Iam
	nP67DXseTyYc6KJ5WFvcZMkmglPBOzuC2+EUlfFdKqOIePLGyb3y1y5p+OYGyAr9TRpf/O4tr7w
	FklcZ1EuMiGO+FV4WLHYTm3q+u1JDDhD/qUj/RqAGUOjKCP24U0RbW9AirnhsPFcCB/ljDuiQgl
	QHmACJMWG9moKyY0qlrt7pFvvGYlK73gwy9rEUesBcnG/gtf2sqYPlr2o+gGr8ZxjTkm6xD46j/
	ShP0wGZn7cMTdrUhzjk4kqJ
X-Gm-Gg: ASbGnct+b8LPQ4M+inmFleAGVT+fI62lU0ytDJt7Vg9mQhrKhzJTp5RGxR+E+6Pao1d
	8w3y0ovjUX15xJlAhXlGTSXF3V25+o+BvgA17J4VqmzWi/UgMuirVHXNDNi9ygX3UATSOAtAAsA
	Rr+wVs0RdwgD2+A6cDEqrL70+zPX5ysAR2bc50o64lhex9JvLl7MXR4sEVcmBKlb247+1H6EbwW
	p1SiNYqkCxbmYZW2skv6wEbpkme36PDmsTEgXRakbOm8r9F+zP+I4lSFYL/AJcBWTtJEQBa6IAf
	7+SAD4Z2U9yOsMtrFPZXdwJn+EbFR1MyF8eJ8tip9m4d10jzFr8nf0a2Em6jZsx5rrHRILzJVGC
	zSwotnFoOsKmPP2NMUvJx6t7N7XXnTQrBJFiIOwvnG2nt4LOFt5dcJ3UbxkQ4+28hquReiBTUGZ
	MY4l26xIzh13Sqc2prPpGToZztdYI9r2AaIqilqE0=
X-Google-Smtp-Source: AGHT+IHIigtLYpFTSl9rWIx7H+s71O6b+YWADox44LS7tNENr7J2sfwE5dFqFzHZwF4lKQYLPEuVQOWUs8Py
X-Received: by 2002:a17:902:cec7:b0:295:5668:2f27 with SMTP id d9443c01a7336-295566831dbmr110584845ad.9.1762188556531;
        Mon, 03 Nov 2025 08:49:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2958dd2303asm5852585ad.61.2025.11.03.08.49.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-892637a3736so1520673385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762188555; x=1762793355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FgUwdfuZpXqy9lYjOTOW63pOPjpSJgOLcy0yCGYOUWw=;
        b=GopdNs/qu/ihqi5yUFN3zH4NHN1PQLgo7PWWQmiJfmlSdmnNBI+nCMzQquBIIzvQv8
         lmQQy2LTHh3NNmmrpoAw2qLh2cXQTQjugLckl3nRSg3a9hI4u/WcEiT1lB7GIkgvlHAv
         OtSWkgokLqtU5BJLKZPVgxX18Y/CSi/tcQuDg=
X-Forwarded-Encrypted: i=1; AJvYcCXy7ZCbH942iiA2XfKrE7W6Yw6Q3ugiZ0z0L+7lzwIF3SuO/W6jBZd/xn4Ibq4BlNdn/zssfMYh7oEUGi0=@vger.kernel.org
X-Received: by 2002:a05:620a:1aa4:b0:8a3:1b83:fbf with SMTP id af79cd13be357-8ab99498c48mr1518206085a.21.1762188555491;
        Mon, 03 Nov 2025 08:49:15 -0800 (PST)
X-Received: by 2002:a05:620a:1aa4:b0:8a3:1b83:fbf with SMTP id af79cd13be357-8ab99498c48mr1518202185a.21.1762188554983;
        Mon, 03 Nov 2025 08:49:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbe610bsm1518821cf.13.2025.11.03.08.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:13 -0800 (PST)
Message-ID: <ab0e31be-47a1-453f-9d73-26b8d02bd882@broadcom.com>
Date: Mon, 3 Nov 2025 08:49:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: dsa: b53: fix bcm63xx RGMII port link
 adjustment
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
 <20251101132807.50419-3-jonas.gorski@gmail.com>
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
In-Reply-To: <20251101132807.50419-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/1/25 06:28, Jonas Gorski wrote:
> BCM63XX's switch does not support MDIO scanning of external phys, so its
> MACs needs to be manually configured for autonegotiated link speeds.
> 
> So b53_force_port_config() and b53_force_link() accordingly also when
> mode is MLO_AN_PHY for those ports.
> 
> Fixes lower speeds than 1000/full on rgmii ports 4 - 7.
> 
> This aligns the behaviour with the old bcm63xx_enetsw driver for those
> ports.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


