Return-Path: <linux-kernel+bounces-750646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CCB15F29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82720165D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E828750A;
	Wed, 30 Jul 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIsYKVN0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE621CC4F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874305; cv=none; b=gsUSIIiYCndTOYx7OvTY+GcO1F70dRYUNT050zbAY64zwcu6H7whPp8jEwDr05ucw/0GlIaW3co4dpC+MMPjRaE+K2Oz8arYhAqIqJMcEmzAm156OeTwdUbLha5FXpXUlSsCKSq2j0qHK9RuzHKgcpFS0k2COgP5RuA6RrjhTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874305; c=relaxed/simple;
	bh=t0ejpR8IQbxsMHqtnT89W08zsv2WKywm9SjCHzeDXwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGfV5PEDJ7+raiZpr9y6WezW3O0NYguojQdh008GqGp/Q00sXqlBs5kKq6p/yJ+ly8WgD2XeTUPBPKeDDPApSPR1gzgEt01SpcekE2hbKIS9g0qbJsnocpNB/EarKLIDhKfVxA6Q2+zROY1ctx/CqrFhnv0hHEbAjWvy2+/diis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIsYKVN0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753874303; x=1785410303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0ejpR8IQbxsMHqtnT89W08zsv2WKywm9SjCHzeDXwU=;
  b=DIsYKVN07ypZqEnXICYgGFn316GCvzFDo6kKY1EFobA+97O3VPXarAzL
   XG3tS2jTxRsSHF8/y311ExD9MLCqQUaKMb4ea6FUzPhJwki0hDUkfDue7
   YYsxzFEZO9ZVjQirZHPNGOY+dIimZAo64dtQxb52nmWJgnRhFT5IcDvf+
   LDWhL5AmqCah/BMPQwryIxWVNVjGx+/bf7CQcaaA167YNEBwsBvjtWKY9
   WFcS+UsPCDFZb/lkzOKM56TjdZms+wtDLRn+E7rJi/cFGGE7tgnilMO85
   ph4W0hpcMwcppw05Mf+CZlOMQZAKyK08Yb5vgv0y65AWOzAa+ozipCep3
   Q==;
X-CSE-ConnectionGUID: K7OfC5drTqSMmGVe9HkZbA==
X-CSE-MsgGUID: Fah9WSrkTeammc6IWRcsLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="73759345"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73759345"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 04:18:22 -0700
X-CSE-ConnectionGUID: 1rX3xvXVTHyxd2N7bYOKJg==
X-CSE-MsgGUID: zvgzea4oRlqjWZvn+Mm2vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="168267976"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 04:18:19 -0700
Date: Wed, 30 Jul 2025 14:18:28 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	linux-mtd@lists.infradead.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: MTD_INTEL_DG should depend on DRM_I915 or DRM_XE
Message-ID: <aIoNlFucSI18G0oX@black.igk.intel.com>
References: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f67ab8ee78f6bf2559131e193381aafff7479a.1753870424.git.geert+renesas@glider.be>

On Wed, Jul 30, 2025 at 12:21:49PM +0200, Geert Uytterhoeven wrote:
> Intel Discrete Graphics non-volatile memory is onlt present on intel

only

