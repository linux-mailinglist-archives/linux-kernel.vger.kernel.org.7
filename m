Return-Path: <linux-kernel+bounces-644390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBCAB3B69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137D617ECAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D41218585;
	Mon, 12 May 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bi81+G/N"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309A1E3772
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061716; cv=none; b=fQudkHQBl54tBQZcOd1Z5/3Awwius+TJ057d11mSftMj7xqJrDtueMf/xBQKUvJbruGb7mE342H+5CspEsX6OG/e2Xj+2s+FlJP5q/t4Pw39shAJraV+d+F0x+sHcopQclXkoFjm87zBpGPNkb683m+k29nhnrPgZSD8XyrQ0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061716; c=relaxed/simple;
	bh=FaAXlK+KdCzoIl0BtgeubecTHe+jSezlj/diqxC6h0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVuxiGp4MIjDk9+M/N+jEvVx2p+uwC5ReSR5mFUPCVNtLNDipNFI5VxDdLDtwFK5QaJyS6TnzXlL10gKbg52jTWlaU4J0x6cfqjMpV5jDtYjQLMZTmv5N2nthfRJRyg6H+e+Oqj1Ng3pla9JID9a/wAxnn1zLLn+Nlcg8c1LKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bi81+G/N; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7418e182864so3532872b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747061714; x=1747666514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lrpxL/mP+K+cLskpsPY5dwSCo1u/ESSLzrBP8HUOFWY=;
        b=Bi81+G/NYM8M32jfSjdp8qhB0WLmLbJP8I5k+E+SYXL3erolT4cRvcWA+sMs+wOKTg
         9Zs9yooMh8XVxpQni63ESF9R0prnC4MEyAQ9dT/SmkU9nHhTtXbYhqGhTQOiIsomXgrN
         VoT1Tg7ShIh0rdPFNqxmCE7Uve7e11tyKm6Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061714; x=1747666514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrpxL/mP+K+cLskpsPY5dwSCo1u/ESSLzrBP8HUOFWY=;
        b=T9wQ+6Att5z+KUnNMNoB7vXz/UTSmt9PqfnZU2t6kLvDgBU0xb6cAmjMxwvAtNx1WR
         RgC4edkPRsR4WIAnbuNEcfX65asjfRfuwl7GNcEoY2h7HSxNI45x73ikmeBYoPN+gc1F
         t3QwXsWOFriqI4q6fSxw0A7N96o26QeKEq1cL5KriFMLwCu/aBznd6MBHksoYXF8xlNT
         lojFQ423VWujrs2YB3KDEmPBFGRntQ8s6S7I02hotio1PBU+jaY5f/PLlfoMSmkmSeI6
         WYKCK8TysKcTj3Pf1nfyv4jYa0k1PNzcQRLZs/UESuLCjnprJM6ZMFc3RvtnAwDTSd8h
         WINA==
X-Forwarded-Encrypted: i=1; AJvYcCVVHnvBQuRlLFtQRHFcDNBMUhh2L407KetlJXtIPus3cDMsMmxtlR5+5TLOb0T/Z4Cm++Q1ku+Cz23iF0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRQczwbAgFbML8PuEvKdpzAmBob8g9ZbuT1kYCvp4hOCL6k83
	wUGQ3N+YXA1ns0O6oFEBuzVBQkK/JvCBVyZ1wgVfVzGU1ccatDJVZJQ0NZ4/wA==
X-Gm-Gg: ASbGnctatGJcEbqi8U87vwMkvq/rmmlb+1pNp23AXz3Sg2x+NX5YOGhlb+D/E5zb+6y
	/gGJVuYqV216CKic+CfwHj4D0U4scBbTWlpmzmJimzPdhezooMaUKYeQAuYOsHl2eK4B4EvZQvS
	t+nTw32yRSbkXBN4UaeO4snCxQueDT/VlgWw4zmWqo5K1KUv7n+TrVDyVTq9VzYbDyuW4CCbas+
	xBFEzkhGo0r2istyvWKKj3m7secrLSQfjpirknjgPWj6kalG6VAGsomHEJCd4EXLL1iNRsv/rdH
	Qly1s56aqluGtSb4se0VFbW8U/FeEG52yS3HyyZe41MnVnnoo2gYmGn4PR5HF1YT2ciGGrmOSL/
	n/IPxVMZtYJ6ZSOKCYxx2Ub5tjpbMVnuT50hz3Crd/DgCBBhPI+cFyw1FGafN
X-Google-Smtp-Source: AGHT+IFWjn0dJiD3AV+D+E2/RWGbXOX04UoyHDA+cM00iL+OwBsqv4BjXvQjc1qrjaVcQ5oZZ1BPZA==
X-Received: by 2002:a05:6a20:3950:b0:1f5:7f56:a649 with SMTP id adf61e73a8af0-215abb0471bmr17222493637.13.1747061712886;
        Mon, 12 May 2025 07:55:12 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0f141sm6133891b3a.117.2025.05.12.07.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:55:12 -0700 (PDT)
Message-ID: <a91a4ec4-76f7-44d7-932a-de7e4eb41277@broadcom.com>
Date: Mon, 12 May 2025 16:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: brcmstb: Use "num-lanes" DT property if present
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250509222815.7082-1-james.quinlan@broadcom.com>
 <20250509222815.7082-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20250509222815.7082-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/2025 12:28 AM, Jim Quinlan wrote:
> By default, we use automatic HW negotiation to ascertain the number of
> lanes of the PCIe connection.  If the "num-lanes" DT property is present,
> assume that the chip's built-in capability information is incorrect or
> undesired, and use the specified value instead.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


