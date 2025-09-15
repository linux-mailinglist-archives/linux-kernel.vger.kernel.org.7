Return-Path: <linux-kernel+bounces-817288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170AB5801A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72C34E1CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2232BF44;
	Mon, 15 Sep 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLGCf9TO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9030BF78
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949177; cv=none; b=NLIvbmtjxz78WYpzjb1LeI2iEexEns31IGZBSRyVC3mP17Sz+iIfo1zCdLrmmtpcm6IY9zLpcjRvJPTztRzvkTIlrgwO16GJoVFAXBiqvN00uAhfTN/xy/V9/onBBgp7bKiPTRo61wjXp8f/k/qRrJtSl6n3zlpxyKaTPDJQ8Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949177; c=relaxed/simple;
	bh=JZsnQjbSavjo4iRyY0Jsfu5oNgRLIQnYQ6ozW8ZCMos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBvtCDT1PU6Du7rZgd7h8h/d6/vG8XrKFkeEExqnMO/CseNtfwiH9IiNyho9+g2f+cZ42/psaNjP1Y3D7F0WMx1NQo/iGNnKZKi3lxmkhBrJlNxGtcysp+ZgMWJspk3Eo6U39IDsblZGwXsj4hluw7xDy/xyCilbHuWcsL1+BhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLGCf9TO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e4b5aee522so2613815f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757949174; x=1758553974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYASgt88NcGmMcWlF6HmYxlmhj+ofg/BJ5SXgUevRck=;
        b=aLGCf9TOp8R/5uUHXdpUW61X18s/nfI/bKh/twz5g8Mv6LSoCLpvzjI4D22Aa2EUrr
         uem2q3cO+g6w9xad+qaLMcSM4geJLGOTVTy5AlKPgacfQZT7yEgf80nf/8RCYqXzwVOp
         oEMGCj6PA0IR7QUlFQgHamatSZqJKChk5/G025nPDUIkKiylDsazpwrpy/zFLHwM9b7y
         bavij3zAm3l5hZr8NwbDjC3Mk6FyAO4F74rwr3vwUmCwPmslw+ByGTCTzHaUsEShLVTo
         4KJnBkCduYhVzLbQsr1GqftSWr2BgnStAAFiP8jdtRsNaKST6Zm9/g11Ng9seoMqR0py
         if/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757949174; x=1758553974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYASgt88NcGmMcWlF6HmYxlmhj+ofg/BJ5SXgUevRck=;
        b=JIsCAMcG9VKQkm5uPEuGLTy1WlJzq3CRY4/N6LUvVkcORy6LIvtYQrpZJprXBiFQ/L
         X01Ac2bm8Fl1jJuyPtePCCbmEQ7T/uSPcRdnPR+yB4whrV0qcGEncLpYK4eyjvzWkv8f
         yq+PGYF5yN2bPmFo4s7VlYAhdZ3NBBhzmqFoZEFHNcMm2rKnmGOcIXWjF0EEP/14AQ/w
         gVosMTciDvW4R70BUqz5KQsKBLHKvu5SGDaMa+mVlGCjMqNyiC19m006wg3QYLj2YPlJ
         l1rwrK9Id2xOUmItrBZ+VKygTpWLuTBRaGDzpnEpwSGexfhuZ0JlM0PpwK8oWlfLFKsa
         3FGg==
X-Forwarded-Encrypted: i=1; AJvYcCVeXESWGJrbKgmBQRLt7RU0gMqTrbSK2e//dzmfZmK61CtKwFRC6CD7nMR3+9IOZDqS6DXWAzZRTeWSQc4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Cpc4mPQgSmjNa053rplndH8Kh+KP+y1lokk+H0GgaGHLSiB4
	xWkYvenHtiQfRXN8iTq9iVL1l0qDmk21aHYX4kl1qkOMXnVQRagSJafE
X-Gm-Gg: ASbGnctSo/snpNTsTs9ddfnakMaqu41EBT8EyxIfWVqrRqC3COBn/3uzbY4WQ6vpLSn
	y2C4Za3FAdbS3loVsFv2A5q/nZ8SxvQWg/RShfr0Ekofzp9zmuANQUOIPi/XJNpaQKqYiNaXM/1
	k1hF8fPvPCwTlu9JdpLkik6JpvRZ3c5d/0ezbCvvMuwwFSpRgK/y6j/rhoUbdpod3PxOWnGCW4S
	5tyS8XPhdCBFJRGM+kgP2jYK6QDTmuFe6+9E+O0w9paUuMj68nf8RGMlXZDLynICgN9A840WZ7k
	Lte0rK3XwalQh7NBEHjITuPNojNEJ6GGOFjoVKmq/ZXCC9Md80Xyi7G7XSGkNJLSgh9AGCvFXLE
	FIzndItIwbTEv38ZCLqcNxGegM+uBRSGlQP1e8k2nOoA=
X-Google-Smtp-Source: AGHT+IFQ6qmP6lhN+miezSHUvoqgK6PL3UztubUPwCE/xaA47jcdO+kWsn2hah9mUl3xrLFUWQbU+A==
X-Received: by 2002:a05:6000:420a:b0:3e7:63c5:9a9d with SMTP id ffacd0b85a97d-3e7655941c3mr10223551f8f.6.1757949173481;
        Mon, 15 Sep 2025 08:12:53 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8c7375fb7sm10001858f8f.14.2025.09.15.08.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 08:12:52 -0700 (PDT)
Message-ID: <d11d3f5d-ab0c-4028-a6e9-5cbf2f2aaec6@gmail.com>
Date: Mon, 15 Sep 2025 16:14:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get
 dma_dev is NULL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Feng zhou <zhoufeng.zf@bytedance.com>, axboe@kernel.dk,
 almasrymina@google.com, dtatulea@nvidia.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20250912083930.16704-1-zhoufeng.zf@bytedance.com>
 <58ca289c-749f-4540-be15-7376d926d507@gmail.com>
 <20250912072232.5019e894@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250912072232.5019e894@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 15:22, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 13:40:06 +0100 Pavel Begunkov wrote:
>> On 9/12/25 09:39, Feng zhou wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> ifq->if_rxq has not been assigned, is -1, the correct value is
>>> in reg.if_rxq.
>>
>> Good catch. Note that the blamed patch was merged via the net tree
>> this time around to avoid conflicts, and the io_uring tree doesn't
>> have it yet. You can repost it adding netdev@vger.kernel.org and
>> the net maintainers to be merged via the net tree. Otherwise it'll
>> have to wait until 6.18-rc1 is out
> 
> If only we had a maintainers entry that makes people automatically
> CC both lists, eh? :\

It's caused by a patch being taken not through the designated tree,
which is fine, but CC wouldn't have prevented from the same
dependency management.

-- 
Pavel Begunkov


