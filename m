Return-Path: <linux-kernel+bounces-851155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40837BD5AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79DC40842E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500A2D3A6F;
	Mon, 13 Oct 2025 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dunCf8cx"
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A272D323E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379316; cv=none; b=PElcIqEBQwktnC/wr9rPiypvBLrI/4RUDimAMDJrRAnaI4hZAV2lhusoTFrPUoOBfeTY1c8ldjaXXert2UpPwf2otn/wKS9NtPRHh20WTaQJf5JjYAn+cpDKqHhZQKz1TuT5VxXUMvzHgTyZUC3vb71zS12OXTliP6ydyQ0GNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379316; c=relaxed/simple;
	bh=NWRdMU9u7gR7m5+1dihsR8wN3vHaZ3K+2AlMbOkqqt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6yCKUXyhP1oXC0OJb6o03zVe9A1j99a4Vj1iD/X2zFUNVx1YLD9cAvFAvH5l6Uzwxo19u4awtV4zvPoy7I+/M350LeHgKZ6r+m2BaWoUorU33Kx5ZKys3Lw2a0+aVzWVNhrzaUnquHNW38ZvFUABKEPXD5fstM4wkgH68sbYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dunCf8cx; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-780fe73e337so50786377b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379314; x=1760984114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFxXctdJJT+BzOc0txkC/Z5lJFQXl9VPAAzfx7IcY1Q=;
        b=Bz1AnX2qQdWu4v10GSrHWcm3A/e7TuP341RJ6ddncU6vBD5Qm95ILSzmg97m5Esg5a
         elJDykjwAXsU26t0VwmZTK0nUR7dkSEh0XcVqTZLr2dSfhAbyO4cE23nsnQGnVck5GqM
         Bdz143MzUtHCoeLnmpa7Kwu8oZN2pYhxN1iMt41xNVo0IkINl9I1Ce81x1B5565zFWYz
         okIlWXTwEdrSnqYMaYmwvO4/qgDl0Q0Zd9SLsPUKp4QhzvJ76H0+81p/B71epSLMyyTa
         OJPTk4g/2gUN9aM4BPWAfzB/uUEn4RlZvvpsIqrhqjcSwC6zPBkU2JqlBYIYTFYaNI63
         rMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkb9UexucC87+Ei5mw43aEaSQgwjW+QQthd43FEgGuhIAHnX1wm1CBiywvJPYFhuUWBCUbrgxIp0qCyBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaNNgJIcvyLz+4Xb/7DorTqaVV84jP17dK6J5WiaskyiT6Gkt
	cuxPTrgPr15lQ98q7ds91g00HVgyB1Z9++l/TRWJP99auKSi5rc8FpJnf/L2T1DAg+YcnE3exyV
	YOZCyzOgFKuhzGfb8Xb3WYBl83T+JU3ZsV02OJC/6SFJicpV8cAAXe5QboeeB4QMHHC55V4iek7
	1jMRLTJizdeExUDGXQuuh8wKq+kb/SocefhbDf4tn6asLxaBhOtncKxk4iNm/jpsTQPz+USbPu6
	P/g2RZ2PJMURJrvMSUtCYLX
X-Gm-Gg: ASbGncuo8pGEEcYMeXYUVBNHZE/M3Hind5CBBt9qwLa0NPL1bz3VdBWJKzhj5M7i7X9
	++n+/U68BxUq0e2lYI4rl3tkR+HnH7mptrpkSs/JT9r9evxkVJgibIEaV6kaugquBbvLp9REFrF
	mQW6K/LLcBDF4jChIokJ2K32tIvtULOYyzhQ/Kex5j0wNy/HCdbbvVrEWkWeEMGTkLvAfwfvhCW
	UiVqH5elDjpT7QErtcnP4SGYwAQi9tGVITmGIVgxflYYaizg4sUBQNzwvf9WfmVGtJiDaS6Heat
	RWvQRyIxia6zKzP6gY5ejTRPZPNMFxG+DFkixNCRT89NIOpOpaa5WEl1csbfO5tIOYKgSUiVceF
	39nZtqp8V6Vb1NFGaHkBsx6GswOQv70JgeDnM2UTKKlsu/g1bp1QsTCYOhseDjQPb7pG/eq7tWs
	KyhdZtK20=
X-Google-Smtp-Source: AGHT+IGSN7cAMFyj/Zf8klE1OgItKuYg+6OL1DGDWo3YTnuD9O+PJ1fbqAR03IxVwSonr8x3zAgH9vo2ZXDt
X-Received: by 2002:a05:690c:6601:b0:781:315a:1851 with SMTP id 00721157ae682-781315a248dmr46969627b3.29.1760379313869;
        Mon, 13 Oct 2025 11:15:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78106d050f6sm6344717b3.3.2025.10.13.11.15.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:15:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-86df46fa013so2990383685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760379313; x=1760984113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xFxXctdJJT+BzOc0txkC/Z5lJFQXl9VPAAzfx7IcY1Q=;
        b=dunCf8cxyOm6vV9+IPO+6HeqP1SVZv6jvpVegkda5s2ZG9DsXuzBrLd+IRPO4+4nxl
         SX1RyLx9M62KW9WRky1bvoyt5E6wbjPoIf/01d1tFbUgrU4NIUwJuCTCzg7qgLOREV+2
         P/kjqAaLFJwtB/ZRi1NpMPUYpMGRaN4gEds1Y=
X-Forwarded-Encrypted: i=1; AJvYcCV/fmhiEXKq7NPc7dHhL5WA0qbmVxf0hT6hfFnnaOnC/QwYRyzuCHlhvgRCznC9CbZV9Mdk+XYPscADrXE=@vger.kernel.org
X-Received: by 2002:a05:620a:4505:b0:853:61ca:9e91 with SMTP id af79cd13be357-88350f57a08mr3101497285a.38.1760379312994;
        Mon, 13 Oct 2025 11:15:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4505:b0:853:61ca:9e91 with SMTP id af79cd13be357-88350f57a08mr3101491585a.38.1760379312499;
        Mon, 13 Oct 2025 11:15:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ad8dasm1034487385a.21.2025.10.13.11.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:15:10 -0700 (PDT)
Message-ID: <e27dd085-c21e-4358-aaf3-d54eb1ffeea1@broadcom.com>
Date: Mon, 13 Oct 2025 11:15:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: b53: implement port isolation support
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251013152834.100169-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251013152834.100169-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 08:28, Jonas Gorski wrote:
> Implement port isolation support via the Protected Ports register.
> 
> Protected ports can only communicate with unprotected ports, but not
> with each other, matching the expected behaviour of isolated ports.
> 
> Tested on BCM963268BU.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

