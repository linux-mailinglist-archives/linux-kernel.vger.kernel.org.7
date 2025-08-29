Return-Path: <linux-kernel+bounces-792135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9449EB3C098
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F000188119B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4432C306;
	Fri, 29 Aug 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YGS2dCDM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F432C31A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484613; cv=none; b=e8LU6fY6mqr60g6J6ciCo02FnTOeCDuJddOLYqbRyNAjWdHqeGh8Vu6K26eKJ4vlRtNBUj9XzKj6FDvvtlpz8czkutAApO37VnGTuNGsgXKYclF5WbGziZ7fbXJkLU1zh6U3DTAPXI4qn2gxC+9v0jM4VJORgVGqVPOyHHTApEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484613; c=relaxed/simple;
	bh=IEH6aCSgySsvmxeMGyD6vtz2AyYfOBhMUEbE5AuvFws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKROefP/KZZs6Uu/hzk9CszPjHjHpjb7EzCvl5fuRUdBbF7K9WiVpAF/wWTxE2E4yLzBNdz0XVU89ZCm6wMCL7rqVxWfpUGltq8fWJyaEYaxs7g4QOjJmmgCdt+lXutzNML2iwzFENX6L+ydpvFegIQ98X5uULstIisE8BhV1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YGS2dCDM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f474af957so2638337e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756484610; x=1757089410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=YGS2dCDMS9XUfLKpohJWkXpge77RQbgPfn3CTlT/7iUsiD/V1a1zhHYt6cv89hKdoN
         /sNDWoIcM7U8FeLscHnb7amSX2NE8n8v9dYUdScpJumYV8rnbGdFrn6Ce3m14lrl24V8
         zLvkJHH2j/FnvdC6zH6CPnaSfA2TM/ORU6VkWKWtjhA3Mn129AAFxTai3GwOAiUgOHe3
         ruyF8FblqmNcNxlHlxAvkup3QpkDsfxpwsc5mouSC3fHiw4AqHfxHEURrcNo18NJo6yr
         eq+9LkTJhyd32bjo1itZjiW/GlF6eZFsD88pothhtEaahI95mZh9YzMO+co7BT5Y7ucr
         5MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484610; x=1757089410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=nC1PF6Hv6l9/J/5kBHEZEKW1q4Z1G97qWwyEvXdFoSYPvgx7bo3uw7VLWTDOwS9Wpw
         3FP3in6hSyNLhohN264r3Z4GEfBOb0WPUCDFBuSqCwO4gzHODSgvZqZwVpdZ8YjoWzM8
         nc6rLg4w3cpjfrt/xn90X85yxvIdiGm+fDPqhGBPy1bDtsx9z61Q9wzGZeRHUmwW+XNZ
         sr3Mq7b/MIII27aFHIDxbP+frPLHeEFpy+YJYsHRkbMlqd3KjHp5M+20vmeshKU6HTh6
         fp2vMNHClcVpwQLA3gJy28n9trOZxr2G6kQUwbp28t+MU1VMfNAzuOkmlgHuN1T+Lwx2
         Qphg==
X-Forwarded-Encrypted: i=1; AJvYcCVawjRbA1p4mhc61bk3eZGid6vq1/6ub6Axw5p3HcSKRx6w++XcT7plBC8j6L5YuADRdXe1hZzPyqPUZ6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSZQBbH9SeW66tqlxETpnFvALN8nhkRx5xsyAFm75BufY8u3J
	dUljPHzjJZM+ud37Z7UTx86OY2Qe/PkMLQLHHBwSeaP1Gpd6fAcLmeD57ivUCDG1Zhg=
X-Gm-Gg: ASbGncvLUk1N3dGZaca95+USKVVDnmidZDXP9vh2pyO8uBrLVHe4NypOzRGNCJIvAO5
	zD79hPk8T/GHXbJNRHllHSfk0D96cAqB7/0+0AxYlGM3/UE+H9q8AsUoiQ7BJDjWBdf2Eq/+OI0
	R+9kqjw5bK9etefHBXpsOwjotguu8hZLVXhfejS3u/ZJPn88OExzoW7QktAW8aqHxfSFR5mYuG7
	D7YxMGmbrsEkE8/ihffhNavwQWXRvt3ECi6Ob+q3+kBvCIfSfVBOlI1hsZS0gCimf5fcp+qdDu3
	x/BzAGaU+dJ3P/KsObue8d63r5Xbg2gefBm+DK1qMYNv50XZPEpSYJq9EGL0DgotbUOG4K8LBHi
	//DHoOBvp5Jxwcp84OQXyV/1draHPmfmQIv7IyT3ONlzo+vlGkyiGqT8iLXeVaEjibtQTvI4KRk
	WIWw==
X-Google-Smtp-Source: AGHT+IGkDyVgClqPhi+jy/rUB2ZmKr6ERUVBat7raNEZp8G3QswM+s5vCryFnVhmubSoyKXakx8cmA==
X-Received: by 2002:a2e:a99c:0:b0:336:bcbf:9e with SMTP id 38308e7fff4ca-336bcbf06ffmr6988971fa.20.1756484609848;
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b468ac23sm5215941fa.23.2025.08.29.09.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Message-ID: <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
Date: Fri, 29 Aug 2025 19:23:24 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250829084747.55c6386f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 18:47, Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 10:53:41 +0200 Linus Lüssing wrote:
>> This patchset introduces new state variables to combine and reduce the
>> number of checks we would otherwise perform on every multicast packet
>> in fast/data path.
>>    
>> The second reason for introducing these new, internal multicast active
>> variables is to later propagate a safety mechanism which was introduced
>> in b00589af3b04 ("bridge: disable snooping if there is no querier") to
>> switchdev/DSA, too. That is to notify switchdev/DSA if multicast
>> snooping can safely be applied without potential packet loss.
> 
> Please leave the git-generated diff stat in the cover letter.
> Please include tree designation in the subject, per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
> I'll leave the real review to the experts but this series appears
> to make kselftests unhappy:
> 

just fyi my email wasn't working for 2 days and unfortunately I missed this set
I took a look now on patchwork, I do have comments but it's difficult to reply as
I don't have the emails and have to do it manually to each, so I'd rather wait
for v2.

a few notes for v2:
- please use READ/WRTE_ONCE() for variables that are used without locking
- please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
   __br_multicast_stop() takes it itself
- target net-next
- is the mcast lock really necessary, would atomic ops do for this tracking?
- can you provide the full view somewhere, how would this tracking be used? I fear
   there might still be races.
- please add more details exactly what we save on the fast-path, I know but it'd be nice
   to have it in the commit message as well, all commits just say "reduce checks, save cycles"
   but there are no details what we save

I will try to give more detailed comments in v2.

Thank you,
  Nik


