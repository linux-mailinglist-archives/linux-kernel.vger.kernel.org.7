Return-Path: <linux-kernel+bounces-819530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226EB5A22E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CA77AFE99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D131B820;
	Tue, 16 Sep 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGqHsA13"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CC2DF706
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053709; cv=none; b=DIRzzbsAhT9kh7K/rc6vvzq/82+yXDI7c9hGiVODg98AkBzvycqgPqTvjaqbHUe/l8j5A4GT8muZ8fBFO+cY4SseKnosvRivnfdUtl09QCGEexGWHb/ljMFtXjtbFk1mMdbfjpzkCkb7A8pIuK6JkZPXTeHCadM+ZZbRt1HTJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053709; c=relaxed/simple;
	bh=3iyON+nEaUeayWRu3kFnsphO+ZdJd4jMaHXSYCzOJkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6eCCXEc9uKD75aohSEfK6+AfHSsfqw2E8UxpJOgPUe8HbXpi5bhTwILZVRnQx57hatJ07xH3eerMsUwnTgwOvpkHU+RSlJ88ACX9bym8zUjN5wzAuM6GaUwhA0ZTwf9VLsw0VnKSxNP78VWpcsCFvqnuwmIiMFUsTkDpM8SHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGqHsA13; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758053708; x=1789589708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3iyON+nEaUeayWRu3kFnsphO+ZdJd4jMaHXSYCzOJkI=;
  b=WGqHsA13nSC+N2yUt6WvTh2I10jiG+iQAgp8503pwF3/Jtn+yptvReUn
   hEExe5u9zDyY7a3PSbFWHAo2BZm8idy+cNEo0vwdb0VojzNz6wU1Qt6c5
   0p+xB06jyLrdB9gHrdUUsBoKONvXBFW6E2Mse8EPxgKOCSij7C/qPs8yl
   z7nkSFrzMyeuRng7DTJDGbyRjkXDI0pEp5ejlOdr+7GQu9ozm8n66Ux/1
   S390965tTCnkPYYztB+SfTKDJ3DfWRZqRWKkfm7+RQX8/umrXlhKrhMsE
   8+WI8MLMqp2LH4ohSzLID4ftIIuDrB7EBCi1NIDKRYvRpnD86r/KIZES2
   A==;
X-CSE-ConnectionGUID: iVqmD9FoQ8CyFFGDpSTExg==
X-CSE-MsgGUID: 8S5xNq+dSaOtiO59Af+Fsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="82944087"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="82944087"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 13:15:07 -0700
X-CSE-ConnectionGUID: 6YZwoslXTCyFHRiasq2UyQ==
X-CSE-MsgGUID: v43ZYwt0TBakltTpP7G/+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174853461"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 13:15:07 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Yang Li <yang.lee@linux.alibaba.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] drm/xe: Remove duplicate header files
Date: Tue, 16 Sep 2025 13:14:46 -0700
Message-ID: <175805362854.2339703.13765857337956924451.b4-ty@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250916021039.1632766-1-yang.lee@linux.alibaba.com>
References: <20250916021039.1632766-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 16 Sep 2025 10:10:39 +0800, Yang Li wrote:
> ./drivers/gpu/drm/xe/xe_tlb_inval.c: xe_tlb_inval.h is included more than once.
> ./drivers/gpu/drm/xe/xe_pt.c: xe_tlb_inval_job.h is included more than once.
> 
> 

I did some minor tweaks in the commit message and applied to
drm-xe-next. Thanks.

[1/1] drm/xe: Remove duplicate header files
      commit: 9e6eb49ec13936461c697348c74e5450ac82707d

-- 
Lucas De Marchi


