Return-Path: <linux-kernel+bounces-644943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66415AB4688
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 23:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17E61B41FE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BB29B768;
	Mon, 12 May 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMSMi6OV"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5729B22F
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085566; cv=none; b=KqubuECqAq0Qkzz2nQRoahDZSXUki6HQ9USeVyFf1wv3Qza4TnzbzBhidGsCGFfbq3YeuJ2Xq0dhyPsCPkS0/fwwJii/hfO8NbpjvhFvBGKhijIDXtLkqQ8oeoADFlcx5oy5FyUAmJwlYive76h/fV+l7PGktbYqb3BDpERKgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085566; c=relaxed/simple;
	bh=f2MCs4lM3l4FrlvQEABriuyhhX5RlGGLRAtIDhd82lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiIAgLxZls/v+HctJbSsEBjdI6IWUU7jRIB18iwXJXgDUQNJyFsO1UGFx+S0kPmxB99V4gnEPOxMSoM9tqDRV/0ki6yJrsq6vRUMCdB3DkriDuyXrB01rmC+RUGUy7/qscyiZOnEZcfCbk8M/bxzR6x74zoOw0vEPQf/+dNqz30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMSMi6OV; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86142446f3fso126405339f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747085562; x=1747690362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVC8CIn+kAUJC5QRXx6Je5lGhZlJWHJlDC4Z0lsVmlk=;
        b=QMSMi6OVn9ARSr1nASQvdrzUNOqd4paa0IYSoqzEBBNDWjFaqMkYmUtzAMVSCpBCq9
         rFZzefecxsgovMxhsXpozyE2z1KUtwslwwFX4slOvbKNbAZOeT78qXZ4yllObnb6D15d
         IYnDImt8w3tuPbLuu5sFp0+E3cQfZQEPMjlrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747085562; x=1747690362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVC8CIn+kAUJC5QRXx6Je5lGhZlJWHJlDC4Z0lsVmlk=;
        b=XHfacZKgPoUcrM7T/OYygYy0xtcI/Ew03z3pMYvjHgEJV5OYb9JYszCxs9DYWa+DpP
         ZGEMMKs9ahp3vk24P8KifGelGNEKUUinoYUYTfPuDAUpfyNqOmQP1/Q83vGdSE4BGveT
         8Nvyac3oQlfhgRNxgQTBaqsIYcQHeGsnlmaOQZ88iExtirFZg/BcKCLQDieDBHBEIXaw
         X5aGlKbSNIQDHd6ppVD1ajhePbCWv7HbaKA5o6pcGzfye+tForc+pu87F86AESEYY/F4
         MFgotJe2W75a970+1h8pZpAq/RQn6yRR/RJBuGxiENintX7CFJ6Q8YHy5eFGZTx59U0Y
         edvw==
X-Forwarded-Encrypted: i=1; AJvYcCVMnJxfAjvwqbdJt6Cp5+ifnF03p2i6PVu6JgjMt0eZw9ctrX2/MNuO/j0H0KWSxikkTHxWCiZXq9QUAsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvrsqLgVWZ3+XW6rtRWvGvbPaFBR5EEqewf0GCs7YoFNVNyZF
	fVA+9kdydkCpSecltotjO00ZoEiKe+2Uyy5YjhSDCsNUqllXvmbDh/mWwDEH8saMfeDVQT/0lnJ
	5
X-Gm-Gg: ASbGnctBwGnGKZXZxT6lk+SPYjw66i/eJSg+gDRSC1BVqWIDAf9cV2vQoDiYvHTgiyz
	jSF1Dor/8RSFoG09W3KsQ6miU4pYGjFtTM5Hs/5YfcsidFv+Q9JJQMq4+t8+mnHvoJCFhW4K8Z7
	Ad0LG3ogPwSyKv+TZwEAo7OyF1QhhU1uFOp6piEvbYhVTYrZvwo4sVWyFrRDcgHPDNUY9DirGIE
	dIaK6U/6lXguFjG3Kkle05fR5bsc1h21zAlTl96KABJO2EgrqWPDT5K6YFUQ1a5B7TUgHp++d0e
	yvBwMqd88uZzC4LmdWgFMkPEA/dOgGf3vWZZVojIeCXnwogXy5lZjGaNvFecpg==
X-Google-Smtp-Source: AGHT+IFUmfEbqs2iqJ2yUBrpmIaYJEyYGMrVR1JpfUOwjb3bm//xzfZQbCP9wt/2h1O8OE8V+0AWaQ==
X-Received: by 2002:a05:6602:13c4:b0:85b:4ad1:70e with SMTP id ca18e2360f4ac-86763575d30mr1787891339f.6.1747085562361;
        Mon, 12 May 2025 14:32:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2ec25bccsm1521170173.90.2025.05.12.14.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 14:32:41 -0700 (PDT)
Message-ID: <a699b6d0-f028-43d1-93c9-250b6c8c4a6b@linuxfoundation.org>
Date: Mon, 12 May 2025 15:32:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] kselftest harness and nolibc compatibility
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/25 00:54, Thomas Weißschuh wrote:
> Hi Shuah and Kees,
> 
> On 2025-05-05 17:15:18+0200, Thomas Weißschuh wrote:
>> Nolibc is useful for selftests as the test programs can be very small,
>> and compiled with just a kernel crosscompiler, without userspace support.
>> Currently nolibc is only usable with kselftest.h, not the more
>> convenient to use kselftest_harness.h
>> This series provides this compatibility by removing the usage of problematic
>> libc features from the harness.
> 
> I'd like to get this series into the next merge window.
> For that I'd like to expose it to linux-next through the nolibc tree.
> If you don't have the time for a review or issues crop up, I will drop
> the patches again.
> 
> Are you fine with that?

Didn't I respond to v13 saying you can include in your nolibc PR?
If I didn't here is my Reviewed-by.

> 
> The issues reported by Mark have been fixed and tests have been written
> for them.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

