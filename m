Return-Path: <linux-kernel+bounces-809806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA2B5123F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8DFE4465C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A338531282E;
	Wed, 10 Sep 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndtkMA4h"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF092D1932
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495787; cv=none; b=NAaVlGBNOZVQ5MwT/WwSGMiL1707V+/NKg5aFtyF32i3zu3MWoAuKzbbFWREM0GoNM1YICWlvrFydtO2kId9KzYl0zIl6xiVgvFqOOWQtjwsI3B1kLY1YH8uGTZ4DRrM/baVaHw8nO+/2I6qx4Av3FFGk10NpTlw6H9homPiOzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495787; c=relaxed/simple;
	bh=bvFAdg+99Y4GcQvOE7202Ik8vv5RqJPxzNGeUuA6ifw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnpeVhu3sxhQmzeCQEfNv2JQETEiuFfmUkEMG0gJELjq4WWsAgJblkFFcBZyxmbkppQ49vwe5HjdIPZru5pXgMUz6Yhp/0fIODYpOQdTzfPaBg1QOVwZMw03IB+djeV4uaD8OpwVxxwUmMdFfTzJL6vkLdPUmHJk5rRgBwDuJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndtkMA4h; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04770a25f2so905490366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757495784; x=1758100584; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWoZ3l7726OX3jB4OzkYOebIG9vuSYZtg5rWWfuavnw=;
        b=ndtkMA4hsou/XsyQOtKKH49+K03lKPxnEuotJL9b/WKY/Q0lvkfiVO2wGae5Uh8eYx
         HEsL55cSWda0TD2+mVuOdrjQTXzSLDZUVRpMRZOiRCyFRGMjDBYI/R6vO5Typ8nFaYq4
         ogNjWwci4lV+ChAUG1HXqgePhnC8Chd0udEO/hOWOZD8o+pVR9CEzY2wd7EkHhWtmEpZ
         1SFkFYEOhHUtOaUtxWCigwaLJa4fIpA1/WPT8BzJ0uIRtaLLalSYCtCyrG/prOBXLPGV
         NX12GfpZ5LmoQFBFbPOIMY5omyzWPps3QXdeCqgk7ajGbFk2D0nSNCGYMRODY/wGoeDG
         fWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495784; x=1758100584;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWoZ3l7726OX3jB4OzkYOebIG9vuSYZtg5rWWfuavnw=;
        b=h2Zge31owO0a6/bKp9j6XURHrBZif1adWWquAd3ojQpCVasxf84sWCq31mIUUntFcM
         xH5pW1jFlRoudCNhaOsfepq02fXdr86AhaFLBCNk5ctjq/3ki/0NWW5vgfKvUGO4eNPa
         sIRACoM38V66l/2AUgFRPbdJD/VZBK0EssnE+xmdyigBuZXr9IR7hXpT21ZJGn4o0aF8
         kWg6R6x7EQnzmA43XaNfEP8JRDI4L9CULWTgwAhjtEVpwy+J3/u9KckZ2GUmgFOwJGMp
         rbt2tAqmCSo/8BHur2XBcKIrE22n2GjTx7Dub7VsovNahBTNei38XuG1kK5qD+pRPHP3
         Y24g==
X-Forwarded-Encrypted: i=1; AJvYcCWwFt6Qkv2GMVOeIAbZG3WWr3aOmQub7ragM1wuVuYp85IQkZ5PvQWXc/nmezn/USZQFAFmdjFliTMbdMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEJ5sG8t/AV4Q/EvD3blHDcuRpyTKTHpsUa1gfLI4h6IyeGtf
	WQWst+LZ11Ni9lzFvfV13Gf7XUDB9Td+kaVRKJWAtY8Q+eCRp3i5G6ox
X-Gm-Gg: ASbGncuZxwqiE/JdG8GGaJS4AfDwQJbvn8C+IcxPYewL6Q/Kx8wAHFimmvzi7eGa7RW
	jd+J4G9MDCRRgqUJOmDXVyeM2oFhYuoPKkrZE7HyOdd7Q8tpjpl4j4jUMFt1xqK3unOyz7kbQxt
	+MsvhOGl/oy9zT07fT+vPL1SA+t5wQ5dQmtx/HDR/Zer9zaHa96dnRd2eX4LrLvxrjRbTt7xNzW
	sD2i/CU07QiDJMk2bKZhbimLMxughtthzUDqJv/rhJSb8XLePm/Q5XeNrsksaleCsW/cICHScDU
	hafdeAXMT6XFbCfRZTRXo9dDJrY+f4+bQDI5sO3uZfM4MSKMKAQWbks9LxVlA09dMgRXaGYEvon
	BSyKgEcMvd+NmOcNugE0/KOu1wQsfkBvpY102
X-Google-Smtp-Source: AGHT+IHqqOBwc9MStuYkne49yKfqkD7CJb5YxJGgDsZcBRqDaXnifBZ7VkKR89evu+GCbSRqZYXxQw==
X-Received: by 2002:a17:906:fe46:b0:b04:5cca:9963 with SMTP id a640c23a62f3a-b04b155a032mr1515367266b.41.1757495783403;
        Wed, 10 Sep 2025 02:16:23 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe99ffc0sm2868513a12.6.2025.09.10.02.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Sep 2025 02:16:22 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:16:22 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zach O'Keefe <zokeefe@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
Message-ID: <20250910091622.n25zvgw27olskao2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250909190534.512801-1-zokeefe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 09, 2025 at 12:05:34PM -0700, Zach O'Keefe wrote:
>As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
>thp collapse no longer requires file-backed mappings be created with
>PROT_EXEC.
>

One question, what if user run this new version test on old kernel?

Is there a guideline for user?

>Remove the overly-strict dependency from thp collapse tests so we test
>the least-strict requirement for success.
>
>Signed-off-by: Zach O'Keefe <zokeefe@google.com>
>---
> tools/testing/selftests/mm/khugepaged.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
>index a18c50d51141..3fe7ef04ac62 100644
>--- a/tools/testing/selftests/mm/khugepaged.c
>+++ b/tools/testing/selftests/mm/khugepaged.c
>@@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
> 		perror("open()");
> 		exit(EXIT_FAILURE);
> 	}
>-	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
>+	p = mmap(BASE_ADDR, size, PROT_READ,
> 		 MAP_PRIVATE, finfo.fd, 0);
> 	if (p == MAP_FAILED || p != BASE_ADDR) {
> 		perror("mmap()");
>-- 
>2.51.0.384.g4c02a37b29-goog
>

-- 
Wei Yang
Help you, Help me

