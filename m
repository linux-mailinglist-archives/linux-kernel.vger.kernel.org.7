Return-Path: <linux-kernel+bounces-789895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D73B39C42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E845E0C30
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39A30F808;
	Thu, 28 Aug 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUNkTpJM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782930F93A;
	Thu, 28 Aug 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382880; cv=none; b=K5dM901WA/mpyAHnN4YDVAkAzWulSPEOSnhsxNnjpBCoxRIx/lxphE39l3Uf17Gwi0uI4uTwwDBJEHCp0Z6XrLQlSDavYekrLYiXNI//Su/w25CFKqCen/YYXh1m3UJ0eT8Guw/keyKg+VUaat+VxrzRFK43CfYmVJwp0/zATIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382880; c=relaxed/simple;
	bh=P73pzTNnb/d5RbN4Z7kQO9Z8mMnwUyg/hl4qnkBIfts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bMh+OYXe3ipdGTfeJGSaSLOqGLLr+v3Mjqbe0VAPbOHkxoarhfuCbXbXkaOcE/4td6BizE+sRd5tT5hNgsfQhvxzrfhqcQa9+99aZyNRBBihZSVUfO+NAqZ95f+kudrG9Enq/KDYIRLr1prmA14s40RNz9BEe2SIAjGnxJVMhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUNkTpJM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382879; x=1787918879;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=P73pzTNnb/d5RbN4Z7kQO9Z8mMnwUyg/hl4qnkBIfts=;
  b=gUNkTpJM7DWjTy+MLWUtB2MD40SyHG9/Fgx4kNWeI3z7GgdjH42GIFXy
   HoW8j7Q+f63UOudvV0tEsvp6MCis0sWIZMrJ6v/xqLwXqx0QwviXazRp7
   CEud1m1g3X6SrBPD4Cfa1TsOF/AR7PTbK+rKxr5KSeEni4ONwtqTwz/ZD
   hDRNPNe30hpSn3ZFVn66LHZJKcn26dWMBrw7L98oLpf0kqKyudRwSHVIQ
   SBuW4cxMhD25qH99Co0QKu3FWbRSB0aLS/JovDfh8QxJTajP5FWZYvnY0
   gxYFk5YXj+f/nTrI5qaslVx3Vrwml+c+TGJzoiTUYPEcA+VG1B+T+6Tuc
   g==;
X-CSE-ConnectionGUID: FWkgtE1zQW27VUU6cHrDWw==
X-CSE-MsgGUID: W012ru+fT06UbduESQLIQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61283501"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61283501"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:59 -0700
X-CSE-ConnectionGUID: dGWYL+3GR5qJVEelCC9Bqg==
X-CSE-MsgGUID: zjnd1nPqSG6nWBnTjiLlHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207245421"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250819211034.3776284-1-srinivas.pandruvada@linux.intel.com>
References: <20250819211034.3776284-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Fix warning in
 partitioned system
Message-Id: <175638287082.13908.17742989705177553671.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 15:07:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 19 Aug 2025 14:10:34 -0700, Srinivas Pandruvada wrote:

> A partitioned system configured with only one package and one compute
> die, warning will be generated for duplicate sysfs entry. This typically
> occurs during the platform bring-up phase.
> 
> Partitioned systems expose dies, equivalent to TPMI compute domains,
> through the CPUID. Each partitioned system must contains at least one
> compute die per partition, resulting in a minimum of two dies per
> package. Hence the function topology_max_dies_per_package() returns at
> least two, and the condition "topology_max_dies_per_package() > 1"
> prevents the creation of a root domain.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Fix warning in partitioned system
      commit: 6d47b4f08436cb682fb2644e6265a3897fd42a77

--
 i.


