Return-Path: <linux-kernel+bounces-866251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8745ABFF4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80B3A448F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45318279784;
	Thu, 23 Oct 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="to7GDf1O"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D0A278754
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199804; cv=none; b=qKCgzBt/TJr6AtaTViehj2UfYf+kOtVW3RWc7Bit6BIrZP2owfrc0cBCkJg68qKuqwSqDl7OzdH3N1u8/VgP3YFAqwwp6/5D/K545VFwEfsshxUzMgKt5cLsKiajFJt5F3qjNtVp3x5YtKl5HX8Q9AvbIRukm8KLlmREUeQWvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199804; c=relaxed/simple;
	bh=1gQoJKPO1x/TqofOaNXeALdXXsZ0E9EFZcL7LPZr7jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efgpq5wZQlYmCYHbBO2WBa79iUOl5zFj44omLyTSqQrF3ALXfG9Ex/XA8zb2SjfdyNYd2Gq/xoeg2NZriyfLFlWx+014w24ll5QZD/6MWjAT5QDmoGgw3UduTguzA5SmVCe3VdnGgRxZUAq+7EMprBfrF0sJ6Xd7qFfJ0LLZPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=to7GDf1O; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Oct 2025 14:09:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761199799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mdbOLl9vdTIDWqXeZ0i3gbMYXcGKvHlrusgaQrtWbKA=;
	b=to7GDf1OuioFYgokMgmfhvX7VUvVvYZX49E4S+efpMptcgW4zJDje9jI5GIDYPfCuk7onp
	KwNTu0YRhI5F4PNxx/sU3J8qEUur8XO5gpKxdp0Qny1HnPJ+x2OAYuoeQKf+2V+yPG8Udq
	TGbX940trv8rB3O38B0N5brzkPE1mDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip/sifive-plic: use hartid as context_id in OF to
 fix AMP conflicts
Message-ID: <aPnGsbufM1OwiNpg@kernel.org>
References: <20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev>
 <87bjm1zcvc.ffs@tglx>
 <aPbeb1SEZr7CG2eN@kernel.org>
 <87y0p4xge9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0p4xge9.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 21, 2025 at 08:23:58PM +0200, Thomas Gleixner wrote:
> On Tue, Oct 21 2025 at 09:14, Troy Mitchell wrote:
> > On Mon, Oct 20, 2025 at 07:44:55PM +0200, Thomas Gleixner wrote:
> >> On Mon, Oct 20 2025 at 11:49, Troy Mitchell wrote:
> >> > In asymmetric multi-processing (AMP) scenarios, the original PLIC
> >> > driver used the context loop index 'i' as context_id for OF (device
> >> 
> >> Which original driver and when did it stop to use the context loop index?
> >> 
> >> > tree) platforms. This caused multiple contexts from different harts
> >> > (e.g., core0 and core4) to share the same enable_base, leading to
> >> > conflicts when initializing the PLIC.
> >> 
> >> When did it stop to cause the issues? And if the issues have been
> >> already resolved, what is this patch about?
> > The issue still exists in the current driver.
> > The PLIC driver for OF-based platforms assigns context_id = i inside
> > the context loop, which assumes that all harts are numbered contiguously
> > starting from 0.
> >
> > In AMP systems (e.g., when Linux boots from hart4 while hart0 runs another OS),
> > this assumption breaks — multiple contexts from different clusters share the same
> > enable_base(e.g., core4's enable_base = core0's enable_base), causing conflicts.
> >
> > This patch fixes the problem by assigning context_id based on the actual hartid,
> > ensuring that each hart context maps to a unique enable region,
> > while preserving behavior on SMP and UP systems.
> >
> > Does it make sense? I'll update my commit message in the next version.
> 
> Yes. Though this still applies:
Thank you for your reminder again.

                - Troy
>  
> >> # git grep 'This patch' Documentation/process/
> 
> Thanks,
> 
>         tglx

