Return-Path: <linux-kernel+bounces-749822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29ADB15346
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219453B53F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9224728D;
	Tue, 29 Jul 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TlmBrXLH"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526246447
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816073; cv=none; b=IAm69mjQQXcNcs2XhPkvnx1kXhGaFXqjWZZ3RfnvgVLPqCF/Pik8ku0FC+Mw7aoG7fc55NoQA3ylzlOSGrbup/rCguOIAsyD4jEAJegNyoNXdfNNbdw0GcWzj8fTGsM1ANqRVl2PlJt4ozt6DemC0geClyFXZifU1tQuG+aQrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816073; c=relaxed/simple;
	bh=rIZ5gV0vjwE4JXxeYjnPae2gDv7uj2USnLj7Ki4n/7M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CApw6C0LqEdv8UbPdUrQ/9CaY64ZRupv+aMtoyExtSExzweW7WSmFWwKWx9ChebobnShcWKQiJNmePTjB8QHsqTO+xCf0qKmZSZLpCIglrNtDln+yfbBaB+S6u7PUvtK9TnIxdhA6e/E5+JXkhBrPUk/vbyZygV7CMGX5znJge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TlmBrXLH; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753816062; x=1754420862; i=markus.elfring@web.de;
	bh=rIZ5gV0vjwE4JXxeYjnPae2gDv7uj2USnLj7Ki4n/7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TlmBrXLHykYnQg8sirN716GLRqFCiRZ5xc724lZnymyvBhRWlldDYvim42ndo7XX
	 75JYTqxxm1V1Ua8y64B/IoGB4RmuYzb1o1/JmAHEVPG2xORqn49B5/skawXYZZzTE
	 w0MgOvDf6WpyqlBAZWSU33u0PD3LWsG6TJjQlx5l5pvAhMXDc9d+sbc3Kz1MqqO5N
	 t4wcOdLZZ2Vsp8mIWxXLJbdkOrHXTMa2Ke3TAmYe7d7kG7XeDrmuzQSlerTMXUbQO
	 1MCOH79cDto9LFFc+sm8DRD8u0He1dxgsv5/bGgaA/+h3yoN6ky6yKX0FkzhhzDr0
	 jLOGP3EO5nUiMpwNKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1v5x9k2uuD-00LOr8; Tue, 29
 Jul 2025 21:07:41 +0200
Message-ID: <ec847f0a-7e99-48d5-8f31-9151d58d3da0@web.de>
Date: Tue, 29 Jul 2025 21:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Elad Nachman <enachman@marvell.com>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250729084826.3222785-1-enachman@marvell.com>
Subject: Re: [PATCH] irqchip/mvebu-gicp: clear pending irqs on init
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729084826.3222785-1-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BiPrboK2rIHOkyDq+zdKEak6l79hHqE2gbNGijJAWTZZl8j/lN7
 ZLRwn4mJkxBqgVr6PoI83g0dpAAEOz1bk0RRSH6YEg3A569EGeO/4mtQSxwKHgXewRzB/YS
 tpNhC8FArqUj5qKKtFk8UKq4RGjlp2zC/zPh2Qhw2n2DlzWaeTZjowTnknHzzeRLu+srGxm
 +D6xsSQBUW2KQ14FtD2jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q2rq4npRCKs=;PJ1A+gkCCbgNzMBKuBf7DORFX2H
 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

=E2=80=A6
> from the I/O SB to the NB. Clear all pending interrupts
> when the driver is initialized to prevent these spurious
> interrupts.

Under which circumstances would you become interested to put more than 56 =
characters
into text lines of such a change description?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n658

Regards,
Markus

