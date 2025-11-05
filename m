Return-Path: <linux-kernel+bounces-886443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B51C35A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3546C34DA45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA203314A82;
	Wed,  5 Nov 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlM9F9Jo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86651314A74;
	Wed,  5 Nov 2025 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345462; cv=none; b=dZOYSjEAj6e7xPFxJZpX0wLDWZ4cz3lDJL0clh232cchDac9RpnV3mSnDkbfPT8o/UwYzn2CLjwXq4WQmibBxHe2dMlTXA5GhHu4lJRbA7TPHN0b2BqG2wYa3QvVGL5WcSZyKU0mHIbJ133qVzuNxymZGDcb98P3gmvitFwUd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345462; c=relaxed/simple;
	bh=al7yMIgLADiVlfSyynNRArD4vKHqdanIFECom8jaE98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YLlZU+zwtMVHkgddvmHAU9AaKcr4wqX5/dPTogKONiye/hkO48YYTNbrRVG8RTd2vd9dXbevy+JNLA8BdNvGeESmhRfAWGGTyH6ziP35P/Yi3PKyGSw80S+y8MyCSdp2EEj5yk1d5sCZsOF/IIVbfbixz1oNbiH/lzflGdcJzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlM9F9Jo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345460; x=1793881460;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=al7yMIgLADiVlfSyynNRArD4vKHqdanIFECom8jaE98=;
  b=dlM9F9JoUVq/KCmYrY50U/SJQkx/zbiVS646loYL/lWwnfoaHFNUn7Sr
   vDVYDACqzpsFRydeQqfRoGvdcPBPDxgJYh8tu4obKDTDlARVZ8OKwqsn9
   Hx0do/ufSWNDUiCter4ZvQtKiNaOa9kSpSe3j5PE3zZ7FP1tojBwAQynq
   YcXAlUmVcKj56wi67658X8SNix7fVYKeJPP0voN96/cVr7VDOTHcQsLjK
   N+KuPlhUndt643zit1q60vZo1Vhmk4KbgpYQXlZysq8XPf0WFmYAID+xK
   5obhIvz1ChciJf0whape192gaGe8fUPpAqk0iRl4FjmTdQZ5wG71tpfKu
   g==;
X-CSE-ConnectionGUID: Plj/3VrbSXugm4QA27Xh+w==
X-CSE-MsgGUID: V7FrNvpdSBePq+s1iaOXGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75808565"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75808565"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:19 -0800
X-CSE-ConnectionGUID: UliKhVWsSKil5a1BMz0+NQ==
X-CSE-MsgGUID: 0AXhWxSHSxqx3BVZosQFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187392209"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:24:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 platform-driver-x86@vger.kernel.org, Hans de Goede <hansg@kernel.org>
In-Reply-To: <20251023194615.180824-1-rdunlap@infradead.org>
References: <20251023194615.180824-1-rdunlap@infradead.org>
Subject: Re: [PATCH] platform/x86: ISST: isst_if.h: fix all kernel-doc
 warnings
Message-Id: <176234545138.15175.10493844659907728249.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:24:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 23 Oct 2025 12:46:14 -0700, Randy Dunlap wrote:

> Fix all kernel-doc warnings in <uapi/linux/isst_if.h>:
> 
> - don't use "[]" in the variable name in kernel-doc
> - add a few missing entries
> - change "power_domain" to "power_domain_id" in kernel-doc to match
>   the struct member name
> - add a leading '@' on a few existing kernel-doc lines
> - use '_' instead of '-' in struct member names
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ISST: isst_if.h: fix all kernel-doc warnings
      commit: 16f65d215810138a70cf223696312c8127982cbf

--
 i.


