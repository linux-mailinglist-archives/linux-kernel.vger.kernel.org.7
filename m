Return-Path: <linux-kernel+bounces-793864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332BB3D973
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DA37A5966
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5F22156A;
	Mon,  1 Sep 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bip7KmZv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5071C84A2;
	Mon,  1 Sep 2025 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706717; cv=none; b=NS8GUJSo6Td4WX7jpOaq2mRB9Bwf8azD6nIpfHiHIVOdV34NjujS9eyN7hrqSbUkyn5ZSZ07oT67aqgVljsum5Z0tFfVfss0J9YXOZMBob5om1l2VYDHRZXXZPtNI+t5hialdVnRsuaVpuQ07crkJg7zvCV2Sf4JvGH42bFPxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706717; c=relaxed/simple;
	bh=CEKN/UJ6w/FhlgeUtzc5km+IHx5Quu8hJSId0IelxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQxI5MePoCOE7q7qTS5rlTiLrQt1yWl+gFIXdf7OQaq48ZA17rYrtjP4g/LbZdLLeknHg1Bdz93kWhvYT9bp7Jt8i+ij6J59R46qG6TSf0vBWCiSjilj31DvSwTBNltWXINbp8TcRz8uvrWuf26ybIDj5B+hqWlM7LZS2ImlVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bip7KmZv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756706716; x=1788242716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEKN/UJ6w/FhlgeUtzc5km+IHx5Quu8hJSId0IelxJw=;
  b=bip7KmZvck3sZ5IR7Jr+q1SsQMiU/0Ioq8qB4sbsucf9n9VEWgkB6jCC
   VBZTNiP+ESMvTo6yIwxahDth6UBxldS8IsrYCZgWViTf4mpMESvf6Krf9
   j+GM4jag0M0YvtYjBBLYIeeQexRWZ5zJUZhDr9+srQGvT09sH9HLi0oz6
   UtsKz8u7SQvEe/q6TVQ5DxBKP/I5WwYXOMOM77Xn8o/gLa1RamfnS51jQ
   yEs5N8bR1zupVjjo7a21LLsAb2/m9p3kC8C3jWMSoZmZOAvrIC1xu0Xap
   ufWicWroKbKNyzjVWJy/ucW+VVnDb5xlSkSapSdW8hKuYyd0PNw7VikI7
   A==;
X-CSE-ConnectionGUID: kvcRTxtORlaWjdLVLX1z2A==
X-CSE-MsgGUID: tXKCdGSTRLedURte32zxJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="46467639"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="46467639"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:05:15 -0700
X-CSE-ConnectionGUID: uQT3SGlQT96TOebk0hBydg==
X-CSE-MsgGUID: D7Y2JAhkQpm4XOv2Sz5tjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175231763"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 23:05:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1usxfC-0000000AGtL-0HQM;
	Mon, 01 Sep 2025 09:05:10 +0300
Date: Mon, 1 Sep 2025 09:05:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: axboe@kernel.dk, phasta@kernel.org, broonie@kernel.org,
	lizetao1@huawei.com, viro@zeniv.linux.org.uk,
	fourier.thomas@gmail.com, anuj20.g@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: mtip32xx: Remove excess code in mtip_pci_probe
Message-ID: <aLU3lYKDdw2VnY54@smile.fi.intel.com>
References: <20250827131228.2826678-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827131228.2826678-1-zhangheng@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 27, 2025 at 09:12:27PM +0800, Zhang Heng wrote:
> In the error exit function of the iomap_err in mtip_pci_probe,
> pci_set_drvdata(pdev, NULL) and return can be removed without
> affecting the code execution

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



