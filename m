Return-Path: <linux-kernel+bounces-894053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99474C49265
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB2A188A479
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA633EB01;
	Mon, 10 Nov 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FxaVYLTj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18572E5B32;
	Mon, 10 Nov 2025 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804592; cv=none; b=k0nlU/3B9cwAeXUEpbl37GCBcwgTP8fe15z3aOmU6NiR+eKuF4+rPrpHUh3XktpizJQt/4ypqndLqwspssVHpfrVbFka8ReQS4b+KWEAZ2XHbRrGghMMyOqF9XoDNohwnCm2tktSHF+5fzlykWa+RFCHtCkHWSN0lW34gkJeCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804592; c=relaxed/simple;
	bh=OESPtg0QOwwclP/3S8CVSXEpBkauIYZqgvBGBz7Ps5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t2ZFH2Mgf8umOpG6lEl61sv63g34YRvmcoysDorAbc/p4/b2BS90LU3T6163Gb3xpQCRH0ekKmVL3nTzf+XrWDGnHQuiyY1DOIpJruvR5/AHZNgYK3jM92jSYqD5cBhqQQAzvQApAA5ERHhBJdKRKzzI8wpt9lJcX4NlPivWDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FxaVYLTj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D434340B31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762804590; bh=47QyOiWeTR9vvXR8MenEG7NqPcMdJFe01J30p7r2pcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FxaVYLTjfVarwLPTLa0kF+9ON0fa7uD1Sz9OEUonPU+td9iH4vEqlFjj9udBQSsAl
	 Bv/NzcHs1Ow+IoN4Rrh3oS0iySDtNVxh43BvCPGwMD0RViGEx+Eq2kSETF2yXbhtP3
	 x2rMOuE2P4A6B4q33lYRwtrG8kfMcnYb0xcKK/6xKhUlPIY1REJrI50NutzbKopZKv
	 qz93q76tSSGm4Zi3o8BbKF/8r0SYsBIyfiZWAuFMYzqUUiZmEIVgJkrTflMUN3tOu7
	 1pUUo/RjgkKaH7bjA8sdqmbX0WSfbdZOGqgSGM87dCiDKEiTF0iOYnQQFt5/+aTL64
	 jpdFo9qMcIFhw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D434340B31;
	Mon, 10 Nov 2025 19:56:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Bagas
 Sanjaya <bagasdotme@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Akshay Gupta <akshay.gupta@amd.com>, Srujana
 Challa <schalla@marvell.com>, Vamsi Attunuru <vattunuru@marvell.com>,
 Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH 0/3] misc devices formatting devices
In-Reply-To: <20251104041812.31402-1-bagasdotme@gmail.com>
References: <20251104041812.31402-1-bagasdotme@gmail.com>
Date: Mon, 10 Nov 2025 12:56:29 -0700
Message-ID: <871pm5y842.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> Here is a small docs formatting cleanup for assorted miscellaneous devices.
> Patches [2-3/3] are split from my previous macro references fixup patch [1].
>
> Enjoy!
>
> [1]: https://lore.kernel.org/linux-doc/20251104022242.19224-1-bagasdotme@gmail.com/
>
> Bagas Sanjaya (3):
>   Documentation: amd-sbi: Wrap miscdevice listing snippet in literal
>     code block
>   Documentation: mrvl-cn10k-dpi: Fix macro cross-reference syntax
>   Documentation: tps6594-pfsm: Fix macro cross-reference syntax
>
>  Documentation/misc-devices/amd-sbi.rst        |  6 ++++--
>  Documentation/misc-devices/mrvl_cn10k_dpi.rst |  4 ++--
>  Documentation/misc-devices/tps6594-pfsm.rst   | 12 ++++++------
>  3 files changed, 12 insertions(+), 10 deletions(-)

I've applied these.

In truth, though, it's not at all clear that using c:macro brings
anything useful even when done correctly.

jon

