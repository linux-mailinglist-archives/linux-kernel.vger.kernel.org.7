Return-Path: <linux-kernel+bounces-886445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26677C35A25
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86403466575
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BBC314B94;
	Wed,  5 Nov 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAgbbUoh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E130FF24;
	Wed,  5 Nov 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345479; cv=none; b=dn4ZDad6Y3g2UGaMxQrn/O089OqTKSoARSzuIf/Wbuv+e5DOAhNotWGeBmcW4FTSyUbu6IW65t8VK0a/7I2Mki61MxcISwPZAXf3jC8vnre4ZufaVPLtIFyIysi88HejRx5jRWS0fGj8WX+6/CVMic8AZFQCDTBFTzMKe3qUC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345479; c=relaxed/simple;
	bh=0B1jhChxD6ZKpJ6Tuobc4Zvkfa6EY5vmp0IHl/3uNNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i0Psa5SHnQoh78A7KsFLuGin82/MoPL5PE1FiRdi33PNXQCguU9gPsfbwsYYxNBHPxfBRZjx9x3UhRzZMEHBG5WM+D3WCYK1zOJCOsAnIJUYMTwPMtvKH7drYhM72ZM39A2keSPeZbGaVVOwXAZC3rfwFc+H3JN4rTlC+t49FTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAgbbUoh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345479; x=1793881479;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=0B1jhChxD6ZKpJ6Tuobc4Zvkfa6EY5vmp0IHl/3uNNo=;
  b=oAgbbUohoHGqdEY2+3DPUOF+LaTqXyUIXeiXfP3uL8p5Xy0P9DlQqhEZ
   rR3ZShuThWun6vzMkzZrxLz2PgDgqKCm+sAWaJvgbEdIlqJU8IA+kfKGn
   p4o7e3uFvlKi1/u2tCxz6QQfUHittVuNErwWjQxSA/X7OkiBvJKlGfwN/
   bYI2myzIsEOnvnQqqrnJdeN8ClNw1lLj3r8wLJju9gYUQL/yWQPESQx3r
   1bWdflDPBfpVibtOop+uAXMJwH8ZDsOE2uYCvn6Zkodi7PkK+ENmjW6fm
   M6+xGa6Ux/AI7KGwpwFy7I5pNI1884+36yaplsq/0GTZwQ2sn4CWqmc+7
   A==;
X-CSE-ConnectionGUID: YHSyyagkR0eOCjTqnwsMjA==
X-CSE-MsgGUID: e/Y89sRWT06dSDVsqAmCgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="87086409"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="87086409"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:38 -0800
X-CSE-ConnectionGUID: hrEdSF8sSEOfh4uQ5YiACw==
X-CSE-MsgGUID: Y8SSPBRqR+KSkimI4DZj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="192610893"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, Antheas Kapenekakis <lkml@antheas.dev>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
In-Reply-To: <20251024152152.3981721-1-lkml@antheas.dev>
References: <20251024152152.3981721-1-lkml@antheas.dev>
Subject: Re: [PATCH v1 0/3] platform/x86/amd: Add S0ix support to the Xbox
 Ally
Message-Id: <176234546849.15175.7746615027448740430.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 24 Oct 2025 17:21:49 +0200, Antheas Kapenekakis wrote:

> The Xbox Ally features a Van Gogh SoC that on the Steam Deck uses S3.
> Therefore, kernel support for S0ix was previously absent. Introduce
> this support in three patches:
> 
> 1) Add Van Gogh to AMD PMC driver
> 2) Enable spurious_8042 quirk, as it is common in those generations
> 3) Adjust the Van Gogh init logic to avoid powering down the rlc
>    and tweak post init
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86/amd/pmc: Add support for Van Gogh SoC
      commit: a400f448c1ad5e22e7ec1700e911f8f9c6a85475
[2/3] platform/x86/amd/pmc: Add spurious_8042 to Xbox Ally
      commit: 50cb52ee1dd60247746a984392632ec4237df127
[3/3] drm/amdgpu: only send the SMU RLC notification on S3
      (no commit info)

--
 i.


