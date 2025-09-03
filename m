Return-Path: <linux-kernel+bounces-798893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE0B42457
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1ED94E1DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134B3002BF;
	Wed,  3 Sep 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Hbsmqkx6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0F3112D5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911829; cv=none; b=XOcIO0RXGMHAa/kGRmILXRpUl0GYcFSkn8061Q/Zqu2uR5iQJ725EJh/Sgc5Nl4bjW1kO6bTg6bzV+AqHj+I661XG5yEdNo5ROqEeN+/eY5blR2APlxWWSorAmPTRAJaRiFX7j/UuDmxKJvwYlLNvZHuEp5HOWzpmuFVWesmqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911829; c=relaxed/simple;
	bh=NnuAHSBDbfi4EOChbt4AksdYqmsgZxMbH5odBKKwj7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKZ62FCWl+h0eB+/OnjMaEHRNOlkdJxk1o+3cDLOPDu9aA0UJ62xj8IEkXlLhKujmGhMre2LWX1Dr0lMHYPbESwllmi02TvKaFcf9aKkDf5N2mqTC0wG144yai5s10xX/fH8bKjGltbSktfU09BFP2Z96AJRSZusGEUFuhhBPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Hbsmqkx6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1756911824; x=1757516624; i=wahrenst@gmx.net;
	bh=lJfr59Plj3fSfvw6i7jJR5SedS5G6ug0wiaaH4W9uCg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Hbsmqkx6L5Ghj3Lc5eiYcmHX4tg8p83VqLFBwes8EgPOVEw5m4Jppet0pUneFQLj
	 Qp3LwxqEvviLdrJgTXHepWhk20yLhaB9R4VZD3dtLOsk3ggpHywLCr3bQ8PcZuOad
	 dWR6ihlSOFFaoT4saBzDuVva2+Nzqi7jtxMgn83B0aah3xVwz0WLU6DEmUkJ5pzkF
	 T/M/bnIUp9eNSEwr242ypgrTB4SZlCIaDNHllubJADh1awKOlUbn5F0yIxpOBNs6o
	 i45k6KVpzUWmAYNPkxI75BbMhq2/ifxsvXLrGd2lNpVXc6xi2TMGAjgC/JDw/lQsj
	 VI/WVvthXgqXBJPB0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1ui1K92bNV-00Gpcn; Wed, 03
 Sep 2025 17:03:44 +0200
Message-ID: <02213561-7a72-474a-be83-98d5ba575f0c@gmx.net>
Date: Wed, 3 Sep 2025 17:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Umang Jain <uajain@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
 <20250827124016.GF5650@pendragon.ideasonboard.com>
 <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
 <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net>
 <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com>
 <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
 <175690728665.8095.6551736878574350999@freya>
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
In-Reply-To: <175690728665.8095.6551736878574350999@freya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6ukBoBSNdFuw3egMUEVefY0V9LJ/LcGd+wfUTfkiFhN/1SczkYh
 7rrZc01W6EYEjquy93uTLQlLx1wFSjEuh2fEcFZ0zprZ5YoxyoG2802H7EUkGLxbBuy9I//
 pt0a/tSs+F3vqG2mGwsAJ0pJEwqBrh+BnpXZD2epToul0JKEV86aAMKPVyHPwuVhezdNZBP
 h3h2Eom7DRCxEmjZ7k2Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8kP8xmbzu94=;vroUPObP0qKtZp/u31HyF8SASym
 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

Am 03.09.25 um 15:48 schrieb Jai Luthra:
> Hi Florian, Stefan,
>
> Quoting Stefan Wahren (2025-08-28 11:49:47)
>> Hi Florian,
>>
>> Am 28.08.25 um 04:17 schrieb Florian Fainelli:
>>>
>>> On 8/27/2025 12:05 PM, Stefan Wahren wrote:
>>>> Hi,
>>>>
>>>> Am 27.08.25 um 16:33 schrieb Umang Jain:
>>>>> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
>>>>>> Hi Jai,
>>>>>>
>>>>>> Thank you for the patch.
>>>>>>
>>>>>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
>>>>>>> From: Umang Jain <umang.jain@ideasonboard.com>
>>>>>>>
>>>>>>> Move the VCHIQ headers from drivers/staging/vc04_services/include to
>>>>>>> include/linux/vchiq
>>>>>>>
>>>>>>> This is done so that they can be shared between the VCHIQ interface
>>>>>>> (which is going to be de-staged in a subsequent commit from staging)
>>>>>>> and the VCHIQ drivers left in the staging/vc04_services (namely
>>>>>>> bcm2835-audio, bcm2835-camera).
>>>>>>>
>>>>>>> The include/linux/vchiq/ provides a central location to serve both
>>>>>>> of these areas.
>>>>>> Lots of SoC-specific headers are stored in include/linux/soc/$vendor/.
>>>>>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fine
>>>>>> with include/linux/vchiq/ but other people may have a preference.
>>>>> I agree with this point and I might have missed to notice the
>>>>> include/linux/soc earlier. That's seems a better location to me since
>>>>> it's actually broadcom-specific.
>>>> I would expect that headers and source would be more related.
>>>>
>>>> For example:
>>>>
>>>> include/linux/soc/bcm
>>>>
>>>> drivers/soc/bcm/
>>> This is not Broadcom code, it is Raspberry Pi AFAICT, therefore, just
>>> like drivers/firmware/raspberrypi.c, we would need some namespacing
>>> here that reflects that, ideally.
>> The VCHIQ code originally comes from Broadcom, but the current
>> implementation has been adapted and tested for Raspberry Pi. I'm not
>> against a Raspberry Pi specific namespace.
> Thanks for the suggestions. For v2 I'll use:
>
> include/linux/soc/raspberrypi
> drivers/soc/raspberrypi
I'm fine with this.
>
>> Should this also apply to the DT bindings?
>>
>> Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.yaml
>>
>> Best regards
>>
> Thanks,
>      Jai


