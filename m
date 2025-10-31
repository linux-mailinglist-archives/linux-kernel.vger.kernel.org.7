Return-Path: <linux-kernel+bounces-880999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C3C2728B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4763A68D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB43254AD;
	Fri, 31 Oct 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pR43qD0B"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E06304972
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951750; cv=none; b=sYiD5WrgetJ0mGdyHAbwnV2he1kKRWvjLhg2HEKJJUVGGqDqhGw7e0K5l5bAXAwwiMm6lXJ4PC6mX6vmKUSgGVhfSTdYghAfL8a8k32LK3F3xHb6wf042uFiMrqM826UCTA4AY2lUErsq3etx8I4dVRY9wEksZ8TT0VvLsNFYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951750; c=relaxed/simple;
	bh=57VhmDuRHUjc3IkHGp90TyMTM6KeK3PpQ5w86E7h4TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPurWXEtRD8udWz9zImhYeU4EOpLGJxMCgtuvtRe0jqcTekRO9VP0PB5f8adWUH3VsGj73Mm9WzhtpN229vxrt7jnqLzBly+CfPeEdhkOufITceLuZcXwRmpGFoIT1UfaGZCnHHcMXrh2QcheW2KPWXcXL+66+rgctfb+xWBA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pR43qD0B; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6352E4E4144A;
	Fri, 31 Oct 2025 23:02:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3855D60704;
	Fri, 31 Oct 2025 23:02:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 764B91181ABA6;
	Sat,  1 Nov 2025 00:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761951743; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=c/QaNAx1tRBSa9Ke44ALpXrcuaXoJLXMTXTJpcGjHng=;
	b=pR43qD0BQgfP2bk4bYk+XmgscS7dA2yTNheJrMQw8mK57QQYyJYxjbTX9JrpdKi++ikKiu
	rixYJlcEDH/0/GQvMh3/w01XOrLwwLeNL0fIkp59kQZljtLsKW7zbSEhf1ixzfuIlgRJ5p
	UC/AjLyR3WvshhamV4AUqGdkgfVhlMRSH0Qy6aIJemH7BlF+O6WMYJpIO2giF60DYV34nv
	6Yyzog30SnzvftR1YaBNEmiGoLbPaOdgxAVFspvSlEKwpUr/NZtDm7NLLIGw3El2YDjPa8
	0TGdm8x3NbuiYUr/n1bG0YPGdW2h6Kuz4o9v6PAQfXGaFqCn5zsIKfI0jzGTIg==
Date: Sat, 1 Nov 2025 00:02:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: yiting.deng@amlogic.com, xianwei.zhao@amlogic.com,
	Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: amlogic-a4: fix double free caused by devm
Message-ID: <176195170903.843198.16395014691314193568.b4-ty@bootlin.com>
References: <20251020150956.491-1-vulab@iscas.ac.cn>
 <20251021103559.1903-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021103559.1903-1-vulab@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 21 Oct 2025 18:35:59 +0800, Haotian Zhang wrote:
> The clock obtained via devm_clk_get_enabled() is automatically managed
> by devres and will be disabled and freed on driver detach. Manually
> calling clk_disable_unprepare() in error path and remove function
> causes double free.
> 
> Remove the redundant clk_disable_unprepare() calls from the probe
> error path and aml_rtc_remove(), allowing the devm framework to
> automatically manage the clock lifecycle.
> 
> [...]

Applied, thanks!

[1/1] rtc: amlogic-a4: fix double free caused by devm
      https://git.kernel.org/abelloni/c/384150d7a5b6

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

