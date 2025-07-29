Return-Path: <linux-kernel+bounces-749372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B44EB14D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4363D3B814C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BCA28FAB9;
	Tue, 29 Jul 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtIXyz1E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mm8w37hU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF11E3DF2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791144; cv=none; b=u2RRCQgSIaf+No70pS1yhIJLfYG+Xh7fa4jl8PMONPPbIXB22pyF5kQdOGmjkJGs1q1FaDg3VwEGk+uoJahfbuse62yizpkg+ChcZLXkAJEXhVsucPjBSD373aqMf7znNW38Bpzlgtt4QY26/TylWnNHP01r407OkLmS0J51dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791144; c=relaxed/simple;
	bh=CIyIE85AOYRmCE225NpAy/BekkHdYredGw/fGNU1gvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhZ1UYuQUbuA17Nrsoe/+pQKau/W8kb+EfabMbvk2JeB3bkVSrthXwJomXMql0cHb/oQL9Wok14y1vCDwXbdml4W3UUPZgu4WVcHm2SIl7pTxKUnW33mqgqpsK/qH4P5nsRdueHq3diaDA52xVyNuWaoXNjblpZDqNL00yk1yEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtIXyz1E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mm8w37hU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753791141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbMRaOhTOnCc6MKMXbhpXd01xayO/NHZvZh8ufGEQ/M=;
	b=rtIXyz1E8nue8Ncq7zshh3rGtNwsIuS4mivROQWhxJyX/odmCKwhPvGbKxHCMvTm64R3MO
	38rXg176aKcZe8WAkCsKXE9SZjXU3c+VznUUnLVIY916QOxEds05+55gzBmlmo1uriOQi4
	WcYfnYQ7xKaI7k6kUuD0KqCbxBUy5hZIKi8rH2hnKL9ykJSyBOoJoPmPuNux2T9nz1DlyG
	WK4XxD+IwePiofYhcKkD/ey66/Rac09mSSrsH5zLYn8uJAyiEigSIeBEf0AjY8BQ1NjT7W
	6C/Wdu9Nj+HnCdSOiXTw9jyxrIXfzG19wb6XM4FMpp/3Uy7u/5ybinvXbLTOvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753791141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbMRaOhTOnCc6MKMXbhpXd01xayO/NHZvZh8ufGEQ/M=;
	b=mm8w37hUmI4spBn55arD3t79ppxbHC9aFo0OlUwfMUbkhzXYnU/tpLSan/amGm290pi0lt
	bOmcjQO9fCE8+RCw==
To: Pan Chuang <panchuang@vivo.com>
Cc: linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
 Jonathan.Cameron@Huawei.com, u.kleine-koenig@pengutronix.de,
 angeg.delregno@collabora.com, krzk@kernel.org, a.fatoum@pengutronix.de,
 frank.li@vivo.com, Pan Chuang <panchuang@vivo.com>
Subject: Re: [PATCH v8 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
In-Reply-To: <20250729114804.21984-1-panchuang@vivo.com>
References: <87qzxzjr3l.ffs@tglx> <20250729114804.21984-1-panchuang@vivo.com>
Date: Tue, 29 Jul 2025 14:12:20 +0200
Message-ID: <87ikjbjivv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 19:48, Pan Chuang wrote:
> On Tue, Jul 29 2025 at 17:14, Thomas Gleixner wrote:
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> Signed-off-by: Pan Chuang <panchuang@vivo.com>
>> This SOB chain is still incorrect. Again:
>>
>>   https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>>
>> If anything is unclear, then please ask.
>
> Could you please advise if this SOB chain is correct:
>
> Co-developed-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

If you are supposed to be listed as author of the patch in git, then
yes.

