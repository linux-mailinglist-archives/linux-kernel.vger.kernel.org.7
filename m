Return-Path: <linux-kernel+bounces-740572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCBB0D5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A765F18978A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0D2DCBE3;
	Tue, 22 Jul 2025 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vap6x1qD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbQI0CjY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A32DAFC1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176247; cv=none; b=A/veUyklyTtIOFvRyzJsEPAb6sENDjkNpXpBM4q1qnLqBM14TTfHJwd7eiMZ2mXtfcWM6uPR/C9MddXsPuKELnPZu1uNgabWZRowEGAwWdgs+FtuN6L1qBD4AQ+hqhFIEZvrU59gH+2HNvUhoHSH5bzVzU22PsIJbt5EknI8eVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176247; c=relaxed/simple;
	bh=BFmGu5onRhNC7oCFD6HQWHvUKHNJDs2FmdzhpgzLs44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHt1WjqmYONnTxLEOmMpCMGLzC3BeCMUf8JpdQKr/+FjUE5aq47zmu89MqC8RbdYPUdPT4QYe904HWWztXePLPmXZH2t2BiNGYSCZvVTyvas6Psd0tRMavw8zbZGrkq3BCm9K4IZBRZny6YwaKKgUvJvXJZ5dAGd9FyR8Sex1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vap6x1qD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbQI0CjY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 11:24:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753176244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFmGu5onRhNC7oCFD6HQWHvUKHNJDs2FmdzhpgzLs44=;
	b=Vap6x1qDls3aE1XarapJgdisRQ84gWiHdxF+OZlLlHab1Wi/pkGoKAX04NZv2jV1LRwa4N
	B1uae0PVks7/UKezhCChoeMJl8xgxi/a3ZOC1FIFeyFRCPAWHWxZbgWQUPz8CT+mPxKH6q
	tPzUOuypFdF2Sdby0CGbxwgIg1y5xr2xXGpPILAyJtiEok7srAXBJH7gUfpFhYlq6yTD5x
	GW8TepMfPiY71MaHbdzAAPcgx7VbUFgvbi919T1FteBxxTMu32XH/L7HsdhcqbGfDsAkwJ
	OxATR/OaOOrhCHf9FUYFhUGgkh4mx9/LBLCjZpngnQlOTCczsWnxf4WdMr2xmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753176244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFmGu5onRhNC7oCFD6HQWHvUKHNJDs2FmdzhpgzLs44=;
	b=LbQI0CjY/6FtiEgNBnARlAY/0AQbn08RbLGf/Y9w9iyW6yeX+K4YtAzKScr1iPov7hP+cd
	kGFC2X1d8EIWIGDg==
From: Nam Cao <namcao@linutronix.de>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] powerpc: Cleanup and convert to MSI parent domain
Message-ID: <20250722092402.uMLOYoII@linutronix.de>
References: <cover.1750861319.git.namcao@linutronix.de>
 <aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH9Na8ZqrI0jPhtl@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>

On Tue, Jul 22, 2025 at 02:05:55PM +0530, Gautam Menghani wrote:
> I am seeing a boot failure after applying this series on top of the pci
> tree [1]. Note that this error was seen on a system where I have a
> dedicated NVME. Systems without dedicated disk boot fine

Thanks for the report.

Using QEMU, I cannot reproduce the exact same problem, but I do observe a
different one. They are likely from the same root cause.

Let me investigate..

Nam

