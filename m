Return-Path: <linux-kernel+bounces-690705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B345ADDB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 20:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F074A1FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA8D20B807;
	Tue, 17 Jun 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYaSVPai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3B2EBBB8;
	Tue, 17 Jun 2025 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184493; cv=none; b=FqeTD9UQWg67Z3fVU6WzFk9WuMbpng//3PpiY6JX5u8CnJCcLHPibPx2+lLIDsPXoj5h7fZNdU4SdtHqUsftm/ym3LLbvsIZGCfs/+hkCRd7zZN68C6ULHdFhpNaQbpSC+GtVTUMd4VQX+ay2uwVl3Rhtz9TFuADxCfsVbEBJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184493; c=relaxed/simple;
	bh=kwpCa+/OAMCtYQUUBJy5jGP2kmO/P0/5O+LiZjW+03c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8a7C9tENaC72V4f0hyCWDPCRNzj1Fov+k8RvSsG1+dL7Ln1RJkk6M2FaEmil5oNaxmOI5PeOUJcyhO9NS5QnYv7M9TYqfV8eaW13VOI1mF51SnKSt6ci4v6k4vA/LLPLNmxFDPHGaSBSW/L/3waiCrs3rTm+DPqMzQam99KGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYaSVPai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B25C4CEE3;
	Tue, 17 Jun 2025 18:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750184493;
	bh=kwpCa+/OAMCtYQUUBJy5jGP2kmO/P0/5O+LiZjW+03c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYaSVPaiBKHQV/ikqhAEdzT9tGUmOLAMupH3xp9z6SkcNGZGZp3agoifJXiaQD6J+
	 /l3veO8NzGhh3feyKo7BEVW7lnRzusKgN/aL62d60oPVkigR8f8otukU6S0JnOfqkG
	 eTPPcM5o2KVsiAkvaEYnG5cyCijFEPyp4hTvEe2Qlc4uAZRtB8BJmTVsoSEoPj2P63
	 a70bpTXyDbQnHDTSDu5CoFmS+xiZtXSkqLfvAz8+i1yKmRgqJDmDrIuG2/tcwS9Z7R
	 MbjHSn2d3dBVX1nKJyd4Xuo/DA01TV9jPitieon1+q9CAgosmEr+y6beCfkiszFJyM
	 xPs0kKyy+l1/Q==
Date: Tue, 17 Jun 2025 08:21:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.17 1/2] sched_ext, sched/core: Factor out
 struct scx_task_group
Message-ID: <aFGyK-J2pLN-fOf0@slm.duckdns.org>
References: <aEzRVj5ha38RAEr5@slm.duckdns.org>
 <20250617085027.GM1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617085027.GM1613376@noisy.programming.kicks-ass.net>

On Tue, Jun 17, 2025 at 10:50:27AM +0200, Peter Zijlstra wrote:
> How do you want to do this dependency on the bandwidth rework? Should I
> take those patches into tip/sched/core and then you base your tree on
> top of that?

Yes, if you apply these to tip/sched/core, I can pull that into
sched_ext/for-6.17 and apply the rest.

Thanks.

-- 
tejun

