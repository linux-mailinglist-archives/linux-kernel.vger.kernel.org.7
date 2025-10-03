Return-Path: <linux-kernel+bounces-841164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD1BB6631
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5F53B48C9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F1B2882B7;
	Fri,  3 Oct 2025 09:38:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316E1AF0C8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484309; cv=none; b=G8JGR0Kc3ap5LquNUIwoJeLRIVbVPKZSajjcX4H6FNp5J10M49AbhEp0asel20LJZhLIJ1EFBXl9aqKTawXG1ixJgmfrEtzQQQ8KP4Rv9E/0tTH1H344zsH/wZj53TzcvPTDngz/G29EY9rT/qgR0HuCQ22J33MIQqY+YZjZ08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484309; c=relaxed/simple;
	bh=bO2Xi6RrCMi33+65AM5z3Avy5D4qvt/c3ObbwI2c6kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9ClbdywHC1tKJkHlqgvJaMoIG/N6xXKt/nCaJgfPCpdPcYlj4vX+umFr0OAhu/olAS6dVbNGCaawqbECUuiH9dT6/2z3aa+fO2tKFdrfO7aYJJ8IBoCNZSw28dBpQQQzRJT3TdvEl5tNaX0Iiqq/kyYyB2J3A3n3+KOCBXidbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D271655;
	Fri,  3 Oct 2025 02:38:17 -0700 (PDT)
Received: from [10.44.160.83] (e126510-lin.lund.arm.com [10.44.160.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FC5C3F66E;
	Fri,  3 Oct 2025 02:38:24 -0700 (PDT)
Message-ID: <ef5d851b-0f67-410e-9479-0f6d344fa17b@arm.com>
Date: Fri, 3 Oct 2025 11:38:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] powerpc/64s: Do not re-activate batched TLB flush
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1749747752.git.agordeev@linux.ibm.com>
 <8625a1d97dcf4ae499b4bb341e27346f768a7248.1749747752.git.agordeev@linux.ibm.com>
 <aFGFl9Dvb9zdC3JS@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <aFGFl9Dvb9zdC3JS@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/2025 17:11, Alexander Gordeev wrote:
> On Thu, Jun 12, 2025 at 07:36:13PM +0200, Alexander Gordeev wrote:
>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>> Therefore, the batch re-activation code is never called, so remove it.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>  2 files changed, 27 deletions(-)
> Hi All,
>
> (I trimmed non-ppc mailing lists/people).
>
> The whole series does not seem to make it, but this patch alone is still
> applicable and makes sence, if I am not mistaken.

Yes, I agree. I arrived at the same conclusion working on the next
version of the nested lazy_mmu series [1]. May I include this patch in v3?

- Kevin

[1]
https://lore.kernel.org/all/20250908073931.4159362-1-kevin.brodsky@arm.com/

