Return-Path: <linux-kernel+bounces-872105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1E3C0F449
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A23189E05B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100CD307AFC;
	Mon, 27 Oct 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGx5uxi7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE72305E24
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582427; cv=none; b=Am3ROtpp9EkaWKP4BVnXBTRhLN3kJlNO4a0Gq5U1qla+3J859lD/Hi+QY8nOCKavDqQS7VBLOBhog/QvFTr7yu4Nh9ipj9ddxuOS8Ue7Ib2W9qHrjtsP+7ClhV46qHVsueSyqesFASHfX4l6tepxf//03WlWs+uLnb7mQ5NhmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582427; c=relaxed/simple;
	bh=vxTR8lbamdeDpWOKL7DBajOZmLjQuC70NJY4GMId3as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6Y5tbOLeCfiCS71aOTnjENBM3E2e61xD9/i6wMJon4v5KaLMssl8kOfZh+HEy1MntUFTMspz/GsYSWZLmpsTw1BzS9gBdWVDKU+6U5PxfsaQBKDT3SXL0DawzKk33SJ7tHb976J0lLXM9EJZ/tsmgfHZjeTXrlFhBc29TUHGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGx5uxi7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761582424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gFGTrLXSQViuLtwu+2VekUSYMKsImqKp1Rcio5lWi+8=;
	b=IGx5uxi7AJCSUAKwHzDXcKwwxaVQyEjaZiljIvT6/ebYSFOKgbfAKmxETSPQlir9Xdvg3t
	5ZBOVOq2k8hu2aCTAKs8QTMYnVkuYt/sVp8sLEo23T5djMjBxftv4Rav6GmOgqNuwpHGx+
	eFkrVMCS+4g9Zaa48hsoxkSvMUqO/Hk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-uLYEq6pONuORC1XZJihTZQ-1; Mon, 27 Oct 2025 12:27:03 -0400
X-MC-Unique: uLYEq6pONuORC1XZJihTZQ-1
X-Mimecast-MFC-AGG-ID: uLYEq6pONuORC1XZJihTZQ_1761582422
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3266517f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761582422; x=1762187222;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFGTrLXSQViuLtwu+2VekUSYMKsImqKp1Rcio5lWi+8=;
        b=IdBYkn/DXzCW5kKtNLvnwnBsOpcmVsNZj7scGM4DrHvm+/6ZOuALCG5lmJejGiQ8p+
         82HISVFrxRgiHEkv3qddFzpjFWS2fmhUoewP+uPRD78sM0+8NlPtQFAyKBsfFfwBT1u5
         Pjvqp9rntXctsD7Pf3ibSMuJ4KawtI7sOW1k+hoSu/udTUWV4w043npwrnXhAiOhII99
         vklEVfj8r2RV6Rs7a/VtyVIFMcvYEyjY05qUbY4UKXZNW+cjhbR4aVbgbIUJF31hc5Vb
         uU6Bt0w5bDFyR3X4/gJufHYkTChKTVyzXMISAN7AT1bLDWJNU/TuPdcxYjpljdDHBiqk
         cZYw==
X-Forwarded-Encrypted: i=1; AJvYcCX2kIDqXvTAlEtZjVxNRgAqHmKkxWUwncue1pEw2W5wUkmUYvtLUETmCEunuhJAFu8ut1SGjcb4IMSI3Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs61apHAvpbd1uq+vjoWdECiz8+cRbxsEOsiTC4in6xlEWva0V
	dQkHuMstTvQy0iqrgQOeghdQDfp4wXS3YFlJ7QCR03xDN5hZyZYYcZTVyRhdYimTz3FmHVwGyRF
	0DgdDKXevFB757+pQCNy450csjn6hBHXFrXnr0wyBZWg/JiEGJW7i14nBpDoyvCUdkw==
X-Gm-Gg: ASbGncvKfk0SSkR7b+LMy2QIuMlNUvC1r1nlFEk7UnWIqoyUNs3Xza3YjJM0YOrgEFk
	vlZ+mJBJCQ8puUU8cvwWfcRNqjo0Gnr5G1B5dRhX+IHvo805Ls+JMUztL7+/NI3iEWLp4a/Yeuu
	7MXWo6P1ZJkCZmNMGTpNTY1x/Kai50q1QBGFkawDNf+FElIA+WHzSV/JntCu07bh6Frt9OB326V
	03yuWkxvKX0LwqpESI4zZQxYgM8F/k1EcDBnpL8vNgD4ihQ61wtmP2Eh58KZoEQK4jYzOaaB3qJ
	GAQ8ULjOBQZXK0pHm9kC3Unski1xAkTSoJs4y7GJq9vG+MNfk8aT5Uc8BKED2XfzkhQiaXy/aUy
	gC0uZW6f52zusJDwie2UZF80LHZq9wR+YD7C9WO8n1wtd3CgNVtMRE8tekig+QH/XchwIUSoOLW
	shpH6psao8mSBXcoGog3CNtkRsgt8=
X-Received: by 2002:a05:6000:240e:b0:429:8d74:4b16 with SMTP id ffacd0b85a97d-429a83dcae4mr27386f8f.20.1761582422050;
        Mon, 27 Oct 2025 09:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoo80cUWX+0e1u72oeksXrmAM7quVFts+JpWS6K9jyENOeTtl/MzibHxpQ/ny1e2QhKFedUQ==
X-Received: by 2002:a05:6000:240e:b0:429:8d74:4b16 with SMTP id ffacd0b85a97d-429a83dcae4mr27364f8f.20.1761582421600;
        Mon, 27 Oct 2025 09:27:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm15164870f8f.28.2025.10.27.09.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:27:01 -0700 (PDT)
Message-ID: <20745ea3-4bc5-4032-ae61-b928f2568175@redhat.com>
Date: Mon, 27 Oct 2025 17:26:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem/tmpfs hugepage defaults config choice
To: Dmitry Ilvokhin <d@ilvokhin.com>, Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Kiryl Shutsemau
 <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <aPpv8sAa2sYgNu3L@shell.ilvokhin.com> <aPstDXRerYqi1O2X@tiehlicka>
 <aPtg1vUnpkaK1Ce5@shell.ilvokhin.com> <aPvjFuio9lBKf2In@casper.infradead.org>
 <aP-ciK_NsCPFZLHZ@shell.ilvokhin.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aP-ciK_NsCPFZLHZ@shell.ilvokhin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 17:23, Dmitry Ilvokhin wrote:
> On Fri, Oct 24, 2025 at 09:35:34PM +0100, Matthew Wilcox wrote:
>> On Fri, Oct 24, 2025 at 11:19:50AM +0000, Dmitry Ilvokhin wrote:
>>> Primary motivation for adding config option is to enable policy
>>> enforcement at build time. In large-scale production environments
>>> (Meta's for example), the kernel configuration is often maintained
>>
>> So you work for Meta?  It is poor form to send patches without
>> disclosing your employer.  That way, we'd all be able to see that the
>> positive reviews come from your colleagues rather than having it look
>> like everyone's just "oh, i'm a random developer doing this on my own
>> time".
> 
> Thanks for the feedback, Matthew. For transparency: I work for Meta, and
> this patch is being submitted as part of that work. I know it's common
> for many contributors to submit work-related patches using personal
> emails, but I can understand your point and appreciate the guidance.

Note that Willy, for example, signs-off patches with

	Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
Cheers

David / dhildenb


