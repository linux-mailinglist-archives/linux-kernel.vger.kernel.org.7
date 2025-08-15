Return-Path: <linux-kernel+bounces-770437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944BFB27AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CC6AE3523
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CE529B78C;
	Fri, 15 Aug 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXrB35I7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D6F245031
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245595; cv=none; b=hs3ASr49l5t9RST7sbZD/hEBS/7g3Xbt4RUjw7HU+qSN3ywIjGk7P3IDoPhlpB3fgDhiccwU4ZD+bSa+AdLx86NWb93DRysHvdDzsWbj8hp7+lVPx1+9+3ZLJY/yFJpMp5ydUqqD4NNYk9PBRHkUnj2l2zhYbO53H5Zh15KE810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245595; c=relaxed/simple;
	bh=CfUlkHevcJg6532LhLuN1OeyloSvHqIr3YcBdRPxSm0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjDWFGk1HPjyh9P2iUrTtO5qLf3D1r8AQUFaYiVO7dlnMDa9pmXnWOUKogOaZT63j4CvCPyJnuiuyqorU0A16Wk3+Wv/F9yNWBBGqBF973fzyKhaGwEhK1JlLYPEsq1SS8cNUjBBmDxs2+L7yzKOZyzJx2xybRQYaYN/qJeC19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXrB35I7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755245593; x=1786781593;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding;
  bh=CfUlkHevcJg6532LhLuN1OeyloSvHqIr3YcBdRPxSm0=;
  b=FXrB35I7iXxDsarcI9r3LBFhQ9lKJdfabDPuoI9rWPnBrgffZW+WhocV
   Eup3j5F9Tbxj0CiNa37155/VhvfBzZU9WPo2EQMjgXP8sOW1KrR+vs3ET
   305628fekI15WfuspeOLLM2nhZDQ73nnCXo9qA2T2SzC2/HrC7/KdQL0r
   cMxSsRJcDxCsSfHQV6vQErC0/XhrvKzm9hgzLTNmJP2tmyg1NmCBTxxWy
   nQym+z0tAl8t5psFhqUgPrdFYI8XdvK84j96v16Qnz4IADp/kBSjdVEAA
   IQuEyINbBK/eqvF+A/RAj76R5us+xMBUKN9Lrxc1RGQNNFA60MoFVtfuJ
   Q==;
X-CSE-ConnectionGUID: lxinYAkrRAOUbAjeTYUstQ==
X-CSE-MsgGUID: l7Cu9CL0TjacpqwuIgx7AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61375571"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61375571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:13:13 -0700
X-CSE-ConnectionGUID: 0/kQrM0+RkGSA7tZNtpTNw==
X-CSE-MsgGUID: +Qfm5rT9TYyh/KAZhA8v0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167780022"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.142])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:13:10 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "David C. Manuelda" <stormbyte@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: Proposal: Make CONFIG_DRM_TTM_HELPER a user-configurable option
In-Reply-To: <51e650f7-39f3-4e06-a3ed-9941e0ccb0c0@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <51e650f7-39f3-4e06-a3ed-9941e0ccb0c0@gmail.com>
Date: Fri, 15 Aug 2025 11:13:07 +0300
Message-ID: <d78f5ee29decaf595363baf93e0b184e0a7a3177@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025, "David C. Manuelda" <stormbyte@gmail.com> wrote:
> Hi all,
>
> I'm working with external DRM drivers (such as NVIDIA's proprietary=20
> module), and I've noticed that `CONFIG_DRM_TTM_HELPER` is currently not=20
> user-selectable=E2=80=94it gets pulled in only when enabling other driver=
s like=20
> `nouveau`, `amdgpu`, etc.
>
> This creates a situation where, in order to build support for external=20
> drivers that depend on `DRM_TTM_HELPER`, one must also enable unrelated=20
> DRM drivers, which may not be desired in certain setups.
>
> In my humble opinion, it would be beneficial to make `DRM_TTM_HELPER` a=20
> directly selectable option in `menuconfig`. This would allow users to=20
> enable it independently, without dragging in other drivers.

You can either enable it in your .config directly, or add "select
DRM_TTM_HELPER" in the out-of-tree module.

IMO convenience for out-of-tree modules is not really a consideration,
because adding new user selectable kconfig options is an inconvenience
for in-tree users.

BR,
Jani.

--=20
Jani Nikula, Intel

