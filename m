Return-Path: <linux-kernel+bounces-844608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE50BC2564
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF34188B7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351621B8F7;
	Tue,  7 Oct 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA0jWiKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA23A1D2;
	Tue,  7 Oct 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860665; cv=none; b=XEQLZod440oyew0k7uljDq9dZ0527P8KPz0vRQhxMqqk2DAIQ4WcSMiv+xzrkPt1H50eS3k7jYn+Kvktjgd9A1aiogEB1lgRiW9QNCO0CEt9ARMSYj0S/I2JcqpbIHzFQo/Z+42Afgz1ayEQh58M9fCMz4H4fSnNqom4DyXjZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860665; c=relaxed/simple;
	bh=Odj3FuJNDzikCiMMxkqH+Ari9vk/WiOOrweWPDJxtaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjKjtAxn8VI2JJx1uJsLml8bxl5o8XnPrKTzDuGr5S6favWr0EVi/iDUQ9WM7ZLNqBsiScRnelN5ZO3/ZJcYwhjesEG4Ga3ziyst0EVfChboDKMMcW9sq9nO/Hj2IwxJUHopDZ2ZzgHuL+WKbzEZniYB53XffXt3wdA6lnYQ6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA0jWiKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24CAC4CEF1;
	Tue,  7 Oct 2025 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759860664;
	bh=Odj3FuJNDzikCiMMxkqH+Ari9vk/WiOOrweWPDJxtaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qA0jWiKFq1Sq84a00gX3ClU1KAs3EQjCVhIPThqeUdLfIGKOXt7sgKmzPXHcb1t72
	 B3K6zsyeMGiWbI+AKtIFQ8rTrsdcuPQ8tvUaKebjndKB0u/tNt3vDhAVww5nUAp3Cf
	 0iKJwrZiSswv9nGFe2z7aWouf0TuiMSmAI9M00L0SMotr73kXs306H183SHKeIDX5d
	 k7mf6NH7R2AHW8l6NXXrTTxsI3KDPwTDc+7A+RPv5gULBLdDLWuZKid0Y3ejufLcQ3
	 v2wLe/ecUnEMguZADUdRmYZgXFhoMz8I/vdNtzymWTmU8AqHfQsXtsjmMcidSiOC7U
	 8v7igueLXCbHQ==
Date: Tue, 7 Oct 2025 08:11:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aOVXuGBp7b2kotS9@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-3-tj@kernel.org>
 <f841e330-d490-4912-b817-76c337cad6fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f841e330-d490-4912-b817-76c337cad6fe@igalia.com>

On Wed, Oct 08, 2025 at 01:28:31AM +0900, Changwoo Min wrote:
> 
> On 10/7/25 10:51, Tejun Heo wrote:
> > With the planned hierarchical scheduler support, sub-schedulers will need to
> > be verified for authority before being allowed to modify task->scx.slice and
> > task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
> > scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
> > checks.
> 
> Is it necessary to distinguish between decreasing the slice and
> increasing the slice? A BPF scheduler (e.g., LAVD) sets the slice to
> zero for passive preemption.

It's going to be a simple "does this scheduler own this task?" test, I don't
think it needs to look at how the value is being changed.

Thanks.

-- 
tejun

