Return-Path: <linux-kernel+bounces-855372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12BBE109D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9A19C1FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216253168F3;
	Wed, 15 Oct 2025 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SguM9pC3"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531CC200BAE;
	Wed, 15 Oct 2025 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571539; cv=none; b=KMGRU1VcOaIqtHTFIwG4rqUPZ6eprJ28lWmD9JWaw3XOpcDUcHp2t70fuOzwc29NW+yAD0PUDqmvM4h67G60fYW0h4Ks3gf5jsekv8Xz74a87BdPut4PciRetYeswfrGk7ZVOIW9gcplDkcbp+YuY7gQ0h96ASFj/ZJPRybAx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571539; c=relaxed/simple;
	bh=eM+xzllgaNf+J/AbvykNCER1vymFd6gfIcOSE3t5oio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSixVTtaKRmgDqUyC4U23E5FPGYxBVBFFnlVZEiFZfYqgyKWeLobhbHdgTSH7mTusWI1QpLYEELG16YiUvPjjAHp5P9z3Xl7b9arD6ICLyfa5gZj365TpgwVoQCyjfw0Ghbtc4H98K45l2ozq14MyqRw0TKOftcPaNThIBe4UX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SguM9pC3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760571529; x=1761176329; i=deller@gmx.de;
	bh=JCI+gHutC8LvosnuV1w5OOy74eNUL8ZnzOJ13O9B9Co=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SguM9pC3Fj38HMgwkQEz/lXTM1xGTQLnidA9JGNeB0LVDmXS4V4IcfqpHnWA41bb
	 QkGZvqpZAGH0pn4FIfcLRyv1kVf/TI4G4wt7+PPG2kTKgK1nAB07F8C61VZFy13qu
	 Ko+8Shd+rV7MU3J6V7Y0Z1LjMU2iNR5zhdkS4i7Ymzz5vA15reu/aO+Y2yrPcoCqf
	 h+LEMCC19jXez1+dZIhjesQe3HVW+J9F8a10w709qiaf66d0/7Su1qvArf1xsJe6h
	 S75OcDZT5cgbE6Z6T5AjgnooEZ8JqRzwOnj/fTR/7Hq4msD33P11ynqqWCY7AW9jQ
	 BdoVT/40uO/BKn/SwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.172]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1v1Rr23rxU-00FKuR; Thu, 16
 Oct 2025 01:38:49 +0200
Message-ID: <4f2872c0-01b4-416d-ba7c-63ff4b3b02ff@gmx.de>
Date: Thu, 16 Oct 2025 01:38:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/entry: set W bit for !compat tasks in
 syscall_restore_rfi()
To: Sven Schnelle <svens@stackframe.org>,
 John David Anglin <dave.anglin@bell.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015212141.289981-1-svens@stackframe.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20251015212141.289981-1-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fGm/oovyswMjBGmvOQbRiTXI3T2j2obgy3Pdu2eTAIqg5pZpdie
 +OSbq1/5FGvsKJcB8VRBO1nuDfOS4DLPwnt4+MU6SsSuUJDad4MOF/nwV5Nt+nHvqKL1Akk
 WVtk1B9R6yK05tNFw9Xrm2J+C9iQpDESj+ryPNiscrtCvjH8LA+dWkGflEnizkdyPHhFtER
 s5M66yEjhaokgBykPD7YQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5AhIXEMcLrQ=;Gu5f2aJ/avDFwu2mAY9vbmxmt/B
 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

On 10/15/25 23:21, Sven Schnelle wrote:
> When the kernel leaves to userspace via syscall_restore_rfi(), the
> W bit is not set in the new PSW. This doesn't cause any problems
> because there's no 64 bit userspace for parisc. Simple static binaries
> are usually loaded at addresses way below the 32 bit limit so the W bit
> doesn't matter.
>=20
> Fix this by setting the W bit when TIF_32BIT is not set.
>=20
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>   arch/parisc/kernel/asm-offsets.c | 2 ++
>   arch/parisc/kernel/entry.S       | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)

applied.

Thanks!
Helge

