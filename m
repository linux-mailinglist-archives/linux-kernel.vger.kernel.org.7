Return-Path: <linux-kernel+bounces-745764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31AFB11E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487907B630B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068E24503C;
	Fri, 25 Jul 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NQT9MmNx"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D322AE5D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445445; cv=none; b=bAD1mGGrXBSznB+UA9MqAmfIIjRueeBrq4bUbiaubM9uLAUaZUSsKW3tN3Q/dmJTUKJamgrzwGD0UKC6Y1ZeQmUoEPsbyftlPO63gnWPQINiRurIRZXYORw47qnzcYQtlZapbkkKHEaPFHzP3OibAvpz4dzMmCLw/bPBf03oYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445445; c=relaxed/simple;
	bh=mR1HZMubzuDo88qoDWRxX2DiK7pQX51amaHggzE4Up8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKCANMe59w3sPqboZdDKcn1QnXJNid5lUhFDULzUGYtvNdOBjXJZp4qv0yVJrLpLdZNuD5e9N9d5yqtvTYgiBx3KaUDCQnH06EDkDErLcC82I3eqMRuZPhX2edb0ZmWEtHm3rITs/rZtYDoyvX7gLGTJAuNkE0NdSfl6BiUdru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NQT9MmNx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34c068faf8so2040139a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753445442; x=1754050242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BB2oK4kVlFMA8R70kPOxJrlj1emQHcqQrUadj6so5I=;
        b=NQT9MmNxZOh1fzaKu+kGG7jvbsJUqIDqcjBLcGxKVl0ectlkqP2U4MMEgdQeHVBhf2
         Q+WBexLUgMHbUwzlpLImRAyGcWSajzXVNes48Oil40Cy19AUw9uky5S8F8hOIBuXGZTz
         05lW/XnesurxlCkgur0l6LB2dlHyrT7sGXTETuL2BCRnlYu3suByB/wpIj3WJmGI4usA
         thF+2zc2Erg8S6+DL0BvpevqIh9iug6TReWjQa+ZPDo4rRGoyz39mDsWRcWoIpM/Pddr
         Y8WRd6xOMLRgp/O9pzxg+BSFYRzouZOrQKwhFe4t+11DJwaufj8FBWl5j5f0JkWlz02g
         X9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445442; x=1754050242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BB2oK4kVlFMA8R70kPOxJrlj1emQHcqQrUadj6so5I=;
        b=AiKwI8RASLd5GJqXroRTNgQwmE4lAtvTKUaouwAiQScUiRS5OZvwCsn9vjyET8kMfR
         eutRZU/dTpPURMlXweGnbI8w6D0mNuEXe2j7exBb1QoXKcttmBnLi04BzcStR98bCzTD
         wPxAKSBKnaMC9OKUx+oDu41i7+Ntl/rqkRYmDI6ncDQHdjIoWF4pSy7EDsS9L0HDxemx
         rR0Aqfihwx5eU89OTy3aUL0OF6B5eJ5txW5GfuoW5rfcY3HL+1u0fQPHepztJFtrjJpS
         6f9ac8XBo73zUjpsm14kBLJvBfhYQazHaZIsJR3ZvSH7CX2HSVOLSAPG5wc7AskD6aRx
         nNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhJbj0wkDov8OS+BG0+58RskwZdk7D+gicTlMsllmQxQs+SigoI6QBMblHyYxKcy2NdaZAY20ZpyUmBZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rplxYch7ruvUjynRDZU1xsprWyKA8AEEBMD49DGs5k+ahIZ0
	ENBPzA0iN4v4mIQO7AFJGrnwcWd/1B9j2fD1fXQ+y6nO4N3yOK0ZJRkb4ZE1qLWiMDg=
X-Gm-Gg: ASbGncuSdMc+pa6zpDmSk74mAXkSEw9JTbmwBUCRklKhaPZog+ep4rIb3i1AeE9/K5n
	CKmRVDCK2Vyfz0F3q8ipTHV5zQAECH5yK+qQUcdJIyXFFswTsjb1tejEMr68yfR9uC/+Tv2KOhH
	cjxPfv7pZJoHZ4khMjzOjvd5JMBeaNjMoJvF0iZra+R3iOrcceFIqGLEsDWPawGwLsAdwpk8siv
	+SYu41tgd3Wq2Z2rYhTqe8T9kRyAay2ABME5bnnjs/g1qQM8+++jen4vPaIxxlJslGErE0LRsha
	/n+LdF8Q5CA8dhkug/SY2pKsZemoNAXFdLi7rXtxkjDNVw2oDPLI0pJNeTdMZObKMWwtrM/R80z
	NLq0XXV3CJ2I7F1PmJw8=
X-Google-Smtp-Source: AGHT+IFevLnjs8vNfTzc8Bky8ffMZ/QArwnsNrHPcQoA35FdKYhdd/g0uxmZ5R0tMqrKafUOSc9h3A==
X-Received: by 2002:a17:90b:33d0:b0:313:d6ce:6c6e with SMTP id 98e67ed59e1d1-31e77858116mr2556706a91.8.1753445442209;
        Fri, 25 Jul 2025 05:10:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09bd9fsm3299292a12.26.2025.07.25.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:10:41 -0700 (PDT)
Message-ID: <67bfc411-d944-4d1a-94e5-610122ac6976@kernel.dk>
Date: Fri, 25 Jul 2025 06:10:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix typo 'prefered' -> 'preferred'
To: =?UTF-8?Q?Ignacio_Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725040939.73175-1-ignacio.pena87@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250725040939.73175-1-ignacio.pena87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/24/25 10:09 PM, Ignacio Peña wrote:
> Fix spelling mistake.
> 
> No functional change.

I don't take just spelling patches, it just causes pain in terms
of backports.

-- 
Jens Axboe


