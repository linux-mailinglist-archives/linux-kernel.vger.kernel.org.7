Return-Path: <linux-kernel+bounces-892232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923DC44AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7221889D34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFA14A4CC;
	Mon, 10 Nov 2025 00:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aughLfWz"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABF2BB13;
	Mon, 10 Nov 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762732941; cv=none; b=XWKR6d0LoAxk7p2++rmDkNT++qsvCIpM1chpg44Ya2BfPbQyTFRophQj+/RhGJRLjFcoHiUUapa6/uocatIGtKeaRebSbHrC9OafROCvNgvxALEVmoo3Su9UYKwBT6zjHDVnoMwh3WzxYEXd1NGfJRm//udW+JhosVR81kaDyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762732941; c=relaxed/simple;
	bh=y1jMFRyCKgL+2eySOLnLlaTjTcCWC3KFm0JuJyOoyOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6Gs/528ZAhVLnV6dA93dOADXHPWpg8H89VlZrklhp33XRxHAbxrVhLuv3YngiMv6vJklC8PQrYWModjNhPHAp3xdDRoVemHY+gJ4XfPqGmZdUCW2CFPsohNsoiOjGq9AjkeCx7sBelaz9eTmj1bmkRIDoUyukuVnnKhHK3Ln2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aughLfWz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762732926; x=1763337726; i=w_armin@gmx.de;
	bh=F9qjRrMtzp8T2rDv7S95wGwx/DKJTR4Z/kvAF1ahX3k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aughLfWzghGER70brOGunqYdxrTNpBDtLSIHniF4YGNXyovJQJDBS8fqQnE1GVLe
	 XvzHse7dY6Y30ghEQtD08/EISYBKtjbPbuaeFXye/gpWwZ57lrfzNLv3cVw6Cwy9w
	 JuNuPn532WF96jMZOS/zHd2MP3wZOpDSm4TXne3VIgiM6bMniQZ0HO8ZQEeqlVArx
	 B1wLT+Dvaotr+mEauB1BAwkLr8FZwBgE78GT677/BMHsE3kteaYfQmLYPf8u2Ufyo
	 oGl6ZS5NqdXpArsvOYfWB22e+qmlaQ+xllGDa1MJeYL4+YwMKu3sLxhES1B83Y7pL
	 TSkJfH+yh7XqHBoVSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1vjmcT3Ofk-00KqH7; Mon, 10
 Nov 2025 01:02:05 +0100
Message-ID: <1b41a90b-3583-4543-877a-0925a4e08853@gmx.de>
Date: Mon, 10 Nov 2025 01:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] platform/x86: lenovo-wmi-{capdata,other}: Support
 multiple Capability Data
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20251031155349.24693-1-i@rong.moe>
 <20251031155349.24693-4-i@rong.moe>
 <8c14706f-f3cc-45e9-bdef-db2c9171f46e@gmx.de>
 <dd93f38bc0129b4b75e2dbde676d402376bc301c.camel@rong.moe>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <dd93f38bc0129b4b75e2dbde676d402376bc301c.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m6NvvspB4HsPXt/NbiJJPfZ1bnEkpQX4Q7Y0/y8RJKp6Qk3Ugj3
 NoSbCphoqmG8JjrgfyB8sUYCwV8Kb8Xp3CI3gCdk3zHAG5ti7BcB4WNVTjYjw/BX7snym18
 bjWMROhLe9K1nY/OK3oYthVY9l/dMV7fwwiC97pDjM4351m7ZbWwdufh/ZVx5o/5uzytx4d
 dX1GBJMd6YXE0Y4mXemcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ivCkMX9qS5E=;cL6zpHw/GUYEpSldsowzNXAFgk3
 RNyZx1wjd5FhY0F7TZKRAYhcHdjElpQZXWmRuGjWR4u66l/5wUsq+Kmejq+V38IY4I/MBIKiZ
 Hq3G5j5REzT9ZTh3rUGz//SwUa4u1vtxwxfgPVrmj99AucZ7EkCp+MPJClylD1gfi3OCIhnah
 0h4BO6WPYVA14ZdyRDnqcrMbQ9LBL9f017KtaN5bs+5cWtkuhmnKZGgioVoPcGedu5+WySV9p
 vU3LKFW7V8jtaZ8gRwuoGXBwhd+G1/0k2xzke9h39X9Ym1AvjCL61CGg9dtmxnUotu6Xpfepj
 jUUs1mfUJa64BenL31JM2hjmCdqgnts/XskSmd92dGpR/wk1OgNSOY+qxDc7UhcQncFx9KPlR
 VBK0BeWDn4GpKSoPmZduK0+roUiTNP6Mbm/Hl2rlqBDWJh4R42jHaLbVD2RBLOAfTHYhjE2LS
 EPXlkcJYd+Ttl8od1KfWNpRNzKisE9SWXcjzlzejRiH2EiI36FOQH8zxNEoE7JsRluYUjUDJc
 dirxD6fAXXgzEin1XEZm61q1JfoWvZy+fEABVMfxAIq+kQtz0OiuNfrHzw2NRYK7cvt6TWz1z
 wthlDAxecdcxhqNcJROanJVZMaxHtuRWg7AVZse9WouM6lR1atP38bza9QEy/cAbU5S5MUE2t
 sqFiGNW/EzkfHU4/EGkmgnUR/clAkErWeBJeLAWOw1gXXCFThC4s9qHwBsHiUd6q3i96g+6tT
 nRZ4DjAHdbyykT7lIoEiqdNN3kTkGBQxfg3mfngQTTurO5hpyGbOgpbVoGr21QbbWyK9QIdqz
 FIX0NrWQHpYZ1H3dtx/9DS9HuFebyqTfptO3AqoyJrjklvR1nX/QYlC/HCFKJs4fgTq9Fk46W
 xV+vm7BPA35GkVVjkZTQkljHnuJh1bU+yR1WcxDNqxqcqbDmZfczODUJyWeBUFCbjgfqWevma
 IAnnQyNESeE4Y4ZvnbBb0TmXf9CuHRUUCqRF3wigr51wFn/Mu49b8ieIcD+53XWpfPoEAG1/i
 cQ96RJgyTqgPtDenKXHxsrTUsewF+ezsgcoKHK8e+q6mtq4LAYV+pPGhyvYeQcCjyqoFsD9EM
 K7Wiq+mWl+Tc3T4yGR01G5qZFco5TniEmz6ggdeWnyUiKYpxJSdVEL6qXrEQzd/bsinpMkK2w
 33xv14pZB7spCposFo+pbfyVfcORDhoS2/XWKO1NtKkBqjWC4VndbesWFiPSmpip7elEGIjx2
 yUclFo/CVsmPLLkszSUHQT7NdZaOaOO8cbIaMGdx7Q1BkvqsIcFYT9a3JMImawgrY7CRsMYDc
 bd46skY8k6G8AZ4fNkF00xVT+wBrGVq78wDc+x0ldO0yKZfOQapgg9e4tydoPZdTZRxcwUb8o
 9E20JrTwtnxn3uYDzrse0MOol3LBzpDWowyFK8XlOhqR8A1Q38LXDx9eZueGAzaTG/ehno324
 sw3NR1tbLf4M/nATjrnDdyUBeR3poAfTFtQdyKaAvxFsowa7BKrdLBK6P7dkow8HAiL4KxaWJ
 OCD/qUZAqM3NCf2leDqurV5l7Od43uhwF+EuJrMzYRuJZTRFSogV87HfusQ5hT25L2qAWBmVi
 +0k7mCAKMURqVAwdxu5ryq3c8dOPo9w59MS+mTAFDSECz9ELGcqAC3lzfYXG4LNqLo5RcLCuq
 Y4mAHXG8gyCo87X2YgQQ+BFfhoEM4uOso66Y+lB6olM2MfQaco5WfscnCTlFv9LrqlXGJlm+y
 k9TEAh90SkQkiHKfvvNxXT+NtcLluPQMpfthlyFpR07d/4sZ3DM9amS3IUM0iRCm2KhXXW7qW
 L4uur5VGCJhKb2n9i61BWc9+K7qzIc8ZuJJucfULTRBqf2aXlgX7Qi8exSTs/vNildEWW4MTw
 i+z/8tiTrqDEozF5wiDyasdFDj26wlcST9gjY7NJzc2cCqle3xsCZxNTtRPEzkut1TniDHpFq
 iPk4JZE7kntBTp7l1ob5rS/q7VagQkVbOb7esqTqBMx5ssH6C6p+OFavy+zrqW59vOyPAZtSY
 9LM3iNchXlHn0OVsHqocKkkBgDD5nqvcOkjEvUF1/VPWUnSgairaROzfaQzTll/pU6DubkHnG
 0wAm4g9ghwAkaWb1leYwvj1djhojGbuoMyE1ZtvdMunq94iuuOEJKy+SA6gl0QWRVVw0VEXke
 dlsgmdiVOodlT00qPD12V3XwZgCrigAv0GAbyM7GjDSPB63sjoQin3dKHsKJcxjn4JZ/uVoIf
 /IEzbM4sZaTuEBp95iMI/VoWn+rifZjLK1E3/B+pO3KRY+VOV7+2gfqcTd2F35b4WbXIxhu0P
 +/QqNUCFUev52cGb0zKQ4N97GMir20In6bJyax3ubBjywED9XK+009IFIAPOj6NGECfE5K6Zx
 zbZKrANFDbtgQVIPW/5arDHVS0tBwlRubchA4NL0uZ01+TlIXUT0u80EaGIt5T2orw7v+w9zr
 sot/6XYWapbi99gk5R9AA1E3hKjN4xOiqyNT6FY1qGEBySOsflcPXtOahoNsOUSwPpaTzmEvQ
 pAL4A7sovZW5nV4F4T36dtl/Syqofabl5Clr95PE01uqiwxxt9je8iLt/x+1AZXDMakA3L1b5
 r7j8lPmeC5vrpzTxtyXBf9SZGz1a1J9eANAGozWif6XqsNYtxjW0dzLYRygST/megu4imP6NW
 ZoDCbmpjk3IpvxSO/Oyo7T4I4tghO24Sq0BMMl4l4LYnPhzrLD7WXZsqeVrxovbfaimSLk+U9
 WcjmEIo+qlY2tNCHM3KhEWIcj+rCRlhCUSK5cwujQ6S0HuTpsUNvYr+TzDYcT+Z4qSnAx5Kgc
 WzOWsmEhPhhdfUowYVDRtiFV+KJV2CaKHMoTT1VtKA8q639eLrHSbRcnDgy4auJeOANTR8/R1
 PJB8GwALezC2P2jL6dC4MhoMlEebCY7qtWeSZbHyUxkATgbecwvL+ERHkcts8N7o5HMGCQfRE
 /AJNEFjkcdLJrmQGOzQ1dx99W2vyFKv/2u5m1XfbDGpEe/BiNVRs/W9Viz8m/q3N2mL8tXzEB
 CVv1WoKbuWAzjiznkfz75gfQ1dFqijSMqiSTqSdJqJhpcd9lYwJO6jcwQrVFzI2VKS9e/qRGV
 xRScOyP26aP5Wopbd2m6T91ulVDzQ8nmFH7jUVVAPZC52D4hFAx+JTTioJUkgZo1dCayU6fmw
 HudnlChXKCnsi8Y2HE94cBWM/4pXO7mLjpiCpDsFVTVohG9xpPr0ohUkVClF9pxuNP3tLZM1p
 ACkT32Nq57niJicYgvLJkxYaEiJVxhkHaOuM0ppm5XYtb8bMppvv+5vd8NOjb5f42OCQ637wB
 9TEgzwsGOZTGKP97cIllguaKKSdCIXJvgUpTJze8ZCdHvbA9Kfd9nVcN9Ue2dB0OJjIsYd8Wi
 aJRsDBsvx/DoTn9JvFuYgl8vr1ZekG2U3YVuQhk+zfLs9esc6+OC46ZUNZvJEoN1yFSdUUJ9b
 nmOm14fXtlP8VpyA+fjRP5rmwyoIzVPInnRJPsenNOH8rEsxaz458hkvJHL7whK7qQ5hnVp8b
 xmhBSK5abnhVzFQRaB9pS0KknUvdcS6gMZlVCeoL5rfoNLbKLTAJWx5C9Ya1VfY/wYGt80Mti
 IWj9Jaeahi1M0Vs1c+0R9vCsdRKmkkPX584OEKe/I+xBIzfjezVZXshtYHCekbmHMUzPeqQQt
 jWZGvNDK2p8Tw3op7Qjl0m1F4QW/J9vuUJ7BvfVQTUw6ZPUMUzUq1iu6HQWnHrAB7vcEcs4I1
 aYy+KyIfqH0U0p8zRvH35Fy8BgGrWL6VtbYfBeguykLrDxviQ5OAc94QG0r1uLBrxSSFfgveZ
 c51gPvnPSIFHWbDF/Wf10hpqUZszBEgRDWR7K5gl74FOVkRm/Ck92OvS+7as0+x5/eKi2CCDP
 fNcgC4ZzqjpRFoie5nINul0iEPtBKj8s9h2/6MT8EcG5Bdi02IA3ltSziGT4ZWOhj0DJ3QEGc
 kk+LxwjB/wopm82ikhTXcf7pmS00cP7+YQTbX5Rd87LT3h1XZDNGOnY9i/Noc6F/4OjKNJQMU
 5hHXEPFkGdDM3fLrv/+F0lAqqHNtymBzx57FGYw9nv9IXUv8420EAqTqbHO760Q1+oUwmjTL4
 Slky50Awa4EeaeR4C+OzD0KyY8ZCRIHMzzgI7bRUvdOY4pLjHZU9RIXkISjQkf6Tvtsn9INBS
 DRdsfydYx7oMjOT6dOW4ub1FN6DG8+rQreCu3G6w8IsMNFKTfXvb97CKOSLaFOEFDCSFjulpe
 rM7Xkrs1kTGGK5hK8I/QNJQvqlOHRbuDxe7eBQNhoOYMsCDEKLOeyz/7yQvCzLOF2Ko93TCXl
 J4AgvNuZoZoARM3v4przbs31ngdCQl0TI27M/MpJCBFu0HJW1xcrf15kc32VidLikBUBWkosj
 2E68ktM19x+PmhKKBXDI+IqHxFQBWCATJPcnKwaDMBfqxmnFmqvY0mWloyF8aG7vdUHlosJSH
 UH3DpVze95pVsJXj7azkctfvQh2dbvIXTU5rA4VEUxQS7Rsq8oMuKXeeEpqvStK5RybnJBsn/
 SBWmOIyeZigcQki5hPtLZhps+OSNSHgrYwXYeFfpaj8fw1aTsWIeXP7UAqLUS1gAjyUAz9dkQ
 ewfJiZBcaa7bvBw52NDts3NAtuBmGKzM/ngfYOAsgvrHlL/M/KIxTVi19+hqJ4FWqGsbwuh+E
 MxFJlgGuRbmSzsunAWIlJEBCIefh7dCJMTyafFoPy2yVyOugXGLq53NvBZcRsJmU7KliYJiiK
 R9jCJjkYDZMnBWo6pkg/ehMQwcge4oeZX/Cwj/HptPQYVRyWxOv4GEnqDeT4AUzhuLy3KHlx0
 5yJQO+qYNn+cqjpkLLwhnUnGh7RrU5HyFcyom5Qza9LDClIXBbm9rHtSxDiP+gQf7vu5OYhr/
 x22rMDCStnO4TGdf0vZfhEHbK8i1eBgSyaBoo65RyrIm4kBvGBswpqChqO4GKoDfGCRBhrH62
 LzeiaOsaZbl8P7pUo5F7IQcJ/ONyclLOMSERYH1b/T2uMQ3qdpNKNnVGHqMWdg8bkZHcDlQCz
 FLt+8JNmte5j+h04BsOTFkGligCr7vNUIyHHK8cVGfDaAJeq95p2wj2JXc6GLIBjV14wGz6bS
 S447at/2yyttm0/dIdQw3EQioR++Xl0Az1STyOK2aSc0fYbr22TupzocW8mwUkDbmA6Ryp2Vf
 fjljgmT4=

Am 06.11.25 um 13:36 schrieb Rong Zhang:

> Hi Armin,
>
> On Tue, 2025-11-04 at 21:20 +0100, Armin Wolf wrote:
>> Am 31.10.25 um 16:51 schrieb Rong Zhang:
>>
>>> The current implementation are heavily bound to capdata01. Rewrite it =
so
>>> that it is suitable to utilize other Capability Data as well.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Rong Zhang <i@rong.moe>
>>> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Fix function parameter 'type' not described in 'lwmi_cd_match' (than=
ks
>>>     kernel test bot)
>>> ---
>>>    drivers/platform/x86/lenovo/wmi-capdata.c | 208 +++++++++++++++++--=
=2D--
>>>    drivers/platform/x86/lenovo/wmi-capdata.h |   7 +-
>>>    drivers/platform/x86/lenovo/wmi-other.c   |  27 ++-
>>>    3 files changed, 190 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platf=
orm/x86/lenovo/wmi-capdata.c
>>> index c5e74b2bfeb3..1f7fc09b7c3f 100644
>>> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
>>> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
>>> @@ -12,8 +12,13 @@
>>>     *
>>>     * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
>>>     *   - Initial implementation (formerly named lenovo-wmi-capdata01)
>>> + *
>>> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
>>> + *   - Unified implementation
>>>     */
>>>   =20
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>>    #include <linux/acpi.h>
>>>    #include <linux/cleanup.h>
>>>    #include <linux/component.h>
>>> @@ -36,6 +41,25 @@
>>>    #define ACPI_AC_CLASS "ac_adapter"
>>>    #define ACPI_AC_NOTIFY_STATUS 0x80
>>>   =20
>>> +enum lwmi_cd_type {
>>> +	LENOVO_CAPABILITY_DATA_01,
>>> +};
>>> +
>>> +#define LWMI_CD_TABLE_ITEM(_type)		\
>>> +	[_type] =3D {				\
>>> +		.guid_string =3D _type##_GUID,	\
>>> +		.name =3D #_type,			\
>>> +		.type =3D _type,			\
>>> +	}
>>> +
>>> +static const struct lwmi_cd_info {
>>> +	const char *guid_string;
>>> +	const char *name;
>>> +	enum lwmi_cd_type type;
>>> +} lwmi_cd_table[] =3D {
>>> +	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
>>> +};
>>> +
>>>    struct lwmi_cd_priv {
>>>    	struct notifier_block acpi_nb; /* ACPI events */
>>>    	struct wmi_device *wdev;
>>> @@ -44,15 +68,19 @@ struct lwmi_cd_priv {
>>>   =20
>>>    struct cd_list {
>>>    	struct mutex list_mutex; /* list R/W mutex */
>>> +	enum lwmi_cd_type type;
>>>    	u8 count;
>>> -	struct capdata01 data[];
>>> +
>>> +	union {
>>> +		DECLARE_FLEX_ARRAY(struct capdata01, cd01);
>>> +	};
>>>    };
>>>   =20
>>>    /**
>>>     * lwmi_cd_component_bind() - Bind component to master device.
>>>     * @cd_dev: Pointer to the lenovo-wmi-capdata driver parent device.
>>>     * @om_dev: Pointer to the lenovo-wmi-other driver parent device.
>>> - * @data: cd_list object pointer used to return the capability data.
>>> + * @data: lwmi_cd_binder object pointer used to return the capability=
 data.
>>>     *
>>>     * On lenovo-wmi-other's master bind, provide a pointer to the loca=
l capdata
>>>     * list. This is used to call lwmi_cd*_get_data to look up attribut=
e data
>>> @@ -64,9 +92,15 @@ static int lwmi_cd_component_bind(struct device *cd=
_dev,
>>>    				  struct device *om_dev, void *data)
>>>    {
>>>    	struct lwmi_cd_priv *priv =3D dev_get_drvdata(cd_dev);
>>> -	struct cd_list **cd_list =3D data;
>>> +	struct lwmi_cd_binder *binder =3D data;
>>>   =20
>>> -	*cd_list =3D priv->list;
>>> +	switch (priv->list->type) {
>>> +	case LENOVO_CAPABILITY_DATA_01:
>>> +		binder->cd01_list =3D priv->list;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>>   =20
>>>    	return 0;
>>>    }
>>> @@ -76,30 +110,33 @@ static const struct component_ops lwmi_cd_compone=
nt_ops =3D {
>>>    };
>>>   =20
>>>    /**
>>> - * lwmi_cd01_get_data - Get the data of the specified attribute
>>> + * lwmi_cd*_get_data - Get the data of the specified attribute
>>>     * @list: The lenovo-wmi-capdata pointer to its cd_list struct.
>>>     * @attribute_id: The capdata attribute ID to be found.
>>> - * @output: Pointer to a capdata01 struct to return the data.
>>> + * @output: Pointer to a capdata* struct to return the data.
>>>     *
>>> - * Retrieves the capability data 01 struct pointer for the given
>>> - * attribute for its specified thermal mode.
>>> + * Retrieves the capability data struct pointer for the given
>>> + * attribute.
>>>     *
>>>     * Return: 0 on success, or -EINVAL.
>>>     */
>>> -int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct=
 capdata01 *output)
>>> -{
>>> -	u8 idx;
>>> -
>>> -	guard(mutex)(&list->list_mutex);
>>> -	for (idx =3D 0; idx < list->count; idx++) {
>>> -		if (list->data[idx].id !=3D attribute_id)
>>> -			continue;
>>> -		memcpy(output, &list->data[idx], sizeof(list->data[idx]));
>>> -		return 0;
>>> +#define DEF_LWMI_CDXX_GET_DATA(_cdxx, _cd_type, _output_t)					\
>>> +	int lwmi_##_cdxx##_get_data(struct cd_list *list, u32 attribute_id, =
_output_t *output)	\
>>> +	{											\
>>> +		u8 idx;										\
>>> +		if (WARN_ON(list->type !=3D _cd_type))						\
>>> +			return -EINVAL;								\
>>> +		guard(mutex)(&list->list_mutex);						\
>>> +		for (idx =3D 0; idx < list->count; idx++) {					\
>>> +			if (list->_cdxx[idx].id !=3D attribute_id)				\
>>> +				continue;							\
>>> +			memcpy(output, &list->_cdxx[idx], sizeof(list->_cdxx[idx]));		\
>>> +			return 0;								\
>>> +		}										\
>>> +		return -EINVAL;									\
>>>    	}
>>>   =20
>>> -	return -EINVAL;
>>> -}
>>> +DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdat=
a01);
>>>    EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
>>>   =20
>>>    /**
>>> @@ -112,10 +149,21 @@ EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO=
_WMI_CD");
>>>     */
>>>    static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>>>    {
>>> +	size_t size;
>>>    	int idx;
>>> +	void *p;
>>> +
>>> +	switch (priv->list->type) {
>>> +	case LENOVO_CAPABILITY_DATA_01:
>>> +		p =3D &priv->list->cd01[0];
>>> +		size =3D sizeof(priv->list->cd01[0]);
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>>   =20
>>>    	guard(mutex)(&priv->list->list_mutex);
>>> -	for (idx =3D 0; idx < priv->list->count; idx++) {
>>> +	for (idx =3D 0; idx < priv->list->count; idx++, p +=3D size) {
>>>    		union acpi_object *ret_obj __free(kfree) =3D NULL;
>>>   =20
>>>    		ret_obj =3D wmidev_block_query(priv->wdev, idx);
>>> @@ -123,11 +171,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *pr=
iv)
>>>    			return -ENODEV;
>>>   =20
>>>    		if (ret_obj->type !=3D ACPI_TYPE_BUFFER ||
>>> -		    ret_obj->buffer.length < sizeof(priv->list->data[idx]))
>>> +		    ret_obj->buffer.length < size)
>>>    			continue;
>>>   =20
>>> -		memcpy(&priv->list->data[idx], ret_obj->buffer.pointer,
>>> -		       ret_obj->buffer.length);
>>> +		memcpy(p, ret_obj->buffer.pointer, size);
>>>    	}
>>>   =20
>>>    	return 0;
>>> @@ -136,20 +183,28 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *pr=
iv)
>>>    /**
>>>     * lwmi_cd_alloc() - Allocate a cd_list struct in drvdata
>>>     * @priv: lenovo-wmi-capdata driver data.
>>> + * @type: The type of capability data.
>>>     *
>>>     * Allocate a cd_list struct large enough to contain data from all =
WMI data
>>>     * blocks provided by the interface.
>>>     *
>>>     * Return: 0 on success, or an error.
>>>     */
>>> -static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>>> +static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type=
 type)
>>>    {
>>>    	struct cd_list *list;
>>>    	size_t list_size;
>>>    	int count, ret;
>>>   =20
>>>    	count =3D wmidev_instance_count(priv->wdev);
>>> -	list_size =3D struct_size(list, data, count);
>>> +
>>> +	switch (type) {
>>> +	case LENOVO_CAPABILITY_DATA_01:
>>> +		list_size =3D struct_size(list, cd01, count);
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>>   =20
>>>    	list =3D devm_kzalloc(&priv->wdev->dev, list_size, GFP_KERNEL);
>>>    	if (!list)
>>> @@ -159,6 +214,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv=
)
>>>    	if (ret)
>>>    		return ret;
>>>   =20
>>> +	list->type =3D type;
>>>    	list->count =3D count;
>>>    	priv->list =3D list;
>>>   =20
>>> @@ -168,6 +224,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv=
)
>>>    /**
>>>     * lwmi_cd_setup() - Cache all WMI data block information
>>>     * @priv: lenovo-wmi-capdata driver data.
>>> + * @type: The type of capability data.
>>>     *
>>>     * Allocate a cd_list struct large enough to contain data from all =
WMI data
>>>     * blocks provided by the interface. Then loop through each data bl=
ock and
>>> @@ -175,11 +232,11 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *pr=
iv)
>>>     *
>>>     * Return: 0 on success, or an error code.
>>>     */
>>> -static int lwmi_cd_setup(struct lwmi_cd_priv *priv)
>>> +static int lwmi_cd_setup(struct lwmi_cd_priv *priv, enum lwmi_cd_type=
 type)
>>>    {
>>>    	int ret;
>>>   =20
>>> -	ret =3D lwmi_cd_alloc(priv);
>>> +	ret =3D lwmi_cd_alloc(priv, type);
>>>    	if (ret)
>>>    		return ret;
>>>   =20
>>> @@ -235,9 +292,13 @@ static void lwmi_cd01_unregister(void *data)
>>>   =20
>>>    static int lwmi_cd_probe(struct wmi_device *wdev, const void *conte=
xt)
>>>    {
>>> +	const struct lwmi_cd_info *info =3D context;
>>>    	struct lwmi_cd_priv *priv;
>>>    	int ret;
>>>   =20
>>> +	if (!info)
>>> +		return -EINVAL;
>>> +
>>>    	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>>    	if (!priv)
>>>    		return -ENOMEM;
>>> @@ -245,21 +306,34 @@ static int lwmi_cd_probe(struct wmi_device *wdev=
, const void *context)
>>>    	priv->wdev =3D wdev;
>>>    	dev_set_drvdata(&wdev->dev, priv);
>>>   =20
>>> -	ret =3D lwmi_cd_setup(priv);
>>> +	ret =3D lwmi_cd_setup(priv, info->type);
>>>    	if (ret)
>>> -		return ret;
>>> +		goto out;
>>>   =20
>>> -	priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
>>> +	if (info->type =3D=3D LENOVO_CAPABILITY_DATA_01) {
>>> +		priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
>>>   =20
>>> -	ret =3D register_acpi_notifier(&priv->acpi_nb);
>>> -	if (ret)
>>> -		return ret;
>>> +		ret =3D register_acpi_notifier(&priv->acpi_nb);
>>> +		if (ret)
>>> +			goto out;
>>>   =20
>>> -	ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_unregister, &=
priv->acpi_nb);
>>> -	if (ret)
>>> -		return ret;
>>> +		ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_unregister,
>>> +					       &priv->acpi_nb);
>>> +		if (ret)
>>> +			goto out;
>>> +	}
>>> +
>>> +	ret =3D component_add(&wdev->dev, &lwmi_cd_component_ops);
>>>   =20
>>> -	return component_add(&wdev->dev, &lwmi_cd_component_ops);
>>> +out:
>>> +	if (ret) {
>>> +		dev_err(&wdev->dev, "failed to register %s: %d\n",
>>> +			info->name, ret);
>>> +	} else {
>>> +		dev_info(&wdev->dev, "registered %s with %u items\n",
>>> +			 info->name, priv->list->count);
>>> +	}
>>> +	return ret;
>>>    }
>>>   =20
>>>    static void lwmi_cd_remove(struct wmi_device *wdev)
>>> @@ -267,8 +341,12 @@ static void lwmi_cd_remove(struct wmi_device *wde=
v)
>>>    	component_del(&wdev->dev, &lwmi_cd_component_ops);
>>>    }
>>>   =20
>>> +#define LWMI_CD_WDEV_ID(_type)				\
>>> +	.guid_string =3D _type##_GUID,			\
>>> +	.context =3D &lwmi_cd_table[_type]
>>> +
>>>    static const struct wmi_device_id lwmi_cd_id_table[] =3D {
>>> -	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
>>> +	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
>>>    	{}
>>>    };
>>>   =20
>>> @@ -284,21 +362,61 @@ static struct wmi_driver lwmi_cd_driver =3D {
>>>    };
>>>   =20
>>>    /**
>>> - * lwmi_cd01_match() - Match rule for the master driver.
>>> - * @dev: Pointer to the capability data 01 parent device.
>>> - * @data: Unused void pointer for passing match criteria.
>>> + * lwmi_cd_match() - Match rule for the master driver.
>>> + * @dev: Pointer to the capability data parent device.
>>> + * @type: Pointer to capability data type (enum lwmi_cd_type *) to ma=
tch.
>>>     *
>>>     * Return: int.
>>>     */
>>> -int lwmi_cd01_match(struct device *dev, void *data)
>>> +static int lwmi_cd_match(struct device *dev, void *type)
>>> +{
>>> +	struct lwmi_cd_priv *priv;
>>> +
>>> +	if (dev->driver !=3D &lwmi_cd_driver.driver)
>>> +		return false;
>>> +
>>> +	priv =3D dev_get_drvdata(dev);
>>> +	return priv->list->type =3D=3D *(enum lwmi_cd_type *)type;
>>> +}
>>> +
>>> +/**
>>> + * lwmi_cd_match_add_all() - Add all match rule for the master driver=
.
>>> + * @master: Pointer to the master device.
>>> + * @matchptr: Pointer to the returned component_match pointer.
>>> + *
>>> + * Adds all component matches to the list stored in @matchptr for the=
 @master
>>> + * device. @matchptr must be initialized to NULL. This matches all av=
ailable
>>> + * capdata types on the machine.
>>> + */
>>> +void lwmi_cd_match_add_all(struct device *master, struct component_ma=
tch **matchptr)
>>>    {
>>> -	return dev->driver =3D=3D &lwmi_cd_driver.driver;
>>> +	int i;
>>> +
>>> +	if (WARN_ON(*matchptr))
>>> +		return;
>>> +
>>> +	for (i =3D 0; i < ARRAY_SIZE(lwmi_cd_table); i++) {
>>> +		if (!lwmi_cd_table[i].guid_string ||
>>> +		    !wmi_has_guid(lwmi_cd_table[i].guid_string))
>>> +			continue;
>> I am still not happy about this. AFAIK as soon as the ordinary capdata =
WMI devices are bound together,
>> the firmware tells you whether or not the additional fan data WMI devic=
e is available. Maybe you can do
>> something like this:
>>
>> 1. Bind both capdata WMI devices as usual.
>> 2. Check if a fan data WMI device is available (you can use a DMI-based=
 quirk list for devices were
>>      the firmware reports invalid data).
>> 3. Register an additional component that binds to the fan data WMI devi=
ce.
>> 4. Bind both the additional component and the component registered by t=
he fan data WMI device.
>> 5. Register the hwmon device with additional fan data.
>>
>> If the fan data WMI device is not available, you can simply skip steps =
3 and 4 and simply
>> register the hwmon device with any additional fan data.
>>
>> What do you think?
> I tried your approach. I looks pretty well except for step 4:
>
>     debugfs: 'DC2A8805-3A8C-41BA-A6F7-092E0089CD3B-21' already exists in=
 'device_component'
>
> Moreover, component_[un]bind_all() calls __aggregate_find() with ops =3D=
=3D
> NULL, which implies that it can't really distinguish the two aggregate
> devices we have. Thus, we are rely on the insertion sequence of
> aggregate_devices (see component_master_add_with_match()) to make it
> just work. Pseudo code:
>
>     lwmi_other_probe()
>     {
>     	component_match_add(..., lwmi_cd00_match, ...);
>     	component_match_add(..., lwmi_cd01_match, ...);
>     	component_master_add_with_match(..., &ops1, ...);
>     	component_match_add(..., lwmi_cd_fan_match, ...);
>     	component_master_add_with_match(..., &ops2, ...);
>     }
>    =20
>     lwmi_other_remove()
>     {
>     	/* This just works (TM). */
>     	component_master_del(..., &ops2); /* unbinds cd_fan */
>     	component_master_del(..., &ops1); /* unbinds cd00/01 */
>    =20
>     	/* WARNING: at drivers/base/component.c:589 */
>     	/*
>     	component_master_del(..., &ops1); /* unbinds cd_fan!!! */
>     	component_master_del(..., &ops2); /* unbinds cd_fan!!! */
>     	*/
>     }
>
> It seems that the component framework is not prepared to allow multi-
> aggregation master device.
>
> Since we are talking about the component framework: all efforts we made
> here is to work around one of its limitations -- all components must be
> found or else it won't bring up the aggregate device. Do you think
> allowing partially bound aggregate device a good idea? E.g., adding a
> flag, indicating the master device opts in to such behavior, to the
> definition of struct component_master_ops. I can prepare a separate
> patch for that.
>
> CC'ing maintainers and lists of driver core and component framework.

Oh my, i did not know about this limitation. I think adding support for
optional components will be quite complicated to get right, inside i propo=
se
the following:

The current component master is lenovo-wmi-other, with capdata01 and capda=
ta00
being its components (correct me if i am wrong). Instead of registering an=
 additional
component master on lenovo-wmi-other, how about registering it on capdata0=
0?

Basically when probing, capdata00 will register the component for lenovo-w=
mi-other
and then check whether attribute 0x04050000 indicates support for LENOVO_F=
AN_TEST_DATA
(or a DMI check overrides this). Is yes then capdata00 registers an additi=
onal component
master, otherwise the hwmon device is created right away.
The driver for LENOVO_FAN_TEST_DATA registers a component for capdata00. A=
s soon as the
component master from capdata00 is bound to the component from LENOVO_FAN_=
TEST_DATA, a
hwmon device is created.

Do you thing this would be more feasible than extending the component fram=
ework itself?

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
> Thanks,
> Rong
>
>>> +
>>> +		component_match_add(master, matchptr, lwmi_cd_match,
>>> +				    (void *)&lwmi_cd_table[i].type);
>>> +		if (IS_ERR(matchptr))
>>> +			return;
>>> +	}
>>> +
>>> +	if (!*matchptr) {
>>> +		pr_warn("a master driver requested capability data, but nothing is =
available\n");
>>> +		*matchptr =3D ERR_PTR(-ENODEV);
>>> +	}
>>>    }
>>> -EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD");
>>> +EXPORT_SYMBOL_NS_GPL(lwmi_cd_match_add_all, "LENOVO_WMI_CD");
>>>   =20
>>>    module_wmi_driver(lwmi_cd_driver);
>>>   =20
>>>    MODULE_DEVICE_TABLE(wmi, lwmi_cd_id_table);
>>>    MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>>>    MODULE_DESCRIPTION("Lenovo Capability Data WMI Driver");
>>>    MODULE_LICENSE("GPL");
>>> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platf=
orm/x86/lenovo/wmi-capdata.h
>>> index 2a4746e38ad4..1e5fce7836cb 100644
>>> --- a/drivers/platform/x86/lenovo/wmi-capdata.h
>>> +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
>>> @@ -7,6 +7,7 @@
>>>   =20
>>>    #include <linux/types.h>
>>>   =20
>>> +struct component_match;
>>>    struct device;
>>>    struct cd_list;
>>>   =20
>>> @@ -19,7 +20,11 @@ struct capdata01 {
>>>    	u32 max_value;
>>>    };
>>>   =20
>>> +struct lwmi_cd_binder {
>>> +	struct cd_list *cd01_list;
>>> +};
>>> +
>>>    int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, stru=
ct capdata01 *output);
>>> -int lwmi_cd01_match(struct device *dev, void *data);
>>> +void lwmi_cd_match_add_all(struct device *master, struct component_ma=
tch **matchptr);
>>>   =20
>>>    #endif /* !_LENOVO_WMI_CAPDATA_H_ */
>>> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platfor=
m/x86/lenovo/wmi-other.c
>>> index c6dc1b4cff84..20c6ff0be37a 100644
>>> --- a/drivers/platform/x86/lenovo/wmi-other.c
>>> +++ b/drivers/platform/x86/lenovo/wmi-other.c
>>> @@ -579,14 +579,14 @@ static void lwmi_om_fw_attr_remove(struct lwmi_o=
m_priv *priv)
>>>    static int lwmi_om_master_bind(struct device *dev)
>>>    {
>>>    	struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>>> -	struct cd_list *tmp_list;
>>> +	struct lwmi_cd_binder binder =3D { 0 };
>>>    	int ret;
>>>   =20
>>> -	ret =3D component_bind_all(dev, &tmp_list);
>>> +	ret =3D component_bind_all(dev, &binder);
>>>    	if (ret)
>>>    		return ret;
>>>   =20
>>> -	priv->cd01_list =3D tmp_list;
>>> +	priv->cd01_list =3D binder.cd01_list;
>>>    	if (!priv->cd01_list)
>>>    		return -ENODEV;
>>>   =20
>>> @@ -618,6 +618,7 @@ static int lwmi_other_probe(struct wmi_device *wde=
v, const void *context)
>>>    {
>>>    	struct component_match *master_match =3D NULL;
>>>    	struct lwmi_om_priv *priv;
>>> +	int ret;
>>>   =20
>>>    	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>>    	if (!priv)
>>> @@ -626,12 +627,26 @@ static int lwmi_other_probe(struct wmi_device *w=
dev, const void *context)
>>>    	priv->wdev =3D wdev;
>>>    	dev_set_drvdata(&wdev->dev, priv);
>>>   =20
>>> -	component_match_add(&wdev->dev, &master_match, lwmi_cd01_match, NULL=
);
>>> +	lwmi_cd_match_add_all(&wdev->dev, &master_match);
>>>    	if (IS_ERR(master_match))
>>>    		return PTR_ERR(master_match);
>>>   =20
>>> -	return component_master_add_with_match(&wdev->dev, &lwmi_om_master_o=
ps,
>>> -					       master_match);
>>> +	ret =3D component_master_add_with_match(&wdev->dev, &lwmi_om_master_=
ops,
>>> +					      master_match);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (likely(component_master_is_bound(&wdev->dev, &lwmi_om_master_ops=
)))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * The bind callbacks of both master and components were never calle=
d in
>>> +	 * this case - this driver won't work at all. Failing...
>>> +	 */
>>> +	dev_err(&wdev->dev, "unbound master; is any component failing to be =
probed?");
>>> +
>>> +	component_master_del(&wdev->dev, &lwmi_om_master_ops);
>>> +	return -EXDEV;
>>>    }
>>>   =20
>>>    static void lwmi_other_remove(struct wmi_device *wdev)

