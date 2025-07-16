Return-Path: <linux-kernel+bounces-733593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE77B076B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB5E583B28
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8519D89B;
	Wed, 16 Jul 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQG1Hn5z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E791946A0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671817; cv=none; b=HM8fjColY+ny4MxE3wStnuv+DCCKmv8JIFHoslynP8F/oGbTU/24RprHMu6mIHf7ZyyZ9WLXGLJ/1gPmsqoaeuObSsmN9IENnjRj0zNb6+tOghP3Q/iWuz4HVV8bk8oF3YmTjoP4S1i0jq0aDmHcU7XPTQOTlYLOfWwRZSa+jkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671817; c=relaxed/simple;
	bh=8oqvuf2+ASvyX83lylqjKS8evNMf24KrTfaxWAlm5E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVZwrV/zg1FgUYJteyzAEte/J3RKkqHb+eof/aRipLg+G0IVj2Or7VvAgNCOjCiGw5xho931o+4Iv8dwf0G8tCsKy3E5lmtylOjIapWWkHbvdLue/qdTu+GTRVsb96c5DTi4Wf1c5NhwNGGn1n7zeRgdozGb7xqE5DAQKsh0Z2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQG1Hn5z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752671814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jl6ZpMdy4psUadBOYPpm7a7ukXkhilAKHnuEM0dKNlI=;
	b=YQG1Hn5z4aTQZEOSGlLufpbLjUe/Q5kIhgGy201aAIgbf6IGKWPZhTd/nRMC7cfqksOFjP
	rdpsNGCB5Q6BFM3hxNhZ0qpX05AXxxXFgwtY+utV8HnmZ0uF3mJXhMgCfh9kFcCI9H+PWQ
	ZqS5S1FcFnEvrYKlQWStWbSko3dsQm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-xzCrfq0sMcyHISoIczQVdA-1; Wed, 16 Jul 2025 09:16:53 -0400
X-MC-Unique: xzCrfq0sMcyHISoIczQVdA-1
X-Mimecast-MFC-AGG-ID: xzCrfq0sMcyHISoIczQVdA_1752671812
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so16818335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671812; x=1753276612;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jl6ZpMdy4psUadBOYPpm7a7ukXkhilAKHnuEM0dKNlI=;
        b=T5ozLCCxkD+Npw4HHgu7MRhGkaaQ/eq5TUZaK0uYaWtb3mSzthiCD3eqVBfBSg5DRm
         ZjJhGL6J4MMT+hcXs1GPGJgyNWEr5rnQJ+m8S99IAfzBceUeaoU9m4I+X14gPmWPRyqk
         gOkwizd0551ZwRD7uRp0tct9ShsfIbXhPB+A8UbqzHRasE9+N6KTNeEZHhJns0+xfPb7
         RW4F5/oHew1BlnAG32K+0oZTvQbk+jTcExcaduPQBhWhQhXAJx54po1DJbxlgZTucWIO
         wgSnvfLLiDPOI5jujW+uFYy2b3VNpjOkuADgh8pXfjwKsOTMMrnmuLzXZVawKvSZC49F
         5ynA==
X-Forwarded-Encrypted: i=1; AJvYcCUtVXAV+E4uNN3IDSc8MXgRbKGBpBIA4z0sqDXICbGjnMJ8G0iefFbK2fBEwVU3n+E449VGtANnx9PVqHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7dDbYFpvk76B4s87i5Dt2Utod9Tf98yhayf6TO79tg1vyzgF
	rYrxp6uHnIGuHgB50dcpCbd4Cr1O63M9Gj7g/JrU+gYwoXLEK5yCuLa4TRUhbFMCVKg686v7f7m
	a/5bi6wTXqgE8+/QaaswpYzRZPjF+cb55j4w//EYjJCWEGLrduX0is2ysyFzU5ynHSg==
X-Gm-Gg: ASbGncsto1T84+yD6LV3lL+18kOLf416LLCoOAEPkIXYyvyjL1HE2AM/0eC3TJOaoYv
	voAitYXgnE7vHymx92DYomTABYGtJ6jWj4ofMG2fKjPu0+qjUzBQEKQjspzat6VYs5kEqVTS3js
	tf7cVWb0aOXWUmYgYlO3uvZtt/ago4jT+Ut4olcjaXoUQ5rVa/Qb6tyDJSzILRYVPhv9qVQg14D
	e09oM1rHdjwipPK2EJfIArgmwY33PgBiy2AcwFN//lICJvIz35UI2zobtS0jespdcNtgMWgn74H
	cx68VQ2IjO/HmsndrkwVGaU7xjuN/lxa3Eib3517cX2kvK6ZEss5hCD300zG5BWPz0t5HbPL35V
	deNv7Pvl9prSJJueXvxFexb/kFny+pTQ13yy968wtVTtR2ZP5V3hXmtSlOYJFrqfHRNc=
X-Received: by 2002:a5d:64e8:0:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b60e518db9mr2312850f8f.44.1752671811822;
        Wed, 16 Jul 2025 06:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG35oyd9NNFk6Y8mNv+AleJxLRFQ1XEid+zALeOpe8yEargGDb+FqXJ3PIoIBz4F3e51RbNoA==
X-Received: by 2002:a5d:64e8:0:b0:3b1:3466:6734 with SMTP id ffacd0b85a97d-3b60e518db9mr2312819f8f.44.1752671811374;
        Wed, 16 Jul 2025 06:16:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2e76sm20950955e9.5.2025.07.16.06.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:16:50 -0700 (PDT)
Message-ID: <914ce985-f642-473e-a312-0a390ab5e78b@redhat.com>
Date: Wed, 16 Jul 2025 15:16:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
To: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 broonie@kernel.org, lorenzo.stoakes@oracle.com, sj@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: brauner@kernel.org, jannh@google.com, Liam.Howlett@oracle.com,
 shuah@kernel.org, vbabka@suse.cz, ludovico.zy.wu@gmail.com,
 gkwang@linx-info.com, p1ucky0923@gmail.com, ryncsn@gmail.com,
 zijing.zhang@proton.me
References: <20250716123126.3851-1-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250716123126.3851-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 14:31, wang lian wrote:
> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> construct to force a read of a variable, preventing the compiler from
> optimizing away the memory access. This idiom is cryptic and duplicated
> across multiple test files.
> 
> Following a suggestion from David[1], this patch refactors this
> common pattern into a FORCE_READ() macro
> 
> [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


