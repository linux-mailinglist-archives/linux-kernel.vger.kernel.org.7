Return-Path: <linux-kernel+bounces-893344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C9EC471FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CB6B4EC5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E63126BD;
	Mon, 10 Nov 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqbrH6t1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D7A1F30BB;
	Mon, 10 Nov 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784174; cv=none; b=bhvLdSRxkA1wmZkI0XxNypeoVCzapK3g0W7oyUMWV4QJUr1urVuZy5/02K/UCeryCeiASyaT6pfjYGFRl5zM4fBzujSRYYi5jdnjQPDRGJ/RPI5Fn+BdBhVBXBD8Uuh587YZMtPNEpAvvmcppqJ6gISqZIoOb3Gt2VyFOtpYTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784174; c=relaxed/simple;
	bh=8R3t8TYQCB3Hxiair/ZjL7WRux4smJ3M28+EDm4B/g8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mMkncBke+r1cgipkQceEBdm5F9aSS2EAo+3/TumU5PaR/TGp6hf5RHOAHmYq+h5hHgKqRuM0hmsiHwimle+cVqXSDUZRBfBxjh2Hgvhsiid1+6bYsdMcLYaUy3sBr8s52HxkoAeSc8qyZWehIAxABByiR6zi1ZAuRYI7ebS6pEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqbrH6t1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762784173; x=1794320173;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=8R3t8TYQCB3Hxiair/ZjL7WRux4smJ3M28+EDm4B/g8=;
  b=ZqbrH6t1TuUQzuG4CsFyYMVC8J8zBv/rKSAypEkm9I+LPH6rluh69NW/
   IzpoyUK9CgnUDFFtptUmGRLqtC8vZAQBwTo02qxXmTYWeBHfcw8cuqETq
   4QcokIhqgUzOqRHVT5YG7uNbo8W6DpQBmE5/+VlgQXiOxgmNYtlU0flBm
   gRkc/Ake+AMjL6ZPlDonQP29paZDfFMdfDhcIoFf3EZsd0ET3rn3RgP+h
   Sck3bcOjbVW+VHSyUZtng5VTzmkDfs4D5+jfwufBALsZ4IfOUz3XHUx82
   G1IsQa3ZW0WxUQO0bEdLKu27Gj4Au2KL5s63bbDdiRi2HginQR9CApYVq
   g==;
X-CSE-ConnectionGUID: 9J7cpOEQRSeRbuCGPjlPaQ==
X-CSE-MsgGUID: MfnDaxbYR5S5g1RWx3IAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64921293"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64921293"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:16:12 -0800
X-CSE-ConnectionGUID: vjEvejHWSbOaNt5h5jBX/w==
X-CSE-MsgGUID: /i2yjnoHTrasTVr014pIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188519151"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 06:16:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251103-aw-gmode-v1-1-eba7b7be0a9c@gmail.com>
References: <20251103-aw-gmode-v1-1-eba7b7be0a9c@gmail.com>
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Simplify FW profile
 to pprof matching
Message-Id: <176278416431.9227.13656609050630747518.b4-ty@linux.intel.com>
Date: Mon, 10 Nov 2025 16:16:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 03 Nov 2025 21:12:46 -0500, Kurt Borja wrote:

> Drop profile matching micro-optimizations to improve readability and
> long-term maintainability.
> 
> Additionally, is_awcc_thermal_profile_id is implicitly ignoring the
> AWCC_PROFILE_SPECIAL_GMODE ID. State this explicitly with code and a
> comment.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alienware-wmi-wmax: Simplify FW profile to pprof matching
      commit: ff49362eca17114bf36240f7531c2060127778d1

--
 i.


