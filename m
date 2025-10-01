Return-Path: <linux-kernel+bounces-838372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEB1BAF09E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2304E3B5882
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475328BAA6;
	Wed,  1 Oct 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaUDxVCN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7027F195
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287317; cv=none; b=LzgqZZo9hPXREWRwb0zlPcCU0XK7tBq1eMTK6VQ3D29ewferk4+5dfQZUUWHMrJ6CDvv6Xe5CDQHbcYSILYZjzRJ4JZYbnwbD7yLLqh33O5a7Firk/4GHlAOTMJg14cjtPlfnURagLQIwEAeIcUspHRPe0zZ0P+89R2eqepqMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287317; c=relaxed/simple;
	bh=dvXGa0GxyCQ64Z7snw7KIY71r0fttLiv1/DWhLRD4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SV0RM88R9EBWVc+8KvFZqJnKIi2EeyLhJaePh5SjaG1XeB1FAo/1lUBnBTi3u/btNPMf9Qt5EQ4RwbPZdBuOMJ3J8D9DzaI7M8bd97howdx+iFHt8TgdTKHBNR48vyfS3L/A18jPI4i7MZU3TU2AoUpoPU63oimA4O3SSKJ320w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaUDxVCN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287316; x=1790823316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvXGa0GxyCQ64Z7snw7KIY71r0fttLiv1/DWhLRD4/Y=;
  b=YaUDxVCNJ8ptxeCBHK8+C7yrXqqYP2wRRdF318W3DB6g9C5sKmeAPqb3
   n6Q5izCOIaMTejlMTDHW817LFYFprfQK9LQCmqzBeUuMWMI5M3EASmYZL
   8FoaOiSUzfCgJHnr8ocTYrTbyxsZMYjPU5NTDnsgTqUeHcpBBlTxlcySA
   Aw23BERgJXTl2HgaTglHLpC9Rl2KdGYh1E/gRisfLWJZEb2MbnOGqS9UZ
   RpoxJSAbgJfEVzpsRsCq904pDnlGH8BTugz6oAPjn4SpYuvWiDWSp+Z8g
   sHHuJ6xfse6XY51GGiPYU7muLYkG/lho3xfiaQW0yqiEMjT5TA3eNpvLq
   A==;
X-CSE-ConnectionGUID: U56W7V4uTBuLuveUhGvpLg==
X-CSE-MsgGUID: 7q+sz18bQC6cFeYNUtDcGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662310"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:13 -0700
X-CSE-ConnectionGUID: zx65eUQOTQaOzn2/y21vng==
X-CSE-MsgGUID: 605RYKm0QHeXoOT+Ag+9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629171"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:12 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 10/21] x86/virt/seamldr: Verify availability of slots for TDX Module updates
Date: Tue, 30 Sep 2025 19:52:54 -0700
Message-ID: <20251001025442.427697-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU keeps track of TCB versions for each TDX Module that has been
loaded. Since this tracking database has finite capacity, there's a maximum
number of module updates that can be performed. After each successful
update, the number reduces by one. Once it reaches zero, further updates
will fail until next reboot.

Before updating the TDX Module, ensure that the limit on TDX Module updates
has not been exceeded to prevent update failures in a later phase where TDs
have to be killed.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b9e025d0f0bc..9f7d96ca8b2f 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -74,6 +74,14 @@ EXPORT_SYMBOL_GPL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
 int seamldr_install_module(const u8 *data, u32 size)
 {
+	const struct seamldr_info *info = seamldr_get_info();
+
+	if (!info)
+		return -EIO;
+
+	if (!info->num_remaining_updates)
+		return -ENOSPC;
+
 	guard(cpus_read_lock)();
 	if (!cpumask_equal(cpu_online_mask, cpu_present_mask)) {
 		pr_err("Cannot update TDX module if any CPU is offline\n");
-- 
2.47.3


