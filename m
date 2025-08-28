Return-Path: <linux-kernel+bounces-789306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F9B393B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74558204881
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED2E26B2A6;
	Thu, 28 Aug 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pKPtG23O"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F61EEA5D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362015; cv=none; b=JpozAfOWPLiqZT0gBRZIZ5KRUPtv2VxjMT+VQJoL+Yk1MDBZFFkRTbiT6iCEYUgmPZ+C7WSQIPlfdVjQd+QnGJCKKI54w/+gzF+YxyQKLcpTqo15TcE0xNgSR8ITuMpjCRMgXgbWUi/eSbY9ChkHurBkN4nIEzGt5/5mi7Bv6bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362015; c=relaxed/simple;
	bh=hK6XqJkQNDAhlvyTtlVGL4OJEynPtpkf9TGBGdV6LPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBzYgtpKEJcgnPmlyuimT561k77Pqwr6+pDb9Tp7dKW/Cte4ziV8RsdERq+VImytLvZjuRYZdqoiY66Ymev2oAKP3ugXOGeC64k8Ftk6T1k+2oOEqtjzuY7pnbucG2asxP220RsYiSAboT4FAuGdJlMt+/nhcp3ZSAERiQDDW48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pKPtG23O; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756361992; x=1756966792; i=wahrenst@gmx.net;
	bh=hK6XqJkQNDAhlvyTtlVGL4OJEynPtpkf9TGBGdV6LPE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pKPtG23O2MNC1qzrthmSWjVows5y2HfCmXVBpURiX4rMuuYiQihfYLGliZnkHL+n
	 ux3EC4wvqD762zzIIDxssrn2Y+bXCjgTqaNZQsSeYpGs3h9i/2EYHns5vZ8puJLEI
	 9tkY3m0ya1H3k4Qwl8aM7I2UPKGxYzsitT6pyw+1FwrHUulIWv6jb47wQrangsBDY
	 nPVcUGwq4vA0VD9kOx6qxCxSpHh6IEHMGpHALDYiaipg1AeB7G/xSDn1OYNXDlw8I
	 N/x915hJZmm3L64LmKDUqNPvR5mlBX0jvswSdaJcaX08/3m98J0zPqvSBNzWWVZKc
	 sH7PsDB29ItbzKEJHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1uXmZz1nOx-00qp2o; Thu, 28
 Aug 2025 08:19:52 +0200
Message-ID: <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
Date: Thu, 28 Aug 2025 08:19:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Umang Jain <uajain@igalia.com>, Jai Luthra <jai.luthra@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
 <20250827124016.GF5650@pendragon.ideasonboard.com>
 <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
 <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net>
 <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com>
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
In-Reply-To: <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y6dZyjpRpNIoL/rKyV9W1dCh4kK3Fr5DRQ9Unqmfd8VJ6I9iVCM
 7Anr/zIXHXZA+Ywytu51yk/oVYd5/a6PdjZxf8D4lE00tTfvamA3Kzi6jI0nH+dn3QGuPYo
 xvPFCy53DW1K/hi9ZN1njRCdjx4qCvjL9uH9vDrUrp9y7i8EJnrpphasUR5QKOp5g0gN8Dy
 9LlYxoL4KW+X6ydkWF5JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rAdP4rXadtQ=;3zfS0URxGLiDDvnWLiBr0ioEON9
 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

Hi Florian,

Am 28.08.25 um 04:17 schrieb Florian Fainelli:
>
>
> On 8/27/2025 12:05 PM, Stefan Wahren wrote:
>> Hi,
>>
>> Am 27.08.25 um 16:33 schrieb Umang Jain:
>>> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
>>>> Hi Jai,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
>>>>> From: Umang Jain <umang.jain@ideasonboard.com>
>>>>>
>>>>> Move the VCHIQ headers from drivers/staging/vc04_services/include to
>>>>> include/linux/vchiq
>>>>>
>>>>> This is done so that they can be shared between the VCHIQ interface
>>>>> (which is going to be de-staged in a subsequent commit from staging)
>>>>> and the VCHIQ drivers left in the staging/vc04_services (namely
>>>>> bcm2835-audio, bcm2835-camera).
>>>>>
>>>>> The include/linux/vchiq/ provides a central location to serve both
>>>>> of these areas.
>>>> Lots of SoC-specific headers are stored in include/linux/soc/$vendor/=
.
>>>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fin=
e
>>>> with include/linux/vchiq/ but other people may have a preference.
>>> I agree with this point and I might have missed to notice the
>>> include/linux/soc earlier. That's seems a better location to me since
>>> it's actually broadcom-specific.
>> I would expect that headers and source would be more related.
>>
>> For example:
>>
>> include/linux/soc/bcm
>>
>> drivers/soc/bcm/
>
> This is not Broadcom code, it is Raspberry Pi AFAICT, therefore, just=20
> like drivers/firmware/raspberrypi.c, we would need some namespacing=20
> here that reflects that, ideally.
The VCHIQ code originally comes from Broadcom, but the current=20
implementation has been adapted and tested for Raspberry Pi. I'm not=20
against a Raspberry Pi specific namespace.

Should this also apply to the DT bindings?

Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml

Best regards


