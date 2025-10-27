Return-Path: <linux-kernel+bounces-871236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E23C0CAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 631F034C33C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9792E9EB2;
	Mon, 27 Oct 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0Ai/bIj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DA24EAB1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557739; cv=none; b=ZUpq+QWf2KHfMByjh4E7o7tFoDAqU/7oV8K80uN2IclBaGbMkaynXnLXLaiTfcFhF15iP4oywGjeJLYTxOHUgLSFUuZjcCm6NnhWbI6LJCi1VHFpCqSAiT/Ufcn45gaet/fpUmV0ctLwxc03LlVC19oA+X2477gQNtMPqfHkr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557739; c=relaxed/simple;
	bh=kvh9yvDC6N4rX0GbG2Y9InaT0bqEJa5Xe3f9dfBnp+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn0t+zi8k3QfGpHQ4isE9ugmXuJ5EJh35/okbi3ad6BhlSs5UjLlrEJhgYTK2c1g42SdAWCf7T1/bo8ToakuhvZndmpkCUbhdpA4L1Ana/DSXdrMUxRqRNbHo6FSRgVsbYwWFHrcnjPiHRG05XXtVI0GeWj6czHeD1LUJTvgupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0Ai/bIj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761557738; x=1793093738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kvh9yvDC6N4rX0GbG2Y9InaT0bqEJa5Xe3f9dfBnp+Y=;
  b=D0Ai/bIjFfgJpk21PfVyNoGWV919A0iXq2vRwlHwidhxVTkOtDibEwRq
   7RZxnbqzLDTdPpX0pAHrUY8rCYL0sPTdhS2k6th+0EH+/6GbFfMtBjVrW
   +XyLapDPKeF9JWVHOT/nnfDrIRe81zMWK1nteNnDEt4z9nhzqOuwnhZox
   Wd6pLL2AZE8EIWnfeefVLPxVVrbd97kRugREfDcPfPReZ9qJeJIGpwsPP
   Z7bUYLA9GL8KXHYAEUmIwZnx212JjUOz2WgVB3pGuN2Ktef+c2yr9p/TL
   uSqGGhevRcLcwW8ByLsgt9IUow2qywmzNwqH+sgNf7i4INHptfN7D3YTh
   w==;
X-CSE-ConnectionGUID: HBjMS9eVRr2x9ehLS5/Zcw==
X-CSE-MsgGUID: p0OuzZA6RQS6ca/6ASJSBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66247618"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66247618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:35:37 -0700
X-CSE-ConnectionGUID: ePaDMegjQOi5ILua/Et3bA==
X-CSE-MsgGUID: BKVYYjPZSnqDSS8peu28Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185349016"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:35:36 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDJdV-00000002xwJ-1wrd;
	Mon, 27 Oct 2025 11:35:33 +0200
Date: Mon, 27 Oct 2025 11:35:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: Re: [PATCH v2 1/1] checkpatch: Don't warn on "orhapned" DT schema
 file
Message-ID: <aP885cVvKxE5xMBW@smile.fi.intel.com>
References: <20251027091742.1741742-1-andriy.shevchenko@linux.intel.com>
 <7730d4bd-0d7a-452c-ae95-a472d8c99de5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7730d4bd-0d7a-452c-ae95-a472d8c99de5@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 10:25:58AM +0100, Krzysztof Kozlowski wrote:
> On 27/10/2025 10:17, Andy Shevchenko wrote:
> > Currently checkpatch warns is the DT schema file is absent in MAINTAINERS.
> > However the DT schema files are self-contained in this sense and
> > have embedded information about maintainers of it. This is a requirement.
> > Hence, avoid checkpatch warning about it.
> > 
> > Requested-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> No, that's not true.
> 
> First, there is no such tag.

No, that's not true.

$ git log --oneline --grep ^Requested-by: | wc -l
357

> Second, I never requested it.
> 
> NAK

Fair enough, I'll drop the tag.

-- 
With Best Regards,
Andy Shevchenko



