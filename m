Return-Path: <linux-kernel+bounces-642649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438BAB219F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B931895AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 May 2025 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3A1E571B;
	Sat, 10 May 2025 07:05:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430691BD035
	for <linux-kernel@vger.kernel.org>; Sat, 10 May 2025 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746860708; cv=none; b=umX36dkqxYh+0YhXFITPhDSY1VoaCQt5LUazzFwrM1q6Raf6GKi8HvgFeU0OBUnxyvlWhQ4HUjrvTVxegO5Zflf1BFzrBRkUlRlTgRHbCbfp1g/bCd5z9SpHAnA1sQu1OliwmofyHjsNMQTnw9AJh69d1Uk+dGY6aav29fg9608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746860708; c=relaxed/simple;
	bh=ZunT4g/hAnBTDiXrormBjeHmfvA3rLYh+MpfEYjbllY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfKFqHGUpA2t4LpP9BcpJicBoJGAOvGpNXQnSFan7Ev94H/HBYGZdZid7kytKj4ABOtlI/ZuD2XVFWY8AonxhC9i6U0hlwgjLTMJMbi9mSEwfLBHETdAmfzGifwdDKxkVA75AKhlZmIXrsJzd/N3+qbeRXV2isttWKGZchlcWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12121595;
	Sat, 10 May 2025 00:04:48 -0700 (PDT)
Received: from bogus (unknown [10.57.45.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC1893F673;
	Sat, 10 May 2025 00:04:57 -0700 (PDT)
Date: Sat, 10 May 2025 08:04:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Radu Rendec <rrendec@redhat.com>, Will Deacon <will@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cacheinfo: Report cache sets, ways, and line size
Message-ID: <20250510-fresh-magenta-owl-c36fb7@sudeepholla>
References: <20250509233735.641419-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509233735.641419-1-sean.anderson@linux.dev>

On Fri, May 09, 2025 at 07:37:35PM -0400, Sean Anderson wrote:
> Cache geometry is exposed through the Cache Size ID register. There is
> one register for each cache, and they are selected through the Cache
> Size Selection register. If FEAT_CCIDX is implemented, the layout of
> CCSIDR changes to allow a larger number of sets and ways.
> 

Please refer
Commit a8d4636f96ad ("arm64: cacheinfo: Remove CCSIDR-based cache information probing")

-- 
Regards,
Sudeep

