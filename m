Return-Path: <linux-kernel+bounces-759580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2CB1DF7D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FB4586491
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B1239567;
	Thu,  7 Aug 2025 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LJ5ETs+A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A02264B2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754607242; cv=none; b=hp85ubOSRvm8az/ufuccvq0ijrihWp9kDDj7QVfliNP8m/MNj0fXw9Q5AXdsY9y5tuuureBwP0rDwGRu/N7mbEQeyi0ahnF2xyKXV1+6Gf3PmnlW7GBVWiKRVL0MfUVNRXzsrMXxFATspfyatot9GVzJWtPe+wPeB15x1Wpu4CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754607242; c=relaxed/simple;
	bh=yTxomUojmR5ID0F+z/FwDbe6uM8bu+LgQm9RYqbWYzs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PYHz+4F/UDtsTRVcEDTB+OzgkZZ9NsPD/8wC6zkD5kIhePOSxi+nK4e2JUPNmoLr71hziB5QB77VTtxzDu4ddl3UcT0nJDKD+gui8SOMi1hzkU6TIsaOMQtZl5L7RFel8Fbo5CIm/2chv4o6VbW117gpP4i2oMHB9bNGLk2mwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LJ5ETs+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F9DC4CEEB;
	Thu,  7 Aug 2025 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754607242;
	bh=yTxomUojmR5ID0F+z/FwDbe6uM8bu+LgQm9RYqbWYzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LJ5ETs+AxmbXea/uHsVXOIXY4Zhn0UQoSkETvcS25bbsuKqckwwZ9aCS3KIyPkD0v
	 elTmXugxMwPUplL1yuCSzk0AT5mqDpEcJG6X4i61ND5CnLAPC0eqK8j/SIi4OFltwV
	 lzVG5JbZw0WItpPuOP8tj+KtUyyR4JiKmthmGDt8=
Date: Thu, 7 Aug 2025 15:54:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, aarcange@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 ngeoffray@google.com, Suren Baghdasaryan <surenb@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, Barry Song <v-songbaohua@oppo.com>, David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
Message-Id: <20250807155401.683c77b0d0cb5c9ec88089e6@linux-foundation.org>
In-Reply-To: <aJT7qQzEs_p36yfI@x1.local>
References: <20250807103902.2242717-1-lokeshgidra@google.com>
	<aJT7qQzEs_p36yfI@x1.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Aug 2025 15:16:57 -0400 Peter Xu <peterx@redhat.com> wrote:

> Hi, Lokesh,
> 
> On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> > 
> > Without batching, in our testing on an arm64 Android device with UFFD GC,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> > 
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> 
> Do you know why vm_normal_folio() could be expensive? I still see quite
> some other things this path needs to do.

Maybe as explained here?
https://lkml.kernel.org/r/20250807185819.199865-1-lorenzo.stoakes@oracle.com



