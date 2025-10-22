Return-Path: <linux-kernel+bounces-863983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDDBF9A68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F4E04FC35B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECF720A5EA;
	Wed, 22 Oct 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUChTIFK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496053F9D2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097870; cv=none; b=RNR9qq1Y06EFSftUht2/LwtdwZt4mxenQvq+QnzInEYxFlteN7ij+l77nu+Na2UGD4gKYlUrOQK6P4zaVGky6Gy7TnrN2c8+6qQZrud1qCXRpIZXknvNdTcHxK3ZhawZ4Mki6gNfMCZIavz4GV1AzitsFP3LPT1X9gpNR4k2lnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097870; c=relaxed/simple;
	bh=M6c8HbksTy9YaQrooyjRe4bq+q1w4ySMC3x/H0yPBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf0F20cz1ZyoUNvk9BCjixWaRqAKPMtcRma3IkmWyCYBD5RzPiYiGK5lEs6CgHc1aqdlB/AxVGVvYJleuy5C7xxxw1b5H68ghHxjK/pxrxAcoFWCAVASa7BQOx8Faz8kkLq+ShI9fQX3/hDARV73c0++v+RCnK9dzF4NM03tMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUChTIFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EC1C4CEF1;
	Wed, 22 Oct 2025 01:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097869;
	bh=M6c8HbksTy9YaQrooyjRe4bq+q1w4ySMC3x/H0yPBFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUChTIFK+sL3dyNfeemA8WRYJ74gjM8V4MWxPhiGYGZPxYH9PSu8WebtjCC6Hp8Us
	 XNRqEM474sk5siDtcmM3tidhfix3D/2vovlZ8wnFekJt+FZMnvVa/k9zeTspxuFlgA
	 7tIZnL0WGPktlhF94bGJxHyR0UOY0TQWIE5PXmv2e0i+oe8+1zu3vcB8DHfGpTw/WZ
	 HGwhurx6ht5ZlqSxudLqL0zIiJT3REm3DwWE+kHffFf+S9Hje6DXnTpdnsrc/CJRQ8
	 PJnNx9LoCb9sSlae60SFwyOlGZtVW6WDbgOOsSNXzfW5hZg+6lBCxmirVcGG4d9t9p
	 SL0MnpWNH/gAQ==
Date: Tue, 21 Oct 2025 15:51:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, christian.koenig@amd.com,
	pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPg4jKrlYajO7jd_@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <aPgBjmIm6n9H-R_u@slm.duckdns.org>
 <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>
 <aPgXH_JjkmKO5_a_@slm.duckdns.org>
 <aPgxy3lIqW1rUGsx@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPgxy3lIqW1rUGsx@lstrano-desk.jf.intel.com>

On Tue, Oct 21, 2025 at 06:22:19PM -0700, Matthew Brost wrote:
> > please update the patch so that WQ_MEM_RECLAIM implicitly enables the
> > checking?
> 
> Sure, but a bunch of things immediately break—including a convoluted
> case in my driver. I can fix the kernel to the extent that my CI catches
> issues, and fix any obvious cases through manual inspection. However,
> I suspect that if we merge this, we'll be dealing with fallout
> throughout a kernel RC cycle.

Sure, we're still early in this cycle and can try to resolve as much as
possible and if there's just too much, we can make it optional and so on.

Thanks.

-- 
tejun

