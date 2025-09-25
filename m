Return-Path: <linux-kernel+bounces-832835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CDBA086F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6271BC7C60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42C304BAF;
	Thu, 25 Sep 2025 16:01:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E572EC08C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816089; cv=none; b=o8p8uDUP21wJZdsKYSF8fQVpEEuLxzjQwI+9j2cxReG/+y616OCAMPx5ZroGKwEfpBIfLP5ijIJDoQ7g/2eDkl81hNHYxzKyJ62+ndkqS1AasYPtQ+4VUqqfGy8Nvru6UEkX9V4EwdMbSVwO6TZQ9Znow6G0zUhHTgxziI1mMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816089; c=relaxed/simple;
	bh=HXVb+JTUA3/j5ZnC+FIF63kL4xWFXyMJ4ABnzyDAfsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOmMHKV9IKaUK6n0JFbxlIgx/UzJSfM2uJkjlTdO/yRGTdL30Bl0H4zrhuE6LrUDvjrAmdNQ8GMUixLQYlaVlfs2I2ZQCcSvhVYnQE0RxBl7jJ4HVZDI84psV4Lbs6/saLlsUzeUyxpGGdo7sZKz6k+5XVnTT7G9mj9+4gxkEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19FAD1692;
	Thu, 25 Sep 2025 09:01:18 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C58613F694;
	Thu, 25 Sep 2025 09:01:25 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:01:23 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Jie Gan <jie.gan@oss.qualcomm.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
Message-ID: <20250925160123.GC7985@e132581.arm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
 <874isuo0m2.fsf@rasp.cworth.amperemail.amperecomputing.com>
 <f7be3833-9b33-4935-b821-a2e0000a2557@oss.qualcomm.com>
 <CAJ9a7VjaUE+iy=FFwPhCdfXgoGR3rP9WSx-ZkKYeCHhqJ2yzMg@mail.gmail.com>
 <3b16607f-8995-46b1-aecf-c6aa79f66f9d@arm.com>
 <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <635ba698-d7a9-40d0-9285-4ec108d4a536@linaro.org>

On Thu, Sep 25, 2025 at 11:10:51AM +0100, James Clark wrote:

[...]

In short, I prefer to store perf handle in coresight path, as Jie has
done in this series.

I will give details below, sorry for a long replying.

[...]

> This one is just a pointer to the perf handle which really does belong to
> the session rather than the device. This makes it more of a path thing than
> a csdev thing. Maybe we can rename path to be more like "session", which
> also happens to contain a path. But I think path is fine for now.

Yes, renaming 'coresight_path' (to like 'coresight_runtime_ctx') better
reflects the structure’s purpose.

The point is we can take chance to separate runtime parameters from
device and driver instances.

  - 'coresight_path': runtime parameters for an active session
  - 'coresight_device': a device instance registered on the bus
  - driver data: after probe, the driver maintains driver-specific
    attributes (e.g., the ETMv4 driver keeps mode and filters in struct
    etmv4_drvdata)

These structures have different lifetimes. For example, coresight_path
is valid only during a session; otherwise, it should be cleared.

From a lifecycle perspective, storing the perf handle in coresight_path
makes sense, since both are valid only for the duration of a session
(the perf handle isn't used in sysfs mode, in which case we can simply
leave it unset).

Furthermore, the perf handle is not just a handle; it lets us easily
retrieve private event data (see perf_get_aux()).

> However in this case handle is per-cpu data that is only accessed on the
> same cpu in tmc_etr_get_buffer(). Assigning it in etm_event_start() just
> copies the same per-cpu variable into a non per-cpu place that eventually
> gets accessed on the same cpu anyway.
> 
> If we exported it then it can be used directly without worrying where to
> store it:

We need to be careful for exporting data structures across modules, as
it makes them harder to manage.

In fact, we already share 'etm_event_data' for ETR driver for the same
purpose, and seems to me, it is redendant to export another structure
'etm_ctxt' to just make it convenient for obtaining a buffer config
pointer.

> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c
> b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 17afa0f4cdee..4c33f442c80b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -42,12 +42,8 @@ static bool etm_perf_up;
>   * the ETM. Thus the event_data for the session must be part of the ETM
> context
>   * to make sure we can disable the trace path.
>   */
> -struct etm_ctxt {
> -       struct perf_output_handle handle;
> -       struct etm_event_data *event_data;
> -};
> -
> -static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
> +DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
> +EXPORT_SYMBOL_GPL(etm_ctxt);

I'd suggest a different approach: drop the etm_ctxt structure and
instead define a per-CPU pointer to etm_event_data:

  static DEFINE_PER_CPU(struct etm_event_data *, etm_ev_ctx);

As mentioned above, if perf handle is maintained in coresight_path, we
can easily retrieve the etm_event_data via the perf handle.

A more aggressive refactoring would remove etm_ctxt from
coresight-etm-perf.c entirely, relying on the perf event to manage
private context data. For now, we keep it only to validate whether
ETM is enabled (see multiple place to validate ctxt->event_data).

Thanks,
Leo

