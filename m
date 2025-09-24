Return-Path: <linux-kernel+bounces-830487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB30B99CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0833A4A7796
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F6302CDB;
	Wed, 24 Sep 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgTGj9Sr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD32FF67C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716535; cv=none; b=XVnnIqEW8xJ+CQqiskGyXlbMlAgT901J3Ge8dA+d5Qo+MLei416/mDt/YBzUbavExSi7inJ9e/7kolWsU2q/kmzxL0CzeQRbhCkUA7zF+pnrlrmb6SklORUT4wYihx8k6fCdZ+Zu2zIPdzFPov7YDugswnLgmuE8tK33n8K4/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716535; c=relaxed/simple;
	bh=F12QU4q8Qkjdx4foIaaaCsAMOffO02IlwUOMyao4sik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2Mi8KU7OVWrSjdw9uXQXgNXNiY0lVvciinpEPpGgQeUzBasVlqvItqyGmJPANdtSP0gilNKxiQU8reNbq0qa26LYSm9RQgjZ286Mto2V1D4YwNgKrMsO8ynvF+6LMBiAYReJQLq8eXm+MmKrNKh1fD8IcIZLwwobX5K5Gezy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgTGj9Sr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vmz9e9JSHdKEXdBu/pteycJ1iSIYc3poo80ZjdbrzKo=;
	b=JgTGj9SrNvM1b3TjdvfRc42DXfz8UW14pOycpNCJjd4QZE8C3MgD1Z3o32StmCqtkiLNQm
	grnX48rBiK1lWNKPrNOm2+okXXxyBJtuExiw124IhX4SSFPFo7vFQxNyNrnFBg8EXkrFn3
	I759CyYm8ea7Hv/fnhaBieBKdcQpuwg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-rWdRvx5pMfeXI3wLpZPXBw-1; Wed, 24 Sep 2025 08:22:10 -0400
X-MC-Unique: rWdRvx5pMfeXI3wLpZPXBw-1
X-Mimecast-MFC-AGG-ID: rWdRvx5pMfeXI3wLpZPXBw_1758716530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eff3936180so1816304f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716529; x=1759321329;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vmz9e9JSHdKEXdBu/pteycJ1iSIYc3poo80ZjdbrzKo=;
        b=Pc8sUlDM2fDW2PF4nY/nwKo3QorJX0d0KNSZHXfdjWIxPXZHhHMLgNnEGZEtL85O6a
         f+Q3v2gJ9X5Z1+rx0tK/lWO4OE9bkXQnqQmQ7cKzN3MvR8jcgj0XiJlyYwAMBXohd7F7
         EdcEbF1aafYvGVr4T6oKNRbFV6NHhGeITmGHbb7GAz4XnmBlxPMnEk9V6C8LcfwLo7Dn
         IYFxTuJNSlIrcfGArHF2DD9ZQtZuAfpDx9miihwsVcfRhnHUtL8eDUb3lhQM4S+cFkmo
         Ib1uWAOR/OlI6A1f5SA61CGzr7S146eoBAJrFtfKpIHrP4fbpwRAHnWQ7Qdoi8H6SSS+
         16WA==
X-Forwarded-Encrypted: i=1; AJvYcCUfwATK4jSQfVr5YXVmguLnUSLGR/kIX99z9s1EDbFIaXlKEF5/9+UwWuPwHj+OCTHaM+dlYZfDvgq/598=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4emx2yvAInUzICxoJR5zlt957q2QQYGK2RogdPQu7OL7mzlx
	0PNeDoLEsocbUvKsx/uMtXIRT+gQBiQJNubFLldN6Y8qedGjMVAD79Mds0ifY/DslOajeEjCrpR
	UnLA8HDpPhM9lkuQRdap/ggeB/Q1gxd9omk/fRr/E/oU745bk6JPMipSXx154KW6+Fw==
X-Gm-Gg: ASbGncu0eNDZr07XrrB3ffNDlQTfLHEdVX63SiGjbwjKxZG6liAUiQUN2zpLihDy4vG
	9RSLp9s2+8+zOBdEsBMD5pDPFaOTqwQGbpaEija3mhh8HswUA18Onq/J1/pSMGRqtjfN8ES/RDn
	EDoBWbe+riaWizrQxEcSjA2nKDbyWaUmtyk0VAfIphnTaFyTZygY/aarlE+iz5N1Kfo/D7cGCOl
	q/ALYMeV1UwU+4DH+jRIvK6kEvaLWeMVTdPaC4cpYgKUHp4f63E/NDJom14l9FERjU5GvdGAxX1
	pXTWQ4T0oNnLrYhBkzSwpHDq7m3KxjIGme3NQs3xOFwpiYTC7m4X/Gv9xj5t83xQBV5KwZDoIeU
	eX/XH6fp4etI0XTiHMOp1Pay4k1avxE4pKJ8PA6eEdMOp4ELfAifSAvHAxywhsKvShg==
X-Received: by 2002:a05:6000:4029:b0:3f9:e348:f70 with SMTP id ffacd0b85a97d-405cc9ed199mr4696073f8f.55.1758716529561;
        Wed, 24 Sep 2025 05:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5gZefcieEpNs9h9qe4+85WE47fFv6kBePDFTI4Qe2rs31B+VWsQMipVnDJxVutukKGr1/Fw==
X-Received: by 2002:a05:6000:4029:b0:3f9:e348:f70 with SMTP id ffacd0b85a97d-405cc9ed199mr4696056f8f.55.1758716529167;
        Wed, 24 Sep 2025 05:22:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab62233sm30548635e9.21.2025.09.24.05.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:22:08 -0700 (PDT)
Message-ID: <dfc83821-f2ff-4b9c-b9cf-9dda89e8eb77@redhat.com>
Date: Wed, 24 Sep 2025 14:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: Fix to clear PTE when discarding a swapped
 page
To: Gautam Gala <ggala@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
References: <20250924121707.145350-1-ggala@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924121707.145350-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 14:17, Gautam Gala wrote:
> KVM run fails when guests with 'cmm' cpu feature and host are
> under memory pressure and use swap heavily. This is because
> npages becomes ENOMEN (out of memory) in hva_to_pfn_slow()
> which inturn propagates as EFAULT to qemu. Clearing the page
> table entry when discarding an address that maps to a swap
> entry resolves the issue.
> 
> Suggested-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---

Sounds bad,

I assume we want Fixes: and CC: stable, right?

-- 
Cheers

David / dhildenb


