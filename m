Return-Path: <linux-kernel+bounces-846841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C3BC933B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA081A61DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B62E7178;
	Thu,  9 Oct 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cu4gC3g8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870B2E2F13;
	Thu,  9 Oct 2025 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015300; cv=none; b=I5o9t2hKrnxfr8q73oGK4dJf7wOG4Mr4G+lKs9rLPnMxQwx3uumr2sRp5lKa4VVhh0HrqBJW5kOaEKveadiG5o/zWTrmrheHSuKik2KojzMN3DreXwsnFn1RLNsYUtithBv4WyzG6xBChBNcLJ9u73ntZ+unm62flZdVvMpMAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015300; c=relaxed/simple;
	bh=W9oySEuOqxxGaxVg9Z1vdxRkil2ALKe1azGsPH4A/s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnVZTwz6Uv9ABLPLYEHrQANgfoVhmrLEvPcyxGPCbT6A+Np2NzTDXrXim1PW9IauVl65K+kr/KSE3B4gSDTeuDaJkgpcs6Qq+KrOIRfQpmStJ/RW2kGC2ua+XrxoT4eFikeiXOol9e7Uvj9nU07n3WeIiHOTXWT9OntGnHS3sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cu4gC3g8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760015299; x=1791551299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9oySEuOqxxGaxVg9Z1vdxRkil2ALKe1azGsPH4A/s4=;
  b=cu4gC3g8A1ODMercTBvyXJpvALMeEMRzRClMXwRWSd8WLY0XJjb2ENab
   96MDEHL/ixEVseAnJmeapyb/mSphpd3GgLVf2efSz0xtkISHs40Np3SKS
   E53z1FkAzUgL3hCo0eDDdHlukMSbfQyv8OTQMvPVg2lwkMrmH8W1m02V2
   C9VG3MFM6JqVAR9k9sOi1ZT7HU0lHi08czxJ1GlbfDoUyr3zCBLpapBEz
   gdMnk1jq/d063oO6NfQ5FF3TitWUJGWHUzcc6ODkFSilCjQ9vQI6YcSE7
   GXhU8DrWmEuqBoT5cc10PQqEGebGB8+boXqmfJyXOLL7iSrdjwFHTnSp1
   g==;
X-CSE-ConnectionGUID: D0P076BEQRCxA5J/LHTUXQ==
X-CSE-MsgGUID: aIdanp0uSXiKXcr9xZhEFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66052235"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66052235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 06:08:18 -0700
X-CSE-ConnectionGUID: PtJjoHvITdmvz/kLEn0spg==
X-CSE-MsgGUID: pqbst9iiSXmGcofaqAqwYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="204425337"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.245.29]) ([10.245.245.29])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 06:08:16 -0700
Message-ID: <0ccd0f1d-4b8e-4d7d-9178-c92c17d21b3e@linux.intel.com>
Date: Thu, 9 Oct 2025 16:08:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-pci: Fix USB2-only root hub registration
To: Arisa Snowbell <arisa.snowbell@gmail.com>,
 Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 Niklas Neronin <niklas.neronin@linux.intel.com>, linux-kernel@vger.kernel.org
References: <CABpa4MA9unucCoKtSdzJyOLjHNVy+Cwgz5AnAxPkKw6vuox1Nw@mail.gmail.com>
 <20251007231709.6c16802e.michal.pecio@gmail.com>
 <CABpa4MCUnLUR_0Vzgd=rTr0+Hot=nxHirKrX6xtJWowDoLhWJw@mail.gmail.com>
 <CABpa4MCg7yixe7O8Pp+YwvpxeC=1JPhMhAap12RjtV6pcxFYgQ@mail.gmail.com>
 <20251008082055.5646dadc.michal.pecio@gmail.com>
 <CABpa4MCm8hQXvtSYqUA+Dh3rCLVM5rTC1p+FsgmFemv+Vyz=RA@mail.gmail.com>
 <20251008130532.49922d58.michal.pecio@gmail.com>
 <CABpa4MAsvK68CyQ7bVdie1j2m2O2YAEuFJHq8D-65uFT3FzKzQ@mail.gmail.com>
 <20251008223406.13f16f19.michal.pecio@gmail.com>
 <CABpa4MBGW=OJi+j34TbL2g=zyTg7-rxqpHYfAW-1DXTPk=g5Fw@mail.gmail.com>
 <CABpa4MBDvgJcgJf3_E7k1dBXs7v1tW-79dmc_sQDVM1bES5YDQ@mail.gmail.com>
 <20251009131444.2c221922.michal.pecio@gmail.com>
 <CABpa4MC-pij0Fczh-mH3zc+Ey2ALX70OfxX=cG4om7R6WMdRBg@mail.gmail.com>
 <20251009142911.6069c164.michal.pecio@gmail.com>
 <CABpa4MBAikj508aofG3fodycbriCMYHTZjJm8L5dcEV+JB15xg@mail.gmail.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <CABpa4MBAikj508aofG3fodycbriCMYHTZjJm8L5dcEV+JB15xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/25 15:49, Arisa Snowbell wrote:
> This also works, thank you
> 
> - Arisa
> 

Thanks Michał and Arisa, I'll apply this patch with a
Tested-by: Arisa Snowbell <arisa.snowbell@gmail.com> tag,
and send it forward once 6.18-rc1 kernel is tagged

Thanks
Mathias

