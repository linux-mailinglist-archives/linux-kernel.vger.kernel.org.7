Return-Path: <linux-kernel+bounces-763914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA99B21B86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE871168B76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFD2D320E;
	Tue, 12 Aug 2025 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ZyOOaVkn"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907E335C7;
	Tue, 12 Aug 2025 03:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968748; cv=none; b=VPgYt6KC+urWDxIqOL0JA6mYvBxIQ8C9z1kINOprE/mPnG0uspxaCWC1ZNSCA2P4sFtUgzY2oC8RmfrBj2UeJDdfZfV5VJL5SVqmC2/WKYmx8R7HJoTSDkr7f1tJNAJvmbd7bdzBdfRCTwBEke7mFD/dyLDUug+A7T7z8teayaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968748; c=relaxed/simple;
	bh=JWr5GnVWnAU4GM/yEBrAkx091IAX+YqdPOB6mV+qwbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxAjrIuzp3Acs0vF2nZHxTWzYsugsnx4KfE0q6abKL/xMSpEjJAQS9fRHhzsA81B6FRif8bpuSolkdc4kRYeda1+cFhlQKEjvByHRe0rxlRMesFBRZzTcM7/VEDMWGBSnpgSk5+/s0pQ2RnMvmnMD3CxFonkN39GPQVDP07QYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ZyOOaVkn; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1754968711;
	bh=w819vPHCzSjvWIZoGLPIItTx9dfZyFMgI1mbx4HJIQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZyOOaVknf6aDeI+yz7yMuiJOvdxjlIvmTI4ci+FTRC0JhGIP0JmhTlnfC373YEISd
	 xZu8B+sqthPjybV978xLkxN3SpM1W6ab5vHha+HLEgn40P7cpsIt8N0SPrk/Rj21tl
	 5/uif6N0yWX4GGTPZhSveH8AmpiL9TnsPbRIrFlM=
X-QQ-mid: zesmtpgz6t1754968709t0043451a
X-QQ-Originating-IP: h1CUU9sYr1EUHV6mgQSmOBaLIqXPI1sP3mzlfK/dHE8=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 11:18:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7724009268559505436
Message-ID: <E8C4F9764DD41E5E+97d54ecc-9519-4ec5-a995-5c9dc45961cd@uniontech.com>
Date: Tue, 12 Aug 2025 11:18:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Guenter Roeck <linux@roeck-us.net>, Cryolitia@gmail.com,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, command_block <mtf@ik.me>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
 <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
 <d4b6932f-fe95-4502-b7c9-650a61ab565d@roeck-us.net>
 <4CFDED845BBB7FFB+10019dea-8229-4681-9beb-5f351eb8faf4@uniontech.com>
 <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <CAGwozwG13swYjCB6_Wm2h8a2CdHxam+2y=g1m42pynkKqqdDLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NcfXIs+Ms1qHGA0BJZqOjmZMULX90a9+w1wk9RTX4GN7WgPJxANHbmFC
	VIAifO0y/LORoGmAi/LRexuGezm2O9VKGZsvABDK0H8hNyX0ozgcRxSUi9GKfz1L4TbIxrv
	XDE/DtbmjkjMjBeSnSNDq8jV8h2fMtdYgunp61kAmzHYpuSrYmrXqyg8crdDZsL0NuWSodI
	masAvU+g2/PxqCQgnQYynp8dwaUeY7ZV+CMsN1/KwIKOULvBwkOg7byxIx30nnjzmQ1B5b6
	APR+r+roe8cGy3kvwDEY5+zsWFQlaJGLZmqRdK6sbqDJYACEzETbgLvR2RwLIPs4iHd57yb
	oCWir24bhYQC2BSqleon4B7qRtc7oP01E1dyW25sCElJ3cuz/m4A8oP4gP9lvh+beDfWIvw
	i2E8cgraV4oGnN9yK8jdBKLOraalH2jlyQje5YOJNjUxjsSDAi6NPZ4m1t0VQm7rdzW2j9w
	1SMlhTL+4L3YVd319e2K20/PKBb2b7Rg8UztP6rIpTPptnQr6cwr24Pc0Jnb2c8nf2dziGz
	aDL7rs2JDgMAaYBfEJh9elAvzovLNxU9nfD1zmo4tsNZXtS+FCeWj+ZDy0s4pjK1pP1+aze
	V2w7K8ADKu24luKNC7bXldas+dYjARTK8FyTbBYQIyhTBA0tJkyEw+kmUhVqS9DizSCPM2A
	mwo4B37kFhFFeGfwN6FrFmxBLBOM4M3vbQSzj21+g4rgYi7N8+5Ty0rouwmyOKbeKIaLDl9
	GIIYovEHX8bmvuoUXWlyJT8Nb29FgwNXtrPYgDf57HPOk4aJet95whT5Dw/ySyoOJVPT2JN
	2Q0sPENQNoCuI9kpNkXO7CXPyM1RWaBJaqoi8mFH1DchXwGR2rQZUKqJzuP58Wzw5+tfTFX
	hujoGFBNlDrINQyrrkm/ae4mfKcHAy9oth0rLTcNVhn93kcr1Evz2+9MaiXYdc+JIKKM6ji
	fsqEpaQa2+HU7N77zG7Lo90nMxuFPfu6RzsP7jrkvOJTf4wA9u5F3q9HErY4cL9VbDAqbH3
	sLBzvoog==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



On 31/07/2025 16.13, Antheas Kapenekakis wrote:
> On Thu, 31 Jul 2025 at 05:30, Cryolitia PukNgae <liziyao@uniontech.com> wrote:
>>
>> Personally, I'd prefer to maintain this small driver in the hwmon
>> subsystem until we need to write drivers for the same EC with more
>> diverse subsystem functionality. We can then discuss and learn how to
>> evolve it. I personally don't think that's going to happen in the near
>> future.
>>
>> So, could we continue reviewing the current patch series? Where are we
>> stuck?
> 
> Either is fine by me. The move is simply a rename anyway. My reasoning
> was it will take a bit of back and forth to get approved and charge
> limiting is a standard feature now on all manufacturers except GPD, so
> I expect them to add it soon. But since it is a rename, it is not a
> blocker for reviewing in any case.
> 
> If you want more comments I think you should send a new current
> version so it can be reviewed again. It has been a while since the
> previous one.

I have sent the 7th version two weeks ago. I would like to hear your 
comments if you have a free time to take a look at it. Thx a lot.

> Antheas
> 
>> 在 2025/7/31 01:26, Guenter Roeck 写道:
>>> On 7/30/25 02:24, Cryolitia wrote:
>>>> Thank you for raising this valid concern. We've closely monitored GPD's
>>>> development plans and currently see no indication of EC functionality
>>>> expansion beyond thermal sensors in the foreseeable future. Given this
>>>> observation, we believe placing the driver in hwmon remains appropriate
>>>> for now.
>>>>
>>>> That said, we fully respect your maintainer perspective on
>>>> future-proofing. If you feel strongly that platform/x86 would be a safer
>>>> long-term home despite the current scope, we're happy to move the driver
>>>> there immediately. We're committed to finding the most sustainable
>>>> solution for upstream.
>>>>
>>>
>>> As hwmon maintainer, I feel strongly (since you used the word) that moving
>>> the driver (or any hwmon driver, for that matter) out of hwmon space would
>>> be a bad idea, but I won't prevent you from doing it either. It means less
>>> work for me, after all.
>>>
>>> Guenter
>>>

Best regards,
Cryolitia


