Return-Path: <linux-kernel+bounces-876338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B461C1B39A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A151AA44DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28976279DAD;
	Wed, 29 Oct 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7mZ+boQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CC26B761
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747871; cv=none; b=jrkQd3JGm7NH1NTfnwG18J+8Z8nteDUNV4JBwbnFVBsC/KcjVhPH3KPyVU3Sf57SLG4gN1GFjVf69CXErvXL31k64QBmr1cNPxbNXjUoYRZF0xNEFAWl1Nq2H3RZc9GPixl5rHdCE2yimtaOy6TRCTfBLo480Ib841I4OwTZE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747871; c=relaxed/simple;
	bh=qS5ti7OtwVEPt76zXgfefM6TFVwnuYoF/S0givgkQgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6w2PaX2h2oCXj9MQ81balgQB6nk7p/Dc/t7/QS8J9jZA3U5Wwy7olEHjMgFqRwbsxDjusI/qkE6FdFX19bUBTn3kX5kz0RzWMuGDj3+kwl7d3lbghCjPw7rRs7x4qAdDQE1jEBsBR/srlYPCN11H1VjoZxGDTKasmTi3L4dn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7mZ+boQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so55525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761747868; x=1762352668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lYw1yzHZtok63cidNSQI3kNDGCJ3YniZmqixcpLm82c=;
        b=J7mZ+boQENXRVmY1sHexaQTwl97w4x2q0WPzF1Tn7msd6B59BalugcA/9LTplrxVdV
         vWOsTV0YI89Ut/OJkIGFh35B/TqYasnNAE9oJ7mAlopJ55Ma4/+CDvzbxVmuRjIVDh5W
         rXmAbERvOahT/WCkdoDt/CB3Qp1UUGpxFffDX+yejrFaCe/VCHrIQTi0zZ8rnAaAnLgA
         CloSadXZqcDhl6wTPKYxy03ROO59a7ELkcJOsSWj04GfsMdvmTZy8CTN+S0u9BbY9HOT
         Qzm8NAG0b8eMx53J+5g13vqqaLp/+bdgEoPROMV6KbQ8L0pzbnHxm62QYD8ZY3AseUFp
         p7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747868; x=1762352668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYw1yzHZtok63cidNSQI3kNDGCJ3YniZmqixcpLm82c=;
        b=YwMDjD8BANoG1G6HsrU3PKNRxhp79nFPLW3KJc64HT1d62ngeId3uBi+gEQfXXL44f
         rcFVB2knAoYb8Cq/VR1XYu6PPpJWXiJK/TgGIezueJUqf569aAopTzwlejHGx0cuA9ax
         0yUwNYPlK6FRbDq97ZsH8TsVTy+ywcQg5PdHNXe0aHb4bIiRmtltbZMNphRfUc19O9PC
         5FOPmAUFx+rtdccUvMuFAOyZTS6pOMfUZ1G3giydgVVzgmfJt17lqQR2jW8f6oUe7jn7
         NzUvEV55YL9Pq4OVW1WcYz0jJivjy1t9Rlv50B5gpQv3VOgB+LSrrqzDoV56iG97V3qF
         Dc/w==
X-Forwarded-Encrypted: i=1; AJvYcCXFLhiF6Deat4A0AMHvqJqyBMDKtyTUTaYkWaY8escW172sI1UgC3XscDUj/57HaEb7QLBkVePzlGyr0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYoErAuQZ+BUTure8p4xcloF6sPmhSgwKlJAQr+fLaBmqWHwP
	D64j6paKWX1j5kKMQQMIv2i9jbFI4VISRA6AnPoypUCrOKdJF4G3pluSTCvodzwCag==
X-Gm-Gg: ASbGncsuoLmiijVv5YshuaOv2X1jgwnzlAjCvBOwTbow3jCWngMGvd7tyt424HvUwk1
	CVNpOeGk4vEol45bF8/KeOVxROvFSvlxkQj1y8zYgVLGwb6cKpQsb9u8XYw57nny5ZCDt6Zu/Pe
	LCt8MK/DSIYip7E3cNHRcJv7lf3Gtg/AKWg8u8y/pwvqqpBZp+7UeSBIbm2Kz0XczDBsTHvOMfq
	b51wkmTlEzHum0gFrJzGQMp7D0GjbNlTvjUHiDpVD8o+j0q6wN48fql8o1sSav13beMl1Lip8Lz
	HCHnLCClhcGB/d6s5Dvhl96HuxOzojd7YvR1+yaotYad+IJ7oJNueTQdNGuBlKLc2+UejyPEAYv
	ydk24BsKdRNmSqNhLUhswE0nWHPUcDJYPhZB2XG7fB1SOvcnk9Hr7Mpi/G+ibkl/Vqn6m07J5uY
	9b6kSXFuZd2KMJr2Aj3NAZJio+mY+4dST+O6HTownpmmM8iOivQw==
X-Google-Smtp-Source: AGHT+IF2w8kCzWJz2ny6yJjbrSOF+2z2doPlN+BMk2LktbvxhoCGI/5la8r3PEhEpY5MyiFPBKRJew==
X-Received: by 2002:a7b:c054:0:b0:45b:74f7:9d30 with SMTP id 5b1f17b1804b1-4771f2ee429mr1618205e9.1.1761747868039;
        Wed, 29 Oct 2025 07:24:28 -0700 (PDT)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d514asm26815984f8f.23.2025.10.29.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:24:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:24:24 +0000
From: Mostafa Saleh <smostafa@google.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org
Subject: Re: [RFC PATCH 3/4] drivers/iommu-debug: Track IOMMU pages
Message-ID: <aQIjmKSH8r8U7uMa@google.com>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-4-smostafa@google.com>
 <3ajy2xcjo3t6xdrbeo5xinlwtxzujvx4plzk3vqj3za7ren2rv@wdmwpjlaq6ql>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ajy2xcjo3t6xdrbeo5xinlwtxzujvx4plzk3vqj3za7ren2rv@wdmwpjlaq6ql>

On Mon, Oct 27, 2025 at 12:46:02PM +0100, Jörg Rödel wrote:
> On Fri, Oct 03, 2025 at 05:32:28PM +0000, Mostafa Saleh wrote:
> >  void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> >  {
> > +	size_t off;
> > +	size_t page_size = iommu_debug_page_size(domain);
> > +
> > +	if (!static_branch_likely(&iommu_debug_initialized))
> > +		return;
> 
> This still adds function call overhead even in cases where iommu-debugging is
> disabled. Move the static_branches to the header files as well.

I see, I will fix it in v2.

Thanks,
Mostafa

> 

