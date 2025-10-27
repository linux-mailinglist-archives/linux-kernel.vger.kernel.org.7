Return-Path: <linux-kernel+bounces-871984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A9C0F087
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94B93BED62
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51E2FFDC1;
	Mon, 27 Oct 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="1CPTaco3"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E430B527
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579791; cv=none; b=VhJa6COsJ9VdO2DseAxj5K1dZaBGPizveD5Yg3tBIS4QdEUFRypQMww1m+1qEGev6TzptosMqLXXCLkq/MsAaspVMPaKVT3Vh4D6IpsFv2NL0yTK//hBb6Z/7W2bMbZspUuy18OrR/Q0KbNYjkUliofNd39Cji8K7SL0QYbZNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579791; c=relaxed/simple;
	bh=ll2hnfx4jgR0V7blXL+4D82llIfgw1Egze998yoynjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2Y7T9cLymB81rCVZ7HD8gNjd9nWQu1dvO4xm/p29K2ULFGsoITC0hc31FI+5EC3H1uoBV8gdXkN0IyU4heJzcmoGo51kYrYmvGwj9XgbUX2JdwFJ5Xmp3By6DHhIBX9G/qZqjn0KHXJ+WIk5L9Sbwqz+KnDToPdkR9RZbbg7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=1CPTaco3; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 594569AFD8;
	Mon, 27 Oct 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1761579787;
	bh=XwPY6ZXZKL3VNgA3NbvC0pR/piPoLDOJ+dzUsiJ94H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1CPTaco3cX+Rn62YylucmDopC3dUJ60e9F6CRHLlmvWvXysgLnkKnH+xTPj7pplwi
	 9q/fl+tPhlzXg9UWsegiLAurqfiUYBRiEmJHVeuIrRoJbRqf3b8+lNjpVx6pm1v5Xq
	 zKsOlcHOBGhGDXoDtQdlFvmDLhKdOPTf3J34T+7U=
Date: Mon, 27 Oct 2025 15:43:06 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
Message-ID: <aP-TCvzsUS32X9-d@shell.ilvokhin.com>
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com>
 <aPstDXRerYqi1O2X@tiehlicka>
 <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com>
 <CALOAHbDneRGZFGcTM0YuObcK0Ugctb+6Hsxvkcy=76xDmgYapg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDneRGZFGcTM0YuObcK0Ugctb+6Hsxvkcy=76xDmgYapg@mail.gmail.com>

On Sun, Oct 26, 2025 at 08:12:27PM +0800, Yafang Shao wrote:
> On Fri, Oct 24, 2025 at 7:23 PM Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 09:38:53AM +0200, Michal Hocko wrote:
> > > On Thu 23-10-25 18:12:02, Dmitry Ilvokhin wrote:
> > > > Allow to override defaults for shemem and tmpfs at config time. This is
> > > > consistent with how transparent hugepages can be configured.
> > > >
> > > > Same results can be achieved with the existing
> > > > 'transparent_hugepage_shmem' and 'transparent_hugepage_tmpfs' settings
> > > > in the kernel command line, but it is more convenient to define basic
> > > > settings at config time instead of changing kernel command line later.
> > >
> > > Being consistent is usually nice but you are not telling us _who_ is
> > > going to benefit from this. Increasing the config space is not really
> > > free. So please focus on Why do we need it rather than it is consistent
> > > argument.
> >
> > Thanks for the feedback, Michal, totally make sense to me, I should have
> > expand on this point in the initial commit message.
> >
> > Primary motivation for adding config option is to enable policy
> > enforcement at build time. In large-scale production environments
> > (Meta's for example), the kernel configuration is often maintained
> > centrally close to the kernel code itself and owned by the kernel
> > engineers, while boot parameters are managed independently (e.g. by
> > provisioning systems). In such setups, the kernel build defines the
> > supported and expected behavior in a single place, but there is no
> > reliable or uniform control over the kernel command line options.
> >
> > A build-time default allows kernel integrators to enforce a predictable
> > hugepage policy for shmem/tmpfs on a base layer, ensuring reproducible
> > behavior and avoiding configuration drift caused by possible boot-time
> > differences.
> 
> I'd like to better understand your kernel deployment strategy. Are you
> maintaining separate kernel images for different environments in your
> fleet? We've found that this approach can introduce significant
> maintenance complexity in the build system.

Thanks for the feedback, Yafang. To clarify, our goal isn't to maintain
separate kernel images for different environments, as we also prefer to
standardize on a single kernel binary wherever possible.

What we'd like to achieve with this change is a consistent baseline
policy for shmem/tmpfs at the lowest possible layer. In particular, we’d
like shmem/tmpfs hugepage usage to be an opt-out rather than an opt-in
behavior. That is, the kernel would default (likely madvise or
within_size, not to always) to using hugepages for shmem/tmpfs unless
explicitly disabled. This ensures desired behavior out of the box, while
still allowing overrides through boot parameters if needed for specific
environments.

> 
> In our practice, we standardize on a single kernel image across all
> environments and handle variations through dynamic boot parameters.
> This approach is quite straightforward to implement. If you're
> concerned about uncontrolled environments, you could set default
> values like shmem_enabled and tmpfs_enabled to 'never', then
> explicitly enable them only in approved environments.
> 
> >
> > In short, primary benefit is mostly operational: it provides a way to
> > codify preferred policy in the kernel configuration, which is versioned,
> > reviewed, and tested as part of the kernel build process, rather than
> > depending on potentially variable boot parameters.
> >
> > I hope possible operational benefits outweigh downsides from increasing
> > the config space. Please, let me know if this argument sounds
> > reasonable to you, I'll rephrase commit message for v2 to include this
> > reasoning.
> >
> 
> -- 
> Regards
> Yafang

