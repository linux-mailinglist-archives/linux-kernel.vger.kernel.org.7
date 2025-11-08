Return-Path: <linux-kernel+bounces-891287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A151C42577
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 04:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B1F188E318
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 03:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC524157480;
	Sat,  8 Nov 2025 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqvzXnEv"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5382561D1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570902; cv=none; b=C1Gg3MgzuXY8LYF0B3pZdYgN4QAGp6Yw/kKNZvKzBClOyfi7/NxWnOJ3uTM6fpdpcpB9cMJwy+hW6xZ7bfVYQnMXgljfd+gg0oMR/0O1cmX6LmT+1q9xGTkszzMMkXyOd3I4nSSB97DbZFA2dsoMCFaYe8GQeKftZ1MXhfz/6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570902; c=relaxed/simple;
	bh=Y9YV3f8Hzry+Ze97F/cP+/xbypI1KDyCVKpqIvt9p8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGNe99sI/+i2zYYuXqtJ70VJ3Wo22MeAeIpzQ1SxI+/K8n7PmssvQLtZtUaIJHhUq6Ynb17+q/zKr2ULDc9XeqEf8N8YOsOwKgOngGQnWTAs7SbOAWNO5bGGsynagDovokI9ZeWnTIYHocN8bPY8hIqfL2t+euno8jZhubR1Rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqvzXnEv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so235040766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762570899; x=1763175699; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvQMGIBRXMAfRMIt2kKWb8Pd94P2qwTUjsmasBUxq4U=;
        b=OqvzXnEv/XhxHmFBcR1ZgdHs7bn8FQ5YaZxR9JHfFjyEalXa+PztZRYnpBlWol6T1a
         iPtyDoT1hfx0gKNJZQfU5X91OFEj27uhQbNL6ifXdIwZuYzSpkouweXU5O3Wm/ngn1wI
         qfQS+yAbrU5xnYzm8bYDYoThZmFG5oFhIpQM+y+ZzmppzZK1BZUBXK52fAqM4QyjRLrZ
         K6tHCMXcKPET8xrjS5whbhh1WridPW5weg0FySMWCw/VTL3kpazSSGiiaRW7ZjBusVBy
         Bva9dSc1kNmSGMxXOWULtg/owMftQ9hTOyYITPwOpNEeuKXcbZxfXMXDSMB6bIpIUkiC
         lnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762570899; x=1763175699;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvQMGIBRXMAfRMIt2kKWb8Pd94P2qwTUjsmasBUxq4U=;
        b=rroGss+ligJ83O2MWASazaGFk9v/i5j9geHu9K9S+jbBvfwLN+7rU2t5/VEZjiYYFB
         w2fp+QgkkHVEFmxFbY6Wcr6oXqAE9Aoi2v9lbS8k7HRlLh5rcxHELOq+mi3V2h2BTxaH
         dA+/izAaQSzGUmCBCkWhV8LXNZejgusSARlgEqJAS66ckDUy5h7koRhpEUc5IGGM60KO
         gqZm9ChkzLWeKGvSdKQZ5TrtCna+vjjIox7YBQHwfNqAyWi3AhV33seozcVDRy0gMVMf
         dCRiurtXA+QIMvzcQLWUGML2xScooaEZsUxObocTZvRM3fXYLElijDG0/RA9uFSjWF8B
         BoVQ==
X-Gm-Message-State: AOJu0Yw2/mF57AOrGilvjaxnGLLCRUjvUaJTxRLEhRKv9T1IT3F37Q5V
	WdqMk/1E9pLPK0qaYFBnnOMNHEb9UE/0wHkemIitcQSvr33d3wG6bM9n
X-Gm-Gg: ASbGncuBczAB8t1Y6rKhlaSa5bIdaUGTABDEtZWtqDx/1K377bYOJIFil0ZAMHaYWlm
	eKl9I3rW+C3fGQSB2WAyNa49mdfvwTQM/ceHsyQar3v1FAEqGgS/TwUnL65jfviKANvoR5ziG15
	CCylU3uVCC4om23nwwhknUD46WsY8dMlcHSQrZQWtfhT/Or2Tx+oL6EeRhg/h/AF+4XBKzFGu58
	aGHJLXzCZJfno7Hbrwyz7SuEyzfg0DAdrARPi4tT2zig3j5hNHlc9fycSVTio+u/YABYLFaQHmK
	+ZaWthgS2SdxZUi6jzzhpPmTLq30g3Tvcj7FTF6QnruKKYsC+pwg7DxtjANfOH6tL3z7wpXFuIV
	pWmLg7evYH+6EWDvlLvn2eFGBwuzL0DbLf4vMvlhzUDhT/DKmziGPORjTY1B0CXyFSRHkA4Sy1J
	8=
X-Google-Smtp-Source: AGHT+IFpe9qLqPYcxu/67GnD+yfSvSPuX6hzgETXb3TcPECOp4WGRyEJjWKfcLIhMsnwyzl+jMrZig==
X-Received: by 2002:a17:906:7313:b0:b72:b8e4:3aea with SMTP id a640c23a62f3a-b72e02b35cbmr147921966b.10.1762570898658;
        Fri, 07 Nov 2025 19:01:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312e25sm397398366b.20.2025.11.07.19.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 19:01:38 -0800 (PST)
Date: Sat, 8 Nov 2025 03:01:37 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 05/15] khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Message-ID: <20251108030137.mud7xxwg5fxdgm6k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-6-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-6-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:07PM -0600, Nico Pache wrote:
>generalize the order of the __collapse_huge_page_* functions
>to support future mTHP collapse.
>
>mTHP collapse will not honor the khugepaged_max_ptes_shared or
>khugepaged_max_ptes_swap parameters, and will fail if it encounters a
>shared or swapped entry.
>
>No functional changes in this patch.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

