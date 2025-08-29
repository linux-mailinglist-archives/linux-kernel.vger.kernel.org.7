Return-Path: <linux-kernel+bounces-791827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F52B3BC66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D77170A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BD303C88;
	Fri, 29 Aug 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvvWIUNL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F9274B30
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473718; cv=none; b=KHlFYfQo/SxIYlhJR3pNM6ZtFVdNSj7z2msjedKQaic/W1dDrF9NKjz79dz94lZHLX+F8IprFFTlun2QpSiTe7Xp1Eb81FVg+XM6DwhIB+twwoA+y1fxoX2gC07zbZKr3SftlgXQGZV9aA8M3vDlmLXHX4UlRuenThZzT3Pd1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473718; c=relaxed/simple;
	bh=MoQuInkk9tRs7HQv5Ll3cdnvNc+UUHtZe9abdWALjY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D53yXP3Lwbr9FGh2TCV3uZSu/wRT8PCieggnFOjXFQI3YdIsBd482+IC39xWV2MizRpMQTgE3o+W8z2N0tPqiPKNKs57oJKzCfUxMYIJcTI4pRzV9hdRvId9t2+7nrXRDivdkNWEaHt3Mzmpzi6lKb0PXSRiNyW92yr5j1RD8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvvWIUNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7C5C4CEF0;
	Fri, 29 Aug 2025 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756473718;
	bh=MoQuInkk9tRs7HQv5Ll3cdnvNc+UUHtZe9abdWALjY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvvWIUNLTDPfJMYkcneF12V40GscPyZxBZdIk0amGV0Ur+IDwkBMyqFXptdrxy26K
	 1wbuTzoqSSMhDFFTLy3wgYQjv73+azgZ8QRG2aw3mnQ9OmhakeOMMOc2l0JRuHUAWq
	 r1fr/ofSijZYCfC77n+g2a3D6I5p2SpqSs2jtgxiZWlDIn63rgEYO/4NKSy2zM8i1A
	 DU0NZhajL65tftYQuJjnnwba5ybp+dqkWUAGb17iwGSY3esIIV+hnEhtbrTijnkrim
	 HVJRUppT3w1V06iTeWNnYI4wshB+miJFe/jxxJ8sT2U4FCAmLlnpe65X+xiJtQAe4T
	 1ocYs99QTgA3Q==
Date: Fri, 29 Aug 2025 14:21:52 +0100
From: Will Deacon <will@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
Message-ID: <aLGpcOSTGiJIRQda@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck>
 <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <aLGVsXpyUx9-ZRIl@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLGVsXpyUx9-ZRIl@willie-the-truck>

On Fri, Aug 29, 2025 at 12:57:43PM +0100, Will Deacon wrote:
> On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
> > Patch is against 6.17-rc3; but if you'd prefer the patch against 6.12
> > (or an intervening release), I already did the backport so please just
> > ask.
> 
> We've got 6.15 working well at the moment, so I'll backport your diff
> to that.

Notwithstanding my question about the synchronisation, I cherry-picked
86ebd50224c0 ("mm: add folio_expected_ref_count() for reference count
calculation") to my 6.15-based Android tree and applied your diff on top.

With that, I've not managed to reproduce the original failure and
haven't observed any migration failures on the GUP path.

Cheers,

Will

