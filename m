Return-Path: <linux-kernel+bounces-883706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC605C2E289
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420803BCCFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831082D3218;
	Mon,  3 Nov 2025 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b="LQSw/doq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2N9sLIFF"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDA2AF00;
	Mon,  3 Nov 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205469; cv=none; b=H2cHEDjShvRlR/Fi+dBlj6KfRJw5c/urfHtcwpsjyQ8DfMkGM3qG9BGHv8MDDvK/vVy5ZlP3xMYCD8zYt1VhgD2EJqab4CQF5zToKOsvbCLAeLQKCirJueja7CtatGBIslatKg+awumQi3Cms4/WK0EiPdnMdP8LMkjd6z2Wn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205469; c=relaxed/simple;
	bh=C1nfCvE/moILgJLutC4rDfqsAuPg81GHNXC7RwANoSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av8ctIIw4tT0VMe28U5bFZzH05hzj7eaAd6TPuWFaSRRfkj04OSXSJQ0/vQSN1SFNanIooxkhwd/Co1QPB0YpjS5ff48ac8MpmrgcLc/lTSnQTGu2wlDwXqaoavR2SQXCbA/l+oLJZpkRLmbbKUuAidp3QqD3BDe5+y7EYj3xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl; spf=pass smtp.mailfrom=vdwaa.nl; dkim=pass (2048-bit key) header.d=vdwaa.nl header.i=@vdwaa.nl header.b=LQSw/doq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2N9sLIFF; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vdwaa.nl
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 71D9FEC0331;
	Mon,  3 Nov 2025 16:31:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Nov 2025 16:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vdwaa.nl; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1762205464;
	 x=1762291864; bh=EBJQdfSFVqVStxS33cWTBDRhAkWgHd9W/rplNVuelOc=; b=
	LQSw/doq3YwWf4pDj6q953CgIzStFjTKfHVOJxAjxiK9MXz+KhTL3ahxvx7F8gfu
	uXDtUzfggu9s5VSea+N3SVKdm9xzZYeB4Dm1kk+Kc0n4GWOXQ4sVe4xK0gVxK2WP
	60k0puiExZRMZvGEJUBqXVoU4PbW16Vs0gZHvRUG3pCl4kLJjxhpDdxwafmCuoAY
	ID3Ccr6W5LYLajGzRZYS1+iGZW5Wbv9h6tT7Ce2rv8+KNNP6m6dF/bbKNtWNpOJ6
	N77/5D+et+9ymoDr+fDOfnsUdivJ88gn+ehU445meF+jVVlBHUH4heWX76OKgpKn
	h9s28sV2YOiYAzkI3H4U+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762205464; x=
	1762291864; bh=EBJQdfSFVqVStxS33cWTBDRhAkWgHd9W/rplNVuelOc=; b=2
	N9sLIFFGLOQfpFskC/Rdtt3aaivVf108WU10qa5/DtYsuYZC0RA1kKg1Wgj+gj0p
	JyErOZF+HzB4c2WYCPVwTt7mv0KB9oypY+2BTWvp5Tq9xY5s4Z+QubgZI9uiIsR1
	jIr4ASEiNakanu7ODllH2/pTwwOw1h+vACS/3zmnRX0sGLVXJeeWqhsIit0S+tMv
	TmFKxvkVjoPkTgP553xqDAWmJePqU+xO21mOZKe2mIbCDF7uumfVe2b8CUyM8m6K
	V/tH6Gd8lw327dSuY7elVzY31o1ZyjaqhGPEw+oqNgpl9j8Kuw2+7SViV45SGLlx
	bIBn1hNT9TpICXg0MlMJA==
X-ME-Sender: <xms:Fx8JaQwn8wdyf6J5mC8RPCp0phjKLzA2WmTWYhhNOkbkreXQD0bsMA>
    <xme:Fx8JaQRmZB_3KSmyaizcGEXFq-rAAHtLVEf0QcZkTz2TJNvsaVtI9TDNQfBTY6ar2
    IlPnJPPWM_LmSVa5pMd_rPtL4VfncAMAaRnphTfFdjV3YZr1hVSfXTI>
X-ME-Received: <xmr:Fx8JaUhY2pe74wPa9KmZDEEhDfcdOUG7wTv45p-xJk1-Vb7Oj2c_ygZo_IYVKmowMpLrywEUWW0Mx5OlY59WUHUsEDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflvghllhgv
    uchvrghnucguvghrucghrggruceojhgvlhhlvgesvhgufigrrgdrnhhlqeenucggtffrrg
    htthgvrhhnpeejvefgvddtffduvdeuleefveejteegfeetfeefleejleevvddvfffgleel
    teeljeenucffohhmrghinhepsggrughlrghnugdrihhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvlhhlvgesvhgufigrrgdrnhhlpdhn
    sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehisehroh
    hnghdrmhhovgdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhkvghprghnhhgtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdprhgt
    phhtthhopeguvghrvghkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpth
    htohephhgrnhhsgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorhhm
    qdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fx8JafkmXNj2BFFGAajBYL04l5h3NC03me2QPI0ip_Pv4PBlAT_PwA>
    <xmx:Fx8Jafsi6kycwHVyeuEpZB0DPVE_SlMUWgbzczgUWp-Wf-tLyWVprg>
    <xmx:Fx8JaVYcDxJUoAmDy2c_edkfEEAVJI45UWipiqKvgWoTllSzFKk6XA>
    <xmx:Fx8JaXCErHhwTBM2YnOwarkA5oqHJtfVhY-LkicdQR8FUbl6-D2hHQ>
    <xmx:GB8JaaZDlied9QYcRT6KqlU8IZc_ALcaLSpOo08ODOgH4_R4Byqrjice>
Feedback-ID: i2d0446dd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 16:31:02 -0500 (EST)
Message-ID: <6bdbfe74-1765-408e-9192-e54accaa22f4@vdwaa.nl>
Date: Mon, 3 Nov 2025 22:31:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Add charge_types:Fast
 (Rapid Charge)
To: Rong Zhang <i@rong.moe>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: Ike Panhc <ikepanhc@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020192443.33088-1-i@rong.moe>
 <dfa70284-04ce-482d-8d79-cc0ee8b4bf6d@vdwaa.nl>
 <5d1ae6eb34378570ed1f9b62d945c95bda8a5b86.camel@rong.moe>
 <1fd710f18bdfcf5d5c157697cdbe874465ee0130.camel@rong.moe>
Content-Language: en-US
From: Jelle van der Waa <jelle@vdwaa.nl>
Autocrypt: addr=jelle@vdwaa.nl;
 keydata= xsBNBE6QLAIBCAC3O6LmF+GKvOh7IV00TG+EKAQHAwjESnHGJOW58lKK7eAYn62ZM1uy0+6h
 yCMu5PD7+ND6U1gcgTTHYwNK8AaJt7yY4FRssgdcJk59uJBwROZtllotClJ893CuB6Wgr68b
 07gIRbENYrB8rEoGfpUG//8/ep7sY8PS03jnFb4ll6mPlUE2oQVdYOlXgF4f9qkkIi4SQeE2
 MTuERaOrDuUNDlroJ7Yfx3J/rL5Qjn578/TKCAxg0pns6VIA/P9spRGmLhT4zP+OxZXeSZme
 IxcwFdJJXHr4oGaZvqe1yHlMmKR98rrIfPWhkw2Ls/XIZIxf6prT0XyczbzBnC2y1JyNABEB
 AAHNIkplbGxlIHZhbiBkZXIgV2FhIDxqZWxsZUB2ZHdhYS5ubD7CwHsEEwECACUCGwMGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJUX8WhAhkBAAoJEMBghjN8UHc+mFwH/jjN+Qob4O36
 YiieajRwVLGuYdUDt9Z655oQYU8V4qbWf2tjUtqTYXrxLnaY6xQoYouRz9yFbh9dIKZb67ir
 7AeVgCOtWVesGxAlGH6EY5JBZcsN0v0ScsivqQAv/Mv+4HK+XM57YlyRagD8tkprYskioWHg
 OwQfXAO6nlm4BJHWO9bHJUMgiGs7I190IKQG7iLBnJuGjsOFuy5KTLpnv+w7twmz0H+pkUPe
 jVHfJlJWdN4v1PigpgpjOR6ZepSIggMk7dHsa6GNLUOzi61yYVFe60+EGXhwyJIqSt56a4oR
 jMUcXaOugGr+JwC8Eq7Pg2+aFk+8fbe0oUzZJucHGnDOwE0ETpAsAgEIAK4Usb7B00WRxCZG
 HtM973F7V4OhOKv4kZKduxtu71bVUZsTuzn4h+m8guJ51uY/I2icUrN9gJG5aEzRqPuQi2L7
 KmZUjs3pscZWgUgiT8UZFDR6RuQ4k3CcWobsRCjYZdSblSZ8ccrLJE7xSbwKMXjAh2PEiaQT
 lS6wQbn6mHv4y3H9QVHs7+jXbmfHCxnVcwLqRmpuegSmezDaL5TlSc102voiXinhrWEZUvAB
 KDh6VuJ/60Y6zelCXVsEjRaApz90iXY1nifLhkHM8B2wG7Pum3V3X0Y0QTVD+z3EL1iq5mFu
 epKp//IOeeJN5iwHcRSJGy2s1oOzjRDyPv6v1AUAEQEAAcLAXwQYAQIACQUCTpAsAgIbDAAK
 CRDAYIYzfFB3PvDuB/0dI13hSYHW27c2Rq8BaGbIhXYYETtPD5B25/P1JJ5OQZkPmVq+vSHw
 uzUaDZHy3ZcwE+xFXzlkwXGdWos07JUGo74zV3HfeZxVEPv0HB9ACqQVU/JKjLZNj2SfhgzL
 4F+O4Zgdsf0YaZG09F5PbMvbhoCZLfAaKWz/4fLEfhrDJLhrphUyPDXosn0UxPkDv0iiixn4
 V+bEZ5/wd8dRWi58R/iND+gRGsBREm5SpzdhnsarwoX6YdsQ449379enDNUN7jV4C3Gkon2s
 VwI2ZZbS10cY8rFSAV/CJA2E9daRoz40DI0tgXgLBAVhy7y5HWZJsDZexU0HFKJfkDi7RUPj
In-Reply-To: <1fd710f18bdfcf5d5c157697cdbe874465ee0130.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/25 20:24, Rong Zhang wrote:
> On Mon, 2025-11-03 at 02:57 +0800, Rong Zhang wrote:
>> Hi Jelle,
>>
>> On Sun, 2025-11-02 at 17:09 +0100, Jelle van der Waa wrote:
>>> On 10/20/25 21:24, Rong Zhang wrote:
>>>> The GBMD/SBMC interface on IdeaPad/ThinkBook supports Rapid Charge mode
>>>> (charge_types: Fast) in addition to Conservation Mode (charge_types:
>>>> Long_Life).
>>>>
>>>> This patchset exposes these two modes while carefully maintaining their
>>>> mutually exclusive state, which aligns with the behavior of manufacturer
>>>> utilities on Windows.
>>>>
>>>> Tested on ThinkBook 14 G7+ ASP.
>>>
>>> Tested this patch on my Lenovo Ideapad U330p, it now advertises that
>>> `Fast` is a supported charge_type although my laptop does not seem to
>>> support it:
>>>
>>> [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
>>> Fast [Standard] Long_Life
>>> [root@archlinux jelle]# echo 'Fast' >
>>> /sys/class/power_supply/BAT1/charge_types
>>> [root@archlinux jelle]# cat /sys/class/power_supply/BAT1/charge_types
>>> Fast [Standard] Long_Life
>>
>> Ahh, then we need an approach to determine if it is supported on a
>> specific device.
>>
>> Glancing at the disassembled DSDT.dsl of my device, I found:
>>
>>     Method (GBMD, 0, NotSerialized)
>>     {
>>     	[...]
>>     	If ((One == QCGS))
>>     	{
>>     		Local0 |= 0x00020000
>>     	}
>>     	[...]
>>     }
>>
>> BIT(17) of GBMD is 1 on my device. Maybe QCGS means "Quick CharGe
>> Supported?"
>>
>> With this assumption, I did some random Internet digging. The same bit
>> on other devices is called QKSP ("QuicK charge SuPported?"), SQCG
>> ("Support Quick CharGe?"), or QCBX (see below).
>>
>>     Method (GBMD, 0, NotSerialized)
>>     {
>>     	[...]
>>     	If ((One == QCBX))
>>     	{
>>     		If ((One == QCHO))
>>     		{
>>     			Local0 |= 0x04
>>     		}
>>     	}
>>     	[...]
>>     	If ((One == QCBX))
>>     	{
>>     		Local0 |= 0x00020000
>>     	}
>>     	[...]
>>     }
>>
>> https://badland.io/static/acpidump.txt
>>
>> 0x04 is BIT(2)/GBMD_RAPID_CHARGE_STATE_BIT. With all these pieces of
>> information, I presume BIT(17) of GBMD is what we are searching for.
>>
>>> I'm wondering if the battery extension API allows to not advertise a
>>> property if it isn't supported or if it should at least return -EINVAL.
>>
>> We can achieve this by defining multiple struct power_supply_ext. See
>> drivers/power/supply/cros_charge-control.c.
>>
>> Could you test the patch below (based on "review-ilpo-next")?
> 
> Note: this patch is just a quick PoC (I am going to sleep now, zzz...).
> ideapad_psy_ext_{get,set}_prop need to be reorganized to properly
> support your device. If `cat charge_types' doesn't show `Fast', we're
> in the right direction.

Thanks for the quick patch!

Tested it on my Ideapad U330p:

[root@archlinux ~]# cat /sys/class/power_supply/BAT1/charge_types
[Standard] Long_Life
[root@archlinux ~]# echo Long_Life > 
/sys/class/power_supply/BAT1/charge_types
[root@archlinux ~]# cat /sys/class/power_supply/BAT1/charge_types
Standard [Long_Life]

I'm however still waiting on the laptop to slowly charge to 80% to 
confirm that charge limits are applied.

Greetings,

Jelle van der Waa

