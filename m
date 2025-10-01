Return-Path: <linux-kernel+bounces-838465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9FBAF399
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2423C80A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C62D7D42;
	Wed,  1 Oct 2025 06:23:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553551547CC;
	Wed,  1 Oct 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299790; cv=none; b=RWwmDCNfSX9x4COBDpRFuanAovxUVVyv054pWZN3CeHtrj3/j8eNRm5ftRHG4yKrJqulK6Bql97fPhKycZMlDgAEIrA7Nw/wppkvbFCiK0B48xoVExc0/vDf8gOBemxrWXGG8pG4+3pHwHQigBK7M8oayB5sanDMyD7ZN3iHtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299790; c=relaxed/simple;
	bh=XWiTnvz4Y+70vsPTxHbzlRhkz9uhp4rhanDjXsmK0jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly3GzY87epyw0BWcWU+Ii6X3SSTQZCw1culPMdok2TgdITSOcCMc5fPkeHRVVN9smdiEyEaCKKVaEbDrf98OLiAeYKsRT9EO+P1HIVCu1u0UEPEhjWOYJPS2NWOw2yxzi13KGsnyhK3s9GG8cMMCrl+S52uzadwXD1lBgWpJf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p57bd9782.dip0.t-ipconnect.de [87.189.151.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CBA3D6028F357;
	Wed, 01 Oct 2025 08:22:38 +0200 (CEST)
Message-ID: <73fdb56c-df62-4576-8602-fb330cac0dd7@molgen.mpg.de>
Date: Wed, 1 Oct 2025 08:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for service
 ready message
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Baochen,


Thank you for your patch, and sorry for the late reply.


Am 11.08.25 um 11:26 schrieb Baochen Qiang:
> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> failing") works around the failure in waiting for the service ready
> message by active polling. Note the polling is triggered after initial
> wait timeout, which means that the wait-till-timeout can not be avoided
> even the message is ready.
> 
> A possible fix is to do polling once before wait as well, however this
> can not handle the race that the message arrives right after polling.
> So the solution is to do periodic polling until timeout.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
> 
> Fixes: e57b7d62a1b2 ("wifi: ath10k: poll service ready message before failing")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://lore.kernel.org/all/97a15967-5518-4731-a8ff-d43ff7f437b0@molgen.mpg.de
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
>   drivers/net/wireless/ath/ath10k/wmi.c | 39 +++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index cb8ae751eb312109f74985580065c3b9d3806d51..e595b0979a56d3110ce0acf534e718a4a1f36a0b 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -1764,33 +1764,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
>   
>   int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
>   {
> +	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
>   	unsigned long time_left, i;
>   
> -	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
> -						WMI_SERVICE_READY_TIMEOUT_HZ);
> -	if (!time_left) {
> -		/* Sometimes the PCI HIF doesn't receive interrupt
> -		 * for the service ready message even if the buffer
> -		 * was completed. PCIe sniffer shows that it's
> -		 * because the corresponding CE ring doesn't fires
> -		 * it. Workaround here by polling CE rings once.
> -		 */
> -		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
> -
> +	/* Sometimes the PCI HIF doesn't receive interrupt
> +	 * for the service ready message even if the buffer
> +	 * was completed. PCIe sniffer shows that it's
> +	 * because the corresponding CE ring doesn't fires
> +	 * it. Workaround here by polling CE rings. Since
> +	 * the message could arrive at any time, continue
> +	 * polling until timeout.

I would have also re-flowed the comment to make it take up less lines.

> +	 */
> +	do {
>   		for (i = 0; i < CE_COUNT; i++)
>   			ath10k_hif_send_complete_check(ar, i, 1);
>   
> +		/* The 100 ms granularity is a tradeoff considering scheduler
> +		 * overhead and response latency
> +		 */
>   		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
> -							WMI_SERVICE_READY_TIMEOUT_HZ);
> -		if (!time_left) {
> -			ath10k_warn(ar, "polling timed out\n");
> -			return -ETIMEDOUT;
> -		}
> -
> -		ath10k_warn(ar, "service ready completion received, continuing normally\n");
> -	}
> +							msecs_to_jiffies(100));
> +		if (time_left)
> +			return 0;
> +	} while (time_before(jiffies, timeout));
>   
> -	return 0;
> +	ath10k_warn(ar, "failed to receive service ready completion\n");
> +	return -ETIMEDOUT;
>   }
>   
>   int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)

Great to have this improved upstream!

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

