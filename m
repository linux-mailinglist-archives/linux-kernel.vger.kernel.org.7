Return-Path: <linux-kernel+bounces-753019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFBB17DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E92054434E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7043208994;
	Fri,  1 Aug 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fa/4b+/0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8A1FA272;
	Fri,  1 Aug 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034977; cv=none; b=hK9LKtXsk17Hu+O8Th+mfIG9dyzxM3XZFhBzrH4g/v6zcnHaABsg5SuDDzPq65RTJ7A2FHoAlm5QL2fioaEg3wHg26OStSPSxWb/QkHZozbp0rW4j5/y2JvpqB+mt2RbKqxYbhZHLbR/XYHQ52QleYL02YFfA9q+spQLjGiAb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034977; c=relaxed/simple;
	bh=2UMcEhhoZlhjw6r12HgvrQgNjxVVNgnGO710rWLwQRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PB7YGiJM9foy2qCrDL0AMHEe0oB1tbC71PcenYCzMSufHh/9b++u47cdmhorPVVKgEsxrqzZ6+h/LY8oJoOevZYIdbACSjeMEq7u6GTxzj1fY7W2KZNT8S8Ix+i+oTd2Gnw3+J7fXFsY1W6tDs+VR0FLhiH2Lo3vPf4T35fjo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fa/4b+/0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754034976; x=1785570976;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2UMcEhhoZlhjw6r12HgvrQgNjxVVNgnGO710rWLwQRU=;
  b=Fa/4b+/0XRXzOWzoeVGixXkqzm4+Gn2d1/rjJlYYGKFDhf/E5AQWoPKk
   9S+0QUWSX1J3uMPHNaOy0Lmml7FkmX9k5oFygM6lYEOcBRTabefMN5sng
   ZGBbwgZTgNWcyXDP9DAO3+rZT6gwIXl5BYWtfGtVc0Q0CXa+j9uUchSho
   ckuwccYO7uvF/6hzH4EyRTHXEUw64z6LXAqF/0dDD5zCgQiGQdBxjpD6b
   fgfSEGy4Fm7Hj2HuEbd4PUA9XT0+/I74EJjH3wW9EDOXIUQr7hE1LYhG/
   IjCjD5GtSv4kEoWi1uNJh/kDCVCsviflAJHuXg0LyoKsKIdKp+IGwsLik
   Q==;
X-CSE-ConnectionGUID: u1QJuk1QQqa3jS/CCMcmuQ==
X-CSE-MsgGUID: Jaf5aQ3mRHSTTbCs8sPNCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="60019011"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="60019011"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 00:56:15 -0700
X-CSE-ConnectionGUID: LfvIxM39S6WdKa7/E14LSA==
X-CSE-MsgGUID: 7BmRcL02RbS34FFYpdmvKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163942874"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.164])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 00:56:01 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
 corbet@lwn.net, apw@canonical.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
In-Reply-To: <45f0995f-17ac-45a3-8bc0-3b276ee91a9d@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
 <53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
 <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
 <45f0995f-17ac-45a3-8bc0-3b276ee91a9d@kernel.org>
Date: Fri, 01 Aug 2025 10:55:55 +0300
Message-ID: <3e9106d35d41a044adeadffeea32fa096c9e1370@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 31 Jul 2025, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 31/07/2025 13:55, Geert Uytterhoeven wrote:
>> B4 does not follow the proper order:
>
> There is no "proper order" in terms of absolute facts.

Let's just decide whatever order b4 uses *is* the proper order, and save
ourselves endless hours of debating! :p

BR,
Jani.


-- 
Jani Nikula, Intel

