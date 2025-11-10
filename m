Return-Path: <linux-kernel+bounces-893777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E787C4855B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AF2234A918
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7362BEFF1;
	Mon, 10 Nov 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMRITlWF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224829BDB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795775; cv=none; b=gudPXkK5JU+r/RX33xiEBkjOZK//SWXL6l2JB21lqvj4vxUvTux0tUgSHicujyuVAWYP3l1PuRDRCiA18LlHX7scZnxNAhXIs/808DTtHCONmj7Yx5zWBGQhZSCyRSKP5ZOt8PBr0XK+bvDcJTIUFEsNTC1+8TTPk/f9iQPa2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795775; c=relaxed/simple;
	bh=GEA7d0J4acRievL55S4Y4q2M0X0q0uWNiqUOXJWHvHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GVmEgn6dOk0SLa7wGxn0LskTXHs6jt7N4jilfVGYSISiehvqqEgdkbH3V6PQAbkZaN7N5V9OHdoa7nySgHthWnTWp/+ZCbKyMqwPyGAi7EeaLNnjBHJdJ/InNQ1JnexjUFudP4Vdp9fr+eBybvDMdreMZzvhMMsfyx0QwfuJca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMRITlWF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762795774; x=1794331774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEA7d0J4acRievL55S4Y4q2M0X0q0uWNiqUOXJWHvHM=;
  b=cMRITlWFOFfa3xEJK4O4428pZVTBi2xytB4OrS5qeksGFslcVzuXfF4v
   FkUgBG3IjZ3aRPRPVzV54vtpzvVKWt9GCOQbF8Ymy5ye0SbrbgSHSqIcn
   b7mdji3lttwpRM1TOYgVXbvUM0EGvTblmC/h3DhVfXpZ2ETodR0trHzoh
   ZApo0nOqQ+AdxEaiIMjvaMuV8hfUBX35ujcqfmIPe+EoWbdTw7mTRK6t4
   mDk7yzXppWgJEbUkyt4/rVBI2njgXx68+B8MeWguaCG+qh/d+PePiVYA3
   U4IrHMkx7lSM0tcYIl0Q4CBYEUtYErIlyUHCybFMgEA1F6R9IYdohE2R9
   A==;
X-CSE-ConnectionGUID: q5V58kpfS66B8nQyFA2J2g==
X-CSE-MsgGUID: u5i/LemWQWu4EjNgiia8oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64762989"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64762989"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:29:33 -0800
X-CSE-ConnectionGUID: S3jP8SJiTzKAQC00ETpv8A==
X-CSE-MsgGUID: +Vxi1KYgSAqGxnLsQUF10Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188477301"
Received: from jpp-desktop.igk.intel.com ([10.91.221.24])
  by orviesa009.jf.intel.com with ESMTP; 10 Nov 2025 09:29:31 -0800
From: Sachin Mokashi <sachin.mokashi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	kuba@kernel.org,
	horms@kernel.org,
	Sachin Mokashi <sachin.mokashi@intel.com>
Subject: [PATCH] CREDITS: Add Sachin Mokashi for Audio Driver fixes
Date: Mon, 10 Nov 2025 12:27:17 -0500
Message-Id: <20251110172717.62047-1-sachin.mokashi@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGF2ZSBjb250cmlidXRlZCB0byBJbnRlbCBBU29DIERyaXZlciBidWcgZml4ZXMgYW5kIGhhY2tz
LgoKU2lnbmVkLW9mZi1ieTogU2FjaGluIE1va2FzaGkgPHNhY2hpbi5tb2thc2hpQGludGVsLmNv
bT4KLS0tCiBDUkVESVRTIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvQ1JFRElUUyBiL0NSRURJVFMKaW5kZXggZmE1Mzk3ZjRlYmNkLi45
ZWVhYzlhZTA3NmIgMTAwNjQ0Ci0tLSBhL0NSRURJVFMKKysrIGIvQ1JFRElUUwpAQCAtMjg2Nyw2
ICsyODY3LDEzIEBAIFM6IDEyNzI1IFNXIE1pbGxpa2FuIFdheSwgU3VpdGUgNDAwCiBTOiBCZWF2
ZXJ0b24sIE9yZWdvbiA5NzAwNQogUzogVVNBCiAKK046IFNhY2hpbiBNb2thc2hpCitFOiBzYWNo
aW4ubW9rYXNoaUBpbnRlbC5jb20KK0Q6IEF1ZGlvIERyaXZlciAoQVNvQykgaGFja3MgYW5kIGJ1
ZyBmaXhlcworUzogQnJpZWdlciBTdHIuIDcKK1M6IDgwOTk3IE11bmljaAorUzogR2VybWFueQor
CiBOOiBFYmVyaGFyZCBNw7Zua2ViZXJnCiBFOiBlbW9lbmtlQGd3ZGcuZGUKIEQ6IENEUk9NIGRy
aXZlciAic2JwY2QiIChNYXRzdXNoaXRhL1BhbmFzb25pYy9Tb3VuZGJsYXN0ZXIpCi0tIAoyLjM0
LjEKCkludGVsIERldXRzY2hsYW5kIEdtYkgNClJlZ2lzdGVyZWQgQWRkcmVzczogRG9ybmFjaGVy
IFN0cmHDn2UgMSwgODU2MjIgRmVsZGtpcmNoZW4sIEdlcm1hbnkNClRlbDogKzQ5IDg5IDk5MSA0
MzAsIHd3dy5pbnRlbC5kZQ0KTWFuYWdpbmcgRGlyZWN0b3JzOiBIYXJyeSBEZW1hcywgSmVmZnJl
eSBTY2huZWlkZXJtYW4sIFlpbiBDaG9uZyBTb3JyZWxsDQpDaGFpcnBlcnNvbiBvZiB0aGUgU3Vw
ZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUNClJlZ2lzdGVyZWQgU2VhdDogTXVuaWNoDQpDb21t
ZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNw7xuY2hlbiBIUkIgMTg2OTI4Cg==


