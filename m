Return-Path: <linux-kernel+bounces-838989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810A6BB0949
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2521A3B61C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134792FCBF1;
	Wed,  1 Oct 2025 13:55:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E572ED141;
	Wed,  1 Oct 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326951; cv=none; b=NPRatIyzFVgS+e2waTtvj/uUHWWmB2ZkY+k1gtg75WNKesgHuAHjo49VlF9KHzrEzb1fWYbUrQLIJ6T16u2wO9T6SrYz8nlLDTeZq02D15ba/IZLh1T81eueWAh1owbKBZhkzMiT5rUYRQvdmpstBdJJi7nuF9o7kpdFpSNeVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326951; c=relaxed/simple;
	bh=DBLdPLwAPYxwY8YrL6peFCZsoq23oqhi/xsqOQI7luo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/EaQNMowLjtYcQryt5UUlibu3mfTZXTRTvAxiSxYeLdE4Q1DUQ81wOey1JoX73hsQLXec5Z3b2LYjEUlVVBbccxPgPnxJGQQYQ46IHg7t6Jh30g2AA55cJLvLVHeyBsR2q9ahglgwMSq/skLXFXM/exNKugLHYHTwC4ljAjblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A795A16F2;
	Wed,  1 Oct 2025 06:55:40 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C6A3F66E;
	Wed,  1 Oct 2025 06:55:48 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:55:46 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20251001135546.GP7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
 <20250930151414.GK7985@e132581.arm.com>
 <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>
 <20251001132815.GN7985@e132581.arm.com>
 <708a5bbd-2bad-4f94-8fd1-6bd10825ba71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708a5bbd-2bad-4f94-8fd1-6bd10825ba71@linaro.org>

On Wed, Oct 01, 2025 at 02:44:06PM +0100, James Clark wrote:

[...]

> > ATTR_CFG_FLD_ts_level_* is only used in coresight-etm4x-core.c, it is not
> > used in coresight-etm-perf.c. Thus, we don't need to include
> > coresight-etm4x.h in coresight-etm-perf.c. Do I miss anything?
> 
> Yes, GEN_PMU_FORMAT_ATTR() uses them but it makes it hard to see.

I did a quick test, it is feasible to move ATTR_CFG_* macros in
coresight-etm-perf.h. This is a more suitable ?

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 5febbcdb8696..2679d5b2dd9a 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -8,6 +8,7 @@
 #define _CORESIGHT_ETM_PERF_H
 
 #include <linux/percpu-defs.h>
+#include <linux/perf/arm_pmu.h>
 #include "coresight-priv.h"
 
 struct coresight_device;
@@ -20,6 +21,12 @@ struct cscfg_config_desc;
  */
 #define ETM_ADDR_CMP_MAX       8
 
+#define ATTR_CFG_FLD_ts_level_CFG      config3
+#define ATTR_CFG_FLD_ts_level_LO       12
+#define ATTR_CFG_FLD_ts_level_HI       15
+#define ATTR_CFG_FLD_ts_level_MASK     GENMASK(ATTR_CFG_FLD_ts_level_HI, \
+                                               ATTR_CFG_FLD_ts_level_LO)
+

> > A similiar case is the attr 'cc_threshold' is only used by ETMv4, it is
> > exported always. It is not bad for me to always expose these attrs but
> > in the are ignored in the ETMv3 driver - so we even don't need to
> > bother adding .visible() callback.
> > 
> 
> I disagree with always showing them. I think they should be hidden if
> they're not used, or at least return an error to avoid confusing users. It
> also wastes config bits if they're allocated but never used.

It is fine for not exposing ETMv4 only attrs for ETMv3.

> Either way, this was done because of the header mechanics which can only be
> avoided by adding more changes than just the #ifdefs. There are also already
> ETM4 #ifdefs in the file.

Yeah, actually we can remove ETM4 #ifdefs, something like:

 /*
  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
@@ -90,9 +83,9 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 {
        int pid_fmt = ETM_OPT_CTXTID;
 
-#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
-       pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
-#endif
+       if (IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X))
+               pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ;
+
        return sprintf(page, "config:%d\n", pid_fmt);
 }

Thanks,
Leo

