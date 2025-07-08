Return-Path: <linux-kernel+bounces-721370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F17AFC849
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5EEE7A5F07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CDC269885;
	Tue,  8 Jul 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR7J9s/H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA521767A;
	Tue,  8 Jul 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970280; cv=none; b=ZtHd1+XpteFc/jfys07uJ0fxIxCZibS7vEYXm6UMf6jfRjR9xW/baw5ldi7Y5PN6LuYN9cmChHLT2RIktFkUw0eU8rPfo3l1Iu9C9urmvRVkldflmC66Qd2QzgA83KxntOIU4xKjq268NGhcUFDTw19lHiXH6K7cV7Dl9v971so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970280; c=relaxed/simple;
	bh=fPSbu8vL5+Dw3tHz+Tecc1OC52fP/N4M5CX40o9kUxM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=crwT1MGqzGdyIM4dAjt8KHECZY9l6Kjybs6D9PETzjWo78FyMp+YMUAfsoLrsBBjxkh5NQh1kQstl7vnm0SHw2YdbujwFsmqqgvWzot/R+nvrSqUb9euD6JukVmRY4dbyaJ2S+xPO2XHM9quqQOKGSA2tpR5/XjTkyHgt3NwRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR7J9s/H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751970279; x=1783506279;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=fPSbu8vL5+Dw3tHz+Tecc1OC52fP/N4M5CX40o9kUxM=;
  b=dR7J9s/H3rcFlnaSWb7Iy7icuFbXR1MjY2sy/3Nne/8jS44RNXCjuUUH
   wrO49oh6xVLe65L8MtJAneEQsJPWeVt9Jnq68ZmA+BWV0FxabWICel/nn
   4lWuthMaioSLTAEUM3THJ6FxVF1w1S7EWfXKXRj3rWND5Qm68bQBKyZ/1
   wqEbYQuNoou8ENjEh2yqtaYetagxIEKysgUmwZSlPOpBTyCE+3ZiH+LQg
   mGGBfwlMgZTyQVof/9Pmzx4xYubJ8JJrNhoFb4lWwbGCNRtA6eAa25BC5
   iMpMWPAFCanYARjyqOK6CEcDUMfG9+u0OZZSStyi2CgWeFA/Fzj9DSIuS
   A==;
X-CSE-ConnectionGUID: jzyL8AQzSe2mMpwPWTqx/A==
X-CSE-MsgGUID: yH5XcGWoTAaY0lzgs1/C7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56814764"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="56814764"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:24:35 -0700
X-CSE-ConnectionGUID: 7d7wOVTzRFyA2tJKQhaOIA==
X-CSE-MsgGUID: 5EJskkxSR7m30vWQLU1baQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="159791390"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 03:24:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Rong Zhang <i@rong.moe>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gergo Koteles <soyer@irl.hu>, 
 =?utf-8?q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
In-Reply-To: <20250707163808.155876-1-i@rong.moe>
References: <20250707163808.155876-1-i@rong.moe>
Subject: Re: [PATCH 0/2] platform/x86: ideapad-laptop: Fix FnLock & kbd
 backlight not remembered among boots
Message-Id: <175197026643.1629.1219841831747579403.b4-ty@linux.intel.com>
Date: Tue, 08 Jul 2025 13:24:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 08 Jul 2025 00:38:05 +0800, Rong Zhang wrote:

> I had disabled ideapad-laptop for a long time until a critical bug was
> fixed[1], and I soon noticed some behavior changes after reenabling
> ideapad-laptop.
> 
> The behavior changes are about FnLock and keyboard backlight. The HW/FW
> can remember their states among boots[2]. After enabling ideapad-laptop,
> I noticed that their states were always reset to off after a reboot or a
> power cycle.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
      commit: 9533b789df7e8d273543a5991aec92447be043d7
[2/2] platform/x86: ideapad-laptop: Fix kbd backlight not remembered among boots
      commit: e10981075adce203eac0be866389309eeb8ef11e

--
 i.


