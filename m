Return-Path: <linux-kernel+bounces-867644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B40C032E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61773AFD62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E4734D917;
	Thu, 23 Oct 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/aTdmcz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2dwpbiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E034D4DC;
	Thu, 23 Oct 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247788; cv=none; b=O4Gvzc1S5C5O7zOg/NauusA/81YKZvK+L5Ht2B0kVf80Z35HBKGN6i260UaBkJ+TqJuNfvAmCUbNbSHN8WVbnO9ilEZbmdXLp0k2CBP9uX2WfTQu6bJb59OYMQS5oVYiIJlr482ePIR9puMQ9lPR6GqrrdTV4GGk11wVmMIo9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247788; c=relaxed/simple;
	bh=EisnLrKN0UF2VdbegRoh5qTxgzLkujCc8ut8WOM1UmE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RUxikM/XItls+4t5Z1UTGAiOPE8FcFnh2ydLX/JRlF5QywLwXpAzR4FgdFyB17WEKeNWl8F8DEQ6Xvco1qxHEPDCNTcYRYl+irK8HAtAOL3FYm0QmpRjVAFNyXJ+b67mo2lTaxzt6kCcL8fRMqNJO4RAd48MNr6lVxo3k1fqWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/aTdmcz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2dwpbiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761247784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n28eUmQml243YudcW5Z7MxWo4RAARcO1V+VuS9VUaIc=;
	b=a/aTdmcz8sNmUTNcjCDlGmxhADWNQP5hyr84v5nJBmZdv+WyRysAoOOcZ0zzbSZC1B7QVx
	THCtlGDGBaTvYkk27QSjsUhghP0uGr9VExq6p5KD/uUAsnDwuiCrs/Yt9ofOEX39dTB5K/
	dQW9tXYmqUW+cW/hDSp9BFYPrCWVMA/WaFcVb1I9cWmm51dvmOrkez1/jPEpig0ovXlRTr
	8lUZW0J/LLHkUBMl563LJDD0Ier3iPSrNcasqCTRcL3r22bOzjdal2v2LSSNo6EVu5m348
	zvJru1CBauUGM/LHL75MD6/d97wAKkroRmgljrUV+fmciflub7R99aK9B389ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761247784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n28eUmQml243YudcW5Z7MxWo4RAARcO1V+VuS9VUaIc=;
	b=N2dwpbiXcXeAVHx8XqdAk9adFazCugDVfl6OJqmERfUuRN1V8FWFfaR+nte3ZFdHzbZhNh
	RmXvtBXws3zZu1BA==
To: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Samuel
 Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Vivian
 Wang <dramforever@live.com>, Charles Mirabile <cmirabil@redhat.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 0/4] Add UltraRISC DP1000 PLIC support
In-Reply-To: <20251023140057.204439-1-lzampier@redhat.com>
References: <20251023140057.204439-1-lzampier@redhat.com>
Date: Thu, 23 Oct 2025 21:29:44 +0200
Message-ID: <87zf9hwh5j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 23 2025 at 15:00, Lucas Zampieri wrote:
> This series adds support for the PLIC implementation in the UltraRISC
> DP1000 SoC. The UR-CP100 cores used in the DP1000 have a hardware bug in
> their PLIC claim register where reading it while multiple interrupts are
> pending can return the wrong interrupt ID. The workaround temporarily
> disables all interrupts except the first pending one before reading the
> claim register, then restores the previous state.
>
> The driver matches on "ultrarisc,cp100-plic" (CPU core compatible), allowing
> the quirk to apply to all SoCs using UR-CP100 cores (currently DP1000,
> potentially future SoCs).
>
> Charles Mirabile (3):
>   dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
>   irqchip/plic: enable optimization of interrupt enable state

    That one never showed up. Neither in my inbox nor on lore


