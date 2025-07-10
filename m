Return-Path: <linux-kernel+bounces-726433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0EB00D14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40FA189B872
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DF3074A4;
	Thu, 10 Jul 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4VXMUj0"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD8306DBB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179143; cv=none; b=tfnpz3c7T2emQ9XQw2ZzF9MLPmV+NjjPKnnf/FqzIimzJQz6ktSv1Y9aWULQzlw5KtEH0pXfP2ddS8ESmAjwU2rGNsAy0FDOfXBR3J5lK0lkQ8uvmrvgqxpZgJbzogjUpvdL6HxWcqXrkqiZtaNML/vEyDb1V2OEE65x+IYZpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179143; c=relaxed/simple;
	bh=dpAvXXm8l9op444PryNU84jOrFviRRWTvceQmBQJj7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHdvMVObzMP/DXWK/wXGTnD6wAG8vi1qCBm4VWsMP4xJZ8zeFJLaOQeFreRzu1jemmxjdd/00GBKosEfHJJaC5+mxRcUt8/kr1HqpJSZ8Fxg7XvAHFWExacRZzP97GZxljFFKjG0eG2Qy9RkZ0mg6qr9iYKyCXREhd8tSQqmi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4VXMUj0; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-875f57e0cb9so114092539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752179140; x=1752783940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOW545cnbFCjCw58sZPhZTZK+ICYR+NAj71Tm0cVR1c=;
        b=I4VXMUj0R8NIbRQnVuwJWK8PrblaXKN9R9z4QUznOgnc9i+bwH6CMwDUdwG7IbHyEA
         ypo2N4NNJnoAupyWhU8JGZqXBbteLu5tvU1oP4fi8mBvnzOThtn40JV7RhWPmF58mRuo
         /0RDmIlkII/7J3DqCyMR36zkYIy6jWIjs8gWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179140; x=1752783940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOW545cnbFCjCw58sZPhZTZK+ICYR+NAj71Tm0cVR1c=;
        b=tldqvH6Ao/goKQMXJoxO0vyA4v9/mtU5OU8KEU0yqIgqs1Cdsx9/wVOMMffY4vfU7X
         fPNzrQoYWV23TMCEnG4HU5y4KpkZZPYF0UfonZMNFdPkv0l/XpCWeoEucm8Lsgs6fJ4v
         PABrYgKlZx4xb4OXcRg271xE7NRUbrXO28qQDK3Wh1Qvf5Sxts/jjbFzhC3/LzEL6vWt
         gY15MTfbJwavzDMOGQmjcZxKq1BOlXzyQcP1OZy/Ou68FHIOZhyjTLw2KcaqjfOBatJv
         eXjtKfJpKWdR5qa2bBv1pHshbU0OSNy/RVgMPUObAWQV1YXey7+pkySLpDm0m+2Byenj
         sZiw==
X-Forwarded-Encrypted: i=1; AJvYcCUsArO/lnBoCuXiU+QfZSqZZ2nClU/LYgPeMuDWoHMs1MkuKxX/eZFnhD6Qhwp7cRiZF/N8p3bIaL0Cqe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUtU5n1UEhBsq6fTE71suExqMKcOmZptB9oDPH+5C90pMmGSi
	gajJGKClcBmj/WXjXTQEFchVhfVrSMMnfLJnpRG4631QxuwljH10HaahVDP2t6KJiFY=
X-Gm-Gg: ASbGncvYjUuqWyT92g/LYaAKSEBG35eeXtLa6Kh0U43Ae+ROPYXZieIiK9xB3WAj1YW
	b2zflH6CZgU1MRRuvVDr48c/KWEHAyHoKmk53bq2HTa8tLh0Lm0t8wPnYgewPhRNl4LryFjr8/Y
	6vKEajPnTN/+nODbh/HH0IcGHRf4zwNbRsGInRqOOPWNHi+S21K17QA9Zals1c8gqD7/VH1MH1p
	iMbaWtyIfKchtm8ZZiM1poiJNYdmE0xIAb8/qiCXmMFRlQrwsAq/p94C9c4SDGTluJArPoMgaFO
	mUldgO8o/WTHWyfTPg2wOxzyT06EYkiB78Z0w2iIXGvKvmu0VChxSbi7I1T5JtiCK+ii3Jirtg=
	=
X-Google-Smtp-Source: AGHT+IHzlWsf/jsE9z63MA8RnwflOpfP+qTaGsCEOAMrn0ovuDzhRAv3fYk2H2SczvZO524QmmMh8g==
X-Received: by 2002:a05:6e02:3420:b0:3df:3b77:1ed8 with SMTP id e9e14a558f8ab-3e25329bb7dmr10180025ab.7.1752179139748;
        Thu, 10 Jul 2025 13:25:39 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2462422bfsm7371645ab.60.2025.07.10.13.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 13:25:39 -0700 (PDT)
Message-ID: <78cd5960-ea18-4e18-9f13-fb3c513014f2@linuxfoundation.org>
Date: Thu, 10 Jul 2025 14:25:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: breakpoints: use suspend_stats to reliably
 check suspend success
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>, shuah@kernel.org
Cc: yifei.l.liu@oracle.com, zhujun2@cmss.chinamobile.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 13:16, Moon Hee Lee wrote:
> The step_after_suspend_test verifies that the system successfully
> suspended and resumed by setting a timerfd and checking whether the
> timer fully expired. However, this method is unreliable due to timing
> races.
> 
> In practice, the system may take time to enter suspend, during which the
> timer may expire just before or during the transition. As a result,
> the remaining time after resume may show non-zero nanoseconds, even if
> suspend/resume completed successfully. This leads to false test failures.
> 
> Replace the timer-based check with a read from
> /sys/power/suspend_stats/success. This counter is incremented only
> after a full suspend/resume cycle, providing a reliable and race-free
> indicator.
> 
> Also remove the unused file descriptor for /sys/power/state, which
> remained after switching to a system() call to trigger suspend [1].
> 
> [1] https://lore.kernel.org/all/20240930224025.2858767-1-yifei.l.liu@oracle.com/
> 
> Fixes: c66be905cda2 ("selftests: breakpoints: use remaining time to check if suspend succeed")
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---

Applied to linux-kselftest next branch for Linux 6.17-rc1

thanks,
-- Shuah

