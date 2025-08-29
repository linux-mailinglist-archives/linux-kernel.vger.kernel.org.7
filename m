Return-Path: <linux-kernel+bounces-791820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7CBB3BC53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B350E1CC2908
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AF731AF3D;
	Fri, 29 Aug 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH2Q9g2L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9231A54E;
	Fri, 29 Aug 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473380; cv=none; b=IOjL9lZCvpYVRaJVY3Z5bwmlC0En2qgYcG9FPe9Tzi/XOMKVr5lh2uSm9eRRr/xteZwicGGCx1U/F+YLEzQSwC8t2Kf2NLvP1HVtXocOzL3MKRBmtFQEkUgR2oOQDr4NpXtRQ+NhtxXgwMcbKJz/Gv2dsD/yIpbxqMNb81/KEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473380; c=relaxed/simple;
	bh=mi/r/zWXg2VY5k3/bDJn8Mqba7CluE0uWj9rxgILTt0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l55Z9DGgH2Hq7dEsOmR8K2o8JMNI44XqzpEsEmhKiKLVUcz/sJdrvwKwvnF3qZLnYPLO4GnBNhSp+Hb5n/7oVcNdkTsm7Dk5VAnLnjR0Q2gTDYfB7DJWX0FugGNWqp8Rve1vnsfBSI124ADJgeIwFOXYxtYdZd4cigvFA4Ei75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH2Q9g2L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473379; x=1788009379;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=mi/r/zWXg2VY5k3/bDJn8Mqba7CluE0uWj9rxgILTt0=;
  b=oH2Q9g2LcMdjspHtB7SrGz1AMUUsrY+EBE6FPRstjEEnoKR+Wcg04t2H
   w2mVS5bknWhXqRA5e0QuvVni1bnqCvs4H0VDRrq8w+7ibnlq7hzWvgp2m
   FDmHhItxtjYvKFUOUeEB0Qs0DkjJ6y/5pXzg3KqWWbJFw/41FTWjGeQLO
   ekqC6YnvOLcEX+hmBdg7IOsp28zbBtLUJaqkqbh8bczQv1oRa+rst0D+F
   XKrAbvYQfvNAg/nWhWnDasLy63vGKVe1Kc+/h5DB0Z0ZMD/XWVMNOAFN+
   NferxPCi+oIPWnFqJ1dw8vExgM3EN6h8PpWITMGB/UJcYeuFjLjY6+BhQ
   g==;
X-CSE-ConnectionGUID: 3qktW+KyQj+myaZNzfAV0Q==
X-CSE-MsgGUID: JMKvIEluTqObrWNnPv09AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62576541"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62576541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:16:18 -0700
X-CSE-ConnectionGUID: FptL1MKiRJiEgm9CZGbT3A==
X-CSE-MsgGUID: uqksS6teT4+pukDeAjjKZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="201292139"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:16:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, David Arcari <darcari@redhat.com>
Cc: Hans de Goede <hansg@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Tero Kristo <tero.kristo@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250829113859.1772827-1-darcari@redhat.com>
References: <20250826164331.1372856-1-darcari@redhat.com>
 <20250829113859.1772827-1-darcari@redhat.com>
Subject: Re: [PATCH v2] platform/x86/intel: power-domains: Use
 topology_logical_package_id() for package ID
Message-Id: <175647336910.2355.7252266115641924133.b4-ty@linux.intel.com>
Date: Fri, 29 Aug 2025 16:16:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 29 Aug 2025 07:38:59 -0400, David Arcari wrote:

> Currently, tpmi_get_logical_id() calls topology_physical_package_id()
> to set the pkg_id of the info structure. Since some VM hosts assign non
> contiguous package IDs, topology_physical_package_id() can return a
> larger value than topology_max_packages(). This will result in an
> invalid reference into tpmi_power_domain_mask[] as that is allocatead
> based on topology_max_packages() as the maximum package ID.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel: power-domains: Use topology_logical_package_id() for package ID
      commit: aa28991fd5dc4c01a40caab2bd9af8c5e06f9899

--
 i.


