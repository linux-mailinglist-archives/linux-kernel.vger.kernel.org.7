Return-Path: <linux-kernel+bounces-720204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83EAFB881
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65272179C97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C14217707;
	Mon,  7 Jul 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGbvo3sr"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780B749C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905133; cv=none; b=ui7QcAnbCri0lgtCIi13xfTrPSvgub4V9JhuTOST56+ZoGvkQ+3oHO6soSkOO0n1fkn529k2fStYh719pH2T3mhEW+p/3VnzDzeieZbAf6EYhHsugJFlA/QcUacPKwmyTIKkMm5KdQtj1Cq3u+UT82MfjAmr92PWAJWgHw++Ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905133; c=relaxed/simple;
	bh=mbn0FOtqyOrAa7bKllj5iYlS4RR7u584EVzV77yqV6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJOBVa0gOibf3uhc0I8QuuC46PKoLmbShyDszg1U6y/IQ7NHUkazgMfl4pg9KVTSzqnnvYxnT4ngoR7/uOyYWSOceSU0AX+4AhHa+1afMZ5UrP0xgyI67U6EA42bYy0fGfiDkASvROxmjpd8LcRRyQ+Mu4Kcw6UYXURv28IJzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGbvo3sr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so3074587a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751905131; x=1752509931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzS5ZyXhRFJQPdtT7pJWRReoUeeAi7PGNzHa/PItqiU=;
        b=AGbvo3srx0S3lyGEyvsHWW10xARmRXJq3+ZQC1OlRKJknX59LG64HRrwFWCYOKE8yC
         V+nu2zVM00rFF6jVgjrh99t81d3TLvIxHfNY8NwQQ8tPC0y4Qiq5ItFwI2mo76JZQYmH
         vsp1K2ICY8VA0pzsGwReQInZuorreA4gYflK8wflxmCQcmby+S4XFI+ro0sEbZZ7pIHA
         4iWjNzqwC3OAZnYuuCOx0OE6tSXdEK5C6q7WMEzSDlPeGO5WlGjAscl0mXmhJdo9vfLx
         zbwFii2yaWmcPcca6PRjyHbahNlOz7hnPRChms922t7Cy3ExIMV02zzJ1P13cSdcKgKJ
         1QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905131; x=1752509931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzS5ZyXhRFJQPdtT7pJWRReoUeeAi7PGNzHa/PItqiU=;
        b=jam1WG1/8B2ropo+6TGC4rXB/rPz09j1kEDQXjYl0Ou2TVrkTw2465kGC7cT3DhM2O
         DnWEkQXNcBfvAYRHz8fkYi9rFWwQvn5hTKz39uU281iSMqQEIHjsf9mSA8Ml/4ZfpXZC
         ScewVnwnh5UQy8Shk+rpuQmNE1rrfb9apJleSgX3cTXmhv25DhvPmVkmU2KxfhAXpbJv
         34v12zSJn/Z1T/PYDR+K8HeFp3H/6PPxNDclelU/LeWrP73SrhEHCtzFkA9bCNKTyo/o
         ZjD+9KXOxjmURRlkhuA7MC6+E7+Hpk9Q7/9EqxoOevEhmkfY3pcbQ4P9vUYrUfwzWeQW
         QiLg==
X-Forwarded-Encrypted: i=1; AJvYcCVM8gc//F5un2HLB+gMrEkhkwxPAw7guLVbLVX550W0zGI88HrqmNGaJrK/vuDNgxZwPijEBbzMiq/5zpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43yqtAO4Y1otldJ3BYyXV4vUooebgEX+uNAMKGNzvtVxFsS2T
	1DCIAbSwJxnpWQDj6KwxfzdK5TcknKDxrXzE4qwA3ZkrP7/ST0IO4zjp
X-Gm-Gg: ASbGncuPTEgkI0A2tEXquPS4pHoxyFUJTeNszfXMT43CBiyZQix2rD5EMvG9kOLLGnZ
	hU/gtcu+Bksc8mpATMwpxlLXO0KiPrF3q2dJjhi/fGIlFZDwyjcXesT2fZWag/OChmrI6G1Rgc0
	1DUT7gplZxoMIm0PON2ofn0+Rs2MjfxqQ+xUpWnIWyxp2XilnywuRZjROV2WjB3bsgdANGo1WFn
	L+N4r1g3HE2Ftzza4EgrethfZTV354capTi/ewyTT2gQEbLUEl7GVQm/JzNlN36nYSzwEk+POK2
	wOdXTm2pGpjcpCFJcbg9AzzmrBpTMvAuiJuRWNQYOCvTtsTBJ629nKkHjkjnu9KWWVNcAFNNUXg
	JADMOMOlu+NVis5/ygg==
X-Google-Smtp-Source: AGHT+IEFMLWJBeYDvpnTUie9w5m1R0hi9Kd6o+X3gA7ub8wJ283E92i6zDwHtWATmQshNQ9PtPwRAw==
X-Received: by 2002:a17:90b:4e86:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-31c20cce7c1mr130079a91.10.1751905130691;
        Mon, 07 Jul 2025 09:18:50 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae6b6casm10040486a91.18.2025.07.07.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:18:50 -0700 (PDT)
Date: Mon, 7 Jul 2025 09:18:46 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
Message-ID: <aGvzZijuczq2H5FK@fedora>
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>

On Fri, Jul 04, 2025 at 11:19:26AM +0800, Baolin Wang wrote:
> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> tmpfs can also support large folio allocation (not just PMD-sized large
> folios).
> 
> However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
> we still establish mappings at the base page granularity, which is unreasonable.
> 
> We can map multiple consecutive pages of a tmpfs folios at once according to
> the size of the large folio. On one hand, this can reduce the overhead of page
> faults; on the other hand, it can leverage hardware architecture optimizations
> to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
> 
> Moreover, tmpfs mount will use the 'huge=' option to control large folio
> allocation explicitly. So it can be understood that the process's RSS statistics
> might increase, and I think this will not cause any obvious effects for users.
> 
> Performance test:
> I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
> sequentially via mmap(). I observed a significant performance improvement:
> 
> Before the patch:
> real	0m0.158s
> user	0m0.008s
> sys	0m0.150s
> 
> After the patch:
> real	0m0.021s
> user	0m0.004s
> sys	0m0.017s
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

