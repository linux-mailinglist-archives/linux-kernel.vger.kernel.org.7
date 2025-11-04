Return-Path: <linux-kernel+bounces-884708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2FC30DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48F460B58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F61C8631;
	Tue,  4 Nov 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ItDO9LWa"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37C221FDA;
	Tue,  4 Nov 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257683; cv=none; b=AToikEganly1QAd60OJWGbh7N9Epn/6VjZM60eAo/rmc+Hi5gc0pZF8/lRCd6DQhb07FdsMh9Tok0uqsu+8nia9jI+TPKwdYL/XegjAwXrY1PDyZT5NmgzZ0jBNrTgqo5TYK5lglmLAZnY2KYQvcoOsNbUCCbniTLwPBdoQ9UMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257683; c=relaxed/simple;
	bh=a7X2ieoeeBHhik2NMBWS0hcX92nNKZ41XvQ5qCU+rds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2SIGVaeinMJ79yDqS+VzP470ZXgc6MteB9ExNJ5+XzLw9yo1UYdwOScDLEEe3YkwTiuws1eQHTywIaYR/RgpECxfNtWPtgsiyKemWwlPmzmPkI0sG63nL5sG3vQx9f8bWu42tGTN/1rHeLvg9PcGdcBtHZSnJdOyr/xHxdqR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ItDO9LWa; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762257661; x=1762862461; i=markus.elfring@web.de;
	bh=a7X2ieoeeBHhik2NMBWS0hcX92nNKZ41XvQ5qCU+rds=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ItDO9LWaxPqilcNj4zw7hBt5uFMdc+CHhiJnmueqfiJ2OQToUK0Bh3cdCRpUzxZO
	 U55cwkZo3MRlNZsCm6u6sNVxMqWLQhXQqsPM7pjnisVoByJrwGihz5cPZSZuvoYPd
	 njpGDW6rgvHC7ZUE+UCFgC209KGhKy1vNBst8E4Gn/vUxdGACCj1jCCmNBxAG7RnQ
	 QkQ+XwUC0qRnF2pZDiPlx/EgJ61Pg38Imp/di4B8iY2XvF8aRp+WG+NuyyhnuJZDC
	 jegGBOg2e75grYxdb38xWw7J64buEsfzzQ8JE602KcENrffOyd+yBDXsl2bfMmYRr
	 Ij/nOWOY8C5YW48kXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1wHoZE2Baa-00v8mi; Tue, 04
 Nov 2025 12:55:28 +0100
Message-ID: <14b7e79c-6863-4cb6-a7c0-f4d7a01c39bc@web.de>
Date: Tue, 4 Nov 2025 12:55:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: greybus: es2: Use pointer from memcpy() call for assignment in
 output_async()
To: Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org
Cc: Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>, Miaoqian Lin <linmq006@gmail.com>
References: <b542b028-4f9b-44cd-aca7-5d4977c2faa4@web.de>
 <aQnmfCKoB3FJ5Jz8@hovoldconsulting.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aQnmfCKoB3FJ5Jz8@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vKLwVHeGwqaRD3NTFs76Ql7209GdsQ7uV/SSakVBW0pRPtSFXUI
 dWZFk7NICniOe/fQHTgdf4aRTzDOAfvg81qCVY6myAi6JW36Zo7CXlqd8CKdqJFvS2k39+K
 Yw4qArPsF9/uUr6n33E2MEaMd/oZjAI5hOHUgnleFI2GGrjeugaqxHsP+2jv8oNupAPlVLV
 j5ZJ5bKIXIoabN145AdjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vwHyoaP57aA=;4Mz6nCfH2guI37lfkrQJv6OQh9h
 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

> Since you know how to work with Coccinelle, at least try to come up with
> something that fixes actual bugs.

I became curious how development interests and resources will evolve further
for such more advanced source code reviews.

Regards,
Markus

