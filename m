Return-Path: <linux-kernel+bounces-889848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA297C3EACF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3070A3AB320
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DD03074B4;
	Fri,  7 Nov 2025 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UfLkC3vY"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CD305E28
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498890; cv=none; b=cPYvFGozBizLkmCfQhOek6/0pX3axdiEIdqXxoMmQYzJycCMjHsh8Ye0ZfNw0HcMhL2Awf9nf5ZybiX+tTw9C5YHj3aNUqLCtY1wL97jfE1sIMielemxwPPRAqaElb0IeVopaLL8IKeCsdbRXwDhoYOOYvVUSMt+QC2obM5xEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498890; c=relaxed/simple;
	bh=47YF6al567fyzKMseSjqVlyZ1q6bZ1jP++MEpQf6R6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVHNdYF/1anKqbMmFttcSMRsP05lTR1iHDohDcpl/06wFLr5I3W9kW+WKIYbJmvxUY/LsoUKOUnSedQpK1Sn5lDhMKBAY6wV5eNjWaezCVS6AKS9eZXKoc98QAtN0SwrhChh4GLpZNCngPpSI8mytyOMYwHjqaqJ9pZM4T6H5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UfLkC3vY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762498873; x=1763103673; i=markus.elfring@web.de;
	bh=nI3CXGkvAFlQIUQ/j6GtegTtizhopghGL4+tXDlE14w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UfLkC3vY+o1sZDmcHZH9kkBYo5A0K9b8bVOlqP5/TJATwA7bbzxajYTnhVtoGZ1v
	 ex0VRgryWn8miVR5b4pBfVt2nrpN3lkgKtXKJzZ2n25jNcNn8cYpTe/N/MKh0XEY6
	 Ffx6j/j+h+oriIhLiqNPD7hBVPEeK9V56WGyuSccZF31kVKSNKJMQQsMHWuU4H7C4
	 c9qJqVanAYD5aEnnV8JlfG1Y2kkOLt3PYBunTlfi2PXceJpEqw3BS3dXPZ0h/MG4b
	 HqRAiopz9X9enfr3LdesErstm9xuXqqf9qC203q2W82ZL9wdScjusnLAX1wCEKt6o
	 XbQ52VqyJE5Uk+zYTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1vcltX2w6A-00VV68; Fri, 07
 Nov 2025 08:01:13 +0100
Message-ID: <396b2d11-29ca-4fae-97c3-7280c879cbfd@web.de>
Date: Fri, 7 Nov 2025 08:00:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ubi: fastmap: fix ubi->fm memory leak
To: Liyuan Pang <pangliyuan1@huawei.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 wanqian10@huawei.com, Yang Liu <young.liuyang@huawei.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <dff05531-f5e3-400a-abf0-a5307c50357e@web.de>
 <20251107021137.874150-1-pangliyuan1@huawei.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251107021137.874150-1-pangliyuan1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+WdNf1CX4372udFUpsF6/LvjYNnzhBvXTIekGJH2+DckSbHGF5E
 KoK4pXI9XszPfc2Ya1kPKks6HpB7Flus+UTohWIhQk646qDuDebK+VnuXPKQCSxY+EZ8tRU
 oBd7DeuzeFONsGjtWRo9njPeLuyJPIf8vaXSxPQ+vC/whSTlyRaA8jY3AGLb1WtV2Z6LblB
 k3efc22BnQhRpj5YdV+tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oL26OuA+5Tc=;cxozs17R1289roWpigGmXh1D5vB
 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
 bf0AYeSraKjLd2TBSl/47vZ2co=

>> =E2=80=A6
>>> +++ b/drivers/mtd/ubi/fastmap.c
>>> @@ -1644,3 +1644,15 @@ int ubi_update_fastmap(struct ubi_device *ubi)
>> =E2=80=A6
>>> +void ubi_free_fastmap(struct ubi_device *ubi)
>>> +{
>>> +	int i;
>>> +
>>> +	if (ubi->fm) {
>> +		for (i =3D 0; i < ubi->fm->used_blocks; i++)
>> +			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
>> =E2=80=A6
>> +	}
>> +}
>> =E2=80=A6
>>
>> May the local variable =E2=80=9Ci=E2=80=9D be defined in the loop heade=
r?
>=20
> I think it's better to leave it as it is, most of the code in
> ubi defines variables outside the loop header, and defining
> "i" in the loop header may cause compilation error in some old
> kernel versions that use C89.

Would you support to reduce the scope for such a variable to
the code block of the if branch?

Regards,
Markus

