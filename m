Return-Path: <linux-kernel+bounces-880680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F0C2652D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFDB6347CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4869305E26;
	Fri, 31 Oct 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IoRNMGQx"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1F3054C8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931297; cv=none; b=PG/Z9ZEHqbnKmz391vwb7RdFFUeZgbGYQNQcTAx9Uk9mCjD0alTReAbQQNw2tt2FzXeQYX4VEjM61lY2n6q4MB3gVCkXzBDswaZz+EAD5XQ55Pn2LHt2NXSzc3wZn1ZobnqSsydb550uLefEV0VLytEwN4W4W2gRfiJMywMS2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931297; c=relaxed/simple;
	bh=9dIYlCqSuay+P18dQ0M4/XCMXtFDI35HoGfcLtJV++I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrEaQDW2Ko4t8wrlzxnqIfUfcU4bVY/XSSBp1qUwrXYSjtR5RtRNfKguFGmTp6DUTNxWVG/tXTRCUs2YiEdlFEoGCkatkaGWyHMwRsAbxdiRPXbJ+M6Q02qNoxhPvm3BQC58fIFJTMdFt9UYlUk+vUaLb77xcIPj3W9mIo43xgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IoRNMGQx; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-65363319bacso1304782eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761931294; x=1762536094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2arCVoySu4BoT6qvWYZ5TCMKdFyAl6i0QIhKt61vYqE=;
        b=IoRNMGQxaJE7gCHO6SpA5/PCegsQmApO7UECLD8M3+Y731+VqrxG4PVu5py4rj5chA
         KVigy7MOCQOGOf3W6bghZB0aYXfYrPwI8X/50Qqzh23070ycIm5D8wu/mtzr0+Wv27zm
         CeT3OdwVHFx3osRQKoMlIHHh6li3gscz/w344=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761931294; x=1762536094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2arCVoySu4BoT6qvWYZ5TCMKdFyAl6i0QIhKt61vYqE=;
        b=sVSmKAgxIllC76h2at5bkHSH3VPC0pSymETLZI8hKDciiG2j8hmysiV01K/sC/pjZz
         9nRxaPvQYXS2pNh829hgy8ttGFkuNCEgVpC/2RYjDff7tQH80clvjI0fJ84QoPUBipDW
         oZWgA7sJi2OFzdOcohQGEqI8JhxyWASk/f4l0c+8tyi3U7EtiD95697Gc6RA3Lasn4Dl
         TDJsj5+L0xb0dGuPuSMxaTfdqP5eBk1TKE3bvJtBb8zW2ejxHlDvuhQgxqajJ1xchGax
         mcck45wFdRTtlWHSAD2HvoqCSa2InMBXSxOECO9a8SayycZL6ACDYBG7JkOX6wl1o9oE
         KetA==
X-Forwarded-Encrypted: i=1; AJvYcCVu+JB6vPeh0twyG9iz0Jlt3zfhXZCkPS5lpMVy4aO36JeMcC6Sd3Fipfcu8/kLj6kvgzQbyxxWMe1WAww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaMbgOWCBR6h6EAci++Ft7/iMjCeA4V9JL+jM7A+0c8gbq3tr
	6Ed4LEBy7DQY1rdmrKoJ/QxNiOnOjst3zxtSYwQ7e86wvhkZxdUe64thHFLZDNRHqkSWN+DTX+l
	aynQo
X-Gm-Gg: ASbGncvzm07x0NsVdxnQjhxf+bWVAs4Gf1H/zRPzuwId8ORuGCIkbhSh9LivW/a3E5a
	Y26oPw8tz0eGR4Xtgfd7mqsyhulujzd/pOTb+xggRSlR7U+PozaylVsktA1E+0MrYVVTc3A+fYA
	gOWU9btq4qx8Sbq6dqCl2Q8u0PcDAR87DSH0DOS28rhsNaI5FqRLgMYUNu+T54DtlrPQtNAW950
	j3nyXLF1dpH8FMpO+YKhat7iNIvjRKXCuTcO7oyCfbwPwXmmMb7YCee7d5TSoPSuL4qwDmtOan0
	+JKQa7IyDXbmVFSd9kUA+1WmJXoTtwTk+St2c9jY6ZpZdL85vap4v3a7BdF3uFa1Ca8597IeoNJ
	YP/wqt4w1Sf3AAtCfoRAp5thP5URzaC/pFgHSizMNQHI5soz4/TkyY2YC5EO4SXEGcloap0VjLS
	QbYG0otXVWcwtZ4X5Ss+bGFbQ=
X-Google-Smtp-Source: AGHT+IFHV5mqBxfVnLGrK24cHPx0N/RAB4xpvKPnhRbNDbS9+AwnDKl1gfiMXkoDBtzu6gX4xQcp0Q==
X-Received: by 2002:a05:6808:2184:b0:441:8f74:e95 with SMTP id 5614622812f47-44f9601fa1dmr1922372b6e.63.1761931294049;
        Fri, 31 Oct 2025 10:21:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44f9d9a4cbfsm500332b6e.24.2025.10.31.10.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 10:21:33 -0700 (PDT)
Message-ID: <3a9185ef-c212-41bc-978b-0dea75a86e7b@linuxfoundation.org>
Date: Fri, 31 Oct 2025 11:21:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: prevent double URB enqueue causing list
 corruption
To: Alan Stern <stern@rowland.harvard.edu>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: vsshingne <vaibhavshingne66@gmail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251031134739.222555-1-vaibhavshingne66@gmail.com>
 <2025103118-smugness-estimator-d5be@gregkh>
 <6c81d455-a4f2-4173-be72-9d77728378c1@rowland.harvard.edu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6c81d455-a4f2-4173-be72-9d77728378c1@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 08:13, Alan Stern wrote:
> On Fri, Oct 31, 2025 at 02:59:07PM +0100, Greg KH wrote:
>> On Fri, Oct 31, 2025 at 07:17:39PM +0530, vsshingne wrote:
>>> Prevents the same URB from being enqueued twice on the same endpoint,
>>> which could lead to list corruption detected by list_debug.c.
>>>
>>> This was observed in syzbot reports where URBs were re-submitted
>>> before completion, triggering 'list_add double add' errors.
>>>
>>> Adding a check to return -EEXIST if the URB is already on a queue
>>> prevents this corruption.
>>
>> This text makes no sense at all, it does not describe what this patch
>> does in any way.  Please do not use AI to generate patches.
> 
> In fact, the patch doesn't do _anything_ (except maybe change some
> whitespace).  And it does not apply to any recent kernel source.
> 

Agree - this patch does nothing. Looks like the patch isn't sent
to right people either.

This person happens to be in the mentorship program - I will make
sure they won't send such patches in the future.

thanks,
-- Shuah

