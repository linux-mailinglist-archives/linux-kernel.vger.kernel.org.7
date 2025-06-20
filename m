Return-Path: <linux-kernel+bounces-695916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DDAE1F73
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E11BC16DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 15:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9513212A;
	Fri, 20 Jun 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umancZNC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpCtRIzb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F081DE4E7;
	Fri, 20 Jun 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434576; cv=none; b=EZxKR1cY1VqxNvDl2EnUK1MQw7F/GY4Sw/biisAaH5islnhY2IqvXrN/wwkz47Dntm5j0bjZZ7qqP6aK91rh1GS8xMQy0OKYHs+S72waybPiGnUvEKjExMntsCXhoKwenDFDm2Cd0F0+o+oSVpHojRaP8KQVU5odgGSCFhvKVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434576; c=relaxed/simple;
	bh=Xfl+Y6rDlxDXAMJd59O7LSJjSDae0AYdTp5zCgk6yRU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIo/RvWLGmPKMb8M0na4sZ88pYE+D4ERR9/xoek1aTSj275+MNTjTIE8/boOG6ohMxOH0M7BNKN6XYXSQeXBcyz8L3/gMmM1zYe6U5ARzZrIw0iVGVR8F6ozIgGd4reM1JkJ39w8kK8aEmOpqzPkyCaZV4e/+oU5bir/xY/+SWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umancZNC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpCtRIzb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750434572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMV6/wIIylPV96Wgfii7uR83PIGoHRQP1QE1XcKouuA=;
	b=umancZNChctpeGJ77FxDapnhmlOdXQhKKb2KMOqlfY5vAMPFYFY4ShBydzQcwf/bud15Rv
	xJoFSMie5EM34CxLmN9zwGs9/2+dSCOoNEUM/J85rrormCbEEYFCt8014znEWPI3lgY3zc
	1Eh6YUZ6rzCVS/3m0IZbX93DFVF+Ge/cUulWbaVvyzm9jbC+DS5qLJLaZG8SGqbLbEiath
	uOWR41MqdABZYan+4HixaFTr0POTGdiGPBnHIbLAFPTx5Y1MEQ1IiArixgN/ZuminnSH0I
	q59owEwAYYRGEt9OAVEiqmGr1uKaIVIBJvRx3yLgUo5ImeCQnDsgCQ8H+4FJrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750434572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TMV6/wIIylPV96Wgfii7uR83PIGoHRQP1QE1XcKouuA=;
	b=cpCtRIzbFiL38lMpEvYOoWuazmJ0rhTbumaGAKQ/q7GOPcp69Q+OFt6HB3z+aAC0TUHwIU
	Lp2MCXZQgzMTbqAg==
To: markus.stockhausen@gmx.de, tsbogend@alpha.franken.de,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 s.gottschall@dd-wrt.com
Subject: Re: AW: [PATCH v2] irqchip/mips-gic: allow forced affinity
In-Reply-To: <25e101dbdc24$fb5cd4e0$f2167ea0$@gmx.de>
References: <20250526134149.3239623-1-markus.stockhausen@gmx.de>
 <87bjqtrtkq.ffs@tglx> <25e101dbdc24$fb5cd4e0$f2167ea0$@gmx.de>
Date: Fri, 20 Jun 2025 17:49:31 +0200
Message-ID: <87cyayqupg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 13 2025 at 07:35, markus stockhausen wrote:
>> Von: Thomas Gleixner <tglx@linutronix.de> 
>> Gesendet: Donnerstag, 12. Juni 2025 15:14
>> 
>> On Mon, May 26 2025 at 09:41, Markus Stockhausen wrote:
>> >
>> > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>> > Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>
>> This Signed-off-by chain is broken.
>>
>>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-
> your-work-the-developer-s-certificate-of-origin
>>
>> and the following paragraphs explain it.
>
> This is my first co-authorship. So want to make sure that I understand it
> correctly.
>
> - I developed the patched and
> - Sebastian gave helpful input for it.
>
> So it should be like this?
>
> Co-developed-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Yes.

