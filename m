Return-Path: <linux-kernel+bounces-883513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C4C2DA83
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45471885ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB6D289E06;
	Mon,  3 Nov 2025 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UZWNhCHI"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F92AF1D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194135; cv=none; b=e6OBN35021Z+1O0OQpvTaSj5HUNwNfC+OQrw8/GwBl/EZfYhsEo7voo2WLiknHID2VqHaocCwcrmwu3k1WqF7a7XpQbroEdCgyH4HJmQJzk793owGxb40BkQymyDzJx0nnpB1lMr7dssN6rAO2+DR6cGKFZ/GsxpA7NyQpFYh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194135; c=relaxed/simple;
	bh=hBQwSFa3ls5tXGp6taWMTxAYUVgv5w1YYI79QHPzWyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B604BbEHxcYbCxixMros3/E/o2fpMgDV34FTKvBKKId+EVwBe2SvZ2JbFVtuhH9Uh/LKwrVx8OTNjDTqoKdDcglznLbNqotklnd506j+dK7Fu8+o97iJHTzVwfw8syZ5uQoqlEk+Mtu/7o13jqLkFxMlvpyyUIB4Yxqegyh/DK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UZWNhCHI; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so3383505a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762194131; x=1762798931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CADywisMv8oKHI4QSeR7YMm7LIR82MPNXUUykN5HtdQ=;
        b=UZWNhCHIJ/gRUyJkjqO9j2Ouw+9KMUIDZ7RU1g+gHLh7t9ogJKmadqG2ksz/6SINjv
         NfNNhN+pg/v8FKFb9RbHvyuzJPbyAiXVFI4O0+TAhq/KXKCBgiJyGv9an0kzjQSniWau
         E3WHw0WSAW2tXTpBj/AJZvw6yfz+NzBATlDmnzGfjJKVCOzGVEIOou/z18OiLGFGGl8k
         aQ79bvM4SvC3OZRtevh+OyGQhsEmpGLz9PEzkgYj+AsHo+xlob/xqJEgJLtfV+fqdQDd
         KRhbYW5RGsCFTIUGYex0VX9KBfqdojf8FLouOmHwynrrCWqUm5pwQ/w8ltayR/Q+61vf
         hP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194131; x=1762798931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CADywisMv8oKHI4QSeR7YMm7LIR82MPNXUUykN5HtdQ=;
        b=mjWpzv1w/xzCXD0ETmF6Kw7pyaiNGeM0s1kUiOQQtCLiFkSLwTIE7hboDYm9I7/6Xk
         hiKvKzVnwZhaOP4SZmJPlWYERdjJDMY3Qgvqp949NZ+yQAQkYoD882xpRhTInNIJ1eb8
         dLWbGRBVUll+xlYq4DeRxtI//84Ys3ZuVpzTz8TS7hcR6WqwWLBYVRdEYD0JX6Yk1I15
         AxaiNsBRTsWjOKgl98yLhg/x5uyk+O9oHCUWTWYS83HiVKWKqFH9V9gV6T9wLPV92fAZ
         ORqAshMZOGCv7Nfnk40ws9GavLykmGnbBQ2AZzUbsmBRtjkV8GRcXG678Mg6o0QAcIbr
         gang==
X-Forwarded-Encrypted: i=1; AJvYcCWEXqLCdQi31O77jTFruxO5cc2URbP6TUJjco/IzAPl5fzU0qxOHDPLLwcVAuC69/y/GpOFFkl5H0MngjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHIfY0rn9dMR7fnrv3TNM21CaPAL3JyHxildZkR3CJOXvVwn8
	MmBGdGVNf7ulm1O3fmTDLMccsyts2+2w+G1I/teEm5KgVm9c+Fpc4zyWO9WdIteRSrg=
X-Gm-Gg: ASbGnctBEVd17NG2Lz4N8butpjS/1gb9Ca/nZnKFX6kc/8JbzrWY2L5ppnE0eutul93
	TFjwFzRHtq4WFnpYL+IAHws1MZpdNyAO+iOQihrbDUgI2yjMwXGZlHTIyqapE7xWPMs9S9/TjPK
	JDxWWo04YzewIK46LVJF/b1pRFpZaw+JZbgFNDi9oNpW8+jFLk7iBN1FSUsq90ogzxoYWF0pHPM
	9prf055RkhqXRBn6MQe2Vw3aRISAi5mjXhDcDMg3R9lkmilQFxKl2ZlfstpbXiQgDGc1vrY5/qn
	+64p/PvqC9y1UgHXnETkUViZEISySkziIa8RtPZc0JsPfaDepp/lPtC8NH2LDIuGpOq3afNwDbb
	izsb80E9twrn0YK/wrFF1Y6T+iC7acQdEkLQYa/Jq5Og2mqKzxI+qSmFFNHf04LG3zfm8t5ZdiN
	/e1l8rUVYzU31/Hg==
X-Google-Smtp-Source: AGHT+IHNFHN7nALHAQI3py5s3oB3pNSaTHU60CtQtHtaXj2ajzjyABGHYsA7JkTUyfWfWQz+8Ib3/g==
X-Received: by 2002:a17:907:944d:b0:b70:b7c2:abe9 with SMTP id a640c23a62f3a-b70b7c2af64mr561377766b.38.1762194131429;
        Mon, 03 Nov 2025 10:22:11 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bedcec19sm413921266b.7.2025.11.03.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:22:10 -0800 (PST)
Date: Mon, 3 Nov 2025 19:22:09 +0100
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
Message-ID: <aQjy0ZsVq7vhxtr7@tiehlicka>
References: <20251026141919.2261-1-ankita@nvidia.com>
 <20251026141919.2261-3-ankita@nvidia.com>
 <20251027172620.d764b8e0eab34abd427d7945@linux-foundation.org>
 <MW4PR12MB7213976611F767842380FB56B0FAA@MW4PR12MB7213.namprd12.prod.outlook.com>
 <aQRy4rafpvo-W-j6@tiehlicka>
 <SA1PR12MB71998D21DD1852EB074A11ABB0C6A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR12MB71998D21DD1852EB074A11ABB0C6A@SA1PR12MB7199.namprd12.prod.outlook.com>

On Sun 02-11-25 11:55:56, Ankit Agrawal wrote:
> >> >> +static void add_to_kill_pfn(struct task_struct *tsk,
> >> >> +                         struct vm_area_struct *vma,
> >> >> +                         struct list_head *to_kill,
> >> >> +                         unsigned long pfn)
> >> >> +{
> >> >> +     struct to_kill *tk;
> >> >> +
> >> >> +     tk = kmalloc(sizeof(*tk), GFP_ATOMIC);
> >> >> +     if (!tk)
> >> >> +             return;
> >> >
> >> > This is unfortunate.  GFP_ATOMIC is unreliable and we silently behave
> >> > as if it worked OK.
> >>
> >> Got it. I'll mark this as a failure case.
> >
> > why do you need to batch all processes and kill them at once? Can you
> > just kill one by one?
> 
> Hi Michal, I am trying to replicate what is being done today for non-PFNMAP
> memory failure in __add_to_kill
> (https://github.com/torvalds/linux/blob/master/mm/memory-failure.c#L376).
> For this series, I am inclined to keep it uniform.

Unless there is a very good reason for this code then I would rather not
rely on an atomic allocation. This just makes the behavior hard to
predict
-- 
Michal Hocko
SUSE Labs

