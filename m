Return-Path: <linux-kernel+bounces-644467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F8AB3CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 17:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F83A9C99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B8242930;
	Mon, 12 May 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wyYPULal"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EF1E571A
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065442; cv=none; b=NEjNB5kxHefrpz6Jh6cKfj5xD/nUY9T4VW+D7EO5pMzL94rOTzdjm1cXgHocy5QqJdb0F10rv39y/gfmWu3yCsiJhZiM+I3FTgDygqYoPASu8YfPI/FIE7v0YlM1XfziIYDLrvxHUiA1f1YEeVD6xf4N3qKoMqm5MHfBakrVhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065442; c=relaxed/simple;
	bh=U4tsIGaAhFhKkb5JREm+VTu9w0Hs7XSxl+UdCmwNueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdqNj0hwHGnGxXCnFBQWA9mBgtFDqIjRhqYirpMSXLspUqLhyyLIFpzMO8BIJfiLAAGpiUYU1ccHH8OknKc2bMy8go6XQOsa6N2yZvTYSu1OeRuF/7CiszMbRow36U1IsbB8NSajNGi/I+rNlY9+xfXjypA6QUCX/E/hViLJt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wyYPULal; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d67d893e-9c7e-487e-a14b-419a7cdc6158@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747065437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17odisrwVfR0WePoUlbvwrcF9+//6rg8N9uv1K3pM+M=;
	b=wyYPULalvB5fw0HIs6OkuKNaoOUo7Kslcz0usqpRkEFIbRxwxoAs/d174CaJG7RJjq2OaB
	WF71loshhbaA0InlldeiJFIhQiL41liHQ6zZeX3zEB7nHQtVpMSek3fZV5dvixIEG6Mup3
	FWhuddWmJsCFS0tUSCovNruAb3qV7FY=
Date: Mon, 12 May 2025 11:56:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: cacheinfo: Report cache sets, ways, and line size
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, Radu Rendec <rrendec@redhat.com>,
 Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20250509233735.641419-1-sean.anderson@linux.dev>
 <20250510-fresh-magenta-owl-c36fb7@sudeepholla>
 <f63c2be5-50e4-4c47-8a56-9a570977a6cf@linux.dev>
 <aCIVec7zl3tIh73h@J2N7QTR9R3>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aCIVec7zl3tIh73h@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/12/25 11:36, Mark Rutland wrote:
> On Mon, May 12, 2025 at 11:28:36AM -0400, Sean Anderson wrote:
>> On 5/10/25 03:04, Sudeep Holla wrote:
>> > On Fri, May 09, 2025 at 07:37:35PM -0400, Sean Anderson wrote:
>> >> Cache geometry is exposed through the Cache Size ID register. There is
>> >> one register for each cache, and they are selected through the Cache
>> >> Size Selection register. If FEAT_CCIDX is implemented, the layout of
>> >> CCSIDR changes to allow a larger number of sets and ways.
>> >> 
>> > 
>> > Please refer
>> > Commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")
>> > 
>> 
>> | The CCSIDR_EL1.{NumSets,Associativity,LineSize} fields are only for use
>> | in conjunction with set/way cache maintenance and are not guaranteed to
>> | represent the actual microarchitectural features of a design.
>> | 
>> | The architecture explicitly states:
>> | 
>> | | You cannot make any inference about the actual sizes of caches based
>> | | on these parameters.
>> 
>> However, on many cores (A53, A72, and surely others that I haven't
>> checked) these *do* expose the actual microarchitectural features of the
>> design. Maybe a whitelist would be suitable.
> 
> Then we have to maintain a whitelist forever,

There's no maintenance involved. The silicon is already fabbed, so it's
not like it's going to change any time soon.

> and running an old/distro
> kernel on new HW won't give you useful values unless you provide
> equivalent values in DT, in which case the kernel doesn't need to read
> the registers anyway.

Conversely (and far more likely IMO), running an old/distro devicetree
on a new kernel won't give you usefult values. Bootloaders tend not be
be updated very often (if ever), whereas kernels can (ideally) be
updated without changing userspace.

> The architecture explcitly tells us not to use the values in this way,
> and it's possible to place the values into DT when you know they're
> meaningful.

Well, maybe we can just use these registers for the hundreds of existing
devicetrees that lack values.

--Sean

