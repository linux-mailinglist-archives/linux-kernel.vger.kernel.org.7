Return-Path: <linux-kernel+bounces-863518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7CBF8097
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A835C18A5A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6F34F25E;
	Tue, 21 Oct 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7dCUf8Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wr1DZ8xo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E233C503
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071043; cv=none; b=EHUJexPkkgEbt2E5uh+B8SmVU+iG17eYqVku3Xrk9lmev+baxM0Y9DMCyzIoPzPuvVxGLArv08vWODGUOg4TfMX2QrnHEUY7c8SfeToJZw7I/EW3wGxIzQolMr72m8x5Azwz359g7j0I3Rxy62nmP0vetHv/pfeJfe6MdwmgOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071043; c=relaxed/simple;
	bh=YtC9FVB6RTwsgQhZ5GJw+dlk0DK/jvxC/CT3+eOfgxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8JjiKV8sITb8lQswIiXuiuvKcksdonh9UQbMNSW1+Yx7gLxCLUyL4WI0wmSW4UgWLr7ED1zHIoN1jfScQYgOkwBk+5YKrU8dz7Rttkiy4IyWK6+C2zc6qZxPudF7EMXNFjWaaP+klD8BmEWWoMgB7l+7zykYTHwyluuoUoQW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7dCUf8Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wr1DZ8xo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761071039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsB5rMhwuhp8pA17tWoe/hsQh2JLMaKKsffP1S6G2jk=;
	b=q7dCUf8Qvn7NfXlik7h4bBI9b/ZtUrH8mHy0eWjPMgEOrvF6SQv6v4uC/nBhedp/j4dGyO
	3baeSimlOvyiucac5Wa1cSWBLd4jcJ6mLQyTpoGOk3xwGocbOUHJNYdwWk8sLRRSxNCPof
	QdlGLZCpbpUX+FcJ7lde0enTbNE2m6MU7P6y9xSbjpU/JZLU1DRg4wq8XqD3RZ2fEv0JGo
	3zWMGsQEWeywU78g6LApl+4KmKf52sNEgeuClE5BA011GmDTM2gY3etA7j6y5vPTn3pFNf
	6x7oKRDetnfHNHj6x08QpFPMe0yBkleowiNdMDSD7hMJi77yYS0d1GJIPpDscg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761071039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsB5rMhwuhp8pA17tWoe/hsQh2JLMaKKsffP1S6G2jk=;
	b=wr1DZ8xomQztHUwIWV70tnSbYbqyS2AHPDlohzIs/i9hS+QRmBCECsOTm5fVSlckICQyI3
	izw2ohDKSceGkTDw==
To: Troy Mitchell <troy.mitchell@linux.dev>, Troy Mitchell
 <troy.mitchell@linux.dev>, Paul Walmsley <pjw@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip/sifive-plic: use hartid as context_id in OF to
 fix AMP conflicts
In-Reply-To: <aPbeb1SEZr7CG2eN@kernel.org>
References: <20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev>
 <87bjm1zcvc.ffs@tglx> <aPbeb1SEZr7CG2eN@kernel.org>
Date: Tue, 21 Oct 2025 20:23:58 +0200
Message-ID: <87y0p4xge9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21 2025 at 09:14, Troy Mitchell wrote:
> On Mon, Oct 20, 2025 at 07:44:55PM +0200, Thomas Gleixner wrote:
>> On Mon, Oct 20 2025 at 11:49, Troy Mitchell wrote:
>> > In asymmetric multi-processing (AMP) scenarios, the original PLIC
>> > driver used the context loop index 'i' as context_id for OF (device
>>=20
>> Which original driver and when did it stop to use the context loop index?
>>=20
>> > tree) platforms. This caused multiple contexts from different harts
>> > (e.g., core0 and core4) to share the same enable_base, leading to
>> > conflicts when initializing the PLIC.
>>=20
>> When did it stop to cause the issues? And if the issues have been
>> already resolved, what is this patch about?
> The issue still exists in the current driver.
> The PLIC driver for OF-based platforms assigns context_id =3D i inside
> the context loop, which assumes that all harts are numbered contiguously
> starting from 0.
>
> In AMP systems (e.g., when Linux boots from hart4 while hart0 runs anothe=
r OS),
> this assumption breaks =E2=80=94 multiple contexts from different cluster=
s share the same
> enable_base(e.g., core4's enable_base =3D core0's enable_base), causing c=
onflicts.
>
> This patch fixes the problem by assigning context_id based on the actual =
hartid,
> ensuring that each hart context maps to a unique enable region,
> while preserving behavior on SMP and UP systems.
>
> Does it make sense? I'll update my commit message in the next version.

Yes. Though this still applies:
=20
>> # git grep 'This patch' Documentation/process/

Thanks,

        tglx

