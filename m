Return-Path: <linux-kernel+bounces-715218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C27AF72C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9876526AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B12E3389;
	Thu,  3 Jul 2025 11:46:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568B24DD07;
	Thu,  3 Jul 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543169; cv=none; b=NvgCntIOehWnWjPJ+41aX1bAxLDGsYZrjQdHHbBe4m0oc1emPrqGacgPMgDUJh0yK78uf37ZLnBUjy/CRGuFt9QK4GpvtUDiZnUBr0JrGv0a0/BpETRtrOKgf2U8IP9WkGTX9G70lKmVVCvTRbQo7450bDVIHPOKC9EGmckymdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543169; c=relaxed/simple;
	bh=2k11KvoMBeQIvrAWZA7P5gWj9h1H7/1T5f53ZD8lUOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpNjrKrInjTExdTO9XV+834QPUZTVTB7DeWg1yMgXEfu6eH+X6WsQ7JKn2/+9/9I4lenZbSCu+OYRvGvdrfInPgHKNEFYK51LtLyscpC/6BUKKiqzlJaVLPJBWLi0vujQTXYOSm1iKN2C+cftBholPK4vdaicBvvFkjCmYjSSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9DF1596;
	Thu,  3 Jul 2025 04:45:45 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B1E3F6A8;
	Thu,  3 Jul 2025 04:45:59 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:45:57 +0100
From: Leo Yan <leo.yan@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: cov@codeaurora.org, rmk+kernel@armlinux.org.uk, mark.rutland@arm.com,
	catalin.marinas@arm.com, linux-serial@vger.kernel.org,
	rmikey@meta.com, linux-arm-kernel@lists.infradead.org,
	usamaarif642@gmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <20250703114557.GD1039028@e132581.arm.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <20250702172036.GC1039028@e132581.arm.com>
 <aGZVP8A2a3VVQwzt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGZVP8A2a3VVQwzt@gmail.com>

On Thu, Jul 03, 2025 at 03:02:39AM -0700, Breno Leitao wrote:

[...]

> > In some cases, if normal world and secure world share the same UART
> > port, it can cause the UART state machine malfunction and long wait.
> 
> I don't know how to check it for sure, but, looking at the serial
> console output, I don't see anything else using the UART. The only
> output I see on the console at that time is coming from linux kernel.
> 
> Would you recommend any additional check?

I have no experience in the driver, I should avoid any noise. But two
things in my head for quick trying.

- First, you could try earlycon mode, e.g., add option in kernel
  command line:
  
    earlycon=pl011,mmio32,0xc280000
    earlycon=pl011,0xc280000

  This would be possible to give more printing logs. If earlycon works
  well, then the issue might be caused by later init code (clock, or
  UART driver itself).

- Try another UART port if this is possible.

Just curious, you mentioned you are working on the mainline kernel. If
you can confirm a workable kernel version, then this info can help to
rule out hardware issue and we can review the delta changes.

Thanks,
Leo

