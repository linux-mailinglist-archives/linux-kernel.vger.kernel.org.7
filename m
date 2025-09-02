Return-Path: <linux-kernel+bounces-796085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F79B3FBB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF8D18883E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E962F532C;
	Tue,  2 Sep 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9fj0Aew"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5CF2F530E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807386; cv=none; b=VcGp22PE8tPJ72978gymDRetc07tjgp2XifPHa5rBbzPGko/niC+3TevnTLJpqNcvt2Kzlg0tO8eM7oHJnB+xBfcpsTIsJ8G3U+uXy9rJz/ik5eU2hI+OVpLbmAjy4MTDD3ijEeaG/wo9o4jNiwx9dXF1XUSVHoOdRGGLeWKEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807386; c=relaxed/simple;
	bh=A+NdCy/QTI3Llqx/OkTYqGnHtrRvbIuwpqve0iQTbaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdwfk0eky/+I92xswQdkbuE/IHlKQJSJ5KSqjQkG7/Ay/ED3U4bp1uemyyMo8SFQshtMZpUCZiH9Tx7Y9qzaIYHGNaG2bQFa19wXuOZLt1ngbh+QrChGvVsuHM3GXpDrzxDThB3bAARt260j0R/Z2zJvzkbBmU5ac9WfjIJAIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9fj0Aew; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756807386; x=1788343386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A+NdCy/QTI3Llqx/OkTYqGnHtrRvbIuwpqve0iQTbaU=;
  b=S9fj0Aewvg7u48s4DTxLCxkUh18bnF1c0rLjqNVYKfLi+ZA4KvIk19OI
   un+s5rX0p5N7BXMUfjtpnS5taNULSkkoTdOJX+ITAm4Iy9oW81imT2y9N
   7WLMxW6hEF1bFawPqyu+YaIBAruwvNhHY+GxaPlVoTAYYW9Yd6zmYvXQk
   dIkK6kdsXFRQJAw0zHn8oZBiDd4nktFM7pPwJj8Tm1FFdayyfk80nz1lt
   NTtj8ygq1IZ1+F/VvwAMb3WGgbQHUepHexxgKPjzAkaaJJ7wrst78dBru
   d9TD/x6yhUymsPk6dNeU8MLXyFGofjqTxlR5ryoOAn2/vvQrGbW9wGgfX
   A==;
X-CSE-ConnectionGUID: DIcEz/iJQluavX8VPyvhcA==
X-CSE-MsgGUID: WWFNB2IqTLKj5OXJ8OBHKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69334095"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="69334095"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:03:05 -0700
X-CSE-ConnectionGUID: ZSKzDkOZSwOxV7XTN38zLw==
X-CSE-MsgGUID: SjYyc/jyRvihbBLIjXhWlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175599919"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:03:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utNqu-0000000Af4t-3FIf;
	Tue, 02 Sep 2025 13:03:00 +0300
Date: Tue, 2 Sep 2025 13:03:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] auxdisplay: linedisp: display static message when
 length <= display size
Message-ID: <aLbA1Ma9Cig3gbWV@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <20250901020033.60196-3-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901020033.60196-3-jefflessard3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:00:26PM -0400, Jean-François Lessard wrote:
> Currently, when a message shorter than the display size is written, the
> content wraps around (e.g., "123" on a 4-digit display shows "1231")
> without scrolling, which is confusing and unintuitive.
> 
> Change behavior to display short messages statically with space padding
> (e.g. "123 ") while only scrolling messages longer than the display width.
> This provides more natural behavior that aligns with user expectations
> and current linedisp_display() kernel-doc.
> 
> The scroll logic is also consolidated into a helper function for clarity.
> 
> No API changes are introduced.

...

>  /**
>   * linedisp_scroll() - scroll the display by a character
>   * @t: really a pointer to the private data structure

>  	linedisp->scroll_pos %= linedisp->message_len;
>  
>  	/* rearm the timer */
> -	if (linedisp->message_len > num_chars && linedisp->scroll_rate)
> +	if (should_scroll(linedisp))
>  		mod_timer(&linedisp->timer, jiffies + linedisp->scroll_rate);
>  }
>  

...

>  	linedisp->message_len = count;
>  	linedisp->scroll_pos = 0;
>  
> -	/* update the display */
> -	linedisp_scroll(&linedisp->timer);
> +	if (should_scroll(linedisp)) {
> +		/* display scrolling message */
> +		linedisp_scroll(&linedisp->timer);
> +	} else {
> +		/* display static message */
> +		memset(linedisp->buf, ' ', linedisp->num_chars);
> +		memcpy(linedisp->buf, linedisp->message,
> +		       umin(linedisp->num_chars, linedisp->message_len));
> +		linedisp->ops->update(linedisp);
> +	}

Hmm... But it seems the linedisp_scroll already has a check, why do we need
an additional one here? Perhaps we need to pad a message somewhere else and
guarantee it won't ever be less than num_chars?

-- 
With Best Regards,
Andy Shevchenko



