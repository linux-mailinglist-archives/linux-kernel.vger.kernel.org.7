Return-Path: <linux-kernel+bounces-863834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E5BF939B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C32B4F4A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B4143C61;
	Tue, 21 Oct 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKC0o2Hu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4326E16C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089154; cv=none; b=AbUQvtcYhBkDtkcOxSbZM977pq1fDaaXtsOelcrMF8uc9Na1DKXdlX0U/19zGM+G+ZhWkJcNHrijFGfWTE2d2EIfsfj+wBZKP04nweqppi8q9lcF79COT4wbxsGFgKbo2B1voYFB8dPB3APW/TyIxhWsDNhSnKxxsRmGdbUNUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089154; c=relaxed/simple;
	bh=1Q261+lqodSbA5keUei/4MITWiCMB6vI0+adsJXuQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChXWRZ4DZ0WicSb/NDut2kCqY6gxL5lFmkiFL/3eBAz5tACjTK3Tk//6uJLxHjrvEV8CiVpVSDQX0jLSMWP7XNABW/lfZikLewPg4XcoaCZOEdFrKsqenPRfutFfE9GQf/GfWnJKXAeM6A8W3/feMMDzA80ROJfXkC0wrosZHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKC0o2Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67118C4CEF1;
	Tue, 21 Oct 2025 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761089153;
	bh=1Q261+lqodSbA5keUei/4MITWiCMB6vI0+adsJXuQ2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKC0o2HuGeIPZ/5AfrFlvg2UQ5VGHNnR7fUcaI5paR18KVahZo4Y5dTEvucdTlXU1
	 7TVVbhjDVBZrsGQiUn4fpiK6Sec2MpyG988/HZYvb/Fbi0mcpIn4b5zL/dPXQ8Moc/
	 DEyB++58jVsOpO2LC6ctRPw64Xn0bHMbPvk2h1JV2F4Iv9Sfjch5aJCxGiftLmfJUx
	 Rsc1cArqQ+TwIuydvM2z+fBTZUrj8sAu6sPHmM9K9D3w3YXCJ1jVpObAgGSu9q65U8
	 zwYbDVelise+SKUVw3mQ6k3iBkyJVm9ll6AYjSnOHDJVAOd0CGziOCrbK7E+seqbpT
	 1gbHB51NAOjmg==
Date: Tue, 21 Oct 2025 13:25:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, christian.koenig@amd.com,
	pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPgWgAs_5XoEWri9@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <aPgBjmIm6n9H-R_u@slm.duckdns.org>
 <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>
 <aPgD/3d7lJKoSzI8@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPgD/3d7lJKoSzI8@lstrano-desk.jf.intel.com>

Hello,

On Tue, Oct 21, 2025 at 03:06:55PM -0700, Matthew Brost wrote:
> > > Given that it's about reclaim, "memory cannot be allocated" may be a bit
> > > misleading. Can you make the description more accurate? Also, it'd be great
> 
> Can fix the comment. The rule is memory cannot be allocated in the
> context of reclaim (e.g., GFP_KERNEL).

Oh, I meant that e.g. GPF_ATOMIC or GFP_NOFS reclaims should be fine. It's
just that we can't recurse into reclaim from WQ_RECLAIM workqueue, right?

Thanks.

-- 
tejun

