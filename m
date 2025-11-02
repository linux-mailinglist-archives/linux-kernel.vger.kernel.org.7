Return-Path: <linux-kernel+bounces-881871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAAC291BF
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253C0188BEE0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8EB21CFFA;
	Sun,  2 Nov 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jlf+iMAh"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D153EA8D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100152; cv=none; b=qGCVWgx6t5ZbX5U7DZ+Qewmk18QkVbzG8Had4WG28oqHn40lFhn1Fq/1A/m5HdwuRYlfFI+aGQvxBxti64k+fpRy/IuT3Taii0phVRfdC8EnosCe6894OYPf7Ce7mvxGyUyruu06JoScPB9RyN59N45+OUM9z/az2PaNsineBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100152; c=relaxed/simple;
	bh=Js+HbjVMxuG/sMlxV2M2pVXUI7MWwejp/2QFZAhXhxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNw/rVzLXzWUdu5BNfU58haE/fITvxr8baxIBewMrCW6gJHFfrWlfoD8gsy5F+o+PO5digronm993CgOhMy64bxtxKVsJsVaxabVSLfXBxJFXpuGUjN196xeCCD1MTMt8o5dhl4cKn5DgtXH8xU5Wja2OShPKeqzd7G7nnfj1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jlf+iMAh; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29570bcf220so10842585ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:15:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100151; x=1762704951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPD7JpL9+HSnLwUj7wrXGanSQ2vbBMEr+pV52clH7sk=;
        b=GjQHekWtNpGUeG8uCHYGPFqWj7yr8yeryB3ad3okWW1O+Hp8v6+BZvrCa8qc/iInr3
         HBFLkhvmHDbVNDDkj/YQOFfnBffpxR+eAH1xnrhNYMBXZGL6ka7WIyax/l4yC4zx6Bqs
         qLtVdBOPg5OH1Iwh6dx4GOZhPDifwkcqCDjccDWzotM5fAjAl9nhTVMngq2I2EYeoW0V
         x5Zh62cDBvCRzJiYhcJI5Kl6vPXA4wM5iKeplyAx+8SC9kNt5LCyT3OtffX5W63HiV+A
         2Ku/kEVi0pZuqpSA0z1CZp70Eu7oWk/AOjRSzcIwtJtUZP5baS2Lpu/va0+jkB6tz4gP
         iz4g==
X-Forwarded-Encrypted: i=1; AJvYcCXS9ewvKWxzDx8FdpOiRwipxXAeBftDRbCzIZQusUJ0PDfaeObruIb/ia6DC492FV3eXnErVTbCBahSQDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DCptZiY2Ab1FdOvlN8Cyo7p+2mq96I7sityEpQ/QOUohVaWL
	GBjObvy/lCAPOgmFV8427nPtfOVfmNsjZxqiPyh2UA3vePU4Fl1uTS5l2NFF5DNZNyFLwjISRh/
	f8o94tF7yz7BBmkGecqeYIrGaI4qVhGjQdimYotKe6miF5EEI62CDzSqHR/IoHiqJOkBw7tXhQP
	l2ixuDhALfw+/qM5eX19xGVi7I8qp8kDlmPPZ4kM46L2ejNDThChHsTZHgVjHymEveIHKnG0Rtk
	mip6nWW2QEBCYgqXfDdTXBo
X-Gm-Gg: ASbGncu0ufh2ZSGvpgCelbw87GZdsbTFRh3YUHnj0XXBZc+p1IkkQmqN/9xVLIJ+5Bm
	EGwI+k6P5fkaErozuxA9smralGnR3V4w6G8IGiaNJZL8SoGVGTxIpCjvIByhpOFN16tPc5ORS/n
	UBP4wcGxqTOF6+NzECAWutQo7UyuZa1MX4jyMGaYLKhiwuv0LfInKvV2LiXwYHlEZQDN/H9aY49
	6F6GUsTyWdmB4SeTvkQcsf5SrBNK3Zu+vCJoWf/CO8vxquAKfxOdWrJApXoYRTycpe2D8ShSMR0
	cTgZw8CnB63xYovyiYVi+rTYFnKww/jLMrUOnoKMyGCIRUQ8iKi7p+t7t/3DYauRqO1J1YC9Juc
	ATONbUvSCwPHJFc9+QWeRGyJ3lzVC4A813VXPDEkr6cvztRVRgsFFw0KxXb7raFJkLZfbo2o/sa
	SzfeOf+93dRofnAlG07T+xtqjxYO2flnI1+LrgDsHLsw==
X-Google-Smtp-Source: AGHT+IGtSRaMhaXfLBQy5DCiQWZ3KU9lvUXfsyC+Qc8wLMHxixQ8HaHVE0N76FOPDwxfHwuv3mtJmebz3BjE
X-Received: by 2002:a17:902:db08:b0:295:3584:1bb7 with SMTP id d9443c01a7336-295358424d4mr108221875ad.46.1762100150761;
        Sun, 02 Nov 2025 08:15:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-295269a01fbsm6927645ad.56.2025.11.02.08.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:15:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99f6516262so1521476a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762100149; x=1762704949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qPD7JpL9+HSnLwUj7wrXGanSQ2vbBMEr+pV52clH7sk=;
        b=Jlf+iMAh8r+XN+GOuQ5UJt0/ccxNCQT86/NDahopy9TcArq+I0r+d7fzb9riRGK6UY
         bpD5DhRMxNQriMrWJgM54U2Dg0qat3leNkSRtIJh2gSz9LrQpDt0C1w+U7xBi5uX09ol
         WPDLj8ipxUiJokCH2vSOXDumuOZleBg627GZo=
X-Forwarded-Encrypted: i=1; AJvYcCXcxc6YBa75UXhihuLGF8AysG/mHN4gR80eEmpGNlmUPXtkCluX7p5Fl2oR6Qh5HgNg7fc7BoIqb0IMvr8=@vger.kernel.org
X-Received: by 2002:a17:902:da82:b0:295:3ad7:9485 with SMTP id d9443c01a7336-2953ad7955amr87084965ad.14.1762100149058;
        Sun, 02 Nov 2025 08:15:49 -0800 (PST)
X-Received: by 2002:a17:902:da82:b0:295:3ad7:9485 with SMTP id d9443c01a7336-2953ad7955amr87084665ad.14.1762100148664;
        Sun, 02 Nov 2025 08:15:48 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:a836:3070:f827:ce5b? ([2600:8802:b00:ba1:a836:3070:f827:ce5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2958dd23059sm26988335ad.47.2025.11.02.08.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 08:15:47 -0800 (PST)
Message-ID: <f2828be4-b31d-4fcb-a132-d6991b0c1780@broadcom.com>
Date: Sun, 2 Nov 2025 08:15:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: dsa: b53: stop reading ARL entries if search
 is done
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102100758.28352-1-jonas.gorski@gmail.com>
 <20251102100758.28352-3-jonas.gorski@gmail.com>
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
In-Reply-To: <20251102100758.28352-3-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/2/2025 2:07 AM, Jonas Gorski wrote:
> The switch clears the ARL_SRCH_STDN bit when the search is done, i.e. it
> finished traversing the ARL table.
> 
> This means that there will be no valid result, so we should not attempt
> to read and process any further entries.
> 
> We only ever check the validity of the entries for 4 ARL bin chips, and
> only after having passed the first entry to the b53_fdb_copy().
> 
> This means that we always pass an invalid entry at the end to the
> b53_fdb_copy(). b53_fdb_copy() does check the validity though before
> passing on the entry, so it never gets passed on.
> 
> On < 4 ARL bin chips, we will even continue reading invalid entries
> until we reach the result limit.
> 
> Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


