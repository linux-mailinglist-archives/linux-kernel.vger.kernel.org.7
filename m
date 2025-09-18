Return-Path: <linux-kernel+bounces-802539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27EB45384
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876017AAE14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4852874E1;
	Fri,  5 Sep 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IPFOiGd6"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ECF27AC2F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065140; cv=none; b=FcYi3soKspxLFupubvd9T8xYv9lPkMCPnfGGE1Fejbz2FWEPr6BxlDoDOaHA+naIqVzK6H4PfLN983RWF6pqMTXYzOiQOoYAhVzI1QqBTvdIL+/MmPZxm98dZW7s55uAG/LmeB63SlVGSOanKzw0EJZ428C+0h8HkfL7560UcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065140; c=relaxed/simple;
	bh=+Er+62QDzwCWbAL7geyWkwgn8N3ROBBfj85Vxsy7SR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+F18s40YsW/hr//oWIFPl3EMWQ+NiX//SjcL490Bwx7tAplMxrk0Ta8fSvrA57Whum8iB3HxTEJ9Mm/QZm2f7/tJXCGzNdgwSHkA43pChhoXO9tuNk1p5zXIfOzI6UyJ+v/R+2pbSDmAEavVAp+wAkeyJSgfHPSgv/8HWGawSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPFOiGd6; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 01:16:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757065126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AimxSnqAg/PYk0/+Yu7w959oIMCqjnKqkDuKgUOQXrc=;
	b=IPFOiGd6nIg8BQj/3OlbgYRSciVmUyCRcdp3IWtWHp2QxD5/bhIaXR79alskup155NcZS5
	w0/e8HFUNtN6zzSHOFf802lfw2wW4PHS+kCM3v46gqsSXvEmo7kBoCBf/BwCTU1OwYhy71
	WEflbCu1/Q3gwE1mfci2KBBWQJT/RKY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: p@sswd.pw
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [PATCH v2] KVM: arm64: nv: Fix incorrect VNCR invalidation range
 calculation
Message-ID: <aLqcZ6zL4rTtxfaS@linux.dev>
References: <20250903123949.24858-1-p@sswd.pw>
 <20250905083008.27725-1-p@sswd.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905083008.27725-1-p@sswd.pw>
X-Migadu-Flow: FLOW_OUT

Hi Dongha,

Thanks for respinning. Please send new versions of a patch series as a
new thread (i.e. don't specify In-Reply-To), it helps a lot for patch
organization on the receiving side.

On Fri, Sep 05, 2025 at 05:30:08PM +0900, p@sswd.pw wrote:
> From: leedongha <p@sswd.pw>
> 
> The code for invalidating VNCR entries in both kvm_invalidate_vncr_ipa()
> and invalidate_vncr_va() incorrectly uses a bitwise AND with `(size - 1)`
> instead of `~(size - 1)` to align the start address. This results
> in masking the address bits instead of aligning them down to the start
> of the block.
> 
> This bug may cause stale VNCR TLB entries to remain valid even after a
> TLBI or MMU notifier, leading to incorrect memory translation and
> unexpected guest behavior.
> 
> Credit
> Team 0xB6 in bob14:
> DongHa Lee (@GAP-dev)
> Gyujeong Jin (@gyutrange)
> Daehyeon Ko (@4ncienth)
> Geonha Lee (@leegn4a)
> Hyungyu Oh (@ohhyungyu)
> Jaewon Yang (@R4mbb)
> 
> Link: https://lore.kernel.org/r/20250903123949.24858-1-p@sswd.pw
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Dongha Lee <p@sswd.pw>

This SOB still doesn't match the one you used to author the patch.
Please make sure the author and SOB lines are an exact match, both name
and email.

Otherwise this looks good to me. I will apply it if you can respin once
more.

Thanks,
Oliver

