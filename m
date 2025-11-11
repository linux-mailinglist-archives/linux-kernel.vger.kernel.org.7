Return-Path: <linux-kernel+bounces-894925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B78C4C756
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2CD8343F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791E3757EA;
	Tue, 11 Nov 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mL/VzBHa"
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320E2561AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850975; cv=none; b=obk51XjD1fDLBD/6qhlybqkWwaLbI6c2zNI8gkmM/nNtwQMDjSDHn3nU3JBrijhH1h3tWMuYud8XEFeJO4h74FWNacbR0b5viDtINWFfVIcRrJm7cXjFW5kOml9pe8AVIoH1ptzSHnAN7t06tSzIpsXMsSTu3vjY8HLjCZK8DQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850975; c=relaxed/simple;
	bh=3KgTt8ZAoJFGlhBsCdLEdKHx84sD5ovia/hV0vx1TVg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rjZqqr1AyBPiTHwzCVfy2vbpDPm6oRHPDnaZJ93W+VznYwOztMC/8sYedoZJkj0U45jUTC0dHltOCpPKps7o6xw4yl0+XNTc3NhMe/8hCs9vHOFtJNerXOhVcUT9JZatF2FIUiubXaTx9JdjFgJY1v9M3/f5FEcZg519UZ2ZX30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mL/VzBHa; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id IWtvvLa7iU1JTIk4CvdM2S; Tue, 11 Nov 2025 08:49:32 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Ik4BvXs3V9m9eIk4BvhSeK; Tue, 11 Nov 2025 08:49:31 +0000
X-Authority-Analysis: v=2.4 cv=eMQTjGp1 c=1 sm=1 tr=0 ts=6912f89c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=F0GicbU7tRTSLTLZ85HXVw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7T7KSl7uo7wA:10
 a=nIWqaF5DGeDNdwXvIUwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XU9jZyuTWIB29Sv+8FJ4Bsp2R0KnLhXHALKjykygo7M=; b=mL/VzBHamT4V0Unxgjx7l5za+A
	s1Um8KTNsCO9Gkfg8USgz/lMr+Afy05+Z/QcOE6UyTDcLYGLofhzARrF3GVifY8g+Xv86YQlDoY5D
	+YLhfYjQ9g+SxWBItLeRyFP0DxTvZ7kAzYhH9vIZSv7DE6okwfpMCXqwT28mWp7WsIGCWDkNpcmKl
	8/6a/gEBTK3YYnAd3vHP+HSFMzH6IpvAMU6BZ+52OKcDWcxIjoyG7Z2Ud4/irbjT/UfDyZEQl5iKI
	ToZVOo1qh6AdE49MMzy4LdFCQArSj8mZBu5rXg7ee5sySZFqemCJH+PZ0H3gTrsDBPIYx7V8rgQPi
	KepuOaTA==;
Received: from m106072098064.v4.enabler.ne.jp ([106.72.98.64]:53302 helo=[10.221.86.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vIk4A-00000002W6u-3V16;
	Tue, 11 Nov 2025 02:49:31 -0600
Message-ID: <3d50e0a2-77fd-4c87-bf74-8ab8b6b15ce2@embeddedor.com>
Date: Tue, 11 Nov 2025 17:49:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iommufd/iommufd_private.h: Avoid
 -Wflex-array-member-not-at-end warning
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Nicolin Chen <nicolinc@nvidia.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aRHOAwpATIE0oajj@kspp> <aRIoufDcyohFWQz1@Asurada-Nvidia>
 <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
Content-Language: en-US
In-Reply-To: <36cc3b51-601d-4412-9dca-9752e2d77a51@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 106.72.98.64
X-Source-L: No
X-Exim-ID: 1vIk4A-00000002W6u-3V16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: m106072098064.v4.enabler.ne.jp ([10.221.86.44]) [106.72.98.64]:53302
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBw8SPi2sbBl8nvmKJSNp9ufK05afPu3/6000Bwx610iH52a1iUkG3m4Lg846NKMApcKctczFjq7ygEcvX3V9j0yywF8qZKT0keXMpzQdmK+/VJ07JTE
 Azz6g+HIUreKXMqQnJqlDxp6ZU+qGikKO4r/RMTeX2/x8m9hfgdY/7ZRtCg4CCid7Eias0AEi7SlGMaoorVOo3LiYRqOIGizFTnhEkZTjtl7njbSCDG+osWc



On 11/11/25 16:20, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/25 03:02, Nicolin Chen wrote:
>> On Mon, Nov 10, 2025 at 08:35:31PM +0900, Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>> getting ready to enable it, globally.
>>>
>>> Move the conflicting declaration to the end of the corresponding
>>> structure. Notice that struct iommufd_vevent is a flexible
>>> structure, this is a structure that contains a flexible-array
>>> member.
>>>
>>> Fix the following warning:
>>>
>>> drivers/iommu/iommufd/iommufd_private.h:621:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array- 
>>> member-not-at-end]
>>
>> IIUIC, there might be data corruption due to this? If so, I think

Okay, I didn't find evidence of data corruption. So, this patch can be applied to
a -next tree.

> 
> Yep. Also, after taking a look at the commit you mention, the counted_by annotation
> in struct iommufd_vevent is wrong in commit e8e1ef9b77a7 ("iommufd/viommu: Add
> iommufd_viommu_report_event helper"). The counter, in this case vevent->data_len
> must always be initialized before the first reference to the flexible array:
> 
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 6f1010da221c..21d4a35538f6 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -161,8 +161,8 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
>                  vevent = &veventq->lost_events_header;
>                  goto out_set_header;
>          }
> -       memcpy(vevent->event_data, event_data, data_len);
>          vevent->data_len = data_len;
> +       memcpy(vevent->event_data, event_data, data_len);
>          veventq->num_events++;
> 
>   out_set_header:

I will submit the above as a separate patch.

Thanks
-Gustavo


