Return-Path: <linux-kernel+bounces-831320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8819B9C587
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4D97A9161
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4D296BC9;
	Wed, 24 Sep 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK6rXpXb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0261B423C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752365; cv=none; b=UIaCzFT3FfPXMv5ALqDVIpvYv+LnELWWKkQLQeJJtKHZ1aDoZQ9wYpLRl3rK8Zlx/K+6x6xlVpJrB8+Z2u3MZBY7GhK2KFgZVKYeYb+fbLzh20ecAbMrEJXnxcX6QzNq7vWphaKRPyhLKG2dxuXaUhFOGMVkFaYtv1pHzi/hly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752365; c=relaxed/simple;
	bh=RJJU0jIt/UKGtJm218exoLMxV9raejaJF7iktshFRhY=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To; b=O7fp3RfmcDt6HzowjZodkRYb+9ayxJFTSSR85TFYFjJOc+R6KLP4/qxV/NivMLH4qWm7OyqtNO4fP6RaNWkJzs8T++qcoy4HuKlhFReEJKtyYFhRN1Ptzuouol/SDPe62jwq8+XV8WVnJeCN/J09OFLySs4l9SzQ7VaIzf5NIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK6rXpXb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758752364; x=1790288364;
  h=message-id:date:mime-version:from:subject:to;
  bh=RJJU0jIt/UKGtJm218exoLMxV9raejaJF7iktshFRhY=;
  b=mK6rXpXb/4vWs+gN/2v5BbFr0RSdM4WCv2CBRxqalxvB/sz3SBkbz8OK
   DJEw2FC/c0tFH3kuck8Nn0HsLLc7J5kdmop3LcrO2yRv5Og9TDj5NIvgb
   yVuaMXzCXVsfyGQeIHX/rWvsOEPPY/oR2X5pacLMJw71Z+LiZz1vYjz/x
   +jHq8aRq5Q918s4jTv0tOzJDrBBG1TZ+Jpi4CRS7Kgqj7y4k62uUWy122
   lcYnwWTQEBe/RCRyq6+wsWda8/+BAFZdAVYbk8etbYtZu8Zg3ALCef3YL
   B+RTLjdP6illXNDJab9eQSFpug3GnZr6Yb4OYMphGGaZ4aCLe2T/nUuaQ
   g==;
X-CSE-ConnectionGUID: kodsC97PRAKAQEGGJ7trRQ==
X-CSE-MsgGUID: qfU9vTXIT4K2v1c9ntwakw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="71307444"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="71307444"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:19:23 -0700
X-CSE-ConnectionGUID: WJl1b5MOSfS211VC7z3PbA==
X-CSE-MsgGUID: ZbFwZfJNRQexExvY6irmIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="182301371"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.235]) ([10.125.108.235])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:19:23 -0700
Content-Type: multipart/mixed; boundary="------------63fe8LkfFRxPYeRQo4n0p8fE"
Message-ID: <fa25d9b0-1ec5-48fb-9249-78754eef6bd2@intel.com>
Date: Wed, 24 Sep 2025 15:19:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Hansen <dave.hansen@intel.com>
Subject: drm/xe: Linker errors on configfs symbols
To: Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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

This is a multi-part message in MIME format.
--------------63fe8LkfFRxPYeRQo4n0p8fE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

With a stock 6.17-rc7 and this config:

	https://hansen.beer/~dave/intel/config.xe.20250924

I'm seeing:

ld: vmlinux.o: in function `check_sw_disable':
.../linux.runme/drivers/gpu/drm/xe/xe_hw_engine.c:812: undefined reference to `xe_configfs_get_engines_allowed'
ld: vmlinux.o: in function `xe_survivability_mode_is_requested':
.../linux.runme/drivers/gpu/drm/xe/xe_survivability_mode.c:228: undefined reference to `xe_configfs_get_survivability_mode'
ld: .../linux.runme/drivers/gpu/drm/xe/xe_survivability_mode.c:233: undefined reference to `xe_configfs_clear_survivability_mode'
ld: vmlinux.o: in function `BSWAP_SHUFB_CTL':
sha1-avx2-asm.o:(.rodata+0x57def0): undefined reference to `xe_configfs_init'
ld: sha1-avx2-asm.o:(.rodata+0x57def8): undefined reference to `xe_configfs_exit'
vmlinux.o:(.debug_info+0x3176eb6): relocation truncated to fit: R_X86_64_32 against `.debug_loclists'

I'm compiling the 'xe' driver in to the kernel and I've got configfs compiled in as a module, which is (I suspect) the reason this slipped through the cracks until now.

In any case, I don't see any Kconfig dependencies for configfs in the xe code. The attached patch at least hacks around the issue for me.

Is there a better way of fixing this?
--------------63fe8LkfFRxPYeRQo4n0p8fE
Content-Type: text/x-patch; charset=UTF-8; name="xe-kconfig.patch"
Content-Disposition: attachment; filename="xe-kconfig.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZS9LY29uZmlnIGIvZHJpdmVycy9ncHUv
ZHJtL3hlL0tjb25maWcKaW5kZXggNzE0ZDU3MDJkZmQ3Li5kMDQ1NDdmYzUzMTEgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS94ZS9LY29uZmlnCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS94ZS9LY29uZmlnCkBAIC00Nyw2ICs0Nyw3IEBAIGNvbmZpZyBEUk1fWEUKIAlzZWxlY3Qg
QVVYSUxJQVJZX0JVUwogCXNlbGVjdCBITU1fTUlSUk9SCiAJc2VsZWN0IFJFR01BUCBpZiBJ
MkMKKwlzZWxlY3QgQ09ORklHRlNfRlMKIAloZWxwCiAJICBEcml2ZXIgZm9yIEludGVsIFhl
MiBzZXJpZXMgR1BVcyBhbmQgbGF0ZXIuIEV4cGVyaW1lbnRhbCBzdXBwb3J0CiAJICBmb3Ig
WGUgc2VyaWVzIGlzIGFsc28gYXZhaWxhYmxlLgo=

--------------63fe8LkfFRxPYeRQo4n0p8fE--

