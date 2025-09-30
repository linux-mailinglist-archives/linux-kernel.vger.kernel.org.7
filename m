Return-Path: <linux-kernel+bounces-836876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9ABAAC93
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A547116EC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4A140E34;
	Tue, 30 Sep 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opEC7rzw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22286C133
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191843; cv=none; b=Q9o2G9KQ/1EbmlSGt3BdbAH0kKkpcCNm8Lf2b02KEv0e5lqxynEvaPo8acOb401U+bz+xd2XMafOxYJQce22QbDhtnqoTcPkxM6ptuRh93s90jSiL19KLgsUK7Ug5T01+gM8xSYyeQYquVVYHoWaJfFqNrDRNe7+sN3BVNgR5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191843; c=relaxed/simple;
	bh=wypLS3wbyCJK01dCOFTCad6xFyH+lsxJrjZiqV1ziGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msnxgiKkZ7haJZvGmmdGOblm5GLzPYNGQ25aBqwsuYq4Jen1vMFEIMZDvIMfDXd+J2mGwRk3Mr/XuKKgo99F+qgr4a+Up5R2eO3L7iJ0t0Zm65VSxzeE2L6e/9klPC7pEjIuM43u+nNRqpxtCnip+SVZTr6kBxU2jqil28u/cCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opEC7rzw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d67abd215so94675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759191840; x=1759796640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcb0iCTs5qPKJqlBUU/RfCrR5a+tDEsmWBE3CmQO4XQ=;
        b=opEC7rzwQSeBYHuUtxvVGPh9tIa/7rhOvJSc74ZZul9PJEejjw08v8y8xwBEO6XcNb
         Sj+bKk2hR9XVXn9j/ylN7RUjuPlsNbBftQ5juu0gbW+IAQiGkkHAbXrHCbyPbYOL6lRt
         6y88UYmCcMme6kyzUboyuxEY8KhqBS7Bp+d/4NYrtTZOARGkGz1G0Ua0EagNm/vlS7Al
         dGvByvnNMZpL/gIDdJuy7t3k/PdKwwMdIgWjBF863LeLi/GlSa/4CqQO5ZSeBdavbXiV
         NAZM1JYaZCBcqCzyZb/z5G5s8mEbJ1YyyU0B+cB//wiEHYbQc+W8FN+qkqUo4na/YC3h
         SYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759191840; x=1759796640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcb0iCTs5qPKJqlBUU/RfCrR5a+tDEsmWBE3CmQO4XQ=;
        b=ASflLTl0D6UpH4H0q25+WTQjC372ho44kp/+TO9YR4cGMRMltuWiSkJ3Xq8yye95Sx
         fpkBU65qObc80tca4FFPiNMo7+bUdVVEEcnzCKNslDtptMC+scykSkrcpXwCKvID0uNI
         VAN2QQcAwfb3qsXrLP590e8RY9M9cMkvrRgZYNP6UGhIlBnUOqKTtN95+XV8qUGQST4z
         44wQq2T0D8ALqcNJs2frdw+9hmrvuyp5VzmZ6iZv1Df0VqQn5jYGmW9ctfFq7fbr2HA6
         56DQ8MqyfVqx8PRQ86Qp+t19qoY2cvZx6mUnmUuXkNeHp21P9sxM8gRrW7tCRKugJ3cO
         NLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEAiUchKbrND0pgvXXJTKauZOeBlozS+84rgAOKPtBk967E4zat5FfIY4532SbIpjjRUbJduPGuW+J5FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs0FectCpD84tlIqTSkEZr+NRs5CA6eRwnRDKOVvaobofdI6Xt
	HONstnoNngJljmz3kAfnsJDxNfl0dMPEoedB1eye+P3uHff2oY/1/1/gNHao1gFENJJc+sINPu8
	DqylycAXaClg=
X-Gm-Gg: ASbGnctT9mVKJsMsIUiqjQ77Hm1rApHTz9RFhaXruNrBB9G/A6ql0RSuMyv1KOvdoHf
	P62vTIevdQfmepTgK8sgXaxMsl5xkEnT6cInKP1t7wgxmuThBXnZN4JRqi37QgbO4Kh49X2RNHn
	DkowCCLCAVwkkzPm+1/qyeLYscDQ2lqNwMwvHLCJypRKaIDYseb1ugCuZVSDfplkQiPCVxz4riT
	bx2ahIfqB5HS5Q4ZSgAmJFBWX4Ng+AHRkvXae7xZUKJWd+7imJRhAhDQ2iJ6aJnJHJeLk7HHf0o
	mqySic+juD1CIwuNbVOzCeReuAJj0ZFfGlSzwC29YaGafJPeDnysv7ZdRoTa+9BKPVoFO1xQE/m
	UGatFxq0em1zoj9INhKDf0yxSsvQeqPuG4HNb9CdLHREp78DlFnaOBHtN2RXa+lgx8k1RLNeLB/
	VT0mxxGVF+4SLq7Ni2hv5TVg==
X-Google-Smtp-Source: AGHT+IH47NqR97g8gcG9ndJRncZ5F4jCUXYW7SnBTfKjVMSIbEg5GROwnU7eM5A3pfaaVR13HzSURg==
X-Received: by 2002:a17:902:ce07:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-28e1483bf6bmr2495355ad.10.1759191840076;
        Mon, 29 Sep 2025 17:24:00 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab6547sm143571295ad.129.2025.09.29.17.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 17:23:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 00:23:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map
 callback
Message-ID: <aNsjFm56D8pnAKDp@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <20250927223953.936562-2-danielmentz@google.com>
 <20250929115803.GF2617119@nvidia.com>
 <aNp6fJNoehs8hMyF@google.com>
 <20250929124719.GJ2617119@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929124719.GJ2617119@nvidia.com>

On Mon, Sep 29, 2025 at 09:47:19AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 12:24:28PM +0000, Mostafa Saleh wrote:
> > On Mon, Sep 29, 2025 at 08:58:03AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Sep 27, 2025 at 10:39:53PM +0000, Daniel Mentz wrote:
> > > > @@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
> > > >  		.map_pages		= arm_smmu_map_pages,
> > > >  		.unmap_pages		= arm_smmu_unmap_pages,
> > > >  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
> > > > +		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
> > > 
> > > Shouldn't this avoid defining the op on coherent systems?
> > 
> > Does that mean we need to have 2 iommu_ops, one for
> > coherent/non-coherent SMMUs, as both can be mixed in the same system.
> 
> Yes, I think you'd have to do it with two ops..
> 
> It just seems wrong to penalize the normal fast case for these
> systems.
> 

I see we plan to set defer_sync_pte = true always. What if we invoke the
ops->iotlb_sync_map() only for incoherent IOMMUs? Maybe something like:

static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
				    unsigned long iova, size_t size)
{
	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
	bool is_coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;


	if (!ops || !ops->iotlb_sync_map || is_coherent)
		return 0;

	ops->iotlb_sync_map(ops, iova, size);
	return 0;
}

If needed we can push the coherency check to the io-pgtable op
iotlb_sync_map() as well. Just an idea..

> Jason

Thanks,
Praan

