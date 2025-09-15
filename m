Return-Path: <linux-kernel+bounces-816282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC80B571D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8171F16B8AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3512E0406;
	Mon, 15 Sep 2025 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="i0cB6JZN"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0652E03EB;
	Mon, 15 Sep 2025 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922341; cv=none; b=PeEi3YMTXv/fMRuT44l91IF1mcvsdGRUbQRXf/dFnUm/9CsYyxMC/R9ppMk3riIgsqjldEABOdFH/YRmC4v48NUWsT/3zPNPaKxiobhkiPOkH9uTchCrmpD215/+stuDUZ+r8TiyZAb6GMSGmMfeM8ZwjBUVt4S+1E+B7wTi0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922341; c=relaxed/simple;
	bh=ERZViQTj+6P1b6/KdlyQAzTUr+pPdDenyjAC3bDncac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwfJxz8PCKjRfEYWJJTqJB1QrxvSNjudLkrAiCMgUdbglaYe292dGt0I9axwNEHPLoCE16vUWCBegyrOIUV3eCnmbhVCsPCl2eLcX8XnrAbTf30zp8l5VEOymLjd2uUSLZh0JFZsclvB/70eUyC5YvYhlHBmFYndN+ao4wt7Uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=i0cB6JZN; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1757922286;
	bh=qF5UwLEBr43GO6SPJWPCyImpKOOb7jUywXrHGThi7ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=i0cB6JZNTrN/O8cu9RQ8MbNidQc1gIsU1VZo52ga8r30GN0yLcWMvQxAiLuGGvsJk
	 62iD34nrrwNbLanTw1BaAp13/hdn7dqrBoAh670HbpZ9KpEWEEHepPzobmxkwAjlQV
	 Oz71SuYZ7PB7pGghHdBfLMXj0pi1xlTDhYgJJ+T4=
X-QQ-mid: zesmtpgz3t1757922187td323d479
X-QQ-Originating-IP: uaKMIBiz8NutNVI7ATwkksZe081CMs2tWjI3RjRxspQ=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Sep 2025 15:43:05 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10455015346246175872
EX-QQ-RecipientCnt: 15
Message-ID: <408B48A84E5811C4+555ae002-5b34-4f90-9452-a3458a11f10f@uniontech.com>
Date: Mon, 15 Sep 2025 15:43:05 +0800
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
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <87a52zr9kq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OWeDQKPzgDU86mCG3DHvRN8Ujs5GHeehhOAyUQ94FNPQBii40Hwv6nrj
	YzMaMCu4JNWpU/SPvQIdLBx32Eu/wo8Zk4RMSXyL+ULa7VsECWx1O3HangIBAbAOIZ7ynWe
	3VKwsqzOTHApbyvoF14bFnOcT0jPEMjEXSyU7qQZQ+y3Wj00Wa4+Mk/c13jaE5tI5kdWnU7
	UClwV40oWyHIh3Z3ttAphipljaZyRWl6M7FYx8RKF6fhIaJv5YG0qQqAqvcxhf0gu3WtxOP
	VWyIfyNQWIAB/UmcGz06pMMCNIBmwBEzpzJJPXLdhXlQWXIipVLSSpX45JG6t8pZo9U5jIH
	yPzTGxEahZzD6dzGvPqzVtRUR3YpaJ9kU0lmLjPDwBv+zFV0SAR+2Uds4qYVrhXLYgZor8k
	awF8JNdvfjzvCau125isgb+0txgKdbkXC87RxppxuZ1fsp0XT2nUPiFbmbxUiWBlwlqq9cL
	1PjFz5nJIhGbVl6c64XbS8qYRPTGTEapJio9pa0a+51xpQpbIAvhgT3enszwgm1XSI72ydF
	3rhMecm76X/s899twxNZ+Thqdxida48U8+dLTDtKvfGFkmuOK0+gmpB7D32rzW92Mt5Yjws
	UyIFal6avmmK7c9sGTwDGfa2VbLYnSvhqGD2e/AGIJBi5KpmN923PTcAzu7c34j0gYENbuV
	s0rceJ14y7xL9v+p0U0Yk5zp9Eqe44nYsn+O/usU1wAwjAdy66FNAX/hEtTN8Xo/4de+w+y
	49Rhx+JKOzih0BjXEYdekolBVoxOI0BkHo9Ar2IoGR9lm2RRxrdbzHKHWDjJswD0WjlP796
	u/9UHODeJq71tkdPVlg8vjQENUItvT1Zol2cjNuoWvlNalYoQwFSuZFVlkHjR3H/XkUhdtU
	YuF3REdlcsVbbhed8SpWkeVSASNuYvOqug9HoAEXjE0CUf9X1Swh+vWGFmBbeMHV+UAhX+h
	rKuwCBEvn6RKB+wXflDXxr5oK8SaV0LlF9/CnZhunuJ2KeR7QDlzYIlNwUXIPs71ylpOi/r
	RkE/ZmnHkQbSJRg9wU59hWwoWGdHJSTCw6S1NMo9upD/ZoG16FnJMSbakdf0RcWXXB/vojt
	B2YJ7jZOY0tJak/NuaIxck=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0



On 12/09/2025 23.09, Takashi Iwai wrote:
> On Fri, 12 Sep 2025 08:48:57 +0200,
> Cryolitia PukNgae via B4 Relay wrote:
>>
>> As an implementation of what has been discussed previously[1].
>>
>>> An open question is whether we may want yet a new module option or
>>> rather extend the existing quirk option to accept the strings
>>> instead.  Basically, when the given argument has a colon, it's a new
>>> syntax.  If it's only a number, it's an old syntax, and parse like
>>> before.  But, I'm open for either way (a new option or extend the
>>> existing one).
>>
>> I would like to add a new param. The existed param
>> `static unsigned int quirk_flags[SNDRV_CARDS]` seems to related to
>> some sequence the card probed. To be honest, I havn't fully understood
>> it. And it seems hard to improve it while keeping compatibility.
>>
>> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
>>
>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
>> ---
>> Changes in v2:
>> - Cleaned up some internal rebase confusion, sorry for that
>> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
>>
>> ---
>> Cryolitia PukNgae (3):
>>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
>>       ALSA: usb-audio: add module param device_quirk_flags
>>       ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio
> 
> Well, what I had in mind is something like:
> 
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -73,7 +73,7 @@ static bool lowlatency = true;
>  static char *quirk_alias[SNDRV_CARDS];
>  static char *delayed_register[SNDRV_CARDS];
>  static bool implicit_fb[SNDRV_CARDS];
> -static unsigned int quirk_flags[SNDRV_CARDS];
> +static char *quirk_flags[SNDRV_CARDS];
>  
>  bool snd_usb_use_vmalloc = true;
>  bool snd_usb_skip_validation;
> @@ -103,8 +103,8 @@ module_param_array(delayed_register, charp, NULL, 0444);
>  MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
>  module_param_array(implicit_fb, bool, NULL, 0444);
>  MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
> -module_param_array(quirk_flags, uint, NULL, 0444);
> -MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
> +module_param_array(quirk_flags, charp, NULL, 0444);
> +MODULE_PARM_DESC(quirk_flags, "Driver quirk overrides.");
>  module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
>  MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
>  module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
> @@ -692,6 +692,22 @@ static void usb_audio_make_longname(struct usb_device *dev,
>  	}
>  }
>  
> +static void set_quirk_flags(struct snd_usb_audio *chip, int idx)
> +{
> +	int i;
> +
> +	/* old style option found: the position-based integer value */
> +	if (quirk_flags[idx] &&
> +	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags))
> +		return;
> +
> +	/* take the default quirk from the quirk table */
> +	snd_usb_init_quirk_flags(chip);
> +	/* add or correct quirk bits from options */
> +	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++)
> +		snd_usb_apply_quirk_option(chip, quirk_flags[i]);
> +}
> +
>  /*
>   * create a chip instance and set its names.
>   */
> @@ -750,10 +766,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
>  	INIT_LIST_HEAD(&chip->midi_v2_list);
>  	INIT_LIST_HEAD(&chip->mixer_list);
>  
> -	if (quirk_flags[idx])
> -		chip->quirk_flags = quirk_flags[idx];
> -	else
> -		snd_usb_init_quirk_flags(chip);
> +	set_quirk_flags(chip, idx);
>  
>  	card->private_free = snd_usb_audio_free;
>  
> .... and snd_usb_apply_quirk_option() adds or corrects the quirk bits
> based on the string value if it matches with the probed device.
> This function will be similar like your parser.
> 
> In that way, the old quirk_flags options work as-is, while you can use
> a new style by passing values with "X:Y:Z" style.
> 

Thanks for your review. To be honest, I haven't understand how
`static unsigned int quirk_flags[SNDRV_CARDS]` works. e.g., based on the
current array form, how to pass a flag, and what does the index of the
array means.

Could you please explain it for me. thx.

> Takashi
> 

Cryolitia PukNgae

