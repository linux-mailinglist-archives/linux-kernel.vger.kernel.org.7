Return-Path: <linux-kernel+bounces-774188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71E7B2AFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BE362814B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE12765EC;
	Mon, 18 Aug 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsqVydyW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBC315783
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538999; cv=none; b=J3NfqLVsP19FR8As4FX8QZ8ZF0FzGI51YHLKnubSq6dKIobvFoK0iXX3ygQqA9/kBCRvhk9cs7Th8G5eYBJWlsZvH546dqHgRSv+AanQdYU1pXPO17OhjDWWbgeMFXs9u6hLUzdoGSLFMiBRQyr4ZCzaNJ7066iiSbl/AfqzNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538999; c=relaxed/simple;
	bh=6yGFbng6TuvlASm0gMlvUw3GVPYLN4WydFGBaRcbEGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti81gTl7Vakk5WF/gnd4yjZFJwsxeaBnWqrUR6Jsr9yFoRz0UTj/G8arCJtFQHAEB4JBAbjXkxVCQV71a7KxRyDeoEeWvv17z/XoJdaivRBnlY/k6rsEZia9RPyv3khl1CsvLleTALUxDBKSOT9sx1lDhkwKuk4KUEXaA15N3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsqVydyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A0BC4CEEB;
	Mon, 18 Aug 2025 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755538999;
	bh=6yGFbng6TuvlASm0gMlvUw3GVPYLN4WydFGBaRcbEGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsqVydyWM+6jlf9FYWHFklNLd7YI9yd4iS3WUI5R2l6QcSTzHVoczw/vtY5ohjAFs
	 2D6OkDdmUoysE2G2NN70Gw+lVf10M4PUYc8hmxJnznnU+zTfudhufvJVkRLvMyBiR/
	 eHkp474VXD3CnEzAWb+QAZrYn3MN5zs6Qp3fkvjWaktGMv9UhbD7chB+bLKHB8WDbS
	 O4OY0ZUSSYvCKaS84PgdJD4kqofSCHPmWEPZul8kWQR2rCWqVzg1OyAJ+GJkb3WY+f
	 6SXyhY/ZgMqYa9vMSd0hNk6ljSeu7kc3PkyjblnoXK1VKtGWP3mkA8jC0SWyzrkEVt
	 LXSQhTKarjmZg==
Date: Mon, 18 Aug 2025 07:43:18 -1000
From: 'Tejun Heo' <tj@kernel.org>
To: liuwenfang <liuwenfang@honor.com>
Cc: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>,
	'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>,
	'Juri Lelli' <juri.lelli@redhat.com>,
	'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	'Ben Segall' <bsegall@google.com>, 'Mel Gorman' <mgorman@suse.de>,
	'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Message-ID: <aKNmNmN7YX94CO0n@slm.duckdns.org>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
 <aJqExL-CjemhWfqB@slm.duckdns.org>
 <aJqLPLxpNgKWbFmu@slm.duckdns.org>
 <b1898ea1365d460e89b64989304ea0f7@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1898ea1365d460e89b64989304ea0f7@honor.com>

Hello,

On Mon, Aug 18, 2025 at 10:45:55AM +0000, liuwenfang wrote:
> +void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
> +                          struct task_struct *next)

Might as well match the surrounding naming convention and use
__put_prev_set_next_scx()

> Any suggestions will be appreciated and a formal patch will be sent out later.

Other than that, looks fine to me.

Thanks.

-- 
tejun

