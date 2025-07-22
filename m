Return-Path: <linux-kernel+bounces-741152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E5B0E0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB02BAC1767
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC61D27934A;
	Tue, 22 Jul 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQmgkO6g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79925C833;
	Tue, 22 Jul 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198748; cv=none; b=eXccJplFDjhtPMuSKnQ7Spwo8pJBROJ36ccR/iYqcgFccS9XntbLm6kJtYkYJZHD8caZGzcoxoPY3FjO4hflZs3G1SZpOA8biS3rAUlmed2fcY4vgrzKi44MitIiNckE8WXpmlOFPtq182pNC2v5Z+iwNzTXeoYQm9yNpQmHgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198748; c=relaxed/simple;
	bh=L1qIlieTBeJjLKSC5FnO3Bi7aA/JmO6/0ewBKzSFvjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QrOSxsnTdcgagxxrukmJIqHw797xGlzXGKRXDMZJIdFHykR5Mb93WdbUjgQHKBBt0IqtCHroYx+6ulwC00A+lEuNS9DqwvBd6KpO7UMxMIMOIVlGO5LfmKc32hYuUYm7ZBxgwIc1K4E+xeYGV0wJ10V8exKbxQ7gfoN7xGUkJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQmgkO6g; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753198747; x=1784734747;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=L1qIlieTBeJjLKSC5FnO3Bi7aA/JmO6/0ewBKzSFvjg=;
  b=AQmgkO6ggsvnZrfQNrjs03oIuwSP/RPu73yKSDr0jQoU7Ytw21sTy0k2
   IO/19gybix2fFOjNHBqCUi0C/79ScT/133l1zdmRvfXNNNbGODlXWdomo
   +2Az/+sEGbypPWpBT6gssafZtQlwqrlpH3I9sNu3Si2LDEwbF+c8njheK
   oARyJvnMKcCEUxJtO7b5BEiDOGGe5dtAM4t+zyD6exSQhUNSXNgXvO9kG
   J+9+45/eYGtJJpx0JTX6M1Olv2QfsJ3NlHdXNRv3dttFqc5jnMyHGongf
   ndDNln2BRii5xa1RLSc473tpGmjAmQflIDLJMmQyPk8czkpSeKv6RmNNG
   g==;
X-CSE-ConnectionGUID: Qw1hEQUbTAOGS5vknMuZsg==
X-CSE-MsgGUID: Y9dYjJB6RUGbRcH4/narIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55336927"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55336927"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:39:07 -0700
X-CSE-ConnectionGUID: KcsF1a1LRQaJf2IO32Mehg==
X-CSE-MsgGUID: a8HZiMMGQ4Gua8iYk0ip3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="159229404"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:39:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, 
 Derek John Clark <derekjohn.clark@gmail.com>, 
 =?utf-8?q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
 Eileen <eileen@one-netbook.com>, Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250718163305.159232-1-lkml@antheas.dev>
References: <20250718163305.159232-1-lkml@antheas.dev>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Fix turbo register for G1
 AMD
Message-Id: <175319873747.17914.9743576512932520356.b4-ty@linux.intel.com>
Date: Tue, 22 Jul 2025 18:38:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 18 Jul 2025 18:33:04 +0200, Antheas Kapenekakis wrote:

> Turns out that the AMD variant of the G1 uses different turbo registers
> than the Intel variant. Differentiate them and apply the correct ones
> to the AMD variant.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: oxpec: Fix turbo register for G1 AMD
      commit: 232b41d3c2ce8cf4641a174416676458bf0de5b2
[2/2] platform/x86: oxpec: Add support for OneXPlayer X1 Mini Pro (Strix Point)
      commit: 1798561befd8be1e52feb54f850efcab5a595f43

--
 i.


