Return-Path: <linux-kernel+bounces-894517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF4C4B38A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0294B4F0805
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC6348466;
	Tue, 11 Nov 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY7TLh0m"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87C313E3B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828321; cv=none; b=Hryioc3p4jMuyYoNfkCe027GAZsOuZFTXzUQ5GyOf+cv6oh1m/56HMnMe8kgVRl3wWKKAl/An8OwZ84QqR61zaeJIjlMqYNg8boiYyfAc4WTD9IWP/gHAj8PS9UvhJ4nnORrUcEXe0O8TEjh5enlC7hMHM6laNqhvfOUFdZAyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828321; c=relaxed/simple;
	bh=yV9cPHk8dIKIWoV6mdgwaGrSx9FwHfzI8XWgtoJnrQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVvz4nIiMnxUfO+1kgVfa0Worw77budfAgYRpUkWuWzTL4frzV2pMfDEFmyUwdRgc3pDrzuQiJGLyZqDjmTMlhICyBGxaTWhKbf/aym6JdkXvf5B2gt6t9XVDGUo+uWeotHU/8W6R3LqJlItKefADlDpC6w9KvFzb/jy25bg71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY7TLh0m; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed7024c8c5so29172341cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762828319; x=1763433119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/klxSk7UtTirsvyrKiSGuSrx879X0M+sdkmegY3UDfY=;
        b=mY7TLh0mVfrD9ru9QrZiBGmdJOXDxfpMg/1/xH7q1yLWYusA2X4S8YorYJsMl2wwfr
         tqZ8UMImCxMLdlT+lq0RZICM38x/eVk6IwId3mI7vnb0Dx+dbN9uqlUl7/BYAIf3oIcl
         m4jQMzvBMdU0BtP5WqvrwR2DKtnAo/rEkjMzD0kHd2/EMCN/wc0TS1M4nx/e+lr2s/a2
         sKE2dYA9AOF34xSloa7HcjYT9IhCXG2b/FEBsItQSi0/uuKJ66Pi0NiFK1bG+peD09Fo
         nmy3ps+D9+8lTi5BqczHeOxewVhtkDdUZ2BXZTA1fg1mptDoz8IMMNOX2qrBhWbDCcan
         WyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762828319; x=1763433119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/klxSk7UtTirsvyrKiSGuSrx879X0M+sdkmegY3UDfY=;
        b=lFWUjIWyBKFEJ2m6XxKPOECVqlUkQ6+RlM4ebPl3aDXeySPAYQbu1I3lzSVeUxLij/
         JgGI1CwntM2sQ9kyyMGSxbUbZYxgElCNv6BBClXNDg8pQy2EKx9JmgGDKutVR4qR0DYu
         jCNXbkr8JP3AV2fs8aSARJwiS+ip+EkT8XVou5GApBIme7tsV993YE+ZrOHXa+FUdslB
         poQg7NDnVQNA1INLqbISPxRAn6fleiijzIwAMAGdU/zh6ejmdu1DlUyftMPB4g+sLw1w
         X7s6/PNZ/TEWG26cSQBPzIi4f5KRqp+Vk8hBV6fTKhaRyigB+2pylczny3dK+0yUFa3j
         asWQ==
X-Gm-Message-State: AOJu0YztkLp6/6+XNDW2VcvWn2SCfvNTKnRbnjYJyOu1hget1n2spH14
	dn09MDOKbKj4Hlt7yefYmtj5Fg88dnE0lX1opV6l0+rXsLrAK8x1tw9m
X-Gm-Gg: ASbGncsiey5xyauas+esSs927EgPw+pyBTOzq6RwoI6/JkYsAjvu5LJcPhe5NgnRKLv
	c84uD6eR4pc8z5u9g2T05vUqFGHoalkI7Bfi7TUbhT4LR2d8nPX+qe34Hb65yqQM5mOZ9DROz6v
	Nr+nwq0Kknl3XjKH6yoxyAs5+FssIrBXFVQxnobQ+n8wOJ2D+U+6VNdVLR0NBvM8grYpXzOHV0T
	NER0rvkT5JUgQzfvhuMHVgKKyI7Ri+4OHaiQGqcEBCVCxvriwcgL+h7wNVJi671V5GBvSOT5cH+
	Mql01BboNGTOIQ4MvJD6jFOI4cmhJMP1dAIjQ8KhX9pXLQnFF3PN2zdYBaK5Yqi/r6OI6D9cU19
	Ju8q6Fp7Z9Wb+4WlZ0EP0rhoKEKY9Yzr1Sw2JNra8uO6kO1C/5EokCo8+xN7XuVylo8cX5yOIyq
	KyA0x2dv4=
X-Google-Smtp-Source: AGHT+IFn+vjJHlq24fT2sBNnkUYmhDssFsbnrCMPiJF+OP/zw7CiLhchDG+Dlttk0AGAXdtB6JpCuw==
X-Received: by 2002:ac8:5d56:0:b0:4e8:9f46:402e with SMTP id d75a77b69052e-4eda4f90156mr128481231cf.40.1762828318658;
        Mon, 10 Nov 2025 18:31:58 -0800 (PST)
Received: from [192.168.1.50] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4edcab79093sm8694271cf.18.2025.11.10.18.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 18:31:58 -0800 (PST)
Message-ID: <d836336a-7022-44e3-9416-1e6cc6a70155@gmail.com>
Date: Tue, 11 Nov 2025 09:31:49 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/9] xfrm docs update
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
 <aRJ3rVhjky-YmoEj@archie.me> <20251110160807.02b93efc@kernel.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20251110160807.02b93efc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 07:08, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 06:39:25 +0700 Bagas Sanjaya wrote:
>> On Mon, Nov 03, 2025 at 08:50:21AM +0700, Bagas Sanjaya wrote:
>>> Hi,
>>>
>>> Here are xfrm documentation patches. Patches [1-7/9] are formatting polishing;
>>> [8/9] groups the docs and [9/9] adds MAINTAINERS entries for them.
>>
>> netdev maintainers: Would you like to merge this series or not?
> 
> Steffen said he will merge it.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

