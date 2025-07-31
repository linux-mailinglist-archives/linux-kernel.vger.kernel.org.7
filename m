Return-Path: <linux-kernel+bounces-751558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03782B16ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C153B3B6DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECC23ED6F;
	Thu, 31 Jul 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GW/gfG4U"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB97238C21;
	Thu, 31 Jul 2025 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932650; cv=none; b=C9vXZQ4v96Zh6BGQJd1N/TP+eWJq4laUiXCfQ+76xvup5ATzO1unjC+PPsJXO59QZMMTSmDJaVkFwK5buKRagORFTJ0uCTQhmOrh5HJM3qoQgzpPIWl1fxBDmuRANVzuaYqQZST+83sQQKY6+LwoPSzODGLZwA34/b+tYc2CJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932650; c=relaxed/simple;
	bh=JZMVXMf82uviq6TtXOW88rD7Gr+Ns5t9/CLyloMEeqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUXMDtlDz9FBjjT4z17kbsOnlsgup07YsQYj0Ua7yrOJS9+C+1GIi7iiSXXDOypdTBq0Bi23Gy9M3DAGyGbGIFB3edMr1l1yVBW8pK6sLXDOqQ11ZE4TFKFADKZaDUK026E/hikLwSKHBT4tTOlA/N/3aiQXFloiRL83trxqtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GW/gfG4U; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753932620;
	bh=mEwlU3VUgiRNqVDg9d2vtujLxFiYx8c2bI5jEzzZcek=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GW/gfG4UAXlUMiqlTV+UROzkU+/EmoE2wJOF19mas8ll9xDW+cFkE2Wio+p7CtLDN
	 AebTayxIT/HoeYb0g/4u9uNBcL7l7Ze2/2ZxGya//Efu4vdinl4DM8IXKecfhJ8oaj
	 7Dt6FvFw7iFwEVTJnxfdgg9LVtMCKpAU7jbd1pzs=
X-QQ-mid: zesmtpsz6t1753932617t5e8e9fa5
X-QQ-Originating-IP: zCqGh6Ww3Ju24DY3fOlLq93/NY5GKrDIm/co/uH03lY=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 11:30:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10897133381214685842
Message-ID: <4CFDED845BBB7FFB+10019dea-8229-4681-9beb-5f351eb8faf4@uniontech.com>
Date: Thu, 31 Jul 2025 11:30:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Guenter Roeck <linux@roeck-us.net>, Antheas Kapenekakis <lkml@antheas.dev>
Cc: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
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
Content-Language: en-US
From: Cryolitia PukNgae <liziyao@uniontech.com>
In-Reply-To: <d4b6932f-fe95-4502-b7c9-650a61ab565d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OUuMuW/cX/8cPXIe4DXFHoWVC5J784kdU/dqt516+32L7DEUUHu6yv77
	4HE16/8mdfffWtOhnuwNnD6EBmajgtJieQtXQsdi9hoooi8oWZtFkx8bEOwpU2USNUwiv5c
	6XISXYJqz5kAHC3Fhmb6zjAbWyelDzPFfSA+Te8MyCHQj+bGsPAsavq5Nt4IgYJX1KGYKnZ
	JjdVt4cQsj4q4jP3B660OfyJ/Grm7Wn/YeNFnwdZysbzc4OHZbQMyIY8zaLPqyx0yNygdCy
	9lS/fU1hfaTO+X+htTMqIZnIBWrOL/86CjjQ9oRIPrC8afDj/EW1dK8erKwGAFB2oo6UoY5
	IaLQaG8fcRM8RcNvssBPWfeDcFJuTf10cumX4hCTtTWNP5FlkggeT9keDp43h7YXoUgK72x
	kO/nzPbH0r8tKGUm5uHUvalv2uWTqkPzff4ZWFM7P7Y4VlkL5C1Lh0rTfURvf2AKQ+VkehU
	mzWGaeSEwsqSWbO6aJP+8dyE3QGCrs8eadLzrpLNVc6UnoxEblGEIBtn2Zf8QejWUcecnAd
	ZBh431N8xojCQnMi3QwSr6Co64a9IW4IYsNcxtHlnI+ViQJlw+JsJMaqrg1esFNmXXKEokE
	TlHja/9vGj6sly6n/DSpssoEdldpOTb1aCtJh/EtJYSrUL1M0VQfyNzYJRN/JPfgdLFMRTG
	NvuKd6uKYBGTy8VS2bV3p34hV7vXL65PDa1z3cqUU8p5yY86ZWVTT6ulgqvR4jt38iTAJGb
	YJpOSrs5BD6V5derk8H/qEyH7gE/JJbjdtIwME5uH7kR3O+lqJUON3qlFN3N5pvXZ45dqQy
	/0a7SBC5n+zKOae9k0hiI50ztMDTISIpEwUBFaeVl6vpSvlwuhO5/oQMvN0uJ1KLuYGuUrW
	83pjKz18p8LaBfeExtVpn9x9CSZXIv6t4FDwV5zvceQ3f5Vk5aLrRORJMixdhKAs2ZPk1C8
	PTxMwzuKUmxeOCOGBWrpgSHZlNY1mq/wpmIW2hj2ry30bkPBTc1R7C/CwUYucueU/x0HFA6
	x7G2KLBQHRcHcnb4K0LIP59EmQc8YzdG6QJpDxWmgpJSyaFciLrWGXntLb0O+JYyTeqOvs0
	5GtS7XG4Thqd6f34luPel2ry5cXxW1qnznK4YmCapZx6O5DHEBZ7TuLNX/YrHGRbA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Personally, I'd prefer to maintain this small driver in the hwmon
subsystem until we need to write drivers for the same EC with more
diverse subsystem functionality. We can then discuss and learn how to
evolve it. I personally don't think that's going to happen in the near
future.

So, could we continue reviewing the current patch series? Where are we 
stuck?

在 2025/7/31 01:26, Guenter Roeck 写道:
> On 7/30/25 02:24, Cryolitia wrote:
>> Thank you for raising this valid concern. We've closely monitored GPD's
>> development plans and currently see no indication of EC functionality
>> expansion beyond thermal sensors in the foreseeable future. Given this
>> observation, we believe placing the driver in hwmon remains appropriate
>> for now.
>>
>> That said, we fully respect your maintainer perspective on
>> future-proofing. If you feel strongly that platform/x86 would be a safer
>> long-term home despite the current scope, we're happy to move the driver
>> there immediately. We're committed to finding the most sustainable
>> solution for upstream.
>>
> 
> As hwmon maintainer, I feel strongly (since you used the word) that moving
> the driver (or any hwmon driver, for that matter) out of hwmon space would
> be a bad idea, but I won't prevent you from doing it either. It means less
> work for me, after all.
> 
> Guenter
> 
> 


