Return-Path: <linux-kernel+bounces-867233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE253C01F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BB93AB349
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16170333725;
	Thu, 23 Oct 2025 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFZJ4ezu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3466333441
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231575; cv=none; b=n7knw7qwPw7LXsOABO5LZFsGlbWYFkJY9kntpyNsppTmv5HHoBO898K9DJAmW7xdKfnnab+DeJDbdVXH73eQMmQqydJhx/y1Zd49ARMb0iFViTSsQDiJkcCAP/XeyGIoF5lCePOTHyzId8u0PUYv+/aw/6/XDianikiEY2QGLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231575; c=relaxed/simple;
	bh=JNBnkDYH4wR6V0MiUiS+6gufeKxWGxxvHeOWw3deuWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaAb1gsyjGakRAln9FFam68eQ7VQR+9vWpCxrxXO247OksmLumnzjjC8EkJetQSewdmykAjQ7vG419qU3IrS1B7DnUUWly2+xe32lAUt7wOCjjcl/xsfsOvfRG6lFI7HUrSGzYR6W7+8ULHWVq+02VpU9rUoa+k4oflrG2U7YO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFZJ4ezu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761231574; x=1792767574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JNBnkDYH4wR6V0MiUiS+6gufeKxWGxxvHeOWw3deuWs=;
  b=NFZJ4ezuEN/e8lrkdYgw4aOokEmRY2a7Wfkd+q4ELtH12KKgBxkN7YEj
   Fy15D3hvytQu21mFwgP6gOnFP01APsV7U7u50Fr5Y2ZL7iFCJvQmm0g0L
   RIDeDOFdzhRR/+OnY3qbkIAUvU+7MDCiwrq1GG/tcc392DXa7Um71ZvYo
   aYaj9H5tvK2vW7ucV3UK6zeJTztZe8eEQfzGOdiwzB1Rsa7PLVDdzG5BO
   GOknEH/GidMCdFdaMAKdVv975Uyi6//ZrWwCEf5enO1iR9mOYsAMjmN8g
   HaEs0gyvf3MPc24xMlWoxPcoQiZqQ87UYFtwn/nj5SeLAjfg6dmsSTKX7
   Q==;
X-CSE-ConnectionGUID: STV3BOxFRBWR2GQdc0HY7Q==
X-CSE-MsgGUID: eZFrDrW1ThSz6Ip7VnspWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88868916"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="88868916"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 07:59:33 -0700
X-CSE-ConnectionGUID: tzLhNoYGQEemqX2ire/dTQ==
X-CSE-MsgGUID: AipfVlmhTUSHyRh/ny/32g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183349396"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 07:59:32 -0700
Message-ID: <f703de61-5616-40b8-b9b5-08529f711e64@intel.com>
Date: Thu, 23 Oct 2025 07:59:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] NTB: ntb_transport: Remove unused 'retries' field
 from ntb_queue_entry
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com
References: <20251023072105.901707-1-den@valinux.co.jp>
 <20251023072105.901707-2-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251023072105.901707-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/25 12:21 AM, Koichiro Den wrote:
> Drop the unused field 'retries' from struct ntb_queue_entry for
> simplicity's sake.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/ntb/ntb_transport.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index eb875e3db2e3..39b2398b95a6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -113,7 +113,6 @@ struct ntb_queue_entry {
>  	void *buf;
>  	unsigned int len;
>  	unsigned int flags;
> -	int retries;
>  	int errors;
>  	unsigned int tx_index;
>  	unsigned int rx_index;
> @@ -1630,9 +1629,7 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
>  	if (res < 0)
>  		goto err;
>  
> -	if (!entry->retries)
> -		qp->rx_async++;
> -
> +	qp->rx_async++;
>  	return;
>  
>  err:
> @@ -1910,9 +1907,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  	if (res < 0)
>  		goto err;
>  
> -	if (!entry->retries)
> -		qp->tx_async++;
> -
> +	qp->tx_async++;
>  	return;
>  
>  err:
> @@ -2273,7 +2268,6 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  	entry->buf = data;
>  	entry->len = len;
>  	entry->flags = 0;
> -	entry->retries = 0;
>  	entry->errors = 0;
>  	entry->rx_index = 0;
>  
> @@ -2323,7 +2317,6 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  	entry->len = len;
>  	entry->flags = 0;
>  	entry->errors = 0;
> -	entry->retries = 0;
>  	entry->tx_index = 0;
>  
>  	rc = ntb_process_tx(qp, entry);


