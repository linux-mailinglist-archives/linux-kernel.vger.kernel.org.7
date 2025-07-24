Return-Path: <linux-kernel+bounces-743999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB569B106C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC31AE530E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29558255E20;
	Thu, 24 Jul 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVZZPOr9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lD0kXarl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073C255240
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349777; cv=none; b=euj8TjZLal2jOPwdPXfdqM97Rx693UrzGtnCOSAIDT1aAQp/SethVSMHST4FOadm1VtfpVDG3JKMhVI5YO+Ifv8PPTKtUHU4c4F0rv3Xkx1fuiPlhzp3/h/IeU5tbZgvz3rT6yYELmJtl1hQOZchkIaHYpNFq7OGLhorN7Blg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349777; c=relaxed/simple;
	bh=ztMo+M1ZYiDY8s1Tm47cuFM5eK9wC8+ZbhC6nC/Dt+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPoSsFfvGPghGGfp7EQvZGdTNYbC+/8khCqAAXGr8aWtxgpua7XQJypRlg48by3OzsiOOw/QR4EPMITeziVnEAAAEVBLGtEzJvwOIM7wG0DgXXlqsgMf7H5ZUU3jH3vNMG90ff5DPeO50p9okGa5jBjhxdhT5u4foYDpj/sSHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVZZPOr9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lD0kXarl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753349772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=St8LhG2IloKI6vEQFWiwV2Hz249Z2tbERnS7qMqFGAg=;
	b=pVZZPOr9b6yTr0WuswDzGYj3d6rmPl/w8kTksCuV26YvOnmesRfdlxcX56+8qXm2dhCtRo
	T2nBFfCGslePZ4xosDsvpFges80puq8TMZjDOC89Fwred0w3x25SZyfbyQtUmz+jH57vvF
	QdBSeX+T65CBn//1KT7oPDtIsAgrH+LHr52os4mqjOp+qwXVNfibvXedeqrvvwyPjq+a2x
	R3U9PJmuO1mNlBmA74kjIH6OWcutf/gtLvPP1lNfi1XqSkIABra34Iqzfvo4piw1bTHkcJ
	lD0BnpA/N/txY1puyl/x//KPF+lw9rKDICfWqR6Oa09/CIqpJbE8hhgvtjc5iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753349772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=St8LhG2IloKI6vEQFWiwV2Hz249Z2tbERnS7qMqFGAg=;
	b=lD0kXarl+6KbeLP2BNsNQyKFeU14dOCFegu7UAE/z6llVEzD3/ehWdjEPhl0A0BGZkMogw
	RDfLO6rCnKMrOwAg==
To: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
Cc: =?utf-8?B?55m954OB5YaJ?= <baishuoran@hrbeu.edu.cn>, Peter Zijlstra
 <peterz@infradead.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in smp_call_function_many_cond
In-Reply-To: <C0FEC6BF-BCC8-4301-BBE6-8A49A05D50D6@m.fudan.edu.cn>
References: <758991c1.13f67.197f9cccf9b.Coremail.baishuoran@hrbeu.edu.cn>
 <877c02vejr.ffs@tglx>
 <C0FEC6BF-BCC8-4301-BBE6-8A49A05D50D6@m.fudan.edu.cn>
Date: Thu, 24 Jul 2025 11:35:59 +0200
Message-ID: <87o6taq6bk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24 2025 at 15:55, =E8=83=A1=E7=84=9C wrote:

Please do not top-post and trim your replies:

https://people.kernel.org/tglx/notes-about-netiquette

> My guess is that the crash point might be csd_lock_wait(csd) in
> ~/kernel/smp.c on line 885. Here the other CPUs are notified via IPI
> to execute flush_tlb_mm_range and enter spin wait. However, it has not
> yet been determined which CPU performed the operation that caused the
> IPI to return a timeout.

Guessing is not a proper engineering method :)

> I'll first provide the log that was reproduced in 6.16-rc4. we'll re-veri=
fy it on rc7.

> [    0.000000][    T0] Linux version 6.16.0-rc4 (qjj@qjj-Standard-PC-Q35-=
ICH9-2009) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0, GNU ld (GNU Binutils=
 for Ubuntu) 2.34) #1 SMP PREEMPT_DYNAMIC Wed Jul  2 09:53:03 CST 2025
>
> [    0.000000][    T0] Command line: root=3D/dev/sda console=3DttyS0 ftra=
ce_dump_on_oops hrtimer_expire_entry hrtimer_expire_exit trace_event=3Dipi_=
entry,ipi_exit,irq_handler_entry,irq_handler_exit

Please remove the silly extra new-lines next time.
>
> [    0.427302][    T0] Unknown kernel command line parameters "hrtimer_ex=
pire_entry hrtimer_expire_exit spec_store_bypass_disable=3Dprctl nbds_max=
=3D32", will be passed to user space.

                                                                 ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
How is this helpful?


