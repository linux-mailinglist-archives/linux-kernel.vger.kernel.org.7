Return-Path: <linux-kernel+bounces-829908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDCDB982BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5380E2E4E68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C3922D4C3;
	Wed, 24 Sep 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+FwMZtf"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB521D3F3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687008; cv=none; b=Thz4UCEOgC3Qt4lRA7U0DtWFboZ9s81h4v6PlVyxUhh4ekVNgNOibnrqKvrvLQlK20GkjGpM6NI1MzoZDMP0EMt+akGaXUZn0zfX0k8Wt0qQ9SdGhxSfMtxsRlb/s1ZTLSx2J0313FOmhYC60TZNvIrmSrUSZL8RylGJBXTOsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687008; c=relaxed/simple;
	bh=3cI83+kMvCnvPKEAmgUH8Iw4iz9w4uzn9IGXgv7zKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6uDW2IL6Uf51D+gKesFbN8TWFwaQndHljkKwuEhpCl3XVcL6uMKXHhzCmo5GRVqxf1FpCV+6vkXifqFpq4KqqFqdXb9JTU35rZh2WaLmUJa4GlOJtcHeMQ/5CDfWHv56UVKuzRURk6Ww0HTJdyW1A/MmrrzFEeM0BlRtDMM9D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+FwMZtf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5276279b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758687006; x=1759291806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upnQzhj0lASnjo/ISsvGDWKyy8Ak/c4h5JmJhqwTbLY=;
        b=R+FwMZtf9G2+cvOWY76Pk7Nf2plieKy+SO7KrI2VOqcwF8auZ8+F5lXk+dARd8ir3H
         vIVdWnjwdNc8DTeKO0bqsKDQSkiJYYTJwfqfkw92zbVHxADUvPe9azuxR1jk8cKHkjXf
         +8f4iICl3/RUqkjHwl/wvXjbAi/4k/dR4cmS/xissZmrArP7CZN3CKo9JSZHGKfyrY76
         GujOulMlZdyr5zcRpRMBmpOC51Bgslnrc672pA5gIrYoOytL2nUToNgcqsr2LaQxFZhL
         aMNwStQaYARGnzqFOyiAi4rcGeSH9aBS40Z42kPix87oimzUpdf2gpQ13DK1U6cMXubM
         iZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758687006; x=1759291806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upnQzhj0lASnjo/ISsvGDWKyy8Ak/c4h5JmJhqwTbLY=;
        b=iFZfMYOTk49rfKq/7OLDIWjbZhnlUPubXQ3lRlwLzHjt14ZmzMBaNkiU+NhsyRT+jb
         Tqx/cyZryXLBONYE3JTevMEvb70URLHnxps1xKcetnSZC9Akv1g9g2UODKjfFpzrLK0j
         nCU3bD9k/Utc1AqEIbvo88MNXgeAUkbH7YRwCpUHIesTP3zaFYkGMtZ/fbq+aXE6uEQS
         MGyAy4YEIyYoaEZwHYJ63K4XDID12d3RtKFPuG9pHoeUsj4Yici3SlQPUV5UJCUrI+Vz
         3QlEG37+yMYSLNhIeTkMH77iWRfiJf7I/52BQ4Ngb/pYR1qBiiP8zvyvv5/zb7ErF+02
         aW6w==
X-Forwarded-Encrypted: i=1; AJvYcCVp3fhbibmax1Bd/F20QkqNZPDVG5L4aHI0joXbJa76Z2spJkeKeKAjO6LMdpHnZQR7i+Bz5rcf1fX9Ubk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5MTW020J3hQD6cmvdQnwvBJWaZademaEVT3krH4JDw3JzgU+
	aS8c9rStGd6AQXKt9t2l2va9MEAQIBKhPzAto3oTu9Ahxl9b09TO5nTK9UoXbVKmbeE=
X-Gm-Gg: ASbGncv0OEw146Z9F/OsTgSoaCEI7Oo45cJ1JFI1dQ2wD20jQb66a3b9pSaoU10AVtR
	ChU42KWOOuZU22k1qvWZioc1uVB/LbxBwPFMKr0ti0ga8NXwgEVtUjMjWXFWjeum17OXwOCqyBO
	qSuMZ6b5ux37V3HfInc0tFsZnepxrH7O51i9VxllAe4pGnERNfL6Usvm+UwADwl2E3z8W63Pa8W
	C/reSC//KC4YbyKT+nXuVLLHK/9dc4Z7UV8YYlGRtkFfiyBhfYyoyBV5oo+EU+MHiR92Yb+LVf+
	CFj93HW5lRgn58Rce39m08XMlUAg/kvGyM0DO4oIOcHpZOvDQwWT+dj4Ts57/hy9IpW0ZO5oSNw
	YEDLEyjopTRZB1BR/xt+Y+Q3eRysChrA=
X-Google-Smtp-Source: AGHT+IFKx9ZNpDWUckunWS3L3Xe/z9wMW+hxpJY2tt8sPMBwy0PfYxAWN4p6TwNVD/MuXmdW/7jLKQ==
X-Received: by 2002:a05:6a20:7f95:b0:244:aefe:71fa with SMTP id adf61e73a8af0-2cff367ed2cmr7084776637.37.1758687006169;
        Tue, 23 Sep 2025 21:10:06 -0700 (PDT)
Received: from embed-PC ([2401:4900:60e0:7677:7e66:bbb0:5e83:be39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551905bb4csm13048369a12.29.2025.09.23.21.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 21:10:05 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:39:55 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: "Xu, Even" <even.xu@intel.com>
Cc: xinpeng.sun@intel.com, jikos@kernel.org, bentiss@kernel.org,
	mpearson-lenovo@squebb.ca, srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device
 Id's
Message-ID: <aNNvE9Bx7M6iMzTX@embed-PC>
References: <20250923040254.7547-1-abhishektamboli9@gmail.com>
 <IA1PR11MB609835ED0230AC6D60C54906F41CA@IA1PR11MB6098.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB609835ED0230AC6D60C54906F41CA@IA1PR11MB6098.namprd11.prod.outlook.com>

On Wed, Sep 24, 2025 at 03:31:33AM +0000, Xu, Even wrote:
> 
> 
> > -----Original Message-----
> > From: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > Sent: Tuesday, September 23, 2025 12:03 PM
> > To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;
> > jikos@kernel.org; bentiss@kernel.org
> > Cc: mpearson-lenovo@squebb.ca; srinivas.pandruvada@linux.intel.com; linux-
> > input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's
> > 
> > Add the missing PCI ID for the quickspi device used on the Lenovo Yoga Pro 9i
> > 16IAH10.
> > 
> > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=220567
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
> > drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > index 84314989dc53..49c8458f0118 100644
> > --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > @@ -33,6 +33,10 @@ struct quickspi_driver_data ptl = {
> >  	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,  };
> > 
> > +struct quickspi_driver_data arl = {
> > +	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL, };
> > +
> 
> As I know the THC IP in ARL is the same with in MTL, can you change this max_packet_size_value to align with MAX_PACKET_SIZE_VALUE_MTL?
Sure, I will do it.
Thanks, for the review.

