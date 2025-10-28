Return-Path: <linux-kernel+bounces-873675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66240C14680
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFD1C3524B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8207307AFB;
	Tue, 28 Oct 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="NfyzdffH"
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A51BC41;
	Tue, 28 Oct 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.224.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651600; cv=none; b=PtCS8WTdXmgS/CIvWdaqcXLwuaIUF4y9wMdTEuDlOWR4rA3KYmyd1xoXjHyOT9ATzdN9rEskCSgyhCIPgh5o4RTNRmbD/QCNvSnVDZk02m/40Ay8sBeLWXZw2siXkfIh+gpKsIpKLEHQ0vdbZphtyyDlW/52wwunZQE7WmpE6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651600; c=relaxed/simple;
	bh=XVFx8SJbdZrM/48CxwReR4w+sE1ZL93VFdW81KWJopo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NOMXObQgh2+jltfO8wp/JPoa7fVALAw/9AA/cev9bu32W2N6w0X02hhS0pzGCpQrhbsM2s32+SCfAvjG3wAG9kn4bh6casZ6I4F1jwvQFJSdDqF+VMXrQ7pzoJ45SEQswj5sTjixVEMwc1TubzqZKaXYfsKB7rMG2QadySSFl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz; spf=pass smtp.mailfrom=perex.cz; dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b=NfyzdffH; arc=none smtp.client-ip=77.48.224.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=perex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perex.cz
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 6F7D538C38;
	Tue, 28 Oct 2025 12:39:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 6F7D538C38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1761651587; bh=PS3nwoVEr99X0Be/ELVpdNni95tGHNA/TGoMqBq23cY=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=NfyzdffHf8xlnFkMcCL3sMT7QIu7PcSGlWoMcbi4pCCllYnRcAhQrIM221PCQkDOs
	 FydawLfzWDj7cX7KvIwLfbAjaGHgIr6x+CgpTV3vojVT8H2+2gHXer8ryIF9NoAY23
	 jBipAIAMHmWCpQhofbGhhCIxr7lzUFmuKo2q1aEk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Tue, 28 Oct 2025 12:39:40 +0100 (CET)
Message-ID: <9b05914d-34f0-4149-b715-b4af6bba6701@perex.cz>
Date: Tue, 28 Oct 2025 12:39:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: sound: Increase max size of components field
To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Takashi Iwai <tiwai@suse.de>
References: <20251023092754.84095-1-mstrozek@opensource.cirrus.com>
 <318f2ed3-57e6-495c-a773-4a094a3784cb@perex.cz> <87ikg03ecf.wl-tiwai@suse.de>
 <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
Cc: ALSA development <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 Kernel development <linux-kernel@vger.kernel.org>
In-Reply-To: <3cb73dae8e8ac1a29c856dc5c86064d568003316.camel@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 12:50, Maciej Strozek wrote:
> W dniu pon, 27.10.2025 o godzinie 10∶04 +0100, użytkownik Takashi Iwai
> napisał:
>> On Thu, 23 Oct 2025 13:56:26 +0200,
>> Jaroslav Kysela wrote:
>>>
>>> Or, we may introduce a separate ioctl for the components string.
>>> The
>>> stripped components string in struct snd_ctl_card_info may have a
>>> special ASCII mark like '>' at the end of string specifying the
>>> availability of the complete string through another ioctl. I would
>>> prefer this solution.
>>>
>>> Also, the components string may be dynamic in the kernel structure
>>> (pointer) to save some space. 256 bytes is not small number.
>>
>> As Jaroslav suggested, we need a different solution to keep the
>> compatibility.
>>
>> My gut feeling is for the option to provide a new ioctl as it can be
>> most straightforward, but we can discuss further which is the good
>> choice.
>>
> 
> Thank you for the advice! Not sure if I understand Jaroslav's new ioctl
> approach properly, can you have a look at the quick draft below and say
> if this is (more or less) what you would expect? If it is OK then I
> will prepare a proper V2 patch here with a corresponding change for
> alsa-lib repo too.
> 
> 
> diff --git a/include/sound/core.h b/include/sound/core.h
> index 0eb2e3ee0dd5..c4e52fb1704b 100644
> --- a/include/sound/core.h
> +++ b/include/sound/core.h
> @@ -88,7 +88,9 @@ struct snd_card {
>          char irq_descr[32];             /* Interrupt description */
>          char mixername[80];             /* mixer name */
>          char components[256];           /* card components delimited
> with
> -                                                               space
> */
> +                                                       space */
> +       char *components_pointer;       /* full components string */

Keep only this, remove the array and don't use the length member (null 
terminated string).

> +       size_t components_pointer_len;  /* length of full components
> string */
>          struct module *module;          /* top-level module */
>   
>          void *private_data;             /* private data for soundcard
> */
> @@ -297,6 +299,7 @@ int snd_card_info_init(void);
>   int snd_card_add_dev_attr(struct snd_card *card,
>                            const struct attribute_group *group);
>   int snd_component_add(struct snd_card *card, const char *component);
> +int snd_card_add_components(struct snd_card *card, const char
> *component);
>   int snd_card_file_add(struct snd_card *card, struct file *file);
>   int snd_card_file_remove(struct snd_card *card, struct file *file);
>   
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index c302698fb685..7d53f6da59e2 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h

...

> +struct snd_ctl_card_components {
> +       int len;
> +       unsigned char *components;
>   };

Use array here. It makes things simpler. Perhaps, we can use 512 bytes / 
characters here to avoid future problems.

>   int snd_component_add(struct snd_card *card, const char *component)
>   {
>          char *ptr;
>          int len = strlen(component);
> +       int new_len;
> +       char *buffer;
>   
>          ptr = strstr(card->components, component);
>          if (ptr != NULL) {
> @@ -1035,8 +1040,28 @@ int snd_component_add(struct snd_card *card,
> const char *component)
>                          return 1;
>          }
>          if (strlen(card->components) + 1 + len + 1 > sizeof(card-
>> components)) {

I don't think that it's the right place to do the striping here. Just keep the 
full string in snd_card structure and handle the split/trim in 
snd_ctl_card_info().

The new ioctl should return the full components string.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.


