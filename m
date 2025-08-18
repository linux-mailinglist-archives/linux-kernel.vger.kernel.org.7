Return-Path: <linux-kernel+bounces-774174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19326B2AF76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1E91962EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B23570C6;
	Mon, 18 Aug 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjFGOHMR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657B343D89
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538392; cv=none; b=OFxj/qVmK2WKK7IZW4SLIndBMSU1gq3tV6KI1IwQs2dwIzBMDOOMbmygenrO02eKqyNsNx9cXMQNXvHOIshwSSzz2wHZLc5MQ752OHBfjrY2+tjoviZxmVnZ9Pu72xVw+V1SPVcPUE3eYc3GhYursSKO8n9/hTlK46Ast/VB8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538392; c=relaxed/simple;
	bh=J7LqyvkWkUvqJQb3l/i1q0ZlM9WXi8+q8i+jLoNgf8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9K9wSGbhXxvo845gCzXuFbGe9bB4Joh8TG17nZVE+N1WmvWnfjQVwDv2IN+fwkvmqh+rKaURR0afPK9XWFNXn4/xKPBz3qZIO5g8qM42Rme0BiJ2C7t0bX/MVNAHTXTZMC2DrWmU1kZdFT26zXIxRoYNWlQWbEHnwNWyJkoHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjFGOHMR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755538391; x=1787074391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J7LqyvkWkUvqJQb3l/i1q0ZlM9WXi8+q8i+jLoNgf8c=;
  b=AjFGOHMRNPicjuXyfgHjd4ad2U0ATHkLJ6xT0LhoZNfO4wO3nQ9lwoTT
   6EUXTX4bsrBaGsDVa84FgfMgiOIRAdG5dBfcCH/dAAOqhyY3Bz6MlJCl1
   UduaFty0YWfJPPPZqXHX68RO/mu0F/M1mtvR/ubg+FyRu0y+CoDOfX0nD
   TamQgp/2FnLv9Hfk4jocyIFNzpaYVTAm/BzmpEtfHS58q/836fiMe42rj
   6GaKel2dQ7sECGYAPRt8p7m2/lAQdZarjGeYErvu+GtjAAA08EYL7qGSG
   qP/AI8QNy555SaD8FVQDXpFI3vjeY8hHImSiQQHud73+qqnJUPTDL+0pb
   A==;
X-CSE-ConnectionGUID: 2KblqEpaQR20sgiHCR4eEA==
X-CSE-MsgGUID: b1InxJ8oSJ+Tw58flOJuyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57698961"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57698961"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:33:10 -0700
X-CSE-ConnectionGUID: QldLS/1fQV6NMIo79B5hTQ==
X-CSE-MsgGUID: RmLVfJzKT1mPl4MY2EPHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172838175"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:33:09 -0700
Date: Mon, 18 Aug 2025 10:33:02 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: lirongqing <lirongqing@baidu.com>
Cc: tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
	jpoimboe@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, david.kaplan@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/bugs: Fix GDS mitigation select for
 non-ARCH_CAP_GDS_CTRL CPUs
Message-ID: <20250818173302.33x5qvvw3mjmnixn@desk>
References: <20250816001905.2270-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816001905.2270-1-lirongqing@baidu.com>

On Sat, Aug 16, 2025 at 08:19:05AM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The current GDS mitigation logic incorrectly returns early when
> ARCH_CAP_GDS_CTRL is not present, which leads to two problems:

... not present? or the attack vector mitigation is turned off?

> 1. CPUs without ARCH_CAP_GDS_CTRL support are incorrectly marked with
>    GDS_MITIGATION_OFF when they should be marked as
>    GDS_MITIGATION_UCODE_NEEDED.
> 
> 2. The mitigation state checks and locking verification that follow are
>    skipped, which means:
>    - fail to detect if the mitigation was locked
>    - miss the warning when trying to disable a locked mitigation
> 
> Remove the early return to ensure proper mitigation state handling. This
> allows:
> - Proper mitigation classification for non-ARCH_CAP_GDS_CTRL CPUs
> - Complete mitigation state verification
> 
> The change fixes the following runtime issues observed:
> 
> [    2.809147] unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000010) at rIP: 0xffffffffb34527b8 (update_gds_msr+0x38/0xe0)
> [    2.809147] Call Trace:
> [    2.809147]  <TASK>
> [    2.809147]  identify_secondary_cpu+0x72/0x90
> [    2.809147]  start_secondary+0x7a/0x140
> [    2.809147]  common_startup_64+0x13e/0x141
> [    2.809147]  </TASK>
> [    2.809147] ------------[ cut here ]------------
> [    2.809147] WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/bugs.c:1053 update_gds_msr+0x9b/0xe0
> 
> Fixes: 8c7261abcb7ad ("x86/bugs: Add attack vector controls for GDS")
> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

