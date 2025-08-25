Return-Path: <linux-kernel+bounces-785049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA951B34533
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033CE162617
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077692F39AF;
	Mon, 25 Aug 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xi9cJmcT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2942F28F2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134393; cv=none; b=QfdJJsDNgeNhrkaWRk/b7PifZ6eUj0JOfJF38TlYESgZVrF1P42zQO9ak8nJW80vDwCq1O7+etr6lVoTrRSCUu4OgOoJaiYMdh32/DLRH5i6CWD7YEdbVQxRUJEJuuNQaIDH/9voNmy51kYfbBz/Tg+n2N846quaWnErEDloIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134393; c=relaxed/simple;
	bh=1NHTpzuJIT/fKbcKXwzyHeU6l+CF3ZH/uGuzx9DTVp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l6GyK1BStkbvHASuVG+WhBpopb1iwWcxGpfkvubEyRn0TV0C+mw/dYSjNGU9/OpS00d7lJ6GkKhbXSK4lgOQma/yROV86RJpRe7JiLMVywMZPmf07PaXXl6B3GFeLItel/tyfRd9/oNdEJtF6f+GYbz9hhexhi3FuXaGigi06T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xi9cJmcT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756134392; x=1787670392;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1NHTpzuJIT/fKbcKXwzyHeU6l+CF3ZH/uGuzx9DTVp4=;
  b=Xi9cJmcT5y0Zoy7dNRjhXqL4boliKwzwAxxsfAk9Q2DCbfReWb03anTn
   /RgA3jWGY/A5THkVQRRDM43frz2tZn3rusz6pS0dHFrkUIxuxHO9lUcWz
   ey9g8AhWN1sR96TfaLlMuhAlZxQmYTOkao/8lCzFJpEqtltR+M20TnHZJ
   yyQwd0065YBHFFSVkIObAJr6m2B2hqi+inetgnd/Cco4hNcnQHYlf/J47
   hn5Zv2iUPBN2BSW75vVYWm4qnzTbsXjHmUeU1xR8u0ADW61N95lYnnjdd
   v6wJDPP6A65FjxCSxKnYSsU8vh7sM0eimrHL0cmo9Ugzx2+wc1eGJCBqy
   g==;
X-CSE-ConnectionGUID: dWRA8GUwSa6LCwbAKMSsFg==
X-CSE-MsgGUID: nr9JKPYNRFOg/hWT7G1sHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58291946"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58291946"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 08:06:31 -0700
X-CSE-ConnectionGUID: G11imIoLT1qhzg3Hcj2PJQ==
X-CSE-MsgGUID: 6yapi8CaQfSRgzvX3Fj7LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="173504020"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.247]) ([10.247.119.247])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 08:06:27 -0700
Message-ID: <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
Date: Mon, 25 Aug 2025 08:06:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed
 linearly.
To: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org, fuyuanli0722@gmail.com
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 2:15 AM, fuyuanli wrote:
> Since the CPU selected by schedule_work is uncertain, multiple link_event
> callbacks may be executed at same time. For example, after peer's link is
> up, it is down quickly before local link_work completed. If link_cleanup
> is added to the workqueue of another CPU, then link_work and link_cleanup
> may be executed at the same time. So add a mutex to prevent them from being
> executed concurrently.
> 
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v2:
> 1) use guard() instead of lock & unlock functions.
> 
> v1:
> Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M930t-N000/
> ---
>  drivers/ntb/ntb_transport.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4f775c3e218f..eb875e3db2e3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -59,6 +59,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/mutex.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>  
> @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
>  	struct work_struct link_cleanup;
>  
>  	struct dentry *debugfs_node_dir;
> +
> +	/* Make sure workq of link event be executed serially */
> +	struct mutex link_event_lock;
>  };
>  
>  enum {
> @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt =
>  		container_of(work, struct ntb_transport_ctx, link_cleanup);
>  
> +	guard(mutex)(&nt->link_event_lock);
>  	ntb_transport_link_cleanup(nt);
>  }
>  
> @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	u32 val;
>  	int rc = 0, i, spad;
>  
> +	guard(mutex)(&nt->link_event_lock);
> +
>  	/* send the local info, in the opposite order of the way we read it */
>  
>  	if (nt->use_msi) {


