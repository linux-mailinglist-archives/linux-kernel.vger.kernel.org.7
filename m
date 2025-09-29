Return-Path: <linux-kernel+bounces-836147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F17BA8DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C033A189D48C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C52FB617;
	Mon, 29 Sep 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="13tNo2p8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Syr7Wik"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CC2F25E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141170; cv=none; b=rszxW3Z8uveFotkgh2Mh/gV7twXAsIl3y8o8Qi/cIrB9LfyL3a3gIBqSow22D+H43gqj4EFulP7BHi3ZMkbBxY6ofl/PfTVduxAD8k7pDklA7qjMcDV8sSZo4Y/tmeb1RJovT9u30URZv5PeyXoirpBiYBB2+cg6f4mOUpSSV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141170; c=relaxed/simple;
	bh=85gBkFFqxaPIw1q7OwWI/Hyd6qYoAESLR/GviQW+bW8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQtMOZiu2VR+Kz9pfGrPFKyI0kR0Ffoc0ZzR7U2QL1dZX/G7DpUxPmFky/UbzMK49HdwAVJBe+hUtNABuiBzuTHOPSch/C2g03mIv+Z+ZsgJ0W0+G4nHcYxz00GCnaWM0+IEXHc4El95kxEJxna309oK3wAK7Fc8+IWSSM9kS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=13tNo2p8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Syr7Wik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759141167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=na+z28tfujvUbYZGUn5Elyo9Cu+dfw5ocKOwLyEHUIo=;
	b=13tNo2p8nc6zWD3ftjF+Dm/6rnWtaYz72CxAujFLiWRtOdHF7CfjNgDNTdS0zMymUk/qFT
	W2ho8qe98rmUe819LIUtyI+/FGjlsI29o5AjIxzh4ZigSOKdb7k8lchTQ9kh8g+1aBFtxY
	o96KFoQiaqHH76JByvV3iOqlPrYj7ZFWsQGNPXOd+BOHUF+KyIe2hc4qX58WPmPveMbud0
	mCUEj+1bPclkDzlzEffHuoBKjFLDVBIfForNaOCb+vjtYJRCsk3W34O40hWkGXAQOPnpz1
	fnnyme24yyXqIuYQqfIZJPsk6eqW+4/9EIBGpJWC5yCuTujXpp/6pGhKF2qd3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759141167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=na+z28tfujvUbYZGUn5Elyo9Cu+dfw5ocKOwLyEHUIo=;
	b=+Syr7Wiki9tBCENI51Zw8YlRdpoNLpmUSdrdBLrUrpUoArChrosAoh4awSkFPiDT8kLCrv
	rhwrakVJ9FrBRQCA==
To: Thomas Huth <thuth@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Add kprobes KUnit test
In-Reply-To: <87frc9h0lo.fsf@yellow.woof>
References: <20250513151631.3520793-1-namcao@linutronix.de>
 <16b74b63-f223-4f0b-b6e5-31cea5e620b4@redhat.com>
 <87frc9h0lo.fsf@yellow.woof>
Date: Mon, 29 Sep 2025 12:19:27 +0200
Message-ID: <87v7l17e8g.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> Thomas Huth <thuth@redhat.com> writes:
>> Could you maybe change that into "__ASSEMBLER__" instead of "__ASSEMBLY__" ? 
>> I'm currently trying to get rid of the latter in the kernel sources, see: 
>> https://lore.kernel.org/all/20250606070952.498274-1-thuth@redhat.com/
>
> It's been applied, it's up to riscv's maintainers how we should do this.
>
> I can send v3, or a follow-up patch.
>
> Or riscv maintainers can also squash that change into this patch, or
> into your patch.
>
> I'm fine with any options.

Riscv pull request is already created. A follow-up patch it is then.

Nam

