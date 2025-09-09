Return-Path: <linux-kernel+bounces-809081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AADB50841
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2521C65CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C8257AEC;
	Tue,  9 Sep 2025 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I6jFz48t"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C927219A86
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453753; cv=none; b=hkl7zHjF0cUlZ4ZvDOHqCM/N0fdJcsLTsy4YA9FWoObuqGSYI77fyKNYY2r+6XFO94WD9OHDP3F8PJV1yOaY+Pp7wOy0bGYDgNaAhEsT+Q84c3O1MepC/yEAsi/BhUdnB+8Fk9kYqFv/vcWfoCFDTw8WyoQbBcRBsdNPxHyBzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453753; c=relaxed/simple;
	bh=XqWoUIdMiIm885HIEscBkxW2tj9oYIjdVhaxfY6ZD9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tk4cHDQRbX7b7kMoWOhFWgdrfikZK4iXdOCCt/CfzqVEOWhpmV+bCbyLObkjnbtO/o8JR2spK/e8zthPqvDtzcFKBbJc9djcnYQ7gTEtVrg2NSDL7z4so8ol4O5adXI+huzWVsfVxFg35wIpaQX8sHgTVDuxqmuK0/uZrvv/WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I6jFz48t; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88432ccd787so445320939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453750; x=1758058550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ld7nUHfU9YQItz92qtqFL7qCvEqQVtcbqTEusRH/IbA=;
        b=sP7p8q64OxE478bdrbqNLVoArJmKJ6KLadTJG2O1OMjHTPIK7Hu45SFAP6KfCtlFEY
         wKN5agSw1OJEgjy52xKDP1WUb7MHGca1Q1SdVtCHEFQjA5nj0wEdO2GnMk6bdZM5CYbK
         1xcHqxh3ugbWr7sSqyFYL6cw2259HXlOWpFekz7qJxX0wHTb2UQJJGQQiPkmmh/Wxucy
         LeS6SMEjLhKznDqILgS2KDDIWM6X42omJXMLtEmtI2GPEohpmt0z48cgL2GkaiS+SWae
         kyLaO8Bk4cduGnFnjpiHPYity/vUbcc4UyUWm4OdeSVtw1Wx2enq9wb7DvGiLtaQGUdY
         yBPw==
X-Forwarded-Encrypted: i=1; AJvYcCVD2rjLDR+uenGSLkpxdm20lDCixKrz475FrqySw3HUO8tqLTnbMJKd80mzW+4jGS1DiA6Kero8JiKJGzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmI2oBU6voTmxXO88cU+BLVLt2pe9Pqd2dqSPEM+aLSVr3r/1h
	zgZqEUKNuiy5rdvriLYUG4QG9I8ETLl6W2p+MhqwPpGFH3qLzHVKa3p9RznbqO5qYJPqExjnABY
	M4W8X9d2gGzSlsrembt35oY/Xs73PhMVIHvaM4faTJbtYfKKtmvwcKHd2TLa5ksnh1TxNTiSGI4
	fcRg2vCicjfR8UOYwSbacZvdYcVrYStQHHgB4J8vIf2AiDcUBg590IiEmAyGwGfe27pqvVf9k19
	abJ+1xPkhPF+6O4eTkFoXe/
X-Gm-Gg: ASbGncsH+zDDUGfrfBNoTgki+NLoZvD2J6QSTlCY/6P4o78pJAT3Ag7K4NDHNbcY7bv
	8pKXgaouFf3aBFyNMFShL0zI+4K3MYPQaq+pMurZG5Fk9l+jMclixZw8KeljTDgD5kwKR5KWnOz
	2x9xTpg+HPYoEjkSvk/3PuciQDNgoVt4DOreycyX+x2Zj3Q7E3xIXcUDv3Rb4+JpLAjed5n46Rm
	S2LNqn8J213StArs3GOZAZwsJdCrg+Yf5VysAYtSNbdosExDc214cpwjTXZ6q4rO5ZWRMtwlHwT
	9s4R5Gr5j2rjB9QBs6wJpmBUEIaCLWUBx878PbcKjpSD57hg3KvcUsQdqIkXYR/MPmVjGHsGyOK
	BY1+w+FnVK1wvz8eDXC/SdsdE7HtxymfV5HlwFnnOExx3UiZxO+udSuMP31+Vl1p1kunnzsHALU
	pXY0ZG
X-Google-Smtp-Source: AGHT+IGlRu5Yg1uwpBLygUs/bhqosolzOD6j7+JRoNblzZoAqenDuehSARxZb7C+gojI2YNHIkpR7Clxw43V
X-Received: by 2002:a05:6e02:144a:b0:3f6:554f:f839 with SMTP id e9e14a558f8ab-3fd89ce42f0mr190616795ab.26.1757453750453;
        Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-408c292b1a9sm5072115ab.24.2025.09.09.14.35.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-807802c9c85so1523667985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453750; x=1758058550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ld7nUHfU9YQItz92qtqFL7qCvEqQVtcbqTEusRH/IbA=;
        b=I6jFz48tzWV3ltasGROMTRoP6RqpNbjppOWUg2N4dYP2iCjEPhsYCcJdVvgj4thJxR
         DIItaMS3j886YC9t8PixzZNdBRnfoaq6hOOd1W2gZ3EOC4hrHg5pH9LkLQiftcC68HR9
         L4i4006VINi0Lokmi2IKMxNYQ8+Yg+9gWRgEw=
X-Forwarded-Encrypted: i=1; AJvYcCWSZMg9zsni7W8rGmFMaY+HVOhI6/loYQgxNCzuk4X0oifqMrGgvWQ5P5o+nGj3kj0fojY0LG9lMQhb9IU=@vger.kernel.org
X-Received: by 2002:a05:620a:2946:b0:815:e54d:84b3 with SMTP id af79cd13be357-815e54d87fbmr1119817485a.49.1757453749579;
        Tue, 09 Sep 2025 14:35:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2946:b0:815:e54d:84b3 with SMTP id af79cd13be357-815e54d87fbmr1119814985a.49.1757453749136;
        Tue, 09 Sep 2025 14:35:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58d49574sm179534885a.14.2025.09.09.14.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:35:48 -0700 (PDT)
Message-ID: <7e4790a1-2703-46d5-adc0-7f792969e797@broadcom.com>
Date: Tue, 9 Sep 2025 14:35:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [net-next PATCH 2/3] net: phy: broadcom: Convert to
 phy_id_compare_model()
To: Christian Marangi <ansuelsmth@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
 <20250909202818.26479-2-ansuelsmth@gmail.com>
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
In-Reply-To: <20250909202818.26479-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/9/25 13:28, Christian Marangi wrote:
> Convert driver to phy_id_compare_model() helper instead of the custom
> BRCM_PHY_MODEL macro.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

