Return-Path: <linux-kernel+bounces-766660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E3B2499C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AC616C00F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8EF2BD03F;
	Wed, 13 Aug 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pD2miAJY"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD326A0EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088625; cv=none; b=uwHVU0eYyap2cntRlf+ULybmLyDHz+lPDfg7tHuxPQtrofFxNadAM6fsj8tKV2e1mZmbOPbUe2vWhHpjtjBcE1ojEIHtVvphwvaOX5U7OTid99Zb9TBHeGop59+sbY+adssEqShsvT+aQm9VnUYiPawXQRGPkZcCufuogVH5oT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088625; c=relaxed/simple;
	bh=Dio7h+uqlbgU4biS+L4BkekXjii6MxHsEIflkjyhoZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjMKKfYiEhn32aYEANZlRwPyX+pfo6OqpWzTZzshUVf/i3t/+Zxav8eNKo/PQGlbNTx3yci3cPPV8lUBalSxaD7jIoQFi65KftpQ+ZLDoPLGRWBcdKK6BHcjAgyflKUNM/WpPeG0p+mV+RadmkOmY5vnqZwnZWgRR84tiRakkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pD2miAJY; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87c0166df31so399565539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755088622; x=1755693422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJSNE7TDIwDdVBJivdzquzFfOdkEAZ/NqbU/Si8oVJo=;
        b=pD2miAJYs2q425XHx+ErrycxYy0aWLorgV+N+BEtt3PMXn3QTBQc/Ah2lGcPD820qB
         E74DBg1bPByO5HSYdhTSwYD8bLUEOJbDQ8e2jnpIxNCtYRhEbfo9Ix2NstSBBhnBZNGZ
         WXznnvJABFi6BtCd7FMr9GLHJRXQtW5SPUrTMGlIuSnKIKYS/yTJsFRUGaxROJV8BnxB
         Xqz4eBXVQvTghFNh36w7NyujD/mC72zb1456B9zuk2Ga4ljDPb8Qkc1D2Wp3BpZj83eC
         NHoCOcwXtoo03WoOygHQxYbRa+JDrrGHjBxXfWDr1UtYeyMDwEyWqIUHHQe+xmxfoBWl
         TBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755088622; x=1755693422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJSNE7TDIwDdVBJivdzquzFfOdkEAZ/NqbU/Si8oVJo=;
        b=LkwPfyp7ir3e+zsdjZOmHaRwARZYILRaCQ7ww59KQ/monnFBu7YCAMGZXjZjx92fkL
         c1pYVmVcaV40X6I7NCSGrt2XsEDX60+W7BUlARLK+ciFYoWasl/iiGZDv8iMuqBv/+Rq
         SwS2Ef+yaVJFFX/3CzGQg8zFlsdjJEXRAJlVx8vjH2axRgwdmzMAPz4kCKGuDNMRwjXt
         xnhEGGxMBXc6QSO6fuom3vTx1N98/w3zTX1nyV+ZT/tyjSUE1yG/DOhqNF0GqEIwq4DP
         i64tzZsVhmHP/j8Cg5sL5qeXtZ74rjeyqI0tyY00AHqpUJ1sXuPuLqmgWf+UOvZB9quS
         q6Og==
X-Forwarded-Encrypted: i=1; AJvYcCU45B1wYwopWTop/rTOfx7TOmJiW+BvyCIGFgRyd2dbEXDS9xJv4tR+z07u/txj/SYPgaERdqQuJtm/ZHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVJrbHUozPd30JKTnNxpwZhFT69LWNQfeMsia3kh7U0rPpzxS
	8o5TwwYpBQ0C/97O1L3cc2HCx0QGCWUyZHQfhZM3iXKATn8WKu8DEs88B0rJvGY80eE=
X-Gm-Gg: ASbGncumwYvaCdxrUo+Yv7m4y3ZsUcAFoLjXv1QT0ZE3vVBkB7LRKZCRbGkepvrO3km
	io2/6QodN4WvTgp0H4JTxZJq4H1Z4vUO2Lk/byrluILd6aaX7NoncXRWwLIaE1Fb0lS4oMxYRIK
	nqZy7OjQE4XVsptSISJa55c9CW5ycj1ddLcFupjfVxKZCg1HMFy9iiZpme1+xfl8XD8TNqq/Tlt
	pbPLP/KQ34nWkCgzgmz/8n3gh6Vw3/ssLxD1QK6SANkY6WP95xIcP7A+r2t+CrHro4HahOcI6L7
	m3QL1cvklpJcyNSY4k/MmIgJnKqm75m3vs6shNSisEeysLJaqVnrJHdkh2HT/aYXTsQ22ymjYKu
	ppnEero8lt57jyH/mjg/LMQ8uesSS/THUSKiGbURtwHWdwaepO5XGesGzAitAyR5qgm0fG0BZ
X-Google-Smtp-Source: AGHT+IFnwEFQtUPVw9g9mmFiyfGLoS5nlr8HAUmqQnFfYA2GdWoqbZqkoS/L9fICYJiWR+VCb+vYyQ==
X-Received: by 2002:a05:6602:14d4:b0:881:7837:6058 with SMTP id ca18e2360f4ac-88429514720mr521566239f.0.1755088621539;
        Wed, 13 Aug 2025 05:37:01 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19c1475sm445898339f.29.2025.08.13.05.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:37:01 -0700 (PDT)
Message-ID: <fd7ac07d-030c-41d6-94dd-da53b593f5ab@riscstar.com>
Date: Wed, 13 Aug 2025 07:36:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/7] dt-bindings: mfd: add support the SpacemiT P1
 PMIC
To: Troy Mitchell <troymitchell988@gmail.com>
Cc: lee@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mat.jonczyk@o2.pl, dlan@gentoo.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux.amoon@gmail.com, guodong@riscstar.com,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250813024509.2325988-1-elder@riscstar.com>
 <20250813024509.2325988-2-elder@riscstar.com>
 <aJyC5q0X8mj1xbSB@troy-wujie14pro-arch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aJyC5q0X8mj1xbSB@troy-wujie14pro-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 7:19 AM, Troy Mitchell wrote:
> You can change it from this to my company email:
> troy.mitchell@linux.spacemit.com
> 
> Acked-by: Troy Mitchell<troymitchell988@gmail.com>
> 
>                  - Troy

I will make this change before I do a final version.	-Alex

