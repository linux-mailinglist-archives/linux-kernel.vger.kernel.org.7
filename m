Return-Path: <linux-kernel+bounces-707170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 474C5AEC0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 22:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD6B1C45D67
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AE42EBDEF;
	Fri, 27 Jun 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EpTqdnrX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54E22069A;
	Fri, 27 Jun 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054987; cv=none; b=b44EXNaI0daV1pz1WxPelf0JnDcwTLm8e245bnmhCyMggsRJI9RfCnlNe1T5dtpwOuffN5DgAeJwY026NVG21k0nHKLC9NR+q4EYCvxgIvPafstL2x9Ds1zSrc+0wJ9QLRIcxLCDiZgh0qn6BUza6lTPIhIdIyFHRJEJ5C54ZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054987; c=relaxed/simple;
	bh=cyxNrnkahbku3kxvEgPsSwg1F4QlWS4tlfvVZmFzApA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A4MxEfBs6vsDKnlrZAMWGGx/bbz2SPx12I5eKS57vNGA2Mop3stxWO/xdWBbNwBC4YuQdkmH98uDP/OLxHX0+3nTzy9iPsgGEmDrN7LVCnQiyOOZagzteKjMnU69vtGqVcp08+Nyom5jojFeXC9h4l4XQI06ocELXSfWI/BG8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EpTqdnrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50BC4CEE3;
	Fri, 27 Jun 2025 20:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751054986;
	bh=cyxNrnkahbku3kxvEgPsSwg1F4QlWS4tlfvVZmFzApA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EpTqdnrXGAyVH25ewafsDwTfyw4v5r3vzLPpP0AhIJWLIDfLzam8w+JzkDW9fqn46
	 +pDhBZ9NJraPzz0hE7SDRCovSPuVXT9e7GQbp9aLXo/pd/aEADmdDOELtTUdxtKDuA
	 BIzRhM8h1PrA6RfZdNSDrs5hJ/Txy4dO3RhN08oI=
Date: Fri, 27 Jun 2025 13:09:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, mingzhe.yang@ly.com, stable@vger.kernel.org, Barry
 Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
Message-Id: <20250627130945.dd074c7ea076359ac754a029@linux-foundation.org>
In-Reply-To: <20250627062319.84936-1-lance.yang@linux.dev>
References: <20250627062319.84936-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 14:23:19 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> can read past the end of a PTE table if a large folio is mapped starting at
> the last entry of that table. It would be quite rare in practice, as
> MADV_FREE typically splits the large folio ;)
> 
> So let's fix the potential out-of-bounds read by refactoring the logic into
> a new helper, folio_unmap_pte_batch().
> 
> The new helper now correctly calculates the safe number of pages to scan by
> limiting the operation to the boundaries of the current VMA and the PTE
> table.
> 
> In addition, the "all-or-nothing" batching restriction is removed to
> support partial batches. The reference counting is also cleaned up to use
> folio_put_refs().

I'll queue this for testing while the updated changelog is being prepared.

