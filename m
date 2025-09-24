Return-Path: <linux-kernel+bounces-831010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE37B9B253
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A614E10AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA63164A1;
	Wed, 24 Sep 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="DqbVTkca"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00B78C9C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736676; cv=none; b=N0Dq59870048siXkavwXHsV1eEEguizBs6ItMUjQq+pEKdAWfoH2m78VwtX4JfiBQknQ5fdTGKXzyciDWjrLW7xu9tPtcKjps31i03+pNlWPwgzTw/QHAuA+qxX8obKK58uCCqgh5+BGJ/wYWEF1dRrnOwdim7KNVnzJZTEYvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736676; c=relaxed/simple;
	bh=1v/KwM/huxtHbwJvg0b1BdepVHxNprsmpQM5BGSeRcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OOyREwnD3ajU6jRKoLyj2E5q5DS227uL478bYNRytUe7mRFn+SD/TJoh1eb3eRx1Q3Y0yg0SzPdp9uxnePuh8hBCsuduQE/FkUcqA/7c0Cuv7do3hg1tq44nphrEkTRA/9b40QRluCRmkeIUTjxoYbu7LKtHJcizkUV1z4kYiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=DqbVTkca; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758736288;
	bh=1v/KwM/huxtHbwJvg0b1BdepVHxNprsmpQM5BGSeRcE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DqbVTkcaY2mxqjDwK32gR+OKB5UHJGJ6fYvY5/hFtLnO0BYvabDseryR6j9qIhGV/
	 +1Epf9QOiWySiyNWVUOqqJRMqddF0uNRtewcmXp4wzVAZTbX3dAn7xFUai3uyXUXVl
	 XszpToJbf2Y9Bl4p1xU8GtFtlG9b1+YsGNq5UgVU=
Received: by gentwo.org (Postfix, from userid 1003)
	id 8B0C540293; Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 88C414028E;
	Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:51:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
    Cong Wang <cwang@multikernel.io>, 
    Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
    Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, 
    linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Message-ID: <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

You dont really need any kernel support to run multiple kernels on an SMP
system. Multiple kernels can operate without a hypervisor or anything
complicated like that.

The firmware can prep the kernel boot so that the kernels operate
on distinct address spaces, processors and I/O resources. Whereupon you
have the challenge to communicate betweeen the kernels which led to
various forms of "ethernet" drives communicating via shard memory.

This has been done for decades. I have stuff run stuff like this on
SGI hardware and Sparc/Neon back in 2003. ARM should also do this without
too much fuss.

There is even a device driver to share memory between those kernels called
XPMEM (which was developed on SGI machines decades ago for exactly this
purpose). Its ancient.

There is nothing new under the sun as already expressed over 2000 years
ago in Ecclesiastes 1:9. ;-)

The improvement here is that the burden of implementation away from
firmware and we can then have a memory based "ethernet" shared memory
implementation indepedent of the architecture.

The reason this was done by SGI is to avoid scaling issues. Machines with
high numbers of cores can slow down because of serialization overhead in
the kernel.

The segmentation of the cores into various kernel images reduces the
scaling problem (but then lead to a communication bottleneck).


The rationale for Sparc/Neon were hardware limitations that resulted
in broken cache coherency between cores from multiple sockets. A kernel
expected coherent memory and thus one kernel for each coherency domain was
a solution. ;-)

AFAICT various contemporary Android deployments do the multiple kernel
approach in one way or another already for security purposes and for
specialized controllers. However, the multi kernel approaches are often
depending on specialized and dedicated hardware. It may be difficult to
support with a generic approach developed here.

