Return-Path: <linux-kernel+bounces-730160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DCB040D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52541884257
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C9125485F;
	Mon, 14 Jul 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xItvqeOQ"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF112222A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501623; cv=none; b=gCD6ZV40FuajbcH07lkF/56SS+p/I/bKoLcSkEYaUGi04Gi+pjS8tOTbycrV5uozG7fr9SiSj/TLNKkYELlCXE8lCouXJhfNm3mOrYU5Ys9kO1T0JnzpQFdWw3Ny5ets922l9ztUyVZvsN2i45EPvYju5E4kXZYDr/y+J6HFl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501623; c=relaxed/simple;
	bh=Q7wko7/wUh2H3S5qcStyrWfJDnuYYGnuowbqH9GBFCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3YrHi03Tf5ZXjgJ+WdlKOhFYDI0Q9uwn4Sb3LZnNXnD8TYcMz4Bepjol4ynuFXsGCuFZ0ZVFgpKgrd+ICdCXO9lFa+d1HVmMAYoQVMRTAk8vPdBmclDRneWKP3+OCrZFF9DOgEKe2zgo2nMq1d4TIxIZYtv1sM5QuB+IN7Sknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xItvqeOQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso27705935ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752501620; x=1753106420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEDN5ceIXoDkHoOeV+Ed848IKBn1ofuiV0LfaO0DA7o=;
        b=xItvqeOQJf+kIThBcA7IbckFWeCkihXA05n3GIDuX+JVdDV8A/67x90CnuY8DJ3eZo
         MgjWlEz/PZHOmvNZXnkkcFLe2a20OwNxg8fFEXrgpzQnaA6r6sbyET0M4zLGuXL5XTRF
         DOJsdPQSbc68N66fOrsvDPWFw1Pea2Q43anJQm8EYPTA9ctV/hIOX6DdGwXOE/8lHtJZ
         fDdFqSp/L0OTgMQunD+kuuMyHoSVd8K5S6vh4qpd5omVjimaHgbkyVF+jKuslAYr5CXN
         ZnEYqRZGWKFK6qhL57GD3sfQ0d1q/d7293XyHqkE8NkWucDmAYxS2APMpm8O9miD+QIx
         aAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501620; x=1753106420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEDN5ceIXoDkHoOeV+Ed848IKBn1ofuiV0LfaO0DA7o=;
        b=Tr0u3j+RZRzGasq1nD0iBIxtptPG2Q7I8kRgiIqWTdBVVCnuNBollknOIwJ6r3WY99
         HsErP8t9QgWwdM/Pb9sSLM3QbapYy5alGejsJLwKVDoIoTXqw/83na4IoxDZY5LdZHno
         L1XwE19uZhs39PfqC7RJCX7f3xxU9UyosdacRB0f4u5LWAEO6osCmcm9qcoj415D5eWC
         1lkMAdedjQyo0ojhlCkVNEr2EDkHvD92GY+/HaZ60ZU5ah8NGvnXb9H/Ld4xFr8nBe7c
         TF6j+jdyzcurLYnloyfJl581lzxvDz6cRu6ANOHQODYN1RJaT91Cu4TtsbKeA+defybm
         MHQw==
X-Forwarded-Encrypted: i=1; AJvYcCVNrcQQLMIogwVwZAldoZmiIohr03Vp7fK21v762Xco1wymWMD53XvAeA7UPEDar9kZ/+zLCJ95HPOyGlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8D2NuNi5VlO2TAREpSqDLNVdctRwLDesenI70kunMVzOrav23
	eBL0OwVukVYjpXrt9vlPbx2DyzXgxiHHQi94b4+nl3gD+jsI982YEsBHPZtiBH9HJDw=
X-Gm-Gg: ASbGncs3Ce92AQ13utijvb36iNE2g9pae0Mb/Jc6NYj/10ITL3NPeh27zI/J1yUkPZY
	SFv42X21D5iVXl9/k+aMZy15gbPHZxKiRYhvXQ+bpyzSFSf6ePRKgJDQ5oMwBBKAyTdvcVxean9
	GprecgS+0EHzI8Zap7mbupMMfuEOH5BFux47crWyVzuQIFL7A/4Q5SFCJgSAPpyypxz1OoSYGs0
	AOuovZ4VxbQZJJz0eZK7Se/wc+R/MpoZdUhVxrTR2YacVKdaW7nFss42Wtv7LKT4gY1h4dVgF7v
	3t8qEZZHKenN2T6ZyxhdCwqbwS0XDTtVCZrsQiht/FIHVOWLPMPKpx3RvEkUlf/OPqTTdLPUjcK
	xFoB0kOOJ51xW1pw43Ws=
X-Google-Smtp-Source: AGHT+IH+QmTwJHy/hmLCFp17WJEN7d08zkwID1qqZ5aqE2Hh/uewiX5O0llmnaALKYkrnI653xS9TQ==
X-Received: by 2002:a05:6e02:3f13:b0:3d9:65b6:d4db with SMTP id e9e14a558f8ab-3e2542f9baamr159539255ab.12.1752501619621;
        Mon, 14 Jul 2025 07:00:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5055994a689sm2010304173.143.2025.07.14.07.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:00:18 -0700 (PDT)
Message-ID: <0be7407a-3fd8-4456-a4f1-4b5ab99ea5ba@kernel.dk>
Date: Mon, 14 Jul 2025 08:00:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL liburing] Add musl build-test for GitHub Action Bot
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: io-uring Mailing List <io-uring@vger.kernel.org>,
 GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Khem Raj <raj.khem@gmail.com>,
 Christian Mazakas <christian.mazakas@gmail.com>,
 Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
References: <20250714042439.3155247-1-ammarfaizi2@gnuweeb.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250714042439.3155247-1-ammarfaizi2@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 10:24 PM, Ammar Faizi wrote:
> Hi Jens,
> 
> Please pull this musl build-test for GitHub action.
> 
> Several build issues have been reported by musl libc users when
> compiling liburing. These are not isolated incidents, common
> problems include:

[snip]

Thanks, this is great! Because it is one of those things that keeps
biting us in the butt. Pulled.

-- 
Jens Axboe

