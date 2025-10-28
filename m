Return-Path: <linux-kernel+bounces-873796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A0C14BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 482D04FDF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E36330D25;
	Tue, 28 Oct 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0q6CIKqS"
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3531DD525
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656511; cv=none; b=lznRxoFG35ZDPHSbCc6ow7FttDYIjHdLRFP7VsjklBITS1qIBQW0mcBuofy/bVDYg7tamFasN0A8EuLGTnW2ULiQOu8dcp8o67WXHo4Y3l9r7V845de4Ahx/Y5eJL2K2ZrPwopcxLXNMDnNyS8d3I/f2hKSom6i8Bs0HoFfvtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656511; c=relaxed/simple;
	bh=G+je3gq6SyPr4mpic59RxkXyND0BDnxnTAB1RME3Z7k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh8GHhNImHGZaUcwBZTUffvB/TNAJx5NW9KQB9/YP+swS8U55+lILLTCbv6yd1z65eYJJmIK9EaiDmRsTM/G0Zd2F8pX6M0JbV15MarZxxVXItVYQChuwHnsWyDMiBhTqcs0Dg1uHLJYBz4Bd9jQwzkA8lhn5yC3s9gkcpVZ0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0q6CIKqS; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XlmmVyLrW9dxB5D/jeLU9wLivg2YAqzJk0hijCQf38Q=;
	b=0q6CIKqS9pZHjGnA2xxGdlLBxvFNFIVWVvYNODcuuM/VMf5yr54r4KZon8S/johgIzA5tpn1o
	l0wTWlUL5iHLwzGeLo+GE1WjLt9uN+SIMTXs2QV/zpBtyWHoKLIVn4ePf8mf3ZyQVqO1guwdc/l
	cZ0iIUoPEvpZcqha7wC4dD8=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cwqlx2wmcz1vnJV;
	Tue, 28 Oct 2025 20:42:53 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwqhk2vR4z6HJcZ;
	Tue, 28 Oct 2025 20:40:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 35F071402F8;
	Tue, 28 Oct 2025 20:43:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 12:43:35 +0000
Date: Tue, 28 Oct 2025 12:43:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <ben.horgan@arm.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvmarm@lists.linux.dev>
Subject: Re: [PATCH V2 2/2] arm64/mm: Add remaining TLBI_XXX_MASK macros
Message-ID: <20251028124334.00001e77@huawei.com>
In-Reply-To: <6e7d0bf3-ddf1-44a0-a0cb-7dc994101878@arm.com>
References: <20251024040207.137480-1-anshuman.khandual@arm.com>
	<20251024040207.137480-3-anshuman.khandual@arm.com>
	<20251024120014.000020af@huawei.com>
	<6e7d0bf3-ddf1-44a0-a0cb-7dc994101878@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 07:06:45 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 24/10/25 4:30 PM, Jonathan Cameron wrote:
> > On Fri, 24 Oct 2025 05:02:07 +0100
> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >   
> >> Add remaining TLBI_XXX_MASK macros and replace current open encoded fields.
> >> While here replace hard coded page size based shifts but with derived ones
> >> via ilog2() thus adding some required context.
> >>
> >> TLBI_TTL_MASK has been split into separate TLBI_TTL_MASK and TLBI_TG_MASK
> >> as appropriate because currently it simultaneously contains both page size
> >> and translation table level information. KVM on arm64 has been updated to
> >> accommodate these changes to TLBI_TTL_MASK.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Oliver Upton <oliver.upton@linux.dev>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: kvmarm@lists.linux.dev
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/include/asm/tlbflush.h | 26 ++++++++++++++++++--------
> >>  arch/arm64/kvm/nested.c           |  8 +++++---
> >>  2 files changed, 23 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> >> index 131096094f5b..cf75fc2a06c3 100644
> >> --- a/arch/arm64/include/asm/tlbflush.h
> >> +++ b/arch/arm64/include/asm/tlbflush.h
> >> @@ -57,9 +57,10 @@
> >>  /* This macro creates a properly formatted VA operand for the TLBI */
> >>  #define __TLBI_VADDR(addr, asid)				\
> >>  	({							\
> >> -		unsigned long __ta = (addr) >> 12;		\
> >> -		__ta &= GENMASK_ULL(43, 0);			\
> >> -		__ta |= (unsigned long)(asid) << 48;		\
> >> +		unsigned long __ta = (addr) >> ilog2(SZ_4K);	\
> >> +		__ta &= TLBI_BADDR_MASK;			\
> >> +		__ta &= ~TLBI_ASID_MASK;			\
> >> +		__ta |= FIELD_PREP(TLBI_ASID_MASK, asid);	\  
> > I think you can replace the two lines above with
> > 		FIELD_MODIFY(TLBI_ASID_MASK, &__ta, asid);
> > 
> > It's a small reduction in code but I don't mind much either way.  
> 
> Right. FIELD_MODIFY() might be appropriate in this scenario but
> there will be some additional code churn needed. I don't have a
> strong opinion either way.
> 
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -55,13 +55,12 @@
>  } while (0)
> 
>  /* This macro creates a properly formatted VA operand for the TLBI */
> -#define __TLBI_VADDR(addr, asid)                               \
> -       ({                                                      \
> -               unsigned long __ta = (addr) >> ilog2(SZ_4K);    \
> -               __ta &= TLBI_BADDR_MASK;                        \
> -               __ta &= ~TLBI_ASID_MASK;                        \
> -               __ta |= FIELD_PREP(TLBI_ASID_MASK, asid);       \
> -               __ta;                                           \
> +#define __TLBI_VADDR(addr, asid)                                       \
> +       ({                                                              \
> +               unsigned long __ta = (addr) >> ilog2(SZ_4K);            \
> +               __ta &= TLBI_BADDR_MASK;                                \
> +               __ta |= FIELD_MODIFY(TLBI_ASID_MASK, &__ta, asid);      \
		  FIELD_MODIFY(TLBI_ASID_MASK, &__tab, asid);

as it's done in place in the second parameter.
 



