Return-Path: <linux-kernel+bounces-825950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B176CB8D2F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6349317FD63
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAFE2E40B;
	Sun, 21 Sep 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="F/Q/9sZP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbrekMi4"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46E4C6D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758416507; cv=none; b=dWZBWqBISe+P4uys0XSmD0kSctKRvePXcC3U+FQ/i8aSKQGD3x8pWaWz0vNtgeKMEExp1YkmC1IQba0k3yf1ODp3FQXxjD6MjJk/+IKdLLtCIOgr7yqGj5XT36F5Gq4GO2Wmz+n1JV8HcwU3xBFk7tg2B5bsrtk90arg5EWMoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758416507; c=relaxed/simple;
	bh=pCYW9JYGaak6dIleu1eaYVNK4LQQaAVWczez3LB3s4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyrvWWY5jdJ6D06ZpRRUrlDNrcgzAkWUd0d1IEbXsBWKu4JlFIPhY9A7x75v6OceA2oGae5lrzKrqLFQZh5xBENRR26IApXXWb2EyM6BVgNGbBOujPEjkOaU7Ranvgbni5PjYGaWuUw6Iu/SVYt9OG0ReAor5hjKEvbcZDq0geU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=F/Q/9sZP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbrekMi4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 81DD11D000FE;
	Sat, 20 Sep 2025 21:01:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 20 Sep 2025 21:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758416503; x=
	1758502903; bh=SOIXOBQzMncLwKGIgkvZizVY3nxteb/lnOoo5Kw5DhY=; b=F
	/Q/9sZP2Pfq4YUOUQGwyv0aKsDFhJYzDQOd175J6bSQtLhtiGMnQxhDNUiEKJu+L
	BOS3QGVQgOX2xHHu2jDIVhG1T3bFyUbohqwZytdwjZe6q1fVsqtK/bIs1v9N1Lye
	1ewtru7T2D6Z0UyZj7XsrYFDLfCUwBnfKcYXLvh2pDzVTWhB7tk0e1AtU9lcCRBt
	8j6IePVJsuKrgWhlUlvygsi9hKjBxRtChhfVqLkJWiIARK38mTSJq5NyLlHVCNzD
	+i5Q4Ri5Q4H9tJegMK2Jj47t8eszQw3W3qRhsyTvLE2sLAndkFUGqZ5JjVDm7ytw
	aalVvTsj5tlZDFlxHsGRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758416503; x=1758502903; bh=SOIXOBQzMncLwKGIgkvZizVY3nxteb/lnOo
	o5Kw5DhY=; b=YbrekMi4BiRTUaSC/9/kHWsHKAqq23tYStRq3ctgBDKucr3vetx
	nS71eRqVgOyMHLmRWGAM/qPICEHHgpHBfhQNPxgLQxeZgF3V0npGrgeGQcbdPt46
	IOFeBcR/ODbURc9IXU/61l8LhzDCsdv8rAhxA+vid0O0plgcMcQgdyWCgyp5SH1r
	ftBbkBsxKfvd8HA7dduUdZzeeiKRCD71Ed08RIb+vPzYOiitDMKRcU6EKwPcJLE1
	M1CJPIGdpJLIE9eeyB83iAUNNe6mSab7JqqX1T52XcpKNmvT8o7MkPgXMG9eT3BD
	mIXxs2CS9SDh5tbuXW13xNai12MdSMdqVxA==
X-ME-Sender: <xms:d07PaOWV_JO1Ex_kggBcMEie3ObpPFsHWXnkWN-uX6nJaxNV5uhwLQ>
    <xme:d07PaDgOGqCmooMGZPc4bCuLTsspOYGibOOQ2fhhm1eNzNRheQjimnlSWhB8RY0wM
    5y6p0-bo_kpWPAJJeQ>
X-ME-Received: <xmr:d07PaEVJFt1QlVUOFxIvaHOJgLCOllOoHSR5AMImeQPmbIZVMRcFWjA--KnzS2mSBwoJpJCNU5A-IQ_6GEToc4dilIG7FZCVIkAJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgke
    dvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d07PaCPjgWXh_8rUn-JNNQIthlLodC7H3Yt58pWaYvyEQQDP38WglA>
    <xmx:d07PaIYfdVp4Jj5CRXpgRbIXww6nDhd5PI7lHxfCh4FDcnkzJXMsUQ>
    <xmx:d07PaGrYNjae_ofL3L-aiUs5xkB1_YFgMPI0IAQCP7iqwqWjxvTqpA>
    <xmx:d07PaMbkS7I3JFEB2OOXfHX4omifmJ804rBfroD3OdMHVW9LknPoHg>
    <xmx:d07PaP6d28LvXdeeeOaALdwstjpC79y6lj2fzVhG2H6ouDGq5qkOGUYW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Sep 2025 21:01:42 -0400 (EDT)
Date: Sun, 21 Sep 2025 10:01:39 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix overlooked update of subsystem ABI
 version
Message-ID: <20250921010139.GA48628@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250920025148.163402-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920025148.163402-1-o-takashi@sakamocchi.jp>

On Sat, Sep 20, 2025 at 11:51:48AM +0900, Takashi Sakamoto wrote:
> In kernel v6.5, several functions were added to the cdev layer. This
> required updating the default version of subsystem ABI up to 6, but
> this requirement was overlooked.
> 
> This commit updates the version accordingly.
> 
> Fixes: 6add87e9764d ("firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction#")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index 78b10c6ef7fe..2e93189d7142 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -41,7 +41,7 @@
>  /*
>   * ABI version history is documented in linux/firewire-cdev.h.
>   */
> -#define FW_CDEV_KERNEL_VERSION			5
> +#define FW_CDEV_KERNEL_VERSION			6
>  #define FW_CDEV_VERSION_EVENT_REQUEST2		4
>  #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
>  #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5

Applied to for-linus branch.


Regards

Takashi Sakamoto

