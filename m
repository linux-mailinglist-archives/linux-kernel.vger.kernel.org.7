Return-Path: <linux-kernel+bounces-657998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170B1ABFB54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA951BA42CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC16D22B8D9;
	Wed, 21 May 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib09jWN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE071537C6;
	Wed, 21 May 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845306; cv=none; b=JGX9AIQbfBL2PtQYnuChHSwX/EFBgIfYGsQLeJ7CQb7rkOeL7nT9l093nFcLKyrEjZpDbMlD5JRoOwi8IoMxKtHeTNH1+M5FbXsu7L/myzXkdsktJCavtwY5fmnU3xP2IWV1q7XTnHJkU0ElnIqaPGPNfg/kSRAe1vjuiIeFktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845306; c=relaxed/simple;
	bh=WlSMZxIVGKgk3pfDff8mZ2qggiwFRsXoxjNQzoTE4yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc+f/QzdPfivETbcRkbUGA9jdr8RP+rIFH30zhFd4dD7/7npLO/xku2PyWASOyEDAzKAlbUnmRCC7GZ+FYr+NSZdmaoNkqExq3+OrBBUirGizGVuKCExhRGTd7yBspaPcGqXME+JMAQ12GEviDhasvsGK2XiBrq7NUWHAruwamY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib09jWN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B843C4CEE7;
	Wed, 21 May 2025 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747845305;
	bh=WlSMZxIVGKgk3pfDff8mZ2qggiwFRsXoxjNQzoTE4yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ib09jWN1SgKcjMnB2M3jGaKTGHxhqDlLfyCnHFsYMXbVBnzO81zsrSQ9Jxl8f5Ca8
	 kaF7AXEvWuNAGosppZFgLlDM5v860PiXMMe3KH2ctrS4ugFWP+0/iPUtbHrS3ntQf6
	 vjfCY4ZXGGzzlJNlUkSy7rYYp39j4oFt3qkquOY2tDiS8Tb0cf6mF9A6AAq6liAaal
	 gp+ER8nx/JS6EUecFN/TLCE6SNKa3xXOiqKzlghoD71xoqE1CamaVCuW3W0mIspv0U
	 yS8g7kiozI190moOp45WVLM2ztta701B+TqjChFz90dxsHeurSYJ5RKymGBn9qPAM5
	 abNhUd+4XYRaw==
Date: Wed, 21 May 2025 06:35:04 -1000
From: Tejun Heo <tj@kernel.org>
To: shashank.mahadasyam@sony.com
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Message-ID: <aC4AuPxKGcTf1A5t@slm.duckdns.org>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>

On Tue, May 20, 2025 at 11:07:45PM +0900, Shashank Balaji via B4 Relay wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

