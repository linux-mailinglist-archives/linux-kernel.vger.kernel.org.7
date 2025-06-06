Return-Path: <linux-kernel+bounces-676103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D892AD0786
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 19:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCAB3B1D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 17:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D128982F;
	Fri,  6 Jun 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5gZE/Kg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC67D07D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231091; cv=none; b=Hfd/aDsA8XS3N49MPmu4mBNwW4qgItY5Gjs4SmXGS1/bc9Y9tiFdGNtjFtO8sJ9mw9hi8shtbhD4fZFrH3tR+Chty0VlJ4Ha3SmGVvLGxXH+XEVxazSOBIKFJQHFF3/k0p4rMCIF5RioUiriql5xukLsXIf7WQtZuZ4YzmRSWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231091; c=relaxed/simple;
	bh=Wr09Q9KGWmSBzo4fuswiZyFsJIZR46X//yeoWLN9/78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncz3WXV/F7/Ln56QXZfpwUjpEqleUvFr7VyXiPkIC0ZNqmbSq4xOL+sgA30t3+mPpcfwaWTE2+c/TsK5UvR6GwdpbpFPgv//Xzo7cmcV2ZY8T4yPtazqtHmNRBuvmYd1TQReyR8VJfnPckhpgDCWSUPGdYRQ2pOVH+C+4l7UI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5gZE/Kg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749231089; x=1780767089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wr09Q9KGWmSBzo4fuswiZyFsJIZR46X//yeoWLN9/78=;
  b=b5gZE/KgjlZflunZugBRMggssyliGoUeU/sz6vCLdKGA7OklTbsvwQkw
   c0yjNm9H3wyeA34OKMgGZy7irGDcjoyigtPyinh3uoh9TRSqPDA6CJ1NH
   M6bw5NpceY3YyrgC+mck0lJlNx06bHjFFPeb6vvE6SItYZVwfqvmYnfSu
   0X/TcGf2swv0O49AMT4l/i+xLE+CzJ+/pxxYJwi9cAh08+DjrYMYmPT9x
   IWRV/tT/lgz/QhXqeCHbxnuXVIm9vdq3UJjObp5Z36wCO92KE/+IXhjGl
   PhpuviAbOVDmbsfmmq91L3aHfFdFjOzA+F6RtXeG7rMteTwvR6lJboYcM
   w==;
X-CSE-ConnectionGUID: IXIcft4bSdSSkuAAXR+fAQ==
X-CSE-MsgGUID: CLP5rMOXTQihEAd8h1RQBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="55179515"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="55179515"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:31:28 -0700
X-CSE-ConnectionGUID: o9bhaOeCRVe06+jC41zt2w==
X-CSE-MsgGUID: GAk6VHa3TQWDzy8i9P2vWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="146835968"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 10:30:55 -0700
Date: Fri, 6 Jun 2025 10:30:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v5 27/29] fs/resctrl: Add file system mechanism for
 architecture info file
Message-ID: <aEMlznLgnn6bK9lo@agluck-desk3>
References: <20250521225049.132551-1-tony.luck@intel.com>
 <20250521225049.132551-28-tony.luck@intel.com>
 <f25d136c-b1d3-483a-ac77-92464d7fe25c@intel.com>
 <aEIxzbuFybLBE3xt@agluck-desk3>
 <9eb9a466-2895-405a-91f7-cda75e75f7ae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb9a466-2895-405a-91f7-cda75e75f7ae@intel.com>

On Fri, Jun 06, 2025 at 09:26:06AM -0700, Reinette Chatre wrote:
> With /sys/kernel/debug/resctrl potentially mirroring /sys/fs/resctrl to
> support various debugging scenarios there may later be resource level
> debugging for which a "/sys/kernel/debug/resctrl/info/<resource>/<debugfile>" can
> be used. Considering this it looks to me as though one possible boundary could
> be to isolate arch specific debug to, for example, a new directory named
> "/sys/kernel/debug/resctrl/info/arch_debug_name_tbd/". By placing the
> arch debug in a sub-directory named "info" it avoids collision with resource
> group names with naming that also avoids collision with resource names since
> all these names are controlled by resctrl fs. 


That seems like a good path. PoC patch below. Note that I put the dentry
for the debug info directory into struct rdt_resource. So no call from
architecture to file system code needed to access.

Directory layout looks like this:

# tree /sys/kernel/debug/resctrl/
/sys/kernel/debug/resctrl/
└── info
    ├── L2
    ├── L3
    ├── MB
    └── SMBA

6 directories, 0 files

-Tony

---

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5e28e81b35f6..78dd0f8f7ad8 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -281,6 +281,7 @@ enum resctrl_schema_fmt {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
  *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @arch_debug_info:	Debugfs info directory for architecture use
  */
 struct rdt_resource {
 	int			rid;
@@ -297,6 +298,7 @@ struct rdt_resource {
 	enum resctrl_schema_fmt	schema_fmt;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
+	struct dentry		*arch_debug_info;
 };
 
 /*
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ed4fc45da346..48c587201fb6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4274,6 +4274,8 @@ void resctrl_offline_cpu(unsigned int cpu)
  */
 int resctrl_init(void)
 {
+	struct dentry *debuginfodir;
+	struct rdt_resource *r;
 	int ret = 0;
 
 	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
@@ -4320,6 +4322,12 @@ int resctrl_init(void)
 	 */
 	debugfs_resctrl = debugfs_create_dir("resctrl", NULL);
 
+	/* Create debug info directories for each resource */
+	debuginfodir = debugfs_create_dir("info", debugfs_resctrl);
+
+	for_each_rdt_resource(r)
+		r->arch_debug_info = debugfs_create_dir(r->name, debuginfodir);
+
 	return 0;
 
 cleanup_mountpoint:

