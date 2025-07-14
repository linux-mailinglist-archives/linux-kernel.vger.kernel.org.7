Return-Path: <linux-kernel+bounces-729993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD7B03ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D5E3A287B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F593248881;
	Mon, 14 Jul 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwWLeaSO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAD420AF67;
	Mon, 14 Jul 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496450; cv=none; b=fVVg1n8oakeNsEbQxlZwxuivj1Srw2NxtzaCAI779f35KE/IoM2yFnJGQ+kwZdyNbJxfEPIMzzkOK5Vjys9pBc5Qea00LJvSWwAXpHZrVOKWwTddalySCfdsHNsxG/SG/D0/riM1fn3TQq4DCzzQEBrUvRChO+kU2KgQ3D4RFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496450; c=relaxed/simple;
	bh=HM7lPTcOhP0g5tlLdGyYh/Y1WZWK13CH4tkWaNRrCdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGVENv01mxFp5wSuSWj5OcyOGoVyp88ubs34OR4As3DQEGtjZtItUKfwGIc7GA1KUs8Fg3ANp2VrTlcH0FDcAKZs3dwT2atX4MpTdql0IUw/tERhFqyKjKJOyoV/4mmSmROX6feTS3dhJh6ngMOfsTojgSJZq6YvGFWDA6SGI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwWLeaSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A51C4CEED;
	Mon, 14 Jul 2025 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752496449;
	bh=HM7lPTcOhP0g5tlLdGyYh/Y1WZWK13CH4tkWaNRrCdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwWLeaSOAe32DRkRPl9Y0CkELkFPEvsDIB6wcdvds+AwRgRw6RtzVF/hb/I6OcKw8
	 J6fGpnRIeG97nAyHzb+pWv8x8Db0nj4QI87/+jiOipx++JZugyDej3FOCkM0jR18n/
	 Pp1sGwgGA28pa9wL2uM0s+e8xKNzIvKuS455LznRsCK3iV2mzKtHcp81+ExaGVdy9q
	 neSyZR7Miit5VhhxBCKXYKr/lFXgsM0Y6Fg2CmyUDk5VszGstR05T15BXl82hRMcPy
	 UCuOA7BrmB0NsnfOju50OQ6HGP/xXLeSGefAcC0Iw+xPMyFYLsL1DauSLshUw2DuYp
	 ABgBInkuM1irA==
Message-ID: <4a828765-abf0-4b19-95c8-bfde01d7026d@kernel.org>
Date: Mon, 14 Jul 2025 14:34:04 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250702070231.2872-1-anton@khirnov.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Jul-25 09:02, Anton Khirnov wrote:
> * there is a dedicated "noise cancel" key in top row, between mic mute
>   and PrintScreen; it sends 0xCA when pressed by itself (mapped to F14),
>   0xCB with Fn (mapped to F15)
> * Fn+f sends 0x9D; it is not documented in the manual, but some web
>   search results mention "asus intelligent performance"; mapped to PROG2
> * Fn+space sends 0x5B; it is not documented or mentioned anywhere I
>   could find; mapped to PROG3
> 
> Signed-off-by: Anton Khirnov <anton@khirnov.net>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 3f8b2a324efd..42d7b435ba63 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -573,6 +573,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0x55, { KEY_CALC } },
>  	{ KE_IGNORE, 0x57, },  /* Battery mode */
>  	{ KE_IGNORE, 0x58, },  /* AC mode */
> +	{ KE_KEY, 0x5B, { KEY_PROG3 } }, /* Fn+space */

What is this key-combo supposed to do, is there any icon for this on
the spacebar? What does it do under Windows?

Based on other laptops I would expect this to maybe need to be
KEY_KBDILLUMTOGGLE, which toggles the kbd backlight on/off ?

>  	{ KE_KEY, 0x5C, { KEY_F15 } },  /* Power Gear key */

Why KEY_F15, Why not some other KEY_ ? Generally speaking
the key-code send should match the intended purpose of
they key / key-combo. E.g. If the button opens
the control-panel under Windows use KEY_CONTROLPANEL

>  	{ KE_KEY, 0x5D, { KEY_WLAN } }, /* Wireless console Toggle */
>  	{ KE_KEY, 0x5E, { KEY_WLAN } }, /* Wireless console Enable */
> @@ -609,6 +610,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0x93, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + DVI */
>  	{ KE_KEY, 0x95, { KEY_MEDIA } },
>  	{ KE_KEY, 0x99, { KEY_PHONE } }, /* Conflicts with fan mode switch */
> +	{ KE_KEY, 0X9D, { KEY_PROG2 } }, /* Fn+f */

Same remark as on the other keys. what does this do under Windows ?

>  	{ KE_KEY, 0xA0, { KEY_SWITCHVIDEOMODE } }, /* SDSP HDMI only */
>  	{ KE_KEY, 0xA1, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + HDMI */
>  	{ KE_KEY, 0xA2, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + HDMI */
> @@ -623,6 +625,8 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
> +	{ KE_KEY, 0xCA, { KEY_F14 } }, /* Noise cancelling on Expertbook B9 */

KEY_SOUND ?

> +	{ KE_KEY, 0xCB, { KEY_F15 } }, /* Fn+noise-cancel */

What does Fn + noise-cancel do under Windows ?

>  	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>  	{ KE_IGNORE, 0xCF, },	/* AC mode */
>  	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */


Regards,

Hans



