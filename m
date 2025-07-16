Return-Path: <linux-kernel+bounces-733110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94AEB07046
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAB717F641
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC328F533;
	Wed, 16 Jul 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCZVmql2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620B2459E5
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654034; cv=none; b=OqWVtMWcEgJFPnm9FwwuiAy+jraMmronvbZLRa5SlO9WUQIaD/VF5ERraP57I74KTLe5UK/UWdrhqRBX2WkfLyLPl6xJLuc0Scvpf1bR6U/5IWUac9uoZlmMwnpT3QlW6QLsInFSM5N7AeTogO6cbwl0QEid9VSVFK/LujjZ+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654034; c=relaxed/simple;
	bh=ZG7MYqbm/JPxUEcAWF86YJxPO27FFTjouJJOkXlQHXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvwWFBNFcCeVuflO8DrPjsRPhU31b08/1NJ5+v5xA19r60XtN0HvQVCbsgSnwYSRLqBAnuFlqGWFoapIUPRXKlPbqbWeuc4H8J4aMLZMldpBFQhf+7QSqhaRQt4Ei27pdsChiMHOxloQxA7AiKlA3eywHUaqHbXgA813haY/yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCZVmql2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKPb3FYVzFfrjo/nSEr903PTnJ+H6/4JdqXYfPo/qsQ=;
	b=RCZVmql2VSbCJKJmB+5GM5gRK2nlYjhZWaChQb/kvsUwEoP5nD6jFojNCTmoODsAuZUwBQ
	+B/XMQP3pw+BQi+TM0ah62IcdIpFaLgtUOUSZfOYRXn4IE6qw5mMAuSTgYOBCr/3lDAxes
	shZZZk3lvYdPTT53wbOgTuko/jhJy8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-_effjy6KMdK8hyVNqFh45A-1; Wed, 16 Jul 2025 04:20:30 -0400
X-MC-Unique: _effjy6KMdK8hyVNqFh45A-1
X-Mimecast-MFC-AGG-ID: _effjy6KMdK8hyVNqFh45A_1752654029
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso23997425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654029; x=1753258829;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKPb3FYVzFfrjo/nSEr903PTnJ+H6/4JdqXYfPo/qsQ=;
        b=U3vgIrMOsxiTIJLrWK02bS8S6Hpk+Kcmo7+mnxBOMuKP1hqpqr3IrtJ6MOP5s2bEfN
         vraxrGR2O32xsfAYl/hrf0ngLv4zbluhPUvAwmRFZ4GD/82/EVsNF7E0+9Wrxpu/MmtV
         Cmtbd8FaAZXzF9rpHNHccfCiMsNcGwAay3SP9C7N/grNeBeG68L8R5eRbbYORbnn+Oda
         lUSU5NSolNA0YU5n3OAk/KmzpS1kychdQxGydAwZ4JDxCOj603fXt1JYA5PdK0daVsVV
         4NLmbCBRC07Y60UpxKcEgBfqQPTzzk0aL3gi3iQ5aahP7jib6N4EgB0x1LmukSO+cru6
         BQuw==
X-Forwarded-Encrypted: i=1; AJvYcCXHExvdBEUjbQdLwseNROPir+wF6gRT0qvARvizSUszs/PvGULUQEZCEFTVBfmTpo6F8wDUei9CLMeBsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/K77xNxFWJcUTrATx02PxlCmT3MOWo2fFT50jO1aaTWGCvMC
	JwFGLONis+97T87G1s6QI/AH4TT1TLVrt6fYYvY1IMisKXEUOOoT2MwdRePwNRuVIAiv4vRw/R3
	7rOvlAj01oryln2bHLNuuJatjhs1vcFlLyxRPhBPixodTup610rnxg/Lze8x9URK6sA==
X-Gm-Gg: ASbGncsPKW+fBaJW65qvfTRfdY8grWutaftI5k0gE+LKgwE7y+rGqm4BZtLjZegusTc
	BsocgrbuK9fJxVvcwOfrEAp+LIViLguBNvEMjzbnm2Tly7M0wtYuBmb80IZh6nJC7qTiCVSVeLt
	eYx4ITfqQpCA3v8N+bbpUHqVt+Q+n1zVvW+T77oyIZ4OqVINFyN3Sn0T7KesIS+r1d1i3beIT9H
	VQv4kMeTKQZb4iNhr5EAKcZEInmAcyuqLZrNnXQiJwI8kZHe5qaBb7jWfWDLayMW59RbOFqc8iO
	KAWwLYebN4badMj4GRLoDCtl0ddY04MAd5OKHI1kvKEOzVLTmvC+B7XzDs3mT886WUCBh2Et4Ts
	inap68mmYzLkWPN8yelSvXuOlWP7Gj2RJr5XMUk+yR82DEOEw3KQItHJaE+6EzASvjqA=
X-Received: by 2002:a05:600c:5025:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-4562ee4428amr8903805e9.28.1752654029187;
        Wed, 16 Jul 2025 01:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPfO/crUSbh/p7Bf2c82O3FOkImgy2tCspzCYogys8HSUj89hQEyYWP4/UInuKY3Ru8/ZdfA==
X-Received: by 2002:a05:600c:5025:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-4562ee4428amr8903515e9.28.1752654028755;
        Wed, 16 Jul 2025 01:20:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13312585e9.23.2025.07.16.01.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:20:28 -0700 (PDT)
Message-ID: <13d1fe66-9f34-47d3-b174-516ffb706aa1@redhat.com>
Date: Wed, 16 Jul 2025 10:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc64: remove hugetlb_free_pgd_range()
To: Anthony Yznaga <anthony.yznaga@oracle.com>, davem@davemloft.net,
 andreas@gaisler.com, arnd@arndb.de, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, agordeev@linux.ibm.com, anshuman.khandual@arm.com,
 christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
 <20250716012611.10369-2-anthony.yznaga@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250716012611.10369-2-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 03:26, Anthony Yznaga wrote:
> The sparc implementation of hugetlb_free_pgd_range() is identical
> to free_pgd_range() with the exception of checking for and skipping
> possible leaf entries at the PUD and PMD levels.

And the pgd loop was optimized out, because probably not applicable.

> These checks are
> unnecessary because any huge pages have been freed and their PTEs
> cleared by the time page tables needed to map them are freed.

Do we know why that handling was added in the first place, and why it no 
longer applies?

These is_hugetlb_pmd/is_hugetlb_pud are rather weird on the code path.

Looks like a very nice cleanup.

-- 
Cheers,

David / dhildenb


