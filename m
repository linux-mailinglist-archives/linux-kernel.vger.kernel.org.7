Return-Path: <linux-kernel+bounces-863836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4A9BF93B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD83A8F39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FF92C08AF;
	Tue, 21 Oct 2025 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFtLUaQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D41E25E3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089312; cv=none; b=YxLrLGG0Jek7tvXEi1YLEJkGc1Mpy924fQ0hMQ0a4Tnt6pdgQq2dMBP+lQDqW4W3Adzu4p2X8pmz2fjT1P189YiN9C9qGX5JaQc/3gUkqylfaeWtaheAEiGc2P5VH2bLTv6X34P4l8LU/VPuPTfjsPiWdwbouG5cnB2TroOLKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089312; c=relaxed/simple;
	bh=yLUPTfQ0fOP6q5PaV+LDloE5TD4E7DwDV7LaIqrcPSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhzAb7QjE8iQk7bMB8x5k1kTbDFUOxp6Nir8VZHFr+lAKLWOXMYnH6gkZ3JSEWZ5GLC0CWigN8EhqpkBCZNilAif/7FflPMMVpOMaK92JlAT9Px0KEjsEwigyur5g1O/qLEHn0DINK55oiTwwEy1gx7vwg006QMLhXRsyWk40PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFtLUaQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1108BC4CEF1;
	Tue, 21 Oct 2025 23:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761089312;
	bh=yLUPTfQ0fOP6q5PaV+LDloE5TD4E7DwDV7LaIqrcPSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFtLUaQMOWo3d76/lTJ9Tect9Ec+1Rgy0s5sznhblE6CqzqeBEEIkhVn2yHdYo0Ye
	 7RiFzJnGfcKEy2irBmH4lmtIo6ZTMztgNrnilGQoqgJlzYeaztDVweFbYsdvqxHXHs
	 dgq40r4UMHBDGpZ0xefp3NhkcewNtcPqTQLuotkaYql2T23nUk9xZ3iOpooeeUo7bh
	 qhhhOsf0ezVALtKc2JkPRjcqV6MPyXkwTSf3aiYqGmmiGsfTrVLXYMBJwMq18Z2qLB
	 S6dpeoaHd3cSkvXjWxJPoJmMQc5TcolvDGooBsOuBg7G5iN9ZDtbCOnhSp4VBYrjqZ
	 IbWawI7Hk9f4g==
Date: Tue, 21 Oct 2025 13:28:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, christian.koenig@amd.com,
	pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPgXH_JjkmKO5_a_@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
 <aPgBjmIm6n9H-R_u@slm.duckdns.org>
 <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPgDXsQY5qAfU0Tv@lstrano-desk.jf.intel.com>

Hello,

On Tue, Oct 21, 2025 at 03:04:14PM -0700, Matthew Brost wrote:
> > Hmm... would it make sense to tie this to WQ_MEM_RECLAIM - ie. enable it
> > implicitly on workqueues w/ the flag set?
> 
> I had considered this, and for a while I thought WQ_MEM_RECLAIM already
> did what I'm suggesting—especially since I’ve spotted bugs in drivers
> where I would have expected lockdep to catch them.
> 
> In my opinion, this approach is better, but it has a broader kernel-wide
> scope and could potentially break some things. My subsequent patches
> will likely break one or two DRM drivers, so it might not be a concern
> to fix everything that breaks across the kernel. It's up to you which
> route we want to take here.

Yeah, it is bothersome that WQ_MEM_RECLAIM doesn't currently have a way to
ensure compliance. I just didn't know about the lockdep mechanism. Can you
please update the patch so that WQ_MEM_RECLAIM implicitly enables the
checking?

Thanks.

-- 
tejun

