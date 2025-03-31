Return-Path: <linux-kernel+bounces-582335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A7A76C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2114188DAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D684214815;
	Mon, 31 Mar 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W53wfwTd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1978F4F;
	Mon, 31 Mar 2025 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438984; cv=none; b=WEJcDy4jnL7/pYx9QM04Q1RFh/0XmlEFiiBBsIIELAhmJeAU6qdxJsGdGZOq8Y9XzTy5A96VQQuytOtaH/FTiBX0tXOGeL5L7hJs7WA0sM7kEoM7sqb4OdD5b3YDY/h0dv7lGX8Vz1D3Kb/LYCBBm39UcrYyn/5MlCycn90PXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438984; c=relaxed/simple;
	bh=CQvu9THSFTJVZsQPbF4NwMbzdwn2Ht5kDHjXq9KwwMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+cZCed9BSmHtKWmT31W63tkojSRbIDse8AZh1Zqq0UFniFCFDoFVFfJNC3asqcn6uHkrz5J9rYjG94bVcjPtZOYMax2hXipb+Jm+qKR2HFQBg3OCuQZQLFZclkMC3pNyPOXNRdINoA8KWcVMV13SWQuYckRMuwFpBvbu+KNWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W53wfwTd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743438983; x=1774974983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CQvu9THSFTJVZsQPbF4NwMbzdwn2Ht5kDHjXq9KwwMk=;
  b=W53wfwTdm0i6luzsCMMnloYz3WbyU82AKZMWRfet5nh1O8lDTi5LnaYe
   NsmtDoy+R5FeXK/sjweKrjNTkg/xyabxC++iEEqoYdFgNFdId/tLi1aWM
   JxCEYUUmth2lEXBk+EkOQKC04ONIohvu1zd0h4RbF+VuNUFbDUYCpBJY8
   2q4Q0qhfc6MbxUdbTnpoGnuo4lcf0zF/ua3ih6f9qjvgi/UPB47s1B4YA
   rH3KaT9zjhH3XjxYQjOtpfQYDPS/J2VB8UajW2Fca6UgXXFHQcs1bH7iZ
   cajBmKKZHqnVEuWfNVRl1R1Gjy6K6q7g3na3jussFeXIZSmAAsrgi7bxi
   Q==;
X-CSE-ConnectionGUID: EUl6qq6ARy6MSlLWmfSK1Q==
X-CSE-MsgGUID: oJoI53wJQ9i0iCLJM1tGwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="55392571"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="55392571"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:36:22 -0700
X-CSE-ConnectionGUID: rhm7ZPKlTa2IlUavWJ1/8w==
X-CSE-MsgGUID: DhbKubTZS4mCy61fzpj6KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="163370727"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 09:36:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tzI7U-00000007ryy-3XWs;
	Mon, 31 Mar 2025 19:36:16 +0300
Date: Mon, 31 Mar 2025 19:36:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v1 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z-rEgHkdkaIMj0dl@smile.fi.intel.com>
References: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331163227.280501-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 31, 2025 at 07:32:27PM +0300, Andy Shevchenko wrote:
> Add a note to the fwnode.h that the header should not be used
> directly in the leaf drivers, they all should use the higher
> level APIs and the respective headers.

I re-read it and it's ambiguous, I fixed this in v2 that has been just sent.

-- 
With Best Regards,
Andy Shevchenko



