Return-Path: <linux-kernel+bounces-796798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E42B40748
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4580056754D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D63128D8;
	Tue,  2 Sep 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="cjcyQ2tG"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F4130DD1A;
	Tue,  2 Sep 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823878; cv=none; b=Io1Qm59rZ7AyiumBbRKToL2KKjjxkOwavOcpk9YZApaMPK4oiYn0c/iK2P6hjilpx4bqBjvRX/q24bKP3kPM6KH+GyZGG+iy+TBk3haldbZCyLKFFzlxovcTx4RtP1xu+/u/SQ6woS937oeliohreLT2RhIwKm+IMPGBVngaJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823878; c=relaxed/simple;
	bh=qC6Bd8iVyjS5U1kYekTHAKgwH131c50lwxwdWfUGSaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVz4iST6uZ/HiNWUFy0Qr2fG71/Se+Fwk+VHmW2P3Qozf/9KYQU4DqXzl4qvAKdPa3zN2wZP8hUTWCjlB9p0nHBI4asiJH6SAXwYpRXyC5wWTf19IGBIWyaubFaD2Be0FUUxOX7Q2L7fFOktYEUEyeqvJ3/FXH4lyF9tnpCMyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=cjcyQ2tG; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 06E382FC0057;
	Tue,  2 Sep 2025 16:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756823872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/WdFSq2k7gt13dUSe2prkF05CMnWfSpk7lbmmv06Uw=;
	b=cjcyQ2tGJzuyf+GVwN6vOxO4iQAqj2DbtVkOnhpI1ElWenIYzqTzgeM7xdDQPXdiBeJ0Qj
	cF04ER7b2fczuef8joq2Zw7dpwXDiewrXdtBE9etGIGiZX+YOqiVJh667dZ80Y2DaMeUZG
	sIIexE+051uNV3lcmaedWJADgM8qVFw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <c154022c-c00d-46ba-86fb-2030ccab0272@tuxedocomputers.com>
Date: Tue, 2 Sep 2025 16:37:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to
 spurious 8042 quirks list
To: Mario Limonciello <superm1@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Christoffer Sandberg <cs@tuxedo.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901164216.46740-1-wse@tuxedocomputers.com>
 <3830aeee-91d7-48ee-b67e-8aefbbd2124e@kernel.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <3830aeee-91d7-48ee-b67e-8aefbbd2124e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 02.09.25 um 16:15 schrieb Mario Limonciello:
> On 9/1/2025 11:42 AM, Werner Sembach wrote:
>> From: Christoffer Sandberg <cs@tuxedo.de>
>>
>> Prevents instant wakeup ~1s after suspend
>>
>> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c 
>> b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> index 7ffc659b27944..8b8944483b859 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
>> @@ -248,6 +248,13 @@ static const struct dmi_system_id fwbug_list[] = {
>>               DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
>>           }
>>       },
>> +    {
>> +        .ident = "TUXEDO Stellaris Slim 15 AMD Gen6",
>> +        .driver_data = &quirk_spurious_8042,
>> +        .matches = {
>> +            DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
>> +        }
>> +    },
>>       {}
>>   };
>
> FYI - this seems to conflict with other changes on review-ilpo-fixes and fixes 
> branches.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/drivers/platform/x86/amd/pmc/pmc-quirks.c?h=review-ilpo-fixes&id=c96f86217bb28e019403bb8f59eacd8ad5a7ad1a 
>
Sorry, i will rebase and send a v2.
>
> Also - a few other comments.
>
> 1) Do you have line of sight to a firmware (BIOS or EC) fix?  If so; it would 
> be better to specify a specific firmware release that is affected.

No

@Christoffer you have more knowledge of how realistic it is to get this fixed by 
the odm?

But even then, we still don't have fwupd support to get the fw update out easily

>
> 2) Shouldn't you also have DMI_SYS_VENDOR or some other matching keys else 
> set?  Or is it really all these boards with this specific name?

I was following the style of the i8042 quirk list where we also always only did 
boardnames

Ofc we only tested the boards the odm has sent to us

best regards,

Werner Sembach


