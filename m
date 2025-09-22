Return-Path: <linux-kernel+bounces-826885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5368B8F8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979872A0709
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BB2FF642;
	Mon, 22 Sep 2025 08:29:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365BD2FE560
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529766; cv=none; b=on0A1QHAj/gLBLMCLVrkI+5FEAZA7OEb1JMrScYX6UFvnpCumjoGIkLqdFA8LQlCIqmzDUlTdCYbr7pfXJNP13G/uM5riDhpA8P8BYhnm/XqNjLuqeiqr3Q/gn4gDQ76Eyco3riGJD5zLlI4KYJ/3AZbiWZq3+r0kJkxgc9+RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529766; c=relaxed/simple;
	bh=okAoRJPo0UWDlLo08dcWEQ3uqZMpO5Te1Udnu5/nsKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsGzU/z3fKyEeMKaGWqShtyDDjkbss+UmA38cAfmwTL4Yl64f73prc3EQULcqF61byoVA4yrRj0XxDXY91br2GK3bZYGM7MhykR5HFJJw6eW0u8hjIgvI1cuUA8YEIlXVYJJNRGxdA7SPZwD9dvOhwQPlEk4JqKD+r0mHk3yr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2641B150C;
	Mon, 22 Sep 2025 01:29:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA60A3F66E;
	Mon, 22 Sep 2025 01:29:22 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:29:20 +0100
From: Leo Yan <leo.yan@arm.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Carl Worth <carl@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] coresight: tmc: add the handle of the event to
 the path
Message-ID: <20250922082920.GB516577@e132581.arm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922-fix_helper_data-v1-1-905e8115a24e@oss.qualcomm.com>

On Mon, Sep 22, 2025 at 03:31:39PM +0800, Jie Gan wrote:
> From: Carl Worth <carl@os.amperecomputing.com>
> 
> The handle is essential for retrieving the AUX_EVENT of each CPU and is
> required in perf mode. It has been added to the coresight_path so that
> dependent devices can access it from the path when needed.
> 
> Fixes: 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
> Signed-off-by: Carl Worth <carl@os.amperecomputing.com>
> Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c |  1 +
>  drivers/hwtracing/coresight/coresight-tmc-etr.c  |  3 ++-
>  include/linux/coresight.h                        | 10 ++++++----
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f677c08233ba..5c256af6e54a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -520,6 +520,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>  		goto out;
>  
>  	path = etm_event_cpu_path(event_data, cpu);
> +	path->handle = handle;
>  	/* We need a sink, no need to continue without one */
>  	sink = coresight_get_sink(path);
>  	if (WARN_ON_ONCE(!sink))
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index b07fcdb3fe1a..1040f73f0537 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1327,7 +1327,8 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
>  struct etr_buf *tmc_etr_get_buffer(struct coresight_device *csdev,
>  				   enum cs_mode mode, void *data)
>  {
> -	struct perf_output_handle *handle = data;
> +	struct coresight_path *path = data;
> +	struct perf_output_handle *handle = path->handle;
>  	struct etr_perf_buffer *etr_perf;
>  
>  	switch (mode) {
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 6de59ce8ef8c..4591121ae1d4 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -332,12 +332,14 @@ static struct coresight_dev_list (var) = {				\
>  
>  /**
>   * struct coresight_path - data needed by enable/disable path
> - * @path_list:              path from source to sink.
> - * @trace_id:          trace_id of the whole path.
> + * @path_list:			path from source to sink.
> + * @trace_id:			trace_id of the whole path.
> + * struct perf_output_handle:	handle of the aux_event.

s/struct perf_output_handle/@handle/

Otherwise, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>   */
>  struct coresight_path {
> -	struct list_head	path_list;
> -	u8			trace_id;
> +	struct list_head		path_list;
> +	u8				trace_id;
> +	struct perf_output_handle	*handle;
>  };
>  
>  enum cs_mode {
> 
> -- 
> 2.34.1
> 
> 

