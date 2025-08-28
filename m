Return-Path: <linux-kernel+bounces-790362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEBB3A5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1222B3B5528
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7693218B9;
	Thu, 28 Aug 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcWKu52i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29E27E1AC;
	Thu, 28 Aug 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398055; cv=none; b=EvJUnHLhxOy37BDayA7ycMLUsCqZ8iGkR+SXSjXsLCUleH9xZW/aupDqK5twmPko8TFxh6niC97apmN+L6lyE1ImnkoustGyPFVb2nJWBaDIwOj4bbuHbL26JGUbDIwZ0N0jpHdwZPFdvlFSgxNi2uRz2WqpwIqf9JkA9w6GzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398055; c=relaxed/simple;
	bh=6gspWONwjRhKsfL5MZRWR855vZx/5z8rz/5fstT6nOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HkdqnO7FynZzIEF0k8GIEDAjYCQSVi4e5+GULsGh/T4VMbSdDdO6dcxnTD6zdLxRH89RC61siullOfmEUHcniTwGr/i/f8QbINE7z0frpk8s9qpRvPzWuEC5nsHK92IYjAIDUpLDS9E6ZZu+xZlwKBLS0EvTakBz6tEw4Mvh114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcWKu52i; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398055; x=1787934055;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=6gspWONwjRhKsfL5MZRWR855vZx/5z8rz/5fstT6nOw=;
  b=GcWKu52in22f5trxmetsgHoj3/7FXwF6xDIEdEMegtlafSZVozoAI7fP
   x1EbfLDftXz+z8ITpWq/2SbVpcaUcggDIqkh069/ZHIHbziGUEqomHdpq
   e5WwaMPhK9WvNV+SxRuCAvv8GBqbfWrDZyPLutG1UTioerP5+utxA4r48
   4ehTuwbV6JH3uUXDCD/+2VVQFp8RnIkRs/4gs5WKmFM/dxG1+owuXwkeI
   BdUcDJoe4h7/pd01WId9Bf9m+uAIjedcWT9E03MaYj4FK1cJVhUWXNpWy
   z6nAhMq5NjWdVTxxGVutUz/WZJPL7ux2AH/FyJ7oawTCpHazIjb24K1qh
   Q==;
X-CSE-ConnectionGUID: DwyPnVDeTjyt38Szg0LW+Q==
X-CSE-MsgGUID: 1gggCqp+RuqsPHWfwW3ZCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58619066"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58619066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:20:54 -0700
X-CSE-ConnectionGUID: xlk3QZfOSUyfXGFlTcRWHg==
X-CSE-MsgGUID: U3wCk/hqQ/a0o+XdwHPHOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="175431312"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:20:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250827131424.16436-1-wse@tuxedocomputers.com>
References: <20250827131424.16436-1-wse@tuxedocomputers.com>
Subject: Re: [PATCH] platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to
 spurious 8042 quirks list
Message-Id: <175639804659.20700.7196322883688733944.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 19:20:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 27 Aug 2025 15:13:51 +0200, Werner Sembach wrote:

> Prevents instant wakeup ~1s after suspend.
> 
> It seems to be kernel/system dependent if the IRQ actually manages to wake
> the system every time or if it gets ignored (and everything works as
> expected).
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmc: Add TUXEDO IB Pro Gen10 AMD to spurious 8042 quirks list
      commit: c96f86217bb28e019403bb8f59eacd8ad5a7ad1a

--
 i.


