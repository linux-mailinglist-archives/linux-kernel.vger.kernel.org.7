Return-Path: <linux-kernel+bounces-683446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D120AD6D94
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D93B0673
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB6238C12;
	Thu, 12 Jun 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzFf394d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C284236457
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749723866; cv=none; b=OWd2huo33dcWbLILYZvRNBE22P+/xs4adkEBkBYk+rIuM3CXqtgFjM0bR28kBZShl6mEIwyy7XWNhcDSv0mVMGQrZLMxLcKf7XDmfNXYpdpZHW/gYAB7crO9M8h39eHJnzTC5jsTA00MTruwp5hn78tqSkSz85KBS7RjeCWEcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749723866; c=relaxed/simple;
	bh=tmAcToaijMV9XVH4tR5N8noq43eOKPj9irDr++PH6hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgoPnbwp/n2T18guH+8s+V0JCTnrYN3GhRweXjONbEeel5KSyADgit27uMATX30ZmAPPBcoKUKvvKpL9whNdrx7G4Pg4f95tXgL2LPGTKrr+z37B1OT5Jx7oZJ4UNTwSWYfmkpIM38EjrlMNHlaLbeVFYVWtMv4Dmork0xQxjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzFf394d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749723863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wFGl1raplgbMDB2Xn7AcMnjgABlKNLDHjU/hV2WGZ98=;
	b=FzFf394dCWrkPT24P3slxaIhFA8FA4vakDUcujorjfI9CCcvdFFq3EpWKNc4WSk8zlYQQF
	InHgqphbKu3f01cKrVX2MRJiHk/obRK32hYV7r0lOB6xH5gkHtP1T2KVhXpEu08SKb9EMU
	hDPSJ0UGfCKOIiReTCi5E09Myf/fOLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-kXDsjEAxO72oBNzeBlJyOQ-1; Thu, 12 Jun 2025 06:24:21 -0400
X-MC-Unique: kXDsjEAxO72oBNzeBlJyOQ-1
X-Mimecast-MFC-AGG-ID: kXDsjEAxO72oBNzeBlJyOQ_1749723860
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451dda846a0so5999985e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 03:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749723860; x=1750328660;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFGl1raplgbMDB2Xn7AcMnjgABlKNLDHjU/hV2WGZ98=;
        b=QzoNkDLjRL//vR6USZfMI7YCM757Rln1EFfYqnvKsLKLCWTEGm7ZhcO2p+qmWVboSx
         WJIN25Dyx7RfOMgLwU2aA/HEm9/O1kUf17Tm6pETvdNJS7OgU18aKDMEbgmEt2+iJ2D3
         62lCKDTCLqJaafoXklM0kvvqFSE62KJb4Z86bwRw29IAPyKAR3WSMYjfISFx/SEXr2aT
         GCwDIhZXdI94r+hOBCMN16u1+4pzTnB8U4WfyDqaN14qNb3Jfb3z75hJEa/we9WTRUjs
         /vSPLAp0YE3brQ2Lx2tqnpacxMhyItTQb0ndgOfb70t+v3svUg9nBxPZ/QN88upUv34T
         qMXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRZ+ctGAeSciVB5qCi5ew1PoVy7yjX7QItq66jRCh9D8il2FgFJ1tnNx0lvnevkN8e53n+3oJpD2UJqn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze24VcLWsABOztSlSfNAsP/ALlKeEXF0clAW50uH1P2/DHTXi7
	plELlUYLf0/L/uulIysJAifRcZFS0lFzWiEmHQ7DoDomuAMi1VZt5T7Y9O2pg34fqmjb4VfCSpW
	tA0miC2RTJ1gBLhPK3aHf602fAwnO2AM7dKQ6VFFbLBJRqfFLvZ7/MoXLz0Iupne6MA==
X-Gm-Gg: ASbGncsN/OksKzKqyONyCTUAdHwMktzu5PVbugE65OgmW3CrZ80POtL8YhQf093cu9y
	9kaspzuCf+GnU6ToWfoYFAaxNMBDJxnxUL2DLsdww9HA/aklAzwklDAzQtdZK12wJHurqOkWkaX
	C2ssBT7bc6s7KLCVFHv65vTrJpvLw0kKTk4zCkLyFylLCMpJP4wzeq1stQqSw1tXnDoDQxmmxTj
	RnxiHqMsNMHr35Up9/7PLTJW/xihPI77ex8+RmUdIU7I2gErUyT2G7zxA6EWLNQmdonOOneZHFD
	qjSi3+uVCvEvkOw7pAp4+My29qvlK0Zo9ZJRRmP3UOpoPAVdCWx+t5tZWAGgXHPxAAa4GkAoHui
	0awDNRg5WBW3+8UNCsDo4csrpM+cboxBGio5PLNMb2zwWfYeS/Q==
X-Received: by 2002:a05:600c:8115:b0:453:745:8534 with SMTP id 5b1f17b1804b1-4532d2db38fmr24850435e9.12.1749723860248;
        Thu, 12 Jun 2025 03:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwidAiVklYyr1sQpkURerWWtEzoMlsRFRCkO1e9TaSJr0LtQoH6E7Vf8YH4FDL4LIrsHNQDQ==
X-Received: by 2002:a05:600c:8115:b0:453:745:8534 with SMTP id 5b1f17b1804b1-4532d2db38fmr24850105e9.12.1749723859812;
        Thu, 12 Jun 2025 03:24:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e14f283sm16205915e9.27.2025.06.12.03.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:24:19 -0700 (PDT)
Message-ID: <0d92812e-4b17-460d-ab06-9912fc3d83c0@redhat.com>
Date: Thu, 12 Jun 2025 12:24:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, shuah@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 05:54, Baolin Wang wrote:
> Currently, we only test anonymous memory collapse by default. We should also
> add shmem collapse as a default test item to catch issues that could break
> the test cases.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 33fc7fafa8f9..a38c984103ce 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -485,6 +485,10 @@ CATEGORY="thp" run_test ./khugepaged
>   
>   CATEGORY="thp" run_test ./khugepaged -s 2
>   
> +CATEGORY="thp" run_test ./khugepaged all:shmem
> +
> +CATEGORY="thp" run_test ./khugepaged -s 4 all:shmem

Ahh, there we have it already, nice :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


