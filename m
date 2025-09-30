Return-Path: <linux-kernel+bounces-837805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FBDBAD3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078C27A73FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B32441B8;
	Tue, 30 Sep 2025 14:41:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2A72617;
	Tue, 30 Sep 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243319; cv=none; b=PvWslqCOeS7cC4P3UBK71xX7X6IBXczLcXAxbQVj0EETJqn4nGqtMtDpUSTEZLOPEMvLj59+iLDYjaPDYY7PSR4bSC3rIb+PPYz5dSHwKAqfj9V0Ez57HB0qjVibbhfl870VTeZSFaO73wy7LGU9O4jWNBUkmDyqqydQF63Rv1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243319; c=relaxed/simple;
	bh=nSGaiJ3AjwZjG7r8ZW1nwQmlj571tGkuZJvQkfy7mbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jU2HC3/XnkGtEeXtv6tvspgFGf2jfrfua8ubBFepsLE4aioc5Bwh75qbOgLo6Z5dWqdVQBPGcni7h4YlhMpKmbOxnPhEie3gcWPyhpp5a7uWtrtxwxl1QUyrGtEeEJtlADsxfpf9KBDcZA3+rR5mX0gY2u8kak2Iae5MAY1boPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F4041424;
	Tue, 30 Sep 2025 07:41:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C65113F66E;
	Tue, 30 Sep 2025 07:41:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:41:53 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/6] coresight: Repack struct etmv4_drvdata
Message-ID: <20250930144153.GI7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-3-c76fcb87696d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-james-cs-syncfreq-v2-3-c76fcb87696d@linaro.org>

On Thu, Aug 14, 2025 at 11:49:54AM +0100, James Clark wrote:
> Fix holes and convert the long list of bools to single bits to save
> some space because there's one of these for each ETM.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 39 ++++++++++++++-------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index a355a1e9606d..1c67b263b01b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -1020,29 +1020,30 @@ struct etmv4_drvdata {
>  	u8				ns_ex_level;
>  	u8				q_support;
>  	u8				os_lock_model;
> -	bool				sticky_enable;
> -	bool				boot_enable;
> -	bool				os_unlock;
> -	bool				instrp0;
> -	bool				q_filt;
> -	bool				trcbb;
> -	bool				trccond;
> -	bool				retstack;
> -	bool				trccci;
> -	bool				trc_error;
> -	bool				syncpr;
> -	bool				stallctl;
> -	bool				sysstall;
> -	bool				nooverflow;
> -	bool				atbtrig;
> -	bool				lpoverride;
> +	bool				sticky_enable : 1;
> +	bool				boot_enable : 1;
> +	bool				os_unlock : 1;
> +	bool				instrp0 : 1;
> +	bool				q_filt : 1;
> +	bool				trcbb : 1;
> +	bool				trccond : 1;
> +	bool				retstack : 1;
> +	bool				trccci : 1;
> +	bool				trc_error : 1;
> +	bool				syncpr : 1;
> +	bool				stallctl : 1;
> +	bool				sysstall : 1;
> +	bool				nooverflow : 1;
> +	bool				atbtrig : 1;
> +	bool				lpoverride : 1;
> +	bool				state_needs_restore : 1;
> +	bool				skip_power_up : 1;
> +	bool				paused : 1;

I used pahole to check the structure layout. It is good to see that
bool fields are packed into single cache line (and we don't expect
these fields to modified frequently so no concern for false sharing).

  /* XXX 1 byte hole, try to pack */

  u16                        ccitmin;              /*   120     2 */
  u8                         s_ex_level;           /*   122     1 */
  u8                         ns_ex_level;          /*   123     1 */
  u8                         q_support;            /*   124     1 */
  u8                         os_lock_model;        /*   125     1 */
  bool                       sticky_enable:1;      /*   126: 0  1 */
  bool                       boot_enable:1;        /*   126: 1  1 */
  bool                       os_unlock:1;          /*   126: 2  1 */
  bool                       instrp0:1;            /*   126: 3  1 */
  bool                       q_filt:1;             /*   126: 4  1 */
  bool                       trcbb:1;              /*   126: 5  1 */
  bool                       trccond:1;            /*   126: 6  1 */
  bool                       retstack:1;           /*   126: 7  1 */
  bool                       trccci:1;             /*   127: 0  1 */
  bool                       trc_error:1;          /*   127: 1  1 */
  bool                       syncpr:1;             /*   127: 2  1 */
  bool                       stallctl:1;           /*   127: 3  1 */
  bool                       sysstall:1;           /*   127: 4  1 */
  bool                       nooverflow:1;         /*   127: 5  1 */
  bool                       atbtrig:1;            /*   127: 6  1 */
  bool                       lpoverride:1;         /*   127: 7  1 */
  /* --- cacheline 2 boundary (128 bytes) --- */
  bool                       state_needs_restore:1; /*   128: 0  1 */
  bool                       skip_power_up:1;      /*   128: 1  1 */
  bool                       paused:1;             /*   128: 2  1 */

Reviewed-by: Leo Yan <leo.yan@arm.com>

>  	u64				trfcr;
>  	struct etmv4_config		config;
>  	u64				save_trfcr;
>  	struct etmv4_save_state		*save_state;
> -	bool				state_needs_restore;
> -	bool				skip_power_up;
> -	bool				paused;
> +
>  	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>  };
>  
> 
> -- 
> 2.34.1
> 

