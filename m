Return-Path: <linux-kernel+bounces-856758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FC8BE4FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2323E4E5D36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C35E21B9C9;
	Thu, 16 Oct 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgKcr8kj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLgXZLXv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6567464;
	Thu, 16 Oct 2025 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637839; cv=none; b=isKem0xLzegZX3+xyPdkrW816vqT4Y8RdbkGid0hp5VjN9+94gD5weGxCVaxVquPfGYzabnU7wtzTQ3MlLQf7N4VUVY9oT/9sTK1UJ4YuQegYrLd3yMITTX8DXXV2abFkUukLmcg4mgYI8ZrmYO7n2q8CLQV+iMq/YsxVKmorJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637839; c=relaxed/simple;
	bh=3M438IcLleLKLrOchGZmvPYl08kQhTgtfLrIArqvTlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Se+rnaSKPTk5K+Nxmdeo5Q+wNKoHDj/DASpvX9VLx/JMEeNQ4BYv+vLpd9qzjozyZJpXwyMjjhraNbv5PtXhCjteXIBnj0OYtvpjSLvKBsX8Io6Q9eiViZygkP3Hjmaj7mo6tCAAiHe4wM4yO6P3Bi8HCdI4Fu/vD3+uvCdi3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgKcr8kj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLgXZLXv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760637836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmaG09FybF1QSupTskdEfI0OuLqWwGIEPddqcjGF0uA=;
	b=WgKcr8kjH6FfiUxbBMzY+bOuxxa0uJx9ZfPX+bktVJeKvLh63qriIiM1dOe05YedZlNt2P
	SqwgwAluZHVfuHR69WLystKoHybkTgpi3ja/NkFs/eLfky5ABzvO6UwK8ZEB61C2fP/FjI
	P5EdOgPXJwkfT8jtpV1XBz9+Jj3paSCD/PgGxsLsT5Mg9ssadXEFQeDz7+7GbeKnvAEdPO
	gyBLHpoDJpoXTZuP4+VpLfUq+REoxBpsJKrVsGoVoyG323K3CMQ+Mg7I7h6zzgBmOlAFNJ
	qvWe4rFFs0JtRwOXbR0GS1t9z1azF07i/816gfCyPrL/Vu3e6ty9Cl6TWvoqsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760637836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmaG09FybF1QSupTskdEfI0OuLqWwGIEPddqcjGF0uA=;
	b=iLgXZLXvAsqSuL4039yFWiptIlpAqYFTWXBTu3nSxJKFRpxJ10YaIX4gYfJOYsBPHQ5zC9
	gYasGwhAFrIXN6Cw==
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, Zhang
 Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <CABe3_aH3YE9wWonH1j09-eCarhzhhRReNAOwmEMs5YjkOvvoiQ@mail.gmail.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com> <87plan0yvd.ffs@tglx>
 <CABe3_aGj68qM1bNZ3LExbexO=9FO4RzJxhUy2T+HKK1qZfBmtw@mail.gmail.com>
 <87ms5q25cm.ffs@tglx>
 <CABe3_aH3YE9wWonH1j09-eCarhzhhRReNAOwmEMs5YjkOvvoiQ@mail.gmail.com>
Date: Thu, 16 Oct 2025 19:53:26 +0200
Message-ID: <87h5vy20o9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16 2025 at 12:52, Charles Mirabile wrote:
> On Thu, Oct 16, 2025 at 12:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> >>         bit =3D ffs(pending) - 1;
>> >>         handler->enabled_clear[group] |=3D BIT(bit);
>> >>         for (int i =3D 0; i < nr_irq_groups; i++)
>> >>                 writel_relaxed(handler->enabled_clear[i], enable + i =
* sizeof(u32));
>> >>         handler->enabled_clear[group] =3D 0;
>> >>
>> >> No?
>> >
>> > Sure that would also work, but why are we using ffs (slow) only to
>> > shift the result back to make a new mask when (x & -x) is faster and
>> > skips the intermediate step delivering immediately the mask of the
>> > lowest bit.
>>
>> Because I did not spend time thinking about it.
>
> Sorry, did you mean "because I had not considered the original
> approach carefully enough" or "because this other approach, while
> slower, is more self evidently correct."

I did not think about x & -x :)

>> It's a pointer in struct plic_handler (or whatever it's named) and you
>> can allocate it when the quirk is required. The pointer is definitely
>> not a burden for anyone else.
>
> This I still don't understand how this is particuarly helpful. Since
> we are doing mmio, this is going to be an explicit loop and not a
> memcpy. The code is branchless in either case (set equal for the check
> of i against j negate and and with mask before loading into the mmio).

Fair enough. I did not think in RISC ASM :)

