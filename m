Return-Path: <linux-kernel+bounces-847618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58CBCB496
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BD94079FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038381ADC97;
	Fri, 10 Oct 2025 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fj9if5q0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF52868B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056437; cv=none; b=pNJQhK1ttiDPIcC7fLD/TK2nmiDcEHt1IK2el8vId+FG0/iL9AgYFkrSFRHhmWLjvZ/nUdehKX/vvO46Y9VLE1LspMxDI/vbxfQRUGYd2q4hBaLi8B2AVCguky+0qhTUOHwaJ4Ns8E3vcaaBN3h+FT4XAW5xM3+uI86Oq2zcBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056437; c=relaxed/simple;
	bh=SvCyLfs3jKvu12dEImRuAGsVMOS3AFRCaxcbrGJ/Hxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDAOExNh1OhLl4Dz5Dg3Z6khoBK0YKy2CObuTKIiZ36jOQQS0WXq0atud16naUMWJ4myRLvIeW/+oaWc7LdbY5o/EkMuJ55JKWnZiGTJoDnud81adf5MWYYaBf0vLDlLTOHwh/hakICRBqjVpXkqVoSujvBKp5YqS5Of/UgVEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fj9if5q0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760056435; x=1791592435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SvCyLfs3jKvu12dEImRuAGsVMOS3AFRCaxcbrGJ/Hxc=;
  b=fj9if5q0eyG4i8fSfTDrv7rpeGD2E/t+Kpd7qxlLXWLdH/4NpdOLzKrr
   3krODxh/Mx5xvUcjkwQ950OQAekc2vmVYxuV0sReBExJllGps31oJM9ij
   Eah4z+LBlwotxXrbC+Qbv5Z8fTDnTxzk93RLLrLHG4ofk//SPmjAxzpjr
   IsCV3rgBx38wqgFUAA0h/4/3QeguvAcJYfGWm9At7hcqVEmqmtDS9DX8F
   mHjFlMnFqqIPC0SrXEUC0bfTN2vZqScAKPV/4vUsgO6y9WSIJbVu6MTf0
   WT2NlEwl+Q8HtEs7z2L0AbgTwCNd8CcAMcru8A7e7+RZd1ce9zdtZMOj8
   A==;
X-CSE-ConnectionGUID: QSImN1ygQJypZtkYHQT9uw==
X-CSE-MsgGUID: 2+g7Py9aQ8Ws8lMHLLxpGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72889944"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="72889944"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:33:55 -0700
X-CSE-ConnectionGUID: 7tPhqBH+QGKIJ7xKlIsa/w==
X-CSE-MsgGUID: S055uhQqR/+htxNNLr2oOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180665127"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO desk) ([10.124.221.52])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 17:33:54 -0700
Date: Thu, 9 Oct 2025 17:33:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
Message-ID: <20251010003345.dc6ybdhwoslyse5m@desk>
References: <cover.1758906115.git.ptesarik@suse.com>
 <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
 <20251009185134.fb4evjrk76rwxv37@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009185134.fb4evjrk76rwxv37@desk>

On Thu, Oct 09, 2025 at 11:51:40AM -0700, Pawan Gupta wrote:
> On Fri, Sep 26, 2025 at 08:01:02PM +0200, Petr Tesarik wrote:
> > Use early_param() to get the value of the tsx= command line parameter.
> > Although cmdline_find_option() works fine, the option is later reported
> > as unknown and passed to user space. The latter is not a real issue, but
> > the former is confusing and makes people wonder if the tsx= parameter had
> > any effect and double-check for typos unnecessarily.

If this is too much of an annoyance, I would suggest to move
x86_get_tsx_auto_mode() from tsx_parse_cmdline() to tsx_init().

---
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 167dfd38b87a..805be8beb37a 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -20,6 +20,7 @@
 #define pr_fmt(fmt) "tsx: " fmt
 
 enum tsx_ctrl_states {
+	TSX_CTRL_AUTO,
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
 	TSX_CTRL_RTM_ALWAYS_ABORT,
@@ -27,7 +28,8 @@ enum tsx_ctrl_states {
 };
 
 static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
-	TSX_CTRL_NOT_SUPPORTED;
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
+	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;
 
 static void tsx_disable(void)
 {
@@ -164,11 +166,28 @@ static void tsx_dev_mode_disable(void)
 	}
 }
 
-void __init tsx_init(void)
+static int __init tsx_parse_cmdline(char *str)
 {
-	char arg[5] = {};
-	int ret;
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "on")) {
+		tsx_ctrl_state = TSX_CTRL_ENABLE;
+	} else if (!strcmp(str, "off")) {
+		tsx_ctrl_state = TSX_CTRL_DISABLE;
+	} else if (!strcmp(str, "auto")) {
+		tsx_ctrl_state = TSX_CTRL_AUTO;
+	} else {
+		tsx_ctrl_state = TSX_CTRL_DISABLE;
+		pr_err("invalid option, defaulting to off\n");
+	}
+
+	return 0;
+}
+early_param("tsx", tsx_parse_cmdline);
 
+void __init tsx_init(void)
+{
 	tsx_dev_mode_disable();
 
 	/*
@@ -202,27 +221,8 @@ void __init tsx_init(void)
 		return;
 	}
 
-	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
-	if (ret >= 0) {
-		if (!strcmp(arg, "on")) {
-			tsx_ctrl_state = TSX_CTRL_ENABLE;
-		} else if (!strcmp(arg, "off")) {
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-		} else if (!strcmp(arg, "auto")) {
-			tsx_ctrl_state = x86_get_tsx_auto_mode();
-		} else {
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-			pr_err("invalid option, defaulting to off\n");
-		}
-	} else {
-		/* tsx= not provided */
-		if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO))
-			tsx_ctrl_state = x86_get_tsx_auto_mode();
-		else if (IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF))
-			tsx_ctrl_state = TSX_CTRL_DISABLE;
-		else
-			tsx_ctrl_state = TSX_CTRL_ENABLE;
-	}
+	if (tsx_ctrl_state == TSX_CTRL_AUTO)
+		tsx_ctrl_state = x86_get_tsx_auto_mode();
 
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE) {
 		tsx_disable();

