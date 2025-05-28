Return-Path: <linux-kernel+bounces-665239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB82AC6639
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2312188F042
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89581269CF4;
	Wed, 28 May 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMUQ8DSF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEy96rth"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F327815F
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425652; cv=none; b=EAgss6imWV7H9oo9Muu1b/L9agyVmPggoJXq3iUi1zHmp3Tj2fQDcBnIcXfFpoVzTXsZ2oZ0EGGEW9dnGsovQvmJShxBwBhBbTAPvHH/3v3KuXVEuRQlJw/wWFq5fSi7czPWMUKcxRSyJBQMcSS4WJUSA6a0ISLmSs5RhtN+NVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425652; c=relaxed/simple;
	bh=Y1mJQ3DF5VL7r3sPW5fzJrKYJD+f9X05KD9LdmNOgoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rw8BBuh00DnKdXhBm88grgjzXKcx/Sd5s4zEK4HPw6MzXalL6Vcz+svNmex/kS3DvxhMWmGzfhS+AGyPe5qz6PrSaj+yUgPAIC3vbIPqRhBoULDPWir8Ir220IH7cOJmbB2B1d7VSIAsDeoqp8rvXT867CgSBxmTlgwnORl2n6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMUQ8DSF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEy96rth; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748425648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqCwS8JMBjO9RvnzZhwCPFZkKFkdqnzqQUXG5Vq7VkU=;
	b=QMUQ8DSFZX6GBwUL2pIvsdd0HquBDn2oEYALu1AhQCwO/4dwvJ+6lpCGP2Dxo/T8SZGJZw
	A0ASR8wnZ1IIZ2pSavupvNeei6ttE3CxSdpwwSdDsGX0uXCy3qC3ViIql67Y8lvFMK5SDK
	oksklEznYEcuN0E4Q1PEeZ7aisMFJ0+VYN6vN+zNSDYNZUJUwhwdSVtmOQW1s/Sg6kMTDO
	nh+OEIvgU5NUOLOJK79cXn69XZilAOLVZHqcWqIloXQ6DCdXAu5XKVwd/X1N0jlTRqZSFn
	09kaNqjXrqTTIz40fVXNrYnUIQ2C5UKvqf5nNQ3YfUa0Pa+OgES5dVq6IVNrPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748425648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqCwS8JMBjO9RvnzZhwCPFZkKFkdqnzqQUXG5Vq7VkU=;
	b=SEy96rthWjg5ezQjPSdt0DJWVaWOxI1ELOvL7JothVkrPu0SkzX/1HxUaZq0XtlhBQ6H0l
	+2rQiJaLLAdPeiBg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/msi for v6.16-rc1
In-Reply-To: <CAHk-=wishzzcmRY8EY_qjD4T4i+W_sX2HWyKfo7dcEwPUSSoew@mail.gmail.com>
References: <174820637262.238682.1985899398053030312.tglx@xen13>
 <174820637979.238682.4349646136552270664.tglx@xen13>
 <CAHk-=wishzzcmRY8EY_qjD4T4i+W_sX2HWyKfo7dcEwPUSSoew@mail.gmail.com>
Date: Wed, 28 May 2025 11:47:27 +0200
Message-ID: <875xhlqd74.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 27 2025 at 08:18, Linus Torvalds wrote:
> On Sun, 25 May 2025 at 13:53, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>     With this update the code is correct by design and implementation.
>
> You have reached that unattainable state of code nirvana.
>
> Congratulations.

Thank you very much!

I'm pretty sure, you'll reach that state too once your grandkids put
your world view into a different perspective.

        Thomas

