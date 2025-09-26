Return-Path: <linux-kernel+bounces-834067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB2BA3BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0293A382E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81482F549A;
	Fri, 26 Sep 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OI0QnsbT"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B92E7BA0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891763; cv=none; b=G4Mp+ooD9Eulv7amKdgN8mhEgyf2cJZUgcI+FNNTpMGWc+7EC1yI7TknlcojxIRkiaoq0nnN2ay53zDySTkdnj1bAs6gpBP3ayTkWAkkiR2gDR9X9+lKBTXrFVWQmkC2wB2SJGwCO12woVjXjivn+ch9iDRhps3ZXV/f3po9bO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891763; c=relaxed/simple;
	bh=ptNXivIz/aNnUiIKkLbB6u3iiGGkTOcWckQJm78UoEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJImChAhc7WQH7M7SGtSNK1L5KVYTSKx6NeCieZi6fVGUICQmgPllsVIiiUXOgjWvLwYaDVg/mqOHytcrfmGc5B5Zwg/pXeVdYO3QVq2GsypPmEMpHGaWUzYIzpuRI5PDXCAhWmIw8Pi9dL2a6TZCSsfWRcsqNH7w+pReFtnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OI0QnsbT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b7a8ceace8so21015571cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758891760; x=1759496560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=OI0QnsbTFL4Oqbzsflyz2TLS9hZfwPfmXY/Jjc8inZqZAmgBpxOn7x35Q5I6XBjjM0
         DrbvSFEfkfcoytBEHJY1aP5ery72sZb69YpGO8DTpljVY7uU0zFHCZx++ej833kfBoCo
         Kky4cCqMoWp6CYfyG7gvnArS+jcWvDUIOBeDJd7W3aByw80yhFsW6vFCVeL5B4H12io2
         TWrEfP4PWOHlrrNxjOP5Npxe2OA5aBlKsCJ+fIsqQ1x+EGbTY8hPzjFm39hWRKMybNlV
         7eoxx8t2m98TLcBCJWJqUn3eBY0Z+6MDLugkAUK/km6Iwl107SktvlKIHe47jjwtBeQs
         9qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891760; x=1759496560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWqwjGIjU9SQRKUcuqoad/3ZN7TYjVFKb+KM6PbNx+o=;
        b=dxre34CWRPfiY0TkfwOwWGc2CfyDcvfKoIBhTqQBedtiaGG49S1QfJHnA1TH5lcH+Q
         n0ESynExyNxxtRaJ2m1/0JR+K2uaOZR5R8bxMkbPkXj0RQPak9YGkJwU3KSrqTcCotau
         7TzTKRvU29IkV71+SKlt4+g8S+ayufB+zMjr0SHirNN81ejBctLcKxBmb7UoGHyd5EPm
         fjsKoyfa7/Ty3ZMbtYr+C0MQDwqq50fOJdtrUpxPz2IMbSF64Q1Km/2ykhDLy978/eqp
         YbFD5iE+VvRVObqcEQQQHZvhEnu7YS+1CH3YtDlOlb0NuMFNzMJdZ8w1MkzBHuY/YCYy
         70EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSldFrVx5fIdDch3cKDbzHmzhTEVYexuliQyIrES0/lZqB9lMSpw009lrNhEZMZTng05cgV3mr6ZZhdyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtXxUM5dbVHDOPLJ04spBLec4/9jYpd82S/0Z72xeJWJ6+54kT
	lxfSqSHuIRkDD3PX+esqLAfxHfJ5aPOd86qndqqWaV50f0Hknm4ARJnRGjP6fbXA51o=
X-Gm-Gg: ASbGncubHU1Wv+oNaOkXtDrvBrmB3NeK1HaiICGoAbuDRdpZF7Gmb/0vgkDZCpiQkBe
	mXBCfGVs2WuNmM5OsVl1OXEALnt2aDRsRo5R64lS58YzBsPiP9SkPrprMN/G5LVZfoKQx1O71kB
	swkPgTzytD2xN/3lCDfxNAgTRvKmAcVliuzO253+guymhvjX5ME0fis7/NnAV/ISa/lOmTllf8b
	IoIj69pgukICPEUJybyxtpGof3s0bZC1TCP/BvKfLnOFDEDxNfJGwqOqKuToIOqGxYL85xbEHDD
	3dhgeD1wFJhNafeyzOfx+8pNJ7zoHd6R1ys11Z8cXUly0HQkD0bVzRYiCQQfcfwN2Kqx4ElTP1K
	jji95VUIFZ2eknWcYjhpCBZNIRfDwx+Nd+j/39KE7MH5dmK34SwlmBOzFI+O8v6YsqG11up9PX1
	mP1q4=
X-Google-Smtp-Source: AGHT+IFG6IrC3E1ZMV5IfBX1Yz/2jeOobnkaeTVu8VbWTtPw/mqYHCeluPzzqGEyM5aIpdwAOBQfaw==
X-Received: by 2002:ac8:7d8e:0:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4da4c39b63dmr93170581cf.61.1758891760125;
        Fri, 26 Sep 2025 06:02:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd52e5sm25939731cf.47.2025.09.26.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:02:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v285t-0000000BmNC-3fwI;
	Fri, 26 Sep 2025 10:02:37 -0300
Date: Fri, 26 Sep 2025 10:02:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250926130237.GA2695987@ziepe.ca>
References: <20250924171629.50266-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924171629.50266-1-alessandro.zanni87@gmail.com>

On Wed, Sep 24, 2025 at 07:16:28PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `res` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> In function ‘iommufd_viommu_vdevice_alloc’,
>   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> iommufd.c:2889:1:
> ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> [-Wmaybe-uninitialized]
>   760 |   if (!(__exp _t __seen)) { \
>       |      ^
> ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
>   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
>       |   ^~~~~~~~
> iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
>  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> nvevents))
>       |   ^~~~~~~~~
> iommufd.c:2924:17: note: in expansion of macro
> ‘test_cmd_trigger_vevents’
>  2924 |   test_cmd_trigger_vevents(dev_id, 3);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~

Shouldn't word wrap output like this, ignore the checkpatch warnings.

> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=iommu

    Fixes: 97717a1f283f ("iommufd/selftest: Add IOMMU_VEVENTQ_ALLOC test coverage")

Applied, thanks

Jason

