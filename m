Return-Path: <linux-kernel+bounces-841565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF46BB7A99
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3115D42769B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EE2D8783;
	Fri,  3 Oct 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Az4vYIaL"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FC2D839B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511386; cv=none; b=tFSbwWOZbvcJoCw3ii+6yCcgVRt07+NYedeHV/kfjVKIrzaeiStJB7iwenQzjA4PAHVS4zdDqKOdWt3K4WJ66VJOp2yOizXZU2P5eEgyQgNvsge+wm250zqUQRUVJa/cAR8wncyfk3bJQrnZFIbnLheHoyEf+/y2tWRJQfA3LAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511386; c=relaxed/simple;
	bh=5Z1/gl8Vildjdb9LI4vL05a94ASK0LMfvbSWas9aGg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi0HuKscAx/10LL3DfFccqCFfb/sYFNpDqc8sjkUhe9qvIddOPhQ/YWzgkNEGwdVyynQSRBylF4Wx/jw/Mjk/ggnNXDa9y7NPNhD/EpNwe0eV3/A7jWZsdIpgTLGmc5SoOS71izvl8WcVVLFX1mxnOsENsizFYB6xXTP5AU3T1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Az4vYIaL; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-42e758963e4so14431785ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511384; x=1760116184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rhq5Xd4Igc9fjcR+TCYBH/u4+ukG5nbOgfFURkP/fuM=;
        b=THmvC5V4KSIIu+zoY5f33g3GET1Y3jWNuUUTh8OEqHrOT8JdksopKs+OXTzA4ttX5z
         taxEAaf/ZRfvOl05tXqqupF+en2zpXo2W2elNlhmgY45/53ImeBY1pX3ZwIn+86bwqsW
         s9K+F4crpD2Ry/KualgxtA+9THMdCNVz4BUvw5HBh1RYvhWHmg8dCy1A42t6n2BtAjLW
         GQLnbGwvYwS/pu30Mu8M01wF/HZIJesa7R9EDbm/x7B8gTevzUKZhkq0IWOTUurQYpj0
         Q6VeNWRlxLT42X6tsAhk9TIrd7HX2adA4/kWUOI3xZdD8NQwWKgAwCTqIVCKQr1K6SPC
         djPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIhLBt5ZKVjd5DgV/lf6CgiSWksH1x4f9i/VYlf3rnfagqnX+ZkZVgFLnSr5a/9ASfrswYE1gMKNGjA78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUUd8T6Dz+vr/LOaR4dOBz7pXH/gwhL3O6ng8Gdv7COdS/7B+
	91/Qez6mu2VUjMRAoYiT8z4CAkXLw5qR1ax6E4UeTTLdkMb+j8RuEukXF02SdlWlxl7AjQ42rJp
	glyXOmLvj/Iep7FdzaxeCsPRf4IHfI/yyirh7vOScjLzooj/m9b5ymDzZ0yadL3Qhcvhz/ETK3T
	bHXYp67/GMMJEDODadH54LXgpoRE6/12BIXPGDdamClOyY3ZlTizdj6fqAne+k1KUdAUDNFZbLb
	exU6rAWBeOoSJck2y6WTx9D
X-Gm-Gg: ASbGnctISunfqxEPt8j5CAVh+kqxA9fhUbn9qQxEwER15KK5tulntD87G9aJBDjK3TI
	n1pgyybZ9M9VIF0YB9ekpxqVb1tNd7+iTHRfx3b8brJQxtvb4GOHr97FngIKqMvwTwPv1z101O0
	aPmqJJ2+qsOtX98KgaXacMTN8JTBo4GC5LFpwwsbXNEWcEPjmhJjq8Wlk+WUHvXXRfpIZtqIG6S
	L3fIt+T4lMUBCOKgqH3ZJA+r6H23dNakBCxt+UuvQCBEHqgdzlm6LuEl5saEtGCkzvM26MfrPgx
	qKr49VW0xyBJimuIPCWyafAYBK5qCHuOf9bMt/v87TksURTmxsbO5q9agX1QyZ6irb3tQ6EPq2B
	OOjm7yeLzwaUAC4TNV7vxAWF0vQ12OMl/WC3U8oIqK0yIfBSRYjZ1Dl8uYFjVcF+DGQ4ci52Om0
	zzz8y8p2BjgD80
X-Google-Smtp-Source: AGHT+IFCBtew35RRBaTMIsulX8ylT6+YweUZuuMRb3DjW0ZYglDC9q/QXRV0DmYcbCkt/C5jOVnksAdl9Z8X
X-Received: by 2002:a05:6e02:3e8c:b0:42e:6de5:b41f with SMTP id e9e14a558f8ab-42e7ad9ce1emr47062815ab.24.1759511384382;
        Fri, 03 Oct 2025 10:09:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42d8b290382sm3953245ab.33.2025.10.03.10.09.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:09:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so2347658a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759511383; x=1760116183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhq5Xd4Igc9fjcR+TCYBH/u4+ukG5nbOgfFURkP/fuM=;
        b=Az4vYIaLPQENxx7lbM5z/Mj5zGy5rE59RvI1fK1IjUVV7VQZDHnedP6TP6pXO8ZXYp
         RZBQaFBeOS7rP61UekccNfzQhBIhCW9HBiPTAFp/ZGbxEducMnjdRCjBWgbEQ0FHutQf
         TGoA14N6i6Tpb3nbK5TSy6imaQg+KMnCzdSBU=
X-Forwarded-Encrypted: i=1; AJvYcCWFmset6wekCfqTXpEOnXPIlA/aIMLegMRRXp1fTqYon+G3TzOpgC3STkpfU0m3Y2eodznGEh/nXjtlJPE=@vger.kernel.org
X-Received: by 2002:a17:90b:33d1:b0:336:b563:993f with SMTP id 98e67ed59e1d1-339c27b9360mr4610182a91.34.1759511382731;
        Fri, 03 Oct 2025 10:09:42 -0700 (PDT)
X-Received: by 2002:a17:90b:33d1:b0:336:b563:993f with SMTP id 98e67ed59e1d1-339c27b9360mr4610148a91.34.1759511382294;
        Fri, 03 Oct 2025 10:09:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a19csm2669228a91.7.2025.10.03.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:09:40 -0700 (PDT)
Message-ID: <72d1e09d-f30a-4f8e-95c3-b9a40e1e1b73@broadcom.com>
Date: Fri, 3 Oct 2025 10:09:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add support for BCM72116 and
 BCM74371 SD host controller
To: Kamal Dasu <kamal.dasu@broadcom.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-2-kamal.dasu@broadcom.com>
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
In-Reply-To: <20251002210426.2490368-2-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/2/2025 2:04 PM, Kamal Dasu wrote:
> Updating compatibility to support BCM72116 and BCM74371 SD host controller
> similar to other settop SoCs.
> 
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


