Return-Path: <linux-kernel+bounces-885218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE12C3245D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063953AA10C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268733B6F1;
	Tue,  4 Nov 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c23TkH3x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19433B6E3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276300; cv=none; b=a67KK5OBAIKfq61CzDl2uE1VlFL6ThEAzl9QPTVYoQKvsZbCBDL4d1dwF+JbHpi7h9Ftar737rCnwlWqPlM9dF92Edu54Sf+/h+60KoXJoXE2F7jfwTH0j5EznFShH3GbIK4Jge/ogDIENKAnU5RytUKu9qVxO13c64O7t2Ms30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276300; c=relaxed/simple;
	bh=l66L8qBe+Tdr24KTy0VRX3lpLVTd4YmRSr8tLx2/SxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iryXsdD+LmlKFfnTRXNWQz2eBwkpjef/+l6WnJ5USL59bdM5cN4SE9tFNScApFdGlHuqqP1CTitCFjB5aqaAJEboJiTnZpbeORZNTyzGS4hOpgH57HreLbgF3I9xMtd8W/aDUM9YURRNNBAHtJb6FeUBfjwLN7sycNSNLC6uOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c23TkH3x; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276298; x=1793812298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l66L8qBe+Tdr24KTy0VRX3lpLVTd4YmRSr8tLx2/SxU=;
  b=c23TkH3x703YUdro8hURv+/JVHSboyvE7dWoDITQnD5vg+wRBpuipbJ2
   R/cTnzPKULsDWLWEtJRVQ4y3CcBWNLP2M8hWGdQi+Jeo916VrRy4pDKJN
   8dL+XLdnCSMM7sia1tRWMkagr34pSPHTA6o2vFhZAT/5ZRrrBEAQdTpFz
   d0uOmbQOonBaab6lBRk0oU+3+I//XSJAzuEnpPFF3/zjGBgcNtWr13KEX
   KxQoCq4g3QAKvxDKkOx9IuuNCRLQ//zOjyM6HSPbEWLtNSGurO0owXPWQ
   n86V8LfMoDEEQ+bRrgsAN06fNNE40I5a5lLdIKh4vSuGS1mJHS/kkx36y
   A==;
X-CSE-ConnectionGUID: Q5QJJNGVQVW3gDfbbTkFNQ==
X-CSE-MsgGUID: yJCleNLiRcS+5BrrSw0mcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75058514"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75058514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:11:38 -0800
X-CSE-ConnectionGUID: zgowIiKlTp+K3GvWlJRf1w==
X-CSE-MsgGUID: tqI676p/RJaN4s2o52nLAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="224462167"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:11:37 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGKZC-00000005WU4-1Vxa;
	Tue, 04 Nov 2025 19:11:34 +0200
Date: Tue, 4 Nov 2025 19:11:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQozxqDFtAhDpBQB@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
 <aQonVNgqJI56nspA@smile.fi.intel.com>
 <aQoqPqVeQiHJ2tiF@finisterre.sirena.org.uk>
 <aQov22j_S8LRzIdm@smile.fi.intel.com>
 <aQoyT4Com8t6zE5U@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQoyT4Com8t6zE5U@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 05:05:19PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2025 at 06:54:51PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 04, 2025 at 04:30:54PM +0000, Mark Brown wrote:
> 
> > > That is the full list of commits in the for-6.19 that do not already
> > > appear in mainline.
> 
> > Yes, because this merge brings also rc3-rc4 bump:
> 
> Yes, it does.

Thanks for patience and helping me to understand this. So, if it's all
expected, I have no problem with :-)

-- 
With Best Regards,
Andy Shevchenko



