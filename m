Return-Path: <linux-kernel+bounces-800860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A406B43D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C018823D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746A1307AC4;
	Thu,  4 Sep 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTBLqfCR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB7302CD0;
	Thu,  4 Sep 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992199; cv=none; b=HKmYvz1xjmpYCiYbe1kEKIkI+g6tqIEX93aqxAwtDdIPZMSaMHt3hpPPwkb8P0Rbkupq5LIV7mt+ZPQ0RZPT1hmMLqWvnMsseicMFGy6SzAESuSvVuTEofhSRGXKpRUm9txylOnuYdahjwN2DwrsKFHzz1zXGLRSF6spWWWbKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992199; c=relaxed/simple;
	bh=gp5BQdU5E4IxOJbSnohCl9WqP3FNPHp7l4+/kSp2YSU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GuF0zPqddKCRJmgMgoAGCLKd01Y5l/TKeSZtVS9eQgMuf+K+ZEqt36gJefhIMQECSE7JCq20CfpBMsGn8BtyPA87sM9x6QGJlWaf3c3YGJOJKCZEIe4K8jp8OC/e1fNYljhJBjVBka0wUh5qIVp/de2NcVx113R59KzgWbHVZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTBLqfCR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756992198; x=1788528198;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=gp5BQdU5E4IxOJbSnohCl9WqP3FNPHp7l4+/kSp2YSU=;
  b=QTBLqfCR6++ItGzykVC2BtZroeU0BAZV0aqbGLuVg85o6GEDzUjW4IxX
   Gbx/mPN8m6PT2uwmtykVrCSAuW0tpPPsDYGGaNVClbfMQeDxe5HcLB7Mf
   IYC2W/FlSgYnVSABpiQ38LrbBCqw8ufc9TF9ZQeuMiwbOcmOt9j13drUn
   JWWwBnJm6cuige2VGKwZRH+kVJfAQuS4eGKJoF2CLjplRs2W9sZIiAML4
   3680XB4nnawB8ocuNg3NpSZ0aGebut7lMg1qW9VSV0evppv5b8lGho4vv
   PFdLcnlExtQDZmWZrFZwtiH5lvNDX9auopOWhU7cd4l0fDu8/44H1pLqC
   g==;
X-CSE-ConnectionGUID: aDdqlzHrSnSW/tHvGD/A8g==
X-CSE-MsgGUID: Mo4RKtrUR16K7+6Q+cqR/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59396744"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59396744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:18 -0700
X-CSE-ConnectionGUID: ANmzp+zQTIGqk96+jS1+eQ==
X-CSE-MsgGUID: vfu90dkxQpKI2OhEOJPprQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202819424"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250903191154.1081159-1-srinivas.pandruvada@linux.intel.com>
References: <20250903191154.1081159-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3] platform/x86/intel-uncore-freq: Present unique
 domain ID per package
Message-Id: <175699219237.16699.8335932347474908854.b4-ty@linux.intel.com>
Date: Thu, 04 Sep 2025 16:23:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 03 Sep 2025 12:11:54 -0700, Srinivas Pandruvada wrote:

> In partitioned systems, the domain ID is unique in the partition and a
> package can have multiple partitions.
> 
> Some user-space tools, such as turbostat, assume the domain ID is unique
> per package. These tools map CPU power domains, which are unique to a
> package. However, this approach does not work in partitioned systems.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Present unique domain ID per package
      commit: a191224186ec16a4cb1775b2a647ea91f5c139e1

--
 i.


