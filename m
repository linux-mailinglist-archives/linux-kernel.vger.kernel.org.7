Return-Path: <linux-kernel+bounces-805571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B14B48A4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D291636D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8467E2F8BD1;
	Mon,  8 Sep 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzV7w4Fe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF52139C9;
	Mon,  8 Sep 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327850; cv=none; b=CDtOkfhD/R4NG8ZiE/slb+b9j4wIP5z4cAZT4xsRQVvMhvffk2F1ZcCrKr1RHMxwa6WKF9ibNp6Odx3qJ7j1m/dwyQMiIP5bP0/d16AOHLkz0dGZ6nJBsS/dmxco48s1GwLbeDKAazKzXSlv+C5B7Lh/6iifq5vnYjBvureyleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327850; c=relaxed/simple;
	bh=PdqRhfEIId3G/UjxVjpB4/kkLUvCR3+Q6zKK5U2Rspg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=URCTPFHjVS1f7+2/5EvgDawZhAlCtUqmhbrqUgUt+JTe9fU6LdlUNbGVE/Xke6IyawYt8Z/z2wcFoaRlvYbNLxYBxW9XuMPzkink39P8QWOXqgsVqmyyC3LWwjOKyBOSlabXh5BydpupPAwNQS2vOBkyyXUTdFdThcT0c3Jq0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzV7w4Fe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757327849; x=1788863849;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PdqRhfEIId3G/UjxVjpB4/kkLUvCR3+Q6zKK5U2Rspg=;
  b=DzV7w4Fe58lZZBLnqaKYdGsDdLtvl7z+3eXHo62xXqxWWmMR68e8FH/I
   aXu5Q0bQbaSMp7WXGbt+2YIWQMUKnOnoc6Ykq0+rpLcLaM5pVED4g7CF6
   IFigO5AV2fEQtPPa9qp+em6mJnZK4BEl3tFJIdyf3Yucg4LZcbtQPbqkS
   bxyaoeel4vfzR7PF++zm9M19UNt0p/Of0CPmryEVACwu7GUSpXPhFNh6K
   v7O0DPzZK1/T54IhhREzj3vH/Z04d1pc8hPTqm696T/64ctotxTkBtPO3
   8PqSDHI0Q9Zad64oOAwoolC3/XlDZkEWzVMceeKNLx9HtvuCjouVmhgd3
   w==;
X-CSE-ConnectionGUID: fbhUFVKCTiybPWOb0Z5lyw==
X-CSE-MsgGUID: I+pYNLrTTmeWXZqV09PSiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70284100"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="70284100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:37:27 -0700
X-CSE-ConnectionGUID: Gmr9I4MrS1WXVyjef4Fwww==
X-CSE-MsgGUID: /7QXt5PUSze1Rm/WWC4sVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172681489"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:37:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Sep 2025 13:37:22 +0300 (EEST)
To: Daniel <dany97@live.ca>
cc: LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store
In-Reply-To: <MN2PR06MB55980FFA32BF5DABCE34333EDC0DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Message-ID: <45f04f10-a003-fc42-2551-a2e180358ca8@linux.intel.com>
References: <d2e91809-8872-7a3f-743f-b4091e8196d2@linux.intel.com> <MN2PR06MB55980FFA32BF5DABCE34333EDC0DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 6 Sep 2025, Daniel wrote:

> > Is it okay to remove preserving the other bits?
> 
> The WMAB call reads only the lower nibble or the upper nibble from the
> lowest byte.  Similarly when the fan status is read from WMAB, something
> of the form ((x << 4) | x) is always returned.

So the upper portion of the mask in the old code was overkill? Please note 
that down into the changelog so it's recorded into the git history. This 
avoids somebody having to wonder why a seemingly unrelated change like 
that was made if somebody looks at this commit after a few years from the 
git history.

> > Please name these field with defined GENMASK() and then use FIELD_PREP()
> > here for both fields.
> 
> I don't see why something like that should be necessary, seems overkill,
> but if you insist then I'll do it.

Yes, I insist. When we touch older code, the expectation is to use modern 
style and helpers. In here, naming the fields will improve readability 
and document the fields more explicitly.

> I'll try to send another patch sometime soon, I've been very busy.

Don't worry, there's time. :-)

-- 
 i.


