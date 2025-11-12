Return-Path: <linux-kernel+bounces-896691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF377C50FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5912318874B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027112EDD76;
	Wed, 12 Nov 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KqAUPlZI"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06762ECD34
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933546; cv=none; b=F+LZgYZMo9Hiy6bjfMmyoQdLiKtdrn21QE0PbidtdZLOmDc0s49lAjSw7injkG4WmuVOW/llIFoz33dxDE43zemqEP3PzHPBm2scYGneNeVpjqjmVadNnjkqyRuELIZmoZ0zKpXj1+h82BjUFesDIkrFQtXact3S9Vri8WiV8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933546; c=relaxed/simple;
	bh=A8Q3W9GOg4SDcj10HeK5nxvnDoXE1pbP9m+0fdr7Gtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsYDkCjVGqo3O879LjlhgdUAzdgTn9yKvtaVzBQLKNi9au7fjqizzEfJwJJT60DNd6SoAuoHCb2mzmcWMNOQbVF8Upq7C6Orubym4DJJKGoPKXAmpDO9v6NYrsDb/2UNu96tlHbK2ur4XpmQI9UFz9uqXh3r7nv2BPytB74oHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KqAUPlZI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DC6E24E41655;
	Wed, 12 Nov 2025 07:45:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABFD06070B;
	Wed, 12 Nov 2025 07:45:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C9B21037184A;
	Wed, 12 Nov 2025 08:45:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762933541; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZskbQC/HIta14eVPmpAZpUFp8zsbAGiqAJ1RYH8Ue3o=;
	b=KqAUPlZIfwDu5dReXJMnEgV/WTTYuKhy4FV2kwy4v+Cqvqdke4JYH9ZNA/zHy/sawnEZuG
	lTWPMhT2zi2GyTzEu29Dgz7aqL+Znd5buSk/Adw2RCAiiUYAksR3NVPmpWnfE+mCh2J5/Q
	tpRFxtZClQPwGJ89BTygeDCkgm1wcXCeOfu4rjM/z0BxPWg5rN258u3pzSO2fuN0tIBVmU
	tvnIYcYn1/WapecsixFHl1fMH7bmvJvk1QLAlS4ndgoZuS6GENn7Clk6+9s/8bLCkLRAIf
	1mZzcboJ3vBUs6yAGvp2t1LS5jkmEiyv2uyS4MkarKnD9kQzlu6QM+SfEeXQkw==
Message-ID: <d44e1692-d8b2-4d15-bcf4-7ae55875b501@bootlin.com>
Date: Wed, 12 Nov 2025 08:45:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
 <20251106-ksz-fix-v2-1-07188f608873@bootlin.com>
 <20251110182713.221a058d@kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251110182713.221a058d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 11/11/25 3:27 AM, Jakub Kicinski wrote:
> On Thu, 06 Nov 2025 13:53:08 +0100 Bastien Curutchet (Schneider
> Electric) wrote:
>> Fixes: ff319a644829 ("net: dsa: microchip: move interrupt handling logic from lan937x to ksz_common")
> 
> This commit just moves the buggy code around, the fixes tag should
> point at the commit which introduced the buggy code (first commit
> in which the bug could be reproduced). I think other commits suffer
> from a similar issue. Please look a little deeper into the history.

Sorry about this, I'll take a closer look to find the relevant buggy commit.

Best regards,
Bastien

