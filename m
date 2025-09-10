Return-Path: <linux-kernel+bounces-809504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E3B50E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC391C80E61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48127258CCB;
	Wed, 10 Sep 2025 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/gg6LOd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EC304980
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486845; cv=none; b=ik/0c4VGuEG6MD/cEQPVe8UNLjlpvJLbWeTSnGh6HQb1JDhCFs9YbSx1F1D2IG1tty2m0Q7FOJoxckiHgI3CInSLTHJli5tQhrgiHuiS/K7hfolGbQrPCr/77fPSYTxSJgQs90V+AQywfSn+ymZyvz0Fb+qHfh3/1vb9cyx6EF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486845; c=relaxed/simple;
	bh=0krdSigjkNWm4whsMe2fv8fzKfNF5OL8bcqbJw08UQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vnlht7c8C9UeBZlY5I5IsODrWv5vU1xBXUqJnA2eDdUTQNW84xG+me2o0Cadg7Z/GfblMSWzDPBOJyvfoPV+lshDuzqB6s511nuZJwtRnRNb2ohKIRMz5ZHN0acyB+qRWgORi80QXJfzt36StZXNYdWL/2vg8C0obCXlbK2anss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/gg6LOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757486841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DclbICh4vt4htwsTue4DjShXgYZNbK2BpNkYpPd7VQs=;
	b=Y/gg6LOdjvb45YIFSC4V01/hhOGrtMTxzoMN2T0WbEfIGLJKdczvs1Rxiuq00WCgXEMasi
	sOMmp/SQOw4+6Avdwdptn+yIZVHYY933+zKE1Rg8BUcA8GpUQdLsqnAw4/SdNLnRszZ5jz
	mLbScrz07GFtwEMOzozJnLk384byHfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-edY2QCdcOB-bgUPfyUHpIg-1; Wed, 10 Sep 2025 02:47:19 -0400
X-MC-Unique: edY2QCdcOB-bgUPfyUHpIg-1
X-Mimecast-MFC-AGG-ID: edY2QCdcOB-bgUPfyUHpIg_1757486839
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dd62a0dd2so1229485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757486839; x=1758091639;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DclbICh4vt4htwsTue4DjShXgYZNbK2BpNkYpPd7VQs=;
        b=VJooLkpaJvcW9llbX17EvoFYXoKEumZeAkcPgLH0npF6dyFMaqsNGwcDjrDdhvo4LP
         HaFodj51YOUqNGsBNnwtxEbXRmZmV1fdgkC3FGIhHZ17j4ODY1AVPtDp4S0Pe6DQbB3W
         5SePZArbXNEq3mwx2u5a111CnXGeZoH1YwR+sTA5jwuwQP2X+/J2d7mc0peP+vvMYa7w
         AzTSWpywfZ2NPLBe7r4TdGdNXbYuHC/Z1dg6qYun7vNZwrKQ/QPIqziqt1NLmUowSyug
         leLy8aJFiu0/mXncxV7iMtXS+MFfVgeBDHXopbB+p3A59HtUppDiD3HOBdzySzmi5Y+a
         9oig==
X-Forwarded-Encrypted: i=1; AJvYcCV0+S3W0h3gaN2eRbzSAjmFhYq6ksDrjlomgc5FQPMzxXIPioVY98ejD6mU0OwR2237F1X8IpV94XEgvEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywuMkfy22Rj+I1dD6SId/d7+4ZuViGUIpONRuIObdmFqMvmZyw
	C/+XnG7UI4u514Fdi9LNGxXRBgoWosRjxKNiBOUBElVCYY1D9WHmcVdBNPzD82RWv3mH0ooueZL
	q7+yTauWHnznN/T1rmjF8wFwjOCAYWBsI2/EhXklxR0wUfmOALILSr7C+RahPx+nwYg==
X-Gm-Gg: ASbGncsDCZA79jq9mRiDPh1tyDQjJ6DcZ6MOLGiCGFcJY/tnyL/07/K222Y4tA/fU7e
	Bmu2w/fPF8R69S3OtWSL5OVnXeK++6w2CvRqz1kxfduzMwObAx9174ZzSv85jIo358XVHy2/i4Y
	zo/Q0Jdd742zee0rYqNB/qOtRaWu1+PsltJcBqne7Oys6zK8zHAtx4o1DVVcNxE+xG5SdeeNqAC
	HRJUiorxn6R+rLD4fdft8KU13YWx0EgnHHxC1/qW4/vm/OEdR9SLBBnCSAzQAaw9CLJ56TMd+NL
	oGZ68kFNig16fn4+doEBTy8HLBxtKs8kO2BXyJOPnIVMCW8/8FdzuegwfK4Xnja8AepSwS41tFi
	l8umX55tMiwANklPVe4kzkgSM/AZ68QCEpVS24UJMgXYXIslga7RvjWBo/mC3FXGD79U=
X-Received: by 2002:a05:600c:3109:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45dd5b6870emr170579955e9.12.1757486838758;
        Tue, 09 Sep 2025 23:47:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83J5OJuXJRUwcDtMhsLLb63Ao7OmC+YBUOiY4RlDnVWFPTK7sefin7s19OlLvWaaiTz7/1A==
X-Received: by 2002:a05:600c:3109:b0:45b:910c:adf with SMTP id 5b1f17b1804b1-45dd5b6870emr170579765e9.12.1757486838384;
        Tue, 09 Sep 2025 23:47:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f17:9c00:d650:ab5f:74c2:2175? (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm5855416f8f.39.2025.09.09.23.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 23:47:17 -0700 (PDT)
Message-ID: <837a56d1-38ef-453d-9b94-b151765d5b84@redhat.com>
Date: Wed, 10 Sep 2025 08:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Zach O'Keefe <zokeefe@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 21:05, Zach O'Keefe wrote:
> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> thp collapse no longer requires file-backed mappings be created with
> PROT_EXEC.
> 
> Remove the overly-strict dependency from thp collapse tests so we test
> the least-strict requirement for success.
> 
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> ---
>   tools/testing/selftests/mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index a18c50d51141..3fe7ef04ac62 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
>   		perror("open()");
>   		exit(EXIT_FAILURE);
>   	}
> -	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
> +	p = mmap(BASE_ADDR, size, PROT_READ,
>   		 MAP_PRIVATE, finfo.fd, 0);
>   	if (p == MAP_FAILED || p != BASE_ADDR) {
>   		perror("mmap()");

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


