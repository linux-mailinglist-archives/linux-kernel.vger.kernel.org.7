Return-Path: <linux-kernel+bounces-879712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC81C23CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCFE18899E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABD02EF65B;
	Fri, 31 Oct 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TA+HBQ3k"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFEB2DF710
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899245; cv=none; b=EiSTwE+FlJyHM7XmfB8Qka5w/HT6HSbPHbhVv4JzzpNDid1/If2IIPJ0MiLV9H06ZY2CtjriOR43l2mq7xZGu1hCVMkxtxc0H8e6l4e6NZECxELrZEGRymFIjkgLui0h8dgwCoGgQhbs3UIa9hELqRdWWHIeFclk2NG7F0sY6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899245; c=relaxed/simple;
	bh=lVQsmI/OgcGtefcLtFfLf1leQyCYm0kn4f7Js5h7gO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdxpKVxmX+7wa5YaJaWhSg3woQYsEA+A/potGvMCkv6yb6xkuyOZBdtVPwjHknqGV34HZfV/b2VsVBjPv8g/qtSlaj6OoxaWAWXwGLqIf39jRMZ9VkFcUW0gQUF90pKw/V35Wh8+PO4hj5U0eULmeqy9j5hNc4P4BXg98B8rIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TA+HBQ3k; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429bccca1e8so547482f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761899242; x=1762504042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=TA+HBQ3kNS+7xiiif6xKFcAkfcAzM88y0Sf58DeYTRQoQGJdQPXMGZyHs6lTbBCxZP
         lbhMmmkg1R1ADgijncgEzu2XrFXDcIInDZbeY5ULZdx8d8NlK2sos//XKSNgSRRAWvvi
         yNb6AyLC+OKnkGfefh2/Ef6qd6S27sBkqjzWP1Jz9k2PMq18ukyoY7Yp/Srt4WOdbsOf
         xQCJ6oJ43kLilMjK2QHuETkDtYl3eu7z0Va2N6JTTiFbd7hiEbYrnqE0x1ckURea6zzL
         e2hu0CpGvSb3luhJ4HFxzuxB1SKaffBjTBbmLFoUg0asMJBQ1IYDH5V2ZsnPsHjNUI+E
         0T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761899242; x=1762504042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/fYaZtBikFS6oNzHl/Bdj60BD7iQqSjLDzNr7ZdDK4=;
        b=sQMJ/gQh35g/9LRL/vSdx8ikTVESgMe2APAEYf46z6CjXr0NU2S9gfznWbJbLhM8W1
         X9MdX9q9coZPEC8u8Gdj2ZCRAW2tsaJV3Yaq2yF4nOGPlNGGG6UKKEFE5HPUdZcMJGZL
         hNgto91lCmuJ92iJ8iaNskVGwKazAZyZwGoaZiuZwWs8PdGjfi6afuSX0tfn7GkJ9HKn
         hSupt7/rPmsbUbfvFjwaO2l88oLJAozykp9VtBjbTaJL8qJhPeFFxflSZoXu8btiCq9g
         oOjXZKh7EcDcZUbbE0HK9eozL9HeM6vIqYxmzNOI2LjWhno5Xo4QP0NRJ5oBComP6NY0
         ckNw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YOoN/iUwe3DCWk/gBniYpXSXWflBGgrbiiM+jd/1Nrd7VNLs2//wXfFefYCrlaGcWOauc1T3h6Hd9fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgArBTV7dCrFYG0s4U2GDEi8oEXNSZqklTK9qHaWus1y9gjblY
	JtJ68hGe9/LhqMABD/UtpYft7Aavye3W9jnPCkT21pO9TP+dLmVgzrEYHjk6GKozdYk=
X-Gm-Gg: ASbGncvALrCanL/c9bVGepPyeEtmHfCyMkzONZTtRRpfrBZmNZZ6kTIxBqJ+7i6/IFs
	ViECR4GGPktAJUvtWb41l2yu5xelhofFCJlBXSi7DrUSny6ALW7UYOHIwyqjmjB+f6DKIoo0Uq4
	qrAAH1S3+kZTQxjTHuoXDHHn+Si/MNcCp3SppDzHitYK+IZ7nrk13h8qmQ7fkr3bWYek9x7fTcl
	gruYHHjnQKugzSpWlYQ3KfQ4/3mYBHNxWjxhBzoCvr+aNyx5TgCKIk874jCHwMKDE51PF3OyvJW
	WB6/d0hI/sJpHPZKSUFL1YQsiAWYuhwpwldYDl2K4Le4IHHyQQ9aHkhPvAeThwp+OOFwbN30RQb
	WQxVwt6bXTarjIeeHIDslx2bfPmF+FZCxzayhiiK/OA3Ica7Nmx0c3/5dpG7xozhDsXTXlhYgyZ
	E9GIF+qzznmMrD/NuHmcPjjcJd
X-Google-Smtp-Source: AGHT+IFSgi5NgEp0bWNzIHDj0wUEorxSLRV/wRdPuexvpAZjr+shE6+j17OmyoRsqSiC8CijMQFTMA==
X-Received: by 2002:a05:6000:26c5:b0:427:580:99a7 with SMTP id ffacd0b85a97d-429bd6b222dmr2082292f8f.59.1761899241764;
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm2242752f8f.17.2025.10.31.01.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:27:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:27:14 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Aniket Agashe <aniketa@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Matt Ochs <mochs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"david@redhat.com" <david@redhat.com>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"guohanjun@huawei.com" <guohanjun@huawei.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"alex@shazbot.org" <alex@shazbot.org>, Neo Jia <cjia@nvidia.com>,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] mm: handle poisoning of pfn without struct pages
Message-ID: <aQRy4rafpvo-W-j6@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>

On Wed 29-10-25 03:15:08, Ankit Agrawal wrote:
> >> +static void add_to_kill_pfn(struct task_struct *tsk,
> >> +                         struct vm_area_struct *vma,
> >> +                         struct list_head *to_kill,
> >> +                         unsigned long pfn)
> >> +{
> >> +     struct to_kill *tk;
> >> +
> >> +     tk = kmalloc(sizeof(*tk), GFP_ATOMIC);
> >> +     if (!tk)
> >> +             return;
> >
> > This is unfortunate.  GFP_ATOMIC is unreliable and we silently behave
> > as if it worked OK.
> 
> Got it. I'll mark this as a failure case.

why do you need to batch all processes and kill them at once? Can you
just kill one by one?
-- 
Michal Hocko
SUSE Labs

