Return-Path: <linux-kernel+bounces-686369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE6AD9676
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 22:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D8617D8A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72A25B1C5;
	Fri, 13 Jun 2025 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efMSumBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26942580E2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 20:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846892; cv=none; b=LkPyP+ouIpDAqaUekWE13WtWs3PW/QfClqBiIVtcUwqV8dm1/zfZnqQEp4nrM6rrf9RQ/aM26E2ZX+0/SaKq52xLcCcNpbRtk7FZQuJ4LDa4QvP0GUj1owDZt+BvFuB2LEBFxFLFe2BLRmpuEY1XGgnGpRA+EEYKwAMiCDhcVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846892; c=relaxed/simple;
	bh=U+QYmARSwcbzvZ/i5KLxyqmIuYaY0pIfNjwmsmfFJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZZWqw+wUQaiqccOXF4+frUqmkqH+LXk2ZiTKcuNJMSTlkaXw70NcSZMu8yvAv9HcpS3u/aTc3GsnsBbxrDjaqrjKyDPMNZNL7KOb0xFZ9Z7iHJslGIe3DmbrzpAGLx/ufg6v4swW29o3e6as17+j2+HMQ0S6lVM/NXOVt7Cqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efMSumBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749846888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqJYpZw2kfoWO8TuT9Cszrg+UIQ9YyscpMrbGv4wYIk=;
	b=efMSumBuTbqLWCV3bxTiwPz+ClOPzzxvb+0Z+9BNnjIEnqVpP1ZZTETBpBFAbe6OYMOs/H
	XjanPmpKss1yqtvpy5QNDW6zUG36BfywKlkeJKjfifeNPM+oOJ6GTBVTMQAIUyQGR2C/Hp
	lQdnmg7zxtCTjVD1aypFcnga3eMkQvg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-NnXLubk3Mm-MFH-yOj4U6Q-1; Fri,
 13 Jun 2025 16:34:44 -0400
X-MC-Unique: NnXLubk3Mm-MFH-yOj4U6Q-1
X-Mimecast-MFC-AGG-ID: NnXLubk3Mm-MFH-yOj4U6Q_1749846882
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D93918002EC;
	Fri, 13 Jun 2025 20:34:42 +0000 (UTC)
Received: from [10.22.89.154] (unknown [10.22.89.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C34F1180045C;
	Fri, 13 Jun 2025 20:34:39 +0000 (UTC)
Message-ID: <45bc529f-0949-4d3c-a9dd-e7a30eac22ea@redhat.com>
Date: Fri, 13 Jun 2025 16:34:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] scsi: fnic: Set appropriate logging level for log
 message
To: Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
 mkai2@cisco.com, satishkh@cisco.com, aeasi@cisco.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, revers@redhat.com, dan.carpenter@linaro.org
References: <20250612221805.4066-1-kartilak@cisco.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250612221805.4066-1-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Please move this patch to the end of the series.

The most important change here is:

  [PATCH v4 2/5] scsi: fnic: Fix crash in fnic_wq_cmpl_handler when FDMI times out

This is the major fix and and it should come first. All of these other DEBUG PRINTFs are less important.

Thanks,

/John

On 6/12/25 6:18 PM, Karan Tilak Kumar wrote:
> Replace KERN_INFO with KERN_DEBUG for a log message.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
> Reviewed-by: Arun Easi <aeasi@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic_scsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
> index 7133b254cbe4..75b29a018d1f 100644
> --- a/drivers/scsi/fnic/fnic_scsi.c
> +++ b/drivers/scsi/fnic/fnic_scsi.c
> @@ -1046,7 +1046,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
>   		if (icmnd_cmpl->scsi_status == SAM_STAT_TASK_SET_FULL)
>   			atomic64_inc(&fnic_stats->misc_stats.queue_fulls);
>   
> -		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
> +		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
>   				"xfer_len: %llu", xfer_len);
>   		break;
>   


