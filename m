Return-Path: <linux-kernel+bounces-797992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41CAB41821
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2991B23409
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342F2E8B77;
	Wed,  3 Sep 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iInr5tnp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05E2D8DBD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887260; cv=none; b=sugki8+K6TElC/FMy5sCuvt8by6n46D3WdyCBIAArohyFq8La2pLfDSc7/DFJ6AZgH8usE3N0kPwVvDfWFsm2qQQF6UW6/VfX56vGU8aVnhnCAUGvh5/Z98y2md/88h80DtdG08L0Y+EcelR8N4YaaKvhQVeI1GAWzMDmrw6SV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887260; c=relaxed/simple;
	bh=345DC5ZaqJjLp1Q0CVLEX8qaZ0OvPG+3gbocYVwDZMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuIGGX5YXOjoRvMMCxAiVQdfMKe6usAsJaf2JoffaFM75yYcfheCji+xVjeE+yP3tCUpmFKQ9VDdJAT/DgLAesC90q6vvgXOVqyOJNPzJqSQ/XCh2yleh0sLij0cZq7ywlRfjF+SJIHL8T2JYP0tjuClnRiHeH6/ufo0ykH8DuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iInr5tnp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756887259; x=1788423259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=345DC5ZaqJjLp1Q0CVLEX8qaZ0OvPG+3gbocYVwDZMg=;
  b=iInr5tnpgHdkpo3US5VDvNeukKidK/L7SxVsmWVgEgMWKaqD2/EBXysF
   tNM4XtMVHpnXcSFJF2iL3SXgdP3dnCwgevqWyxXaa1+vTHlqj+Tnoq1tU
   qOngaOBuowuTQyKLfobf5KYyb1k67Ul/k/tOpoK3aAxvyLguNnNY1QIkP
   gV/2ikHvB4ThX5ucwNBU5SyAF54zAnuAhrcAr6NOkL37nu0w3gAyrG/3D
   WN3IOwhsOKs0/hLtkcBwR+XgLPu6hnHbmfk1CfMSlZJzMPcjFSiUlabmg
   6S1wLEmHhp9SDqAn1bzUE+SJpUzYmehg8zt0wExw6fdp7dYh27qFj2VxE
   Q==;
X-CSE-ConnectionGUID: uNqDIvJERWifcH1DhwgxHw==
X-CSE-MsgGUID: l8QyDQ9mQdy1u8q0YonQbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70569906"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70569906"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:14:18 -0700
X-CSE-ConnectionGUID: y4eYv2l0Q5qw6UUmgHBaUg==
X-CSE-MsgGUID: RCrimchfSMuXCXrmoaJKLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171675886"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 03 Sep 2025 01:14:17 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BE2DC95; Wed, 03 Sep 2025 10:14:15 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/2] resource: Introduce resource_rebase() helper
Date: Wed,  3 Sep 2025 10:12:28 +0200
Message-ID: <20250903081414.1972179-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper to add an offset to the resource. This is helpful
in the cases when, for example) the resource has statically defined
the start and end fields, but the base of it is yet to be defined,
usually dynamically at run-time.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..159e74284d0b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -290,6 +290,12 @@ static inline resource_size_t resource_size(const struct resource *res)
 {
 	return res->end - res->start + 1;
 }
+
+static inline void resource_rebase(struct resource *res, resource_size_t start)
+{
+	resource_set_range(res, start + res->start, resource_size(res));
+}
+
 static inline unsigned long resource_type(const struct resource *res)
 {
 	return res->flags & IORESOURCE_TYPE_BITS;
-- 
2.50.1


