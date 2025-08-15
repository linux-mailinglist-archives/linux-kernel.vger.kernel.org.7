Return-Path: <linux-kernel+bounces-770761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C08BB27EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680941D06370
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777762FFDF8;
	Fri, 15 Aug 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ykx+ouQ5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6062E06D7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254735; cv=none; b=KPZJ2V7ZJo1cS+y+wlZJ7UDlI2C+XzpafZO0U5DgNdqNLN/oaSCELAdC+rAEpmblJUdiHfx6nr2zxg8iL5juWu1i3H0bscTCB3qgla3pT5s8uMU5lZipYf6mkNnuJ+DpnX7oq2gEwaECUAlI8LeWdsGOZ71pLwjqb7HW6ZudT7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254735; c=relaxed/simple;
	bh=oD58rtSkgR9/HDrRgWtpmg1LwtWuOjwY8yU80bdRgco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnzXrDzrLOSn8SbSn0W5TJTH8wM/C7eY5JQrQpyghKVkEgnccHDSL40Jc8HeSCTYR2eClZcJkFCTaROzHxrZbxBB/URJobfHLhPDW9srfwMAmfICwm7yQrIUB2Nkxp/LYQAtH7OWaq0NrDWPzQ04y95/gyHPBi6Vp+IRlbbAGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ykx+ouQ5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d3be6484so99105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254734; x=1755859534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZOHDfnUcExL3Br23cP9r4Hw7xHtBw2wjRy9sUmDuzw=;
        b=Ykx+ouQ5usDRF8fslVV1Kbb5czF0g8Y5dO4t8zpdmMMZarGkdkpkRzwo16KVtIb/ye
         ef8yTworFpfZSM0FkCJZ7zdHCCSrXK6vTmvnTZw7V+gUZSwfyhYF4Yzmsv0nhTwX27Ld
         fmRpOMYI/5iVpLgKw3+P/ZOnFfhVwKnCsgk7X7+iwoWDuRcRwTpIy//rM36HHnnWK/6g
         DQogm7CyV/tKM6CraeybQ/r4G5Xp8qvj8ewQr/Id8hD8NyNE2ODVZ2qmSAlHuiqUyNbe
         TbxJQ2jOSt8juxyMyBeALXf+MJ5uDeBly4PdhqPjQ2YhdX0B7ezus2vZSa903qeMEseq
         SSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254734; x=1755859534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZOHDfnUcExL3Br23cP9r4Hw7xHtBw2wjRy9sUmDuzw=;
        b=EoOhahSimn8ifaXRTIYRYOUWXue0s0FjNuJLmFtC3TvO79q4+N5ICwcmaCvSo6Bc6f
         ELtHhopQp2jv7yzcVZ3IsLj7v/wg6k7tSHzpG+FQsosF+yyB9n5JzXysGBBDfzplsPl9
         ztffg/Cf/BoKk/ZzbSo2j0uaYospWhcrSRny946I2fwWYCEfvny2UMA3rA7E4VgQkxtT
         6LGLrprlIJOpzMgE3Ji6RoGtkSA/6gJQM6NcEEXbXhpF9DCANkYy1FREbQrexsSt5aDG
         Ey8REXNgl2mQ7s5KRu1PM+u6xHFBwuLvsFt1FcFHNVEnAawqeg3DnZHk7s2L717wdf/o
         MthA==
X-Forwarded-Encrypted: i=1; AJvYcCWgUAGr0surGnOhAVS8TtabIAUXcfaHXOjYm5bQ3LruuwT9wEcdtOkviOYWk94f6f/KX53rdsm/OBb/2Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwleXJeimzhV0f6QTr1NWsjlNrjPKgx+4w+eqErQzKAZMArAYvz
	emgii0dO69oWJ8rVOm7OtthW9wgKdb7omRK/OcYz9ouojRI7TEwMslXTe9rSqEoBtQ==
X-Gm-Gg: ASbGncvvoahrSXBCYs2+nK8O3RYlEwaN9iGqOv/Vzqvlcin9Ss8RzgK8cvvOdBvTeke
	pbL+0hHzSg56qJ1C4OukdTQu4XONoqrwaNJbAgWA6RwbOJPFRozNobaY6/qL8E7v8PGRm9VkevK
	BtZ9p+cVtSMqt5zwRc0p4ymmLQmSe7/7Ar/ez1pZyYIVXoFPhJ72ZCdrPC/R0cbTRVSxkXKN7O0
	/2YMiNe75BLG+8phSQ7+hzzkVs3sORMioiH7+qzvo9SG85r0S3d0t6ud4SGlgZoqksPVHL2tMpT
	fyOkzaD0lJkZqdYbtNem8KeJrAzx1DlCg1IH5vfjLQ3zeeagkWy+hIomtvd+KbdNiBYuVUPiRZd
	o00v/ryMYGjIVolT7158GNaC7DxLxgzGESiuivwdHLqHhpvb1hrWmd866mPepmISBakTzq383lm
	kJOtGYmCf1
X-Google-Smtp-Source: AGHT+IG0rikT/NZEANwZZw4qUgDRW9B6Cy5Tz+GUMNCa7cz1l4czOTgp2vuDl6rPX++zqkwkfKsE5A==
X-Received: by 2002:a17:902:f690:b0:243:597:a301 with SMTP id d9443c01a7336-24469933caemr3236235ad.2.1755254733564;
        Fri, 15 Aug 2025 03:45:33 -0700 (PDT)
Received: from google.com (208.131.87.34.bc.googleusercontent.com. [34.87.131.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cadf96fsm11524465ad.41.2025.08.15.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:45:32 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:45:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jgg@ziepe.ca, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, nicolinc@nvidia.com,
	jgg@nvidia.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
Message-ID: <aJ8PxlIP_KtYgYun@google.com>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>

On Sun, Aug 10, 2025 at 07:04:01PM +0530, Akhilesh Patil wrote:
> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
> Ensure the memory is properly freed, as kvcalloc may internally use
> vmalloc or kmalloc depending on available memory in the system.
> 
> Fixes: 2238ddc2b056 ("iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC ioctl")
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

