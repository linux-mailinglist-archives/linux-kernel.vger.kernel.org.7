Return-Path: <linux-kernel+bounces-860575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0287BF071C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43153B3D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7B2F5A0B;
	Mon, 20 Oct 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuhJ8yDo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6D1D7E42
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954957; cv=none; b=k7XzP+16DUAJEBGmmmAQRZDQaEdKw37Yh+fW7INOLIOotRDdGJ9nRcaKiVbYhAedVqcdVfFuuI7mnYU/5fbs7GiKOO2sOjTCyz1oh5Blx5NwgPWxKinVIg3dmiAo+vurL5bsAIpxg+l/jAWiVvfb1FD5F8ojIeFmVTVvsXsQszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954957; c=relaxed/simple;
	bh=mgmagDXiBORp/cgzFDOu0tnOLlFPHt0s85Ud1RXqUp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k985xcDVeh2vqzKeXtGDZtAShs5wrAUCcHj9IZSNM5UCDYA/6mM/rYpx3k2KrGs2+8XYyGE+hOGeOuXt8P1kbU8VZzbORiAFMtt0IHKhaTt7c1P8JTeZcXNLpn+GfPsUkopTs1S8kDM5g6XUFLsByHMgqK/aGuPkTE4zXWGmLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuhJ8yDo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760954956; x=1792490956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mgmagDXiBORp/cgzFDOu0tnOLlFPHt0s85Ud1RXqUp8=;
  b=kuhJ8yDoqVry/gNV9h0JaJslmH4AlCzE6X0ybXbhXTq3qP8NwSHQkiOB
   Ec3PpQW/p4JAhmeE7i1/XaHCNfuF0jGGxSiVevaan4DULu+CyVgHzOYae
   dAksEvaqSoOfW/E0fAMnlNS4KJ/S6RCB/6GaUNg1Z1E7gDrD06/wHBBuJ
   bfsdRjWxGwirjHQVus42Zbt7KTpkVqjdxHrjU8IA+/7Pc/L84erq/9QHf
   UfQqh3FisUvzrPIWyhvUqewiN4nng1HtmS2LTfoaeg6YybYx+BRPYVRcO
   8fZ6gj8KD7EtXL2CY8cgHgt/Mpe6jOUyg2orB8ZfhPqmvXG9UXisqpKuK
   Q==;
X-CSE-ConnectionGUID: pcJnOHMsTryMaApiimL48Q==
X-CSE-MsgGUID: 3XIAYjoIT82cXXDYJC2J+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66932440"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="66932440"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:09:15 -0700
X-CSE-ConnectionGUID: LtULEggHSpKRmikGNFyx2w==
X-CSE-MsgGUID: m+WRnFkkTfGGevtdeoL6Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="184063321"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.6])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:09:13 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vAmpC-00000001GpQ-3tt7;
	Mon, 20 Oct 2025 13:09:10 +0300
Date: Mon, 20 Oct 2025 13:09:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Reuven Abliyev <reuven.abliyev@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH] mtd: intel-dg: wake card on operations
Message-ID: <aPYKRvCenwnrFXcb@ashevche-desk.local>
References: <20251019150145.3228079-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019150145.3228079-1-alexander.usyskin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 19, 2025 at 06:01:45PM +0300, Alexander Usyskin wrote:
> Enable runtime PM in mtd driver to notify parent graphics driver
> that whole card should be kept awake while nvm operations are
> performed through this driver.

...

> +	pm_runtime_mark_last_busy(nvm->dev);
> +	pm_runtime_put_autosuspend(nvm->dev);

Please, drop the second (duplicate) call.

...

> +	devm_pm_runtime_enable(device);

Please, justify why this code is good without error checking. Before doing that
think for a moment for the cases when devm_*() might be developed in the future
and return something interesting (if not yet).

...

>  err:
> +	pm_runtime_put(device);
> +err_norpm:
>  	kref_put(&nvm->refcnt, intel_dg_nvm_release);
>  	return ret;

Mixing devm with non-devm usually lead to hard to catch bugs in the error paths
/ remove stages with ordering of cleaning resources up.

-- 
With Best Regards,
Andy Shevchenko



