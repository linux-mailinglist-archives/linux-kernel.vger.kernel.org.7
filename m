Return-Path: <linux-kernel+bounces-736030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464AEB096F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94B81AA84C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D923771E;
	Thu, 17 Jul 2025 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wjGC60aX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC0192598
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791758; cv=none; b=p2gvDp+2JHzjF91p3ox8qqNG6urX9UthAVfyh+RF04gMu0uH8YPXzOD5vfBaz0ebRksN+yeg+rtgEw0jgA9gKM3CgVknlinkWbdCyg2xrWwX73EKRIh6X0mh4WVjHaFXYZtY/vqUZHemEN4iLlfzupLFKJlCOYvfBnK0PH+cuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791758; c=relaxed/simple;
	bh=Ey4NtoW0iae8Zcou1NVxFFvN4khbn8Mk3VWY0dDuxn0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o2SdGyrOjVAoOQg/iDdBsJD4pOuwBCIwzlOK5bkp6xpntATDcwMJzGu048JwxIM7KguvgdopeTIZpoapFd/w3aXZKj+ERO+pfyiD8ERNOz/cOh7Tr5s/AnBYQoz+8mp70B5PIw47pcow+lBbFkCgu3EiJ//MDy/4pWNV4uZh7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wjGC60aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13FCC4CEE3;
	Thu, 17 Jul 2025 22:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752791757;
	bh=Ey4NtoW0iae8Zcou1NVxFFvN4khbn8Mk3VWY0dDuxn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wjGC60aXfpUKsGrjtYmKJoRNK7BkOm9Rz9u/1G2VPzrEm+eA0rVtmxCeWy9G4z49N
	 4TmWIBLOHG7xyA7H5Mzknft8+6O76uAu9thHtQEPBK+md2z492EojdWthh9nkOSwU0
	 W3c5Jch7dYIhyFq9K45oRXKClHMZLSnQFAqIYhy0=
Date: Thu, 17 Jul 2025 15:35:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>, David
 Hildenbrand <david@redhat.com>, linux-mm@kvack.org, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] __folio_split() clean up.
Message-Id: <20250717153555.18676fbf351eef2286b33cdb@linux-foundation.org>
In-Reply-To: <1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
References: <20250714171823.3626213-1-ziy@nvidia.com>
	<1cb14f22-bb17-4997-bfb3-6f1d1f984d3c@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:40:55 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> The patches are in the correct order, but the 2/2 patch, 'mm/huge_memory: use
> folio_expected_ref_count() to calculate ref_count.' contains the cover letter
> and has the suffix:
> 
>     This patch (of 2):
> 
>     Instead of open coding the ref_count calculation, use
>     folio_expected_ref_count()
> 
> But immediately prior to it is 1/2 - mm/huge_memory: move unrelated code
> out of __split_unmapped_folio() but with no cover letter reference.

Doh, I placed the [0/2] inside [2/2] instead of [1/2].

Fixed, I'll hang onto the v3 series - it already has a TBU (to be
updated) akpm-note-to-self.

