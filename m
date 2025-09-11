Return-Path: <linux-kernel+bounces-811750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B9B52D70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175195812C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E8A2EA746;
	Thu, 11 Sep 2025 09:38:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A592EA492
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583493; cv=none; b=nb6r1VXucPs9pY7I0QPPit+oONknFiR2DFpeHgxABt+qgVjISPCnm0uXcw9I88VHM0wXefs6pfpLXS+v97iaz96PKkys+3bo3oJ518+qKD120KYBrniYYoY2dw3pbF2abD2Rz6VEy/3rFVA1KTqKkZPh/WRIkFCKnAJ55sTW6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583493; c=relaxed/simple;
	bh=ZYRFf7S3q665BVnYWNBoen1F8DpGUxOfP9Q0fMsVyBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPA7sxkgIosNAHqTYhfBSZUrFhkCJjYliXbhPqWHzaGnK+Ox/aw0Zcql6o/c5vscxuzIkhzKwWE2lbfnPD0NyvKVOgeXbDT7Wirr2q/Lm6I+D92I66K+BduIUU6XO5vIzJHZoV0pb9MpYhz+ad+KjliGT8Pn+IMF8IuVw0kGa3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F77F153B;
	Thu, 11 Sep 2025 02:38:02 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704E73F694;
	Thu, 11 Sep 2025 02:38:10 -0700 (PDT)
Date: Thu, 11 Sep 2025 10:38:07 +0100
From: Leo Yan <leo.yan@arm.com>
To: Junhao He <hejunhao3@huawei.com>
Cc: suzuki.poulose@arm.com, james.clark@arm.com, anshuman.khandual@arm.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, yangyicong@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v3 1/3] coresight: tmc: Add missing doc including reading
 and etr_mode of struct tmc_drvdata
Message-ID: <20250911093807.GE12516@e132581.arm.com>
References: <20250818080600.418425-1-hejunhao3@huawei.com>
 <20250818080600.418425-2-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818080600.418425-2-hejunhao3@huawei.com>

On Mon, Aug 18, 2025 at 04:05:58PM +0800, Junhao He wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> tmc_drvdata::reading is used to indicate whether a reading process
> is performed through /dev/xyz.tmc.
> tmc_drvdata::etr_mode is used to store the Coresight TMC-ETR buffer
> mode selected by the user.
> Document them.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-tmc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6541a27a018e..9daa2680cfb6 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -220,6 +220,7 @@ struct tmc_resrv_buf {
>   * @pid:	Process ID of the process that owns the session that is using
>   *		this component. For example this would be the pid of the Perf
>   *		process.
> + * @reading:	buffer's in the reading through "/dev/xyz.tmc" entry
>   * @stop_on_flush: Stop on flush trigger user configuration.
>   * @buf:	Snapshot of the trace data for ETF/ETB.
>   * @etr_buf:	details of buffer used in TMC-ETR
> @@ -232,6 +233,7 @@ struct tmc_resrv_buf {
>   * @trigger_cntr: amount of words to store after a trigger.
>   * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
>   *		device configuration register (DEVID)
> + * @etr_mode:	User preferred mode of the ETR device, default auto mode.
>   * @idr:	Holds etr_bufs allocated for this ETR.
>   * @idr_mutex:	Access serialisation for idr.
>   * @sysfs_buf:	SYSFS buffer for ETR.
> -- 
> 2.33.0
> 

