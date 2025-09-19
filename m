Return-Path: <linux-kernel+bounces-824494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7BAB8964A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EFE16F86C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32810307AF5;
	Fri, 19 Sep 2025 12:15:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8BF3597A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284101; cv=none; b=dbQscITXz+IB4O+UcBBcHj7cN2iAJHNlj14KN/tlv/8H48OOjCw+yA5ZVx2R5hiWC+db+mSdqKZFs+d+CQe1rIgoUIOLUXAY1Bx2Oke4PPyQh1wkVQZa/3gCrJay99Qtk5EJvgfauwTMBji859E6h48wOKlEFXFawt85VjXx8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284101; c=relaxed/simple;
	bh=+beKHJIQYtWb6UPelOK+FmlPi9FAXTmHnzAxH9jdvmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/Xi6Fc1hlrdAwLZMFGJ7u+B+k7u0fP4FHRYjJCCka57i+PnYsUtC/66wfCnYRP3BMr3CsCRLCYvfrNhim4iZ1fs5bgR8syV0AN4ADDB794tz5cB0ToK1Y7CgH+ZpRWU1GuT85ufrsKda48pRZiQXN3RIDR1+tX5SpG5MAHDAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27447169C;
	Fri, 19 Sep 2025 05:14:51 -0700 (PDT)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D1F23F673;
	Fri, 19 Sep 2025 05:14:55 -0700 (PDT)
Message-ID: <b93b0cca-04ac-402c-b522-cda8f39a52bc@arm.com>
Date: Fri, 19 Sep 2025 17:44:52 +0530
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
 <839ac455-f954-428f-b1a7-89778c57ee8b@arm.com>
 <aM0yQwt3_8WuxBC2@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aM0yQwt3_8WuxBC2@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/09/25 4:29 pm, Will Deacon wrote:
> On Fri, Sep 19, 2025 at 03:58:46PM +0530, Dev Jain wrote:
>> On 17/09/25 9:13 pm, Will Deacon wrote:
>>> On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
>>>> I'm currently trying to put together a litmus test with James (cc'd) so
>>>> maybe we can help you out with that part.
>>> Here's what we came up with. There's not a good way to express the IPI
>>> from kick_all_cpus_sync() but it turns out that the ISB from the TLB
>>> invalidation is sufficient anyway. Does it make sense to you?
>>>
>>>
>>> AArch64 ptdump
>>> Variant=Ifetch
>>> {
>>> uint64_t pud=0xa110c;
>>> uint64_t pmd;
>>>
>>> 0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
>>>                       1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
>>> }
>>>    P0				| P1				;
>>>    (* static_key_enable *)	| (* pud_free_pmd_page *)	;
>>>    STR	W1, [X0]		| LDR	X9, [X3]		;
>>>    DC	CVAU,X0			| STR	XZR, [X3]		;
>>>    DSB	ISH			| DSB	ISH			;
>>>    IC	IVAU,X0			| ISB				;
>>>    DSB	ISH			|				;
>>>    ISB				| (* static key *)		;
>>> 				| L0:				;
>>>    (* mmap_lock *)		| B	out1			;
>>>    Lwlock:			|				;
>>>    MOV	W7, #1			| (* mmap_lock *)		;
>>>    SWPA	W7, W8, [X2]		| Lrlock:			;
>>> 				| MOV	W7, #1			;
>>> 				| SWPA	W7, W8, [X2]		;
>>>    (* walk pgtable *)		|				;
>>>    LDR	X9, [X3]		| (* mmap_unlock *)		;
>>>    CBZ	X9, out0		| STLR	WZR, [X2]		;
>>>    EOR	X10, X9, X9		|				;
>>>    LDR	X11, [X4, X10]		| out1:				;
>>> 				| EOR	X10, X9, X9		;
>>>    out0:				| STR	X1, [X4, X10]		;
>>>
>>> exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
>>> 	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
>>> 	0:X11=0xdead)		(* ... but the freed PMD *)
>>>
>>>
>>> Will
>> Is the syntax correct? I cannot use the herd7 command to run this.
> Weird, what happens? It runs for me:
>
> $ herd7 -version
> 7.58+1, Rev: e39a86f5d59dee3174d08d9ab5b13155c75936fd
>
> $ herd7 ptdump.litmus
> Test ptdump Allowed
> States 5
> 0:X8=0; 0:X9=0; 0:X11=0; 1:X8=0;
> 0:X8=0; 0:X9=0; 0:X11=0; 1:X8=1;
> 0:X8=0; 0:X9=659724; 0:X11=0; 1:X8=1;
> 0:X8=0; 0:X9=659724; 0:X11=57005; 1:X8=1;
> 0:X8=1; 0:X9=0; 0:X11=0; 1:X8=0;
> No
> Witnesses
> Positive: 0 Negative: 9
> Flag Assuming-common-inner-shareable-domain
> Condition exists (0:X8=0 /\ 1:X8=0 /\ 0:X9=659724 /\ 0:X11=57005)
> Observation ptdump Never 0 9
> Time ptdump 1.65
> Hash=238908ee9413a36507c61b92a31a366a

I was using some other command :) yup this works.

I'll try posting the next version today itself, but will you be
okay merging this if I post on Monday?

>
> Will

