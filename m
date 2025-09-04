Return-Path: <linux-kernel+bounces-800861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4DB43D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD85F3AA742
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1033081B3;
	Thu,  4 Sep 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y62QX9sv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36D8302776;
	Thu,  4 Sep 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992206; cv=none; b=rAavwMzj2cHOFuGsma1AYiRN/e1fj8qEoo/tcea5Dj2Mb4CSNm7H3GbMxdAO2XqT0R2MBKyYpN96j3W8UZVyWlXpFMbYiRxIVxRMu38v5JLUt1E/m1imSLzPvTDhKphliaCioVpYiQujfAG4fYiNt6bqY5KIoEk7LMwRgsvKMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992206; c=relaxed/simple;
	bh=35jXZ50t2frDr2cMa40SQAj/vWigai9QC3gwft6sIno=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ijswhv2id7jwylOZ7Kq7acq0eWY5xpxQEQ2zqvJblrDq+M2hvq9f1iwBd4R0YVuvQqQn++yU7DkXl20KehZA1dLBroRc23A1X2O0eOZb6Q50BgD4LxX8DCJYXdAz7y1RpFPALqNVxQ51uZsQJvFlfURPgPCdfLLesZPQzVpRgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y62QX9sv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756992205; x=1788528205;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=35jXZ50t2frDr2cMa40SQAj/vWigai9QC3gwft6sIno=;
  b=Y62QX9svP61e9K/qT9WGMPwi1WnPz1Od8iTq31EJoXQ5CdOHmaykQXAk
   xCNZdbAHxFWMppdFts1dIeI8ohJhHcxgy/9TtmSk2Hw2s8w+qV3PvTC0o
   AmQUmFuXoB1qmIlyNCMP2JcCSxAYIMg1IKdCfVkQvD12KIqO6NXKCFMh7
   hLoHTBxGiVX23LgtSSNhpfQug25pi+rNZUIfTV6EOTf0O7Q18tUU+1HrF
   e82bstbMHsoryS6anTV1zwV/QLYbt0scLf+VSPTUxyHiWoKlrWZEkUKwi
   lZqJqhYqQNdpVMS9TsBzFt8c1w9dCg0B02cezifY/VyqhKO2oAMg9dWRm
   w==;
X-CSE-ConnectionGUID: hWObtNc3QzuqQPN9KUqX1A==
X-CSE-MsgGUID: rK9oFXm4RUGE/GLamb0o2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59396756"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59396756"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:25 -0700
X-CSE-ConnectionGUID: MUZpg03ZSDWi5Zlwz4xLqQ==
X-CSE-MsgGUID: IF31AUUkRkS/8dajs1u0+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="202819433"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:23:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250828122649.39574-1-liaoyuanhong@vivo.com>
References: <20250828122649.39574-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] platform/x86/amd/pmf: Remove redundant ternary
 operators
Message-Id: <175699219833.16699.17061443584274137529.b4-ty@linux.intel.com>
Date: Thu, 04 Sep 2025 16:23:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 28 Aug 2025 20:26:48 +0800, Liao Yuanhong wrote:

> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmf: Remove redundant ternary operators
      commit: f490253809c8dab4af62e787f5a3ac3d22aa869c

--
 i.


