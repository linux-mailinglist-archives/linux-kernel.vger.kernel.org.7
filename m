Return-Path: <linux-kernel+bounces-838842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E889BBB0420
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A443B3462
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4252E7BCE;
	Wed,  1 Oct 2025 11:57:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4A2E7652;
	Wed,  1 Oct 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319862; cv=none; b=O1irqxNdRHMj5B7+BDjZQmMuWlRlibtnde1orwfAmeLmTcMTziqboTMv0JlaHC8iqtpcY1sReGaiTUMvk7QH0lApRFcYVjFfo1pGresaU6H/ALWnQBjUoR5FB22KnYQ3heyY7elphwGGfQRzgasUBdHj+v+s9s/DqxTA9yxeJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319862; c=relaxed/simple;
	bh=Wku+p9ieJkSFmgR5WNUgksaqcifDe+FYFkhfSSc2Rc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwtGNJwXRDfhjJLCZ2Qww9FE5Gvwl/y2BLuDQfT9Pid22KSPCShVMrorKfGW42rRaB/hfECDGngjC9lSaxws8IBFgjBH5BattsBjohnPFyOwoSbePeF6W+ro1C8BAUnMJxKPWjFoY74kJBnAROJC7KCNulpChINPhDcR2MJPgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0E6F16F2;
	Wed,  1 Oct 2025 04:57:30 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 810463F66E;
	Wed,  1 Oct 2025 04:57:37 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:57:27 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Artem Shimko <artyom.shimko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>, a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: scmi: Add completion timeout handling for raw
 mode transfers
Message-ID: <aN0T0tvsL6t6R3yF@pluto>
References: <20250929142856.540590-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929142856.540590-1-a.shimko.dev@gmail.com>

On Mon, Sep 29, 2025 at 05:28:55PM +0300, Artem Shimko wrote:
> Fix race conditions in SCMI raw mode implementation by adding proper
> completion timeout handling. Multiple tests[1] in the SCMI test suite
> were failing due to early clearing of SCMI_XFER_FLAG_IS_RAW flag in
> scmi_xfer_raw_put() function.

Hi Artem, 

> 
> TRANS=raw
> PROTOCOLS=base,clock,power_domain,performance,system_power,sensor,
> voltage,reset,powercap,pin_control VERBOSE=5
> 

Glad to see that someone is using the test-suite im RAW mode out there
in the real world :P

> The root cause:
> Tests were failing on poll() system calls with this condition:
>     if (!raw || (idx == SCMI_RAW_REPLY_QUEUE && !SCMI_XFER_IS_RAW(xfer)))
>         return;
> 
> The SCMI_XFER_FLAG_IS_RAW flag was being cleared prematurely before
> the transfer completion was properly acknowledged, causing the poll
> to return on timeout and tests to fail.
> 

I have to say I had seen some anomalies, hardly reproducible, and I
think you have a point here, good catch !

The xfer flags handling is racy and it could lead to the observed
anomalies...BUT....

> Сhanges implemented:
> 1. Add completion wait with timeout in  scmi_xfer_raw_worker()
> 2. Signal completion in scmi_raw_message_report()
> 

.. I think the fix in your patch is overkill...it is really not needed
to add another layer of synchronization like you are doing, because the
bug is really around the xfer put and it is very well evident, now that
you have pointed at it...

What about, instead of your patch, this:

-----8<----
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 801d59e6b3bc..d3453130896a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -822,6 +822,8 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
                        scmi_dec_count(info->dbg->counters, XFERS_INFLIGHT);
                }
+               xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
+               xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
                hlist_add_head(&xfer->node, &minfo->free_xfers);
        }
        spin_unlock_irqrestore(&minfo->xfer_lock, flags);
@@ -840,8 +842,6 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
        struct scmi_info *info = handle_to_scmi_info(handle);
 
-       xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
-       xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
        return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
---->8----

..because the xfer itself is refcounted properly, BUT as of now the
flags are cleared out of the block inside __scmi_xfer_put:

	if (refcount_dec_and_test(&xfer->users))

...and that is the problem.

The above patch solves for me all the observed anomalies...

... probably EVEN BETTER if you just clear all:

---8<-----
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 801d59e6b3bc..914510de3abb 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -822,6 +822,7 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
                        scmi_dec_count(info->dbg->counters, XFERS_INFLIGHT);
                }
+               xfer->flags = 0;
                hlist_add_head(&xfer->node, &minfo->free_xfers);
        }
        spin_unlock_irqrestore(&minfo->xfer_lock, flags);
@@ -840,8 +841,6 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
        struct scmi_info *info = handle_to_scmi_info(handle);
 
-       xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
-       xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
        return __scmi_xfer_put(&info->tx_minfo, xfer);
 }

---->8----
 
...to simply clear all flags when xfer is put...

If this solves for you too, please send a new patch with also a Fixes tag.

Last but not least, are you running the test-suite against a Kernel
configured with RAW cohexistence disabled ?

	CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX = n

...because having RAW COEX enabled when running the test-suite could lead to more
false positives even with your patch applied, due to the interference of regular
drivers..

Thanks for this !
Cristian


