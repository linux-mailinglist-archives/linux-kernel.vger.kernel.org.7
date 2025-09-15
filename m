Return-Path: <linux-kernel+bounces-816395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317AB57341
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E203A5DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8322F0C5B;
	Mon, 15 Sep 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bx5/1n8B"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED736D;
	Mon, 15 Sep 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925741; cv=none; b=kaFg4txrytgYhdjuj8yaQ/I9crn+FAKlsYqfyO4s5MxRy08If8bmEKicPBHyzDsGEf63BoiXlKFUIfQUVDV3pkdDlQReddqQ3+c/F5+9HT6ljIUtZMy9AtBAHB2JU0/kGtSzjRVK1/AcBuBew9ivTSnS6O/78HtgxOiWzCtLqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925741; c=relaxed/simple;
	bh=ZQ9/1OQ5zgWl2afiY0uhe6nntXDy+Ux5mLMYKveBP84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNmhMTQ+/EEy2Y5sbFeFgX27+a8mytCsICQdZ67vCfA99F7nu5xfh01I9fSytYpICYkQ8RQpzZ13sIdhY/zYIZImP7n/jLxa7yyRHYsD4aoi3FVtx39rhVCO1v9YZI5eF7LTkHMdE2JK1XHMu7t1KHHn0L7on1HK4lNaQ/R5f3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bx5/1n8B; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757925693;
	bh=ONwI2U2f2czYvS146yv8bYCH6Eh8amtdVyt6bAK4hro=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bx5/1n8BRcO53gEru4loZ+I2mXKkdOgIhFeG7dTTccyuYmWvEclX/xL8Wh87+Oc9O
	 8njDVG5EpykUGUX5vvNxcHJTyZ3/OT31YEcTfbrlKT8rZNij1gmFj37IAuIjQWvZ8Q
	 AblbyLtybKaovfCPL5EQ/8zvCmmRZvs11PedxuiA=
X-QQ-mid: zesmtpsz9t1757925594t13176318
X-QQ-Originating-IP: 1yqyX70u9cEvSZHh2DkNwqhZn7NylZUwcumWXRspy+A=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Sep 2025 16:39:52 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12716244607003397470
EX-QQ-RecipientCnt: 15
Message-ID: <E8E9626E8F00D397+401f622f-247f-4b0e-b82b-faca3a1055d0@uniontech.com>
Date: Mon, 15 Sep 2025 16:39:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ALSA: usb-audio: add module param
 device_quirk_flags
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Nie Cheng <niecheng1@uniontech.com>,
 Zhan Jun <zhanjun@uniontech.com>, Feng Yuan <fengyuan@uniontech.com>,
 qaqland <anguoli@uniontech.com>, kernel@uniontech.com
References: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
 <87a52zr9kq.wl-tiwai@suse.de>
 <408B48A84E5811C4+555ae002-5b34-4f90-9452-a3458a11f10f@uniontech.com>
 <877by0p28h.wl-tiwai@suse.de>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <877by0p28h.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M3MOXkEWTBZdqfey1fOjSb3I+RIXEwfd/jbxZhpREB6aR5Op6ZBazuFc
	STLdahbMx9FDu7hn/gf3R3HxpTv92EH2ik2ssEznOW+cbzLg1WOklaxcVTBEU8zCW9ZmBcw
	/HkyuRH6qvMtZSeBYqLjpbBy8WHoB0/nDjkh+j5C3ub+PiVzyfxkk1usyCd6ZHg4SbGubCB
	TjCGSACljX8xcUa2799rUBHZNzqsF+MEeG5gD1JO+f7cj+AeRPBaH79T8y+xC/bFOLC0Qfe
	/bLLDi+6GJyACrERfVVlE1+/g8XpdH7fECHoPs5SztgEmQMK7EeHv/eoS6O8pLUx6gczbrX
	fs4zr3SbLqnMr1wkdAJmkdcHlOkojW4y+ilmb0LwishgBcWYbzrifOkFBVJ3hiautd+i8fo
	Ihlvb3RgykcFWEKf70dPAH/kuwrVQbsa1+26nVbRp/dzpjHiPzzZH0th3OTAUjdMbXie+/f
	fmJrU7DEKuopOWBznuC9H7S2aFjRiMG5wKcXdM92k1WpW0V4OjBeg9YkAGt0eA6lqCDJ1IK
	iT935Id98uUgjVOPDZm9MC9GYHDVpKg+1D052bu9FuLTEJE7MFud7fmxcPw20PtGhJmg29H
	nopwDFs8FTLIuy145oP/tJkucxsGzw+7XFMwuS7v1SQz21G2Tc4uzCpH4juMtq4TCxb0wCE
	fshD4yJk9Uieii801ion44yaxGuf1wWtaHF6QQcbeIv0sYsgMIG0Qj2Kvm/mMeO96qULOBV
	Qrgc5LpbHu7Mp5nHK+XakQwhf8SjWBONeaYb20tG7cTsN/6qt/D57zyqIW2Zirgn2lOm++y
	uWU5n0T9bn6Ckzf4coH0alYyjg8qNkcQB4DhKjZsEdsXGxLFhulsu3h3mcQ/+446qxVFOSZ
	HnPFIZh4mFIUtdcZkU4loHpdyEpEJLu3TlFdXm+sgk91kWYa7yLh0kbifaHViiNJVIwKkgW
	G8K4XkI3QiJjCXoZaAfsa4l2pwoPHTtlTTNPljbPXkEwKabXjgWcJ2HMPygPKdiDylbKi8D
	b2+0DFvq7rRjJ6EgHMFaKUf60rBE0cWQG574oRDci3Rg1OWPp0wHC20AkR/+M/EACopjUP9
	vdsH2/cYyRTNUiyqjEpltSqs+V7OtQabYiVu7qYQlYiIwPSS6CY1RtE7jJ+3hzEvF4+r0bj
	EzemMzKlhgvI1R+gaxqssBdwyQewZS8oufowlzIehS8Ld5eoYE96chtVljt+aGotOA9UJiI
	G99BD6LHVEaNvoo0ckw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0



On 15/09/2025 16.08, Takashi Iwai wrote:
> On Mon, 15 Sep 2025 09:43:05 +0200,
> Cryolitia PukNgae wrote:
>>
>>
>>
>> On 12/09/2025 23.09, Takashi Iwai wrote:
>>> On Fri, 12 Sep 2025 08:48:57 +0200,
>>> Cryolitia PukNgae via B4 Relay wrote:
>>>>
>>>> As an implementation of what has been discussed previously[1].
>>>>
>>>>> An open question is whether we may want yet a new module option or
>>>>> rather extend the existing quirk option to accept the strings
>>>>> instead.  Basically, when the given argument has a colon, it's a new
>>>>> syntax.  If it's only a number, it's an old syntax, and parse like
>>>>> before.  But, I'm open for either way (a new option or extend the
>>>>> existing one).
>>>>
>>>> I would like to add a new param. The existed param
>>>> `static unsigned int quirk_flags[SNDRV_CARDS]` seems to related to
>>>> some sequence the card probed. To be honest, I havn't fully understood
>>>> it. And it seems hard to improve it while keeping compatibility.
>>>>
>>>> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
>>>>
>>>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
>>>> ---
>>>> Changes in v2:
>>>> - Cleaned up some internal rebase confusion, sorry for that
>>>> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
>>>>
>>>> ---
>>>> Cryolitia PukNgae (3):
>>>>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
>>>>       ALSA: usb-audio: add module param device_quirk_flags
>>>>       ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio
>>>
>>> Well, what I had in mind is something like:
>>>
>>> --- a/sound/usb/card.c
>>> +++ b/sound/usb/card.c
>>> @@ -73,7 +73,7 @@ static bool lowlatency = true;
>>>  static char *quirk_alias[SNDRV_CARDS];
>>>  static char *delayed_register[SNDRV_CARDS];
>>>  static bool implicit_fb[SNDRV_CARDS];
>>> -static unsigned int quirk_flags[SNDRV_CARDS];
>>> +static char *quirk_flags[SNDRV_CARDS];
>>>  
>>>  bool snd_usb_use_vmalloc = true;
>>>  bool snd_usb_skip_validation;
>>> @@ -103,8 +103,8 @@ module_param_array(delayed_register, charp, NULL, 0444);
>>>  MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
>>>  module_param_array(implicit_fb, bool, NULL, 0444);
>>>  MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
>>> -module_param_array(quirk_flags, uint, NULL, 0444);
>>> -MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
>>> +module_param_array(quirk_flags, charp, NULL, 0444);
>>> +MODULE_PARM_DESC(quirk_flags, "Driver quirk overrides.");
>>>  module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
>>>  MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
>>>  module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
>>> @@ -692,6 +692,22 @@ static void usb_audio_make_longname(struct usb_device *dev,
>>>  	}
>>>  }
>>>  
>>> +static void set_quirk_flags(struct snd_usb_audio *chip, int idx)
>>> +{
>>> +	int i;
>>> +
>>> +	/* old style option found: the position-based integer value */
>>> +	if (quirk_flags[idx] &&
>>> +	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags))
>>> +		return;
>>> +
>>> +	/* take the default quirk from the quirk table */
>>> +	snd_usb_init_quirk_flags(chip);
>>> +	/* add or correct quirk bits from options */
>>> +	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++)
>>> +		snd_usb_apply_quirk_option(chip, quirk_flags[i]);
>>> +}
>>> +
>>>  /*
>>>   * create a chip instance and set its names.
>>>   */
>>> @@ -750,10 +766,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
>>>  	INIT_LIST_HEAD(&chip->midi_v2_list);
>>>  	INIT_LIST_HEAD(&chip->mixer_list);
>>>  
>>> -	if (quirk_flags[idx])
>>> -		chip->quirk_flags = quirk_flags[idx];
>>> -	else
>>> -		snd_usb_init_quirk_flags(chip);
>>> +	set_quirk_flags(chip, idx);
>>>  
>>>  	card->private_free = snd_usb_audio_free;
>>>  
>>> .... and snd_usb_apply_quirk_option() adds or corrects the quirk bits
>>> based on the string value if it matches with the probed device.
>>> This function will be similar like your parser.
>>>
>>> In that way, the old quirk_flags options work as-is, while you can use
>>> a new style by passing values with "X:Y:Z" style.
>>>
>>
>> Thanks for your review. To be honest, I haven't understand how
>> `static unsigned int quirk_flags[SNDRV_CARDS]` works. e.g., based on the
>> current array form, how to pass a flag, and what does the index of the
>> array means.
>>
>> Could you please explain it for me. thx.
> 
> That option works just like other options of the card arrays -- each
> value is passed sequentially to the device of the given probe slot.
> That is, the first probed device takes quirk_flags[0], the second
> probed device takes quirk_flats[1], and so on.
> Admittedly, although this works fine for the static probe
> configuration like PCI devices or such, it's not ideal with
> USB-audio.  So the new format is requested.
> 

Thanks for your clear explain. I would try to implement it.

Cryolitia PukNgae


