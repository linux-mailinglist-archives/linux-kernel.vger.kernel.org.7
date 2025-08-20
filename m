Return-Path: <linux-kernel+bounces-777417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE278B2D911
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A6FB60D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F22E285C;
	Wed, 20 Aug 2025 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FPTTjmI2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE52DECBA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682840; cv=none; b=WmgpH+o301/ForC2KYppDAQw6pbTunWMLsdF0Qt356QRXxj2Mq0M0FdNOKerho8vVcj7Kvkq5ewSjDtCFNjqTAzoT+EfjB37ocsdo+Ud5N3q7XZblSZbSaperTOBBJ4IuazfKfxeq/NYJg8E0LSMktV5F2azxHbQjYT7qj2HqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682840; c=relaxed/simple;
	bh=jseJB8mxRO8twsWpgM50wcB2CH10FcIVLbrukEtfdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnMz/3mtM/cxhQxJQ8bF60hxZDJao1tq+jcO3TP4SdpFuPnwK4ZAuzOsHlSgJAWgY0BE3PKhYVNOswliCcuht5KJnRGwGtgZDpFxHH/SteSkYIaekUa/9vHwWttyi+BP8OaQOTZlUHFYazSjCIgNtxJM5Q95yYRuTyYQMrGgPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FPTTjmI2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-618b62dbb21so9074258a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755682834; x=1756287634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NM0fyXJdFVsVnU/yS6K0gQI6XozNG1TCaWkFW+vAlK8=;
        b=FPTTjmI2m1Xomt7ZjDRJeFiH49jk8C86vS+VuzKkE6mL1E6wiF6vLMIos6Nhj1a9Vm
         Fsl8OZjzNrochKnp+7JVlmy9j8mFj8SKlFcPR9mFcCK8u5ta+RcNDBXYJbAcZEy4lSJW
         sXB7ULiB4Okj3DVDrPxHoO61qBgDj0BkBHwRNmlzV/VykAQWCGOUpEJqNrzCHwX5p7Lx
         YIUn2lO0lwOXV4aVXTk+l7MwJj1kOZOpqWLd3E7It7KQP73sOp2IusL+yGQFRFaqTUpj
         zE8fmPxRwEreDgcXddsa+btihZAWHN6D2OjZLETrz6ZBjH21IDvODIauQkRuI5T64rAk
         oRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682834; x=1756287634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM0fyXJdFVsVnU/yS6K0gQI6XozNG1TCaWkFW+vAlK8=;
        b=qxtUUsoO0P6ySphm+tOmdc7Kc1Ay2D/BBxjfy97rEfFtpg6ix18U2wJqc3JpI1P+XX
         nUtXW75QPVzuXDZoNn4MI/i/HpQ/XRUAdIvOG7SAmuYKgtrhZ0WcUuY9sQ+Cbdrmqmy3
         eT4MdAttS2RR03mz/4C3cqmWDBZRK6l+xLc71/aIVaKwWGj2utpJOAf1sOKuqyljEF9Y
         hQBXS47PaRNnUAl0QMrZZllm47G1fR6nmS2m92rws/Vh0jAw/+G/XHR48kKkhuUjHi1u
         CylK8s+1VENF6RqwL07T3F84V4Kfdc/nz7lMha7BiK2ZG9K9tEpcmTwJsWH2Q9LoYd8y
         jWZA==
X-Forwarded-Encrypted: i=1; AJvYcCXrcTuEYhWL21LNxOxAsMf3PnE3PR0c7aJHneVKyWUJIRfx9N1Z4CwB+F8y1BJpIdLfkx8i83/8pHyJzLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1tjBPOpq+fiXpvJM10aTIpGmetRNYmvbYOAnL5F2cDkpnKmN
	hV5hzNyOBgfiuUM+JC+uIXu4NWRwlqewMAaM0PbQFlUV2FJCMwHtx+CcjaCTb9Oln0Q=
X-Gm-Gg: ASbGnctnLVaue8rMx3dqeHunRL5smCvKYtd0bv/BNMxf++XeLJuL9dGdYTuk9s6lDy8
	FKIuemChGW8Pt31PUusIvthQ6EjhYQBjnthR/egQF+fVvR2TPmR+K6piPPom4o6RbF3TmWR7cYW
	3Mw4Kxcs0Cw/wclBFDcENdZ3eK2Yx2mD7hIWI8HZpWPPCF96x8PFa9RqmJWquE/EpxgzGoxx4+u
	pdmPB5rig9pV02ARvIqyARIx79wFEBKhIdFevsQkWVmEQypaLUAHDU1BDEVwnG7R3s0VLTOHG6m
	NHqACoq+ZS4gbzEk7b930odlOjDIB+nPTT8inFGm7d6660lC4bUsJffnqu35cuJ5J799fVaMSI3
	gyrbgLkRfG5NpAYMpVqDN5AzwFA==
X-Google-Smtp-Source: AGHT+IEL5yizeK4oP3hcKNDpDCbogCgeCUIgrsK+feZZ6+ybN7ZuuNRbKKwxk5Z77sh2bbe8+uaS7Q==
X-Received: by 2002:a17:907:3c8b:b0:ad8:9645:798c with SMTP id a640c23a62f3a-afdf0209598mr168513766b.51.1755682834470;
        Wed, 20 Aug 2025 02:40:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478a14sm148404966b.76.2025.08.20.02.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:40:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 11:40:32 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, john.ogness@linutronix.de,
	kernel test robot <lkp@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2] panic: Clean up message about deprecated 'panic_print'
 parameter
Message-ID: <aKWYELPjbhC7R8NO@pathway.suse.cz>
References: <aKRJKZHgcxyNF3y7@pathway.suse.cz>
 <202508200907.PsZ3geub-lkp@intel.com>
 <ae9bb2ea-c6e5-4a4b-ae25-aea1d6fe084d@linux.dev>
 <33a897b4-7d9a-4641-9c7a-07c19bb9cb6f@linux.dev>
 <7a34da58-874d-4271-9dbb-7991468d58ff@linux.dev>
 <aKWWcPOf9qPIoCe4@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKWWcPOf9qPIoCe4@pathway.suse.cz>

Remove duplication of the message about deprecated 'panic_print'
parameter.

Also make the wording more direct. Make it clear that the new
parameters already exist and should be used instead.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
Changes since v1:

  - fixed compilation with CONFIG_SYSCTL disabled (kernel test
    robot <lkp@intel.com>)

Thanks Lance Yang <lance.yang@linux.dev> for debugging the compilation
error reported by the test robot.

 kernel/panic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 12a10e17ab4a..24bca263f896 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -77,6 +77,11 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
+static void panic_print_deprecated(void)
+{
+	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
+}
+
 #ifdef CONFIG_SYSCTL
 
 /*
@@ -125,7 +130,7 @@ static int proc_taint(const struct ctl_table *table, int write,
 static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
@@ -944,13 +949,13 @@ core_param(panic_console_replay, panic_console_replay, bool, 0644);
 
 static int panic_print_set(const char *val, const struct kernel_param *kp)
 {
-	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return  param_set_ulong(val, kp);
 }
 
 static int panic_print_get(char *val, const struct kernel_param *kp)
 {
-	pr_info_once("Kernel: 'panic_print' parameter will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
+	panic_print_deprecated();
 	return  param_get_ulong(val, kp);
 }
 
-- 
2.50.1


