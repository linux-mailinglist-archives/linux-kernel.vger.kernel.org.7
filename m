Return-Path: <linux-kernel+bounces-752979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76536B17D59
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817867A8B69
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22F202F9C;
	Fri,  1 Aug 2025 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxaNs6ww"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C31F4E34
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032506; cv=none; b=X+r9bBn/OQVG7hAtYYP4jgYX4hGC9VWwrwkKa241+R35TQu9yPCmGraqwNbmnXWIER228D4IjHETzSnzKQ5t0ZbxmuNLDNPJBVLc0nHWrqIJk8okpV2NKCcnOf9oyxvXpQVNLhd0om+0m65rcutAjZmuWTmoSD6vV2kfPpHcunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032506; c=relaxed/simple;
	bh=3zxHxQGbG5EHBuy+CI0riooTfliVPCggoxR2OTAOV04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV4dFjl/tN/TleRPN6ZyXYQrV5Mz0erWFQOOsLHBkEXqColuCCiFtl6Kcl2SYFK673g4z0UOc5qq0FyJ36708oqkp6gA8O1uvt3aSFQWr6F1cYBzb7rkGokkzFBVEzXF3bhL5yHRywAeL36/++piysQzgg73a/vimxbge5QuEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxaNs6ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754032504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8zsP++KTNUaPodvSH4cDflu0en1lPWroDDUWAbpWBvg=;
	b=JxaNs6ww4KWFXdZTg2CZ72v3ZTbUh3acBQ5ctywpe0GPgzXBjVthnXojDG/PcjVe8getcR
	dGJGGm8d1eNZpfIqwZCSDHpx7xdmZskDuKFV7UOcwCi9Ix2kuimWBcB+WyPHlkyWb+RYwE
	4DAWqwLLXcfZg5fz8O6JGUGdzDRMi08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-UlszHmMoOpuCQWGybb95mQ-1; Fri, 01 Aug 2025 03:15:02 -0400
X-MC-Unique: UlszHmMoOpuCQWGybb95mQ-1
X-Mimecast-MFC-AGG-ID: UlszHmMoOpuCQWGybb95mQ_1754032502
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45891629648so10122455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754032502; x=1754637302;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8zsP++KTNUaPodvSH4cDflu0en1lPWroDDUWAbpWBvg=;
        b=J6ct49aINvuZ1szZgSt/WCJDMKf79F5OeagQAfGm3/Nnpr92v0JduM6/QtqP14sB9f
         qd2OpFFW3GKD46Rv3IkB/UMILmUf72MSx3o5D17wLR5e+OY0cpkFx8mKmLf2k/FnkpHH
         DWarIxMkrEWQ9nV1B9dw02w8yl9hydrkaxcUAl8SdF/HNhAijeldhL4xTNUq7GhFKhj3
         9mZSsgFagJzjgVTbGxZNCgwHHXpA2Qpv++PCXtSDo80TFJfH2L9EO5KhBpqTRvupfBSR
         2a/e6cMqSOAmzNXe9gPmmE1eX8A0zsn6mxtVwTyUnGWMArG12Jq5lHKpzQwr20Nu+mYr
         FxVg==
X-Forwarded-Encrypted: i=1; AJvYcCVuMJwnPp3saJgIR+VEPFEhfB4nkYVFe3SRk6gA9YYj0gQJKMDTiph1a4HY0b/MIOUWau182N5R3a5pq6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIsVximfAMbShvaWRinhNUX3Q/+5713mXhjk2Z0mUMS05D5tRe
	evJBISE3CAhYEpEZpjKPSwYctFW/aunCw1Qazhe5GmSaZ6xTI1xzj7oD3OYEvP5eXFyx1I0PC8J
	6lNC9T8xNx3QNimrvwuvjfi1bwCDtuESK6zVNo1ZklhphVfeqLH1kT7fgQRTBJgmfFw==
X-Gm-Gg: ASbGncuORiLyS/sWOW1O2lTyelqRzv5v//NSc3P+UpHYgMhvgC2hw69cVylxmqqnRzb
	e92vhpWt2AbWQqN+GG8hb8S92C+MSrILUm63BXub5/9eAkk4jbA9xNYzrmPAO9osMiPKkxxk1aa
	stvaMH3+cvdUMP4vLm0ji4d2hD6ZLlGVh88yafTYiSiFGnVL5pXp0Q5qMIRH9R6R2Xozq6WK9sm
	mRhYKJOP4eGYrWDZqov7Vi5D/iWrAvcPuurtaZ4Vg2mu2kS9+0zwg6CPYSZIJKUK+8DQ8CdAjjI
	OpGpcRv4v3A63GCm4+gjs9usas3CtZn0V/zvf4qounSo/YrXJmgXwoodjd/7xkjyyiGlkA==
X-Received: by 2002:a05:600c:c093:b0:456:2257:3777 with SMTP id 5b1f17b1804b1-458a20032cfmr31373025e9.4.1754032501548;
        Fri, 01 Aug 2025 00:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqEgovPXS+bSOytnGo1/3qgezWi40htmY3CdWP2rI3GAwEe+kqxnaoSv2vjYTl7ueaCkadcA==
X-Received: by 2002:a05:600c:c093:b0:456:2257:3777 with SMTP id 5b1f17b1804b1-458a20032cfmr31372845e9.4.1754032500946;
        Fri, 01 Aug 2025 00:15:00 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1fa24.dip0.t-ipconnect.de. [79.241.250.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edfd983sm53298925e9.13.2025.08.01.00.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 00:15:00 -0700 (PDT)
Message-ID: <1f95e865-ee09-4ddd-b6db-f2092f0d4b10@redhat.com>
Date: Fri, 1 Aug 2025 09:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: pass filename as input param to VM_PFNMAP
 tests
To: Sudarsan Mahendran <sudarsanm@google.com>, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20250731201009.888945-1-sudarsanm@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250731201009.888945-1-sudarsanm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 22:10, Sudarsan Mahendran wrote:
> Enable these tests to be run on other pfnmap'ed memory like
> NVIDIA's EGM.
> 
> Add '--' as a separator to pass in file path. This allows
> passing of cmd line arguments to kselftest_harness.
> Use '/dev/mem' as default filename.
> 
> Existing test passes:
> 	pfnmap
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	# PASSED: 6 / 6 tests passed.
> 	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass params to kselftest_harness:
> 	pfnmap -r pfnmap:mremap_fixed
> 	TAP version 13
> 	1..1
> 	# Starting 1 tests from 1 test cases.
> 	#  RUN           pfnmap.mremap_fixed ...
> 	#            OK  pfnmap.mremap_fixed
> 	ok 1 pfnmap.mremap_fixed
> 	# PASSED: 1 / 1 tests passed.
> 	# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Pass random file name as input:
> 	pfnmap -- /dev/blah
> 	TAP version 13
> 	1..6
> 	# Starting 6 tests from 1 test cases.
> 	#  RUN           pfnmap.madvise_disallowed ...
> 	#      SKIP      Cannot open '/dev/blah'

Now, if you really just pass a random *actual file* that exists, the 
test case will not actually test what we want.

Unless you have a way to verify that you actually get a PFNMAP mapping, 
this extension is questionable. It will make the test report possibly 
wrong results when wrong files are provided.

I think we can test whether we get a PFNMAP mapping by looking at the 
flags in smaps output ("pf" in flags), so I would expect such a test to 
be done in pfnmap, and the test should FAIL if the file would not create 
a PFNMAP.


But more importantly, we rely on "/proc/iomem" to find a RAM target in 
/dev/mem. That doesn't make any sense with what you are doing here.

If we are not provided /dev/mem, you should probably try mapping offset 
0 of the file.

-- 
Cheers,

David / dhildenb


