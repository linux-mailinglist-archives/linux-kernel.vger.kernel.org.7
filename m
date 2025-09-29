Return-Path: <linux-kernel+bounces-836734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B519DBAA71A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326C219219BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AA2417E6;
	Mon, 29 Sep 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZ+l9q9b"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB419343B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173550; cv=none; b=lSvGs6hvIFzLFyz/tWeIedqJrfAI1Hr1Cc31WBWu1GgDhIgNkszHCIG1ruqI7xVrVepVJzNSvhzU2qLTP39iWw4OJS3LklM6EWTTQyQjRcnw6694B2/Qn8Jrpw8vDhIEJivgWAL7u9kibKoIhcyrQFKHG7qSJSRbeENb5CRA664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173550; c=relaxed/simple;
	bh=zBnad9EJYfVwk4ZBFsZ2fTR/TQrtexdZk0mtIk48Ptg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqrhYe7hXao4mjxFCe/VBOnEJOPrdc7R2JwV9sXbdA+vaZsQCyrNbEJRJ/6BZGHbc4dS+ORbW6VEKrvFL2YynafB6aDATIqoRLXoD8k/eFZD9L3pN7rzxMC3EBpxlPtuAgNtDjBQXkrTLQ++kaoQLTx96w7B2tQdRK4qmiFddhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZ+l9q9b; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-91e578e2a61so90404239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759173547; x=1759778347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dCy2LF3KV1f/Ee8OpqPdEz2rOo1BLwqJUwgqG/vhjk=;
        b=XZ+l9q9b5G8FH7bL4mH7K581p+ujSsSfoES0ObSSuv9GATVe1kpp0/zVViF8TPdMFO
         ItHrOm7ZHglKmYCnBCHIQ1J0z+l3o3cGxOhLUhhtJBhx0O0dRSwzioSh5QpET/OG7Rde
         ouwSmttJ7Hd+KAHWQHpEv+E9AgFKV4t68koSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759173547; x=1759778347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dCy2LF3KV1f/Ee8OpqPdEz2rOo1BLwqJUwgqG/vhjk=;
        b=wj0zPeCyahCjmJDAtExmGMe1dV2ZAEi8E6qYnN6efaY7gGSKkaN1M13pPNz6CNkvrC
         rAo77fgaUtsSU5sWouea+mismb0OHWrf6pTSl4h3FZRfWoJD6+XImdOIWAO0q8z0Ur4C
         PBwrHrDAKK1h6mS5TU2MBA44yxQaGWAKNmOfffjVMyjDwNq2oYb0rjvLuEXe2JkT4UDH
         GY1wg2ARkbRoV5+1cWhzLxffc1XwY/xSVXRi0dAmkAbHR8ufXOa5OPe/2gakp+QCCexn
         froJk85tIZv/GFBQA8mzH7EkAByWNQfy/YPEMIfvhGD2FPITfqbnRdqytbPt+76L3XcR
         A1tA==
X-Forwarded-Encrypted: i=1; AJvYcCVllr1OOiVq60ELGKMgF6zbk3lcGSgs06PFyHJIlamGu165JnIGDcY26gPbe+kXzm6vl2aR1ORfY76zpcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl5v90maCYZ7DwBdFrPFRHgFGU8UROkb8uxMzAtWvuNtHJmrYl
	D08E7g+gYEePfgvDkPnkK6kwHm2zBGGpte+/PxBm1Nsv0mJrUdxYOzJkvSyLhE9Lhr4=
X-Gm-Gg: ASbGncv8NBKftvY2EjbhVGBGnSirVkwqqGYLR0cWzTj7wVi0n4EIbBUeZOcHIVT9Ryj
	6KfDrWUs82ty3BX0ty2EF9SuT72OlD6OvP6U3MRNopFsh/wnXhEy0eNoDM7O3cCMOXM3C/oweYf
	arKaNMZ7I/kE29vLmVdvlU8xCRXPu70UBmfSkupryQlZ7joJ5eOMfjuEenbY6/YmnhUszmxnaqY
	HeD6iMPCWtOW9N8/BRb3ySkC9bWrRtjcOmMYGMzyti9h7dFdlYvnNhn+dgMjZUT6e8CXAIlcF5l
	fKf7N5jp/Ofd/295HbVznrfrTTBvg5i+V+oERCf+ZfqO7i3U1bO3tcWeeE88Y/gtsy/R9CLRJlu
	zw+owobLIbA6BEJNeHSMKI3yyrUgmkWSZi9WYAS9x44q/Yg==
X-Google-Smtp-Source: AGHT+IFXQJniqhnGOTj1VN5ttpc6vFUxHUYPG52qF0U1SkqiJdALjmHy1lmnRSwcbsmg9Rs6bty/XA==
X-Received: by 2002:a05:6602:6c13:b0:92a:e2bc:d861 with SMTP id ca18e2360f4ac-92ae2bcd88bmr545063039f.1.1759173547206;
        Mon, 29 Sep 2025 12:19:07 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-91595607a87sm309780739f.8.2025.09.29.12.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 12:19:06 -0700 (PDT)
Message-ID: <3e9d38b2-4fac-4048-8fef-e989630da9ee@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:19:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Qinxin Xia <xiaqinxin@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Barry Song <21cnbao@gmail.com>,
 shuah@kernel.org
Cc: robin.murphy@arm.com, jonathan.cameron@huawei.com, prime.zeng@huawei.com,
 fanghao11@huawei.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 yangyicong@huawei.com, Shuah Khan <skhan@linuxfoundation.org>
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
 <20250917011759.2228019-1-xiaqinxin@huawei.com>
 <11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
 <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
 <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
 <ae8a2c37-74db-4e53-99c1-fc7f86e80253@huawei.com>
 <5900de48-e4a4-45cc-be7d-c906a59ba04a@linuxfoundation.org>
 <22825b66-1648-4301-855c-cdbdd56bae5e@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <22825b66-1648-4301-855c-cdbdd56bae5e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/28/25 00:15, Qinxin Xia wrote:
> 
> 
> On 2025/9/26 06:09:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 9/25/25 07:11, Qinxin Xia wrote:
>>>
>>>
>>> On 2025/9/22 20:20:39, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> On 22.09.2025 01:50, Barry Song wrote:
>>>>> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
>>>>> <m.szyprowski@samsung.com> wrote:
>>>>>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>>>>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>>>>>> maintain this module.
>>>>>>>
>>>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Thanks!
>>>>> Marek, would you rather merge this into the dma-mapping tree
>>>>> instead of ACKing it, or would you prefer it to go through
>>>>> a different tree?
>>>>
>>>> I expected it to be taken by Shuah, as she is responsible for the
>>>> tools/testing/selftests/ directory, where the dma tests are still placed.
>>>>
>>>>
>>>> Best regards
>>>>
>>> I'll send V2 in the next version to fix some of the review comments of V1, and maybe there's some discussion about V2, I think shuah can deal with the patches of MAINTAINERS first :）
>>
>> I can take this patch through my tree. Are you sending v2?
>>
>> thanks,
>> -- Shuah
> Hello Shuah,
> Just pull this patch into your tree, as Barry said.
> So sorry for the confusion.


Done - I will send this up in my kselftest pr to Linus.

thanks,
-- Shuah


