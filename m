Return-Path: <linux-kernel+bounces-801373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B37B44449
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B03B6662
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC234304972;
	Thu,  4 Sep 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bny5BE0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44804EEAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006835; cv=none; b=tTlLBfOTfHSSfcrIrRTHSZ4W2txBNAU54c4gzOmddzt5jasypKLCWLhZaWHBVithD6wPeqdIW+aD3QCf3UPEiDAvzkfqiGoN6BaWfEK9ZVTGo+SOnNl66CfX5KAK0xQVff++IMVXG/aR3K2Y/qs1HViFX7QEgqzGlhR1QgRm+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006835; c=relaxed/simple;
	bh=IMPCWALRY/7U2RpyauAYcqRPiOBi6NIUCHBBsZlcmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6f4dv5bCBFvZnCfDk7LpF8alBn1I/3S97pZHVZv5OYxA6imt2ymAKgJLOq9LnBXgUk1bMydAXFaA+LlAz0SYiZrL9eDuP7pd+6av876gKkBlKnzZJFRY9iiUd/OlTFLfVpgOj3E44FD2VE+jHUhfEFgZKizg0PpEKL91ipZF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bny5BE0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C05C4CEF0;
	Thu,  4 Sep 2025 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006835;
	bh=IMPCWALRY/7U2RpyauAYcqRPiOBi6NIUCHBBsZlcmgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bny5BE0Phys6NrFZTj6c9uoRNK0lkSyLAUGSik28/mmsFHiSbqRSENK8E0ZEGeEEy
	 HcpBqvEJsIN1FZT76pK6NiCujFD43w0svn1PdLHx0Rp6z16tTvJSN2xUQtMFaZLi4+
	 I2cZIZEcouD9G5gMu5/RgolxDRA1AupwVfWmOfT1ywPNU2rMsT3xum7UzYFavWBI++
	 PyUfRDtHU0eGuZs49AGltvrkm8jS/H9Ea1InNEQrRH0bSRWr5yZaqdd6S8K8gtVRE/
	 W2dvhTojGhiTup+nCrGmsjAjDt9/TRTfTuLk0Mof8VWuxQ+abVzU9UEmMe1/4e6LgP
	 hgaggXAk9BxDA==
Date: Thu, 4 Sep 2025 07:27:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, longman@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Defer flushing of the cpuset_migrate_mm_wq to
 task_work
Message-ID: <aLnL8RLdyRCPo-9P@slm.duckdns.org>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904074505.1722678-1-zhouchuyi@bytedance.com>

On Thu, Sep 04, 2025 at 03:45:02PM +0800, Chuyi Zhou wrote:
> Now in cpuset_attach(), we need to synchronously wait for
> flush_workqueue to complete. The execution time of flushing
> cpuset_migrate_mm_wq depends on the amount of mm migration initiated by
> cpusets at that time. When the cpuset.mems of a cgroup occupying a large
> amount of memory is modified, it may trigger extensive mm migration,
> causing cpuset_attach() to block on flush_workqueue for an extended period.

Applied 1-3 to cgroup/for-6.18. There were a couple conflicts that I
resolved. It'd be great if you can take a look and make sure everything is
okay.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.18

Thanks.

-- 
tejun

