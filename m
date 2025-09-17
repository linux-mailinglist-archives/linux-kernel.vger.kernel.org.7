Return-Path: <linux-kernel+bounces-821200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F173BB80B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F60C168346
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2732127D;
	Wed, 17 Sep 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jop6rJto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C642321270
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123786; cv=none; b=AnyITKoODRr5KhHa9S+ZiiEkI2c9Jj1gI+ElMcIQWCYt5qK8TCQjN9heRxpLdeRPkv6EXlQX0HcgxBCWyPCT5YJyNdfwgqK0SVIyNH3NEB9Xbl7nJ7qaer+bIZ6ow/Porjvh5z/6sVm7KqKzkunZOFHLOsDqTSTzKSDJbj+x11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123786; c=relaxed/simple;
	bh=CrTcWSmw57vJDB60Q5vonaC865reIzum69JAsoQCNPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgPCtJWJZ1B3LerDXcqs0clLWeDkN0di8TjgNrYS30S6MZ3JWr1h3MLjmCtCVfVYbpv6OB3hqT9MsEASP6yf+ncVD8LPB11gZrktHyBof+xvYvnphBM/F6N61lpyFZg3BBn+KHnI8xb76kzvmW2cvgMJaBIInnaQN5mgUj2+Utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jop6rJto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F892C4CEF5;
	Wed, 17 Sep 2025 15:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758123786;
	bh=CrTcWSmw57vJDB60Q5vonaC865reIzum69JAsoQCNPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jop6rJto9GEsm7cFXyzefBfFgQAn0sfHoO+ZiQgz2Avl+ct+g2MyCb0TajI5KM2c4
	 cK+yR8+1cFAKPkcBF2XqvCYSV1L+S8hk+Y1OjTweGUmQnqP4Nwv/xXBpwcAzu1UFks
	 WDjTdp6sU18RmauydJJbFSD9R/bpVUfEfuLU0obc6epH1xXahmszVwnBjVDJTjrMQn
	 ZHG0PgHfFiNAoHYPmiNjkH+rUzw8qAMUFlZjvMTO6o6F9YOOJsXaYXO2KtIiZsqMo3
	 HrmRBYe1bhYrP8NaYMoYNczpyRv640lt0Lt+LI5ylXx4AOC+YWauZ+mL8178jzkzwO
	 /4GLfmjiNMJ+A==
Date: Wed, 17 Sep 2025 16:43:00 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com, ryan.roberts@arm.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aMrXBArFNLTdwWs3@willie-the-truck>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMk8QhkumtEoPVTh@willie-the-truck>

On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
> I'm currently trying to put together a litmus test with James (cc'd) so
> maybe we can help you out with that part.

Here's what we came up with. There's not a good way to express the IPI
from kick_all_cpus_sync() but it turns out that the ISB from the TLB
invalidation is sufficient anyway. Does it make sense to you?


AArch64 ptdump
Variant=Ifetch
{
uint64_t pud=0xa110c;
uint64_t pmd;

0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
                    1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
}
 P0				| P1				;
 (* static_key_enable *)	| (* pud_free_pmd_page *)	;
 STR	W1, [X0]		| LDR	X9, [X3]		;
 DC	CVAU,X0			| STR	XZR, [X3]		;
 DSB	ISH			| DSB	ISH			;
 IC	IVAU,X0			| ISB				;
 DSB	ISH			|				;
 ISB				| (* static key *)		;
				| L0:				;
 (* mmap_lock *)		| B	out1			;
 Lwlock:			|				;
 MOV	W7, #1			| (* mmap_lock *)		;
 SWPA	W7, W8, [X2]		| Lrlock:			;
				| MOV	W7, #1			;
				| SWPA	W7, W8, [X2]		;
 (* walk pgtable *)		|				;
 LDR	X9, [X3]		| (* mmap_unlock *)		;
 CBZ	X9, out0		| STLR	WZR, [X2]		;
 EOR	X10, X9, X9		|				;
 LDR	X11, [X4, X10]		| out1:				;
				| EOR	X10, X9, X9		;
 out0:				| STR	X1, [X4, X10]		;

exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
	0:X11=0xdead)		(* ... but the freed PMD *)


Will

