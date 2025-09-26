Return-Path: <linux-kernel+bounces-833782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA453BA30F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EAC7B99D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C62BE658;
	Fri, 26 Sep 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYXlLIdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467A28D8FD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877264; cv=none; b=mgCmFtoJADZs3/UFu9hRQLsk6xgutOK4Cz2ZtVxlXGaNIlVnFUp5BzZ9p/oyJjQC56Ib2HlgKhtiLtFnMXLtGTIYIHxZskWyxQRdFhYNG78ilidPvsf3rkVbeJgltpafYItMM81uve/c3TKXaBTHuJCf0PMu1BdRcxbimab7+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877264; c=relaxed/simple;
	bh=aoHwYNOokXAGRoK1jVhoOEMXZxjxQdbdW4MEf+flVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJoPulZIS6y8c7DzimHL0q4EXtKtYIDhIy2BJCE8UvGROptFJCGEo0BSOasylEIEWPjjzssZ+Vy4If6M+Gnxtadce0FG5+PavzjgQHCWU9x9cynoYNmooI2xP60w4q27GSfn3n4jO+LogQfkqregSV+iyTrZqP04Zu43VzIgJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYXlLIdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D609C4CEF7;
	Fri, 26 Sep 2025 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758877264;
	bh=aoHwYNOokXAGRoK1jVhoOEMXZxjxQdbdW4MEf+flVRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYXlLIddG5o643w4XSILB/DoVovDl52dYTyTwheDRkfqFKsWIjSGiO1YNg/QQF2DF
	 Yy3+XfHgVG7ufU9kDESkrPZtZ6d/r8e83/Aj5zIqDus2HtsWqRFwB9E0CxVP8MKee2
	 59c7jKvWqAeGCPutnOJk6ZvBchzEXqTLA3H+kihwDIrfq00kEMsqu6qC+xkBL2o175
	 kBmYzKALzV+ZE6VrCqMcG2Lv1rU3A3JU+Yacg3ihF6q+O2+LyoeI2zBr1XyYSxfrQb
	 O5V93ifpDrkxRLTFW/Zx4by2jpfsBs5VFWTN2ctdyNRWtKWc+c7oNeRitDnaHZehYI
	 3YYdR/mFK1Ayw==
Date: Fri, 26 Sep 2025 12:01:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNZWTB_AbK1qtacy@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>

On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
> 
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation
> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)

This list is like asking AI to list benefits, or like the whole cover
letter has that type of feel.

I'd probably work on benchmarks and other types of tests that can
deliver comparative figures, and show data that addresses workloads
with KVM, namespaces/cgroups and this, reflecting these qualities.

E.g. consider "Enhanced security through kernel-level separation".
It's a pre-existing feature probably since dawn of time. Any new layer
makes obviously more complex version "kernel-level separation". You'd
had to prove that this even more complex version is more secure than
pre-existing science.

kexec and its various corner cases and how this patch set addresses
them is the part where I'm most lost.

If I look at one of multikernel distros (I don't know any other
tbh) that I know it's really VT-d and that type of hardware
enforcement that make Qubes shine:

https://www.qubes-os.org/

That said, I did not look how/if this is using CPU virtualization
features as part of the solution, so correct me if I'm wrong.

I'm not entirely sure whether this is aimed to be alternative to
namespaces/cgroups or vms but more in the direction of Solaris Zones
would be imho better alternative at least for containers because
it saves the overhead of an extra kernel. There's also a patch set
for this:

https://lwn.net/Articles/780364/?ref=alian.info

VM barrier combined with IOMMU is pretty strong and hardware
enforced, and with polished configuration it can be fairly
performant (e.g. via page cache bypass and stuff like that)
so really the overhead that this is fighting against is 
context switch overhead.

In security I don't believe this has any realistic chances to
win over VMs and IOMMU...

BR, Jarkko

