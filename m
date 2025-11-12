Return-Path: <linux-kernel+bounces-897177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0FC52360
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 742A74EE4E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A983314D2C;
	Wed, 12 Nov 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZcEF8yR"
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094235CBAB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949202; cv=none; b=gTRIBf6gXHisUsjdfIklsvVhZYOMEBfIkQl5RTiDCHZTbYKWYdFFaZ0wJqkoD4+eoyKvoeSA4lRXee1XvA1h9PF+0PGDiV/L7OqfiYu0lpitPNO3v7YOFE97xjQLmv7QI20IY3eIs3zbISvpbhMxQLErtxJ8SmKhLA3EahOiCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949202; c=relaxed/simple;
	bh=8Rww5lSkbQz1qI6uXNS0kAognCF8JsETbZNPHP3L3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4ga5xMH5d+jLnmjWkO70wD66MoTAutyTtZREXhjcuVk1UCgoTIXaMrHyh/YeOSj29wAHE3VhFyL6F1unorIZvHuN5U8Ohg4QHZF42uqfeoDYg2Ej9IDAVQ9UWgDqabq2Gm7vVoH/TJ0l3+IrwNeLFwuVgANaFSiYK7t0fTdUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZcEF8yR; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64107188baeso287653d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762949200; x=1763554000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rww5lSkbQz1qI6uXNS0kAognCF8JsETbZNPHP3L3TE=;
        b=lZcEF8yRyRJvgR3nxKtwBFn0K4vVyycjvb8xgxYd+z6khmvLhKW4XQlCfkuDtQFf9E
         Jcu3Dysc54vnH3lqcADIm2+fXPQSt1J/tH/8GLy6o9NzkpPjq1nLksVe69sTifgjejqT
         vYzRTg+ubWvpAFVYpNm9dju/HueXpHb6ARE6PVOOKkKPozflJATMItcY2NerEjBL/Pvv
         uwLaOooBx7AOEU7XCD0BvfR+UU07M+vF1DheFU4Tlbw9ntXks/nHoNd8rZErTxhkg6Jv
         Hh7f2A2QTmz1XMo2He8juNzQBqyPcYinr86+wlOS8Wykqx8ptetigT7R/rtFDAsDnsrU
         hKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762949200; x=1763554000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Rww5lSkbQz1qI6uXNS0kAognCF8JsETbZNPHP3L3TE=;
        b=UEPXX05J00RnG7tSVQ44eRDE8gKXkkXkj8Z8CU2Qk+segu5B5L4BiglLP0cpCr0I+2
         iHei2OAUB9S528XxCPT9FVgEinZtbsZ4auEKTti8BaAQeWJ1hTK2jnma/qWNTEnNpyLm
         EgNFqQvoZFyLfv995lczgH7Adfs6BZZvP0+jn1whVAHBBzb9MBSUQZJiwMTzO9Jg2E9V
         riIzoYyKzOUHlKNmrENSLdr6KRWxmQCqYIDHGwM8wWDWk9AxvBAbNu+Q2h/UjUFn9+cW
         5N4Lb46qL2RvIbC/lZaUk9QIKwnMO9kQtn7qOetGVQ3ttd0K8ZzAMtlRwJ6stkpey/b6
         XAxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9qP4GqSZuAqafjlixiqBldAfZ+CFYc0tUfsMxKyQO+vgiKkorejV9GpsO2WtWKx1FHod9QEnjzfJyT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSNVUVfLUll8inXjvmhffvKpJMzpPgG55Mcwes5QNs2omRHgm
	Y69JmqJrTYREJVR0ze0JvFAvzXQ0Stja8LtHuZKlekjyiuB12UlRjwrrgAjsgfiA1bLGSOEabz5
	3iMONocBXagAmHhBDq7m5IQ1B+e7oJHk=
X-Gm-Gg: ASbGncu/gNKsarpUbrj4sRUV/rBONsjnjKVa2dTzs5D9DdsGkD3IyCIUucb/1QK7Pfs
	fWBQ33DS64bPWvZB3dw+yV8wy6QRMXizICK8EKDEi2dN8Tvw7Alkn/0mAC78QX3t02Rzm5Qx/jd
	SX39KdqwFDLdiwYm5iSRjzJOJW4pFoIhMFBrlQ4T8ggrpXD7gW/rep7UstJP0CbGjSUs0ntSs0W
	ajmb/tKuCYhWS+fqJuxDUxfqVH/a4iDoZA64QH2QNgMFFw1tXvmooy3ZDZQDrP5I79C58fkmTCB
	bph7mj0PcOBlUNL3fA==
X-Google-Smtp-Source: AGHT+IE7oaQsaKznBzR8Ac3oK5FOFEcMdzAJjty5XgkozUB4aq/OhhvGTu5ZMJmYxWQI93r5GpFTb5jZk1VXVRkkkMM=
X-Received: by 2002:a05:690e:434d:b0:640:dda6:e957 with SMTP id
 956f58d0204a3-64101af01d4mr1785386d50.36.1762949199923; Wed, 12 Nov 2025
 04:06:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com> <aRRPvn4DYAhuGtq3@localhost.localdomain>
 <6a63dbb8-58f7-4511-8090-18a58c3206d8@kernel.org> <aRR2AV7_R20i4qi8@localhost.localdomain>
In-Reply-To: <aRR2AV7_R20i4qi8@localhost.localdomain>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 12 Nov 2025 17:36:27 +0530
X-Gm-Features: AWmQ_bnxqCiaWnCHRpe1E-k3cnJAWJ5GNfV5Yy_j0wQtY7Eb4hK9FmpxM7a2drs
Message-ID: <CADhLXY6keq6+0NY_=xiugguHNFGpFGc07ePWbiTTFU3qO534rg@mail.gmail.com>
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
To: Oscar Salvador <osalvador@suse.de>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Oscar and David,

Thanks for the guidance!

> I guess it is worth looking into it, I shall fiddle with it.

Great, I'll focus on fixing the immediate bugs in v2 and you can handle
the refactoring in a follow-up. This keeps my patch focused on the
security fix + the missing initialization steps.

> Yes, I would go with folio_zero_user() as well, to match what we do in
> all paths.

Understood. I'll use folio_zero_user() in v2.

So for v2, I'll add:
1. folio_zero_user() instead of folio_zero_range()
2. folio_mark_uptodate()
3. hugetlb_fault_mutex locking around hugetlb_add_to_page_cache()

This will match the pattern in hugetlb_no_page() and fix the information
leak, missing uptodate flag, and locking issue.

I'll send v2 shortly after testing.

Thanks,
Deepanshu

