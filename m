Return-Path: <linux-kernel+bounces-815895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD9B56C63
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852701896DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6262E1743;
	Sun, 14 Sep 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pI8+bu+O"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1162DEA75
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757884651; cv=none; b=LIFpOL0rjzaXz4zWF3Oh9ZjPwqT7sZOSSXJUNntxJMmm1jHHk/cM7aYD7ET/xjmyaQTuLVjKlthi7+hMqREcbQx9LNAede0n7cqLkvkyWeZVSqXJJY05rxNgpsJRTIznSvo0N/RtB6oT0c//dhKKl7xQH/73OH7OWx3M+JgUYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757884651; c=relaxed/simple;
	bh=EqMpuRSa39CFNELS/O8eaTFT16AO+EIrbNPR5ZZr3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhoPsBl5GjpPo6YHtOpAACgUf9r6wzJS/oWqzDOruzUamnqLRadOc6BhRsMzvZ1Cwz8doQH6Qvnz+nmI7aDSXkC60QMiCTNOGwUBKjsvxptbzW2St+TzH92FfcDpQL/czVkHN/Pk1IuUTrrDf8q33aTvXfE7c0duD3cq2h/SxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pI8+bu+O; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A7CE4E40BD1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 21:17:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F7E36063F;
	Sun, 14 Sep 2025 21:17:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EE7C102F2A7F;
	Sun, 14 Sep 2025 23:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757884647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=edwJHsqw68GXTyMcUxTqvQnh2mdUFj+gJkZqvxPxGiQ=;
	b=pI8+bu+Oqyb3hywW0P5y6DtWst+Heo0G0gm6rJNLF07U+v69AAfjfcQ6CIDBN+kXGy7GZY
	uStLHYIGqy+fvQU8kkoiDuMwPz9cQHjwMO05Jq3B8h3vpf9OrCviLXr2w4YkrBVQxjEdjD
	Fmj+gUr1JRbOA3XQfV7b+RAiFrEfPptaadBOCDJN+1KLYsi8FzyvyrwdjaKpf87YJL2sJv
	VI20EBJQIFkBLRkgD5VTSTJxidE65Q8pmFCCpKvF6oSfZ2PLiADrKp7HBlgf04fVQnULYn
	G6wDwB50y41kYr9ktcf2Y9v4uzJJVb+4S9o9CQplZaTAAT5X01CanIeEsCi7gw==
Date: Sun, 14 Sep 2025 23:17:26 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Josua Mayer <josua@solid-run.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: clear minute/second interrupt
Message-ID: <175788449952.388732.14957851580765870997.b4-ty@bootlin.com>
References: <20250825-rtc-irq-v1-1-0133319406a7@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-rtc-irq-v1-1-0133319406a7@solid-run.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 25 Aug 2025 19:54:09 +0200, Josua Mayer wrote:
> PCF2127 can generate interrupt every full second or minute configured
> from control and status register 1, bits MI (1) and SI (0).
> 
> On interrupt control register 2 bit MSF (7) is set and must be cleared
> to continue normal operation.
> 
> While the driver never enables this interrupt on its own, users or
> firmware may do so - e.g. as an easy way to test the interrupt.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf2127: clear minute/second interrupt
      https://git.kernel.org/abelloni/c/a6432c0d99ba

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

