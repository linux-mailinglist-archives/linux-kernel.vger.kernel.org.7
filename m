Return-Path: <linux-kernel+bounces-819301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D353BB59E49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912617AC93C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B83016FF;
	Tue, 16 Sep 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="ZytCOCc0"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC13016FB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041395; cv=none; b=nZX2TYxPVxkrBsae6STaHSrutKiDeNBzJUhbJMuSPuhxzJu/af847C15E14/mvlLKFtwAcPFUGeUqo+bip9RlLAL/W08Wf5vboyfSeBkzNsfPqlcvkIOluO9483skyL347wq3K85lJ1+tIF+78VfdaN2KJWotYO0aGKRqXj5vH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041395; c=relaxed/simple;
	bh=Y/9u0idWUq/YCSUmWD2pwuftK/iVnDcLbi5HmacD/lE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ez0RC0af17MKDxqQp8HaeE1uTN2fiFnhyKXi7tJzMU9GYeDhqK/bSd7uSdXrbktS9WGWMkAaxZoNW8ULx7WYDDF5Pl1JfMGLzhc2+xRnl3uz8QtPpikgGLnZLytoU69jgP42mkEjXCUVApOI2/P+/kPXclBfEnR3HHKhGSu0EN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=ZytCOCc0; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id F0FB12FC0047;
	Tue, 16 Sep 2025 18:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1758041390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88wZCM/SrwLZmsYHtzhh4mBHfhvxkYG0EV5pYfT2s8g=;
	b=ZytCOCc0UyBzQBeS28n5hsExzY/6pn7H9Lv9jMV9r9GphbDGZB1Skb7dVoG0RGY5WLFKQQ
	wzk7n3103G6JMgA8JgjuIXD90Ev7UIrpPJLbmqC8vN3/64ehzdVnJ5f5HPODkPxwEjHiy7
	4wuWdHu6sMaNsoaJ7EylURJYPUBMS8Y=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <ca327bf4-cd65-4c3e-b63d-7ac2b88b9cad@tuxedocomputers.com>
Date: Tue, 16 Sep 2025 18:49:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
 <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <bcd2fe8a-c80a-4556-9944-83fd2b493567@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 25.08.25 um 18:07 schrieb Werner Sembach:
> Hi
>
> Am 01.07.25 um 22:55 schrieb Werner Sembach:
>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>
>> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
>> a high power consumption in s2idle sleep (3.5 watts).
>>
>> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
>> a lower power consumption, typically around 1 watts.
>>
>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: stable@vger.kernel.org
> gentle bump for this not to be forgotten
bump again
>> ---
>>   drivers/nvme/host/pci.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 8ff12e415cb5d..d677080e67d33 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3198,10 +3198,12 @@ static unsigned long 
>> check_vendor_combination_bug(struct pci_dev *pdev)
>>            * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
>>            * because of high power consumption (> 2 Watt) in s2idle
>>            * sleep. Only some boards with Intel CPU are affected.
>> +         * (Note for testing: Samsung 990 Evo Plus has same PCI ID)
>>            */
>>           if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
>>               dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
>>               dmi_match(DMI_BOARD_NAME, "GXxMRXx") ||
>> +            dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
>>               dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
>>               dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
>>               dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))

