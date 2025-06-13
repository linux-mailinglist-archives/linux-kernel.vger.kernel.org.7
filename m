Return-Path: <linux-kernel+bounces-686436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC134AD972A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660557B2061
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CD27381B;
	Fri, 13 Jun 2025 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY61hkJp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C79273D80
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849050; cv=none; b=mhhF54jX3xEmTU0p+TTFr65xlzxOKDvqFoHSw0ypVxMF97xYlySwoC17HmQFRD2wbaljuw/MxCieuesNOX0Efe43LP+0Rs85U6FXpBKKUD0x2B38ugXT3AMXW/daUvhFV8CAg9IHeeQcTw2HZfMOcYrYtW7di139VoxG+c3D3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849050; c=relaxed/simple;
	bh=FHAPxI/HuXRg4fJxkaPDbwP0KAPYb39etCsQBuSsyBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB4LsPDbSGCogZGPmGvnQFDJjKi4/bawN10qDIlYN5ve3xYx4JITW1YBD5MkEWVY/ZVf11CCP2O47g0LV8YvS6qCi3JCq0ThyIk/ZGcs7TOmC8fHv6LSEtHxJ+K5I6tWBJf77cYBGl8YqqI+yIQhXvb5SXMpsMjDjalPNd53h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY61hkJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749849047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNiQe0latyuV+0Nej5a3v8dTOT3R2VIrVcf+cVDytHw=;
	b=SY61hkJp5nCtnCOqoZy0duW2fU9EvnCvlX45+bMzjslStoo1CzKN6ns3mOTcejVCSPuoo4
	oAf3Odzq2T6MqF2zj8FmzHPtZJpYzUySGknPuu/rzPTWE5gAXBNGL9ztXqUk6r7I/SX56u
	/wGHmyaeUe5EJSTSAcVHDQF4zsy2reM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-C6wIBbHOOKG8kF1Hgbfh4g-1; Fri,
 13 Jun 2025 17:10:42 -0400
X-MC-Unique: C6wIBbHOOKG8kF1Hgbfh4g-1
X-Mimecast-MFC-AGG-ID: C6wIBbHOOKG8kF1Hgbfh4g_1749849040
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB281800343;
	Fri, 13 Jun 2025 21:10:40 +0000 (UTC)
Received: from [10.22.89.154] (unknown [10.22.89.154])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A087919560AF;
	Fri, 13 Jun 2025 21:10:37 +0000 (UTC)
Message-ID: <0b930c3e-0835-429e-8081-d83df811a091@redhat.com>
Date: Fri, 13 Jun 2025 17:10:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] scsi: fnic: Increment driver version number
To: Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
 mkai2@cisco.com, satishkh@cisco.com, aeasi@cisco.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, revers@redhat.com, dan.carpenter@linaro.org
References: <20250612221805.4066-1-kartilak@cisco.com>
 <20250612221805.4066-5-kartilak@cisco.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20250612221805.4066-5-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Since we are making a major fix to the driver here do we want to squash this change
together with

[PATCH v4 2/5] scsi: fnic: Fix crash in fnic_wq_cmpl_handler when FDMI times out

so that the driver version gets updated in Stable together with the bug fix?

/John

On 6/12/25 6:18 PM, Karan Tilak Kumar wrote:
> Increment driver version number.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
> Reviewed-by: Arun Easi <aeasi@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
> index 6c5f6046b1f5..86e293ce530d 100644
> --- a/drivers/scsi/fnic/fnic.h
> +++ b/drivers/scsi/fnic/fnic.h
> @@ -30,7 +30,7 @@
>   
>   #define DRV_NAME		"fnic"
>   #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
> -#define DRV_VERSION		"1.8.0.0"
> +#define DRV_VERSION		"1.8.0.1"
>   #define PFX			DRV_NAME ": "
>   #define DFX                     DRV_NAME "%d: "
>   


