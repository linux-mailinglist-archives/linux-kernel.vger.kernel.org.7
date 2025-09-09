Return-Path: <linux-kernel+bounces-809066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA028B5081C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B755189589F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F2625D528;
	Tue,  9 Sep 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e0GNiq5F"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978E25C822
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453155; cv=none; b=PqAWA81d7+doiQG3Pd572X7iPZUKiVn9KB+Oh5in/mo2HMk151/j2ot8KFo5AlTD+N5w+33QHkXTS3nQln04N5Dbn0aSmmEHtRLpCLy/mTAgTmW1gqQGMn2BjKBbntIJFt0Q5cHZUUU8BkafAbh6Hy8NZOxvy0glXLKGFYdGl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453155; c=relaxed/simple;
	bh=Uh8IQvldQNPqqLpWVK2SQYeB94Rq/6h2KT+7/+kLv/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lf6ngXo/h9hmDjJoYgs274BRp/XtgmY+pwY88nmgupH4ZX52MUzKQS8iYK15YxxYThQEs5ApkHmQ/BGzUzs8Vk33XaKV5U0r3kDbrRJfRxtGRuyqyzzkHFL8LlDMX/OY1cnoWQ1wQf95QrmIFbDP8RLbjvOh5Lyu0f0BSiABAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e0GNiq5F; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-411498d92deso11405715ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453153; x=1758057953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PiUrH4xoFLpy/PuZ9JloxTD7fWhTm5wGcBSZSp+4VjE=;
        b=CNIfq64nuIFvaGpk/I2ZEuxb5/6Ja6h2IOsATzPF9itIFI84fYR6YAVXw2QAspW3vf
         lzjIGYPTvX1XQBh+P5L3UYcaYlbPYIeVl2NoOZrGcA8UPQvRFbTQB879tNJBsd+XpSq6
         Ptqb9cWTSqdkgXiWk1JY7J5cHgcEkIpoyUGLV+pnMI+r+vNZ2YeXqp/BVWvZzL3fwPQ0
         hcP7st0VhVcOaypku0XWikb4k2utnHw4y50N3mPdxef1CPssZET4aQ/IhNzhbC6r2IbL
         SbUAdmJeZAiA85QobDzhoCLcmGDb43G7Ogj50aEX+VQNUr+A6vVNXr8/6Mk8ShfvrHO6
         94Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWFgoBcX9hQWBVYVbPfbENODlQt5fUE3/YAq+5vXA9bp4jZwbfsUBFFwstyJd70dRlkkb7AhWx1NAFqjWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTWAQ48gE7i00QlS7FfvM34XciEUTMJNqJKoObPx9BXPnXUBw
	QebvYEAgdsOct9sHBi6iG3glcWF9injBY90tv4ukxKZxioRfYFsQfJIKBHjc8PgAgKY8p0x3Eug
	V2IVTlGxqaMXLoOcLAr8rnThN1kRuJmmM7lsg7O7anQ3gvbzoV0vK3FNFqz+0KbwGAIqTHWdI8F
	dxELEbj2o/A8TjWU1zdEpGlGAvp7O3bs/i3YjWYMxUT3usNePLSyAFPQROGnjeHa6u8mLFRAQAb
	e38bVvxMIflXFtGc67K3lA0
X-Gm-Gg: ASbGncs5rys83gjLeeFlowJcl6vbv4O1y/6CJxLb+ReRYz2aN4o4xrDVwPepyB9qkQ2
	/r3V1int3XzFpJBZTGxOb+psQJk9cWT4BIzRcGMgk6i12FV1hXiPRguZb0hpG73uTaNCb19DsBN
	yUiab2HHf30v/V6QK+6PpnB7sD9ZpEoA10mA9MQUs6OEAxdJOEdcEsCIDQIRi7OmI4ConVwDK6N
	FYX82Y7XV1jsfFSydkFDL0mMusmJ4G8GUaRGLaJWEM3oUVTWY8jGENjTdmhsGJ2yEGEDOk6uP91
	yWwZAaiqrLRuw7iW0Orcfe4GXqeM4P8IJQRKzHr/JzPBbviSW97E9NJZNQOOV3w+DMu78CiVv2e
	+lk8bcz5UT/Uu9pIN7UJCJbodcMpbOlb35lUvLGqzwJjM2tbUfeOUBW52/ZVgocgXfLCJnjsKL+
	Mc1wqcAz0=
X-Google-Smtp-Source: AGHT+IFxyak0Mog9na7dJN7UQvK6VThMxbT0wIK9Z5Qzt3FSr7HVxbLH7RVQaq6PF2e027MsDprhOth/JhY9
X-Received: by 2002:a05:6e02:3788:b0:40f:7f8e:610c with SMTP id e9e14a558f8ab-40f7f8e6265mr82007675ab.3.1757453153417;
        Tue, 09 Sep 2025 14:25:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4117cf3a7a7sm2095085ab.29.2025.09.09.14.25.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:25:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b471737c5efso4398060a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757453152; x=1758057952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PiUrH4xoFLpy/PuZ9JloxTD7fWhTm5wGcBSZSp+4VjE=;
        b=e0GNiq5FBIuhm/Eskf0PF4PsbzKIJ+vbx3r1yGwRzbCFrupTtQfKzhV05i3NnRIX8A
         hzVq1m9pr+eDj5tzaK0RLvDv1RoJWpDBmc4Yb5o1pCJGS++MeElBkLfQrWMDqOoXMTjO
         3qQ7wcRyW6sAXVAiDh5queV1ggRPzVOeYXU5w=
X-Forwarded-Encrypted: i=1; AJvYcCU/NBnCVs/FaonZnPw/33KIPHY+wTis7lnWqrugdyTWw7vEjnmd4PGu0l1GyRLpC4SHgx1OaPY+/T8QsLo=@vger.kernel.org
X-Received: by 2002:a05:6300:210f:b0:24e:3b70:977f with SMTP id adf61e73a8af0-253469dbd3amr17194799637.57.1757453152128;
        Tue, 09 Sep 2025 14:25:52 -0700 (PDT)
X-Received: by 2002:a05:6300:210f:b0:24e:3b70:977f with SMTP id adf61e73a8af0-253469dbd3amr17194770637.57.1757453151765;
        Tue, 09 Sep 2025 14:25:51 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e67cbsm2994494b3a.6.2025.09.09.14.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:25:50 -0700 (PDT)
Message-ID: <be4cf5b5-b2ad-42be-834a-86985fa4aded@broadcom.com>
Date: Tue, 9 Sep 2025 14:25:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: rp1: Add USB nodes
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
 mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
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
In-Reply-To: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/5/25 02:42, Andrea della Porta wrote:
> The RaspberryPi 5 has RP1 chipset containing two USB host controller,
> while presenting two USB 2.0 and two USB 3.0 ports to the outside.
> 
> Add the relevant USB nodes to the devicetree.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Applied to devicetree-arm64/next, thanks!
-- 
Florian

