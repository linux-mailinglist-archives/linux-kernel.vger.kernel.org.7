Return-Path: <linux-kernel+bounces-767567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACECB25603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A8F5A4BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E12EFDAC;
	Wed, 13 Aug 2025 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bII1u7aT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B92BDC2B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122144; cv=none; b=Dql8ts7jjvlN7mwCtUlWc9DL/QbUoVnxRvxGuedanrCVCJ8T0wBv4qhPkksePXnEKkqa9WTj86SCS4VKBOw+xKqTqHMNJSpuKfg6+d3AZld13YS6acKWmHp/VSHpke/0YzLdmTewndxmLvtAhmYK71zMUA3M+F84IEMdXEu3KeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122144; c=relaxed/simple;
	bh=/92sLgVIXJ/37jnko37eHBxZTjkYG5hjktUyq6kVHPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFQLU4sdbH+aPYP3i+gOAzL5CsA6NnBRK1Qt2NvsTIiTh+rNqI/2wJsI6pb3dqrnbzhhNVZx+hhQwSiqJXLXGebA56tNk629yatJQCFiUSp+iqENqMj9WpPwJD/LOcRwXxkDl/doqBEmuEYqMjuuJJBAr1CF1ymRQXYvITf4MDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bII1u7aT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so2249115e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755122141; x=1755726941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/92sLgVIXJ/37jnko37eHBxZTjkYG5hjktUyq6kVHPM=;
        b=bII1u7aT2pTxcFMdZOhFQXgOWykgLzkv2yi28DESlN23iMdwNVDkBBwMi9biiRosJk
         q2xvmFBmZl2NDKJadCcOQDieKsXZoXWVI8cWHY/6dfIQ+v2vvuh8+uB6Bcq+5/1mOOuU
         CZSblAdOivqV3vJhjsW4PyPC7L/uGEQOAk3751LqcXYmqBuDrHRaMS3+SMbT/rFhgzns
         hz0E90180TK/0qdQ0bALKaYGjdonDZHy9MGsk6llQuHXW2fMYb+Lw/zXbuHXjhSwFCE2
         fkM2GMaYiHResIKu8iV6jGdbNL7wDVd1DvQ2ictCDLqFM0ozcC7Wmf26SmlrilGCGDg7
         zjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122141; x=1755726941;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/92sLgVIXJ/37jnko37eHBxZTjkYG5hjktUyq6kVHPM=;
        b=PShzJCsNidf/j86IU/4jaNVBdNkRzjhDSMc4nCIOifCJBwzYmxKsCjwzug5208hq2K
         pAjUWkJrODv1pbwPi69xprMTyp7j2Xb92KiW0YZ6IwVS3nV2ZeUOm6RgSCDpz/XSWNSW
         CxVXqWFYjHJTZTy3myc6pCRUrkb9uxW/aQtOpX77VBgSW+wkmtZpQiKUyOsgjIfvPuSi
         U6WqCmXaIhRN0XlkpLJoKrTdD7ETv78aCzmIs8VUidi4D63HAZmxv08byxLqzSRAZ0AO
         87XC0387dGj3ZzGBEpNOqj63H9IMyZTZfS9dzQU2tzVk0W+ff65NjY4q2DE/4B/IwBAv
         HvnA==
X-Forwarded-Encrypted: i=1; AJvYcCXXHK3+1kWYGBMjjULRnRiXul7aEyF80KQUWc+ZH9FB0bCLUQAt8it/5greZwoS/vJYVnUgt2fJLam//aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbGTCbVLJmkbYw+KcSFFA0Oa3JQQmKxXBo5ydEYLPMzFgQdcW
	KMYa+1y7MoCbhuFc46Miol0miK+6tDRU/NxGTMAQ3KRRdkfFcz6DdKiTxuYGPuInLqA=
X-Gm-Gg: ASbGncve5I/OLxV64fW22GpH4oa59qpXt+VwFUdtJm49ri836+8Nd3b5RKW8mgG7Pgj
	YA0opeYNLQuOHHqK09TV7cuJCZnufRvU2m5+bx7WjHalQCOpU2nbvZ3XiB2ticKYFM1I0ZiMGZN
	Cv1VpHcAgK7l7GSgYwtxbLzA94kUO1Kf7VJnBqwt5u+Q0WTQCLsmYp/qnK1Get3uY13lxHaxeDi
	oVkiAkFDOgyqZdmrZ10Lc4euzwHfBD8ivX786XXbvR2LxxnftOeiSAtphHOq2v4vPTbqZZAWie0
	clhczx1YPth+4Y76z7FhtphAj7+THnhqSe2qCjpm6ftN91UbxG4eT4lXWI6M8mjFhT3EnEbd1G/
	o+zYlZcWFl/9xCZo16lG9i4NEqTm3cVeDPdUgJSU+Q76xNHQBABXMjUKwgijBDs35
X-Google-Smtp-Source: AGHT+IFU2fJlqPaZk2tNh5JZyckG4stm58L/0bzHkpCtPgZ487c0DjhTgrCu3hLQ1dHm8Hr3LQbJbg==
X-Received: by 2002:a05:600c:b95:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-45a1b79dc1emr2066465e9.7.1755122140883;
        Wed, 13 Aug 2025 14:55:40 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm51390976f8f.9.2025.08.13.14.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:55:40 -0700 (PDT)
Message-ID: <aebbc0f0-ca65-4c3b-9a32-86996a132507@linaro.org>
Date: Wed, 13 Aug 2025 22:55:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] media: iris: Allow substate transition to load
 resources during output streaming
To: Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>,
 Vedang Nagar <quic_vnagar@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Renjiang Han <quic_renjiang@quicinc.com>,
 Wangao Wang <quic_wangaow@quicinc.com>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-5-c725ff673078@quicinc.com>
 <24714b00-cc15-4c9b-b0d4-8c76d702fcc2@nxsw.ie>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <24714b00-cc15-4c9b-b0d4-8c76d702fcc2@nxsw.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 22:51, Bryan O'Donoghue wrote:
>> Fixes: 547f7b8c5090 ("media: iris: add check to allow sub states transitions")
> If a restriction has been removed, has that restriction been marked as a
> Fixes: ?

Yes it has, never mind my proton mail filters are misdirecting patches...

---
bod

