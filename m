Return-Path: <linux-kernel+bounces-886441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3AC359FB
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401F618929AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B90314A69;
	Wed,  5 Nov 2025 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja36Suw5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1A314B6D;
	Wed,  5 Nov 2025 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345438; cv=none; b=ihrwF0inDwCdt451gYB7r9ZSMr5BVWAF3Bkxrj1VQ0ZUEP4n8coGLxKNN/X0u6uHYN7dseZ2haz4FBGqzCsqzQfgW+EV2tVLBhURTFubkvigssdYXf5Xw1jij3vlCUd6oCMr6TiTlAI80Tb+Tx+jOIjJUhF3B92OzaL4C4Jh7eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345438; c=relaxed/simple;
	bh=K45FDEGHuDds+sK0sB9xr3fr8z590mTZYrbbzbs2+jM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NXfZEJH7/eKr4wzt0BSbUHlap+IkeQCcjXuiK9Xpy56Ei8kyiwhbjJjbkBYKhI2wrVsMtDaiSNvJLyAxkxdCxGE6QGEALMVgOwsMIlls5uE0X/yI0uVHNzWVprqumXsPBtO7W1KwypbCspIqcH9LZ2kUfU3dgvWxXbJLkjREDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja36Suw5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345437; x=1793881437;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=K45FDEGHuDds+sK0sB9xr3fr8z590mTZYrbbzbs2+jM=;
  b=ja36Suw5enRntrmh3kOLGIN4KIA8g0su76xSto+iner/nJNbGrSLdANO
   H0xeXFCv313Bz3icqqFjhsyNW5H0EKpHI3WsrO93lnhNzn1pVc3K+jBD1
   7yK5i7czUlUjVs78l575HUmAC6ogjcQZX6kYkui4PaoEWCmuYaw++1BiP
   3A9k33CnF4T9TSMynkuAHZZWcLmAT5LJ7tt2DaJf6Dc5/lvyPGR11V1cf
   ZuM7iSqDTE63T/4GrC8KeRYC61GAQMjIueCzyd6cD7eI2+dlIa5GlsCXz
   geTxMQfvU8G3SJaGvWf5BRXOupmxlqBaCtjx1dUbzx2pEcDN4SNyU+ITF
   w==;
X-CSE-ConnectionGUID: eySP0wSwRHmzxnUgYkWADw==
X-CSE-MsgGUID: uK36bLiTTg2az7EmHZ84Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75138601"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75138601"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:23:56 -0800
X-CSE-ConnectionGUID: NVS8kj2yRlusNQFoBGbUzg==
X-CSE-MsgGUID: Ly7bMqMVQoeI9dIqfTQsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186729327"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:23:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Jia Ston <ston.jia@outlook.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251029051804.220111-1-ston.jia@outlook.com>
References: <20251016102137.92110-2-ston.jia@outlook.com>
 <20251029051804.220111-1-ston.jia@outlook.com>
Subject: Re: [Resend PATCH v4] platform/x86: huawei-wmi: add keys for HONOR
 models
Message-Id: <176234542889.15175.4251133460259665802.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 29 Oct 2025 05:18:38 +0000, Jia Ston wrote:

> HONOR MagicBook X16/X14 models produced in 2025 cannot use
> the Print Screen and YOYO keys properly, with the system
> reporting them as unknown key presses (codes: 0x028b and 0x028e).
> 
> To resolve this, the key_entry is added for both the
> HONOR Print Screen key and the HONOR YOYO key, ensuring
> they function correctly on these models.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: huawei-wmi: add keys for HONOR models
      commit: 6eee991995b16a1b0a266ce9081fa130f82f98ff
[1/1] platform/x86: huawei-wmi: add keys for HONOR models
      commit: 6eee991995b16a1b0a266ce9081fa130f82f98ff

--
 i.


