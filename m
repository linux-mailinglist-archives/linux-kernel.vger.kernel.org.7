Return-Path: <linux-kernel+bounces-725520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49166B00033
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D83B42635
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997E2E091B;
	Thu, 10 Jul 2025 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3TbB01K"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D6428D849
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145780; cv=none; b=hpwk8XO6Ulv+JgJsfGKk6vHxuZ8EmrBIA0zsYLwZ7UhGWfPBoScug4z2mtn3yB7KFJr+ELelvpaHwqJn7/cuh+Or4h0Zs6qLetQ5KOOT3xOXNgXohJGr8RxT2baR76rW+3FKf7IIsnavLBEff5KB3Pq0YX3cks6qqsEJpIV38I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145780; c=relaxed/simple;
	bh=0jzrMYG/Zqi4a1LCUXgB/nVmLmrbFykZy+3KzRBvXgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcZfggAFc79HjrDF68rv1uraR6IJu/RsBRF8LTMpcMSa289jLbSe1res4Dv3/WHF2A6qhMS6QSTq6WecoVyZpjXggzJoOhQVzOgNTKfcR7bYuLnT/HOChVO4UKgkpbiKmKoCs2dq72Ozrvyi0wzaxul4LnkVGLTNw7CJTovneio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3TbB01K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23dd9ae5aacso132845ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752145777; x=1752750577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JO/Qlx6QEcthLvC0sGmt+qm/PZ0F4XLP2KPhYGX+AQ=;
        b=S3TbB01KMHLBkOrFxDR0Fi+kD9LvkBfYlRJJcohSpHFq0RYA2tqr4w1oqfpz5J2bmL
         gIpkb0jbBCHraVijUMeJ7Nb7nXxePD6m0nCZDI+f7vL5hKumKPKn3IpCK7BdHavCSvoy
         rvUWEEvqfSRHw0htSG+Y1rHL1fJD6aAm1YhMQVmSVWYgHoyAUACzZargg9GzfTKrqQa7
         OSPqQ3i8WfLxDjKJTEbzxkp0lDTkYBvJlUgCTPK8u2G6Q5uBco+rjQmAFE0oiF/jFLvR
         L0/xiTbpu9NUhGeZ+/U80NWAP1YvoYeWeiVmB8+Tiwh/sagJXJPYejb0lFbZANyxWyEo
         Smbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752145777; x=1752750577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JO/Qlx6QEcthLvC0sGmt+qm/PZ0F4XLP2KPhYGX+AQ=;
        b=CUMKm1D0/LaqNEcBOzyLmfZVwcmX/Jnnv7zCDrh/cBqj+xNPKiKLjRDmvKwLSS/yTn
         7HXlHCsD8mc0iRTWIZGCz/IWAkyM65+2CqNK6tPJIPzzq8JZKBjMrvPl++pLXIo/Fr1C
         mndsKc53nx6VDucgsCXo/rfYkSWBnqZocY+UnnrGk9NnB0ySH9yRj0D9vApNC/A5aVV/
         6YheSTqXVe7JOlxe5TIpUSG8eQLgOjQB4fCT0NTgDxiI8w6XzBC+FbjRUXavxxpOfdKx
         1uFUQ7pbgls6kVejl8fpecGwICLswqySshM7LBlM4UOTwvNhnRh30dLllfwCoiyVbH7O
         rQFA==
X-Forwarded-Encrypted: i=1; AJvYcCXnHL/lRANFOYkRZxBzZFUwxmFgGD891Hz8PlhzmwXx5+ntOhGNHu+gGgFAbNmzsagD83njF2N/gjYxBXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrzmUJS0RIcgPbBqcmVhPot4qeEv0/NHLYsFnwlE9RBuZvKOUp
	CiiS78KN47dO61Vm4VBUaHQ5uXvdVVui4/HLgXRNotUV3VOn+YyvG6LXCjlF5Gh5Yw==
X-Gm-Gg: ASbGncsU4xUboANrt/n1E0lEx297Q82R4BgrdkqEAFTweUJglGVEmGrHGU8Ct2wmUyQ
	J66SavIsYs8withCBwER5mIQ/HrTzrj3sWCEbNO+ir2GRezRtNYbn3w/uGrgYABhoD1OOd4Vy3O
	7qjFVvHp5v/IWtxUep9YdnLk/BF2L456J+hpsmICStKdV4oq0zEdiZokXnMMnQCPGTXIxdNzmpt
	OQiaSP1YeHT97tUyBH0RBVB44sUeNz0ELQPAbjf5afhzknH94XuVvfsWS3CRKghvT15zcdtP53e
	oY4AS8Ng/uIUucTPYFGS747+GrfYqT/e1jhdrnIVqLc9zIzQWhiSJs2t9FoaFbjmACqUEVsisFI
	E2AybFc7TAjBeEhKO3o/V
X-Google-Smtp-Source: AGHT+IFn1YIIoN9D12OH+6EFBum3x9hdmg0bQvNt4lFk/nH2gQNwHagVfZTJ5ra5fh+Eufg2l4KArw==
X-Received: by 2002:a17:903:120b:b0:237:e45b:4f45 with SMTP id d9443c01a7336-23de4314a3cmr2237805ad.1.1752145776361;
        Thu, 10 Jul 2025 04:09:36 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3007e53fsm4845325a91.19.2025.07.10.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:09:35 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:09:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net,
	bagasdotme@gmail.com, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
	nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
	mshavit@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aG-fZv39ci6yip3z@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>

On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> add a negative test for an unsupported type.
> 
> Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> is complaining.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Note: I see a couple of warnings while building the selftests on Jason's
tree, but these seem unrelated to this series:

make -C tools/testing/selftests TARGETS=iommu
make: Entering directory '/usr/local/google/home/praan/master/iommufd/iommufd/tools/testing/selftests'
  CC       iommufd
In file included from iommufd.c:12:
In function ‘_test_ioctl_ioas_map_file’,
    inlined from ‘iommufd_mock_domain_all_aligns’ at iommufd.c:1789:5,
    inlined from ‘wrapper_iommufd_mock_domain_all_aligns’ at iommufd.c:1757:1:
iommufd_utils.h:679:36: warning: ‘mfd’ may be used uninitialized [-Wmaybe-uninitialized]
  679 |         struct iommu_ioas_map_file cmd = {
      |                                    ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
iommufd.c:1766:13: note: ‘mfd’ was declared here
 1766 |         int mfd;
      |             ^~~
In function ‘_test_ioctl_ioas_map_file’,
    inlined from ‘iommufd_mock_domain_all_aligns_copy’ at iommufd.c:1843:5,
    inlined from ‘wrapper_iommufd_mock_domain_all_aligns_copy’ at iommufd.c:1809:1:
iommufd_utils.h:679:36: warning: ‘mfd’ may be used uninitialized [-Wmaybe-uninitialized]
  679 |         struct iommu_ioas_map_file cmd = {
      |                                    ^~~
iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
iommufd.c:1818:13: note: ‘mfd’ was declared here
 1818 |         int mfd;
      |             ^~~
In file included from iommufd_utils.h:11:
In function ‘_test_cmd_get_hw_info’,
    inlined from ‘iommufd_ioas_get_hw_info’ at iommufd.c:792:3,
    inlined from ‘wrapper_iommufd_ioas_get_hw_info’ at iommufd.c:752:1:
iommufd_utils.h:812:37: warning: array subscript ‘struct iommu_test_hw_info[0]’ is partly outside array bounds of ‘struct iommu_test_hw_info_buffer_smaller[1]’ [-Warray-bounds=]
  812 |                         assert(!info->flags);
      |                                 ~~~~^~~~~~~
iommufd.c: In function ‘wrapper_iommufd_ioas_get_hw_info’:
iommufd.c:761:11: note: object ‘buffer_smaller’ of size 4
  761 |         } buffer_smaller;
      |           ^~~~~~~~~~~~~~
  CC       iommufd_fail_nth
make: Leaving directory '/usr/local/google/home/praan/master/iommufd/iommufd/tools/testing/selftests'

> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 33 +++++++++++--------
>  tools/testing/selftests/iommu/iommufd.c       | 32 +++++++++++++-----
>  .../selftests/iommu/iommufd_fail_nth.c        |  4 +--
>  3 files changed, 46 insertions(+), 23 deletions(-)
>

[...]

> -- 
> 2.43.0
> 

Thanks,
Praan

