Return-Path: <linux-kernel+bounces-827982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048BB9399E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD5188A2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4E27A47C;
	Mon, 22 Sep 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bhknsX6/"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92F25784A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584158; cv=none; b=skDO6IhbIzvipD7Reu6op4K0OJJwsuot6UGfeijVCu67bnDi6j+5cWB8kM/P4fnK4+YBCCQvXeIkEOr5nGfM6uTJdakRfczFvw6em/gUR5ukuVD7B582NzgLOTItq+FOBxS8B6hhhWrNCdlDMZkPju8aTsuPP5IVccMjkQGswKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584158; c=relaxed/simple;
	bh=QvkvFySCol+f4OrBWqJ/V7kbVeZUeLaAPs0LUqnUKTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKoYIiNhW3NnmRQfMSUsSBExTrPu3sg8hnK5CxYIb5XVQAkiTNx8k9pIrSw7FDIsOJhjn8/caUcGpNTotaqPhiuTpfihcqsl0QvHkojaHH13mjjmyfmRumx4nhq/f0gUDkDGpEW1dhhqg9lOVIPHqZaB/UvDCbfoTG+m9qdRg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bhknsX6/; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758584155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YROanHWLsZyxpmkg+bbLtUTGJa8eSeOXO+0+S132Fq0=;
	b=bhknsX6/vaxKSZnPvKsUbfdwHD6LKytZGBvllisw+rMQMMDWi/4rtFUuhfA4B3/v1aCWwx
	Lp3TL0ZLYkFWymqq4yqURK4uTHU3iRkrYuECvy+ovmF+ipjkrCz8O7QI8VSLtwPLDJfEmb
	fe6iGL/v60eF86/upnlOh+WZHIH3+qc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in
 set_id_regs
Message-ID: <aNHdVtel5VGMltJb@linux.dev>
References: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920-kvm-arm64-id-aa64isar3-el1-v1-0-1764c1c1c96d@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Sep 20, 2025 at 08:51:58PM +0100, Mark Brown wrote:
> The set_id_regs selftest lacks coverag for ID_AA64ISR3_EL1 which has
> several features exposed to KVM guests in it.  Add coverage, and while
> we're here adjust the test to improve maintainability a bit.  
> 
> The test will fail without the recently applied change adding FEAT_LSFE:
> 
>    https://lore.kernel.org/r/175829303126.1764550.939188785634158487.b4-ty@kernel.org
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (2):
>       KVM: arm64: selftests: Remove a duplicate register listing in set_id_regs
>       KVM: arm64: selftests: Cover ID_AA64ISAR3_EL1 in set_id_regs

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks,
Oliver

