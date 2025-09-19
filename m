Return-Path: <linux-kernel+bounces-824387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C7B88F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4AA84E31BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007030AABE;
	Fri, 19 Sep 2025 10:28:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392F309F12
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277735; cv=none; b=L8p98ANkf5y9smpHMev5kt5sTXy7QHlPfz+ToamgCrzkiISDLNw+Ngo/pupuLLD/1m28cPqo0WI7sqjq8Qeo+Sd1037QhGF+wCoTbxSoeFs0DQviUddhGN4XI9OYqt1kgArBobJHvjemHKq+z4TPkgXlLcFJskgpAhtrqCGb67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277735; c=relaxed/simple;
	bh=oQNM6pqw52CFrENz2hgSKLPlQejrzg39plL3pWPWna8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emXT55wv/8oyyXSaG011Ob8uZaDu74NIwIkAgz+OhJSs/9p34+FJQ8Bx3/zwbzt85QVx+szRmvVj5Rqrl04d0Hyk0uL5ZXyj4ZOlrcW6oa3F07h5M2DqpFlKRq8hkm3rE9dr4ig1kcAYs6XILpNF4qk75CuOu1rdnav2d6iKwvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B41169C;
	Fri, 19 Sep 2025 03:28:44 -0700 (PDT)
Received: from [10.164.18.52] (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B5D23F673;
	Fri, 19 Sep 2025 03:28:49 -0700 (PDT)
Message-ID: <839ac455-f954-428f-b1a7-89778c57ee8b@arm.com>
Date: Fri, 19 Sep 2025 15:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
 quic_zhenhuah@quicinc.com, ryan.roberts@arm.com, kevin.brodsky@arm.com,
 yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
 jthoughton@google.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck> <aMrXBArFNLTdwWs3@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aMrXBArFNLTdwWs3@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/09/25 9:13 pm, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
>> I'm currently trying to put together a litmus test with James (cc'd) so
>> maybe we can help you out with that part.
> Here's what we came up with. There's not a good way to express the IPI
> from kick_all_cpus_sync() but it turns out that the ISB from the TLB
> invalidation is sufficient anyway. Does it make sense to you?
>
>
> AArch64 ptdump
> Variant=Ifetch
> {
> uint64_t pud=0xa110c;
> uint64_t pmd;
>
> 0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
>                      1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
> }
>   P0				| P1				;
>   (* static_key_enable *)	| (* pud_free_pmd_page *)	;
>   STR	W1, [X0]		| LDR	X9, [X3]		;
>   DC	CVAU,X0			| STR	XZR, [X3]		;
>   DSB	ISH			| DSB	ISH			;
>   IC	IVAU,X0			| ISB				;
>   DSB	ISH			|				;
>   ISB				| (* static key *)		;
> 				| L0:				;
>   (* mmap_lock *)		| B	out1			;
>   Lwlock:			|				;
>   MOV	W7, #1			| (* mmap_lock *)		;
>   SWPA	W7, W8, [X2]		| Lrlock:			;
> 				| MOV	W7, #1			;
> 				| SWPA	W7, W8, [X2]		;
>   (* walk pgtable *)		|				;
>   LDR	X9, [X3]		| (* mmap_unlock *)		;
>   CBZ	X9, out0		| STLR	WZR, [X2]		;
>   EOR	X10, X9, X9		|				;
>   LDR	X11, [X4, X10]		| out1:				;
> 				| EOR	X10, X9, X9		;
>   out0:				| STR	X1, [X4, X10]		;
>
> exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
> 	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
> 	0:X11=0xdead)		(* ... but the freed PMD *)
>
>
> Will

Is the syntax correct? I cannot use the herd7 command to run this.

Apart from that the test looks good to me.


