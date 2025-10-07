Return-Path: <linux-kernel+bounces-844689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFBBC2814
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AAD19A2E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A920E31C;
	Tue,  7 Oct 2025 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aB2uGtQi"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402622D4C3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865136; cv=none; b=s47fhvCcRO2+MrInHDLX85g5qP4+XvxnnFNcFI/IvYqBHYz/U1HWZaURhGAZxzviu5TW702hA6OZil5IU0uqKmKDhb9BH8lsl2whslaJCfQhjyPo4fgadZqf3jugiBPXP6Q5I7q6oXTfYxaz43TSbWP2AT6gAUNRu9pM8EPSrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865136; c=relaxed/simple;
	bh=EDgHwoAJzqvcFv+vwg/QTb+53s/c4vVsjUdQ6WejS8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV45WwLULrReSyOgT3Iy16Y+OtjAn52RTe+2wyS7cAJl10eDBxFSBG+ql+2IoeySkRMub+ih6IMSd8/qj2kSqIDX76ah9A6iw/8wv2v+EDPcfgweZm0SmEuCr1KkxYgM/NldCIAMe3luxJK5g09d2V29ciadgQW39yCfVtkMoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aB2uGtQi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 11:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759865122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGuyQHKKKk5kaFnYuhxhE4b42paZhXgBeZT5hWvt874=;
	b=aB2uGtQixcZ8bSr2I9L34mScrQ9EMhFP/TKRKR2UDidJ2WNbGf16h1lI1ROwOwjItLfQyF
	A+3iMUiL6K6ryXgFbkzh7Akpe1haY8MYhH3afkhXVf9KxXv0rw1jqPFcKtAIEev+/X02z5
	STF0zp5wF586aMzKids38/SPamJVS4Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	alexandru.elisei@arm.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Check cpu_has_spe() before initializing
 PMSCR_EL1 in VHE
Message-ID: <aOVckTSJET5ORY1n@linux.dev>
References: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007182356.2813920-1-mukesh.ojha@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

Hi Mukesh,

I find it a bit odd to refer to cpu_has_spe() in the shortlog, which
doesn't exist prior to this patch.

On Tue, Oct 07, 2025 at 11:53:56PM +0530, Mukesh Ojha wrote:
> commit efad60e46057 ("KVM: arm64: Initialize PMSCR_EL1 when in VHE")
> initializes PMSCR_EL1 to 0 which is making the boot up stuck when KVM
> runs in VHE mode and reverting the change is fixing the issue.
> 
> [    2.967447] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    2.974061] PCI: CLS 0 bytes, default 64
> [    2.978171] Unpacking initramfs...
> [    2.982889] kvm [1]: nv: 568 coarse grained trap handlers
> [    2.988573] kvm [1]: IPA Size Limit: 40 bits
> 
> Lets guard the change with cpu_has_spe() check so that it only affects
> the cpu which has SPE feature supported.

This could benefit from being spelled out a bit more. In both cases we
check for the presence of FEAT_SPE, however I believe the issue you
observe is EL3 hasn't delegated ownership of the Profiling Buffer to
Non-secure nor does it reinject an UNDEF in response to the sysreg trap.

I agree that the change is correct but the rationale needs to be clear.

Thanks,
Oliver

