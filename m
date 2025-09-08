Return-Path: <linux-kernel+bounces-805729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA44B48CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B57514E1872
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2982EDD6C;
	Mon,  8 Sep 2025 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LLZZcL7U"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546B219A89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332856; cv=none; b=LgA/9dpPFTYC0qoZaiN8qP/SheA4bRb89GILOpNOZ94RWdzLWvFr8LR6Gj/l7L4HrN2FWEWwcocp6oQNmQgCCWV2Vd2CJFs7tGe5vSyHS/EwdEjmxLa7hcZEkgxvI8+tU5pG0zsDdx2Bf5GWkirWpwYT7v54rALIpwTq0Jgsw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332856; c=relaxed/simple;
	bh=bC39qHqlUfCPmw+WmaKjg1Q9LsPOxX0uSolpDvPFtoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8KwgDFZQNchK9mNrjhKcdYw0wC1CmsoXiShzo6M4d18nS/pEJgjWOwet5V/PFNO9deKyFJXyIhUEvwv450iYnOw3X0B8J8PqtxkYRHy220EmNVEk0kQU8yy7K/FpE/wRc9jniwQ65D0SE2/XX0E1W62c/nE5PsHD4cZHp6MEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LLZZcL7U; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757332841; x=1757937641; i=wahrenst@gmx.net;
	bh=bC39qHqlUfCPmw+WmaKjg1Q9LsPOxX0uSolpDvPFtoA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LLZZcL7U5cajszmVvvCCnggxd5Sn5HMo23hSWdXC/9hdGIuOQJRyM9fgMdx5YmlJ
	 Fjz9CScY5/ofr7787VrinOMTmDWlHcKEMnZVuQwEg11KE1wB9HgzrtmMmfSuQkEbT
	 TF6CJqFv7jCHRPykhijdYa0iPYWvvbKzu/3wFf20RCoMe9VPSzx9R8mjDnf2Hpof1
	 +yp+KHCSrWUVXWJhEKoF69poAkkDzVZddYkYzMHbhccOARd0vXcyak68ZOD0jFWPY
	 g7fze3AQdfDazYeppIzpuwC6bYkPyXFdFoBngWqoMjmyeFFpIIytDOj8BLrPP6oOF
	 u7G62S/Mpr6ukGqgfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1ubJo22Ae3-00xm3C; Mon, 08
 Sep 2025 14:00:41 +0200
Message-ID: <0b9fa19b-195b-4bee-8f51-6b00ff2fcb6a@gmx.net>
Date: Mon, 8 Sep 2025 14:00:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] media: staging: Drop bcm2835-camera driver
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Peter Robinson <pbrobinson@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-4-5052a0d81c42@ideasonboard.com>
 <731ead88-8dc9-4032-86f5-7a2dd5044b22@gmx.net>
 <175690685574.8095.13306600513284108529@freya>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <175690685574.8095.13306600513284108529@freya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dbcQxO2oHE0D1OWtsoZDKq2VJUNKo74R6cnUu+ggZxgkwCn170E
 bthDc8e4as2pNxpTEFL/j/DrVuw3etSyyWBWYsEjD5vf38L3CmLIZoiXbpKrLHg34jwjfcE
 MnnKAMZ+NBx/R+56xHo3brHJ3HWxKwbT3caCFnLpBVbC2EcbUJZlzhvXBpARZtK+/CQ4whH
 8CfdYppXm4gEoTvUEsQXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a4KrkC/QwQw=;XZ+TsAa0Bpkx7WSP9Fo4QQxvb/t
 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

Hi Jai,

[add Peter & Ivan to Cc]

Am 03.09.25 um 15:40 schrieb Jai Luthra:
> Hi Stefan,
>
> Quoting Stefan Wahren (2025-08-28 00:48:22)
>> Hi Jai,
>>
>> Am 27.08.25 um 08:24 schrieb Jai Luthra:
>>> The bcm2835-camera driver is replaced by the V4L2 bcm2835-unicam drive=
r
>>> that is already upstream. So drop it from staging.
>> AFAIK the old Raspberry Pi Camera V1 isn't supported by V4L2
>> bcm2835-unicam. Personally i'm fine with this, but this must be clear i=
n
>> the commit message.Did you already talked to distributions like Redhat =
&
>> OpenSuSE about this step?
> As Dave mentioned, the OV5647 should work with V4L2. I don't have a sens=
or
> with me, but I can order one and try to get it working with the upstream
> kernel separate from this series.
>
> I did test the V2 camera module (IMX219) with my series applied on top o=
f
> upstream kernel, and capture worked fine with bcm2835-unicam, so I don't
> believe V1 camera module should be an issue.
I was in holidays the last days, so I better reply to this thread /=20
context even there is a V2 out yet.

Yes, this explains the technical part behind the motivation and I'm fine=
=20
with this to speed up unstaging.
But my point was "Are the users informed about this step?". So I hope=20
the extended Cc should do this job at least for popular distributions.

Best regards


