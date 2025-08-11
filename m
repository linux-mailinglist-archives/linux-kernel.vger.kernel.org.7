Return-Path: <linux-kernel+bounces-762827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2BB20B40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537E61884E86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934E22FF2E;
	Mon, 11 Aug 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+fsxgiW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50C1F91F6;
	Mon, 11 Aug 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921075; cv=none; b=J9I1AJi7Ti+7wIHg2Ka2xJVAO1tbO7yn9eMJg4e1zdHncIlyp8ITYKErSPK5RCOfdtXsq/wgMGXHNnRAcyHyH/Xzjd/VjnDwGPH6zDhwe2U7ds8os1lv97lDCUyDyfUi7GbYyAKgWw3I5uxLTRc9dgslMFuIxe0nJM0FwdQR/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921075; c=relaxed/simple;
	bh=RmgTHIaDhOguz+w7nmvLbH/WpMkuuGx2b8fcu3B0jaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0SkYf3ASZycbiapy+TgKkRKITz7Ys8FYCKwrlwzXJY/eTI7sGzuKy89/uT24C6o348gLoyibbgXOS+hRWroevFakRshDJaSyAiRF7IquNno6rM/3znVHitjX/4Xes5WokERsMgK5ul/TwnKFiSL2TJHiaseADTKs2s61JXRSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+fsxgiW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24041a39005so27711155ad.2;
        Mon, 11 Aug 2025 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754921073; x=1755525873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YUTK53YIspNHhHoCh8vVSDbdxt8XCkmaBRBU4QetOB4=;
        b=P+fsxgiWWykuFCzbpVTDsn9RyCGrBCIbJqpLhPCeR1pnqRyvRqLbgw4wgiO7qbqfw8
         kEIHJN87ebhY4HyzXIxju4BS4pci5Q2jr+LZN2OBlt63jSl4815RkOTms/Lh4OuLdjc6
         kVJBO6rJk/B5UNo4ItHvXpneGLkPpu9L3y6zGIxnrFONCe/JRAaAkNUF9es3clCPoVVe
         TPeepVzXzbn06krpjNpuyfrEt5+cLxR8hU1lf6a2/gp10wQepjhblLPiSWu3Miow9vvj
         yyJkOKe75IKcCUNGcj4mBveycmTAbLHh+8HRhqL1EA3vLIr3nn3V2awboy/5CpkwDitr
         3EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921073; x=1755525873;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUTK53YIspNHhHoCh8vVSDbdxt8XCkmaBRBU4QetOB4=;
        b=CrfneS7pZL7boFqxgjXgFYWYAiqjt2QwWKvtJ4oqeVrKm17WEtcbezmQZBt2K/ORtK
         VqgdisLf6oYvoOIf/zh21QpsR4Zw4HRU57SF4MJpbSec4qX2ppOHtuyEXKo6G02JTD5L
         k3XepELQA2vu3SW13q/P/uXeVxdhy++7uqz0q6lzdZSne9I0GhHFezwAjXFi7L5CBPef
         tI+6qczODEAQT0OFN+y65CKaD2qWdpAoID51Fby5c5G5RJYDpWfe7cVXOT7ddTrD2ys6
         VTlIzYQtGUS94H1hR0TKxIvf62VkL4rVAI6CstEwaQ0RTWNnvoV/p3RwJwjyOKlU6r/V
         sa4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIazbYs+KMFo3B1dbFAJfZi8VT0AW45E2TGOwLu6XaYtwjDYbzwMKf4eTNBq86AfF3pBx4Ui68+237gW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1galOiuhg9p0vy0cDiD6LwFOhoAaLa5OYz3g0PKNAm/4dE8J3
	gYAAYPu7WOhWE7oFJmCB0nSRAlbrII7eZAxAWBi8L9imAg5u+mSWygX3
X-Gm-Gg: ASbGncuZH3qC5uHM2pPOOn/R1NJOkpd/3dnwIlIPBTl2SvAeRFze+ePsw3MswFD46xx
	HUDYPuINS0lNdb+xxfxsxxYxmf9mrRC1xR24sY77+hoAAfExy7pi1Kt95aNrRyfGA4wPSzao5Tn
	p01NM3g8EVWuB9f6mNzmvXwim4U9b0zlVyreSNsdlpsw7oTQ8yrstSCfFFSo9g6jNk5ykCdrBrI
	d5dp6WwKorl+LvBffjzjEwmD/03A0BFR13PZLmpieDxKVD22UHCtEnb0cifbZ8uJ9AQ58dCCfzS
	3tb+jkLQPL5vxuqIACzW8YaRMMPlcHOd6JZngEzAd3njVXEk+Tncw+Npzs6bIOylEJDOHXqbz1E
	9BIUPNgJvhkXJpiIHsZ1FJDywVB/3ofNLa1UF6LkigFjkK2qDLCmPCZJ1KdqeoNoT2OrPI4w=
X-Google-Smtp-Source: AGHT+IHbkYXNAxPAuxg++nImkbnZkg3L+q8zj6FyMyfLfo1rJY0xudYw/DYfXMbWZB2Ek4/URlIJdw==
X-Received: by 2002:a17:903:3b8c:b0:242:460f:e4a2 with SMTP id d9443c01a7336-242c2004168mr157897575ad.23.1754921072812;
        Mon, 11 Aug 2025 07:04:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b6casm272694975ad.127.2025.08.11.07.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:04:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <112dba6a-dc3a-4b6c-b558-e1cc87636dea@roeck-us.net>
Date: Mon, 11 Aug 2025 07:04:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] hwmon: sbtsi_temp: AMD CPU extended temperature
 range support
To: Chuande Chen <chenchuande@gmail.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 chuachen@cisco.com, groeck7@gmail.com
References: <20250810084307.41243-1-chenchuande@gmail.com>
 <20250811050752.76030-1-chenchuande@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250811050752.76030-1-chenchuande@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/25 22:07, Chuande Chen wrote:
> From: Chuande Chen <chuachen@cisco.com>
> 
> V1 -> V2: addressed review comments, also save READ_ORDER bit into sbtsi_data
> 
> Chuande Chen (1):
>    hwmon: sbtsi_temp: AMD CPU extended temperature range support
> 
>   drivers/hwmon/sbtsi_temp.c | 46 +++++++++++++++++++++++++++-----------
>   1 file changed, 33 insertions(+), 13 deletions(-)
> 

Introductory patches are not needed for individual patches and only add noise.
Please just send the patch with change log after "---".

Guenter


