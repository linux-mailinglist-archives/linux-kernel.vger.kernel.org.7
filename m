Return-Path: <linux-kernel+bounces-736385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F46B09C43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334991881383
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954721770A;
	Fri, 18 Jul 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTGMQZ3o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B31DF723
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823169; cv=none; b=YDRkwrlC2bkDCaM7MK/2uZ+Shr4CMQZhWk8SJ5znXIXdJUZy/AyJ6IKYZkXpwweYPbbxA4aSVKNd2dftmhDafALaNC7fWcX6qIhJH/+zAJYCuvgeBPSUFHPi+03WX77UC4FiNZf2KKv1ReX57KBfmBs0AonyvhSrdncMlp23NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823169; c=relaxed/simple;
	bh=KwLNYNDrrA1wFJNtdoruEJ6ioa+vNR92+TTRGbkiN/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fF8tSoMG6h5ApZf16oxhMH42FXz/EFErYndiDlWLSAyKCurl/PLTXm95sMrfaljPVmbBYXP5HbxZhhrujDVTFlojxzBBSGdl138eMiy0LUC00wNVI+eH1TiMowKIrHRtOsN7y5vg6V8ckRWXqZKpBSzhZUxWlMI4SyiNo97jzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTGMQZ3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PJDe71826pKjxjjWcgCqsFzQxVy+vchc770vtGOrErg=;
	b=JTGMQZ3omiCjo+pK53GgEOxJ5cehUY5mQWjH9rDiK9qKwvewlcTa/KCXP5uEG4hyTA/m3e
	j7YUH0FZGrRvWwdolNcW0CQ8GsIjY2QrzF5ZIjgGoP6sm1BI4F2XDLiXycaVKrVWbOhiF5
	2jiFy6EJWG00lbT5FMxYp8wP6W2Gn9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-BHPPPBYyOfKfMzAjoxfNTA-1; Fri, 18 Jul 2025 03:19:24 -0400
X-MC-Unique: BHPPPBYyOfKfMzAjoxfNTA-1
X-Mimecast-MFC-AGG-ID: BHPPPBYyOfKfMzAjoxfNTA_1752823163
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b6162a7abdso420487f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823163; x=1753427963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJDe71826pKjxjjWcgCqsFzQxVy+vchc770vtGOrErg=;
        b=W0j4kMko0GUUPTa9lf9SM00Iv7Nd/1SnEe9LwAM2M3W1OvnJxVwkvxKrcTWf05q5Ed
         Q1qjL4l1tjhfmWN8kTF2K301dVm+qPJqtCg8Un1n9KoDAePYqzLhyy0v8HKfFC8xc6cA
         IIcryH5HfE2BmqezP4/d3ybRTPVUS2n0eRUUMzb20zhex9aQwH/VRqlmCenn0WofMHZX
         /l1casVOnY+H7jEnTzwL6nw22w9CzMcRXjF1IwI5BmeTqNj/VryMa1tsLmeFoyzslicS
         0fm3FqFjKPgyn/q5Kas2uD5yQOgg89qsUnQrb4UZ5mVVgTYJ+n9vvtoU6D01AZEIBlgF
         i+WA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Eva21fDs81NcCeY/+Z+3xUwBTWTseH9dBC3ItXqK7xCqt4KLKWNFbXb0hba+QydZ9PJes5ZXdXYoB40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUC3F+NRF3Eq9K/bkhicEu/mOhGyXRyHuIUuLxTXrxKWuuaBZl
	heXjg1wQZRIsDNmnUsBjtbvSVqzLIMRDWXmAkfnjRxsYhpVBFIPMbsi0ZPNnKgEfo90D4D80tP3
	8aYo4RQ/BzdIglkvuNM0ZB0Xz3gP2cjWiQXrJFy6Rnqe+zlTlmKHUruWYM2iiXvTFIA==
X-Gm-Gg: ASbGncv73wojqQo9fHMgxuzOzvE7KSGg5/r6Blgi21ODElnajeR+YdDCJ3o7Bo5nivT
	8toCFWqtAcy0ekLo+fRSfjcqW5f7H2XszHJf5JdDOJwW9ByINbUbqCKoCBKEiJ0mbn2F4leK8PV
	yZtR2yk928FJMtE8RQ/FU523JYS05csiBC72i0CK5JHgsHBC1yvvMJTcl1VuIGR7Os1A1yOcGRY
	XAjHg2PpknJlZtFqCJomP6dB4+90A/qy8/m2pEc5Mw8PuqntV78wGOIEKsitXYgeI35Tb6N3xQl
	5Ifpm42sS8AXLyNUN9WRMy0U9Mn2iGttC862M2kWmcnPFm3r2gxRQDSM622ixpCNsNT44DmrBiV
	3g9dan0w+h5XjuTUAuObL6+wRQzg6ie1ayfCoa9e+HpEOqDSusO/KM3YcpjNPbhk0sjU=
X-Received: by 2002:adf:e195:0:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b60e540843mr7137000f8f.56.1752823162859;
        Fri, 18 Jul 2025 00:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7TlK5geRWaYK2xblS44GZhjJMlexcykufIuIBaZk9pA7+/9a9MCdYZKEcuIgal0rwI2qnGg==
X-Received: by 2002:adf:e195:0:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b60e540843mr7136940f8f.56.1752823161835;
        Fri, 18 Jul 2025 00:19:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2549asm1000265f8f.18.2025.07.18.00.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:19:21 -0700 (PDT)
Message-ID: <ccc8c5db-3f55-4c22-b8a6-79cd515cf042@redhat.com>
Date: Fri, 18 Jul 2025 09:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] mm/huge_memory: remove after_split label in
 __split_unmapped_folio().
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718023000.4044406-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:29, Zi Yan wrote:
> Checking stop_split instead to avoid the goto statement.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


