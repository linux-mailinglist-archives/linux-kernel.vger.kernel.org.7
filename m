Return-Path: <linux-kernel+bounces-751123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0613B1657B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2255856734A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2C2DFA54;
	Wed, 30 Jul 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ck2eWV+D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bTqwthK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5915255F4C;
	Wed, 30 Jul 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896439; cv=none; b=R5bmtoFEYtkx+UDxBdO9Tu3J6SHA0N/5PQMz5I928OPTlImMBYqh1Ob86ScbzJGdawKRhL3sczM/Yr9qEGQM6ohtQw8oHK6Yv3Q1bSyFPpcyO4bWaYyacMjcoclGaB5BYJ+A7NUUill35nSHuxAYRLvAK4iyxJb2dxgWWi8nlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896439; c=relaxed/simple;
	bh=iqjScba0Jru1xnrG5GS55CIjbaQ3Y/kM9LH3gJH2uII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hyFWEKCDAjToSpZaXfUXhzjXZQxatyXRsUThEKaLHSFu/cZbXZtYWIO8tqFDRc2Jv2EPr0EKZxSQQTadV4XKV47bkHPpUkMtByCrxOIHVHK493jlTd2h9uoE9i50EJz7X9EM/4fVb2Q0OjBw2LnQ4p99WVIXZPWiGXxk89kIyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ck2eWV+D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bTqwthK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753896434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6UrtHxdKy52pBfQ4zCnkR5SXEYEpFGzade42gEmk0=;
	b=ck2eWV+DVg7Vl1QtamGwaj8+vEI178BKFymWDChSPnu3qjVa+DPBIZ6s4AuybKnPLuWkXM
	UjIzVLOGJdWPzTsSEwXysT9A5UxNwEfqmw7wczqlkj+ODS3NSGmxWl8d3l4js6Cr6n20lg
	bkuoifh633IeAKpjQmz6aMK+6/ZqVQlQcS9af+nxOlHbdJ49Z1+pSNn/HI5xiEJNi17NyS
	xB1HWWg7PYRHmg/42X6Swdf2NnPyAL93eqiC8uJ6Gtq4J3gy82nK3GzT9U7qGZFakMD81S
	H2Q+wesF4LzWTIYvpo6XJne589ngeOnvIyKz/iuf89+BpAYRbRPFyjHdS1A2Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753896434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jM6UrtHxdKy52pBfQ4zCnkR5SXEYEpFGzade42gEmk0=;
	b=1bTqwthKQq3ItaOVQrX8PxpfLDM54uPg1ypSxL3hE8PmGnZ4AE1ZECo2uA63nDGJSLXTX3
	W9crdAZUJ3PKYjCw==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Pan Chuang
 <panchuang@vivo.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com
Subject: Re: [PATCH v9 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
In-Reply-To: <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr>
References: <20250730062554.269151-1-panchuang@vivo.com>
 <20250730062554.269151-2-panchuang@vivo.com>
 <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr>
Date: Wed, 30 Jul 2025 19:27:13 +0200
Message-ID: <87ms8lio7i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30 2025 at 18:48, Christophe JAILLET wrote:
> Le 30/07/2025 =C3=A0 08:25, Pan Chuang a =C3=A9crit=C2=A0:
>> +int devm_request_any_context_irq(struct device *dev, unsigned int irq,
>> +				 irq_handler_t handler, unsigned long irqflags,
>> +				 const char *devname, void *dev_id)
>> +{
>> +	int rc =3D __devm_request_any_context_irq(dev, irq, handler, irqflags,
>> +						devname, dev_id);
>> +	if (rc < 0) {
>> +		return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
>> +				     irq, handler, devname ? : "");
>> +	}
>
> Extra { } should be removed.

No. Even when C does not require it, brackets should only be omitted
when there is truly a single line after the condition. That's just
simpler to read because w/o brackets the brain pattern recognition
mechanism expects _one_ line not two or more and if there are more the
reading flow is interrupted as you have to parse it. With the brackets
it's obvious that there are more lines to read than one.

>  From my PoV, it would look more logical to have the same logic in=20
> devm_request_threaded_irq() and in devm_request_any_context_irq().

As they print the same thing the right thing to do is:

        int rc =3D __devm_request_any_context_irq(....);

        return devm_request_result(dev, rc, irq, handler, NULL, devname);

and in devm_request_threaded_irq() invoke it with:

        return devm_request_result(dev, rc, irq, handler, thread_fn, devnam=
e);

and let that function return rc if (rc >=3D 0), which handles both cases.

>>   EXPORT_SYMBOL(devm_request_any_context_irq);
>
> On version 5 of the patch, there was a comment related to using=20
> EXPORT_SYMBOL_GPL(), does it still make sense?
> (no strong opinion from me, just noted that and wondered if done on purpo=
se)

That's an existing export. If at all that needs to be a seperate patch.

Thanks,

        tglx

