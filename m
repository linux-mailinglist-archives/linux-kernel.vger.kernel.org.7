Return-Path: <linux-kernel+bounces-726182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95AB0091C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FF71886BEB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703892F002D;
	Thu, 10 Jul 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDO8tI3t"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C902EFDA3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165807; cv=none; b=fxNjv9Whv7tDEcnIe5XJJxUiIaIR8LceK4vnG/yDcewDCCnUTPaKFrPBxbeWCYnc898KQiXijXUAbL/fTORwDhNorj/qtRFyot+1eG6LUciA3gxQPkF8bVXmJ4lrPR9Mi9TG7O1FHgT3iZvDioc8Tm6GdAqsrVTqnmqZMVorD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165807; c=relaxed/simple;
	bh=FL1g7AAqZse2G2GgfyKga3py6hCil3qJCjBWU6lZuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BScnswGOqCVvFW7+UVK2i4KqjGfrJ10FOSEzHjb7UhzNrAp8MFdoQjUU++1dBxYYgGrWfQZADiWJFKveVZMTBhkJbF+jjn/fUVL3Gd45YEDUz0ulTYs9mQGNyQnbHAMj3IesexNIPR/YbdCggGAbq4iwJ9yA5BdemFFO76+3kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDO8tI3t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237f18108d2so3875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752165804; x=1752770604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=mDO8tI3trph7Q7JCSujSBTzLMo0Dca9w+tnxTk1Z9AxTmypcTu9xM3d5v6X4Y9aDPR
         qvT7kLoghGCVduxDadhOfisxcw5UghPWM9/4GmXMhy5GZhgA3e6/Ysuldp4RiY3UqRdW
         WrsHi5qi7zczH1pSQJCRKMEOnmFrJvc8xoOUV2LSbRtWVuRKYPknQs5B00kZit3XMbaG
         u2aWPRu1E8Pe2myaDn0QwYrXROD+EIbA69jI/yFXi+y6y40mO/a6ws4u8h7xJDHtkWB9
         ZoViebSMvBSqM2X03ZCmCWZQWYyrcVnT1TYGv90j4J50wLt6GGwbi1zz7iKhyYKauS9e
         XWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165804; x=1752770604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=BK9hVz+NBhsFHGajnpoerPz90fYXxyuXt/Gy1CKAVrjFnKY+gdegqva2708mRFZ2U9
         DyDWN9O4EXSVaAv8zRJLl26uxWg24BNBKYWruHFHkUoWnvHbdO/azeGG/iWbscQCz3eC
         syICc4Zj2y2ADzXxeH4dl0OL7XzpROJYTukwNp59FvY6jwPLdZF7sPQvpz+IALkmn98g
         63yrihRzHW3BHxakLkjeIhLxjbseKsY4Q7BoqnC2Mq2rSu8d1+Jrg5dvitIzDjvQf9IM
         KE834ETCfO6McYy6UO1aqlphe6UdoU7xVplpplg4IfHRWCLgvpkPh9wDrB6BmeUu82TA
         mkBw==
X-Forwarded-Encrypted: i=1; AJvYcCXbtXb5OSaPQahggiHHoksRC8p7U6m6SxUfY8TNk22C/JSZZDMB2mEvVUHlpKtID40rJfdIA9hLsC0eq3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIzU33Bzbw4lF4ZJ8edrSARoSaMn7gD0cWf5wL/tmwEvzLph4
	KjmSCHGwp0mBF1/w/NeJrLDZZ+azFOGxjFyaQ8Gq3uwyXB3LRiNCgQEf212svsctOw==
X-Gm-Gg: ASbGncvuHNDIlclyQq4xENXeDdNgZaefMGNrD9+sCpZ+nJNji0FPHya0SlwDi7nuQfz
	0bF2IIwdpjIv5CGdiENxl0GEkTs1XSzjfcWFBdA162ifY/YixWB4iX86K29ydgrCkfbNU2mfBt4
	/t+9UkrHTdlVRhKXi24X+N38+OCEiAZch34EMwW/Dn1MqKya6uhNdZeuanfX+wnqKUX+bdc2Q67
	N6z7ns2wTIQsoSVmf6yrK0qPUcyKAljKKZ5Tt6MKFkv8fHTYm1po+JPyLaYLKZab12IpJ2zJMeN
	5OO802bye5n/+WDAEDrorXfkGj2jqF9cRnKTSP1Ngdlikj31NoFFkvsAqeJxjgsR5JSDuQhqK7o
	HHypi4fp8zUJrYWPAe2iLp7mLKpGDqk4=
X-Google-Smtp-Source: AGHT+IEFm5EK2K+aFRgM2luBkKYZSMINjT3NZbf79E/WEwhVEuFkFUby27jaM+gbx9d+ftRkB3XZMQ==
X-Received: by 2002:a17:902:e94c:b0:234:9fd6:9796 with SMTP id d9443c01a7336-23de43702c4mr3052595ad.19.1752165804369;
        Thu, 10 Jul 2025 09:43:24 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435c2e3sm24897415ad.226.2025.07.10.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:43:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:43:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aG_togvop53dLSZM@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710153202.GO1599700@nvidia.com>

On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 11:09:26AM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> > > Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> > > add a negative test for an unsupported type.
> > > 
> > > Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> > > is complaining.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > 
> > Note: I see a couple of warnings while building the selftests on Jason's
> > tree, but these seem unrelated to this series:
> 
> This is fixed in v6.16-rc5
> 

Alright, this was on the `for-next` branch when the head was at:
3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
iommufd: Apply the new iommufd_object_alloc_ucmd helper

But I see that on `for-rc` [1] the fixes are merged.

> Jason

Thanks
Praan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-rc

