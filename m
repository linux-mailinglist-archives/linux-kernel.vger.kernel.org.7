Return-Path: <linux-kernel+bounces-886442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F5C35A07
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B229C4E60A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C8F314A62;
	Wed,  5 Nov 2025 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeWFwkYv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA543112C4;
	Wed,  5 Nov 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345453; cv=none; b=pTesb3BF+VQz8ekQwDWncjRJ2YKKDk17TaIf8azHbhNqmLIEh24Bp0CxbMYoO9UNQKE4O4PhPrKZQd8RWkzwUQufg68ZZzjxUjI++bTQDtxTI9cQ91R8HJoSltZjVdcxrddfDgb7LVXGkhkWwx6UsnjzpnUwrciOnewnB6H0KfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345453; c=relaxed/simple;
	bh=jhZUF2C2mEaJ4slv0fx4s3Gkp2SApKlhNbUWzlLu2N0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LaJlOBFcvIu3f4ZfnUsF0OkzntpESBHKg9XkbZiatwELagQu4YziK/wMNE1P5EUv63d0BKWhwaNdOtQa7cCOKHxP6V/M2Wx/K0DhgDUUGZFojcSa68d4nsUMASIovjieCuqLih5YhXxm/TNypw17vnkPUo1b7RJfk04IJ38LeS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeWFwkYv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345452; x=1793881452;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jhZUF2C2mEaJ4slv0fx4s3Gkp2SApKlhNbUWzlLu2N0=;
  b=GeWFwkYvq8B0Q6ifsKqMf9oOWss/Rgfs+3EUeyHI407SSH9k8LRbT+xh
   d9ReooJE4zq/DSwA84r5Jhku/+HFpK06kDPL9aYHhsZSQPGLP6He1SkRs
   V9fCOy5c9T4amNVhDYtVmZuN4xowWCV/610E8E5POT6K5Eo6hwlUDqMI8
   +8TNLVF0YRsXXjgKYS0oPqyfnBSHQj8CAN7zu8A3fU6avVGWYSlXBNDhs
   vwLbVpbXrRbF+bxUT/L2mSTGkAoL6fUPqjeaIhSGxZTJh4Bk0sShtRbWR
   M+DyYQHuSrErI+ruPDTK/ATd3Fc7nahuHTpVJZnX/ssv9d5CV1Q6nDp0J
   Q==;
X-CSE-ConnectionGUID: DZOsCtTWQ4uOYr8WD43itA==
X-CSE-MsgGUID: PdKfFM5mT1a3d587QvGzbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63663147"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="63663147"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:11 -0800
X-CSE-ConnectionGUID: R5A0Lh7XSOCcUPTIdfbnsA==
X-CSE-MsgGUID: N1tt5WCiTrSj9PC7+DHEMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187603220"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251022211733.3565526-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20251022211733.3565526-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v1] platform/x86: intel-uncore-freq: Add additional
 client processors
Message-Id: <176234544289.15175.17820312439917939860.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:24:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 22 Oct 2025 14:17:33 -0700, Kuppuswamy Sathyanarayanan wrote:

> Add Intel uncore frequency driver support for Pantherlake, Wildcatlake
> and Novalake processors.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: intel-uncore-freq: Add additional client processors
      commit: 27dbf901f7301071f20817b57b10d4dd391dfe91

--
 i.


