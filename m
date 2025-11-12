Return-Path: <linux-kernel+bounces-896668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F28C50EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 942764E10F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D32C234F;
	Wed, 12 Nov 2025 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IklV9Kkm"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84C2C21DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932551; cv=none; b=pLz09nAnv1ifELUyo6Xb1na92kCXB793nk/p1MbX1Ffjd7YE70jJxZvpIF6nsws+UOM439o0Tvugxzx0A+z4k1A5lN08F6jfdSXc0aJuS/xoN1OsiQNrH7yW5FbjqTjXsGq0EzDU2HuFMaR/yKWLxvDdmp1cjdl/+24wXm502vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932551; c=relaxed/simple;
	bh=eC7AqgZQkH9Bf8jeUIBuhznj5sAlbf4jzNtUK6FuTHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7XjrEuOk5lpa3p0wx5z/XF7f23Qf9L0MXtPmiXZqeBT3Yohromm1bg5hbd22QRts0417l/o+qZ/t1nk7T8hCxgEOu7QMEVz6owSlC5feC3rPLq4vJV4C9P15YClOUfNpL2jhCQCgtnQe8FU1TY8mt2QnpRKaAO5GiP+BmJ/28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IklV9Kkm; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63f9beb2730so485271d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762932548; x=1763537348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eC7AqgZQkH9Bf8jeUIBuhznj5sAlbf4jzNtUK6FuTHY=;
        b=IklV9KkmskmVjgaZyDIsCa86GTXhekUFui1i7s1W+UH0c4Vy28po8j991YTkGsdz64
         VHemWC1/QDr4BBEq4V4Bfp5Uq5GTg7656XM/RaiT0mea9EKCNEclFOZAmrswGbUvoodU
         nOL8xvyqTJ5GTBCKQTqAr7eT7fvUT7GpoCKJ2eZO02fqQ7aluqLiE8TlD2MzErfUbxLI
         rNVUK9p/gpm7DxqioWQVqFf6DLkxhgGRRd0KwpZljNeD/SYmsxrdOKYBk4FYVP2w1Ys8
         CNJ/0gq8YU1N3VKZugFYDRwbFw8DXkN4bsOyEYSqvwfpenA/yyBxVZ4RQ6L1xq0MbXlU
         kxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762932548; x=1763537348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC7AqgZQkH9Bf8jeUIBuhznj5sAlbf4jzNtUK6FuTHY=;
        b=jO771f0J8iXzsm8GSHuefcTFeWmVGU6/mQYVBnkfEGRh7uk5MtyEPz94yrP39QOsv3
         83VLT2/71TFQwfEJUsuYq8InqPAjOeKWAuhey3gXT8KBNc3QgMg4BpUdPP7GEkum/aBz
         gKCH7FZsP+voHkAYvck3jW/xCedDMGdUSXDm0lqvcoiOA65+bnMBVhisFc55E8ofUQ3i
         mnNC9tS3EmDepohTzS6NyrrZSLNiiTsMK3/j2qc1jHK1+uxXGyGP0yKiKLEB8ZO0Gu6s
         3b2HtmMq7L6TVLjh1MqU4aXwPxtrwKR8JXCQ2ooAIQAb/Dk04Ck6otVuJyB0ypz3PW60
         RGVA==
X-Forwarded-Encrypted: i=1; AJvYcCUL8FY1btfEk2efJNjKcr/aKkWzbLh5aUGriDdTONTXKwl3PkSKTjR9cUG4wen2nS4RlWzI4h27P5jvJao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIzkqzBbdsCF1AqDs9UW4inPExFKSBPZDm6aCZYcCaDMpF2fC
	Ma6HNhx51hjXkkKFBVSqSen4xMnt4cBIA4p7/gVpgeJPJfVvVD1cEGxvnSAZ72s/9qiD48K50eh
	8qhmGWSzaL/vNHFtN4iDLUXR60GQ5lNU=
X-Gm-Gg: ASbGnculQ+V5K7q9vVIGPSvVfNNtlf5PvaZHcatocsMQndLGn8WVJsl1g0FRu3jkhdm
	YJw+gP5LGfi5nSDbVu1+V62XC1PH2OXZ9lWlTm4h0BumnwzAHoy5IA0TQVRFhtbP5s57G5By0Yi
	7tyPzkMDutaB8AxV2SWLQfY2C1GT1Heb8kJf0221zZqTOlgGOiqMq6oJHg8Lyf5VxRS7cmnVkQz
	k/am+QUumjE3z4I3Jn0G+daGrUw+wfODKQsuMH2vdAeluRZcy7hTCdrY01fTYYp8EZbSTLQ/23y
	2vz0l2AOvxt4BQ1KuA==
X-Google-Smtp-Source: AGHT+IH7KULuuRrF2Oly5Rimc+QhsJIxRJ3ajNz39rkRuKHwfzBK/tXJ3NwVa7aPrWyci+T55J/S8XdqtHfeU2E+JxQ=
X-Received: by 2002:a05:690e:d44:b0:63e:18d6:72c1 with SMTP id
 956f58d0204a3-64101b37d64mr1604942d50.46.1762932548401; Tue, 11 Nov 2025
 23:29:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112031631.2315651-1-kartikey406@gmail.com> <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
In-Reply-To: <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 12 Nov 2025 12:58:57 +0530
X-Gm-Features: AWmQ_bnwRTMjo11VJ1_SlN2ozfCDVzCWYVVmlr2dEKduOizviC1FKYdbRb3--IE
Message-ID: <CADhLXY4qMvBTqirNmzgiPszn8vCkCFV6GGeDkNpxVDi32uhzEw@mail.gmail.com>
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
To: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Hugh,

Thank you for the quick review and for looping in the hugetlb maintainers!

You raise good points about the approach. I chose explicit zeroing in
memfd_alloc_folio() because hugetlb_reserve_pages() can allocate pages
without seeing the __GFP_ZERO flag, but I'm happy to revise if the
hugetlb maintainers prefer a different approach.

I'll add the Fixes: 89c1905d9c14 tag and Cc: stable in v2.

Should I send v2 now with just the tag added, or wait for feedback from
Muchun/Oscar/David on the overall approach first?

Thanks,
Deepanshu

