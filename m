Return-Path: <linux-kernel+bounces-730071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294CB03FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B8C3B7BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F324EA85;
	Mon, 14 Jul 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEdO+sxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA324E4C6;
	Mon, 14 Jul 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499681; cv=none; b=fvwFlp0U9KB5PNpVRIf0YSYOsEAY1FzHqpEixU/njHeE6seE1CvEF+HL2wckWQ3dczwoCbvPpTSG0NtAaQ403I8txr5tj8xwn811ayWGC+2cmgDasx6JRZoXT+L0kyqDtcgyuAmPSlHjRUqHkLwhm4NSXqkzWkbHz/hV/qZVFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499681; c=relaxed/simple;
	bh=8bEhy2TEkvnvrKQy2Z5PmafsXnBLEL6fa+aDuODNJsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2dFgtUwvRnwPW/sGPDUZcjeMqIVAW4I8czIz4CtEzJCCUtWnARcdnKVuM8A73Jk9Ox/0n5MV2M4CjL2I6WdaPHEQoke0IcRJzz49JTOZfAmIi7vtgiJNj+ZdJHCu1dqhOXogP7hlTXtyKfnA4pLAcgiI/cq1Z0MfXSMAluWl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEdO+sxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E465BC4CEED;
	Mon, 14 Jul 2025 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499681;
	bh=8bEhy2TEkvnvrKQy2Z5PmafsXnBLEL6fa+aDuODNJsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lEdO+sxXZsCoFYRRe2RWBuqbW4o0uom2ic3hqCbFh7g9XOPy8b2QO+xG2+the9qGG
	 bkIvph7agRTz4Bz/tbU1gmm42sg4KSHWh+qEHSvVtbGsdn4M0A7gSOAW+jhSlDbRWv
	 2FMV68JJWvdaOv+SRp6aLn7Z1KRSPCeFbDRvfqUCtbQIaooSU3HVkG2yKGjymF2ooK
	 gWDZz79m8gvUCaEbUjoS0T/sXjeD9MIauJe6fXsetWMjpOe6pkdDPzQIdxdGpBszh6
	 SJyc8yGoej9bxQlnKQ8mH66JuRo+AA1rj2yKQfmFNrtpKyZ31XSokIsTiyhadE85F/
	 a1tAI8UKjRIAQ==
Message-ID: <62871f1b-85aa-4d8c-82a1-2fb65be83094@kernel.org>
Date: Mon, 14 Jul 2025 15:27:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: map more keys on ExpertBook B9
To: Anton Khirnov <anton@khirnov.net>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702070231.2872-1-anton@khirnov.net>
 <4a828765-abf0-4b19-95c8-bfde01d7026d@kernel.org>
 <175249787152.21445.16925102541286211351@lain.khirnov.net>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <175249787152.21445.16925102541286211351@lain.khirnov.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Jul-25 14:57, Anton Khirnov wrote:
> Hi Hans,
> Quoting Hans de Goede (2025-07-14 14:34:04)
>> Hi,
>>
>> On 2-Jul-25 09:02, Anton Khirnov wrote:
>>> * there is a dedicated "noise cancel" key in top row, between mic mute
>>>   and PrintScreen; it sends 0xCA when pressed by itself (mapped to F14),
>>>   0xCB with Fn (mapped to F15)
>>> * Fn+f sends 0x9D; it is not documented in the manual, but some web
>>>   search results mention "asus intelligent performance"; mapped to PROG2
>>> * Fn+space sends 0x5B; it is not documented or mentioned anywhere I
>>>   could find; mapped to PROG3
>>>
>>> Signed-off-by: Anton Khirnov <anton@khirnov.net>
>>> ---
>>>  drivers/platform/x86/asus-nb-wmi.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
>>> index 3f8b2a324efd..42d7b435ba63 100644
>>> --- a/drivers/platform/x86/asus-nb-wmi.c
>>> +++ b/drivers/platform/x86/asus-nb-wmi.c
>>> @@ -573,6 +573,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>>  	{ KE_KEY, 0x55, { KEY_CALC } },
>>>  	{ KE_IGNORE, 0x57, },  /* Battery mode */
>>>  	{ KE_IGNORE, 0x58, },  /* AC mode */
>>> +	{ KE_KEY, 0x5B, { KEY_PROG3 } }, /* Fn+space */
>>
>> What is this key-combo supposed to do, is there any icon for this on
>> the spacebar? What does it do under Windows?
> 
> I don't have Windows installed, so I cannot test what any of these keys
> do there.
> 
> I searched the web for any mentions of this key combination and found
> nothing whatsoever, the manual is also silent. But it does generate an
> event, so it seemed reasonable to make use of it.
>
>> Based on other laptops I would expect this to maybe need to be
>> KEY_KBDILLUMTOGGLE, which toggles the kbd backlight on/off ?
> 
> Keyboard backlight is Fn+F7 on this laptop. That said, I'm fine with any
> key that is acceptable to you and/or other maintainers.

Ok, so no KEY_KBDILLUMTOGGLE then if that already is at Fn+F7

So lets stick with a KEY_PROG# option here,
note asus-nb-wmi already used PROG# for:

        { KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
        { KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
        { KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
        { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
        { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow */
 
I guess you checked that this laptop does not send the 0x83 / "Armoury Crate"
events? What about 0x86 / "MyAsus"? If there is no MyAsus key I would prefer
to use KEY_PROG1 here.

Or you can add a KEY_FN_SPACE to input-event-codes.h grouping it together
with the existing Fn + X combos there.

> 
>>
>>>  	{ KE_KEY, 0x5C, { KEY_F15 } },  /* Power Gear key */
>>
>> Why KEY_F15, Why not some other KEY_ ? Generally speaking
>> the key-code send should match the intended purpose of
>> they key / key-combo. E.g. If the button opens
>> the control-panel under Windows use KEY_CONTROLPANEL
> 
> Err I'm not doing anything to this one.

My bad, sorry.

>>> @@ -609,6 +610,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>>  	{ KE_KEY, 0x93, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + DVI */
>>>  	{ KE_KEY, 0x95, { KEY_MEDIA } },
>>>  	{ KE_KEY, 0x99, { KEY_PHONE } }, /* Conflicts with fan mode switch */
>>> +	{ KE_KEY, 0X9D, { KEY_PROG2 } }, /* Fn+f */
>>
>> Same remark as on the other keys. what does this do under Windows ?
> 
> As per above, cannot test. But in this case a web search suggests that
> (on some other Asus laptop) it switches between performance profiles.

You can use KEY_FN_F for this one then.

>>> @@ -623,6 +625,8 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>>>  	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
>>>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>>>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>>> +	{ KE_KEY, 0xCA, { KEY_F14 } }, /* Noise cancelling on Expertbook B9 */
>>
>> KEY_SOUND ?
> 
> Can do, but then what about the fn+ version? Ideally they should be
> related.

Hmm, can use KEY_PROG3 + KEY_PROG4, assuming that the Fn+ spacebar becomes
KEY_PROG1 and that KEY_PROG3 / PROG4 are otherwise free ?

If not then why start at KEY_F14 and not at KEY_F13, does this laptop's
keyboard has a key which sends:


        { KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */

Also are there no conflicts with some of the other entries which send
F14 / F15 ?

As in no other keys which generate the existing codes mapped
to F13 / F14 / F15 ?
 
>>> +	{ KE_KEY, 0xCB, { KEY_F15 } }, /* Fn+noise-cancel */
>>
>> What does Fn + noise-cancel do under Windows ?
> 
> As per the manual:
> 
>   Built-in microphone: Toggles between single presenter conference call
>                        mode or multi presenter conference call mode.
>   External microphone: Toggles ASUS AI Noise-Canceling.

Thanks.

Regards,

Hans


