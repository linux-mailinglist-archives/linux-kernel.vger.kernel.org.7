Return-Path: <linux-kernel+bounces-869474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F85C07F88
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6584E508534
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0065A2C3242;
	Fri, 24 Oct 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mru2RUlx"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5A2C0F95
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335493; cv=none; b=C7ZIfbq9+obKMCgXhzWwxirDc7ZSNG5YC6SngDrP4vX+IJXJH2wqEk3yp0/1bHMl3dhqf+S14t+MZEYk3Q/lKmENUASdJmxlHTQlRnT6Gakh0nXENZHBX5sSe4noVu/YDeY74Se/iHFX4LPi7ZEYA5USRxdjZGUOrQ/p7yJZdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335493; c=relaxed/simple;
	bh=XtZGMyF3R4fjdGuxpuvODD09mNUOUpWhMWE3Savnl9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6IluGsxJYyGq+8TV0pqDn9oRYJ5QW6pE+HgOyXRn2xJ5dbkIM+QdAn3wrPOxxs6EitIkOkWSoxmgkMudqXhcYPyCf+PQ6Q+ujT4Quxe/hghx7kMWxFO+YvFGJXMMc9sObJKBEORnEXu4jFAEintUb9BjJ4ObEr7rhiNF0hbIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mru2RUlx; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Oct 2025 19:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761335489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JnihTKSnvQXRg+XSStJxYAzMIrcvZ+qpSlkEbmVyp9A=;
	b=Mru2RUlxW65iES+EWbdDHmKfl/2PNCAUAzYsyTgEBFzNXCB2sc4l9k3Rhqn2Yxd/o7CP1t
	6ha8u9Rt5byaVKghoUQ7IC++mgDywxPa3y5WFKuPwvcW+Bs0ac0PRUKVjRQCDUUoAbYPrc
	bFk9IanmMd173MAMo+0GSlTWHWB2CmQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: nSVM: Fixes for SVM_EXIT_CR0_SEL_WRITE injection
Message-ID: <yx5o5o4xqwqlqcpnfrak72c3mg7mbup7ejdzwufzqgtdf3opze@zaq6ebnq2ho2>
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024192918.3191141-1-yosry.ahmed@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 24, 2025 at 07:29:15PM +0000, Yosry Ahmed wrote:
> A couple of fixes for injecting SVM_EXIT_CR0_SEL_WRITE to L1 when
> emulating MOV-to-CR0 or LMSW. LMSW is handled by the emulator even in
> some cases where decode assists are enabled, so it's a more important
> fix. An example would be if L0 intercepts SVM_EXIT_WRITE_CR0 while L1
> intercepts SVM_EXIT_CR0_SEL_WRITE.
> 
> Patch is an unrelated cleanup that can be dropped/merged separately.

Patch 1*

Also, related tests:
https://lore.kernel.org/kvm/20251024194925.3201933-1-yosry.ahmed@linux.dev/

> 
> Yosry Ahmed (3):
>   KVM: nSVM: Remove redundant cases in nested_svm_intercept()
>   KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly for LMSW
>     emulation
>   KVM: nSVM: Avoid incorrect injection of SVM_EXIT_CR0_SEL_WRITE
> 
>  arch/x86/kvm/svm/nested.c | 10 ----------
>  arch/x86/kvm/svm/svm.c    | 34 ++++++++++++++++++++++------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
> 
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 

