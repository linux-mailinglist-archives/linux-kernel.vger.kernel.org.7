Return-Path: <linux-kernel+bounces-860160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED68ABEF757
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177EB18995DC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9D2D7DCE;
	Mon, 20 Oct 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReXGEkky"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A832D73B4;
	Mon, 20 Oct 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760941310; cv=none; b=Z+Sfj/fU5pNsPiLF/73wcugBegZ3Ji7rCq53YDniyNCAj7ap/BJ+btCVCmvAh24YQPhMUI+SaKWU/ObBZ9/85XVOziZef1oUimVfSt5N+0+6+v7K8e7Pvpju4icwgy9cTUQRW544ECB0uBATb9QTH8dZ+VuRCilVmEYuev02o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760941310; c=relaxed/simple;
	bh=m3WSYwZfQYBAe/ctKfXulnoHd48KB+494AXifxvjUUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcgaH+GOCd0QZV5djEyqSNw3UADSKUgR2fkPamBvMDCa5t7M5e4QM3DvgsTsWmCrM5xpsp6Tj6vdBEaXd6IJyvQd5MYY0pMkuNSdG87XFch83fzDGcE77IvamVylUAkh+rI0UrK8Pi7BuhiiSdBPFq+ipi1CrPmeBCpZ33AwTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReXGEkky; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760941309; x=1792477309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m3WSYwZfQYBAe/ctKfXulnoHd48KB+494AXifxvjUUk=;
  b=ReXGEkkywPwcjbAQv3ar8+/lq7Uj79ohc5NGIzCx/cBEy/1mRbwmR/IM
   Bt6CJ5of+glqjPmJMOr+N4dn606AvhUsH3QDWx1RW6YeBA2xoGbTxupUI
   qEYWyYnSwYAm5rq4g9XfJkzRzqwy6yRp4oefNSDZSRRHU/9sx0dht5m15
   LgjwWOsQbhSZ3Gr0tC37p68tACV613AkayRbXVmPHSrRpbtKiG2smPsBp
   ucOWxuj2GOP8cdOINFMId7D/AuS+x20hPGgg3W7WEOndapn0cJvDpfwAl
   or7DqCpG1jYBOEJg60+ecgxreZ3Z4XJ497byjITLugkYTqjbZvSeanf6n
   Q==;
X-CSE-ConnectionGUID: RdF84HBQRSGN6eZ/7lZoqw==
X-CSE-MsgGUID: v/kurGknR5Oof9jWJNh0Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="88522238"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="88522238"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:21:47 -0700
X-CSE-ConnectionGUID: DjYtgUasQ2Oua1TnRI4TLg==
X-CSE-MsgGUID: Ztoo97+LSiOTD9+uUSZksA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="213874034"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 19 Oct 2025 23:21:46 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AF85395; Mon, 20 Oct 2025 08:21:44 +0200 (CEST)
Date: Mon, 20 Oct 2025 08:21:44 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix typo in tb_eeprom_ctl_read documentation
Message-ID: <20251020062144.GJ2912318@black.igk.intel.com>
References: <20251002173459.68542-1-dominik.karol.piatkowski@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002173459.68542-1-dominik.karol.piatkowski@protonmail.com>

On Thu, Oct 02, 2025 at 05:35:33PM +0000, Dominik Karol Piątkowski wrote:
> Fix presumed copy-paste typo of tb_eeprom_ctl_read documentation
> referring to tb_eeprom_ctl_write.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>

Applied to thunderbolt.git/next, thanks!

