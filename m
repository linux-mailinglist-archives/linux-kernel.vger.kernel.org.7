Return-Path: <linux-kernel+bounces-838676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEABAFE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8183C61CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0262D9796;
	Wed,  1 Oct 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/G0Ac3b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923E1804A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311765; cv=none; b=f0mV3Vx4MIk1yxBeACd8o/UzK/OTJ1U70Q5t5RtSMAGGyZuQ5bSKRspalLzntZ7IkOnvW4Cav2e3voflbR07H5Fmq+wiVOx8HS2H/2RgsKtK1255HZF0RrUMj49LcQqENG6o0wlGqNtQqXsdbRDMuvlfUbbJ29tw/8ZZBC1lve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311765; c=relaxed/simple;
	bh=04DFmLbCUMb/NzDXHOJCQThEWyMLJ5888+Etag6VdOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRX1NDtq737qTZb36uvH4xqWLdrs5euMsFHU+gtD1EjH4Wjbe0tfXRZDJOvN+KtL3EG69ZTYB3V0J+EL+YMn6x+lHdx/W9qQnwNwAF4mycO6PySajPG7vnzyZp11ah0jhBpMvo9VRHkT/KTqsZbh1UFZUQBuSfk5w3OCBxOwtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/G0Ac3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB33C4CEF4;
	Wed,  1 Oct 2025 09:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759311765;
	bh=04DFmLbCUMb/NzDXHOJCQThEWyMLJ5888+Etag6VdOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/G0Ac3bW9MD0joA0ptWQEuAhTel2fNxum1zw45ojN5TzWODrY5JfgjaYIaU5B+NM
	 Xs0uMe8QqC0ujOd5MUbHKu4SRVlFyPXI1qB7CWpKxIJhJt8fpXZUqPrBntHL1fsLq9
	 n1NVvulkKA4zsqHYGY+XVaKn9t+ZFBU7K2ivE8i+c2KKWfG9ERyztd02/xkyl0bybr
	 1jN9atdzIADFce/byyhr7SP0FHvPxidXjSPBfAZNrIfoZE9JxsuyX94hIDOBrrN/C9
	 Qy9eu9CtkvBRqSwcoeag2Py9mJTeog4t8eyEAi1/uwS+skOZSywbjJyJLDJGOwRxcN
	 ItFq6gb4Ztwjw==
Date: Wed, 1 Oct 2025 10:42:40 +0100
From: Will Deacon <will@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, brauner@kernel.org
Subject: Re: [GIT PULL] arm64 updates for 6.18
Message-ID: <aNz3kLEOA60pdRmH@willie-the-truck>
References: <aNbJ0YiL7Us_eicz@willie-the-truck>
 <4016897f-42a5-bb18-4ebb-80de97f99a60@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4016897f-42a5-bb18-4ebb-80de97f99a60@huawei.com>

On Sun, Sep 28, 2025 at 07:27:17PM +0800, Zenghui Yu wrote:
> On 2025/9/27 1:13, Will Deacon wrote:
> > ACPI, EFI and PSCI:
> >  - Decouple Arm's "Software Delegated Exception Interface" (SDEI)
> >    support from the ACPI GHES code so that it can be used by platforms
> >    booted with device-tree.
> > 
> >  - Remove unnecessary per-CPU tracking of the FPSIMD state across EFI
> >    runtime calls.
> > 
> >  - Fix a node refcount imbalance in the PSCI device-tree code.
> > 
> > CPU Features:
> >  - Ensure register sanitisation is applied to fields in ID_AA64MMFR4.
> > 
> >  - Expose AIDR_EL1 to userspace via sysfs, primarily so that KVM guests
> >    can reliably query the underlying CPU types from the VMM.
> > 
> >  - Re-enabling of SME support (CONFIG_ARM64_SME) as a result of fixes
> >    to our context-switching, signal handling and ptrace code.
> 
> IIRC they're 6.16 stuff [*].
> 
> [*] https://lore.kernel.org/all/20250528114103.GA27965@willie-the-truck

Well spotted! It's nice to see eagle-eyed review of the tag summary. In
this case, I forgot to drop a couple of sections from the previous tag I
wrote -- we use the same tag name each time ("arm64-upstream"), so it
gets pre-filled with the old contents when we update it and, since
Catalin and I take it in turns, that's why 6.16 showed up here.

The good news is that the actual pull request is fine and Linus has
already pulled it. I now wonder how many quality news sites will report
that arm64 is re-enabling SME in 6.18 ;)

Will

