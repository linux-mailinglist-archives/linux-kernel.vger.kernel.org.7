Return-Path: <linux-kernel+bounces-856757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D16BE4FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCA31A6343C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3322FF22;
	Thu, 16 Oct 2025 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gtf4bb+r"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7A22173D;
	Thu, 16 Oct 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637684; cv=none; b=cdPb40uVnUBxvACnIenj8gYdv0I0lZqE5GApwsAiF6L/RyY0VLYCzcXkgSWqLnG64w4nt56PXRRVt+X111WQO1Zq4Bz/anemWafeuGfGG/XboKqWv8A3lGz6ov2CkX7AorVPU9VR3i880ZUcH94FVkqliW5zQmZngKxLGrEEyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637684; c=relaxed/simple;
	bh=HHVVaxsF89op4pNfdku8FJj9VGD8pE674ULayMgG5nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJj7WFlx0e6I0Dxt5dj115zz/jd3sYYNdCmgYG7GOPz1xiyJGbqHllwxvebGMfUHdIYDZACf3/WBQdj+quUib3OWJDnp4L8vI0NbhIDgLW41wQbGr4VGihHLu38vqJZrhzsrjLbxAu3CB/gYQPssxDH9lJOa6bKigIc3grpgWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gtf4bb+r; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637679; x=1761242479; i=w_armin@gmx.de;
	bh=Q16D+6aJBQlt1JfZ0aZTlA8PpUun+DZc60iL3nXImIA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gtf4bb+r/JixMpinXBD9+VZLSLliVULbZcIEH/fm4BQoymwpc+JblfzPI3GSs0+3
	 z0nizHUjlEC28QOgiuhem+kkYGiLyXGqc6Tl6YvJ3lRQUU/DU4Avxc5ST+JaVUGsP
	 VZWO6wQi9JEqQaOIMl78jVNVMXGAvI4JAf8C5NdVAgjWtJuykT37NnfS+rtE+FVLe
	 TD3nWTH0X+eF/pLkktNQ2bEmon0Yhv7crHuWnf2FXRljuDT9zjZ6JXySlWUdAQQo2
	 TmrruuML/Uz7YEKoACQwFnPKfEQ1vxUJ5yo7xc3yd7oEpIWfBUtve9tVXUzq2GP+p
	 Vu9EMoYNLxSEaoYelA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1uHUBu18BR-00v07x; Thu, 16
 Oct 2025 20:01:19 +0200
Message-ID: <a112b38b-aaf3-4c86-9469-0f60723d5443@gmx.de>
Date: Thu, 16 Oct 2025 20:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] platform/x86: acer-wmi: Add fan control support
To: Fa-Iz Faadhillah Ibrahim <faiz.faadhillah@gmail.com>, jlee@suse.com,
 basak.sb2006@gmail.com, rayanmargham4@gmail.com
Cc: kuurtb@gmail.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015192551.321200-1-W_Armin@gmx.de>
 <5048620.31r3eYUQgx@cacher>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <5048620.31r3eYUQgx@cacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqBS/0LAlaKLokzzUj9lIOhZN7ytNhevNQ/6uF3alGdNW5vRa+p
 R5889WbwZtAsyjDuXw7PSdSlJW8tx7zS8HzPPl7qp0ulKw4GQxRpgLn0EcPL3lSXbnmDMpK
 /MksWW83tc5ix81gTRXA9IS5jzyRRsINsOqzzsrMEqPzPUwLKAcWjrFvo63aFbhdbG9OjtF
 Wvq+ouxpaAEcCK8ZfI42A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:urpPFHPCDog=;oWgxPtN009rjSQ4O1lqHuytJrQn
 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
 BAdFMEEEzjQzup2fDjVwXSauv0o2ZySJWX4=

Am 16.10.25 um 19:23 schrieb Fa-Iz Faadhillah Ibrahim:

> On Thursday, October 16, 2025 2:25=E2=80=AFAM Armin Wolf wrote:
>> This patch series aims to add fan control support to the acer-wmi
>> driver. The patches are compile-tested only and need to be tested
>> on real hardware to verify that they actually work.
>>
>> I CCed three users who requested support for this feature. I would be
>> very happy if one of you could test those patches and report back.
>>
>> Changes since v2:
>> - get rid of nested bit masks
>>
>> Changes since v1:
>> - remove unnecessary blank line
>>
>> Changes since RFC v2:
>> - improve error handling when setting fan behavior
>> - Add Reviewed-by tags
>> - whitelist PHN16-72
>>
>> Changes since RFC v1:
>> - remove duplicate include and replace hwmon_pwm_mode with
>>    hwmon_pwm_enable in second patch
>>
>> Armin Wolf (4):
>>    platform/x86: acer-wmi: Fix setting of fan behavior
>>    platform/x86: acer-wmi: Add fan control support
>>    platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>>    platform/x86: acer-wmi: Add support for PHN16-72
>>
>>   drivers/platform/x86/acer-wmi.c | 292 +++++++++++++++++++++++++++++--=
-
>>   1 file changed, 269 insertions(+), 23 deletions(-)
> Hello,
>
> I've tested the patch on my PHN16-72, this time the fan control for CPU =
fan
> works just fine, but GPU fan control doesn't work anymore. no logs obser=
ved on
> dmesg while changing the speed of either fan.
>
> Thanks,
> Fa-Iz Faadhillah Ibrahim
>
It seems that i made a small error in WMID_gaming_set_fan_behavior(). I se=
nd a v4 patch series
with the necessary fix.

Thanks,
Armin Wolf


