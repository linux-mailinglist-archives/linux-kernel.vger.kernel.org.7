Return-Path: <linux-kernel+bounces-586133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01121A79B99
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F8E3A9842
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3A219C554;
	Thu,  3 Apr 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtMk7+EN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303F18DB1E;
	Thu,  3 Apr 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659652; cv=none; b=DdHXB0mNoWZkIYjzvdSBce5PUyO46mvRnizXKRbwEsFHAsjFIeVsI8BAWBsKcvbxSNZMRIkZamLC2zHqMEJSWl6ubuPD8I5IhcfLS7VoKRIF9ivFMhXA+ExZ2wvsyhmfDgGLx7W2CrZzHPeeFCkjL3aNT2Nt/tsj65qwbCGtsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659652; c=relaxed/simple;
	bh=jWU5FiVHZr6cbl60CsMvAeFKm5C+YEWDrXvOS/vzVpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSFJHEZdZR7aciSVZIozOuQX23P7eE/hM1CDQEhgrnEjK8sDr1W/nMfDO3s3+5Nns8dpUyTZPKRywnXm0M+k358pYS/mbbYzk3xXVi10RJyl48bYdv62MJaTKjNqYVb382+q6XiAZiUk8W9t3r6dajB8eGyHfCZosEuTpompqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtMk7+EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F744C4CEE3;
	Thu,  3 Apr 2025 05:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743659651;
	bh=jWU5FiVHZr6cbl60CsMvAeFKm5C+YEWDrXvOS/vzVpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtMk7+ENS+Uike9cMD7Hu+wpxJ1siCXxmi+K6r/NjeHes7Mnwr8Ogegaey1TYc/mk
	 yZjqe3pZ9ZGkyVyzTdDsU0IANlpIw3BzcZMvcSOurs7HuUVZl0ZgnLvh25yZek/JNC
	 iSG0y9MGJ+LNYPG6yhqO9GfEVW8ky3UIq/h6qemL4cxRMN45+kNNqYl0Ythd6IHixG
	 KVa4HTi9asAU20m7m8RclD39EbZ9xdCNdgFje7G/vDJyMhb6tihHlcR0hOQqY9SxMI
	 j/oMX25SqWtzA/bbMGq0dSn56matjFpo9I23aum3V9+q/p7Ks5pjVv7f5m+LTgbq3E
	 K+5DPqbO/fdEQ==
Date: Thu, 3 Apr 2025 08:54:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-stable tree
Message-ID: <Z-4ifptwcWrlCoF2@kernel.org>
References: <20250403103817.1b0cb26a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403103817.1b0cb26a@canb.auug.org.au>

On Thu, Apr 03, 2025 at 10:38:17AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the memblock-fixes tree as a different
> commit (but the same patch):
> 
>   7790c9c9265e ("memblock: don't release high memory to page allocator when HIGHMEM is off")
> 
> This is commit
> 
>   e499d00056a9 ("memblock: don't release high memory to page allocator when HIGHMEM is off")
> 
> in the memblock-fixes tree.

I dropped it now.
 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Sincerely yours,
Mike.

