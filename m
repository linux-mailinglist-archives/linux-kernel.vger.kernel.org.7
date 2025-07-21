Return-Path: <linux-kernel+bounces-739731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44128B0CA37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BA917467B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4BB2E041C;
	Mon, 21 Jul 2025 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVsbvk3y"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A17522A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121160; cv=none; b=D4s7BGDguLwRVSZrvHC+Fdc7dunDeWJo3D8A3U2q/pI48J5YdK6ZvSb9W289HGAjALWGD2xLQ4zNjJBcR1Hj+nXVhcbyDb7O5YbVtdCaugFjp7CdL79ED6zkwBWU4F8yq00n7jQ5IU202XN1OkL/MxCSyH8AD4LHl52HpFSI8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121160; c=relaxed/simple;
	bh=uKwFy0jAyua+i0+wptyMVMz4QkLGhgnerelly+vNe/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYTWHNc1L1aef8r2A69TrFqukkymwDsWh4kzhZC3JUYHUcrDBTzjoGIy1c6LdgccEyLkweTUQBKprzpHQOy+/JTQ7sjosPm3lU3qiJKquLyEULWXocfvCoiJq4DLFwdI5En2nnNxz9lX7qbfsJUjZpfJYM5YtsoeThm+B4FotAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVsbvk3y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zsnyxJJ+11OoOARQOP3KrbEnVXqa4oV4nIV1ZvKLUFA=; b=pVsbvk3yOybYYIX0224avZQwUn
	ET7GfKdpXFLcI5I9UopaN0boOuIgcxMrsDroyccESQaXwPLWu7cl1U/Db/2C7LQMR1UKRYZxJTQyB
	N03ez3Lbl1YbDFXQoJVgc858g+daLiBASot1SotQA+hD2ZIEFn3j6jvAxvK3RQzbUFHr2fjuV7g/K
	E9Fkg8hatbN1HQA+CRbxZvu9v/iBEZiWnnPJw3YTZRMekvTCeM/ozKkfszD4Xrc7dL3xXVwdLEaGM
	QW4swITvCS0iexTsJGWqPCd1Gudb5JQUU7OHkVAi2uq4kqMfJp/W9Lsni+kU9M2II0gE5HrHE0rSe
	zMFY2Nbg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduth-00000000OAR-3gZU;
	Mon, 21 Jul 2025 18:05:57 +0000
Message-ID: <6a184920-8b03-4b9e-8a46-a0f3827080ca@infradead.org>
Date: Mon, 21 Jul 2025 11:05:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc104: move PC104 option to drivers/Kconfig
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250721152402.716262-1-wbg@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250721152402.716262-1-wbg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 8:24 AM, William Breathitt Gray wrote:
> On Sun, Jul 20, 2025 at 11:26:30PM -0700, Randy Dunlap wrote:
>> Put the PC104 kconfig option in drivers/Kconfig along with
>> other buses (AMBA, EISA, PCI, CXL, PCCard, & RapidIO).
>> This localizes PC104 with option bus kconfig options to make
>> it easier to find.
>>
>> Fixes: ad90a3de9dd1 ("pc104: Introduce the PC104 Kconfig option")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> This isn't really a bugfix, so it doesn't need a Fixes tag, does it?

I agree. Sometimes maintainers (or their bots) want a Fixes: tag
on almost anything that isn't new code. :(

I'll remove it and send a v2 with your Ack.

Thanks.

> 
> Regardless, I think drivers/Kconfig makes sense for this kconfig option,
> so here's my Ack.
> 
> Acked-by: William Breathitt Gray <wbg@kernel.org>

-- 
~Randy


