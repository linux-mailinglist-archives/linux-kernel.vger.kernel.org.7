Return-Path: <linux-kernel+bounces-882468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E008C2A8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274CE3AA095
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F192D9EFB;
	Mon,  3 Nov 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRjk03VT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466112DBF75
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157830; cv=none; b=cbL7wq6vaki9Hb8DzFv1Qj51/eEYSAShmTjtANs3c+sce1JaMS3E9IUFxqFgyL/5AUjepoY/L+X+KYsktF5OaThozrBAb0QmciqWfvkdHeZ4EwC/GqUcCfKSpDIwGv04TcSbw+xCXTLNSZKu9UwlQOnb5sQccs7QIUydpWKqDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157830; c=relaxed/simple;
	bh=j8mFAeinoGzjohTxPM/JooGOND/brFE6iWetnyY1zLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+7uG40R1CKVNAvhY0eIV+FtIAqT7vk1YWzQoflqduYyYfGEa0IODs5VN9rpMtOjrS1E8YvXXQyet8bPl+Rnhyfzxlu/skJxYZjh+d9MpQNwDaXnbbICqvl38cgK+DY7HnxH4ViwufL3cCxa1IrjrFKykBOvV7zUKqhw3EHgNgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRjk03VT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762157827; x=1793693827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j8mFAeinoGzjohTxPM/JooGOND/brFE6iWetnyY1zLA=;
  b=HRjk03VT2gW0QPdCBzJs9UAKc92nXpecoP+n5MDeCAYXuo6ujO45Uuz3
   Wu44VyqblIotsS8hOhCt6P8iqPrL7ZezJqcpmdBcuyrTEO9r4AjQDnLNS
   kweed5HrWMPsFI4be/Gm3b0W3H0UAI5fG10FJSy/MSfAR1/cFiKobpCww
   JizFyHAAuoicRQ8MouAzpqW93Do2W7ZGYl/GF3wA+yHxgyK57ScTgGT3+
   zJTq4+fAjNKJd5YRk3LODgeBNAFSzj0TaHaBSE/Yq//1G8f6qF82S4WzE
   WSbHMcE88o9JPc7JO0eQg/lHs/nde+WO3DPH+SyMg2uhahSmiHu8bbR1N
   A==;
X-CSE-ConnectionGUID: mN/ighyYSy+tV99AzzALgQ==
X-CSE-MsgGUID: 31wjy1WCQ6emXCGLabQAZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64153815"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64153815"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:17:06 -0800
X-CSE-ConnectionGUID: 5Zqo+qmeTNONqQD3jKh5hA==
X-CSE-MsgGUID: 8IzxdN4iTv28R+IiUJY3gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="210339720"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:17:04 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFpkJ-000000055Qu-2lCY;
	Mon, 03 Nov 2025 10:16:59 +0200
Date: Mon, 3 Nov 2025 10:16:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Raag Jadav <raag.jadav@intel.com>, kees@kernel.org, broonie@kernel.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mod_devicetable: Bump auxiliary_device_id name size
Message-ID: <aQhk-lQSDhzRmqHu@smile.fi.intel.com>
References: <20251031190234.224813-1-raag.jadav@intel.com>
 <2025110105-upright-dinginess-3b2c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025110105-upright-dinginess-3b2c@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 01, 2025 at 07:18:22AM +0100, Greg KH wrote:
> On Sat, Nov 01, 2025 at 12:32:34AM +0530, Raag Jadav wrote:
> > Since auxiliary device id string is formed using the combination of parent
> > and child device names, it may require more than 32 bytes if both the names
> > are long enough. Bump the size to 40 bytes to satisfy such cases.
> 
> What in-kernel users need such a larger name?  If we allow larger names,
> people will try to do crazy things and use memory addresses in them (has
> happened already...)
> 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > Triggered by [1].
> > 
> > [1] https://lore.kernel.org/r/aQSwWLVKH_3TthTW@smile.fi.intel.com
> 
> How long would this driver submission's name be?  I couldn't figure it
> out, and really, any device with a huge name is going to be a pain...

Right, Raag, please describe a use case.

-- 
With Best Regards,
Andy Shevchenko



