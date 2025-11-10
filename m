Return-Path: <linux-kernel+bounces-893060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD427C46700
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F99F3A50D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322930BB9A;
	Mon, 10 Nov 2025 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V56k7G7O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DA21772A;
	Mon, 10 Nov 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776044; cv=none; b=hoCzpwKcqAIm7gF6EhBgk2gXaz7R0a626tJQ5+rKZDGl2P/zVg6u1VRNv7HveEBDiaGS6sztUDGjR8m/nYcXeKv1aqaZe6OdiJZw7XKal+enS821lU0aTeGBqWfrcNbSFxaVeK3LQw/lClAZVCqxpSOKY8n0zt3RTYiK+VNZfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776044; c=relaxed/simple;
	bh=pLq2WM9z+voW7C5dO4LcZoazmwugdxikgQMGtcE8DjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UZjkdfcM5HvBHp1HuGh/WW/1US41BFtV5eiIwDShVRhmVOV9K6cjQ2JwiZNmCw0D5U25DnKp5K+AO/CupheQX9RyycEOqiOV/FzOCfMPRSB0yuoO6q8Ipu463ckbn06oHvw5WZAuQlH+ZLHomdz+JcflALWBHdSQWQmjsezrKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V56k7G7O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776042; x=1794312042;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=pLq2WM9z+voW7C5dO4LcZoazmwugdxikgQMGtcE8DjQ=;
  b=V56k7G7OSGAatP2OW9WlolA39d5Av7dSLAfqtlP30W4+Q9J4FK4zzOYk
   H1P1oC8BwhrtO0+yB0dM8lK4EwvGLVjeOPe4A1y9uG6tUqSUfM/39Utzp
   A+jyAVgnFIfdfdBe8zmNi7s0daKJ5YwHxvendq87Q13Q/R82PbgP6nKNi
   DmIStTvZ8djPuJfbC83kzusClEWXoSTGeoL2wjhiVwq5BdF72bIgoezsi
   +chAXmI8av6tLig7ZeOpuWGSh340tHW2n0lbdoaK+rjDuo7KM7xbA4qGk
   ti/r77DOe6be7mo1G5qA+S9tW4t8GQ4OO+2tUZty2Bts5bGy1NWVWLLaG
   g==;
X-CSE-ConnectionGUID: ADTx3j8IR1mPeUQfBlWTsA==
X-CSE-MsgGUID: zUUtL1oZSU6QR4bmzmEfBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75433454"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75433454"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:00:41 -0800
X-CSE-ConnectionGUID: owNsOSTPQru/EP9H7uGOKQ==
X-CSE-MsgGUID: cMsmrMjPT7ifZ0II32tNjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193839543"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:00:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ikepanhc@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, Rong Zhang <i@rong.moe>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105182832.104946-1-i@rong.moe>
References: <20251105182832.104946-1-i@rong.moe>
Subject: Re: [PATCH v2 0/4] platform/x86: ideapad-laptop: Add
 charge_types:Fast (Rapid Charge)
Message-Id: <176277603234.8442.18421634997984069130.b4-ty@linux.intel.com>
Date: Mon, 10 Nov 2025 14:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 06 Nov 2025 02:28:23 +0800, Rong Zhang wrote:

> The GBMD/SBMC interface on recent devices supports Rapid Charge mode
> (charge_types: Fast) in addition to Conservation Mode (charge_types:
> Long_Life).
> 
> Query the GBMD interface on probe to determine if a device supports
> Rapid Charge. If so, expose these two modes while carefully maintaining
> their mutually exclusive state, which aligns with the behavior of
> manufacturer utilities on Windows.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86: ideapad-laptop: Use str_on_off() helper
      commit: 06c129cac01be45e458d37534d1a6ba753cf6f13
[2/4] platform/x86: ideapad-laptop: Protect GBMD/SBMC calls with mutex
      commit: 85901a0d8591ecd756078e57be077f12a0ee78be
[3/4] platform/x86: ideapad-laptop: Support multiple power_supply_ext definitions
      commit: 5c54ece0476638f7c5fc655c655e721286a26bf1
[4/4] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)
      commit: 90430ea98f5585270bc185cee548154d239af8d7

--
 i.


