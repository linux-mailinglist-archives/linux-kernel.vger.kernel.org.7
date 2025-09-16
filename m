Return-Path: <linux-kernel+bounces-818803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD164B596A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CB81BC7F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E2F21CA00;
	Tue, 16 Sep 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyUYy6uI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB419CC0C;
	Tue, 16 Sep 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027162; cv=none; b=p28a8lc51J7t83Ro4NfCGk5lUclC5HRfQ9e7xQ6JMUxhXNPKN7rXJ21YkViKU0rxrzwTIAiGh5U+9ZI6dk8HhxfMsgAA29PEGdz79dvCOLZFXPJmXzD43IDXPSKKi4JvKr35XCs+CP34/KWQ2Y9o9BMnXx2tGCAfciAvYwgfBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027162; c=relaxed/simple;
	bh=vqbcR4wQ63DtZzR+CDAvsZNxuJHNWzFyGJDUfom1VsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phEOVWXx2vp1aJowaFJvd/IVBA+tTZDuAi98QCnA++oT8rBYAFfOmpu5IaxfMMByj1FoF3LUlf35336DdLEUWhK5uUD8l58DDG/7GvbK+YGQIAJxCJjYD/9Pyk4+cfTJzQPOnL1cMMknzQ1xsFDq7tv/3v7yJETgssMIM1NIU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyUYy6uI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758027161; x=1789563161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vqbcR4wQ63DtZzR+CDAvsZNxuJHNWzFyGJDUfom1VsE=;
  b=hyUYy6uIOLJ4qteFR8Tbiy4NFmy3h4qFqH9/+CZDra/T/N+B6RsoA4IR
   cnYqmDCd/rZQbfXzIS9gGtbElPtek7zeCxyF2+Gq0KO4v9Ba8HFpNP1IE
   sow+tpKia6kXXrocVCjX4WsDljZ0CtQSfwzR0/x6/lSn0twi8k0m5iEgg
   luJfC0cqmFGKMwe1RFOmG4WtD2Cl4PIAcu0YCUEkst9yCbYDExqsaQfL/
   0dZTdxqqd0QZ3wQgDuZhgT7C1omhUcPol0sRDSjyvn0tOGRhKbC7VkLZ6
   6XaL0ADMigJH97HBbwVxAOswokO0gxxPaogpqbTTA1C0BVgZVNX5lTnnJ
   g==;
X-CSE-ConnectionGUID: h344aNrjR1upjpdhwm0NYg==
X-CSE-MsgGUID: RajVFfxaQYqJfWF9RqFVjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="77912724"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="77912724"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:52:40 -0700
X-CSE-ConnectionGUID: FlH42tolSDK7p+p7Nwy0DQ==
X-CSE-MsgGUID: 2l2wNfolRPiO/m6G/AU6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174869473"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:52:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uyVAh-00000003Wqz-2jtE;
	Tue, 16 Sep 2025 15:52:35 +0300
Date: Tue, 16 Sep 2025 15:52:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1] clk: keystone: sci-clk: use devm_kmemdup_array()
Message-ID: <aMldk7M05W77rRw_@smile.fi.intel.com>
References: <20250916124518.2857524-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916124518.2857524-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 06:15:18PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



