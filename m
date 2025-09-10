Return-Path: <linux-kernel+bounces-810937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93A9B521B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5063B2507
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BECE2EF655;
	Wed, 10 Sep 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="asz8WCyf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7gQndas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95362EF648
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535788; cv=none; b=lkMvfrx1j3Gg6Uj4GU0oSFEXVEAw4AUkmA2R0A4uisY15g48tDKjJCNsfgSVZALx0ZUZzGJJawPynj6zVRgm8VpPt52D1eSHmAoEZJp7R1C6S0nPZBDE/YY1MXZ0Lz7xZXoVaOv0hq+guKBpKPESrs4/PM0oDEabcp41pC5hZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535788; c=relaxed/simple;
	bh=Qt9fEPDDSAxfSjWKJn2lptREGY68byhg4Qt0ZZytO2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MeH4eqJqrlMrY3rjkBbehEpm/USB87gtdgE/Lx+jMRQH4su51SBAeVtBQJ0xUvduJDPYT2wzHV6y4CuIVmmEkYdm9TdpBlS/YIdp4K7UrSEuLgnRkSmeoBNXylnYVXNleSxY3OocNgjenz6iZZ4KO+kpc+P75sxjiE55Dz/H72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=asz8WCyf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7gQndas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757535785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6JppIYrmEDWEBmdblA7ULIVxZIHJ3mliKKCj/J+dUc=;
	b=asz8WCyf9cnS3BMBwtrU3ZqPWzgbaNDidcLL/dq7mwu+tfHouh4PlTUSVHH2aevv6qaiiH
	mrFRl4Ffda2v4nbsGVWwJpSXd0AWFZS4ixEpY0w2s/zsJ3CwVjx0fUwb3xYY6doaOYPBCu
	7TWTlLTtVFU3GodRA0gVBSJS+wFyBAohRtGm0EegZuo5JtvQJ62TslVKJ53vNaW7K/ZKvk
	FwzRmBtruktBOAwqctDK8yB4IPdPQPIL+unA31zsjlybTc1Boz8DuyopiK38ghL0h+nfpK
	RagXnDR1bh3kcMMvL5+xcQBzmejEh9UxWpC4rYNhujuDSu37sn/bfrcuqOfPmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757535785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6JppIYrmEDWEBmdblA7ULIVxZIHJ3mliKKCj/J+dUc=;
	b=N7gQndas+HW+vhHMKOorVfZL45dU91oZcvccxJZRsxCAxGlqVlCitko6PEVkq+D+6Ov6Q+
	hATZLZFP+SUt2cBw==
To: Guillaume La Roque <glaroque@baylibre.com>, Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo
 <kristo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
In-Reply-To: <0bc124c7-55af-4a25-b02d-3bd9aabf0266@baylibre.com>
References: <20250812-timsi-v2-0-90c8500f3f18@baylibre.com>
 <20250812-timsi-v2-2-90c8500f3f18@baylibre.com>
 <20250813152610.akcdxrzhev6e2kfa@unturned>
 <0bc124c7-55af-4a25-b02d-3bd9aabf0266@baylibre.com>
Date: Wed, 10 Sep 2025 22:23:04 +0200
Message-ID: <87ldmmrr9z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 16:40, Guillaume La Roque wrote:

Can you please trim your replies?

> I will resend weries because something look not ok i don't find serie in 
> lore or patchwork.

>> If Thomas doesn't mind picking the full series,

Is this actually addressing my previous feedback on this?

   https://lore.kernel.org/all/87cy87zx87.ffs@tglx

>>>   config TI_SCI_INTA_MSI_DOMAIN
>>> -	bool
>>> +	tristate "TI SCI INTA MSI Domain driver"
>>>   	select GENERIC_MSI_IRQ
>>>   	help
>>>   	  Driver to enable Interrupt Aggregator specific MSI Domain.
>>> +
>>> +	  Say Y here to compile it into the kernel or M to compile it as a
>>> +	  module. The module will be called ti_sci_inta_msi.

I doubt it, otherwise this would not exist anymore.

If you disagree with me, then have the courtesy to tell me why. Just
ignoring me is not an option.

Thanks

        tglx

