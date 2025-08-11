Return-Path: <linux-kernel+bounces-761907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB1B1FFD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21FF16D8D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B029C32F;
	Mon, 11 Aug 2025 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jMzLDgzw"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4813AD1C;
	Mon, 11 Aug 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895793; cv=none; b=OuHbrR+dj9+IqRlFcPbpQtC7PCND2qMlGBjtgDL2EwBzjFaKb5hHKrSaFSWSzG5WVX5Vkw9g3vrO1O25jlRlaLsNvXXI6NJm4DJ0Y5yyikB1IpF24GbybDWVBjCzs4RBptLnoR53YAhjrv1f/mn6miO/NsdrjJSKujKNB0iRc1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895793; c=relaxed/simple;
	bh=jFlr9UYK2kzOAFrXv0E7sxyc9yzgXyZM6ByvYepr6SI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IuxiIRguSdzQIGXEg9y0zrf4lthCrYP8TAV+jAQTPWV7jARjsRQNiONOLMnTIacSvGGv8AAsErrBXDmGYHyF7ECnazf2Qfb7rtZY4o7N34kUC5N+UiUqQaJn/Buye4GHp75WtwHjbrH0KuHdwaxKqr+nK4P69KPAcoyEaUl15Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jMzLDgzw; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754895783; x=1755500583; i=markus.elfring@web.de;
	bh=+lfblwZgeFckk0X+2jPfkd8ETJunwzZBg9mF+DbP/3E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jMzLDgzwHTmjZQ1MFhKmyGjuQ/eWJiKXND9AS2FDwWtf61+MVgHMikKf9itdVK59
	 oh1c2tJ15s3SnUlb8IqQRNI7RX5bfTQRWoG+Sm3Ruck+AvQ+JQtHQoYxQHavxX9wq
	 z803NokUG3PU1mw+Av3C4BriZPuDUYUbzOWRhhl2xcqTGjXHPLAKiwzDZzCweax8W
	 0+RBfI93SOR4Yc6jT3Z+h38l+0xVZ907qivlX6wFF3k7agMeM8KXN8ZGdzmfAbjRz
	 hOnKS24nBV645NQ8mXYXL9u5juPO9GyuswuMGFRSgpvqNza/Wx4dRQmGt2pvMgD8E
	 ShVWB4role4Y/tj86g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.213]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N30dV-1ub9nH3ahB-00xvkz; Mon, 11
 Aug 2025 09:03:02 +0200
Message-ID: <24759bdb-b427-47a7-b9c3-724a11d0162e@web.de>
Date: Mon, 11 Aug 2025 09:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Scott Guo <scottzhguo@tencent.com>,
 Phillip Lougher <phillip@squashfs.org.uk>
Cc: scott_gzh@163.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20250811061921.3807353-1-scott_gzh@163.com>
Subject: Re: [PATCH] squashfs: Avoid mem leak in squashfs_fill_super
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250811061921.3807353-1-scott_gzh@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BlYR/fb0hQpd3LWIh+Hw7ZY4mTFH7VTuMX+5obpoxfDkEb+bgUo
 2Skpkz4HNTur81Azn0jB4NZoeGH8ugXfTpW63qDOi0F7uSVOPOHLcr/Ibwvq/TDTLc7XTMI
 Hqy+M4nZ8bfHFLYap7YNagxGe5Xh1r3ulUElK03xJ26kuVaxr7t8lQ4Jit6EO3qA+SaGowL
 Wfc1Qb1I94z4xSer+L1fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:55P1pmpdPu0=;6aKM4et1dUonXfr9ku8Y7FuTENQ
 t4RjUZHub0/UtkYsKUOv3Z0Y10NSuoyGoUZYN7/JSrW8y6ibm8a5f//dQDxWpDqVWi2/1OXth
 qkfeug+Y7XzSqxRxlDqiFK7lAGBmqRmFCqs8J+0PaUuSWOTrdgneeABVaLJSfigLFGV4lBMyw
 MH+kosPH4vdtEQoX9kA1G5xgR1QmwS8LGyOQxxpLZq6mbr8djlDkBdNzjdVjq2E3232ozv7Vw
 XjElwrzSBuxmB1zGL+1M1EyYy8aMasuoQfFTip4fgbRQddyQ6zU3sO0Yn5OqCknlIPArXZz1/
 0xECM59QJmAV3GlVX9lKR50yFM2kTz+8VJQHxWJEIasZ6e5cAoDqW0yG6rIo0orzSbpCdMPTZ
 GsTdtFKW7cmyWsEKc78mojGBGpeqM+xNs13K4gMV/uoXr8ybeLweWki5wkg9uDyXLI/6pD67f
 5LwG4sZcQmcBYealEIHL1CxidJ8DKdnVC2nmGwbQQScTJDegLZQjymeqwH46A0NAa7nupb09M
 tryQv5hFYo8xVHED/+G8X5CU0bh9bKQakE/GnMuIMrZwo3b5zLXqmj3wldYkE67vY929ytSIr
 194xm1XKpY9/oolD204ezEn30eFFjVfPSJHca8dtwUJRaeiJZJzOdlu+DzVNHlj7s57cpWwQ9
 f6PSr0b40Hi8XZD2IdeDBnE2TiKsCg7qUZVsIkIiW/nLa0EQ3ccpIONdmTt0AyBDdGnzSndWF
 0mOvpNJoHxGKlhA39nzZ1eMosU5oWgLAfSFYTohvqu1RNBCNVvsRmiyFKCb93o20wOt7DLvJa
 jgeZWUGReBUbg67Q9vOsKg1n5bH6f4ezlz4iwg/9QusQcaRrYRiVDcObglyvOmMYTVItPL1Bs
 9Y6pm6CPKopgv3xwkWh2cHTbniQ4T+gX0OgJasO9eVm6jr6Qmmi7tw5plCsuiQN42N9QtZWx7
 ZgCMQueV3bQsghHYK9kcxK5fuBT6dlBXUWic/v/Oz0lr5d3AWXy9WISdnBDLOEQIZPsc4nodL
 2KrYRkAoTEVGkoX3yWMKJdzjQswQgEdHBbC9qw1WKEawj0w1Rid/rCIZ2ONRDnmDn5g4k/dP0
 KHUuAZdiD4uFmJajzTm3D4fCjOXIS8rw5vxd/BdVwBTYG0PfEUqZbt3UGs/PDlX8m+vdrgVcZ
 PDV9Ockqmmz7RI7qkQVBwUI92Fj12IfH2QK7lKsMtNMSiZhs6NPoTAi8cjQZPRPZmPVA0SI3P
 N8F4lYO5oTQXF6zNlY1nWemGXECFxlz/V20btfkYP3/+zLJQMzaSmeKB+6axKmqS8y9kA4BeW
 XbkKjAIQaUCwTsbwQTkPdZ+T/tXB+evqIi5kFK3L1pdlgzwmPBX6B2+MrgPyHZj1WK3diKFxL
 DHViroJ+SwA7/CTBzrKceDP/2Narcoh5CBO8LyvpYHGmc97uOH2cFzv0uohpJUm4gI02DN+vk
 mbcXkNhUNwZXBUbCavjyp6JwhX9iy6Z4iSDOJ0+lEE+7HrX6JeRz/peHup0VpRUPaasqlF/3w
 48BB/LX2p3vJKLv7B5p+Ae3561MmgRwOLQym/YlKu3F+6hCqUE+wQ96rZKWh6/u3x8Ez7RxkD
 40FgNKBS4yaONClMjmnVszhedIJDc8VwMA99aItBUmRGgJ+NE4xhfGkNaZVzxA6bYNM49w4EM
 OzIaD97s2uh+kB5A34mUcyDpXV7pd0s3dONJpfi6EGB4WhwvW21ZCugTw3AqZDyqWeSPk97zl
 1r+V3mBkrsMkZmPbVKtPtsHNdwGbJgxS0rkvpVIk5pi7KEESYFUwr8UIxAmaiciM2n26OqWDj
 gOZvvXPCW8v8UwrPiL5StgTRCAC1tB4M4Ct3SPiPqxHSlaNHdE+qYQxiohklEPEUHs/IV1TkI
 M7FCRukIzS1KuRbzVEEfGdCa71SGB+K7x1ptsC5AqGiYWjQlsqENKKcztB8nZOXqE01G901Hk
 Eb5aCjXfuiyAH/n4Cfxl7dS0VUP34bXQftDI3PRP1gcuDy/F7cIcDUFZn3QY6g7oIdxFv0y/8
 GgCciIceTo3YnSEnmeNTlnzi//UP9d+G7OZLFQmrSroLSjFCm03727MeB+K7Uf5ZSdN2zq4BT
 cGiO8XQilXEoyRyTN1Ogz9vUU6+hxO070vjVxFsl5Cog8CPv6iJ6yhRGvGyB6EifegPDHQp3P
 x21RvpoVH1amrtDFc36VeMm0GwWb4RSkVmqQu+3kBuBPiA9+ZKx/qwo1XKOAwrupblOLydFRa
 3wXGwTVcLHu831hNxz8VIVS5ut7rGO9usMSN8JG7vwYIvofgJ0gC+ec89/A6QycE1jGn8eVjB
 3hhWntfX4bc9PHqXe0a12hMXMzNl5ngM05GygV+vhMy1Pe3h6dfgagvQRq4bjezWpaAxPaSFi
 HLGvcFdLaKEdVGcP9fjuKPBVFWrrxeXir4oS2ZIJqiTgMA56/BR/ite5L4Sdyt3Ak8FVaml5u
 lSQ2jHXH7WuFVIxMr93n+K/RISA4zWuV/mPl8itAGX7dLqq3PoCvuB4dyUD4QTRpfi6/N4NEW
 qdW5s3rnsniQx8BsQA0sAFnDRyY0ildj5eMyQUz3frli0H+l22PBktDdeaBfRIzFNkyPiKk/5
 +T0uUsCsxDOmFvPmQNPhfjZu4M3AL9llo2ocbFEfvb9e5LKgzSnx2Saa7gGqmXPOX1q3qIAKg
 EjPjzLcynuowB8gPBgqjK0H5nu6Drybw+t8UDvEG6AIzavenB+t8UXKearFDxN4R2yJDp8Wpe
 x1dEmocFNjy8CSZ4J922qXXI88PjLULM65MmPwcsoM1ymRQtOFD7lmccHxA9SviNtlgjB3dqS
 XJBt6ZWFvRBSoC1Z88p4FI3AVMyXh7zTfaguDxwGvPN2QXVgPmtpaFMNH3BeXaS9I4CofG5y7
 UdnxoYN6hci2ZAvQD88knKsQ1YwhlwYJRj9OqZVJH5iso5CFiCXGVuCzGSMfAwhSJXQ6WKn1W
 DUJhqpTbuDHLgKKf8w+102A9JDWq07GR+Lh5lpRI89CRnTovmVoyjXzc8KLXJM1ioTtPYjefY
 Q1hPiIum0n49MkB9j4lNKU43irM7AvYojCKLMwnvUZrM2pDxBVvDbSnIJNrzEON5LB/K4QJlw
 5hKBMsdJq+JnMR7XVwHCA5R9MFLascL7ScFk9bpa5IlFfuZWLDAqnnIv0CWE84KNIg08HxCkd
 6Nvvu0wm+TVXPicJ8Vl7GXnFAf7YI+0JU8kFo5FCw0Em/lIx/pwpY/y2lTCy3M8OZKg+9pBxI
 ZGf5k9Qesny3C2ahUqPpiuMKnX51UK3FYJm5TZ1W7oZbWyLyKjUgaTgnU4qIORFozYp7KIjEr
 LyHWsDYOZ2J3cUdcMkkIE0Uia98cgAkJqA05ALzgcxcSDXi341xyWzGv+8WZ18lXj7fth2QEn
 JXwTpgiyc/8dOF4/FTNZEq6s7Bz4dS8vTaovCUbCQzHHFyIFoRwh5pWigFbmre

> If sb_min_blocksize returns 0, -EINVAL was returned without freeing
> sb->s_fs_info, causing mem leak.

                         memory?


How do you think about to append parentheses to the function name (in the =
summary phrase)?


> Fix it by goto failed_mount.

By the way:
I propose to refine the goto chain by using additional labels like =E2=80=
=9Ce_inval=E2=80=9D and =E2=80=9Ce_nomem=E2=80=9D
so that another bit of exception handling code can be shared at the end
of this function implementation.
https://elixir.bootlin.com/linux/v6.16/source/fs/squashfs/super.c#L434-L46=
6

Regards,
Markus

