Return-Path: <linux-kernel+bounces-773102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 002FFB29B69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66AC7B1E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE1E29B214;
	Mon, 18 Aug 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpX+3PHp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F628C849
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503851; cv=none; b=sxFIYNw7P4QgZKF6AwcocrEORw4sKZr9OcLpnqGvMWdYjVUqrQC5/lr6JAGEZmXsxRwwqp+53PqX3dngFWjt7be2yNDr6QbU1rna99317PLlqDOcr3njh5DCEy6QXjloXMwN0Il4bbp+xT3ZqZ+ktQYDj/AS7YwfqSVLbNm8du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503851; c=relaxed/simple;
	bh=UYGkkspU+B63sm92wMSzq+haWmbUPgKrQyQjqaa8St0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5zWG+1THwXwJ9PLK7wyRmqV4ugak3Msc4VZsoTIZfyd9TXadygZcVFbSPPvOD4E5I52qzbxgci76i5Kk5mWEmo8PzCntG3h0X870r07H2wLNC3KdnR2Dk2YW+kzuvgdAyFiiWdGl2XW+kpaIoZtv0s3VxVz7RroM/7kz7LT4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IpX+3PHp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnLNVOy+1JPODpJ3Yc7eupS4dHoP80nfXVqFC6FlADI=;
	b=IpX+3PHpdBjDGnmuoTCTjzZAulx3+QEB1Sg5hGHsWtu4du2XEInP/7YbE2OQIQa4/YRmwc
	xVojIbxjw1dQ/H2Pbn4Ci6fAhwBhEsY46XWbIJ+Vb+tbRS4coGUUCSg8obJcglkZNyNkj4
	T0gXx4/+UqaOb1YTeilZ5y9khb7kRTM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-8uiJs5tmPb2UCwxA30OXBw-1; Mon, 18 Aug 2025 03:57:27 -0400
X-MC-Unique: 8uiJs5tmPb2UCwxA30OXBw-1
X-Mimecast-MFC-AGG-ID: 8uiJs5tmPb2UCwxA30OXBw_1755503846
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e86fa865d1so1197733085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503846; x=1756108646;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EnLNVOy+1JPODpJ3Yc7eupS4dHoP80nfXVqFC6FlADI=;
        b=Bb2d5ARbMjrl0laIU5GBOh+M75x5p09Ol78hLzOmbEc7rX+wrHJIzK0zBtvalmXvJt
         4ynuqiJAnWWEb1bSEGw/SkUF3tvA31VwmkDrjnUfhix4tqTCRf/b49LRVKx4AaKcAYrU
         WkOg5cGu/1mLCmyfRjCdv2KWgSCY0ZTwQEKOtxNrxi5JoNXpYKyvYFYpOjXuEUoHxeQx
         Xk4nxO+HkGjrSen/+8iHthvMWcmrrkfsznWCyYNFAV9vvWgTRQHgkIvJzLYe3fi4fTsT
         tuQBth5NnTKDgECRYzJpiMAwohveaprjjLr816KtoUTZ3/vs0dBOh14m9/IZCHm2/X/w
         AQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxMMZL7ql3mOuLshDA4n/OvxI+HIxCK8eK9wf6u1JzftSlHmSoHEDCJq/1Hcha/wO13g+ZXaINn/idTU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bJHSXmGNGiODfA/pLl/p3B2nS9e8Y+4z5CsYJ1e8+as3QPGt
	4RYec2ctDmaVI4fN0qC2ewhoFWGGcyPC1NVrjRdw8GuE+Woy4MbqvhXEggcIU4tyQnEDsgNHqmd
	VAnaKcDGRdw5S31BCoOrZ/A+Of5RhpQ1WywKstSaruQETmEl0Naa961NyISZVrw7G9A==
X-Gm-Gg: ASbGnctvwJcYkAWUVK7xxlf7t0QoU1mJad3wxM25l2T8x2zXMAmyiUi+3onUSmTaNY+
	Cb/fONExJ+bUR/OH/8YKZKBvfTrpOQWawiv/uU6dgbn4ZNrJ4fKk/EMNBAgDi58VxOd8zgJsG9s
	AU2TY4qtNLz5I9LmgP80iDqBHc6s8pMjoAW6HEbwA/uoz7/UhO9vZoCkFVaqplOUfRidkxy2jYp
	/fK9gHyZLKbcYuXkhrx2lRVRIuOzz3+X9Gj2Yt+rIHO947Ilguj2m1WJyazw6W4zKPvmbua7PiB
	r5hzt1HaEF4j1Bp/BHsddIohnQdBbd+nKvM=
X-Received: by 2002:a05:620a:8395:b0:7e8:8fb7:fe8 with SMTP id af79cd13be357-7e88fb710acmr709376185a.11.1755503846526;
        Mon, 18 Aug 2025 00:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz+Y7q7Cu1RnQ2whkcwKktuyquYKEHgUyH2v14hpiHFQmIn3M88eiXtWwjcl0ERF/6wn9BUA==
X-Received: by 2002:a05:620a:8395:b0:7e8:8fb7:fe8 with SMTP id af79cd13be357-7e88fb710acmr709373685a.11.1755503846133;
        Mon, 18 Aug 2025 00:57:26 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e020b3dsm545707985a.12.2025.08.18.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:57:25 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kernel test robot <lkp@intel.com>, linux-hyperv@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Nuno Das Neves
 <nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Li Tian <litian@redhat.com>,
 Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
In-Reply-To: <202508161430.0GC3nT8J-lkp@intel.com>
References: <20250815133725.1591863-1-vkuznets@redhat.com>
 <202508161430.0GC3nT8J-lkp@intel.com>
Date: Mon, 18 Aug 2025 09:57:21 +0200
Message-ID: <87frdpm59a.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kernel test robot <lkp@intel.com> writes:

> Hi Vitaly,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on linus/master v6.17-rc1]
> [cannot apply to next-20250815]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Vitaly-Kuznetsov/x86-hyperv-Fix-kdump-on-Azure-CVMs/20250815-214053
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20250815133725.1591863-1-vkuznets%40redhat.com
> patch subject: [PATCH] x86/hyperv: Fix kdump on Azure CVMs
> config: arm64-randconfig-003-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161430.0GC3nT8J-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 8.5.0

Rats, I completely forgot about ARM, will add a stub to
arch/arm64/include/asm/mshyperv.h in v2.

-- 
Vitaly


