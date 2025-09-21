Return-Path: <linux-kernel+bounces-826059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74586B8D6ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F25E3B1087
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B62BE7A0;
	Sun, 21 Sep 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg+I5mIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C4A17BD6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758440392; cv=none; b=tLqAzlOLRCdvsS2MeAeSMPX6PRmFRgDNx4jWyc5EeWglKfDiNbqad9tqCuPx22BhO26825OuO2KsLk3n4BInK7GLhwVpBQv78vJHEBIZsZZgkqGalyRgTQxdyo3vNtO0HaKbEpuQ3vM6vuMs0V5fhowq0Utvle8bY2EpTlPNaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758440392; c=relaxed/simple;
	bh=YeDyQS3+mMpnmNaLa0DMpyp/Ge24svjN6e7TseL5PlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzCRr0oTue27MtYL1aGMRlQBsESuBdPh9QUGZNudccrymKu7tQUzqY0MilHycaG2euOE5lmP6isbXVyrHI6H0QWmr/JMp+HnUYleWIBKp9jaV7Qv4l1WkvPjW9E3+ONA4U1bKQtpt+KRP8u9/FyxzIMy/jRnGCHqXmQFpnMVZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg+I5mIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF0CC4CEE7;
	Sun, 21 Sep 2025 07:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758440391;
	bh=YeDyQS3+mMpnmNaLa0DMpyp/Ge24svjN6e7TseL5PlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jg+I5mISszxOM6vxuJLUP7StToWz2ZhNXOYlCHpWWucv2FOMahAAyW9olJkCHsamN
	 rptxT2zcVb5KRr7njgD83lT1mW0XXICmlWbWIlDs9w8Kq3KCrno3ezVryu+wXrD5Ut
	 cMyPy+D+JD+TZIebBf999+FwAyKy2KNsit1+aaVs4qnz7B7dbCUeTmHf1yM3nEiyp7
	 IOOSC4jJ8ECjGy9cGQ/b3k32jrQ3Lyxc1WOE1/LaesVDBbA2qf6h5NOzHxkL1C0aVD
	 Eu7l0e46W6X6qyeLMYzsCNbNmUMng0duQKijN+C1f9MyeLyCyMSXb9nAoGUrF0bUIa
	 ZvTVD+X7Gz3qw==
Date: Sun, 21 Sep 2025 10:39:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove PMD alignment constraint in execmem_vmalloc()
Message-ID: <aM-rwfvR32xmbCXj@kernel.org>
References: <20250918093453.75676-1-dev.jain@arm.com>
 <aMvf_R4ttLibbnQ1@kernel.org>
 <d4019be7-e24c-4715-a42a-4f1fc39a9bd4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4019be7-e24c-4715-a42a-4f1fc39a9bd4@arm.com>

Hi Ryan,

On Thu, Sep 18, 2025 at 02:06:25PM +0100, Ryan Roberts wrote:
> On 18/09/2025 11:33, Mike Rapoport wrote:
> > On Thu, Sep 18, 2025 at 03:04:53PM +0530, Dev Jain wrote:
> >> When using vmalloc with VM_ALLOW_HUGE_VMAP flag, it will set the alignment
> >> to PMD_SIZE internally, if it deems huge mappings to be eligible.
> >> Therefore, setting the alignment in execmem_vmalloc is redundant. Apart
> >> from this, it also reduces the probability of allocation in case vmalloc
> >> fails to allocate hugepages - in the fallback case, vmalloc tries to use
> >> the original alignment and allocate basepages, which unfortunately will
> >> again be PMD_SIZE passed over from execmem_vmalloc, thus constraining
> >> the search for a free space in vmalloc region.
> >>
> >> Therefore, remove this constraint.
> >>
> >> Signed-off-by: Dev Jain <dev.jain@arm.com>
> > 
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Hijacking this thread to ask Mike a related question, which I noticed during
> code review...

Replied on the related thread :)
https://lore.kernel.org/all/aM-rDD-TRqmtr6Nb@kernel.org/

-- 
Sincerely yours,
Mike.

