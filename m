Return-Path: <linux-kernel+bounces-895819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF065C4F03A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035444E3780
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1FF36C5AA;
	Tue, 11 Nov 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL/G8kH8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD302F7464
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878183; cv=none; b=Yvc3iUTxHjJBQA5U9khv+JZ/DbegYNp53YjwiAMsr5SWLuhLn8pVzS2RX0Dk+accx4cIX6y/ix5sfkHHXUh49VbqBd4BN82XGrgv6FjbLtJK80KLaPlBJNg8CHGp2Go1JCM6/oRhrMYJPfbAMY8MNlxwbG5dZYUb5PoN6NvuGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878183; c=relaxed/simple;
	bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kqqw9rGsTYl7A3GtpGwdGeiVYgiZceCA9W84aY07IgdkWnFyUri1Arpk1J8B46T5MpvjcEHPNM6sWZghNGK4uS/MBXelBpwlWDVwdhS5veV1Ik4qE6zIUGIZpc62XiFqmlZSsfkTsNfhB0esHwT2bj2fNEyoLMiZhMu6j27rXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL/G8kH8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29555b384acso40532795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762878181; x=1763482981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=iL/G8kH81/IVaSdfe7lXOFWjh9H4zjgAEAoxS76cOnW6kGhhpZqTUbkxRjmxoO2kRQ
         iNu6hnMTSPicDUPPK9/LM8OG+IovhjVYHfJA7zi+7czQUeL5sPEug4sw+iJ686cNXNCJ
         SOqYcm7Zbfl8jeY0pye58C9ojZf9Tn4OaxwWFpI1jCArPuvs60534LRLL9suYx2w+el6
         UYNuIrPiWVKLXO7/oAjtPgVPgOWLRT6wdOJWf5rjJpXBh+rLHQ53J6/kbnoqcTOsVgrr
         SgiCGejzYNEyR40HeQHOem++GcRtbbCxJUEM5GwnBhKP6ngCh59/jA/b8qJCtTDBDFe8
         eXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878181; x=1763482981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0ljOlhWjxilin5kH+KEY/abTrp4fy30VKx1w09jdUY=;
        b=bqzQXEIvXVNG5ndgUdiqSeJwR1kfjqmHE0+pqZXntUpDM60YxXuqOYbnjObvLoEV9k
         q2vkuIu/Ba5DrDBsW6Fl/IqzwSRUL3NKvcanAMxRu6qIymZTOWYvYEQF8yXQgfm0wYSY
         BojGfyYCR8BLqZeWwzNIms7SlosjfukeJayyNrrBtaINvyQukwoZcp5vOmfXMBJEuWT5
         PJ1nwhSq+QMeaciun/CxQC8Gz3fqdqVONYZZTyjriYDkKT4N3piE3iHasqnhAfV1aqN9
         +KwN9blnl7ZyH4/u6tart0e611z/gq8zd7OayTAe0U0CZank9Emk2I/urboYdnfiH/3n
         qhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFLnJ2fFiRbHZz13Zbt8orb8OMPjUC3vsQvPLYTepzM2KJBBVGW8kCFzxUB7e8CJ6Yj6rALsRuwi/XpLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TiSmxyc/EbvqZnzBEqmzUvlSTf5SW8T8+vWjo3aPgCSZE5q2
	9ocuh9vIDT9mxI82Jj5DI4IkSdoXFqPu7M1SSqvNrFVKDofbXMdTrsEj
X-Gm-Gg: ASbGncvmLPjFI4ZBYP+PRqIgfOF4vPhH/iwGsP1vOgN5DN9o/G4ruX7pUbyMoGsp/Tr
	2ns28Ng8QvKWRISsqSZg0cPqoAA+dj+0vcYRs9C1Wku5iFhuMLmZMj6MHs3RBwvWN/PDyafbUEc
	VzP/hrwx+WpBl7rmHJoawhFJ/filj6SXYw7GSIf/pMScGmST5acV8useCgF0nnMAa2a6LzFNDBC
	jKQsiZ2iWgf4H03iw7OtwGj650KnZDq1IWhw1SxCFZR8nwSZwvCXAW5aqvyO/wSUj+aQ1RyFXWC
	Ju4HwHpDXROc75s5TQ3QC/3HKOahN+Nf+uBXqTQhW6dqimS70GREhfSzo0Dn+ppV0pV6J1JFRd4
	D2QVH8rhk/x+l8OkaRA4/gq5tiuKmG3hwvbvyaxxqpfnOUVpHnHGKT9ZeWeL6RfpYC5oyNaF0Mx
	BgByrXNzUT/RdGDpaHFLkigJo=
X-Google-Smtp-Source: AGHT+IEIxU6B/C+/gaE5krPsjCGJbHME9xr/mVp0iRWSOeqny304a0jPzv72fNDwODfJiyMz4oZbcQ==
X-Received: by 2002:a17:903:19cf:b0:297:db6a:a82d with SMTP id d9443c01a7336-297e5668a96mr169381405ad.26.1762878180793;
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Received: from [192.168.1.3] ([223.181.109.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf54e6sm1713765ad.37.2025.11.11.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:23:00 -0800 (PST)
Message-ID: <fc82ba95-2c9c-454b-9d32-8f5639671822@gmail.com>
Date: Tue, 11 Nov 2025 21:52:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fealnx: fixed possible out of band acces to an array
To: Ilya Krutskih <devsec@tpz.ru>, sdl@secdev.space
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251110134423.432612-1-devsec@tpz.ru>
Content-Language: en-US
From: I Viswanath <viswanathiyyappan@gmail.com>
In-Reply-To: <20251110134423.432612-1-devsec@tpz.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/11/25 19:14, Ilya Krutskih wrote:
> fixed possible out of band access to an array
> If the fealnx_init_one() function is called more than MAX_UNITS times
> or card_idx is less than zero

The code already validates against the >= MAX_UNITS case and card_idx
can never be less than zero at those points under normal circumstances, making
this patch unnecessary.

However, card_idx will overflow with enough calls and that is something
that should probably be fixed


