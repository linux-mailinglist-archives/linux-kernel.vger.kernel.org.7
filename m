Return-Path: <linux-kernel+bounces-744779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E0B110C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E623A3B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382092ECD33;
	Thu, 24 Jul 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DBsE4oTm"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F225E471
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381297; cv=none; b=jwFHS+gQIC9S4Rx/g1vjgPkUQvjz+znnnqNSD7zdbNXFC84fTJb5iMeYGpErBrZ4T3NSbY8/vUNJuft0gehQqRFka5/pXyFGvqrj1NaDen/MJeyDMk7tI3WIHoaAzX5Ysh+AGGP+t8b1TAtuM2rhqGPu3fVvJW0qsVKJDkZ8cKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381297; c=relaxed/simple;
	bh=LFto+7nmVk/9DNgIsdyBeYPDr2MTNvHNhGUL1ft9WHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqaXHilCMHCBE4HXkDPVC3SnBzFOga92fve5bDjSNzD82Qc66ciEymSjZGc3A/w4YSFdUbbQBvJuh3FLjVGtwkI+sHHG5Su75q554jQxIel9MIeREkoAN5M9CxE/J09iWTM6uCVmAPnnhby3KcPca2Zc0QGWnGHI+Nxfq45mRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DBsE4oTm; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c04c907eeso107221639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753381295; x=1753986095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdPQZf7gEv0BC5TALPGgtfN6EoB9E9z3HERM82woW60=;
        b=DBsE4oTmYW639KR5DoypMBSXFHXkAv8BFL5S9JH7m/9xa7sPXXWRAs5XyMjatZmY51
         Hw5pQDyZNJVH+QpJSOZdJBhwYfuZISSz0YeenqWiIXyl8mCgI7eWSuZC03cH2HftkWMq
         qX3WDQ9Kqq8pMLGQqbFfq/TlQ0fxSSjZv76H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753381295; x=1753986095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdPQZf7gEv0BC5TALPGgtfN6EoB9E9z3HERM82woW60=;
        b=jXND9zL1PfNEMNR4CekAgpkGex0t8C1VBNiAs0Gu/+crwN5qG/p8es8/Ga0N/e4Koz
         4CyoyKx9HtVU0F0XLc5zcP0wcL97G3reRfq04/eI8E5DA2UIZ3cL+5SljqUp4NDwK0qo
         sZ+Dn/V4l3F+Rw1PcX5qV5NbSv9uGd4J5milanlq8M6eDCayBTwV9WMHiiU6TREP/xDS
         9KqC355Qe8ymVbvYhaZ/1/aV3V19zZ1mttLPzHKNwBj74HiWF+Yk0i7RL1ueDLmM9HmB
         5wzt4KkxlNrhCkXPcUf/aR4xEw0HvQUbaVlCRWI9xC8TPrRLwV6dvWx1Z+doYYSXdsfG
         hBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6wrJEEYfmTV13GclHzXRnui7VQAWnYt7BjLpqMUhA7m2gCKyPDxgZalExKm6L2yueLuRjv9pBU73LXjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXc/1HWdSyBRHixPfLK/bkZ8wDNjvG96NDWoxSo7RS8uXmJ0Z
	w+eWwSomwTFQHUs/Ve/TZFGJ38ki4PbvIbWc677NIPavDskiQwWNHezC97iIuyT4pcE=
X-Gm-Gg: ASbGnct3spdBn+1YI+4syGKQZ9pE6GZqFitxBOmrNfjLqdaDmAC/tPqJv/SHwIw4XYV
	o9/2eKX5/Uq7abM8JkfPZ6fuAIUFO6XZoXYmes5HTWrtO8zjTvowqQrlr/PYrrv6n0xSm3BSykn
	Z3xDvTHWGXF7WhSzqmvTM0NDlYxgcrrvITiJWx9orO2mZtA1eEz3lyfef6xdD+qzEZ+wvqNIWeN
	KxESNGs+GEKBdtvn2snC3NMt1GfhUbmqSegvsv1JEmD2p2nv0vviG2cMNLYB71f1FLtyx81pBpp
	iSjrH1WerJR/79BLWQ9AUj54rmNRN7zMc9kfCEpHStBtgGPa1JTqKz2gkFW9qfCX8llvvZA87CB
	Zsx39/NEzfY0GTXGJKkHBhBPhndyUy+WwkyfCDyTbiDps
X-Google-Smtp-Source: AGHT+IFhsUlGWWXmuUUxipbvDO2LKjfiJ3JY/g3kNX0QvZGP9clzEw28V4lNKY7x0ex7gVSefyCIaA==
X-Received: by 2002:a05:6e02:3b83:b0:3df:29c5:2976 with SMTP id e9e14a558f8ab-3e3355601a3mr130529145ab.14.1753381294729;
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508ae900b01sm563729173.0.2025.07.24.11.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:21:34 -0700 (PDT)
Message-ID: <54b648f7-2756-4db2-a6c0-7869b7ae37d1@linuxfoundation.org>
Date: Thu, 24 Jul 2025 12:21:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cpupower: Allow control of boost feature on non-x86
 based systems with boost support.
To: "John B. Wyatt IV" <jwyatt@redhat.com>,
 "Shinji Nomoto (Fujitsu)" <fj5851bi@fujitsu.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250522061122.2149188-1-fj5851bi@fujitsu.com>
 <aDhJdTWzDihchywc@thinkpad2024>
 <OS9PR01MB14003E72236096AD987D2D4CED96DA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <0053926a-7b0a-4e49-9acf-fcb1d73134cc@linuxfoundation.org>
 <aFWZyPs4eBwGcKPu@thinkpad2024>
 <OS9PR01MB1400335E9E14CF505B8AD26DED95CA@OS9PR01MB14003.jpnprd01.prod.outlook.com>
 <aH_RecWNuC_UqUlx@thinkpad2024>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aH_RecWNuC_UqUlx@thinkpad2024>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 11:59, John B. Wyatt IV wrote:
> On Tue, Jul 22, 2025 at 07:30:27AM +0000, Shinji Nomoto (Fujitsu) wrote:
>> Hi, John and Shuah
>>
>> Regarding the subject, I submitted patches to cpupower, but so far I haven't received confirmation that the content has been approved, nor does it appear to have been merged into the shuah/linux.git master branch.
>> Could you please inform me about the current status of the patches?
>>
>> Thank you for your time and consideration.
> 
> I do not see any issues with the answer Shinji gave on testing.
> 
> I am fine with it being merged.
> 

Thank you. I thought I pulled these in for Linux 6.17-rc1.
It appears I didn't. I applied these now to my cpupower
branch.

These will be in my next pr to Rafael which will be after
rc1 comes out.

thanks,
-- Shuah

