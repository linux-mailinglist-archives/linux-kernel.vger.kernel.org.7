Return-Path: <linux-kernel+bounces-874471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09489C166A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4758355F91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763F34D4CE;
	Tue, 28 Oct 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zp5tubok"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0629B78D;
	Tue, 28 Oct 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675234; cv=none; b=BetsTZk+/cQkPWuInf9dO9n3arRhdr1I2tWqrlGdO4QivEaXcekWimjYpsWYOwdtQsxsa+8XtUl8wI7aPnkbdjKs/LjT0t5VRajozR8ESZJLFJfWHf7gbFGfiHbM9zISMKeOy7wlm9C4gp8vPSWyfGpHHiYl4cLbeIIFnvruuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675234; c=relaxed/simple;
	bh=ydcqvtv6pl9AvbRH/zswn14QewZaklN115dIzczXlLw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aYgVK3evowt6HPQuuh3lzc2EtNoiz6/NmykIHM82yzwD+k8qbu/HZ8x77OdMK86a9zzBym5rHaNugmj3SUO4S6wHS+PezO/8NKIsnGJ+Zl37DzeIqVe+44dqlZDMBGvPIAMUdfVvz4vWgaqzo8mycEwu+KMtSY+u+ClnQQU6RJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zp5tubok; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761675233; x=1793211233;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ydcqvtv6pl9AvbRH/zswn14QewZaklN115dIzczXlLw=;
  b=Zp5tubokexIjYQ/2lQO7wtpAtFEzHHeZikZ6L+LK0FQgvC0AVPUcayBN
   jDWpRXg48q0wAmWeP8uU7lsod4ca+nCPBnJeXggMHjMSymUaW/6YLp2Lp
   CmehQtk/Fw/S4Zv4RgpA+qE0idgJRpWJUGtBWCSbOdt7KW7CPcXXtI/Uv
   P5MdVCIj44F0UGRpl+g52iwEpC0oySw/oSsVXvxziXQ0D1tIKFtuw8CuX
   2DQXlgZAvgN7mD1viJolSDCM6N2ODGrxo4w0s9KEJ2oZ2a4GGSehK2sED
   nVvjvjtHgJICP0JqevT6L9Kr0KKhzCo+qk8qT89b/5WgMTDjKH43VSOCL
   Q==;
X-CSE-ConnectionGUID: rb3N6JotS/mws3cG9CryTA==
X-CSE-MsgGUID: gjifVBv0S6S/d6OCCa7+Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81416677"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81416677"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 11:13:52 -0700
X-CSE-ConnectionGUID: pauuhUuRT3CzfJ3Juy9zaQ==
X-CSE-MsgGUID: DL+N6KbURzukO/CD/RhFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184602165"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 11:13:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lazar Aleksic <kripticni.dev@gmail.com>
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <20251028180956.10753-1-kripticni.dev@gmail.com>
References: <20251028180956.10753-1-kripticni.dev@gmail.com>
Subject: Re: [PATCH v2] platform: x86: Kconfig: fix minor typo in help for
 WIRELESS_HOTKEY
Message-Id: <176167522483.2247.179631177596031371.b4-ty@linux.intel.com>
Date: Tue, 28 Oct 2025 20:13:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 28 Oct 2025 19:09:05 +0100, Lazar Aleksic wrote:

> Fixed a misspelling of Xiaomi
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform: x86: Kconfig: fix minor typo in help for WIRELESS_HOTKEY
      commit: bd34bf518a5ffeb8eb7c8b9907ba97b606166f7b

--
 i.


