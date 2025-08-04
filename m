Return-Path: <linux-kernel+bounces-754658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2BB19A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CE2C3B2834
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4382222AF;
	Mon,  4 Aug 2025 03:27:32 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE72E371F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754278052; cv=none; b=UAWSmRe+NnG8nUrlm6gj1kzy7CJu3K0SIDGwGnvpQDP29NQJnHVg00AniKlUzuDm9inR6TqqwqeIjHoDa7nVezNuzafWakmLyC1y9jaHqfVwfHh5+M6P4JnGtwB77Ku9ZykCUVRBSOXqNQqxqc0sYZ6OE/dz9HkrisLWL9+RcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754278052; c=relaxed/simple;
	bh=qV5+s0C3LbdHrvGuhjlGl69/BquLPKROU0otJqT8ItM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S87/89qnAI6FNOiTc5ZYiY7zeq8xfm+whBxzJtGN9GrdB4xJ48yGic16tytO59pnPdV/W4e/iJR7jBO+aBmX+ILOiziXDqFfMfjBdNA5qKACGfGAl2SktYjm1wx5tXUO/2+qJuh+t5dpG5kTJf+Rq9B2CXhmUT7Sc6r7N+NtLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bwMPJ40Tfz23jf6;
	Mon,  4 Aug 2025 11:24:52 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D25E1A0188;
	Mon,  4 Aug 2025 11:27:20 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 11:27:19 +0800
Subject: Re: Question on the scheduling of timer interrupt and FIO interrupt
To: Marc Zyngier <maz@kernel.org>
CC: wangwudi <wangwudi@hisilicon.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangwei24@huawei.com>, <yaohongshi@hisilicon.com>, Zenghui Yu
	<zenghui.yu@linux.dev>
References: <8c6eb963-0a3a-8b75-8ab4-a0b2e10f3d40@hisilicon.com>
 <86y0s36yjh.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <917dfd6e-b8be-03b0-bfda-ce1108693bc2@huawei.com>
Date: Mon, 4 Aug 2025 11:27:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86y0s36yjh.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200017.china.huawei.com (7.202.194.83)

Hi Marc,

On 2025/8/1 20:01, Marc Zyngier wrote:
> + Zenghui, in case he has seen this before.

I haven't heard of it before.

> On Fri, 01 Aug 2025 07:26:20 +0100,
> wangwudi <wangwudi@hisilicon.com> wrote:
> >
> > Hi, all
> > When running some FIO tests on ARM64 server(Kunpeng), frequent NVMe interrupts occupy the
> > CPU, and the CPU's hardirq load is 100%. The watchdog feed interrupt arch_timer cannot be
> > responded, triggering the hardlockup.
> 
> I am extremely surprised that even with a screaming NVMe (or even
> several of them), you end up in a situation where you don't have the
> resource to take the timer interrupt.

+1. I will probably have an offline discussion with Wudi today, or a bit
later, to dig out more clues about it.

> > GIC driver uses GICV3_PRIO_IRQ to set the same priority for arch_timer interrupt and NVMe
> > interrupt. In GIC spec, "If, on a particular CPU interface, multiple pending interrupts
> > have the same priority, and have sufficient priority for the interface to signal them to
> > the PE, it is IMPLEMENTATION DEFINED how the interface selects which interrupt to signal."
> > Shell we consider setting a higher priority for the arch_timer interrupt to fix this case?
> 
> Linux only deals with two priorities: the normal interrupt priority,
> and NMI, where the NMI can preempt any other interrupt. obviously, we
> don't want to make the timer an NMI, as it would break a lot of
> things.
> 
> Which means that even if you were to give the timer a higher priority,
> it should not be allowed to preempt any other interrupt. Which means
> that you'd need to set the binary point so that both the NVMe and
> timer priorities fall into the same preemption bucket.
> 
> But it also means that you now are eating into the few bits of
> priority that we have, and that will cause problems with the NMI
> priority. Also, how to you decide what interrupts should be of a
> higher priority?
> 
> I find it surprising that your GIC doesn't have some form of
> round-robin scheme to pick the next HPPI, because that's clearly a
> fairness problem, and punting that on SW is pretty ugly.
> 
> Thanks,
> 
> 	M.
> 

