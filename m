Return-Path: <linux-kernel+bounces-815252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AABB561BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560E71BC2742
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D264C2F0C7A;
	Sat, 13 Sep 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkowNWwM"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38802EC0BC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776211; cv=none; b=TE6Sgzh/2YlV/df9ZbapfBQQJSJmLN49QWOYJ13BWtAZ8CLHw4b6BG146UsOCWaEYU0x8mivj8S/NIo6PuRffbG1EjauTMk9IhQ6Xj04zLA2pdsq/XqP4TSOl2SQB+y3NX5aLpDTUTmPn4KjQRkCupsFg66V5U4eKMqcHDpkd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776211; c=relaxed/simple;
	bh=MJf+OC3maX2ZmdUOw7mY7bTSxAiXKJBHLm8Y1+eYoXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxCfP1wtQBrSiHdpS1uYoB/MeUY1WdfwaZPHHFxAbxceFYkifcnWQTr0pnSbeiaP4yZ1S1CZ6oaxSc4QdYUnp2Ump6E85oHOM3Y20mjKd2ohRTYEmxhb1DIGkukxuPsKhMh+VQQlqnIE5AZlb7gyadKjQ9OMYfmON8TFBcD53Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkowNWwM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e11f35c0dso322653a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757776208; x=1758381008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzdPa1s2Ytoialc1u1fhJTSVdVzF4hVkQANScdjlGlw=;
        b=GkowNWwM2UO5IGbP9o7MyYDkosSehC5DC28O7ahrgker2plf4x5tUJ1yzHTBTZDqEF
         Nb15GfEvJGsN+nLWtx6cz/uHFmWLYI+SZt2v62RSK5HSQkTki0CFRQFKEIlnYiG4SRax
         UOUCRYH6x+7tw0pv5xGhFGgS1dBVCKuEelKvclzqbYr6bPz1tKfGw8FljajcLvYqM6Gu
         JcQLtCGpbc758pTtkju8sweD6VQC9vxGvu5lMrR50w4TQpc35YPUKFuq+8MdgpJrAzbu
         pZCYB1I8GJf2/29i1uap9+DUJgLd0OvZ8eA4FarrOu5uCPF0OPTb/+sxrIRYGJfMYc5D
         Sxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757776208; x=1758381008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzdPa1s2Ytoialc1u1fhJTSVdVzF4hVkQANScdjlGlw=;
        b=HSXqGHb9WJwZCQwAtJYJ8n0KghBPUtI2JgokHX9nmoLqR16nESn2LLHQBvjs8C6NyL
         X6sFXxBnMx/gujI099ivF5MGJw1bOYwNzFEsjFXKnHFG25DsYbyXfTQINGjMhOYD3umQ
         p8jgS9PA107qaucAD1bzHBR/2r3yn9MGKrrHarhLClqbkCXjTYVrAAVNTbkHNhYS31dF
         Tp8E5bXm8BWl3MPX5qRs/R8CkqYVmYORttKpdoIy+Dqjd830RET6ws1npqcr4usTSO1O
         kydA0tYcp6GGiTcdGNAB4E4Fpr6RLIv9SDm12Ub3J/ckGikRDggrSWTogq4Ugsww+oLb
         VBuw==
X-Forwarded-Encrypted: i=1; AJvYcCVAYEqF3TSWkJysEJdfQMVag4+6qsd5DYc7viNZpy5zfY07EG0D/kfe47X1puRr660Rds8S56ml0rjwVAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAVUBtJTgMM74q1kXIKWsOKteHMj41VnOp02G6ZT385VlyWfL
	bX9xL8TkkKHdklwXlGM6183u0N/uur3jjV0eurJzw4pqTqX8boophqRq
X-Gm-Gg: ASbGncuXe0/fYn1IOIE/iXh9YOsutfFMw0t6lqPutc/mYHgtUvAwxH1Hz4pjhdVs4G5
	2mw2ylfxrJSXYEh4M9BEulZnQ5OiJcanFss/pG1nqrm/dStf1olfWrKY7n1jt92Mup5K+qcgEQ/
	WRhlUh/lMgkSpDlu8MnDjJ5qxD1OiwY+GgXnkdoyCUKF/vzCo4yqZoVLmsEqFKXU+j+RSRbEXZk
	qEtmQPwjO4leTDEh7NV73uLCRlWmSDTXSWH7AaVLO6S3a2yApvKMh7HaxMi213pP0tX18FtL7fG
	Fua2iJV1nyRYXlMXb2QkL0FjqxhbGaEBjxkl7wHPIx/FAc7PWsPpBufmfWde/HUpDIgGWRK5+L3
	QzZBtYkhgkNDTrYVbnmOhH15ct7VDOaYsPMh85+7j9blnYI5fYdW6tpBW+A==
X-Google-Smtp-Source: AGHT+IFQLwKW78Eyf3cNt54Zk3w44x+XzWX4t92z77pE9LBL04QN3MjfIphxRI6bKsbhdofevXIVfA==
X-Received: by 2002:a17:90b:5750:b0:32b:cba3:6361 with SMTP id 98e67ed59e1d1-32de4f982bdmr7023218a91.26.1757776208005;
        Sat, 13 Sep 2025 08:10:08 -0700 (PDT)
Received: from [192.168.1.6] ([223.181.119.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a4781dsm8798357b3a.33.2025.09.13.08.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 08:10:07 -0700 (PDT)
Message-ID: <3081647a-a4dd-486c-8a3f-c196580a9ee5@gmail.com>
Date: Sat, 13 Sep 2025 20:40:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: dts: ti: omap: Drop unnecessary or unused
 properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com>
 <20250908-ti-sdhci-omap-v2-1-72927890482f@gmail.com>
 <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09-09-2025 12:50, Krzysztof Kozlowski wrote:
> On Mon, Sep 08, 2025 at 04:17:12PM +0000, Charan Pedumuru wrote:
>> Remove unnecessary properties like ti,needs-special-reset,
>> ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the DTS
>> files as there is no user of them.
> 
> No user? That's not true:
> 
> git grep ti,needs-special-reset

Yes, my bad, I removed them from the whole node. I will revert these changes for the next revision.

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Charan.


