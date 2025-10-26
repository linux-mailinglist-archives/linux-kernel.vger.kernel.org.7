Return-Path: <linux-kernel+bounces-870554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB3C0B1E5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052DE3B5F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6826CE36;
	Sun, 26 Oct 2025 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ha5DK69s"
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BE1F30A4
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509980; cv=none; b=DrmNNxPw7+QnyZTfesuDNDsjo8B0lEPCscaq+RzU3hmReHEOCSaG8x10QZXKpsIsOZ4jemea9bxMshNX+0O81ILsxilmab9YHHXA0osXrG988mUWZSiwXjMXebCLig64JqwYqq6y2IruJEJQHbTYfJaGSLSe4hkSRFs3dyeqzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509980; c=relaxed/simple;
	bh=E1b2xJQsVz3gmgTXHya2z6EQj6tScR9DMq4jL+DL7yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge45XI9VBQKdZui0SkYImxXUBoOQCWFoJyBSlHF5oOFcfVmu9/sqqyqCSpnDkH38Z2OCjqNQ91hBTLHhd0mUXIc6L4PCBMv/KMM0/SK4XUvz+8K7ZqYT8GAwrtkbWwZl5jXoxnFyPxoKg9XXy3T9RBxwR7dQ9iZu2tyE+ZSamJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ha5DK69s; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-557c26c5d43so1136705e0c.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761509978; x=1762114778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fYvW75mpSyvpvtiweDwsolagmegJ85pd3qFJm05W9s=;
        b=huEfdZigX5mklhXqGR91PsSXIPR19fJnjqlU9kefa+K+nist11UazBAyU2+W6ZDtZo
         1XfMrpQ/U/DAV+RSVIS2iBlkRPQ/L3TAOEsVNS+E+Q8L0eXhqp8aE0ZfWESvdUNSj/+Q
         VabAqwBxQ3enpLpjLs+gCXgIPYJMCkWBGpGrMIJxoSlXnGBguCVd9k5K70mf0YawtWnu
         xda3A9YXJCuG/j3RDQgYsHXbxmrGQftgFjGYmF7qWzztC78DFlzAUH3cydRTgf88arIp
         KI/xg9bVU9SlAA7F9jSkCV7kPndNY49i7SGR7/ZLkWczKzjICkRxwpbZYY1Hc44iUmmu
         Vnsw==
X-Forwarded-Encrypted: i=1; AJvYcCXSlXB15CLwF6t12YNGnXhgddLAcdnq5fcsl/3udYfZtBQKvXeMNo61bTF7qvnFXW1/1FPXA8qQ8+GqLeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRi3m4bctBbSD292yCv2NvwMoCnJ7D6z89O9CTEmhkfPHDcA/+
	thuITB1AlhDuDVnzNUjQJFrJ5JjbGRzLA7cHh/xA/Kjj2ec3U6qu8hmZ4qnPlGwuVJ3aqk1GKBq
	z4W3vyqvYK+c0XHgueseYwaml6+hzEhVyvsuK0UAEagHDgwC8tf2rwTCWB0h56ixzk++m41XlsY
	L/1NCpY+3SfcYF6pJ62n7vtMQZ3aJZPzy19u3IBcqjiuOZzKCvpXGuvGov77BeNnQ4TjuxJVdJb
	tDzp4kQZJOm01xiQkLLA1b/
X-Gm-Gg: ASbGncsxcIhJZIsMN1GYUjHiWEyab45nMEVxvRdMBMA2k7xOfROPJwB1AHFwE9LhevJ
	eDs9z+MrXbFxfPzjdyVAw9MIbTINwSH8rS+CfTfkb6gSxy1EOaEWoUmvlVDC8ucUY/Qe+k39uGC
	lgF9eu48t7aSV/vzD/WqIEo8Z9SWQLZahHOZ9ZBK4mDIfanG0KM+EulVabv3OerHl+xgdtGfWmS
	Np3/DB8FHThC4m4Dhs7a+3zruNMuc3Dvujf8EJ9CZFdQYxzQtJ6ecnxXktMom0bPPnshyFwxQGN
	Xdzdi2bKQ0z2XDpacB7Tf6Wbp+lHcyLKq625M7lCZbsOcYYshZsy9RxhSmoi/0E3A0e3aJ8/Ep0
	yeUC6uS2CqbtKymIY0s/jvUOBkVcNbkF8rndbUKcHOqi57X3XGD46h9D8ijjEGzkTL3h0fhMC0D
	xyedq3A5VitaIaERqpVATMCNeS1vnSV5sW+VDEGc4=
X-Google-Smtp-Source: AGHT+IGwT/z4TA1INACkEW8Q7D7sxPpce8JLto3YXTD9y+n5J7ZIbVWYyp5+rUnENUF/qFgacTv8cnVooTXE
X-Received: by 2002:a05:6122:370d:b0:54a:87d3:2f09 with SMTP id 71dfb90a1353d-557ce8e732amr2223068e0c.2.1761509978022;
        Sun, 26 Oct 2025 13:19:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-557ddb27e46sm652611e0c.5.2025.10.26.13.19.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:19:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28c58e009d1so85127135ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761509976; x=1762114776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9fYvW75mpSyvpvtiweDwsolagmegJ85pd3qFJm05W9s=;
        b=ha5DK69smLes0QzakZaBc43D4teYNaAfJAdzDFfvcJkU/nABag3g+gj37KMQ+uXPLE
         ygsLsMI0xLCkffzc7Tda3obHPRa+1KRv6lh7T9Dc1RRBrhDaTFMnTA7aatToJMq2BUGC
         X9bQkVpD69Me3XBmNalu5q+35I23F3kcsj6Lw=
X-Forwarded-Encrypted: i=1; AJvYcCVwNyhnQ3u+0V84LmfIAcQkOuFmUfsJDuA/ipfGg3a9gNxQ8mevsJRBRTE0BIyTpvea0MCBf23VA77WzMA=@vger.kernel.org
X-Received: by 2002:a17:903:228e:b0:290:cd9c:1229 with SMTP id d9443c01a7336-2948b9a0af8mr101404515ad.19.1761509976467;
        Sun, 26 Oct 2025 13:19:36 -0700 (PDT)
X-Received: by 2002:a17:903:228e:b0:290:cd9c:1229 with SMTP id d9443c01a7336-2948b9a0af8mr101404275ad.19.1761509976090;
        Sun, 26 Oct 2025 13:19:36 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm58133635ad.9.2025.10.26.13.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:19:34 -0700 (PDT)
Message-ID: <eeb428cc-44fa-4d8b-892c-74401bab5c4a@broadcom.com>
Date: Sun, 26 Oct 2025 13:19:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mfd: bcm2835-pm: Add support for BCM2712
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
 <20250917063233.1270-4-svarbanov@suse.de>
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
In-Reply-To: <20250917063233.1270-4-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/16/2025 11:32 PM, Stanimir Varbanov wrote:
> The BCM2712 SoC has PM block but lacks the "asb" and "rpivid_asb"
> register spaces, and doesn't need clock(s).  Add a compatible
> string for bcm2712 to allow probe of bcm2835-wdt and
> bcm2835-power drivers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


