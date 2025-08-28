Return-Path: <linux-kernel+bounces-789897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CFCB39C48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B20687981
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1D30F7EA;
	Thu, 28 Aug 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcJacZD2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DC30F959;
	Thu, 28 Aug 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382887; cv=none; b=DzoK16LimNpEn+Vba2D7GzT+OO/psteAb/XxxlPDMBfgwYGAHsnuqdFdJsYK3/Ke5FqnQeDAQF3ZLaaHKbAQt5Peftu4CTm47gbFnNQURX1hU1e9RzZkrePY3h8VIoTrly2s1OOBK8yV7OgS6np+bi66FSvtOAqrUMIXnbhu278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382887; c=relaxed/simple;
	bh=fGu7UiqbNorOhv8zDirn9Y3nlFS1+FY8EBnaTT0MIJE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AkVxnzWJuVMlFSqYZ7Oi4P2cotdrzl6CI87UhPh5dCEStkh5GmGzxndCogAZsQeNvsyapaA/qhoxUENBF7/U/PwEHe7lCBcXDQh8StOzzuqRYpE0HTcf9R2BW1eAv/Pk2bnI7X33wpF2AbJt7YfMUeKSrpSmylrDG52WK5RnXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcJacZD2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382886; x=1787918886;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=fGu7UiqbNorOhv8zDirn9Y3nlFS1+FY8EBnaTT0MIJE=;
  b=AcJacZD2v34sPtf+rH/955QuiS1gy/rfm4ixdsSQuEgo/zM8acy6jy3J
   gs32uoEJq+omSc+wqEnZ92niV3eN3eJGCAzM3VvZHd1f9YAKyrfIrjLAo
   /1oq/zWilJ2nQYPyta4v2ohmIUirOwhUtPGiDE97vidXTx8ZwLrwuIdte
   GAp03ipNmx5O0r9SehqdijzFw3Y6QcxnFpcYG0uG73nTzsi3KvuwWx0Ck
   RJ9kzwyl08o+wg0oijux+9Yt1DGMzUBBP/vFHTI9QCRd23rWKDzPDYOga
   fEjhebnJgRW+fKy8fMBWYWkc9YHJM7/BNxjzK9jDC7TMlKDwIq9BSmp9K
   g==;
X-CSE-ConnectionGUID: ngFEoFpWRDCmY1rXPbs0IQ==
X-CSE-MsgGUID: +rzwPn+oSRaVlwRxEeaZ+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58749731"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58749731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:08:06 -0700
X-CSE-ConnectionGUID: 4KNUiPnrRcudC5/EIZ4MuA==
X-CSE-MsgGUID: MfSGpmeRRs+OrrmYPKLwJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175375435"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:08:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
 David E Box <david.e.box@intel.com>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250819135155.338380-1-rongqianfeng@vivo.com>
References: <20250819135155.338380-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: use kcalloc() instead of
 kzalloc()
Message-Id: <175638287905.13908.5051712719471737806.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 15:07:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 19 Aug 2025 21:51:55 +0800, Qianfeng Rong wrote:

> Replace devm_kzalloc() with devm_kcalloc() in pmc_core_get_tgl_lpm_reqs().
> As noted in the kernel documentation [1], open-coded multiplication in
> allocator arguments is discouraged because it can lead to integer
> overflow.
> 
> Using devm_kcalloc() provides built-in overflow protection, making the
> memory allocation safer when calculating the allocation size compared
> to explicit multiplication.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmc: use kcalloc() instead of kzalloc()
      commit: 55df384148396c0503cfc51a9c7177df6a423843

--
 i.


