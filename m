Return-Path: <linux-kernel+bounces-791362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E8DB3B5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C88716BC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0C298CC4;
	Fri, 29 Aug 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="V2dxd/N4"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60371273811;
	Fri, 29 Aug 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455826; cv=none; b=h25zJ1KnWQb3paArYgjE5YIcFQg8Xs0aZZzV6RJlWDgo2XQw/hS6+EN4LDVEvjAvVQSWrdbE/+q4Q8FuLD+E7buK8FMlMH4arpp5XRIRr2ILIjZrsIPQ8VFQHKOH0EWoOWyGJsBfidMf+MQcE0Tl+DBqmlRsgGvtf3L3jeSnJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455826; c=relaxed/simple;
	bh=YgrYJAqlgHJsPOK11CQ4lAvnZqm6T8Ah5bSSyHlt2bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ui9g5KupLbFK0y6f/MXQGVSPwkl+6/6IsTbQIwE9skxR+UJxDsbvJa1yEtEMw8tZDYptIUNdnC15n0gLh9pjwY5dyed6Z3GWmEylHc+V0Xbx9aNNQr2A7ezcF6rtmh52exXqkd2+CdMTcwEfbMJ0lB7fC/eOgrMghbjng/qdF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=V2dxd/N4; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756455761;
	bh=K0ji67Dxttq1FwFtmOwl4Si0WmFLwHp1Gu/K45tUh4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=V2dxd/N4uZNHrUw1l4BI58cxmljhHFGpFzs6toLydH42m0Wf2h3Unl0n0FVSPfIMU
	 rnpxBsUpXXihqHAjVHSp6Uo3TuGhx224fL1huiVMaOzJpengWg+aLVJQElxp9eXrcl
	 0rsROLaR5hjrdp7DK7B0HEKHwZ5MOSeAWM31naaA=
X-QQ-mid: esmtpsz11t1756455746t9accc36a
X-QQ-Originating-IP: gX8XflqqNCBDkjeEeOHez5ul6qvX9McGVW5f+JsrXs0=
Received: from [192.168.15.210] ( [103.152.35.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 16:22:23 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 658202669656667885
EX-QQ-RecipientCnt: 15
Message-ID: <CF78F9A880340BB9+4af33fe1-2ec1-468b-9f74-137b715f2193@uniontech.com>
Date: Fri, 29 Aug 2025 16:22:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: docs: Add documents for recently changes in
 snd-usb-audio
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
 Kexy Biscuit <kexybiscuit@aosc.io>, Wang Yuli <wangyuli@deepin.org>,
 Guan Wentao <guanwentao@uniontech.com>, Nie Cheng <niecheng1@uniontech.com>,
 Zhan Jun <zhanjun@uniontech.com>, Celeste Liu <CoelacanthusHex@gmail.com>,
 Guoli An <anguoli@uniontech.com>, linux-doc@vger.kernel.org
References: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
 <20250829-sound-param-v1-2-3c2f67cd7c97@uniontech.com>
 <87a53iimsm.wl-tiwai@suse.de>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <87a53iimsm.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MKd8b23ZYblI1uUanIMuxcEqLX6HUL1iEr6uPhfaScwJM9nConcKBTZf
	iKziRAQ5LWpofU1dzXEOnd6B/DjMTxPDXJ9XM5YnNHb5q6emSC7/IEDzjif01k4Ltl/RXVn
	xIt7dVdO/fT32VJPb7GEve2K2Z5a7GCtfW7JfuFc5beoh2EHemvPeFGRTR6ivTzlnQERNdr
	wPkmb2Tl3m8dwTfxIXg8yc7abd5COUNGdwDomO0DJwGoGSgPhfO3XfziUsK70lZwsyIZdVf
	NnAhpYlL21SNmctoKfudPswCWn2cRKj4Bi9BBO3S2On2/R66wqigC+7+9t8Jf9B+6bz5Tqt
	LjYPa3YhB2up3Is6y85Mv+yBZtlgI5mbYFS/QExtHMWS2b3AsTtvp/YV96/fweKzfJUWrsd
	h68y22YFXvFRIipTWYbILMNX2kOUK/e3RXArejx6irDapMFTNDTNkZX35wUkh5HoOGBuMUA
	RLIAI+Qrt8P/D5F9Cz54Lye3K6Hfug7Og0THITu+h9dsBoWRHUqtoDXziAH3oNN5MU//pwN
	eE8uL90KFAketNNnyAEQ9zd3vlTXF1Ci+qt/IJA5sjcv4X3Sc8R9/NxWPmEvtC2cL/z7P62
	Fw0Yn3xos71DGgI6j1hld7sUkT2uFrMdAn8fDmqKGdOZG8CUhsZ1ZubNuaq1Ti156o9wX6P
	vr7o/qzDjKBstr5bXas2esWvEunGL05gzI+agLb///mTbR3sE+fC/hkQZK2r/GYu6eQuC8b
	RxEVRLLUTwOC9nyEBiBEt4zPffaz/oJdrrRcUMxM1v1vx4shsfsqDDFs8JrCt7OOZm0mLvE
	nLEfNryeJ1kWDilV3AbyCErvIlgWhZUn1M7bdLIZFSx+cFUkFHKVGCYmNS9br728/AJZ2xp
	1YamPTqOZ7RpFO0R/M8b0CmUGgV1VJdOl47QyamUt3kF77X64X1DEIQo/VjlrM8SLmf8jdq
	wNaQ0NJSufOKxmO+MUYzft4hgWi5Kzu71wKlxyPdUxrfe2il6u1H7d5QcotDsIMfvkpmYhh
	0G8E4Vd7x/NHPurmrF1jjGC1gQOmC95FnjATrhHfKlrAmXjwDZ73/TFGBxxGXXhme9bgZZ5
	K4xH8w0nz9sNUY3OOjQFbLsdtOh9RGj3Q==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0


On 29/08/2025 15.56, Takashi Iwai wrote:
> On Fri, 29 Aug 2025 07:11:00 +0200,
> Cryolitia PukNgae via B4 Relay wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> Changed:
>>   - ignore_ctl_error
>>   - lowlatency
>>   - skip_validation
>>   - mixer_min_mute
>>   - quirk_flags[19:24]
> While I'm not going to take mixer_min_mute option addition, the others
> in this patch look good.  Could you resubmit only for those?
>
Ok. I'll quickly send a patch to complement the already existed codes.
And then we could discuss how to design it gracefully.

Thx for your review.
> thanks,
>
> Takashi
>

