Return-Path: <linux-kernel+bounces-647006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6C3AB636A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9388917CBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 06:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C35227;
	Wed, 14 May 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5l9N07Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834FB20297D
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747205043; cv=none; b=Y9EnfSxi8vUuVae8L0cQA8gDXX56r/fOJP/7qcAm8eSQgUfmFB3ojxLcgocYcxCrulDr+LrwfdmmDQtoDf+IHabYXrHnbWZse0bfmsmUNV33HgIn3KTnRY5nhR1lSB1DKego7sg+tCA1xiUepKxejitlatmmi/Zj8ZPQ4LzI4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747205043; c=relaxed/simple;
	bh=w/ck8FP/0peMslKPAAUo4+aaobGgd/LaJyMrWDxryIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELtj8YNy9WgAdoOoEuaWPZoNsIA9NHXuDdvmwRtOg7bVxC/lA2Iky8UfUeRX+0MKO6RT4z7sjPSoyHX1QZHagaVCLBbuApyAedhl8lOpFvQUpuYhZLMI2Y6d6vB9OEK7K7nz1hiclPliGrvGISZuk+k3Uc5WJywJxKVX34qGaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5l9N07Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747205042; x=1778741042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/ck8FP/0peMslKPAAUo4+aaobGgd/LaJyMrWDxryIA=;
  b=J5l9N07Zg5nf2W7sf99y0ovRozqt5wgeMCGQOiSZaFIQV6anj3OfJMAA
   /W739NSeeKVEQBtiBq0LdPbhzwo+wknK3saZ6JDY/UyaL3Q/NzN19iipG
   Lp2+jMicgBTJFuBRmCdV0uZ5Ak1wpvjIsFOjasTdzVsnz3q0RE91XRssr
   mdLxLLxtSJVtgYjOZmwwOn8vRaE0/RpiPyMBx3xxtKVZ0BSYsK+PRg/bM
   ksQciBY+lBv2cxhyfKaZh4lQDseQ3SSuc44CF745h02tzEpyEZiB5x1Ri
   LB/nnwGuNQkXhlvuiep7TwLqVe8VOAu0xv7YmIjgzTNQ+C3sVvcjxsPGa
   w==;
X-CSE-ConnectionGUID: aRmXgfQKQ+qGqLlyFKGcIg==
X-CSE-MsgGUID: 1KJKTLtSSYCelqdFA7JltA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="71584985"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="71584985"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:44:01 -0700
X-CSE-ConnectionGUID: AJgXBp2CRzuRmYuGHsVlqw==
X-CSE-MsgGUID: pWI0IcR+QDKEXnsMe19efQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="169044659"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:43:59 -0700
Message-ID: <18db51b6-5685-40bf-bf8b-1e787834fdf5@linux.intel.com>
Date: Wed, 14 May 2025 14:39:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iommu/vt-d: Restore WO permissions on second-level
 paging entries
To: Aditya Garg <gargaditya08@live.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <PN3PR01MB9597D59895582119A2F56928B891A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <PN3PR01MB9597D59895582119A2F56928B891A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/25 13:52, Aditya Garg wrote:
> Hi
> 
> Since the original patch which this patch aims to revert fixed CVE-2021-47035, I'd
> like to know how is that managed now.

Modern IOMMU hardware supports multiple formats of page tables. Some of
them support write-only permission, but others do not due to
compatibility with the CPU page table. That's the reason why the
previous commit removed write-only permission to make it consistent.

Nowadays, we have renewed iommu domain allocation interface which takes
a device pointer and allocation flags. So, if the upper layers, for
example, VFIO or IOMMUFD, want the iommu driver to enforce write-only
protection, they should add an allocation flag for this explicitly.
Otherwise, the IOMMU driver will treat DMA_FROM_DEVICE as a hint, not an
enforcement.

Thanks,
baolu

