Return-Path: <linux-kernel+bounces-784589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A695B33E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F132167257
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555012EA174;
	Mon, 25 Aug 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcvtnzHO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD82D8782;
	Mon, 25 Aug 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121442; cv=none; b=i8UeAqiPL6ITeHohDWZbxu8qv01dUbwKnLxm3nq5ZUGPKmPUt7Ic/hsDaOvteVTtufDx+qN5BzUU1WDeSfDg3XSZkaq+9zHfnQm0Azm1Pj6kpm+bU31DblWEFVo/06377ZKVFj1VgHdfYa2rT7ID2Z9/pL4wy0IH39RxRm8Xys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121442; c=relaxed/simple;
	bh=Sec8KA9l8Vb622XFZIKMLKf9Dg56IzeQGQdTFcGQoj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qP1wwav49mq9jrS7Rclqm/oKI4Csgy1juC9KdqAQ4to/aDnjWrhIgCOKld4oVqryBOVLcS3P8nmfGS3PGdb0tLh1rpXvnue8uZXU+KSmepMX8DyySgxMnjHgNJUGRHooEQGOavNR97onunIwx+VR/qmetSIEWzV2EuvNCwwKbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcvtnzHO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756121442; x=1787657442;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Sec8KA9l8Vb622XFZIKMLKf9Dg56IzeQGQdTFcGQoj0=;
  b=DcvtnzHOHNLYYFLIeBxphX07+3pmAoZxk5szw3aYY3f6CgNU9M6s6d9a
   60wMLaf35z5In3tbgjBP4aHBLp5U2drcEVNUTp8p4SHlwInR0PXh5FWN2
   XByyFCxjYJ5Z8M0rerGInQWguxm4SfExfZWrfT7cofg2aWiahlx8IDv8R
   QXKhLBJjdInU47g7VRp+M5sKnkiZehlTu1Toa5KVyyIMhIPFGWhUpts+8
   B6UpB2FWxvbgBHiODwpZ6S43XOw0fDJvF09wDZimvMYiyLaF1yIgEYGzJ
   8HDv6spO1JLf+atg/ugY8cLkpnmr3T+tFd+2uwnBzO8ufSHLleWcnnOJ+
   g==;
X-CSE-ConnectionGUID: lZOX780fQIGWNCQmb8+V6w==
X-CSE-MsgGUID: wY1C8XlOQI+jFKIIpNGt5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58273605"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58273605"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:30:41 -0700
X-CSE-ConnectionGUID: hxRdr1AcQ7WR98KlUw62qw==
X-CSE-MsgGUID: Td45XEktTUWqP/vg5x0A3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="170101398"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.85])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 04:30:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D . Jones" <luke@ljones.dev>, Mathieu Fenniak <mathieu@fenniak.net>, 
 Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250808154710.8981-1-lkml@antheas.dev>
References: <20250808154710.8981-1-lkml@antheas.dev>
Subject: Re: [PATCH v2 1/2] platform/x86: asus-wmi: Remove extra keys from
 ignore_key_wlan quirk
Message-Id: <175612143487.7176.12842954767446670180.b4-ty@linux.intel.com>
Date: Mon, 25 Aug 2025 14:30:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 08 Aug 2025 17:47:09 +0200, Antheas Kapenekakis wrote:

> Currently, the ignore_key_wlan quirk applies to keycodes 0x5D, 0x5E, and
> 0x5F. However, the relevant code for the Asus Zenbook Duo is only 0x5F.
> Since this code is emitted by other Asus devices, such as from the Z13
> for its ROG button, remove the extra codes before expanding the quirk.
> 
> For the Duo devices, which are the only ones that use this quirk, there
> should be no effect.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk
      commit: cf3940ac737d05c85395f343fe33a3cfcadb47db
[2/2] platform/x86: asus-wmi: Fix ROG button mapping, tablet mode on ASUS ROG Z13
      commit: 132bfcd24925d4d4531a19b87acb8474be82a017

--
 i.


