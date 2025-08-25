Return-Path: <linux-kernel+bounces-785682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB2FB34F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EBF176CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25F29B8D8;
	Mon, 25 Aug 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFZV2iQm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713E4A33
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163084; cv=none; b=gLWHCockOu40ecd6P5atMDFlO3O8z0iuFtw+KYMUc0t9dj5vngtg/KhfxkBu6p1vINMNghsvQCgKFMz80xw+HyU7W+24K5pb3YASJhZ9zFjHGJ4D+zAdBcCZckFnBDIqxYrc+/tro5E1nqzhGfAsvhTRfGunkwu5NFR8uo8WPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163084; c=relaxed/simple;
	bh=m7yzx2gp8xPIyUKkpJ4QuXt629TP/wdXn0zVxJ0dZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuzPNMa8qnIIIbXAF2Q69c8h26d2Chc1owYsuCmRHXfBz/sNTjf2FWtn1e54itd/B6++3lLVsI63hT/6UPCZTFwPdoNVZFenisOrOb+NPRymfTE/O8L7nSloasYBk4ua+L/wqk68rjHp951JcufrCl+A8lv3Wgzm7yZIDyyfkAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFZV2iQm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756163083; x=1787699083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7yzx2gp8xPIyUKkpJ4QuXt629TP/wdXn0zVxJ0dZNo=;
  b=kFZV2iQm/vEKGPCfOH8dSeQVcueMXlgJlG5Rv8nFND9MDQtKN3igsu1z
   s2HYp3iKCkB4TOIO4O/OrYXtGxsFAI9FiP3cGSZZXX/fAf6NyZ7qOumxl
   r8adjxB0w9l+ejudV4iPwgWlyPhEc8x+dNp/TYFQyAi4+n4YaqdBjCrDv
   zKS//LbRQV7Pza0KsKDgkpvqM/TIlUqEryotBrhE5bEP8ZQ9w94oBiLLd
   w9CSRDprmqEy1HzoUAZsPTOI0NFvEH8Q9JpXY6Y9yGF908fBmnHsHpy+W
   BHewrXXiUn0eIa02RRM5TH1L24f3qdztyc1V29bGuLPjIxoDY7eJx1Jhx
   g==;
X-CSE-ConnectionGUID: KfFjKVC8TRmgpURUn9RoLw==
X-CSE-MsgGUID: oaMdHE+sSBaDikmdih5dhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58489144"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58489144"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:04:42 -0700
X-CSE-ConnectionGUID: fdJnNPxSQPiyzcdW/RHG0A==
X-CSE-MsgGUID: SozrkSyBSG+9zKftYPHD9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="174692173"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 16:04:42 -0700
Date: Mon, 25 Aug 2025 16:10:54 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: ricardo.neri@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: Fix a typo in IRQ effective affinity
Message-ID: <20250825231054.GA25222@ranerica-svr.sc.intel.com>
References: <20250812-rneri-irq-debugfs-typo-v1-1-f29777b4024d@linux.intel.com>
 <87ikievsh3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikievsh3.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sat, Aug 23, 2025 at 07:49:12PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 12 2025 at 14:00, Ricardo Neri wrote:
> > Fix a typo in the line that prints the effective affinity of the IRQ.
> 
> It's not a typo. It's intentionally shortened to make the output
> tabular, which makes it more readable.

Ah, I didn't see it this way.

> 
> If you want 'effective' then please adjust 'affinity:' with an extra
> space so it stays that way.

Sure. I can do this.

Thanks for your reply!

BR,
Ricardo

