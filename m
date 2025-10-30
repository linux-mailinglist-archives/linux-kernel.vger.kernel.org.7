Return-Path: <linux-kernel+bounces-878561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739AC2100F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB810343D20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7B3644BE;
	Thu, 30 Oct 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3nsJS5H"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C44363B85
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839085; cv=none; b=X2XgcrwX5iBlL0l2qfoJ9uYMqgtqGW5Eqc6LKy0+OcP+xes1Br/BSeFbw/UPxj7mvtu5i/oUKD17qcfwr5DBgJRZy3oySYs09OgxO2GQeFcNormAWQHOEpN5v0lmHw/x+zR08UFakTzkh1fJr0u9y5ABTc8waOQ3m9A0nBt/hM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839085; c=relaxed/simple;
	bh=16WBWc3DnafSrhh4cP6sIl4QPdU1f2YAc+r0Ewazp9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seWnnRxkDPCWIXKChGZDrXf45GZYktJVgdhphGyCr4MoUxMChpqG+t8f/bwBncIgxzUhdCwVXDRuii0eOhNtH9NPERkxSTTmQ6iBR0GwUfQ4fucQRAKKsajVgxibiYWrWwTQA76pLOC03TC3fBPQqnwUv1pcP8ugTDaR2YmHvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F3nsJS5H; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430d4cf258fso4709805ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761839083; x=1762443883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2/g28wpsFW2ZWNmYyXCn4YPpXzzQ9BIJP57zBn6Kuo=;
        b=F3nsJS5H9o5AuSbY3FfrHOJHJXYWI+eIH2gaZWzqileNi5YUPkL+262AgjHluh54j6
         AkMRsywadN8jiRECzrP8RaCQ9OVDQumdaW4uxnHpb6AAKeO8m/Uwe0mjjTcww6t8/5tr
         5Zgzdbo+C7Fg+oIxJxZIR5nanvZ1dYlWaQDDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839083; x=1762443883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2/g28wpsFW2ZWNmYyXCn4YPpXzzQ9BIJP57zBn6Kuo=;
        b=K+3hngNs97rf1YPSXtpz2Dpa0O8X/VVM3zrxhM+Wigk5SQCs/tHZDWpAcFM5EU9eoo
         Scr12JakX2fBtK8bcPQiWrj8UkpAKD85DyCK+2m1KfehLKntt2JADCPsOYvNB94lGhqd
         wjjuBD8fempDec6cKJQ8GTQDl07eRrdZWRDJcZhDVrmXv+6ejTsotIz1UmXQjRFomIQy
         HUB5hik1QrTp/QHPKhdbDqhZQbDNYLR3UOXjyBPEgg5S7mP54O1Gd8r/CLLOY3R+MwxD
         scMKws7XQFrxO+xnYd3GRJJV5RSoZMrQ6wyqJrXXIzrfrdx7dzzMgJ6yRa5BuPb0kqbR
         jXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGplcwy8UuQg6GRlc7rwv7NGvXEH7Jo8VCmW2c/72CtyrywWV/em2M9lU47CC+bxL6JVvruBW/urcrk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9vRs1MyL4UdQ7RQqTHPv2wTmyIMplPmUvDpycL+iPbhAeJPr
	vOfyZKD0H1YivQmePcGCyTmWXt4O96g2ncC9PTJtfvvPDHRxKUbwAEDhEwq7hCTp5v8=
X-Gm-Gg: ASbGnctEKfelVC2GZ8dv5DwJsO738+XHFa9aeSVNpO0Jg05HZsVhjjODZDQ2xTP4vBW
	N6AtIaVuUZXZhECl2GbJsNt1q9c+lCL2VVdHHzzrVBX8kM9+ZuhcRy1nUQPRJLUUx80vOZa60Cp
	1UF39Nmf6exwCLJVMbZJPKdWo6gVv0do05P98T4i2bI4rAkOtUaf/csvnFCn6ITRyp5OhbVyQrV
	qr8ZmHbeWe2y4tsFWBO1yi1fdtZssLZUtOIJC+MFJ9cst/LZN0ZK065pgGQnTTUr60yBePmV001
	Ge1TR3K1bABRU+sdoHqQpCF2f+njPB4XA5df4hAeOZMULBead0I4ugb7Zq85DDVnAoA8FfhdW4V
	hq7xZVBG0nnRhNwmROPlSxtF6LC1izuaAwUhLNawJDQfIjrcubCzt7WxzuMdjzkqAz9Brky1Ykt
	7vdbhii2x69R9U
X-Google-Smtp-Source: AGHT+IFyWHYCYRL73yLOZzMHQqt2IfpiL1br904ZZIKT0bFKGOHms6qkOoR3m6OWHx3934M2Ti1MBg==
X-Received: by 2002:a05:6e02:2147:b0:42e:72ee:4164 with SMTP id e9e14a558f8ab-4330d1f6a3fmr2877745ab.23.1761839082660;
        Thu, 30 Oct 2025 08:44:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e1abesm6772230173.24.2025.10.30.08.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:44:42 -0700 (PDT)
Message-ID: <dceefe7e-4cd3-464d-b5b4-f80c02b4331d@linuxfoundation.org>
Date: Thu, 30 Oct 2025 09:44:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
To: Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Khalid Aziz <khalid@kernel.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jan Kara <jack@suse.cz>,
 Taotao Chen <chentaotao@didiglobal.com>, NeilBrown <neil@brown.name>,
 linux-kernel@vger.kernel.org,
 syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
 <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
 <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 09:12, Jeff Layton wrote:
> On Thu, 2025-10-30 at 15:09 +0100, Jori Koolstra wrote:
>>>
>>> I don't see a licensing issue. It's BSD licensed. Also, this is a
>>> userland code, so we wouldn't need to worry about that too much.
>>>
>>
>> Oh, my bad. I thought Minix (the OS) had some licensing incompatibilities
>> with Linux, and this repo takes code from Minix. But that may be long in
>> the past.
>>
> 
> Minix is BSD licensed too. That's not completely incompatible with the
> GPL, but IANAL.
> 
>>>
>>> You're quite right though that userland replacements will need to meet
>>> some criteria before we can rip out the in-kernel versions. This might
>>> be a good discussion topic for next year's LSF/MM!
>>
>> Would an in-tree but out of kernel implementation be an idea? Like how
>> kselftest is integrated in the code, even though most of that also takes
>> place in userland. That would guarantee a level of support, at least for
>> the time being. I could take the code, verify it, and write some tests
>> for in selftest.
>>
> 
> That's not a bad idea. We already have some userland code in the kernel
> tree (the tools/ directory comes to mind). A directory with replacement
> FUSE drivers for in-kernel filesystems could be a reasonable thing to
> add. Anything we keep in-tree will need to be GPL-compatible though.

Jori, if you want to continue working on userland slotions and working
to initiate deprecating, working - please do.> 
>> And there is still the issue of what we do for the syzbot bugs until a
>> more permanent solution is achieved.
>>
> 
> Yeah, that's a different issue.  Most likely we'll need to fix those in
> the near term. Replacing minix.ko with a FUSE fs will take time
> (years), even once we have a new driver in hand.
Does this mean Jori can work on fixing these while replacing minix.ko
with fuse progresses?

> 
> We'll need to mark the old driver deprecated and then wait a few
> releases before we can rip it out.
Jori could work on patches for deprecating perhaps?

> 
>> Anyway, this probably goes over my head as a clueless beginner. Just
>> trying to see where I can help. Thanks a lot Jeff for you answers, I
>> appreciate it.
>>
> 
> You're welcome. We all start out as beginners!

+1

thanks,
-- Shuah


