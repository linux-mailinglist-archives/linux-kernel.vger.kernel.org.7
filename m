Return-Path: <linux-kernel+bounces-801357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1587DB44428
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9B83B49C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE2302779;
	Thu,  4 Sep 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQk4p+Li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4636B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006120; cv=none; b=quYU4Kdu3+KG8Mg12FooJ8BRfUXNL+f8wTl3ooztb70xSibGHUR6V6jK0Nj3Tpm1gx7OEBICNltgQIqSxS7Un2tTtha0oa9xlH47GCM4HazFHVlxnSKdq+YxFcUun7+d9Aw3ScSy7ljKNS2hO7VKAsL1tXZfixRCusiw7+4qV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006120; c=relaxed/simple;
	bh=zT8010GcyFiL9/gy0Q9SvzWYqTObinpteNBMIoEtc+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHv9G+PgBbH+NiDJtmIfijAYXRpZFnO9mqQTGYv90hcjgmgxzRB1zPJsgJPGdo/6QhjsHajyZGrriCGI0EHh4sctbFwNJwWwn7gFfil4afszLFtBxEA7zVQ43RRtyzPups6Shkoy8RkSBdv/tcBml8cxIRyjWi5wEWq1apX7db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQk4p+Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7CFC4CEF0;
	Thu,  4 Sep 2025 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757006120;
	bh=zT8010GcyFiL9/gy0Q9SvzWYqTObinpteNBMIoEtc+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQk4p+Li7eTytJEBXGv8zS2RQy9EyrRBebqmnxMQObS5aEWaIWvWgp/ZcSQwalAM4
	 Umu1XlZKT7YrdT9p3mRfooa9JnHZ2jm2RTG1KZfpavsTiEeKCU06kQ65t3M1xwCNTi
	 UIHv3r90kk4IQaD2kcpBxFEuyaivigX4UW0uGiTgbI/SXb0u8gYQzdQQxmAa2eamI0
	 H98Cfzl87UrvZxJU2R1YCTlZnBjqL+0Pi1qHz9bpFMy5Zy93fxIUATc4d/xulpTSn4
	 ByVy0M8X2xgoUmW7PxB2h1NMVMH6Gtu5ZDAH516XC6U7mgSevbROYKjdLVazPyrOJw
	 EHtYIuDYvx/Wg==
Date: Thu, 4 Sep 2025 07:15:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mkoutny@suse.com, hannes@cmpxchg.org, longman@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpuset: Don't always flush cpuset_migrate_mm_wq in
 cpuset_write_resmask
Message-ID: <aLnJJ8n0opa86ePs@slm.duckdns.org>
References: <20250904074505.1722678-1-zhouchuyi@bytedance.com>
 <20250904074505.1722678-2-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904074505.1722678-2-zhouchuyi@bytedance.com>

On Thu, Sep 04, 2025 at 03:45:03PM +0800, Chuyi Zhou wrote:
> It is unnecessary to always wait for the flush operation of
> cpuset_migrate_mm_wq to complete in cpuset_write_resmask, as modifying
> cpuset.cpus or cpuset.exclusive does not trigger mm migrations. The
> flush_workqueue can be executed only when cpuset.mems is modified.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Applied cgroup/for-6.18.

Thanks.

-- 
tejun

