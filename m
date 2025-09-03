Return-Path: <linux-kernel+bounces-798782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCCAB422EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765251743EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F1308F2D;
	Wed,  3 Sep 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="d1rLcnuJ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031130EF6B;
	Wed,  3 Sep 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908072; cv=none; b=YEXF0+zQ9CrL4HnxevNoaQjZaHD+j94QP1hkIynkKaDV6xyc5y6LGe6p74hUa0ZwZoXZSNFe9MM7LL1f5o25ObwY9KDXP+iD2hVYWPGToP0cVsdkmQEkmSZOMIOIK+e7meKt04glIU1RpoDgangrAaOsttBO30DBbnli7Sui+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908072; c=relaxed/simple;
	bh=ZqQmkOArRuHnXAxn41bAke5L+mCbr9OLiPfQMEf3pmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZEDEUfIKJslS6fMlzcE+bLNb6ze1wsc+YUCvahFfGQkjyhcepUbFPkXO1r2HTRUyLrjuhqtc23VsOrTmaekY729u07Y/8Xa4gdvAR9pcdOBdM+FnENvUEPHFcSW43fn0sQAlSGvLOO3NzK7E3uE4u1MY4DDJQkUNvLOgA/onwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=d1rLcnuJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C3F9E40AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756908064; bh=CUBTmrJzlHEyvioYPG6dRMuebJKjGgnlUmA+FpZYTdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d1rLcnuJ70Bdcnd6BGrhB8gji9pR6Y1PLBLs0vnsBUjGXNK2OHn7M66gh49hk8Qux
	 2DX7OQsSV6eNQ3JtadwQ0LWkDIOPDiUQcfs+2D7MisdpCDCB3JEQIpgockV/ezsYb1
	 FEGjyF7taom2AH737SHRdoktAuhWHKl2q8j3VK4sQsmQBWZQSR+CmlQGEUkX6aM9se
	 XTUB3sYlhhQ4/Yu9ZAs8WpNbyEy7z9KFDuadUYjzfqA20SQdA80La5sXba8V6bsR9f
	 TLHcz3S5H7KiobgLXhpDOstfwiBhHLtki6e5O+p085XJbaQHQz216IVSeJAYg+RpD8
	 HtDLhd0x+bSow==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C3F9E40AD8;
	Wed,  3 Sep 2025 14:01:03 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>, Akshaykumar Gunari
 <akshaygunari@gmail.com>, mcoquelin.stm32@gmail.com
Cc: linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] docs: arm: stm32: fix typo "busses" -> "buses"
In-Reply-To: <078fb552-c848-49ef-b917-14aec0e4b6aa@foss.st.com>
References: <20250807145119.2214-1-akshaygunari@gmail.com>
 <078fb552-c848-49ef-b917-14aec0e4b6aa@foss.st.com>
Date: Wed, 03 Sep 2025 08:01:02 -0600
Message-ID: <87plc7zlcx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandre TORGUE <alexandre.torgue@foss.st.com> writes:

> Hi
>
> On 8/7/25 16:51, Akshaykumar Gunari wrote:
>> Fix the spelling of "busses" to the preferred form "buses" in STM32 ARM
>> architecture documentation.
>> 
>> Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
>> ---
>>   Documentation/arch/arm/stm32/stm32f746-overview.rst  | 2 +-
>>   Documentation/arch/arm/stm32/stm32f769-overview.rst  | 2 +-
>>   Documentation/arch/arm/stm32/stm32h743-overview.rst  | 2 +-
>>   Documentation/arch/arm/stm32/stm32h750-overview.rst  | 2 +-
>>   Documentation/arch/arm/stm32/stm32mp13-overview.rst  | 2 +-
>>   Documentation/arch/arm/stm32/stm32mp151-overview.rst | 2 +-
>>   6 files changed, 6 insertions(+), 6 deletions(-)
>> 
>
> Applied on stm32-next.

I had already done so (and copied you) on August 12.  I can drop my
copy, I suppose, if that's how you want to do it?

Thanks,

jon

