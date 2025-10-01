Return-Path: <linux-kernel+bounces-839463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D5EBB1AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4A2A3217
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B72D8365;
	Wed,  1 Oct 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NJ/2U1Qr"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347A246333;
	Wed,  1 Oct 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759349770; cv=none; b=MgsbmxgVdlDCtYGMFt2QwTj34fmcoIffb9gHzt6qXw2vPtaKZRIe3ksD8diograliZ04nTCZ37H/tx6OFK5jLaVeYX87wlVhy696wSzGYSOHKaUKEpUem7pFsd9Aw2ikPHm6m98IpUIJ1qCi3FWCuGN6O18FYHbuWRbpYcMhN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759349770; c=relaxed/simple;
	bh=u3Thdxdwau53LuWQOON+Wn13kMGHLQm5ErFkJbbLJ04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQygLBSpvsau0DtYzxi85mrdDJSfE+GMxORlLSRs3B7yZ9RHWc22slT4EPND90BUpTOE7eTsfWUw5BAerGRpsS+Fi7aQghHwgMKIVn5Wvv4zZtNhc/Atvfwdq1bI5SBjt7em3IY9KPFNgHdDrPB2Kx5BjR34BwwcGkE2KYDN+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NJ/2U1Qr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759349765; x=1759954565; i=deller@gmx.de;
	bh=OcAjJiP/46BXtpCbi26BugCdAAYCqQ8rf2GTZhwvH5Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NJ/2U1Qruj3r8SOrYQ0fQIdV8lcLkegWk/P0UYscAvMBmw4kQU+IFx1Gpj0cM+fW
	 VkDxKYY4VIUFgwUrh7HGMeCDHanI+SaEl2GRFpHEEfU0L2edjjiC/Dz8rWONlVcIN
	 NDpOvYatmIP2inaI4nysqp5OUTa+eOsNUcHU4lUepNGVeQ3teRSzyp5EN2zu7//du
	 RMrVNXqKhJjl+pZg1es/9Q0Hry2NdFs4FU7s7GxSaexYZW0cU7cZr9i8S/qA9/2QF
	 gwcRu06hXPSg9ujDaavyT57wqMB3Jl3u3AFZrjehbxUUohTFUxLKUCcHA8PHykmRG
	 71REtga/rpcnbH+Nqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1vDACE1hdD-0097MD; Wed, 01
 Oct 2025 22:16:05 +0200
Message-ID: <6d23f2c8-7009-4d9f-86f2-2179d6d1e9a3@gmx.de>
Date: Wed, 1 Oct 2025 22:16:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] parisc: don't reference obsolete termio struct for
 TC* constants
To: Sam James <sam@gentoo.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Stian Halseth <stian@itx.no>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <fc2e8775d55f43e08eb79d326d6fdd89291898dd.1759347737.git.sam@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zS5NQAmpvB71xIkfb+3uiz07z01N//vvemYrL9dLtReLTH/aOH+
 RcYFmt3ufEwiIMCeDTNESjXdLxu+B98460mmydcLdMtyPZNjEKH1VwsrPCVeAsrx/nO7ze7
 s73EHoqPlgWNjMRIjBqik/Uwkd9vO9Hk//5+9kLZNoyAOB9AnteoX0hEDWc4A6bxZmtb6/6
 2MycWGzSulPmVtzN9yQKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vvFHgADSJl0=;o6yU7Qt7N3OTpKF3rWhNqJjHSH8
 SO7sPn9e5LOdzJIynlCl14XcyKe2+0Yfpn671WJlBdpMZ84elI2I5A/UqcfIMvqk386CqOx+a
 TwjPK+XlZDqIou1oHXDrs0arApJrOnTMNpbifCRmPFXB7xiQ3atLyKvPu0kYkbFh113WDKgwR
 K25px/GNtq7krA7AI+Ucoe0U0yGj2WHtprueb5zcXpLr1ePUAxSvhzMnsc6Y99VYmnF77Gyh5
 nbTSKdJSUzf+sA4tdvRxfeKBuAzAbkK6vfq1ObS3PuuA52OWXH2iFjFSY/3pRIc/I++AumuUh
 vlGsmdroFu6rLOBfaDd9T0lTNskf3M+DdBCS1GEQQjHH6YsIHb/gOocDWcWhsfPtkK1qyrG3h
 RZuyR0aBmpVVr2be8Pu+zAwVEjRhkdPO0zmRP6cdB05Y04lOZO81KBnyut7wfsvuQnIjoED++
 a+E3CMhCIMtppYgaIGaSTl5QqobpV1jaqaWvHiuzW3p3VJrZR4tMsYDVGv/LspoZiXWJ6tfxa
 iCV/WSRPlrdFur5++5J2ED66jTZs9Trnucx3ZZJ8yACrFEdE4NB8UH7slaXFzkqxy0bfc38gz
 tlwSiiZq74TzuIyvsdYvHBlhhS4dZSn42NhYH4PzzXt+T9kVQUEVOxvn7ddRDrE1MVKWDryah
 etNy8esn+b7OK5TjtunSLEF250/2GulXScpx6vOONcvxqimfyNETKRFXyv0ySdgyeavCj3y0Z
 BfBN48/oWkjx7xJPzuIs9ouWyil3JHhiWH3l2M5XAiYezDnYB1LQl6DFqCwjnKvBUncnUs8Hz
 n8OHwQ26Y8jvFeGGvv2Qp3GrKGK5u8dyNF7N/j9i6OstJrbJ/NqvdHe8RsLNDIvABpD2AYUtK
 xQbEhu5eg4pVRH1Ut6N03kzr8RW1bidIYyvUm5a1o1WJimiYNeDeWl8KA/lZG8zZHeqw1nCny
 tAHZEiiigNlAEH+t16YZLg0pWp3hgJu9kteJXz4B0JJ6TXFImMb0LgGdSiMcMLH8XrxaFQya8
 02VOWdyZLo2GNnlb8hF1wSyDF3R5I5FYE0YRptUvSqHD9hmqoT7Kv1rgOwmK5BiUuflm2ZMY7
 90dHPJTUC4WScHRZ1nnLleW7RmhAxQFbDclAoqu8Qzvt1OpLIQiYiFH7Y1s8w6Bfria0bmhl1
 wb4ImHR9r6vI8xElncjvEE2suZ8o0a97NpPaR24pJbRpZtYPwqDCrKQls1BvFWwcm+LsQvKHz
 cHm5Hf2z8fNwFt/SFTvlWT5Mefh7XxOQN7rfTHkNnB6FyU+ALri/Eg7RHZrKRzhBmUdWE2mNC
 b9YQ4mfzy/0/GLCUbAuwNtx8p0aWg8oSMiimCmAZckjjGO3rXezj8QcIEQVLncAzQ+se1Kx0c
 rPzk8ESvTdTZJXOTTK7y+o2i3riw2HiaetJPvwbNN0RZFT7x+N5P2gLsqjLV77if4NEwI2W8Q
 m0KxxvB4FVsx2OUIu47flOOHpThOeW9QsE3auMVk+GfhGpXuadznBglo3tqW/iI83f9o9xWen
 hpg8G8Bk3Weh9yhARTfxhoC1SXPXzr6MxdkekhSYEhiMo6jMh+rKWoIN94mgWHW9kpWBu0ssJ
 sQE87zEsAuE6Rabm04zVoPJc0BZrVkYKhKQZDMCYyYu+9CTfbO+5vYagrypIlmqRB0CIMK04/
 Oo6eqdXCAUJ0Vh1TLUbyHYcJYP67jiMfd8cIGuZxnemgfsxaGffWBVeGYD82dQ5w9EDfJJjdf
 hJX4AqBrno2dL6R/Ew7V7XBxHrGE36onc/wjWVKijZHgcpQZz/1MCgVvM64htAN4enGHiUe4/
 Ds65OyDCUTuAbANHGqeEiofC/Z46NVCDx3iCGPO51SUam6L+Tsc6vXxcUmaC5Wj4gmTkozoyd
 GQP2B6Cu7twoVglWfbKqfp1E/x30lEA9stGmN3kKDlRAJJhaNXwrdvwm9QjUta20nJk8JLmaj
 /iYDx4Q3TlDeA06lUKRRla4eZpxO3lWjdIdrl3qTEajw3bseP4yJQ7mTu6CJ/bI7HAlXhoDFC
 bDo/0HJQbYilXDLlGIusQJzUJKPGwfisig5W8BVEcsHGxq/IU/5tbr64HSP50mODnacRBsWbd
 8L0Gei4wnTtiMyoYaEGSBhv/pjYOmHL2/k4x4PlzhTEC8p95LeS9u7nwN6KoRt9LbDf4wwhcE
 LR/HOe/a61QDYLErNlmgwx3iDR2Oca2uX+ozTlvU05QT2H+TJIk00kciEUXgbL31XRxWw13uL
 KqbDVvLSygPz2zai22Lf6duSEaG/TGUh68v8bQLeLX8SZ6fH1FnAQDeJC4sQN2HZ1u9i3hnsh
 OvAqpiN7mzHxZZl62Zb6/h++k7SP/q/L3EpPQHVJa3Ki+jROdhoWJKqAD3qo115xPMkDIuzhL
 jP0bxRAzdwob/HO4q0Lt7XOtws+vzxO2uW5G1NDdMJ3diMZp3Hb1IXdPonTMFDTcl12+F8nlP
 i6nr23yqqzMIViBRCyKmBkDrgWuSTtzIbTW/78stDx9209Qu0nAI4RrRgxmRIoJ1nJn0oVVAI
 9s7aSNpk9ZJ2I03lDAro8ufr+BReU2skeitX0rjIccRnSugvcdNPkAOJLWrcJ0XyL3SPnhz3a
 mpX+Go9b5DRIk99SaSWE2qzHLqM5kvYvZ3yyVezbdA7Pn43L4o+ds4Co3/Fy5X/9ijvgqCzHM
 nk4WPp2RiKVFIg/Hkp3ABSko3gbFNbTHpo8DmMy43WIj/30EGUXj4oDHjpSeUAuKD9L89ZkbH
 cqHM2046wgDX+r/J0Gx8OWqUZ5VsjJTVgUtSMZktpODZyxUcy1+ivGmamRJo56Xp8Mi/RGY/5
 LHCHvl6kV2WQUtYbA0SvWBFRb1CnDqGXpnKi2UkZ6ujVcgMUG02asUI0sP5uetKVSgk1Bn2y0
 NWQsYfIQKxbKD+qMujVXMTovllnO9OGIhRprYDuCwmnZrrBr54g5RjxoVFliVexTRRtBecHoH
 ejaXR97qUpkPFqiYwvgvGARKO28PhbWe/HQRC6rbmSaD++2oE9ZklpolRkFLgRFv2IXqPq8OE
 X/2BRqD5+6qH6IxEOnEEAE1nxf5T/vcV/54jk0DpyL0smZdGmR5VdDGDuTYYqXpHyLPQzaADF
 EFr3nwSk3mBXOYri+4y/7q9AEEc+4cAip3s69lKtzYYcAWTV2BpsYtkiaEHAtDLut6+EpCUTQ
 aXDeY7gurSRy/AUz7YAIZezhkC4Z9715FgNyJLTPD4H/poL3BZG7GKQFXH8zJlczND9oJfI1H
 pQ6/MBniDcxB+hYM5DnmZxOf0PAXbg1ea75VkzMwpZAhbD0Ho5e9u0z6Ic54S0KThu2M49D3o
 GWrYTHSzf4Cxo0Sc2Fuh3qyy3MgHoKDz3ySquBh1luV/GM2fCwfGDn3lSMwC92VrUsU9p77ZO
 Irs97xv84qla/ETI/iPK4Pe5ShM/beX08oSHJ8mFhR/MAjxfVcHYsIubtTViizpS0qEmk1aQA
 QioK6/S9AtuxUVX/w6tdY9se0hD+a7DqirqaZ2TuZykSnEIj6NRhJmW3Mxaxy9EdH0Oss4quV
 gxHiWTsYgxgwM90vZOgw2HzoNcVlQ3g06MxYoMKz9wtE08G0zZOmROSgI55kaGxA4s+rq9854
 rLmBjim52HlhtsMmjnLO2I8nppw9aAQpwF5NXelmIPAxMNXduCER3P/KvgwRAtCJXmsr54Ok+
 3f0Fle8b/P0oMkuDpCoJ+B3INmPtLHqvXKC2faG8aIR1VVjMD2ZrTDXq83QuDooWW9E8fSYab
 MsIV7SYMvKMBJbB6+v3voODYIpR3bl9p6X6OnLttOR19sPPmobayBCwHlk4FjQH1lnPukAAWn
 iHE88fSdZXRhloyVLAEr221XhQc88xdoXZdFadjndUV+Yc2N2O+nOjY3t+cgF67sYBp0MopH6
 RAbsyJ3LsT6FHRVkiWhaEwta0L892Kk1ifmA6cZ+N0aLTDd1EJ2szv+IHhD47N1ngLnLgkku5
 QGEsSUlMD3iPEBSTmGo7b8+nNQLd0Gt6qXw+0Lib9pRJG/Y6qXKFDDDs+gMakI6VzSf6tsCOm
 ummbgtBaUbsrMaJh7MiDTXD3KFs0DnVn1jipr0EfkyWrUH7OeFlYfv2XdZJW8KHM+zdQRxwd5
 79pCub+bcIbpAR2eOX+tqw1kwQqe/sKS/AX0ksCY750aVcXrHZ8S5NCiop/U0TOl8hxMzSWVg
 Gom9o/AAmH2KgZruAzqXRJ3wH7iiVLG+OxTA0t2JhN5SFgudM0zw0vl9E1b+mdDfLN6gUBuTi
 kZ09YpP+qkka8fqzJ92RL0pq5qAmwtz8np7kI5I5I0HGHM4svQWv5bEXD95R9TtQ0niyKIc5W
 pol/C8E5cEF9svRFupea2fK5/+ay5X79csaKBN4g8mxIGUwD+XrSn+1dIvONvAR0Gq/CtvKyH
 YOhNlkdFmeKA+MM5sNp8fewpyN20OuR+XZ9t4TpP/IbtSYI7rNNfPyrs2X2qnLeiDrLdVSr8S
 C8dSm8+yVBZWPJ8i8XTFwk9TxL1k8N0TGte//Pmb5OQ+04RzVQYi4mjOK8RJ/EG3y+G6sqn3V
 H2IpSdqxusvB0/iCcYCnNXEnDstXmIooBhZnXO7YaD6KV9hMTshVEeVXIvPAgmx6ihyvPLmkJ
 sWpNlaiqfdfOq+wW0sgQNFdQxwV9GTshGUcAtzRANWkHsvdnyHe4kg9QZkxV1v2sRMv76tHCE
 AnmZFYMvanduvZ5q8S2gDSsPywRaRYEw60igPiwczItuV6wi8JXPiaVEopczoq1IUmdeUzAAf
 6MVcYM9aO+ADzPupQNe9Hq3t0fq9IHWnrAXKUZxrLO2oNm8pUKvmbppeIzvnnLR1qZUGJIgxa
 jAGP2SiwqCjjuMAGk2A97jetDoklj0vfXJnQXbiKIoppiiRmrfc66lCXJC5DGmFY5wsYglWxn
 RUpbYN1a9wpLtSjBgtfQagwQ1KFQcq1UBhTNSRoOApnU2VQXshQf1kAZ99w48iSFe5RGNuXkO
 M0NTXTCR7jpkdrHHWWPd3TsixgC9hKFNa17xybo6/2ekRPSgZ4SMO+ievtmEuawCb9VbP9pQz
 w8QixUaOlm0horvlQaE0CR7ZG6ugj+1UrMZPjUDtUGXtQfqOnP+976Ko/Ef62MtKLHBq/Bu4S
 cy+UqiZcuzx4ew45n24xeQOJjR3r/9G2+dxGl7

On 10/1/25 21:42, Sam James wrote:
> Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.4=
2
> drops the legacy termio struct, but the ioctls.h header still defines so=
me
> TC* constants in terms of termio (via sizeof). Hardcode the values inste=
ad.
>=20
> This fixes building Python for example, which falls over like:
>    ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' t=
o incomplete type 'struct termio'
>=20
> Link: https://bugs.gentoo.org/961769
> Link: https://bugs.gentoo.org/962600
> Co-authored-by: Stian Halseth <stian@itx.no>
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v2: Fixed title...
>=20
>   arch/parisc/include/uapi/asm/ioctls.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

applied.

Thanks!
Helge

