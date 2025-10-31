Return-Path: <linux-kernel+bounces-880774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A365DC2687E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824A5404823
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A015350A0A;
	Fri, 31 Oct 2025 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VGs+GKO8"
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D02FE593
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934231; cv=none; b=MoqxXzTzVh/i8OgiD7IJIR+RJgkTkDO8SxmWdpZSltL+fUyNAla+Gnbqggk+U5Mhy/bdyhoNUfbICK0QFB2CK28pBtzSFDaI4S0j6RyuURnDLEQYiB0FVR/GiD8uBVkRRaRSUkQnYcfONOiO6C9uOf8d/DNsCZAFT6lVJZ4Igjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934231; c=relaxed/simple;
	bh=a9xIUxH3kQc8g4WoNuUJFjo3JZiZ14L74BIdEuGYacI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE4j+bn9Etf6EldpakmofbNGjzdoVSSKI9NVaBzxhs1UJS7ZbgtzyhejwwAKZj0+fFBAvjpxhMtb+XEyo76B36siti6s3iqRDfIYv5Pe8PGbii5WFNZ8+YtvjlTBORkhosEP1KN/2yOp5YpeBjbVtcX3bxMS4olZEXuUBbZzTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VGs+GKO8; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4b109c6b9fcso21401971cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761934229; x=1762539029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aTRxWRn5jXTZmg3iJpHPOm7f9rtaLnt98Sh1XgXqZo=;
        b=uBJQ0jm/9P4aZcpS4oXQB2HMQ9rO8KI7JYjYQgqrvkM2zBrB46nKfHDV4BRSAzYwTk
         aXEKs9s/qpoOZec3ORBzgODDi9uq6fLEhQJOko6PRhDQdv4AJydO8wBqUE38xlpWNnaW
         zC3sz9ioV7oC7Rh3WwsOiWdTNR5FsZ2AA1qdNKRS6PJrTXkPNKe9PG9jkNoVg4x4dfJx
         zyuxfGQJEv1HcmH7Ck+zNKe2OB1/psUQot2cZestSOIxAcSullGmRZq9IFiWO+xRd0Ex
         SJF/l+TK7l4y+/WiFuCpM9VG9wlKY+FFWCQntDIydqurt1AkI5kCS8jD924rJ7eTQKI+
         LApQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD7nvohdIbxn22m2lMJiXH8TB3SRdbPnZ6kmoP+wdyGeDql6wqI7T3S0bWnuvkJrrjSFfmHSaDBj7RPaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVPUwl5MKFeAF6vjxoBHoWuTPqnFPX6nFwZeo3mxTnLz7GKbQ
	759Hd0Z9ADYL181kEfg3HbD99PtBtJlk0gXB6Gvl6HOkgzhYr4OnclJi2cHoSeY1qIyqNmW+b9Y
	vLbgg836WF3kxSNpdFVdX/2z4gUTzhN4UQeDyxSD4PXNvQyKO1EzgUTQFHBslAV+6S1vm8aa17d
	DaqpAYdtVOCbgxvc9s4iUMfaHsh1Wt2FXkol8NVLN6mC6AO9+ET1dxrjVzhUVXc1sRZz85O8TYi
	juDvjAUVld+fHKOGUq3jR4r
X-Gm-Gg: ASbGnctCiA7D4WwVr3vD544/OuHXd/qaES177H0alAIZrmLvQTMKsncYjV06x8qMB7Q
	PFAZuJD/mFhTmhwqL1Js0rSsK81uiyG34oXsuJAkXpP62LXYGz3TbmGrs77V/Pb4DRkuFbxDm2S
	gjOOUc2twkaWW9aPRQCF8xwsRa+eH1xaPvO2AmsxG1WjvXCOaCtTcLDW5G6zqeUfZG85Mz48WRJ
	AU5jdG1TWMk5eXrbKRAuYZHFfHvL2LWG0HmyaWj3lRHMd3/D/Nr6G61yaebpTSfPJJ+UmrO+8PI
	AicL4xFAAinmyVXTVEBqfoXBtnfmD4nSzUZ4V7D+Yp7F3nJQcxS5vuMpFZd8JCdeo4t6OShejhq
	1yyI1A+wweCUAU3RStwnZyQWFJqkF4Is1dfiThLVNBDE9JTu7RBfJVk4gWcO5hvWPffW3w+Fc+w
	mvqFNxsV1rM11Lx6CCyCw6RhWL+prMElFbAVb9UkU=
X-Google-Smtp-Source: AGHT+IHusspFJqEPvsqUsM/pY2IFm6YDn8qxZLwfKWBQyf1c+Eg8f2rAReeaa8jazsW4AdkY7kb6FKkJBJcw
X-Received: by 2002:a05:622a:64e:b0:4e6:ebe3:9403 with SMTP id d75a77b69052e-4ed30f8c84amr52911441cf.41.1761934228749;
        Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4ed34d83fc8sm1292841cf.0.2025.10.31.11.10.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c0e0d12ddso62462536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761934228; x=1762539028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0aTRxWRn5jXTZmg3iJpHPOm7f9rtaLnt98Sh1XgXqZo=;
        b=VGs+GKO8EwbHAtktIvjYIfn119hiRbI8XnH/nT/H18J1QzahgJdlDWWLasA4OvbcbL
         OBT84haxhGhb65dSszbLCI+5bgmTN5Zl6Fho32nJxrBxZgdhEnWSzhTraxwC/GtWVUmb
         IwFpMsnbnDtQsNKGdsWi63ji5XPpCSqv+ELHQ=
X-Forwarded-Encrypted: i=1; AJvYcCW1kl+BmSxlOHuqQA6SQX7teKXDCS6fkirx+LIXb6Umte84zGiNZSDreLZzUpAJd/w75n6hFBAMD3SBZRM=@vger.kernel.org
X-Received: by 2002:a05:6214:2688:b0:80e:327d:be66 with SMTP id 6a1803df08f44-8802f46f505mr64085796d6.39.1761934227734;
        Fri, 31 Oct 2025 11:10:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2688:b0:80e:327d:be66 with SMTP id 6a1803df08f44-8802f46f505mr64085346d6.39.1761934227324;
        Fri, 31 Oct 2025 11:10:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88035fdd424sm15354046d6.1.2025.10.31.11.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:10:26 -0700 (PDT)
Message-ID: <31316499-4007-4211-add8-eb6bab565e0d@broadcom.com>
Date: Fri, 31 Oct 2025 11:10:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12] sched/deadline: only set free_cpus for online
 runqueues
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Doug Berger
 <doug.berger@broadcom.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20251027224351.2893946-1-florian.fainelli@broadcom.com>
 <20251027224351.2893946-5-florian.fainelli@broadcom.com>
 <2025103157-effective-bulk-f9f6@gregkh>
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
In-Reply-To: <2025103157-effective-bulk-f9f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/31/25 05:27, Greg Kroah-Hartman wrote:
> On Mon, Oct 27, 2025 at 03:43:49PM -0700, Florian Fainelli wrote:
>> From: Doug Berger <opendmb@gmail.com>
>>
>> [ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]
> 
> Not a valid git id :(

This is valid in linux-next, looks like this still has not reached 
Linus' tree for some reason, I will resubmit when it does, sorry about that.
-- 
Florian

