Return-Path: <linux-kernel+bounces-851485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A27DBD69C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BDD4E5BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB32FCC04;
	Mon, 13 Oct 2025 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GISJlyzW"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A46246778
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394419; cv=none; b=qu5R+FLJgn6CehpdKK04EDPI+lSm4MwW8wsopeDYkq1y9UoQ2OyRif7fqMthsuLBK4yCxEzsf9fPzlyDX0E92/ipgfB4NqOTyWe9ToXaLyFddJ2tsOcZ77h28nt2oQ23JtMvvyNhRdVO5SDSfqs3DkHLkiDO/oSpZPB6WcKQsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394419; c=relaxed/simple;
	bh=45jw27UOqcaEEgXA2Om8nunCMYD9TzVJ5Sapx94fZyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPJ4PfDDL5L9ZAFCAfee7IA74ie9LPLWGQLNFivlk10PueLq7Bq0RqhSsxzxfs9zjhXMJT0BLoWXPRHJTG/iCzWUDiJb0xfpaTs8ird5J5NePf3gRv4/e8wWa2r5RxgsdhbhyTqWk6vnT/Qb5JpZwHDGj4KK7t4Iq9W5UNh6MT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GISJlyzW; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42f95010871so17360305ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394417; x=1760999217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b845DlXd9K6jDMVlYO3LVzHUkLALRMHXbWD2uYSJcu4=;
        b=qtNvgNp7xHCX1UZGlDjqRfRmIVvrnP9WfWAJA7E4meP6Lv6EWmgE8d5NhGaK2VQpDc
         8Gt+vC2F0D8FqZKD7enqCoC1gFcnlsDMmMiCJBnS6pRBVFxsPtaRcLdRJl+TNyrCn6uq
         gPpqdkFZhtDCIXdS59XTapkd7DxgU2gFBHBsqNsm4wsjxIIPQ/d/xmNrJd25GWIik+n7
         l4Uk3+vNA2gzAKXUnURodnFcg+rNZ/Iu4g4cte0RqBlckafuDv1WyUd25QoPhBGOc8xI
         Cb/I3dZGCQc4Ulm3FhbYIzQMgaghn1vdFd8ImChZQ2jAybevkNAJXhOwny+DlrBBFXpj
         D8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWAAbsCC81z0zrlrHS/azywrTuWcL3vjMmGXX+YmFPT3D5+yfb84OB5+PYYiIO1ExJcjYDMD8xZbCYjlfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IdxCbRDPXos1DY3rSqD5z7CJPLEv6dci8BzMcdnLtywjfG4o
	58fV6RDM/IJZUf8J5+1IE77nvHHzOwAvw8ZWNNx3163ONbjnIgYy7kMrvUODyxjwXryNeXE1wY5
	QFFnA4Le1nohm3Dml7Jpdp/0fS9zHaF7PfYR5bqsdFNPp3HlL0QPKU4Y3A+oyn9/vKrAAxqy4Un
	riJ6zsF8W5BxUIQ86ETywN188Eq+OTHjl1Bcz2baZFdOfvMgwKT9QbvowyQCz3o1IkhXpyptCfM
	6YgJWLvDy37tgxvono0XDE0
X-Gm-Gg: ASbGnctvosVixlTJCK/aBDp3kK/LxmW2xoJGxq5pcUbNG3L7vfhZh6UxtgTQOHlEaAB
	OOChyxDPnsjPu3QtXbFXqc0u7M1xKMyYDA4rUR4e3XYVgrOl/U7dbZ0cmXJq0SX1qKPXchJa89/
	101rL2gD4Au8woHiyvsH2xaz63IuMRAA4fHy5KqSlSY2sbMESsadEKbJDgEegjGNuxRvgT4saGN
	gzFHHO1axXB5XuGLGRCTq2ShY5qvQs+fPcs37v+EbT2ekX3kL0bJHfGQtqsB4K7Os4uOlSAF13A
	iaYBMm/t8Lmt4b/BQ23aLntpq3LDb6PiiHqXBFmUi4cls2Gk7b4XjxNEJMWwkWGCNQUYQYvoft6
	HI7vQ+W3kYatykWvPHJ+zOfU1nCkf71d0IdhaHd1VpZY13P4dPWIams21SxRBNySuMu05bAUmqI
	8qb7mH
X-Google-Smtp-Source: AGHT+IEm+4rSlhmcOPowPeB9Xn3QO/CHlLSd5AjGxwVtgBKhgOZzNloEHAAUyge/jqEiYyAOic8Og+chORuO
X-Received: by 2002:a05:6e02:148d:b0:42f:9708:168f with SMTP id e9e14a558f8ab-42f9708183emr164948785ab.16.1760394416883;
        Mon, 13 Oct 2025 15:26:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-58f71469aeesm923364173.25.2025.10.13.15.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:26:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88375754e8aso1973175185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760394414; x=1760999214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b845DlXd9K6jDMVlYO3LVzHUkLALRMHXbWD2uYSJcu4=;
        b=GISJlyzWB3pKJBlLK+54Ne+YQ4rgEKFZFdRZnDQtfDTrhL0q1PQJ8/e0e1bg7Qtf66
         tpGctiKgCTMa7Geyze43eQr3ACOQOhRRfyNgvTNGBs0aDFdlBVTmPatQp4RepiHIXS5O
         neZ7+WTEchab9ccIAeoYGw15qg4zpkKCNORA0=
X-Forwarded-Encrypted: i=1; AJvYcCU3WoELOVUoltzjcOkSAbGQNLJKnoIVjqBL+VIJWJZgy8ykimL/SrSPmLQ9477eoerbmIQ5mTTe3bukINA=@vger.kernel.org
X-Received: by 2002:a05:620a:7085:b0:858:f75a:c922 with SMTP id af79cd13be357-883502b7b36mr3412901985a.6.1760394414534;
        Mon, 13 Oct 2025 15:26:54 -0700 (PDT)
X-Received: by 2002:a05:620a:7085:b0:858:f75a:c922 with SMTP id af79cd13be357-883502b7b36mr3412900285a.6.1760394414168;
        Mon, 13 Oct 2025 15:26:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849fe858a4sm1060309485a.26.2025.10.13.15.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:26:52 -0700 (PDT)
Message-ID: <865e5488-ca67-4d1c-b846-4f7defbac4aa@broadcom.com>
Date: Mon, 13 Oct 2025 15:26:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip: Enable compile testing of Broadcom drivers
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org
References: <20251013095027.12102-1-johan@kernel.org>
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
In-Reply-To: <20251013095027.12102-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 02:50, Johan Hovold wrote:
> There seems to be nothing preventing the Broadcom drivers from being
> compile tested so enable that for wider build coverage.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

