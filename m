Return-Path: <linux-kernel+bounces-727953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A46B021B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383245465AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C502F198D;
	Fri, 11 Jul 2025 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Utqmyygu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026C2F1987;
	Fri, 11 Jul 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251216; cv=none; b=tC4tm42QDRc/XZnUIC972U/kGbxwz+DmwgpMxA2kz94MpHYIwQMnoFMNLiwLNeXwhx9b4U0EFGHMr3FcTV7HnsY6b1f8FWR7o4xSsW11SHVRt4Y7ZvnWSJTQCJctfN/KobiYy1/w2oB18uTOwN2tLbPdj5oFuOXTGr0e6ehJGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251216; c=relaxed/simple;
	bh=a7BM8wgwmFL0JatFqoMOdr1GJsje0RBxeL/3HCZU078=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b6pwcyZ/thP5i/VoNnRyKRUCZErZep+3Cfu+koDjHdnHYcIgDdyeLUNapuEnuNwBQE3KxTMkbZ3ju8JLs3e/nN/nEXr5g0T/kWvqoSGeAXMFck7YC0NtnOg3xiPPOfhcuHv+eQaVtJmrzrPlKYXn18C2zTAg/PhizC5pK462x4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Utqmyygu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251215; x=1783787215;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=a7BM8wgwmFL0JatFqoMOdr1GJsje0RBxeL/3HCZU078=;
  b=UtqmyyguVy0mzzpeHnJ+J/TBRWIlSg5bDx1IN0Xa3VghHg9nI+BXXzbO
   Rb4wJCTFYwP8WP8vb7inzLPs2iy6nF3U1kZbB7aFeUPuuQMuaRjf5czz9
   LoUjqYRKRaMl6Vl6yCs4bPUh8lF7byZKoVRzc4pPNISdXTGdnu8I58LeA
   FFUqCKjYicj1keu9ghOIdST9rQEM0MCYfcskZtgbLNroUcInfn5Di0Fvi
   U8ftAErIg7ZVX2QTsCHvwT4hsJ9hIGytbNFFqjRt2tcKhO05OOKZQlkpO
   nP/6CqZF7F++xL946Ywn/GOXKcdzoxA85R9cE9BBHxYO/nD8IPdNoUsgy
   A==;
X-CSE-ConnectionGUID: j8nj9JTuTG+61vfuR/fomA==
X-CSE-MsgGUID: 86kG76VCQk2seKVkjVcJcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42184051"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="42184051"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:55 -0700
X-CSE-ConnectionGUID: gPztrH3oTtmCnDC26XyJvA==
X-CSE-MsgGUID: MMvG4Fl/T4aqPGVwr6q2Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160742542"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, Jan-Niklas Burfeind <kernel@aiyionpri.me>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250710190919.37842-1-kernel@aiyionpri.me>
References: <20250710190919.37842-1-kernel@aiyionpri.me>
Subject: Re: [PATCH] platform/x86: dell-lis3lv02d: Add Precision 3551
Message-Id: <175225120779.19602.4440321847761795142.b4-ty@linux.intel.com>
Date: Fri, 11 Jul 2025 19:26:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 10 Jul 2025 21:09:19 +0200, Jan-Niklas Burfeind wrote:

> This marks 0x29 as accelerometer address on Dell Precision 3551.
> 
> I followed previous works of Paul Menzel and Hans de Goede to verify it:
> 
> $ cd /sys/bus/pci/drivers/i801_smbus/0000\:00\:1f.4
> 
> $ ls -d i2c-?
> i2c-0
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-lis3lv02d: Add Precision 3551
      commit: aef9da333823f70b074e36a94c6e85f5c55e5477

--
 i.


