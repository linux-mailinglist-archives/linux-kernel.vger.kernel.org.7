Return-Path: <linux-kernel+bounces-741279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A24B0E25C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0F0567B60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070227EC78;
	Tue, 22 Jul 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bibkTVKv"
Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D825F7B4;
	Tue, 22 Jul 2025 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203917; cv=none; b=US+NhSf6zaHv45gi8/xo0OrJpKkPDYfEKoc+J2l4nMwIutys88j0pvX+TJDYpqPXb+0tr1/FFfb0GmnKtFUkb6RS1yPbHg+jHssMOuY3LCKffqRzrpRtT8qnUmBkTgwAJtJuek88QO+Jaz+KUO4t7dCYUXV18iBoepxZTv+mUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203917; c=relaxed/simple;
	bh=MsbOBqCdhvkmcT8garlNkx4qKXvrWtrbDvujJZN40gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epO3Gv1gfXFFDZjo0QJI6nR1S/rAg1UkBeYoKzj+0AuEm83EO8kPkE1JU56oPBmArEYYRwrecQuklwBBwlgBznKff6UI1SOMohUuLcO8R4wuIl1c2ey4KiH/uEUS1QhV77lEd1K9V1LwKbXq7s76wIF+bemZUcCJsN3db7rDXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bibkTVKv; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id eGPCuzqqs7oQQeGPCuolrN; Tue, 22 Jul 2025 19:03:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753203839;
	bh=1LCUcL331vbtCzLQERTjWDc5Tg4pTHQ4IJIaPEGil/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bibkTVKvhqyulsY6SdBhylzp97cisGjwyScpE7k7Yf+TUaaP5+B0vWFPGI8XMyMR+
	 tEuEcFpwIZ0jyD9T01jJZ5Zq3HZ/zqfdSSNewExqUp5oiQ02CpJo3RD8HNnjXpwJ7l
	 jf0PCyZhinbPAR9q0gSKIckIk8zlYS1SJienqmdt8WkTsazwoLbbEB0Gz3w2YdSFjW
	 3UOjV+0Jc3PbF9UvO2J+3i+08YVatQeoOLyHFUkcAYQ7PwbQspoePI1msCrf4rN9Rh
	 UQjhZ9QUbdA5+9x99LBEfFsbMGkDNH7renvIG1NI+SWG4epBYY2LkJHpDcxORVMH+s
	 OMgir8sKITTFQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 22 Jul 2025 19:03:59 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <ac2ace68-e88f-4055-9b01-45a2eaab50fc@wanadoo.fr>
Date: Tue, 22 Jul 2025 19:03:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: caam - switch to use devm_kmemdup_array()
To: zhang.enpei@zte.com.cn
Cc: horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <e4c297a7-1ef1-4c39-8daa-8acdade47508@wanadoo.fr>
 <20250721100618249bnR0yTtsh0IeGzAdt8Fuu@zte.com.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250721100618249bnR0yTtsh0IeGzAdt8Fuu@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 21/07/2025 à 04:06, zhang.enpei@zte.com.cn a écrit :
> Thanks for the review!
> devm_kmemdup_array() will call size_mul() to combine its third and fourth parameters into
> length for devm_kmemdup(). So keep the same value sizeof(data->clks[0]) here as before.
> 
> 

sizeof(data->clks[0]) and sizeof(*data->clks) are the same.

But the second version is the preferred style. See [1].

So while touching these lines of code, updating the style looked a good 
idea to me.

CJ


[1]: 
https://docs.kernel.org/6.15/process/coding-style.html#allocating-memory

