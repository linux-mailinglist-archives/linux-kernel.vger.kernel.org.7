Return-Path: <linux-kernel+bounces-859288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F351EBED3A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74F6F4EAC97
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853CB2459D1;
	Sat, 18 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msvctw3b"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6B23BCEE
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760804025; cv=none; b=Vt7fUWYXymp3sLaZFtThY5PPJ4+sG3m6/TXZOX1Uium2yXNEgOu+1Hnn6CkrMr67K4zqsO1Lb/c6gmbHlfAbc2RwNU4BoEPhDinIimveZ8Uq0uCdqSelJDA3oXmJ8N4yDWPwyddMg/qTwnPg/+1Wwh+AKmKw5OBbu5yXl9pS5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760804025; c=relaxed/simple;
	bh=pLKk0UA5x9txz2pzbD022hS7+sQLw1lvQiEUDBqTXvA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fteBAJIrugKsPq3IDAqZPN6DPGzeydDRo3bMSAdnAvf82bjLWBj+wj3+MqrMYDK64qQYnAXE4nN+1GPrMrfiMQAwaJ0m8L4d0wFxJ1l41e3NOHUWpBo/DiLD7+N4u3WK1Niu5LujyaQNi8yR6A54Jw6KiqQvdPLfNkNSaqQB1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msvctw3b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471810a77c1so1033875e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760804022; x=1761408822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f0pOHV9nv1hxJzjc+rhs/0yX1sV8PPggM1YFk5/tT9Q=;
        b=msvctw3bfEUxwkWMzay3rarQMRNov/LmVY7Yn7vJIfyMnMa4LdkusMRmkI8nWIQlAd
         hWh8a1jI4f1KXLzfOOC66E4kVhvUl0tu9PMSeJPf+Mm5QNBcHYjpL39RK6XGHBfIYngT
         YWzUW7sp/LTtKUc6AEqeRaN7zl8gkb6RuqYbVNay8stW8NjBbOt/Za06cjYVBG52XhJR
         toKp5E0P2yi5gYNhw7madupKthUAxGGs+eRucPYOSBNuU/JeA5vntm3H70PyxEY8IP0X
         tvaNLzz9jeRRTjOTvNGQgVdoAUBQVKqEvayeH59uNY2NWi8iaqAOLfXzkR7Q606mOsXg
         nc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760804022; x=1761408822;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0pOHV9nv1hxJzjc+rhs/0yX1sV8PPggM1YFk5/tT9Q=;
        b=chTJtFo8uYZQRiALtvxAGALQAZ9xJNLKGmHO99GrtaZT9Cb1jn2ouIBONWjawOWQPJ
         KZlBeiN/jzHNMeZGxhkDCUsBRY3HIeC7PsB+m5RHjkMBaOa6iMl6WnKSMSmbwexYWU0Z
         U1GY8W/cSRE4T7rA/PewkRFSkYKP+b/cfCcEsyp+OkI7zUgtGlnHqjzy9yMz7ThmX9RY
         HQCqZKoJ096h9Dn5zldvHcrif0ubf1Roa9Tp8ckim2ruQwO20afj4hDKbeR4uQ80f0LO
         7JFhu/Ex9PhfKOWLuAK22kYUvy/cjwaxzpZbl+6jGXaPxSiYi1VkmolEc7qu8vncaHAu
         P8tg==
X-Forwarded-Encrypted: i=1; AJvYcCVhASDC/UZB8YSx1hLePKJFAI9SfyyJh5Cm/JH047WaRJiuy1ZOMB0YMPXLIluCl1f6E6pGQBW/GFl3BqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJmR4mFV/hDodm/DP2TUMCKZp5MSkvc3rQLOadGAbNeDVD9XA
	w77QGQTkcdL9T1o/v9nO83piVgNdzHUaJmahyb5imxvskHLm3aNZ9qQ8TBZ7Hw==
X-Gm-Gg: ASbGncvosV7DtZ93kCsbhPPg+5to2EhS1vYZVEKI8A08ne+MhAgGVCQVDOUX4Thq4YN
	FkXon5LaRx911TnzwOBZ2Gy/DRFwRFa+l4RkzrdvhPN0bMypYr3jcz5RMPOgu2AQxqBi6QP2TXB
	btPITar/2/J/uYjbA7+i1iiNkyDEztsAlcwAaiJCmB6dO8sS99hf+Jt88Nd+ZoC39Gw9VP5V8wa
	l5cjATMXoQwVbdE5Thv6sOORi8UwgNRI2MckbpqpUwweCvZqWoZG9sWRB9JpvTmxPjsholszFbt
	0GMUknD126v6459l8BHciDteTZl1Wc4cWwZXsbFyr8krKUKv4OAg/LLeC/0kNvvmCW+aycD9h9b
	bSiJuta5s14Uz/84WcqiRc7llcunwKhHBo5ndAw5vtAgjaUAC9+u4vg3EDZSrnnb5ifVG0YAstP
	Tqi8Ecq8+fx3lRGwkqsLz++r6tPa8S+uw=
X-Google-Smtp-Source: AGHT+IGOxLwcjmXvE3Lb0mSlFrm9lnVnNEmJmV5uOeoSLYYaZp87Dibu/aojvz+uM+vnxkS8QeEjKQ==
X-Received: by 2002:a05:600c:3b8d:b0:471:703:c206 with SMTP id 5b1f17b1804b1-47117917718mr31981905e9.5.1760804022334;
        Sat, 18 Oct 2025 09:13:42 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm5665372f8f.28.2025.10.18.09.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 09:13:42 -0700 (PDT)
Message-ID: <ccaa911b-f405-477e-a542-fe4f6bcb618d@gmail.com>
Date: Sat, 18 Oct 2025 18:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init: Use kcalloc() instead of kzalloc()
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250930083542.18915-1-mehdi.benhadjkhelifa@gmail.com>
 <20251002023657.GF39973@ZenIV>
 <b0388977-413c-46d0-b0e1-fc8d26ef9323@gmail.com>
Content-Language: en-US
In-Reply-To: <b0388977-413c-46d0-b0e1-fc8d26ef9323@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 11:40 AM, Mehdi Ben Hadj Khelifa wrote:
> On 10/2/25 3:36 AM, Al Viro wrote:
>> On Tue, Sep 30, 2025 at 09:35:37AM +0100, Mehdi Ben Hadj Khelifa wrote:
>>> Replace kzalloc() with kcalloc() in init/initramfs_test.c since the
>>> calculation inside kzalloc is dynamic and could overflow.
>>
>> Really?  Could you explain how
>>     a) ARRAY_SIZE(local variable) * (CPIO_HDRLEN + PATH_MAX + 3)
>> could possibly be dynamic and
> I missed that c is in local scope.It's already of size 3 and since 
> CPIO_HDRLEN is 110 and PATH_MAX is 4096 + 3, it's far from the limit and 
> it is calculated at compile time since all values are deducible.>     b) 
> just how large would that array have to be for it to "overflow"?
> If c could be of any size, it would have to be of size 1,020,310 for 32- 
> bit kernels and a lot for 64-bit kernels around 4.4 quadrillion 
> elements. Which is unrealistic.
> 
>> Incidentally, here the use of kcalloc would be unidiomatic - it's _not_
>> allocating an array of that many fixed-sized elements.  CPIO_HDRLEN +
>> PATH_MAX + 3 is not an element size - it's an upper bound on the amount
>> of space we might need for a single element.  Chunks of data generated
>> from array elements are placed into that buffer without any gaps -
>> it's really an array of bytes, large enough to fit all of them.
> Yes I get it now. But Even if the CPIO_HDRLEN + PATH_MAX + 3 is the 
> upper bound on the amount of space and in use it doesn't have any gaps 
> in memory, Shouldn't we change kzalloc() to kcalloc() since kzalloc() is 
> deprecated[1]?
> Regards,
> Mehdi Ben Hadj Khelifa
> 
> [1]:https://docs.kernel.org/process/deprecated.html

Hello viro,
I'm just resending reply in case if you missed it.

Best regards,
Mehdi Ben Hadj Khelifa

