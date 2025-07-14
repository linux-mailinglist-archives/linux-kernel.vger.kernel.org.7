Return-Path: <linux-kernel+bounces-730180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9CB04114
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAB31890D94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907D2550AD;
	Mon, 14 Jul 2025 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN939bm/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683024678C;
	Mon, 14 Jul 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502216; cv=none; b=kbK77ogpZBee/GW6zWWuLjTrURDMJ5cpGjIZp0X9m4zCPLKbln+1I1jko6zrAyaxas17pddpWXCtMXFEWUqHOC5h8XCpzj/8kETb1SL36aaqSGh9c0NKd42yfISXfKFpOFMeln06mpX4EYkHvrZo4uv0lExekZtbQ6eDQVo6QYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502216; c=relaxed/simple;
	bh=naC2vB5VdPl02OdoXhmjHRnsIRMtNYgzq1zhGsnWmJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvpYDzFJo4j8E2L97nmuxI3OXuCQMlRfwgcJwMZHEu4xuP1NGgLSlv2Hy7QSawbqRqKOpqgwd2cvKdz6Yt0MObo/NA75K8im5Xh2pqBsXsQTascg+pTVPxopeD8Vy8S84NzD0j2iKet2EgnXbnq146P09htgYEI0kci8yvzwRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN939bm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD5C4CEED;
	Mon, 14 Jul 2025 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502215;
	bh=naC2vB5VdPl02OdoXhmjHRnsIRMtNYgzq1zhGsnWmJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KN939bm/glOX+rZomGFqIPS3j+XtkBtc95plwPLjufw11KnoKSxb5oSs0LidzGVoZ
	 XJgKlS3eEtw/x8fneo50Ufg5O+RnOLa6OEDdLIScmEBjc3XNem6/TZ/vl/FfAY7UnZ
	 VLLyeq7atX8L7dTTe35/VfkPJ2vlwCe6ulqbu6W0WBZINi7HalLSH3QQC36DLMzES+
	 AWh369+5V7jV8bHGmevEOSFEOIY3iqGA50FyHY2TBoE6MtiAj/wZyxtOljIuTrh0Fc
	 SbKKYn1YfbAwOGVdqZukv8vPw5o5VSfVr5y0zykfvO1WoomrkD5m+eVtt8BsJvz2Md
	 tUdFdRVH1qWhQ==
Message-ID: <5b333571-7fa8-4581-9f9c-e5546590cbd9@kernel.org>
Date: Mon, 14 Jul 2025 16:10:12 +0200
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
 <62871f1b-85aa-4d8c-82a1-2fb65be83094@kernel.org>
 <175250123216.21445.8438057789120013393@lain.khirnov.net>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <175250123216.21445.8438057789120013393@lain.khirnov.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Jul-25 15:53, Anton Khirnov wrote:
> Quoting Hans de Goede (2025-07-14 15:27:58)
>>>> Based on other laptops I would expect this to maybe need to be
>>>> KEY_KBDILLUMTOGGLE, which toggles the kbd backlight on/off ?
>>>
>>> Keyboard backlight is Fn+F7 on this laptop. That said, I'm fine with any
>>> key that is acceptable to you and/or other maintainers.
>>
>> Ok, so no KEY_KBDILLUMTOGGLE then if that already is at Fn+F7
>>
>> So lets stick with a KEY_PROG# option here,
>> note asus-nb-wmi already used PROG# for:
>>
>>         { KE_KEY, 0x38, { KEY_PROG3 } }, /* Armoury Crate */
>>         { KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
>>         { KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
>>         { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
>>         { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow */
>>  
>> I guess you checked that this laptop does not send the 0x83 / "Armoury Crate"
>> events? What about 0x86 / "MyAsus"? If there is no MyAsus key I would prefer
>> to use KEY_PROG1 here.
> 
> That is sent by this laptop as Fn+F12, which is why I started at PROG2.
> 
>> Or you can add a KEY_FN_SPACE to input-event-codes.h grouping it together
>> with the existing Fn + X combos there.
> 
> I wasn't sure how big of a deal adding new KEY_ values is. If that isn't
> too much of a hassle, I can do that and that takes care of Fn+space/f
> consistently.

It shouldn't be too much of a hassle and it indeed would be consistent,
so that sounds good.

> 
>>>>> +	{ KE_KEY, 0xCA, { KEY_F14 } }, /* Noise cancelling on Expertbook B9 */
>>>>
>>>> KEY_SOUND ?
>>>
>>> Can do, but then what about the fn+ version? Ideally they should be
>>> related.
>>
>> Hmm, can use KEY_PROG3 + KEY_PROG4, assuming that the Fn+ spacebar becomes
>> KEY_PROG1 and that KEY_PROG3 / PROG4 are otherwise free ?
>>
>> If not then why start at KEY_F14 and not at KEY_F13, does this laptop's
>> keyboard has a key which sends:
>>
>>
>>         { KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
>>
>> Also are there no conflicts with some of the other entries which send
>> F14 / F15 ?
>>
>> As in no other keys which generate the existing codes mapped
>> to F13 / F14 / F15 ?
> 
> The reason I picked F14 is that the key is physically located two keys
> to the right of F12.

> do either F13/F14, or PROG2/3.

Lets do F13/F14 then.



> 
> For posterity, here's a list of all codes sent by this laptop:
> * {up,down,left,right}: ACPI button/{up,down,left,right} (in addition to normal ATK event)
> * fn-{up,down,left,right}: ATK {PgUp,PgDown,Home,End}
> * copilot key (right of AltGr): ATK shift+win+F17
>   press+release (immediately, releasing the physical key does nothing)
> * fn-lctrl: ATK compose (menu)
> * fn-space: WMI unknown key 0x5b
> * fn-b: ATK pause (scancode 0xc5)
> * fn-p: ATK pause (scancode 0xc6)
> * fn-k: ATK scrolllock
> * fn-f: WMI unknown key 0x9d (supposed to be "asus intelligent performance")
> * fn-a: no event visible anywhere
> * fn-esc: toggles between fn/f keys being primary, sends no visible keys except ACPI event
> * fn-(1-4): WMI scancode 0x61-0x64 (switch video mode);
>   also ACPI video/switchmode event identical for all 4 keys
> * fn-(f1/f2/f3): ATK mute/voldown/volup + ACPI button/{mute,volumedown,volumeup}
> * fn-f4/f5: ACPI brightness down/up
> * fn-f6: WMI scancode 0x6b - F21
> * fn-f7: keyboard backlight, sends no visible keys anywhere except ACPI event
> * fn-f8: ATK win+p
> * fn-f9: ATK win+l
> * fn-f10: no event visible anywhere
> * fn-f11: ATK win+shift+s
> * fn-f12: WMI prog1 (scancode 0x86) + ACPI button/prog1
> * mic-mute: WMI F20 (scancode 0xbe) + ACPI button/f20
> * mic noise key (right of mic-mute): WMI scancode 0xca; fn- sends 0xcb
> * fn-del: insert

Thank you.

Regards,

Hans



