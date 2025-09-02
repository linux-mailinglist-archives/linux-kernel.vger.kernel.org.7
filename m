Return-Path: <linux-kernel+bounces-796108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEECB3FC07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D592D3BC531
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062927EFE3;
	Tue,  2 Sep 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1fUFz7H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90116F265
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808310; cv=none; b=IFZN+Ye0qk+8mtHIi3c2hcDlHXS3HFj1ZJ1B963BB+WxoGjileecA2al/KX3zypSYRcbczfiJF5KJajh+eqzwJImXgCLPZMcR3nINuv82eSKIRCF9BsHwsZWjhF1FEmwuSyHtTKU+z5opCHlI2/P8eCIyTLLWiBmIkQ3H5TPiPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808310; c=relaxed/simple;
	bh=3QCI5tGjqvaAI5ML9Q0DYkiUhN1cD4vJ+o/YMVotpxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Hcj22dsdiY75cJ1ZjprqCslM9rQY/3L7kEFYYkCJFpeDPvqU8aZIPIYe4X+sJqQ8LzchdiXnqFDpRHmlp3wcYOFMwIck3zBHaLOJK6RJSRGQrQAeH3jSqBrQQYNNVlmONh3KzkCEMcTPeQT6IJMqRBmlCX2LsJxDiwKSVjoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1fUFz7H; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756808310; x=1788344310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3QCI5tGjqvaAI5ML9Q0DYkiUhN1cD4vJ+o/YMVotpxM=;
  b=T1fUFz7HS51bsaBykMHCMgHylhRAa0LUadREsozVHQs7c2vAnyZUGMaI
   pkHpTywSy5jV/rqEwrtpORZ9AneUOwq6zj8R6VBoEjl9UWv1zQYdzVC1j
   mbmQvTr83EXhIrf1lYpTAEA2rEPQFZqyJ1dKTRUXX+jvUJ0HigCXFQqDR
   5zo5f2gN2IJTLNhYVDIjbYITwowMNbb8yBz4ejiEVHwSy7N+7V7dRVBk2
   sBvXT0SUzKJSBpIEzm16KT4B2VXrlp2UUrduD5xgZ96FlOVNxbmVvE/z/
   Fy5hMjx5RL5nVzQYka4NTzLgzdjilUCzhvu/2Cc06Rn19zFo1Rpmp4B78
   w==;
X-CSE-ConnectionGUID: HE8LVPCKSYCws3RGaIaysw==
X-CSE-MsgGUID: uKoJJGYARzS1PmazeLVNyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62904817"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62904817"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:18:29 -0700
X-CSE-ConnectionGUID: umvimwuvTw2dej7SgTR00A==
X-CSE-MsgGUID: MhoMojHnTzqgt5EMi6mLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="208432209"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:18:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utO5o-0000000AfH1-3E7S;
	Tue, 02 Sep 2025 13:18:24 +0300
Date: Tue, 2 Sep 2025 13:18:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] auxdisplay: linedisp: support attribute attachment
 to auxdisplay devices
Message-ID: <aLbEcN44RT58ywzq@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <20250901020033.60196-5-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901020033.60196-5-jefflessard3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:00:28PM -0400, Jean-François Lessard wrote:
> Enable linedisp library integration into existing kernel devices (like LED
> class) to provide a uniform 7-segment userspace API without creating
> separate child devices, meeting the consistent interface while maintaining
> coherent device hierarchies.
> 
> This allows uniform 7-segment API across all drivers while solving device
> proliferation and fragmented userspace interfaces.
> 
> The provided attributes appear in two locations depending on usage:

You wanted to say "...in one of the two possible..."?
Otherwise it looks like undesired side effect of the change.

>   1. On linedisp.N child devices (legacy linedisp_register())
>   2. On the parent auxdisplay device (new linedisp_attach())
> Functionality is identical in both modes.
> 
> Existing consumers of linedisp_register() are unaffected. The new API
> enables drivers like TM16XX to integrate 7-segment display functionality
> seamlessly within their LED class device hierarchy.

...

> +struct linedisp_attachment {
> +	struct list_head list;
> +	struct device *device;
> +	struct linedisp *linedisp;

> +	bool owns_device;  /* true for child device mode, false for attached mode */

I would rename this to 

	bool attached; // with inverted logic

or
	bool mode; // with "default" (false) mode to be actually legacy one

(so in both cases I think we want false for the legacy mode).

> +};

...

> +static DEFINE_SPINLOCK(linedisp_attachments_lock);

Why spin lock and not mutex?

...

> +/**
> + * linedisp_attach - attach a character line display
> + * @linedisp: pointer to character line display structure
> + * @dev: pointer of the device to attach to
> + * @num_chars: the number of characters that can be displayed
> + * @ops: character line display operations
> + *

Can you add a description here, please? Important note that it should be freed
by the respective API afterwards.

> + * Return: zero on success, else a negative error code.
> + */

...

> +	/* add attribute groups to target device */
> +	err = device_add_groups(dev, linedisp_groups);
> +	if (err)
> +		goto out_del_attach;
> +
> +	/* display a default message */
> +	err = linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
> +	if (err)
> +		goto out_rem_groups;

Can this be racy with user space? Once we publish attributes, the new
message can be already issued and here it puts another message.
OTOH this is done before device_add(), so the attributes are not visible
until the device is added.

...

> +void linedisp_detach(struct device *dev)
> +{

> +	struct linedisp *linedisp = delete_attachment(dev, false);
> +
> +	if (!linedisp)
> +		return;

Please, rewrite as

	struct linedisp *linedisp;

	linedisp = delete_attachment(dev, false);
	if (!linedisp)
		return;

> +	timer_delete_sync(&linedisp->timer);
> +
> +	device_remove_groups(dev, linedisp_groups);
> +
> +	kfree(linedisp->map);
> +	kfree(linedisp->message);
> +	kfree(linedisp->buf);
> +}

-- 
With Best Regards,
Andy Shevchenko



