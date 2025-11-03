Return-Path: <linux-kernel+bounces-882590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87EC2AD14
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE6F13434C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F32F39A1;
	Mon,  3 Nov 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZYQ380G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEE2F291D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162979; cv=none; b=dS/fNCxyQEtljgIpF02oV66A2+OPyqAk5GotUdd18txpF8iA50y2CiD/GeyN2JurIoBWPNq+3fu9u1wvlZdFUASHFqrJnEd+KaIvr2WwJuPjzZswh8JTZtOy5yrwhZ0z1h/QpuzIY1AlFrT/KwnbThUp28KBbsqaJeGkq2iwp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162979; c=relaxed/simple;
	bh=iM0sgaMKRFAsw0YRK+d7gXx4/u+EAcjrzdpAg8bwqyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX37mmaRR23paiag1vPtKYATA72rqY/4lPgGA8vXSPnH5DLcBYu0hjMO4kRUJ3CJjpk7nplFnmALYwi+KNJnQdtAkHgx0PHQcY2vSYGFfc/QWpvj30fpf/SaKvJgiUG4oEOS3jn+wtcmDbmAcdHF9pTS6PrMG0paJFI7y8xp0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZYQ380G; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762162978; x=1793698978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iM0sgaMKRFAsw0YRK+d7gXx4/u+EAcjrzdpAg8bwqyU=;
  b=PZYQ380G7tvELcugcTaAj6HoSN3dbOHqbbtRglg2OjeIinr0KiiwLBTU
   0fU1pubk8THJII4LyxsRIJmAK+Cq3sFSabIVo+dk3MNuQyTuO+ZkN5t8L
   j/3IFTYyRyzlRwuPfCleMwHrrGaUOzLimQDaPIoNh2jSzcFA/Yt8l78ms
   ABYVth9N4URlQF0vwiJHVEi4S/l5STeJdGMjWkL8zWpDmdsXU4yqzeYzF
   DWeWNKif+rLZ6z9/U2JjmTcqhe/tdxmM5/JVUAKf0OkFF05ProuHVvML7
   IZjkZ7ub8MYlO+tOqnahCtUEuEEfN9IS3BG2p4u769xfpJsjdZCHpxzQM
   A==;
X-CSE-ConnectionGUID: 36CilZURQDi66K3EcwYkIQ==
X-CSE-MsgGUID: G5ToeA2XTMWmWeDJYt3qPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64385151"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64385151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:42:57 -0800
X-CSE-ConnectionGUID: /U1DBDAATPqyHYgCgSf+tw==
X-CSE-MsgGUID: 38ZbeHYhTx2vqnKM2bM5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186112044"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:42:55 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFr5N-000000056sa-31f3;
	Mon, 03 Nov 2025 11:42:49 +0200
Date: Mon, 3 Nov 2025 11:42:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] lib/vsprintf: Improve vsprintf + sprintf function
 comments
Message-ID: <aQh5GINiLL9xLlzg@smile.fi.intel.com>
References: <20251103090913.2066-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103090913.2066-2-thorsten.blum@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:09:13AM +0100, Thorsten Blum wrote:
> Clarify that the return values of vsprintf() and sprintf() exclude the
> trailing NUL character.

I dunno if we need this clarification, but I'm not against it either, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
if it helps somebody.

-- 
With Best Regards,
Andy Shevchenko



