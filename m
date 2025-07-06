Return-Path: <linux-kernel+bounces-718289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC345AF9FAC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F7517D1AD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jul 2025 10:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E427A930;
	Sat,  5 Jul 2025 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="Z5qpHdf6"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D862E36ED;
	Sat,  5 Jul 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751709879; cv=pass; b=LFmVX9QfUBhCXVOaAQ48TQvgrDnw1Eo3crEk/QN8bsm1QBwWdvzDqeZV7FgBUfPhuziD/0fiWRhzwaPkkMa1ol8ycy6SoIq8WWFPZEZYplN1OOP1o6TJOBBXt0tZYPOwiET865TOvWgnJMjXbCmi7KN3u4a54CNKje+CcouaaD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751709879; c=relaxed/simple;
	bh=AFm0hKYWXZnKo6+zcZUUrSRbxBkQoLoEP1go/dH+c9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1i7ZzvHgixqk2/I4oW7LbAcMZclbJxJui+ZKrbXJE3/zHn52dRMKuocUeVX8BmTMw7jy8xUzLXrYg0fI9jFNTNidAGkqMi0EpThJoj1liqR7upSPV5HsVVsk2Ln6IZyuOroGk83dwVKLZmWN5YoHA2dHexPZ0p1+m2iOMH7wSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=Z5qpHdf6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751709851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XuHk2ri8GSG4lBxChP/+R6h/v0JjJM7fresgHKd0dLQn7uzcCA0hY+emJrQhYBCdOSc1ZM+3CQfTZ51403WyvoVQyaVlV8C1KuhVhrRyyQ/q4h6xdYleLuY9wCU4wCYYQKmDFDpn+onBU63L3ZpmEm2vlSZtRNA8gRSK7vxB068=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751709851; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RviDwvDQqjYXFY5scaKMdpbhX+ttH9CgIKwYVhmfk4c=; 
	b=GpxsAABxo7BDZ6TD42gmws+/uPa4EuRGWNAbg3Rha+bP6/vul0ntR2oOKCf9Be0LOVfVit1MF1q+uARLbBFIGS8RsjHocvx/pdESm12H9czkFj+qz7IaymK1tkvgqkmSBVqs4fYBu49sGBPo9FF28P+l2nOlkgWBPwD7Ve9VFXw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751709851;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RviDwvDQqjYXFY5scaKMdpbhX+ttH9CgIKwYVhmfk4c=;
	b=Z5qpHdf60CuJzdWjIWkZgUznVTXkHbdc/Pd/98TEepfRGmwJBpxsOnPmOJd4VJcM
	gvGlpvMDBtOfKFQsL2IIU4x5AjB+k/uBMIE2mos1U25Y8u2LY+n3gClKyXzFeaUFYfS
	LrwqKZSuON4ppy5BZR7SqslbdI6ChRjO+DRCEjWs=
Received: by mx.zohomail.com with SMTPS id 1751709849751114.53291093115388;
	Sat, 5 Jul 2025 03:04:09 -0700 (PDT)
Message-ID: <62cead85-2d50-45f1-8020-7aea77f6833b@collabora.com>
Date: Sat, 5 Jul 2025 12:04:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
 <20250623153931.158765-4-benjamin.gaignard@collabora.com>
 <20250704175425.GM904431@ziepe.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250704175425.GM904431@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 04/07/2025 à 19:54, Jason Gunthorpe a écrit :
> On Mon, Jun 23, 2025 at 05:39:27PM +0200, Benjamin Gaignard wrote:
>> The Verisilicon IOMMU hardware block can be found in combination
>> with Verisilicon hardware video codecs (encoders or decoders) on
>> different SoCs.
>> Enable it will allow us to use non contiguous memory allocators
>> for Verisilicon video codecs.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> change in version 4:
>> - Kconfig dependencies
>> - Fix the remarks done by Jason and Robin: locking, clocks, macros
>>    probing, pm_runtime, atomic allocation.
> It broadly seems OK to me
>
> Though I did notice this:
>
>> +static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>> +	struct vsi_iommu_domain *vsi_domain;
>> +
>> +	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
>> +	if (!vsi_domain)
>> +		return NULL;
>> +
>> +	vsi_domain->iommu = iommu;
> So we store the iommu in the domain? And use the iommu->lock all over
> the place
>
>> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	ret = pm_runtime_resume_and_get(iommu->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	spin_lock_irqsave(&iommu->lock, flags);
>> +	/* iommu already attached */
>> +	if (iommu->domain == domain)
>> +		goto unlock;
> But here we don't check that the domain matches the iommu of dev.
>
> This seems a bit weird to me, I didn't quite get why the domain uses
> iommu->lock instead of just having its own per-domain lock?
>
> But if it does use iommu->lock then this does need to prevent using
> domains with the wrong iommu because the also use the wrong lock and
> then this:

I would like to avoid that but maybe a static spinlock can solve that problem ?

Regards,
Benjamin

>
>> +
>> +	vsi_iommu_enable(iommu, domain);
>> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
> Is not safe?
>
> Jason

