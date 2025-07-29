Return-Path: <linux-kernel+bounces-749174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF89AB14AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C431AA3D76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA1021D5B0;
	Tue, 29 Jul 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8eldOIx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="plzSfjVs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8131AC88A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780521; cv=none; b=gWAPX6A8qp17YXodd0+rupJ8SJIjZUEQjQe4AYHVUgtTAl9yxkc+DHt3WU1RegdywuGkOoICn3NKLRohnCF6zS8GtJx6Y1o8dGN4v6nJ7Lqt7kcfEdQIlnfooww4pcc9Xedap2wKkArkCTlW8zjYi86lVI3wIyCrjR2aI0IVuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780521; c=relaxed/simple;
	bh=aOBZ/tM1Qg2qhkWSPpZFdTdC9lpg4jmKd7J7zCISI44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PkyHxwRjQxroBwxNVOw3oJfTjTEw7gdQRpO1IEcQU3qKItLkQTmyKUgjJPrnFJptG6G2HQSgwd6otcfVSNU5agyNGTTgB6iCv8YAzPmymie2BMdncXg8JCr7cOm7lsSTau8QmcZzOMOLjQHqqsc/IUHO3oHRKLenSSbdUvFb3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8eldOIx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=plzSfjVs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753780515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2n5khdBGN4b+rE4+61xpylnCTZ6TU4RaOoD1tcNfbM=;
	b=j8eldOIxLrtnwJ3NNknKIoL1NjG95KDsIJCFIGJbrcmdgR7vNIYhPcE9zQgZ2sxroFqEan
	mEG19emzNNgCxGSO03UiBDU8Hto2cgwCevKfYJzzi5y4lbCSlLCg3M+qy+lslYYOIQaj0s
	S/7RAGBJ7B2Q3UMzKs8G88nx7kPO21AhKJvappLq2dyJ3IbNeGR2y2uAutuLC2jCGi6j1a
	iBlSjxAy/mfBPpg3JehjItzSlmXbvIKdnNQUGM6dRz2Kp0EE2E3aw0pwSJ6SWtt8tWXMIx
	hrbyAouSdT9AHRzF/7aMJvlSb/xaWj8oRo1Arjbs8cK1uQxgdMiTGlf1IR0iEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753780515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2n5khdBGN4b+rE4+61xpylnCTZ6TU4RaOoD1tcNfbM=;
	b=plzSfjVsOH4tki0fTO60zHnMFJGjehOx81yiZm4/WDz1jy8qx1PcwsUEvGHGfPEU0PQze9
	+iskM/X/V3/kosCg==
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, Pan Chuang <panchuang@vivo.com>,
 linux-kernel@vger.kernel.org
Cc: miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 angeg.delregno@collabora.com, krzk@kernel.org, frank.li@vivo.com
Subject: Re: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
In-Reply-To: <73a4fc1d-6852-4050-85c0-8c29b4165e4d@pengutronix.de>
References: <20250729081434.497716-1-panchuang@vivo.com>
 <20250729081434.497716-2-panchuang@vivo.com>
 <73a4fc1d-6852-4050-85c0-8c29b4165e4d@pengutronix.de>
Date: Tue, 29 Jul 2025 11:15:14 +0200
Message-ID: <87o6t3jr31.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 10:20, Ahmad Fatoum wrote:
> On 29.07.25 10:14, Pan Chuang wrote:
>> +	return dev_err_probe(dev, rc, "request_irq(%u) %pS %pS %s\n",
>
> Compared to %ps, %pS also prints offset and size relative to the symbol.
> This makes sense when you have an arbitrary program counter, but for
> merely printing a function symbol, I'd suggest %ps as it's less noisy.

Good point

