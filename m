Return-Path: <linux-kernel+bounces-796088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29FB3FBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7A92C2C49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DAA2EE5F0;
	Tue,  2 Sep 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8+uvpO4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A01A288
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807480; cv=none; b=EMWA55nYFxZw8R3ZzKP90mS5MLvgLrok2JT0d/ztPkk9v1cE7/4ljAklhG4dkefpbWE0VxBzERdAizBo3BD0I5ULgYIqpooL9JMNDELZIRyaGaOx6302+qaedzdqLpAP/o7A+wpHH7bqf9dHp56i40CupCLvTu7xdXqjQyJ5YLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807480; c=relaxed/simple;
	bh=DaeLapKaYHOr60eRmE53nQmUJf2cga3S68w5EoPTUHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC2d+MVdRc4X69Yakme19JPO5R9QDEitzjDHG3rYH8BY6lRYw5UEuMwzr4c6ZW6QTq7MbuSXsdZYU1O7df91URMhvP9Xk3J6P1touNNHZusQQioHHkhC3JpuIwwVIfVCUpNanSMNvCSjiZ03i2q0NFc4u4E3ZYc0VjKuDCgwzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8+uvpO4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756807479; x=1788343479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DaeLapKaYHOr60eRmE53nQmUJf2cga3S68w5EoPTUHw=;
  b=N8+uvpO4yRc0Ufv9HX7mGHhZ7ww0DCgc+EWtVQAbdLXRPlVQzouNK/vO
   ZQuE+Y3L3KnuC1m831D9SVyW5JBNYU1lINJS1sppG1TfOQWUrPJA8gskT
   KxuOXfwxvMLoa3gRLk7fDphLe02onxY0n2uvLXnMnu7UBQ30z0hkEYN9d
   4qk0k8mqAeIK1iubPIH3K6al/2SZeODl7hgpUk+TXj3rZ4dntnlsYjOaT
   h3koMJnc55jCzrNvso2pOtMivlB3CxyWV/x5yMiw0Xik6sJTQVmZMZZ+C
   5MFc8ciSAYVl6UAAclEp8pqfxfNZh2w5dnpE6H15MJIQlYRZnGDMjm4Ny
   A==;
X-CSE-ConnectionGUID: AQ+jpAt5QSKyV5BuYyggyA==
X-CSE-MsgGUID: LaoDRzk3SEKqrrbMz+JjzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76516981"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76516981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:04:38 -0700
X-CSE-ConnectionGUID: jzLSp0h1ReeP5e5kStCq1g==
X-CSE-MsgGUID: 3R6Hl9h0Tlux6QRnCwWEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170494976"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:04:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utNsQ-0000000Af5n-45Hp;
	Tue, 02 Sep 2025 13:04:34 +0300
Date: Tue, 2 Sep 2025 13:04:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] auxdisplay: linedisp: add num_chars sysfs attribute
Message-ID: <aLbBMumD9mJK2z5U@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
 <20250901020033.60196-4-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901020033.60196-4-jefflessard3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 10:00:27PM -0400, Jean-François Lessard wrote:
> Add a read-only 'num_chars' sysfs attribute to report display digit count.
> 
> The num_chars attribute provides essential capability information to
> userspace applications that need to know display dimensions before writing
> messages, complementing the existing message and scroll controls.

...

>  	&dev_attr_message.attr,
>  	&dev_attr_scroll_step_ms.attr,
> +	&dev_attr_num_chars.attr,
>  	&dev_attr_map_seg7.attr,
>  	&dev_attr_map_seg14.attr,

It looks like we have two groups of the attributes here, can we keep the upper
one sorted? (Put the new attribute one line above?)

-- 
With Best Regards,
Andy Shevchenko



