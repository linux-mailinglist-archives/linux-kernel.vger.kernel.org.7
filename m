Return-Path: <linux-kernel+bounces-824476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA08B8955D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B981798EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9130E0D9;
	Fri, 19 Sep 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cJ5CvvFi"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC12D2D061F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283090; cv=none; b=QX5SrBqYR0DDaMYYF/zCJkdewzL8UgplrtbEQlOhaTF/Tuk3MZk98doF03yix4d1VdGZff3jWnE2IE4HCUNkawiblBv8hlckY/zQVZhE44OzGHkka7f8KCywYWgV3oTGmCH64VPYxri7y3cREJ/3CvFHKWHiExChR47OmoWc9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283090; c=relaxed/simple;
	bh=z76f63pK7iULjhkDPA2cDB1JEhtZUbriGGo8ro5LyIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUOPBu9EFPVJj9wB2vqG5CY9DSNcEf9nFDIEvOUWTRk+NWwgXQYrWVIsrJCGBH9u+pK/JMZrCgTam5TcurL/4/6f28VMFrqbq0iNaz9cCmjMDrV6u1fFTUsreCIpAKef8JatZ5/UDQ13J7lTfTlCHF/kBrCA1agBXJGlWlqmHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cJ5CvvFi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7997a43ceso23465721cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758283088; x=1758887888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XqkzJ715IFhAdPqz34JG4QrSrgL1I3NolvpeVSTSpSM=;
        b=cJ5CvvFi4Ux+0g+c5NdMmNIvSoh9f0ftQC7qisliChqhhYmJADWMtZsVY6vpSY7DLj
         TBgjaYj/OnvG9ksqbX3WS86N8ABjCPYhprhE4/XH21TFNY9E43PpuILUj9GnbrN0KYdy
         ipUrG6JPg7GuZqbgRRadQfXMX9723oLaKMWW1vkyKhQ3MYvb2x8ETUrPgV69g/CHkk3+
         LnIDz9f7/C6qPMAthQ4jSeIleIvcDdbG3J3V2hcRB1Wvcc8inf13L5DBxq8QX0lrc1zp
         CSlkrOeh/Ky2FQoWjbOIYFUV2p6+ChCrFzm1zCxV6q2QEe4EIiIkZPtMuVSD9EN7d9Xi
         bgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758283088; x=1758887888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqkzJ715IFhAdPqz34JG4QrSrgL1I3NolvpeVSTSpSM=;
        b=l7sOhmRKX1fZ8kSSsA4p6f8Fnt/fHgvIC/3pQ46F0LmEFcBkcwc8hAh4qupgtLc7Y3
         wuwtDkVZ7ecpfxyLxYbFCx41phpDkcAjUciHlJi9VAPw9tV9JtkYUm4grwJZ0Pb2Xx2Y
         5G6gWqjru6Xepkgx/KfnaCJzqtyjtc6dBH+nI4K5hf4szGTtCOGKvPYciXhwb61SLu1X
         nY+D4G2nvhM6xSnlBRALN6YeFa4KBZWLtfRppRqOT83yKCmt7M1hVJhmyN55qre5rjiV
         5Tt4CuLESzC4v+wQlVnm2RSdRWiQQWhlz6zaZzzLRSwwdu5zVOS6V2kA2Aria6rafNf4
         p4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUfiUxDYHstffOT2mItLLtcJ8dU0TRvoSl1Nw0yT35tnG3VfYpZGrJLM9VQcX7LhRKUZmJXhg9cs4qJews=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2ZqhIdkTBpj0isPxUnXHQ1ecI2iZI985L94GiO/4FQDuLu7+
	WW2neDgLwbXy3LM/NRAEW1kYiCoE1IcrBaGvbFXrMl69Ce2w7Qreubm7yQ7kVZAqdiE=
X-Gm-Gg: ASbGncvxegV7siRFyRUw9sOZnnxAvJ8K8xjU1TyqBmCUssgV2Fr6gAF6W1w0vuZQJRU
	KsC/F36OILkTODfHZA3Od2QOdCPRhCxsu59KaM+NOtaHcZx4mDmCs6p98axZ2HppeXNX+yW+dAo
	rFIFSO4TjJUU/cvJN2K55J7rS1Z5hnrg2N403JQYoRc0BFPz9ALyIonv0g+tal95W50vZDDMBMj
	3Wd9fvgt+iw/zpkXrg4gk+FV3cTizVCKO8aa+S6mD9XaqCSX9dLy9dSKmNql2S5RWXFZuq8ABGo
	B+owh0NJ2splGYuZKF6Z/PgksUUKPGUTJJxKJgmngssuI65N5OtX+cmxjHRPfW8VwkVvDVzs
X-Google-Smtp-Source: AGHT+IHAUUCTifYO3tvHTIggD1bty3WA1tAmCInvXz11D2JOt+J25vVYjGygxn7PDvPC0VZaaS2K+Q==
X-Received: by 2002:ac8:594d:0:b0:4b2:cf75:bf10 with SMTP id d75a77b69052e-4c06cbe95ebmr27476741cf.17.1758283087738;
        Fri, 19 Sep 2025 04:58:07 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363198ad41sm325729185a.46.2025.09.19.04.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:58:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uzZkb-000000097c5-40qZ;
	Fri, 19 Sep 2025 08:58:05 -0300
Date: Fri, 19 Sep 2025 08:58:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Keith Busch <kbusch@kernel.org>, Alex Mastro <amastro@fb.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, David Reiss <dreiss@meta.com>,
	Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
	Li Zhe <lizhe.67@bytedance.com>, Mahmoud Adam <mngyadam@amazon.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [TECH TOPIC] vfio, iommufd: Enabling user space drivers to vend
 more granular access to client processes
Message-ID: <20250919115805.GU1326709@ziepe.ca>
References: <20250918214425.2677057-1-amastro@fb.com>
 <20250918225739.GS1326709@ziepe.ca>
 <aMyUxqSEBHeHAPIn@kbusch-mbp>
 <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D7D2BF13374EEA2C788F8C11A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Sep 19, 2025 at 07:00:04AM +0000, Tian, Kevin wrote:
> memory of other clients and the USD... there is no hw isolation 
> within a partitioned IOAS unless the device supports PASID then 
> each client can be associated to its own IOAS space.

If the device does support pasid then both of the suggestions make
a lot more security sense..

Jsaon

