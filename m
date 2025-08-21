Return-Path: <linux-kernel+bounces-779318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA730B2F28C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5091886324
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1E222582;
	Thu, 21 Aug 2025 08:35:44 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53753594F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765344; cv=none; b=h+Pwtp3dJ15ez/CmcmJ9p8HwQWQ0shZgw6x2do8BcB80khNKmPt65sj5fXh3NqxRVVa6EpLyrLF4fwGf/o7e5bUrSqlWsTG/Sx5jN/6jJwDTrFcYlU6pUKUXj8n80sgEyPEQ/UhzUrLmwHQkIHfXi8jWiEyXrrYE9x2ZnXkAexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765344; c=relaxed/simple;
	bh=UaFhU0ASekfjt+7a2TVZKefNXSuYXrZL2vLsDrzLMU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krqLndY4e1Yo7FWdHfgBhV+upM3rmIArjwKRGiFyLxh5e4oJD9qJ2EyfKR7AjJ1+Q4tFPly7WY4m+dW4eVVAycrAc+vUNDDPpdgPB9ka8gfq36YcxXrprNo6lc/RLZ3CNjr32Oqyfj3LtaWpLX1ozKq2jfF98qftOT2nIGPaRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a1c6a5338so1185974a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765340; x=1756370140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLTaYQKz+L6mS60IaQHO0FlbZom6v0EylZjn5fadR0E=;
        b=pfShcT6Ya5VxHoO2ckTMYL0Cu4upUo1UxNV4MT3EU+jsh77Q9SUz6k8hVjncxHsl7x
         d+HtS+w5jrJOVIzNH7iCQ822MXCvSodpWEMJ4abYzHTdZkF/1xJVSkAChS7BdGbvlhTD
         hcdI3gPwp0orYdcdH6A8tYQylgk71wdWMFHUamBPoUwNA9CpMaIi8SX/YS8h1FbxY8je
         8UBLvjX3za+M9eSZVcxpndbUE7duv79ok94Dp8MJEHa6XQMP1YYpQ/N6H5c0YoKlfsLH
         gnihShMP+XuwYcK9zjCFt+4LFs9WfdiGrJ1TjfT2xx4PkxQq9xtwiTVtmWY2tOD06y+h
         R60A==
X-Forwarded-Encrypted: i=1; AJvYcCWKT7gy0Qkp9NGo2Vu4Y5mG2Evv76wzdB8JR3mV/ZkrkXtsbq+oTXnKeclGivHaMkxsytivBfyH/pYqJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCA1wcaRKY6tieh4EFig00u8aNDbUnxre3ddrHThpDbe1gqhgk
	Yy1VOm2BPVZH2ghpPJlH4twLL7oo2XuN7FVi0z8aqqsa/PH252GFFbAf
X-Gm-Gg: ASbGnct0wgb4j76P57xqy9ajlQJtjVFxEP8MUvLOvccq5JgjhaY1irK3Qcf/I/Zt8Rf
	U2KhxPfoSwyoE2d5iFaG9jhd4lz/H8EjXbK0T9hT6QtVnY4B/A+UgTrTg9H1g91KXYzYViyeo0c
	OtNkVyBGdbi4nS6JkXBlwGfTvv+NrK13xkDIq8WZ0HDuFLY/uFKb09vPLYchxstXzInv3rBmHOw
	Mri2mTUN/Kwtohmvqfn9DzLUmmI9z6SBP9SZRGfqmUHE8I05uL6LpI8Otq+E2PslfleDmiGAK/P
	EKOa82Ztf1mSkgAnufWIrOQRir9bAzYYALx07ggopjhIdYoRI79Xjt8ZUbl/hcm+wdPdN7vbg5H
	0YKQ5ZaEHXsTr+J/hhgXa7OM=
X-Google-Smtp-Source: AGHT+IEkJdR4ZytuF3ou0QnN9dqwsgDB4fi3WpC1cU6D2DxADi2r+x6LKDLki93uSdw4v8TOHeihdg==
X-Received: by 2002:a05:6402:354a:b0:618:20c1:7e43 with SMTP id 4fb4d7f45d1cf-61bf8736398mr1310328a12.29.1755765339676;
        Thu, 21 Aug 2025 01:35:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61bfb41b760sm727145a12.16.2025.08.21.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:35:38 -0700 (PDT)
Date: Thu, 21 Aug 2025 01:35:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiri Bohac <jbohac@suse.cz>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
 <aKX1vbE5jWVUr298@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKX1vbE5jWVUr298@dwarf.suse.cz>

Hello Jiri,

On Wed, Aug 20, 2025 at 06:20:13PM +0200, Jiri Bohac wrote:
> On Wed, Aug 20, 2025 at 08:46:54AM -0700, Breno Leitao wrote:
> > First, thank you for making this change; it’s very helpful.
> > I haven’t come across anything regarding arm64 support. Is this on
> > anyone’s to-do list?
> 
> Yes, I plan to implement this at least for ppc64, arm64 and s390x,
> hopefully in time for 6.18.

Thanks!

I have another question. I assume it’s not possible to allocate only the
CMA crashkernel area for the kdump kernel, since we need to keep the
loaded kernel in the crashkernel area while the system is running.
Therefore, specifying crashkernel=X (without ',cma') is necessary.

At the same time, since the crashdump environment will use CMA, the
crashkernel area itself doesn’t need to be very large, as the CMA space
will be allocated later.

With that in mind, how do I find what is the recommended size for the
crashkernel area, assuming the CMA area will be more than sufficient at
runtime?

Does it need ot be much higher than the size of kdump kernel and initrd?

Thanks
--breno

