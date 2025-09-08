Return-Path: <linux-kernel+bounces-805562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8249B48A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BD1188F19C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419F2F3639;
	Mon,  8 Sep 2025 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szeDtN1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E22139C9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327703; cv=none; b=ld3IMood/o4ELP/B2DbS/wXwu4kecyn6gdYebTjzNPTyD6OfXLSTSwCjp84l3w+pN+mfvT/DZGLhReR2meJx/K/CFCapsPOFtfhaUWlI9kN5zmFWvGHvK5kgzdq+XTTE9t1H6MBjsphq0KiHZJe1uFcYYLTwhmjPgdZbVYq+llM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327703; c=relaxed/simple;
	bh=ezzayDxZ/eh5ilJqIeWgMDYws3Vth7AuzHHdrl/M/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8fxpodsujngX5DHGwp/3eJw4Hni7S0XNK+8hI/IcmQYjduNDHPzyGXAWmoUdJzmOjIaWbqbNOiCzO2ejMJzxanSCYeu1ayECYQzTUXA3fwEJc3aL59Z35wmdGIOpowZOBgPAn50Ytw47Wq2gniQbMH95OREvCFV3av/2TXaNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szeDtN1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7473C4CEF1;
	Mon,  8 Sep 2025 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757327702;
	bh=ezzayDxZ/eh5ilJqIeWgMDYws3Vth7AuzHHdrl/M/sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szeDtN1Hy2mboR7182GvWrEih1Lqvgrh7pESUmR/yxOa4iGH7GLgRDPaODJaaE42E
	 Q+mUqvDPSjsg56jvX+7rgJ1+wuPyUugI4QU/jpJZlt8NSRls1xYbHigLf8KA27pGV+
	 LiE1RsPffr5SnYhj3RJQ8MfSiAYdO3wvehZpTQO0AoNc+ro1RudQcLbP8Uiik3qY4D
	 UEl+ngboJUpZcyvGg3dJ9kw0qNnqJsNzQejNlMtzWf9q2PGHr/0aoS2I29IdueHFZe
	 MpfEcwSK+HrwPgxcHuYeJBngcROm/G86N0o3yCi9jpH9ZwG3tQ8HANOL+ZWT3ymxVt
	 cEb+lKQGlJtxg==
Date: Mon, 8 Sep 2025 13:34:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aL6xUMlRFSYm41uS@kernel.org>
References: <20250907070022.2177974-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907070022.2177974-1-rppt@kernel.org>

Argh, I've messed up the posting :(
Sorry for the noise.

On Sun, Sep 07, 2025 at 10:00:17AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> Following the discussion about preservation of memfd with LUO [1] these
> patches add support for preserving vmalloc allocations.
> 
> Any KHO uses case presumes that there's a data structure that lists
> physical addresses of preserved folios (and potentially some additional
> metadata). Allowing vmalloc preservations with KHO allows scalable
> preservation of such data structures.
> 
> For instance, instead of allocating array describing preserved folios in
> the fdt, memfd preservation can use vmalloc:
> 
>         preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
>         memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
>         kho_preserve_vmalloc(preserved_folios, &folios_info);
> 
> [1] https://lore.kernel.org/all/20250807014442.3829950-30-pasha.tatashin@soleen.com
> 
> v2 changes:
> * support preservation of vmalloc backed by large pages
> * add check for supported vmalloc flags and preserve the flags to be
>   able to identify incompatible preservations
> * don't use kho_preserve_phys()
> * add kernel-doc
> 
> v1: https://lore.kernel.org/all/20250903063018.3346652-1-rppt@kernel.org
> 
> Mike Rapoport (Microsoft) (2):
>   kho: add support for preserving vmalloc allocations
>   lib/test_kho: use kho_preserve_vmalloc instead of storing addresses in fdt
> 
>  include/linux/kexec_handover.h |  12 ++
>  kernel/kexec_handover.c        | 200 +++++++++++++++++++++++++++++++++
>  lib/test_kho.c                 |  30 +++--
>  3 files changed, 235 insertions(+), 7 deletions(-)
> 
> 
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

