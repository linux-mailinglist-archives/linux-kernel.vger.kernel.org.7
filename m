Return-Path: <linux-kernel+bounces-837685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2300BACF28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D13212E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99798302CC0;
	Tue, 30 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NJ8zUw/Y"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750B26B748
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236896; cv=none; b=RYwxU2oCs/4w0C8oYSJEnVRQpiVGW21hK6gNjxZPqak/Y9yA+3hbwmo99+nwJrwzCowqO/1/fIoD76LJs1hlrXGrwwhXvkj2FXUDgxRRwTVLSigR7O2bdZm47OttrhFkoVS5EOXahCQu911XzO2epejIT2CgAAQ6MKitZwkphzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236896; c=relaxed/simple;
	bh=MKBeHyv3NY02Jpy+fPZVna1bcBZA3eyBmrzzBsDs3WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evh9uQqkkaFPBdsXhKAJEsuBpCa0jQSjqKZeNrD2fqt1sGAg9H4IflIEUUwTWb+EHPGohETp2Jxr3+fomQHkybYmkH2PJHnkS4KcurYQeDKvF7i7Obi0z9CiObu0jankPVgeu6y2aP/m2DA46iClKKenu0cRdJ6Uvg8iFW9ejYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NJ8zUw/Y; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7f04816589bso624752985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759236893; x=1759841693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn+6mTGWkxBQjLUsqN+kSoojzIgnAUXBIQNu61nSFyA=;
        b=NJ8zUw/YFvPcns2AUEJYyaWVwULIa56MoUXScGr+Sk5YzBTCeSdcb6OxCDmSc9i6Fy
         GudI/jNafm09ikmSneic/LEzQnGVc5flqxTN9E6Z47sFcVkySk1zczMx0OTmYOu9H23j
         boHCfthhnDr2jEvNotN4uB5EOjcR5L7LvwpT9tzB/1gRIIBlkhISuqZvsnNk17dTjlSX
         boiB/NAgX9ROEDZg4O0tpmnxSxSybo86CYzm0SJnMluFJZNitVd5+idt3c7jvt6jS1tF
         xg7/HQeRnLh2dpw3+4ZoYawnAuGJ0zmqwiW9eu3Jhtfdvg3DdcsICDTMnXtVcVAINwd4
         WaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236893; x=1759841693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn+6mTGWkxBQjLUsqN+kSoojzIgnAUXBIQNu61nSFyA=;
        b=KJpY+b8KVD1extES8NFEAHD/gP9JmzWrkY1+WFhjwP4i6/dgetr+K2CPujcUVYdjRi
         /8GeyXkhrzETFLiDxEHGn8RX0nfq8o32iiI0QBKuCe7p1otVuKmvNV9CHLs5zYDib4hb
         SukCtVhv/wDUHz411mUTfaJyT/z/QVflxNT+/BTkXCABS5LqnRtrk7A+vLQOa9k6RSbz
         t2rjzJOzw+7AmAEMM1m0+JwyHGSh/aS3uOHujAYa7WZXWD8ty6d2j7n4a6t2bux/KIRo
         b6tdgk2mM8IboS20FWSOBFL4idobOnyrZLrwbxN4OP9Y+6mkQX/hxVA6crnrgA2eetdG
         lz9w==
X-Forwarded-Encrypted: i=1; AJvYcCWB/NIyz03jdaQbh5gfuZlxCq8v5jzip2EfuNr7f7tk049j00/t2ExfFXo3OM4VYMYFJaJhgjM/OnBCPVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaNYbRb1TcMsIZH4AoRterx8g4sYKuoMQVXvBo7aiuPUL6iEO
	ndkFI0OW3LsD8UmjTrHwD2jgxL+2XowAGRO+qsNT5DFbiUg7xAW0VwC4nnqXksCW1Fc=
X-Gm-Gg: ASbGncs3PLAcQGLonUMmHLZGKFwSB/ML9cGWzt+bX74YzksSo1G+mzRV/73R6IIvIIj
	8Kk36OpO1HYpv5CltmylCaHm/n9rmZhAx9EeGagYUcQyJVCYjFccYqVhoyfg9FrEaN/jnL14uDk
	0nDWj0chhjJAI8fdOp4qiAxv7gZyW3pcq3h8f3P3hjgVw1UmMTSSM6EDd5QfJDbcGjVdv58XBZR
	0rgvF6XChWrbs/Q4hUT072Sc1kKneP8HAMLjnvCXLLVKJygz/4WdM1xctvRIOZUZiscc7l8ndpn
	BjqQAtXxg2PcGF+FFIy7srfi3Jdz+W1SAskuEtfDb83UWC8PLzcDrMT1rG3FCiMZclffd7CAVe4
	icYhltGa7SI6jWjewKYJmyP7M5PyN7/Q=
X-Google-Smtp-Source: AGHT+IH8Xq1xzvsa5atQWy4L0N+927va19nw9h/INxGPOCjMGegHFYwwzd+J5W1A0Dfgpb/gIfdZBw==
X-Received: by 2002:a05:620a:6281:b0:842:6a7e:52ed with SMTP id af79cd13be357-85ae7bdfb4dmr1889933485a.45.1759236892962;
        Tue, 30 Sep 2025 05:54:52 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c33b73f99sm1035322385a.63.2025.09.30.05.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:54:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3ZsZ-0000000CX6a-1f52;
	Tue, 30 Sep 2025 09:54:51 -0300
Date: Tue, 30 Sep 2025 09:54:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iommufd: Fix error code in
 iommu_device_register_bus()
Message-ID: <20250930125451.GM2695987@ziepe.ca>
References: <aNvMULgt6s7-3ceR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNvMULgt6s7-3ceR@stanley.mountain>

On Tue, Sep 30, 2025 at 03:25:52PM +0300, Dan Carpenter wrote:
>  	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
>  	if (IS_ERR(iommu->fwnode)) {
>  		bus_unregister_notifier(bus, nb);
> -		return err;
> +		return PTR_ERR(iommu->fwnode);
>  	}

Thanks Dan I fixed the commit

Jason

