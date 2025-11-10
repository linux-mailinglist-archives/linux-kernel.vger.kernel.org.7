Return-Path: <linux-kernel+bounces-893464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF9C477F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37AB13BACB3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96C315D3C;
	Mon, 10 Nov 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QfqhNo2/"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76A1A7AE3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787481; cv=none; b=Mt7iG8pKaM4M+JuU/Y2P1JiDN7G1g1yCE7VkMi1pxYpRa8AKYtbp/fmmWr5VKbhzxmyKNOvL7+EXKNAfSd6tfgluBkTM0v5RdflYiSSt/l85vAqA42qH7PvsFN/p/v9Xo/hPi84tIY4NnG51R7PaoV+ev/gViUWKh2sETIcQ7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787481; c=relaxed/simple;
	bh=FPlXeQmlbpUeuFc/ceY/IQijGNTe8SceVdpRkBYmgd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRXstDSyK2qJiBloBvyq7fJ4MLTOXEtXhmVpC/C/U//HSxom6SniKi7jIj4Op+RWlTYJmym7YQinwW/SSLhssMx2CsPeCdnRFwXzIRiPDNZhmpaDXg6VjGa2n5c//KgVD7Zg7UA0eK6rcuJTVKsv8iBvCDFqIJFcXZm1Gq25Fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QfqhNo2/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E87B1C108F0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:10:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61D74606F5;
	Mon, 10 Nov 2025 15:11:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12B06103718D6;
	Mon, 10 Nov 2025 16:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762787476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wJUr/0EUzjfCaK+KSuA5yM/imTi7pw3eemoaLfp6LKk=;
	b=QfqhNo2/G3HQxs/W7N3+/hwen5dY46GEKIU3Wnc8Iksx6Avkh9be9p7gLH9zzDmSM7tH/a
	AaYhmj/U0WQC/e2VYQkRUX49MQAZYzFbJS85OeTIkwSzXSRRJmHL5b6XaOORgjJfBZKdXQ
	UuHG0qnKFnyDT9chCkvfSd5i1hod3ks1hDygZy1RSkHSsdJuqSNCIR94z+tG5X0MaAA8nw
	GzI5FvThdAjWFBBpJis8C23MPtRd+I+3VdcGWmVmGulP5QGJu/qSyydRhvqiPbNb94VhbU
	dJQmLalY5exmCVEcdro31ZxgAr643zB/oYCOuFIzYMJKMyR3DA6BPIZt5KI9OA==
Message-ID: <5ea31c61-7bf5-441c-a7c1-e346039d03d2@bootlin.com>
Date: Mon, 10 Nov 2025 16:11:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] firmware: ti_sci: handle IRQ restore in
 BOARDCFG_MANAGED mode during resume
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, richard.genoud@bootlin.com,
 Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
 <20251017-ti-sci-jacinto-s2r-restore-irq-v1-2-34d4339d247a@bootlin.com>
 <20251107115457.i6tkt466bp62mwp2@whiff>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251107115457.i6tkt466bp62mwp2@whiff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Nishanth,

On 11/7/25 12:54 PM, Nishanth Menon wrote:
> On 16:44-20251017, Thomas Richard (TI.com) wrote:
>> In BOARDCFG_MANAGED mode, the firmware cannot restore IRQs during
>> resume. This responsibility is delegated to the ti_sci driver,
>> which maintains an internal list of all requested IRQs. This list
>> is updated on each set/free operation, and all IRQs are restored
>> during the resume_noirq() phase.
> 
> Couple of drive by comments:
> 
> clarify why is this not handled by ia / ir driver?

A patch was sent to handle this in intr driver [1], but the feedback
was: this shall be done in ti_sci driver [2].

And now I have an other argument:

I'm actually working on having functional PCIe after a suspend-resume on
J784s4. And I noticed that set_parent (sci-clk driver) shall be restored
during resume. Restoring irqs and set_parent clk config is only needed
on Jacinto platforms. The sci-clk and inta/intr driver don't know if we
are running on a Jacinto platform or not. The ti_sci have the
information so it can take the decision to restore irqs and set_parent
configs.

[1] https://lore.kernel.org/all/20220607061912.12222-1-a-govindraju@ti.com/
[2] https://lore.kernel.org/all/87r0l96f0e.wl-maz@kernel.org/

> 
>>
>> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
>> ---
>>  drivers/firmware/ti_sci.c | 143 +++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 135 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index f9f1a67e8e66b0a4048fae04ce31be54ca5cba7a..a211f8805dd21c7675b8cefd61929ecfda8e0f7f 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -87,6 +87,16 @@ struct ti_sci_desc {
>>  	int max_msg_size;
> [...]
>> +
>> +	irq_desc.valid_params = valid_params;
>> +	irq_desc.src_id = src_id;
>> +	irq_desc.src_index = src_index;
>> +	irq_desc.dst_id = dst_id;
>> +	irq_desc.dst_host_irq = dst_host_irq;
>> +	irq_desc.ia_id = ia_id;
>> +	irq_desc.vint = vint;
>> +	irq_desc.global_event = global_event;
>> +	irq_desc.vint_status_bit = vint_status_bit;
>> +	irq_desc.secondary_host = s_host;
>> +
>> +	list_for_each(this, &info->irqs.list) {
> 
> list_for_each_entry_safe ?
> 
> How big is this list on a j784s4 class device? is it worth creating a
> irq_desc_hash and using a hlist a better option?

I did the test with arm64 defconfig on j784s4 and the list has 43 elements.
I'll look at the hlist.

Best Regards,
Thomas

