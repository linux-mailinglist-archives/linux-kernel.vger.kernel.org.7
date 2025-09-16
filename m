Return-Path: <linux-kernel+bounces-818234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC4B58E91
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B8F1B27912
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88D2DEA74;
	Tue, 16 Sep 2025 06:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztR+rMSJ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503E2EAE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004942; cv=none; b=JP2vabW+EsC0IUrkv/tPpJAXCYWrJ/XvqWhjo9c+4XuAAOI+5WXWEJtEs6Uhb6K9fkOh+eNnCkMyMSDTf7MBp8tRuAi1+7Lm++SAHUd1+QJQwfmenyZwIYXZq8ZfD45cZiHCaHoQ/oTxLGD74oppeEIKxN1Nfu4RcviKVxd8FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004942; c=relaxed/simple;
	bh=Y39LYFDrdZYkf8OdftXjQA1WiBA8IV0gAXokxGFG1lM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QZQM1D7cbTEqSyZuAyaM5XPdQqYsIqLEzfAQgx/Kyy5JNuZrCu1ymPzCWaTbbYzxdF8oC0WuYYj9oEKODbqrGTpeH+wyf2qnq7Kq+pcFmkELmkWLeCy9yOwuWk02XdCtVjEiGaFBR8gz1MhwAiFYaBXepB+Nz0yM1PdHPXp3eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztR+rMSJ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-724b9ba6e65so33320397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758004940; x=1758609740; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjkprOvz/RkqKX+dHlOFxhwsjERP8ama3QUFKbBY1II=;
        b=ztR+rMSJclxtTSg/lYRfP1OlVKt/OxDOQSOSe3F+CyvXAp0EALkclY6dFEPvuZtY93
         2etPV4FvD4VpPYNAsSw3yqgfg7oACwE32JchsUcJH2UgJEm0LVOOHkAQ0SuE676Tse5i
         aYTx6V3Wn4B1ZzJgjpPoI7si/1qK/l+EohcMKJNT9p+ONv6ERxFfG+Y+YQEB5bdO6X7l
         Hu5cMN20BwAntm7UmFB3HNQ6OyhammxtIyp+1VlKFLK0bAR7JErO2xykvyMCKgBSGKgV
         Y8BVGsHgTJcPzOpVUUbY7yNDSXFONKPthL93+AcKSlV/yOHZ5N2CvyBii9ertFD4rOHG
         Mupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758004940; x=1758609740;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjkprOvz/RkqKX+dHlOFxhwsjERP8ama3QUFKbBY1II=;
        b=Y1ZxYAi2+S/36laOEhbjKV1Wx53XT5gwsKBrkK0N8DVgTqaIw1jkxQJ55iVOCufHBk
         pQv8UOoDv/eR8cLZTSKZ1Qc+vy6AlfJcTv85/WhUziJico00S32J+XhdoWWyEn5Zs5VQ
         2GHnXd2pDznuHg53AcfbFXo+ZL44AT5YeyCRTi6gfj5/BORq6VNx76t1Xdqt5qdhE/KM
         5hG9oZfvBbp+5/hGkMUWW/oz5PFZCuQyyhdcYl/K/wZmzgS3ZKZWddVSmzahVGzK/SJe
         82RLwjokzn4zQ4B/uHonxb7hXR2VWuRi8P22byY7IChn9+ZLvfaLaSbdhEmo4zBCGN6G
         +kAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpJqNQKK2W0+d6QxmxEYa7VM85NtA35u769Y+5arT2ZUHnzgoCvzIv6qQiFwPt+CosCQ+1d6GzbHmuwZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUxRmR5vcWbjZMExz9SyjCNtfCBoRFA539xoYEYQtLS1vJcuA
	WSUXTCLDoxAvEl3jQO7IVTeF/RiJnRH3OsIylXUIL7HhP7kGE3KJSzEf71nSnR9aXQ==
X-Gm-Gg: ASbGncsiWfWRtouk/V59NxHPJe2NOFHPr/HXPm8ecwSuxiUwRrMAEhqDhLE13oS0Itx
	LlH2Pln0AtzPOX8V67SZUyUTwWT+X2dc8xgarbgXISBS73efq5/EYxIuReyG1PdcQLaysotXpyB
	DJo19cU6Q8oMAG0NqyUKDCr4ZKv5a0Hrl2zzm0Sg2nV39dfqwv6EEsq0cTJQ8si5KB960gI8uXM
	FOA364mehRrZTudNxhJrt59tdV/juTRGsdGl9ZuMDDhWaibsgpRkW/gCcctkoJXV+KvqD9XwlfE
	m3U/hwieNzutWwjmxuWpe5Up1JyeTbRPydMmvUBQDrXk3mDYAF3/9/BxmySuIwh8zRrj9XIqtX+
	2o76kOZkMjFcL5oSzzSCnzOix9hXTr/AG16sVXuCfkTd9v3B6JrPQQs3GXgjYYw4yRDNx15K7JQ
	sF84k4Z1C0i72Ea2wDPl0DMywloT91OK3NzVg=
X-Google-Smtp-Source: AGHT+IFa5Yc7kB+jDP4gPjlSUbmKLcKObhsiMC1oLC1zyc2+6uKV6Yk1QPHdZljy/C43ynHyygPPGA==
X-Received: by 2002:a05:690c:6288:b0:724:2cad:8df6 with SMTP id 00721157ae682-73062ca5277mr142928827b3.16.1758004939742;
        Mon, 15 Sep 2025 23:42:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f769302acsm38528677b3.29.2025.09.15.23.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:42:18 -0700 (PDT)
Date: Mon, 15 Sep 2025 23:42:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Lance Yang <lance.yang@linux.dev>
cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
    david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
    baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
    ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
    ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier
 in khugepaged_scan_mm_slot()
In-Reply-To: <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
Message-ID: <70da1948-b0f2-f54b-e0eb-ff901e007ccc@google.com>
References: <20250914143547.27687-1-lance.yang@linux.dev> <20250914143547.27687-2-lance.yang@linux.dev> <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com> <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Sep 2025, Lance Yang wrote:

> Hi Hugh,
> 
> Thanks for taking a look and for raising this important point!
> 
> On 2025/9/16 13:32, Hugh Dickins wrote:
> > On Sun, 14 Sep 2025, Lance Yang wrote:
> > 
> >> From: Lance Yang <lance.yang@linux.dev>
> >>
> >> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
> >> mlocked VMAs should not be touched.
> > 
> > Why?  That's a change in behaviour, isn't it?
> > 
> > I'm aware that hugepage collapse on an mlocked VMA can insert a fault
> > latency, not universally welcome; but I've not seen discussion, let
> > alone agreement, that current behaviour should be changed.
> > Somewhere in yet-to-be-read mail?  Please give us a link.
> > 
> > Hugh
> 
> You're right, this is indeed a change in behaviour. But it's specifically
> for khugepaged.
> 
> Users of mlock() expect low and predictable latency. THP collapse is a
> heavy operation that introduces exactly the kind of unpredictable delays
> they want to avoid. It has to unmap PTEs, copy data from the small folios
> to a new THP, and then remap the THP back to the PMD ;)
> 
> IMO, that change is acceptable because THP is generally transparent to
> users, and khugepaged does not guarantee when THP collapse or split will
> happen.

I disagree.  Many of those who have khugepaged enabled would prefer
it to give them hugepages, even or especially on mlocked areas.

If you make that change, it must be guarded by a sysfs or sysctl tuning.

Perhaps it could share the sysctl_compact_unevictable_allowed tuning
(I'm not sure whether that's a good or bad idea: opinions will differ).

Hugh

> 
> Well, we don't have a discussion on that, just something I noticed.
> 
> Thanks,
> Lance

