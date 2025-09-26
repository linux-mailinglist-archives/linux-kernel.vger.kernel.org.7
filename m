Return-Path: <linux-kernel+bounces-834575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5DBA4F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB20D4C424E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B3727FD46;
	Fri, 26 Sep 2025 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCyokDs4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149E27FB2B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915378; cv=none; b=Ox2Jd0RuMO3Up7V6mD2SDtXDpKHrYL+aXo3U2EqiKbHjEeGQ0/Nq2qFVwiJdNEoiwGmETm6TKpshC6XSPxWnlaiRNGDUGcvOVhP38A6D784Y0vksLtu8HqkkmJMP6OxsMtdtsijOQ0d0WwpiiA9V/8u9kpSwj6f0KSsDMsEazB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915378; c=relaxed/simple;
	bh=uuIq1t4c7qGDy0Lsti4d3Xt/7BKE5D5umR9UNUEgDjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZi8h1DxfbowSK7G24Y6OvZrKpaBAZm82lZi/HpFT4OU+xERRQbZu647pSdRi9NgwY8NHuZd5aTB7U7oFL9WhSMqujAXjk5q79MfsxtM+NEOsS0u+2tILwNBkOmD3K5gclNDizjcfANRcRAVv1+ebFNzFOCoLl3wZ9ivTclGljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCyokDs4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758915374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjnw97MU9jbLsmf1Uqxw2Nci38Y0dPqhhgHU46NMhgM=;
	b=iCyokDs4VyUGQceifZAlObyTJn1p+3XZvw4vxy9DWyp8NdICnf9LePnuPRT8+/HgRSrAj9
	2uh1vpFZBqSLnHf8g9qqAQ46PQG3/JusMo/ph3/NOZGrafblNVkOYVq7/f5etIecX9TQwe
	867PP5vrC0XLL7RFHt8xQpKzN/XxdNw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-UrqKQavuP5iDAjtOrDEYHA-1; Fri, 26 Sep 2025 15:36:11 -0400
X-MC-Unique: UrqKQavuP5iDAjtOrDEYHA-1
X-Mimecast-MFC-AGG-ID: UrqKQavuP5iDAjtOrDEYHA_1758915371
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4257e2f44e9so5750885ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758915371; x=1759520171;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sjnw97MU9jbLsmf1Uqxw2Nci38Y0dPqhhgHU46NMhgM=;
        b=qP49Hrc+8J8zHFxvg5o/5pf5zztbzr1WG/HNfHCY5Y/cPtKciAWKpDmg8GBqZzdid7
         NrTge3kAlJza2NzAZ6vdO8sQeQBQtthUSCBHwObbeqhj4M/GmUIzzoSGbE82GEPl2FI5
         OXySLSsWcLb9TIS2DTLANAyeMPJZXa8GrcPuImCIupL8M8lGzVAqDav70QLVhxnI+DH2
         KwLBZ16/Z/qdgoRlcgrl8HlPAzxIL6disscT/u8pf0PdKReRDH2kKaxP6Sl8Yp+gHf0C
         s3yw2PzzSvv8yBVBmV4Ab3HcT8sBp8KrqlQZJk6cUgzrIIsjKGSw9bHBo812qsB7Wdwu
         vTOw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxHh6ROFwcpt4wWZqHS8We8x9aFaZG3GPg0eGCHXJ0jfhnR0TRGieyz1cKFu/CbCgUhJmmjOeALOXGq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCglSW5gPZlI4zw3qCtEuPxdy/gaXxsKXJ7KlG61NCtwI4IwXa
	Cwg4CbfFEFj+g5CUtWN9RVcHAdICVs4Jp9m/Tb8hMfBRTqQueFXtjNt6jG3vcPbFq5PBWAT/eUx
	9TM+ZecuOKQ5FsO8HS9mZbsT44x4fRIXIvLcA5hTnyqW/fRLtRmnQ58LV3WGDAHmORw==
X-Gm-Gg: ASbGncvwp5K/uqM0Oc2mZ9jsfsqH6Q+qM539T1UuaAlEKvdTis6z0dR3oPxYphO/M6E
	7ESrtZANg/hi7HJrT2VpDUqNBnSLiKnoAv/qCnl2lE8nsf6SjghGp7LyT5NDmRqJs209HvZAs67
	3ucMJRYL8TQMRuCRZukE5vjZe+jJHXKPIg1QSSyXoqs7UNqzR8gYQeJYRZbI/rYQWv5Jz40nGDA
	a0QxJZMFijSp9PPIwc9QfTkyJpy2ZY9VbeTmhCwkrYNDV1axxa2RggIkDRBDRTJvdOKxc/xpyTs
	rrHYbChvLse6YUOkln+o1H6LHOeRaF09b+sViMapG5M=
X-Received: by 2002:a05:6e02:1523:b0:425:9068:4ff with SMTP id e9e14a558f8ab-425955c8eb5mr44103245ab.1.1758915370844;
        Fri, 26 Sep 2025 12:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5kwS0VyoWACtgc/kvwMhl9hpO10Z/0kNKn1tSjerc+aPGklJvKL8PA+MiMW+9wzh2XQYqfw==
X-Received: by 2002:a05:6e02:1523:b0:425:9068:4ff with SMTP id e9e14a558f8ab-425955c8eb5mr44103155ab.1.1758915370427;
        Fri, 26 Sep 2025 12:36:10 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425b9133085sm25262705ab.0.2025.09.26.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:36:09 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:36:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: ankita@nvidia.com, jgg@ziepe.ca, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/nvgrace-gpu: Add GB300 SKU to the devid table
Message-ID: <20250926133608.4963f2bb.alex.williamson@redhat.com>
In-Reply-To: <20250925170935.121587-1-tdave@nvidia.com>
References: <20250925170935.121587-1-tdave@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 12:09:35 -0500
Tushar Dave <tdave@nvidia.com> wrote:

> GB300 is NVIDIA's Grace Blackwell Ultra Superchip.
> 
> Add the GB300 SKU device-id to nvgrace_gpu_vfio_pci_table.
> 
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index d95761dcdd58..36b79713fd5a 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -995,6 +995,8 @@ static const struct pci_device_id nvgrace_gpu_vfio_pci_table[] = {
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2348) },
>  	/* GB200 SKU */
>  	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x2941) },
> +	/* GB300 SKU */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_NVIDIA, 0x31C2) },
>  	{}
>  };
>  

Applied to vfio next branch for v6.18.  Thanks,

Alex


