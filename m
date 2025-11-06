Return-Path: <linux-kernel+bounces-889170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D8C3CE22
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEE13AF18C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922473491DE;
	Thu,  6 Nov 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQRwwq3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEA19D07E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450574; cv=none; b=Q89T0o2IrddpLLP70ESNSiLHPI50Y2n53pvVFwhuEd21/yKwd9Mjj05oV0mKOuJd7MBwutt4IAFjwt3t3zteTGLVS+Pr2AVBPyGDP0tgXN8ZBKRl4lQx7zF4rr2Ixd4BVKe4dMXuTMmTU/7PhcVhLWU33pnBAbLrZ/21Bz/iZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450574; c=relaxed/simple;
	bh=mFe7kz/m3IOlNyZfxanBW/veFAGMpPgQM2JWBxcjnT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoTqaB37BFR/7YtHwSDapdTdH1C3Aa3Ir5PUa5N+Miy1bIMhBxre0AmPhP3uf7KK0RuqAIC7fWASayf/po66P7miMIW6SaRqI0SeLaRnR150aZ0z79+JtqNDgpVVHIi92hOKPXHEQ92obbMurewV10lgFC/JukAGI84V1J3bDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQRwwq3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517A1C4AF09;
	Thu,  6 Nov 2025 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450571;
	bh=mFe7kz/m3IOlNyZfxanBW/veFAGMpPgQM2JWBxcjnT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQRwwq3LmLUFM1pVFLig4M7na84tZdXs4A49kBbQO4dNWriolSpieRSb8VuHHMZ48
	 Hp5coHum7tBC7SkLTt4hskZ7QEW3Az/2BUYN4YanvhPFZ3AQanfvAudk3XlyBlW4L1
	 LfEgY5YHANLsDQLOmqjD0MGHDfrsxwOYGsG3yAT7A943SKeXfwajqrar1kqGwnXyLc
	 gb1OxE/2V97q4mPcz5Zw7G3QyOTjQBtuNpz8fZFvQPxf33G0vJWbfjrtvgAnRiHjtE
	 /JpsiuA1m/Y8p1b/JD5Ti1GbY0EQkVzM84IKJaPg8bNj/b6vyzlFks6tUOyZHA0tjP
	 JWeqEnxsE2j/w==
Date: Thu, 6 Nov 2025 07:36:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <aQzcimG9JLsWTZdH@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <aQv2xkFKWTdU6xU1@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQv2xkFKWTdU6xU1@mozart.vkv.me>

On Wed, Nov 05, 2025 at 05:15:50PM -0800, Calvin Owens wrote:
> Works for me, no splats with that on top of next-20251104.

Thanks for testing!

-- 
tejun

