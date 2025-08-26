Return-Path: <linux-kernel+bounces-786033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A414B353E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4904D162AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBFAA927;
	Tue, 26 Aug 2025 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBMMrMf4"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427A92F39C8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188667; cv=none; b=UX40iGYsBRu6nGovEaFQxOyvrrIHI5qbnowb0JIC81U1oZOwxLAKnR9xD7gewePlaILJY1HifwMYl4a4co+Q5O4fJceKM5Zfk7V4yWi2i8/JeOFoCtI5ENUrNZSXpVoRPWnUJWmYL0c2z3SOx4I3MF5chss2aFGX2RPpUKcEA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188667; c=relaxed/simple;
	bh=q3DFPMk5WFBs5C+G+yhwCZh4sN+sL6jQ7uOIEcyNHVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHX76pvPaKxW7My8B1v0IKL9hFqxmnCkZdAn7eSFUEBRHqzTkPOJ6W4lV8fUA3OjEwFsjVfBfpwEtsKLfYeqfu0u1hYyjs8Ho1mUbNkSQt/DPebX7wkSan11q5QoZTPax4+IBrs0FdiLnq2VvrCzTmnFhsZoUbMbMQxvubevroM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBMMrMf4; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603c0a23so2242737b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188664; x=1756793464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9iquqj/s7zSXGxOGmSMkXZ1B9Lfhdll8knK3f/rRm0=;
        b=CBMMrMf4TdHRt5Lfsa4tTXWlx0QxLu7I/I8Cexan296D4fCG5pRIhutk6n5ERhMlP5
         p5v0o8iWRut/x24BL5xt6+0pdeBD380aH3S3fLlHbiJSADcdjIkP4WZs43PYFtfTT/v5
         LWRcbmhT0WCp7JynYwkmostzPS3JeA2/z3YQfxanPIND6GfVg1iT4OW6kIlSAGBVaJpc
         iPTliHI+93RGeERT0w/lcBXyP8EzhCqN0kUHluPKUXH3uC3P14G1I0oKjYhdXJtLjIKz
         Kn8JFR/cc2EFXSaPftBpyWtq4gcPzStcQjKHOnRPWEKnVKGw088vy4/yde1sh7wBorgW
         RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188664; x=1756793464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9iquqj/s7zSXGxOGmSMkXZ1B9Lfhdll8knK3f/rRm0=;
        b=Hthql1wZxQT4F6TKr4FsLFxsyxP/oTbTHdpU2+hJwDzgqmXGJiWgLiggvAc6W7tvSo
         l5r//aUHkisscLWFQ1rI/UxvgXuZxLEmHvAAoQndF3neGzHjajxA4RAv2ndqT1MDClF2
         DSietWelh62LpWA33f83KQGn5IrIVe8X1aSeIzxxp5RlC1dYal62VzMzHHo8lxjJc2aH
         SnVrpV/zRZbJ9Mwgr/gjNSmxm4jVahBk9z3RBolCH7RhZsVn+ckYNyqhL9wGu8BxEKGK
         7mcHU/cQd6ACWNAoDdiYHpPSAzSzNaq7dWGQv6XrBZ6rgySvZG/sAjKQZthYHw17YkzH
         V5mw==
X-Gm-Message-State: AOJu0YxDshqmUhfjTBl/Mg3xo+ZJwpTv6T6HOufjDQ/HLOgld7OOkcSB
	5ntVCXSbjUhYgogueuhO7a76QCf5pUKlMDOkTVqgQclSrOuSb1gKeBTj
X-Gm-Gg: ASbGncs6DIPL0xBzDJfgSgNh0OEO7yAAbJTngVYYdgd2N3KwnMFOHmyDSx1eyitjrpN
	mr/MDBcH0Zx5kGDj6c72Wyl9Y1AX0i9y9vDz/7ejUW8rjX7K8kOH5B9f+nXjK2nM8VNGbj104JY
	WUD0HOnoHT++1uL181uDsWzEcB+VGXVZczzpYEMgHOBxeRErzsEnMHK1LHp4MayQu2Wwyf21g2+
	+LT/m6nQsXJzTEgFSIvQo2550CctVrKBJBnn8Fhte71FJsK3KA78WsaQSJiguHuc1m8Ekv0L5v5
	A6MTvplX+0PvXwXgHADJ/YiMixapampXgPwVUo1qLb42cO9VuUb2s+d109L7lcYa1ZF2/5o94FH
	ib+zhDsklRWtenIcECPbOzy2NTQ3ngAMT59AI20y7JGUNzPeFMm03YwoSwRW3P/SENMXsISbA7w
	==
X-Google-Smtp-Source: AGHT+IHuvIqFraNiN8NR0puxYSwhWot5sAD6I0n0YNnJu73K5zGvZcL2epC6OzOx08JfXiCYh9caNg==
X-Received: by 2002:a05:690c:9b09:b0:71c:f7f:d4fa with SMTP id 00721157ae682-71fdc418f41mr95400447b3.6.1756188663469;
        Mon, 25 Aug 2025 23:11:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:6470:8880:b0a4:b89:bd73:d8f8? ([2600:1700:6470:8880:b0a4:b89:bd73:d8f8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1883f42sm22700717b3.45.2025.08.25.23.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:11:03 -0700 (PDT)
Message-ID: <bce4e6c2-df52-4923-bb51-919271c2dc0f@gmail.com>
Date: Mon, 25 Aug 2025 23:11:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, jacek.lawrynowicz@linux.intel.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
References: <96e9e5b9-d7f2-4527-baf2-f7519ffbb612@gmail.com>
 <09906ca7-62c7-2ca7-5436-662a6c4b19f5@amd.com>
Content-Language: en-US
From: Min Ma <mamin506@gmail.com>
In-Reply-To: <09906ca7-62c7-2ca7-5436-662a6c4b19f5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I recently left AMD and would like to continue participating in
the review and maintenance of the XDNA driver using my personal email 
address.
This commit updates my contact information accordingly.

Signed-off-by: Min Ma <mamin506@gmail.com>
---
  MAINTAINERS | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..6eefa494000c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,7 +1231,7 @@ F:        drivers/spi/spi-amd.c
  F:	drivers/spi/spi-amd.h

  AMD XDNA DRIVER
-M:	Min Ma <min.ma@amd.com>
+M:	Min Ma <mamin506@gmail.com>
  M:	Lizhi Hou <lizhi.hou@amd.com>
  L:	dri-devel@lists.freedesktop.org
  S:	Supported
-- 
2.43.0

On 8/22/2025 9:42 AM, Lizhi Hou wrote:
> Hi Min,
> 
> Please fix the patch and make sure checkpatch is passed. I can not apply 
> it.
> 
> Applying: MAINTAINERS: Update Min Ma's email for AMD XDNA driver
> error: corrupt patch at line 10
> error: could not build fake ancestor
> 
> Lizhi
Hi Lizhi,
It turns out the 'tab' was expanded to 'spaces' when I copy the output 
of `git format-patch` to my email. A new patch is attached on above. >
> On 7/22/25 23:38, Min Ma wrote:
>> I recently left AMD and would like to continue participating in
>> the review and maintenance of the XDNA driver using my personal email 
>> address.
>> This commit updates my contact information accordingly.
>>
>> Signed-off-by: Min Ma <mamin506@gmail.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 10850512c118..6eefa494000c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1231,7 +1231,7 @@ F:        drivers/spi/spi-amd.c
>>  F:     drivers/spi/spi-amd.h
>>
>>  AMD XDNA DRIVER
>> -M:     Min Ma <min.ma@amd.com>
>> +M:     Min Ma <mamin506@gmail.com>
>>  M:     Lizhi Hou <lizhi.hou@amd.com>
>>  L: dri-devel@lists.freedesktop.org
>>  S:     Supported
>> -- 
>> 2.43.0
>>


