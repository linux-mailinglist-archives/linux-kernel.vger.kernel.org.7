Return-Path: <linux-kernel+bounces-837764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D3BAD220
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE423322F38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0A18CBE1;
	Tue, 30 Sep 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O+35PJ3e"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872B1A8F97
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240760; cv=none; b=q8CToqkOZaHmeXc9h3LyB5BTE74fx1ef+k8Te3R96pXALsfUOFx/qoWHnlahqZ42xrV1UDTux/709aFbIBt8H3NO8FPpKTVWjE1iyvv9M9DIaNAzUrR8FDqZfUXpXr7VoI+tlVQhMcfdbmzCxfTohuBUOHu1t+KXNwpl/GgqieQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240760; c=relaxed/simple;
	bh=7ZIeyeEBb0qTqoKYPRyQaMzNn6s9dqeEoUQZcEJwHEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXmgtC8Vc0xYf1S0bGpqfc/SAOfb5dPo3HTVuAvOODOChcYWzrhNiAKQwWkNl1338151PJ28miEDtrKz6itmABKxgHoCJeIYeY7mQJPNEBLRPojE0MHSseKO+OUffZ1VWMoGjo1n20ukIdR3DIg3Fi+WgWe6qSlGvrsC1/6PckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O+35PJ3e; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f605f22easo5408124b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759240758; x=1759845558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LjWUtHOtj5aDOxJQNu28PlCHm2FClKEoHbTsTRz97go=;
        b=O+35PJ3e54uWAaWci050FttJZ34HJn7IAC9TK3oHFWY3ro/O55rqXrHwfcthCtvPDa
         BJhtyjwCa7YYAkRLTxKAqcjglCoJ3m6/JFiWzJhPqEr/b47tAIifmT4COvH9XSvd4KO5
         wXNChGQL8VBDvcySjtUwQpP81ZZl2S1H2Jq5Yqb2ngmq333ETP344ekmMzrdflvKDPl/
         u1eTp2X3jgWcENsXb1ulMdMtgFYitI7eWuZWIGnyIXmqLr4paPhsvMvVwml2Id8l0S6c
         jrq4NrCWTA1LZZCkUBepFJsYiPgL87wkv1pocCj1slk4x7Xezj6wEaRWblCc6B0+EtPW
         eAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240758; x=1759845558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjWUtHOtj5aDOxJQNu28PlCHm2FClKEoHbTsTRz97go=;
        b=JIYGdBKu2oMFRQ+N00tRBT1VoGF9gisT2XHJQrUIy6W/MLkE63RVBaYDgMw660JXO6
         UsX80pqs9y0ONn5frw8QLhm9jFsoEOYnYywlPP7GFM0+W5aDysgQNlHNDiiJLFkOEylj
         if5ZSXndUzju45juLYsOjRmX5FRAzJ2TAUlPXS0Aay9RyLLG2J4sQoJqeOxzrJEzwSO9
         8SfPRIkhDH8SMFsSai06Q0zyjVAwW4m0szD8h1UIfuAJaWbTjmT+Ac9XvNwPDnW6s7Q/
         K8OPvARfbqVW2eUFKq8s4pJbqfmQ29lFMfK7u8Si19X8TVch02FCiRnGW2i1kd/aXfQQ
         yaJw==
X-Forwarded-Encrypted: i=1; AJvYcCVXWeJyffzVGWra6mhEegOqWsAwdyWynFfxERz1tSapwenIyAifPwKOId/dJ12v/bUIGvTqconNbWnFAac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfyaMrPAyLXPpIMrd1EELGHSaHuduO5fbSvAHd4esT/46S0Em
	FVO2EprMaNsCGZoNaawug7lO1n1PB+goZMiCd8uVwDyTYF0SefCKH+vFb3zN9H1/EIM=
X-Gm-Gg: ASbGncuMr0WpeGLIz/2ieUNRQ7C9JEViUH/z7M4SumfKQGYzdYtXxYy+MC4EkWd7Yab
	PK/Yi6yyFdoWWDGYPk+gTzKuR5tIvLAITn8hEP1Ae8VZ8NNG+dHvwADii/DbHr4ZL1F4JIXaV3M
	QF2+UFlSU/gbBIvlSRzUtttn947c46SiXC4mXylq2EA03gzDrsDQp8y/U+ACBF5TI0GsDCrguOy
	kEFksSXSpyx88xc93aZSIa0zrtKpkp4cG+yiBnskHLry8B1sQUhdYht/mx4CEj7IZGLr5vLSrTA
	o9Nf/utrQNreX/QOqGwxKIdpOcKI/GLQ7lDkP06Lg3mW0Q/gIPPm2E+sd76DtuRRnxYmOPYYOYq
	dlZ/ZRURFMNjzezl2kMOsxL1EHXkoiBA=
X-Google-Smtp-Source: AGHT+IEgBdYFmpFsQlLd3igFNhSM2bn5LlcXWT1cbyPcqW/u7eTqHoO1i9rVJ1owB/tgZ5CnEV8DHA==
X-Received: by 2002:a05:6a20:9f9b:b0:30f:7840:2c96 with SMTP id adf61e73a8af0-30f7840af75mr9397829637.47.1759240757873;
        Tue, 30 Sep 2025 06:59:17 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53b9615sm14076293a12.2.2025.09.30.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 06:59:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3asu-0000000CZmQ-0Zal;
	Tue, 30 Sep 2025 10:59:16 -0300
Date: Tue, 30 Sep 2025 10:59:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20250930135916.GN2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>

On Tue, Sep 30, 2025 at 09:07:48AM -0400, Pasha Tatashin wrote:
> On Mon, Sep 29, 2025 at 12:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 28, 2025 at 07:06:21PM +0000, Samiullah Khawaja wrote:
> > > +static int iommufd_save_ioas(struct iommufd_ctx *ictx,
> > > +                          struct iommufd_lu *iommufd_lu)
> > > +{
> > > +     struct iommufd_hwpt_paging *hwpt_paging;
> > > +     struct iommufd_ioas *ioas = NULL;
> > > +     struct iommufd_object *obj;
> > > +     unsigned long index;
> > > +     int rc;
> > > +
> > > +     /* Iterate each ioas. */
> > > +     xa_for_each(&ictx->objects, index, obj) {
> > > +             if (obj->type != IOMMUFD_OBJ_IOAS)
> > > +                     continue;
> >
> > Wrong locking
> >
> > > +
> > > +             ioas = (struct iommufd_ioas *)obj;
> > > +             mutex_lock(&ioas->mutex);
> > > +
> > > +             /*
> > > +              * TODO: Iterate over each device of this iommufd and only save
> > > +              * hwpt/domain if the device is persisted.
> > > +              */
> > > +             list_for_each_entry(hwpt_paging, &ioas->hwpt_list, hwpt_item) {
> > > +                     if (!hwpt_paging->common.domain)
> > > +                             continue;
> >
> > I don't think this should be automatic. The user should directly
> > serialize/unserialize HWPTs by ID.
> 
> Why not?  Live Updated uAPI is handled through FDs, and both iommufd
> and vfiofd have to be preserved; I assume we can automatically
> determine the hwpt to be preserved through dependencies. Why would we
> delegate this to the user?

There are HWPTs outside the IOAS so it is inconsisent.

We are not going to reconstruct the IOAS.

The IDR ids of the HWPT may not be available on restore (we cannot
make this ABI), so without userspace expressly labeling them and
recovering the new IDR ids it doesn't work.

Finally we expect to discard the preserved HWPTs and replace them we
rebuilt ones at least as a first step. Userspace needs to sequence all
of this..

Jason

