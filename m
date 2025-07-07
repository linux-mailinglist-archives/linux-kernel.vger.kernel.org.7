Return-Path: <linux-kernel+bounces-720570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153DEAFBD95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699A34A4B74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FE288511;
	Mon,  7 Jul 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuhSX/Rm"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C92877E3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924172; cv=none; b=jWb46lRjMo2gANmY4IRRedOz4ze2doynkVRxyBx83MRlUw87i7mgJb24Ur+JRj+AvnNyUaIIZJSHtCw1S6KBhonsC25AlT4dnZWkJnwJsy1ungeHF+YFZpnCUuUKuWwO70wg+s6gSCC1aq7nCNuvbqM8U648WDxsTh/S52nZJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924172; c=relaxed/simple;
	bh=FoE1yw4PinF8aLsqwiVP49aNTfhL5YfYRDuew1h9slM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqZL2U2Ql2N1CcfSFgSTiYErwYXWdXxrJIRo/+vOkOLxGAAa443fvN/7hZHrMNsNJVRAUTfDGqLxm7BK/mDd+q3cVqfq6VZut8spSgVpFORsjn5VWOWNG0ozZmpH5un+UGH+iE5VNmlRJ/2C8ZTJTGRlAus9SB/J03/rkrB1atQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuhSX/Rm; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86d00ae076dso153839339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751924169; x=1752528969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=ZuhSX/RmBiY/WSTlomwxELJK18RRt8o2YaBsq19C+h/8M7Zlqcm88ZN0Z1pWZkUEYq
         x36BN9F9Uqnj0NJTqeXjifoLpCdcuX3wNcM5sEIn3rP+xv2DvJL+0WsfJDD5+pVM191V
         apGnv0fE5VlNtfme18Nc7ZCRU26+jGOppG8CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924169; x=1752528969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y+/uCDo8Ap/hlxb/YHfGaplN840tpeb83kN5x/Y9MM=;
        b=fKeLlvaqIqzglMBIxK9qSN9H81y1xJr2gxN0mWD8MVta5dmNSPjTIC3JHMKktm0WLG
         jTtd+d2GOWxJBshbPOMRah9ZOJZcS9ImhN61q2A6SDMaaWGAjGWWBP+ttcnqqD/Urj3S
         /k1vukglXEQSEY+PoeMHmzpHJESdA5AkwXQArIZzM83P21noUKdPhVnqmlS74/8a6ldq
         rX7EGzGkAn+CYi5IVJtR3OAbUA/SdVmau6ayCk1iBCV8Ad+PrwxLVRw3orzlL8UjmO5w
         iRtQ9QsEu/PyTufLP0iz5uE0FqHvsjmtQGawAF3Z0QuZbXCmS/LnWiGkCo6myECPaD1q
         6yDA==
X-Forwarded-Encrypted: i=1; AJvYcCWVa/qIOxRw3fBHVuoySX5lDG6ABftWLKpQcHRjEfo6+hOwitNRMTdyP2zQek6jmchzS+idCNQ7pY+4v8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFEH87b+G69VOxcwN2tbcnexgxLn/+tZmQQ84+DnyqsF9SIg7
	XKioFHNw8i96VfcAFqoP9EUoRwmcOrQQaLKvtN8kEEeBARTCaL9O6BltwAFHkDOO/ck=
X-Gm-Gg: ASbGncsfIgkrHTLFIZtyfL7RhRpndRss4kKr7l+Id4EAk5cnvHLnnYTCW4N4zZb9KfZ
	vBGiMfDoMnZQdszYkSZ4jVbkNJ7XYFwABgMItHzMUZn2pBJUEzqxavRFpCFyPQDynpB0fhntQR9
	ER8AmPl7uK2ugEIhcfpIkOgf/XhBEhBVlj3oYuWo060IhzC9t8jpVDehzdsnwpiOvuW705eRzs+
	h+k1NMFHvJ4nCKH93XZlm06+C/b3mC5DdywO85aAKYj2AhcVm53TYBTXDZm26gwIcJbEhdGye8A
	pJLVtnt61d38yCCP7SmevAUvC96Y+rmVdolZxDMiCBM8cQY+KbUIOstO8PIhAK0g7xxcKSTWTYc
	6xGDbrAMy
X-Google-Smtp-Source: AGHT+IF53byRaWgnL2/6PRGJxd7DTJKFA1T8Wjv6k5cGUjcY6U6GoMsR0lJgobtuehyYtbBQa4iQiA==
X-Received: by 2002:a05:6e02:522:b0:3e1:433e:2605 with SMTP id e9e14a558f8ab-3e154e63815mr2132085ab.9.1751924168902;
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c6d77sm1911718173.32.2025.07.07.14.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 14:36:08 -0700 (PDT)
Message-ID: <57f72a27-10b0-49d4-8bd3-39b35f422a95@linuxfoundation.org>
Date: Mon, 7 Jul 2025 15:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing glob
 filter
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
 <175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
 <20250703103039.3559a7e1@batman.local.home>
 <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 00:04, Masami Hiramatsu (Google) wrote:
> Shuah,
> 
> Can you take this patch (fix) to your tree since this is
> a fix for the selftest?
> 
> Thank you,
> 
> On Thu, 3 Jul 2025 10:30:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Thu,  3 Jul 2025 13:26:43 +0900
>> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>>
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Since commit c5b6ababd21a ("locking/mutex: implement
>>> mutex_trylock_nested") makes mutex_trylock() as an inlined
>>> function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
>>> mutex_trylock() for testing the glob filter of ftrace.
>>>
>>> Use mutex_unlock instead.
>>>
>>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> -- Steve
> 
> 

Applied to linux-kselftest next

thanks,
-- Shuah

