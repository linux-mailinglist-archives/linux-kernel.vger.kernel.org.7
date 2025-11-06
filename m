Return-Path: <linux-kernel+bounces-888459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A81C3AE07
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B9A4E862F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAB32AAAB;
	Thu,  6 Nov 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1k6kuZ9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C030E0C0;
	Thu,  6 Nov 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431652; cv=none; b=bEdXof+0M4nHgw7RgGMcfqCUzHIzvpr9u8jsIYiIKRymfD2G7F+O5cHz4wFGkH6gOu0ER8tZtlWNmcIMocbbv412p1jd18bTCHJmKuTuy0gtxfXcs0k2ZZZKzenBVDlk0BVr5m17QI4iAV4vRORnLi30kq6UzlGuheX73qK7bRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431652; c=relaxed/simple;
	bh=Ehdwcafh5mxaP5S+PGqr3JnEJUeuqwfYf/112kGr5Q0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tZ2fAE9q5VPISi3YmzfW5fJg1q8uw0MeR+2odW85Un44ImwMUYAz1zZeeHidhReOMKcplQYvGX0XVwNt0zyp1JpdvQyRgMB5gy82vrZRQEAIakA8f7YDCz6yEyjzfiHKuS/1BPC08D4+lOM2opI3myUm5Qm5+fcAEymugwXRhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1k6kuZ9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762431650; x=1793967650;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=Ehdwcafh5mxaP5S+PGqr3JnEJUeuqwfYf/112kGr5Q0=;
  b=T1k6kuZ9r51L29SxbnvCBwdIhDXYxyTTx/D7454de9Ktp9VF1mKorLGX
   uMrD49P0aLWmOQe+qHxtKLul75DHF8HGb+GFD2DzqB28ycDu/Gf2tTNHi
   z9HMbLDkoSdYJVAub8t2yl9zOLMashNMUWeNan/WFRnTixfAodV0JWSNC
   uIyv9xlKIOZoBGAsBKGnaZNztVFEaoVTFc4yXo74ZyOZYaIau4e5GjQH0
   S1ooIJkKs0W1/gpkE+4LvGdKd2C97dARi3+4RPhp/MYn2I5B5ufxfBU86
   vfA2kID/ffLn3SF9jODPAnBpSDa/KiWWdMVPlpCUGqvI2vSr3BtjLdqfy
   Q==;
X-CSE-ConnectionGUID: mGHFoaJWQY2rMabnC79w/g==
X-CSE-MsgGUID: we9Nst1/Qk2QMsP5wD3VBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75916820"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75916820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:20:50 -0800
X-CSE-ConnectionGUID: vTVVDgZmRka0ymoFsYVvUg==
X-CSE-MsgGUID: 0eaqcrS/QMa7KbsJMeQKWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187688589"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:20:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Marcos Vega <marcosmola2@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106115017.77782-1-marcosmola2@gmail.com>
References: <20251106115017.77782-1-marcosmola2@gmail.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan
 support and thermal profile
Message-Id: <176243164304.2946.1841460166696016305.b4-ty@linux.intel.com>
Date: Thu, 06 Nov 2025 14:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 06 Nov 2025 12:50:17 +0100, Marcos Vega wrote:

> New HP Omen laptops follow the same WMI thermal profile as Victus 16-r1000 and 16-s1000.
> 
> Add DMI board 8D41 to omen_thermal_profile_boards as well as victus_s_thermal_profile_boards.
> 
> Tested on: HP Omen MAX 16-ah0xx (8D41)
> Result:
> * RPMs can be read
> * echo 0 | sudo tee /sys/devices/platform/hp-wmi/hwmon/*/pwm1_enable allows the fans to run on max RPM.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add Omen MAX 16-ah0xx fan support and thermal profile
      commit: 836a26660b97c62b1ed734e38a78bd20949dfa22

--
 i.


