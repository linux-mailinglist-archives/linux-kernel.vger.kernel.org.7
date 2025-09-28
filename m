Return-Path: <linux-kernel+bounces-835207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE07BA6805
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D51711FA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C28222586;
	Sun, 28 Sep 2025 04:56:49 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012FB1EBFFF;
	Sun, 28 Sep 2025 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759035409; cv=none; b=GN0HDyhN7/1k5yhJ8KjNfxIJvS4VsYcvHOCZXyUXn2crzFf+98FN/qBVraa08Debf5vVIQJHx6F3LuZf2LcR5lRYWBEAJbdI3RJrdHAEVbnH1riclDdcBmYtIgM3jFBUbf8p57DtCJzZnWCda8K7XUMuDAI6q/UyDOwiTt6W6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759035409; c=relaxed/simple;
	bh=a17ZsfBt2wEIAzGeIsUwIA+//wu3wUHYHBwflOCrFzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxTtNv/V30Q8fMzgVaE2OVKG1Ky0Y5+GU5kT4eukOgJgyKtF390pPUEUYzvY+I3a/tBSoHouRitpCdAwf3pZYepTZC1Z4sqMthllp6gROZzgjq62G2mreXvHkTdukKRG33Autml/2pG/MRXUo5GpUM68Ve55+QOzkwEka5Hqrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.29])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id E13D0B220091;
	Sun, 28 Sep 2025 06:56:41 +0200 (CEST)
Message-ID: <83fc0f4d-1e7c-41e0-87b3-bfcb84a0450c@freeshell.de>
Date: Sat, 27 Sep 2025 21:56:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <C16FB37F0982124F+aNi46yQc_e-gCIvL@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <C16FB37F0982124F+aNi46yQc_e-gCIvL@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/27/25 21:26, Troy Mitchell wrote:
> On Sun, Sep 28, 2025 at 12:16:48PM +0800, Troy Mitchell wrote:
>> From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>>
> My SMTP client messed up,
> and both 1/2 and 2/2 were sent from the wrong email address.
> 
>                                          - Troy
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Confirming it is showing up now. Thanks -E Shattow

