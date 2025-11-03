Return-Path: <linux-kernel+bounces-883530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1AC2DB49
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA8B84E2CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BC28643A;
	Mon,  3 Nov 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSxRJoJB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7C137C52
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195012; cv=none; b=GZJDSsYZe+Up8cLcdMI+FhQbUB5TETx4Tj62z7mUjO/DZngr2j/RztapyukKnFU37Fssh98RSeH9ztxt2GEpOITezLO4r1+s3+t9j6GAkyZ2EroaG1TWdAXZWduU/UDwpZzZPhmDSGWgWdWuGI359WbnlK2IxYOtp0vPNYSzRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195012; c=relaxed/simple;
	bh=avadB8g9qjqqRwulQIzu5lecW++0n0UMpXPoAJxVaeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBBWN8MGcb80SlWS2Q3eDvCB09huBEERI9CKw1pHBvTi91YLjlBbRycaOnPghH2yMMESQR9iADlLOhJb3EW3LGw5FogSR1ypMuZqNO6VhwZinE3xennKVugkVbiHNBfFLOC4pjW1u+gHwa4OA+BV2iRXtu4Z9k0Yucr2+aMmoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSxRJoJB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475d9de970eso31954835e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195008; x=1762799808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZanATNUPbFaToYEjjeEZY7zqm3TfGXKjQ4xQUPFBYw=;
        b=BSxRJoJB0Pw04WvS13QuqsO0ecXX4xoZ1KLV9C4Vu9HBYDfWc5bBvtB5Kkr9m8xn0K
         kDggvI4UORpCiCiwLaXZO9WOaoges7krCbelrM1dQkCPkxe2op96VxSbZT958tyfkcop
         +/uzOOmhCNqfZgzxUXFpMqgHBeSfTB2qLbrARIMwHjbpLEtqWUjco+MPnJSUTp7AYdG/
         IaIKJ3qIkRud14SSvkNiKl2cticrjuLThdh1metYi4v/VfUNnnT2l+HMWe58qto/VQmQ
         640A5ppAu00RYtb1mjF5adQ4yOK9bDVVWdCbj92ha5NL+SiwvbIreufUvfas+gpb64iy
         nBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195008; x=1762799808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZanATNUPbFaToYEjjeEZY7zqm3TfGXKjQ4xQUPFBYw=;
        b=Cq22GnT6miHo+wyyd7Z73Cki0nUb11hAsNm3cCq1z2R/U+0/xUy+NJqj+jdsfTz+Q4
         wVwXc22U1RIHlIXh+BEqeT9KNhYpH0gASamlVONBQDvTOHXnySG0GaY1/k7A8SiVOK5q
         19djtu3rQqRBISCAzLbo48ZF41SDKko98rFwEQE3QH1IfPteq+r7VD9JyAN9+xjZEjgE
         7MhejzpJ+CQQHVml6NCDinPVBw0XoqDj9fQJhjGxy7iHwcW/j6Xy3qfq3CCpkObNM/UZ
         JzXxWG49Tlht2RUj/5U1PB/wCSUWQaimK+/ECQr/FiretbH0HMJ7xvtfifyYlxioQQSq
         Dqmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjVXb31vFBQP80vV7V/fVit7RgeFCLBKafVEb3Z/keJWfPG12Hg6F3+JcJrwDcA2FFu2Y+EGOyI821H3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEEvom/2kkzi8P4Va60fDh+9prPWSye1TSWgZmBZgjQipa3/P
	Z7y257OJJ6ipY89Kq8elMYui93QdhiQzlLcHKu2KidkLqBxNd+wEROWi
X-Gm-Gg: ASbGnctsWEaBLHOVdIH/b4eThw5QlCDTca0xsUuWCbm7MK1sL2LvB2YORd5MNqRiV56
	CJFFbfVFj5VDaUAop00RFBmVVLb8gF0cqDVVg7pjFvjN/y3uftdeVuavZHlpjXR+SD9hlo8LnJj
	0aUk3+fX6T2t9jrTyuJoT6hchoGlojwprnyt8DI01nFupm/CLesCSbzzARh1rvkW4pTMZUsEebZ
	iVg0peyrjLzsOJO6OxvRESvnyMv88Z7m3zRG4o9F5UUnLLyb5mafwfjPHx32cdcmjJ0IDuR6A46
	wKM53oKmOiei4Myp5dwzI3v/J5kCtfLgp4X8yiI7NsVNN5cNOYUEultsuUbWQtYZi8isoNXQs6M
	utcFsEUz3VYegJRLeap7cKZI08ffNE8CFOX0L/IiYJ95xh3Z4j2nE7fKrmTSsWHYaxXl7VZVfpx
	h4QBFhJEVEyIaXVCzydoU=
X-Google-Smtp-Source: AGHT+IHBT3goG6o5/i+wGgWn6B2Jy5qdG/7qj4PSYlOBOKWqyZ1rxQ3CXxOOnLL5mDuZ4WsPZ6qXHw==
X-Received: by 2002:a05:600c:811a:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-477307c147bmr109383155e9.11.1762195007648;
        Mon, 03 Nov 2025 10:36:47 -0800 (PST)
Received: from [192.168.100.110] ([77.31.161.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm169323925e9.13.2025.11.03.10.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 10:36:46 -0800 (PST)
Message-ID: <e03f4b4e-dc94-4444-8fe0-6c0c18a424d5@gmail.com>
Date: Mon, 3 Nov 2025 21:36:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Content-Language: en-GB
To: Borislav Petkov <bp@alien8.de>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com, x86@kernel.org,
 apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
 Tobias Fleig <tfleig@meta.com>
References: <20251103141002.2280812-1-usamaarif642@gmail.com>
 <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/11/2025 17:45, Borislav Petkov wrote:
> On Mon, Nov 03, 2025 at 02:09:21PM +0000, Usama Arif wrote:
>> v2 -> v3:
>> - Use native_pgd_val instead of pgd_val to fix broken build with allmodconfig.
>>   I wanted to keep the code between pgtable_64.c and x86-5lvl.c consistent
>>   so changed it in both patches
>>   (Borislav Petkov and Ard Biesheuvel)
>> - Commit message improvements (Dave Hansen)
> 
> Did you run the build tests I suggested?
> 

Yes, I did the below build tests:

make LLVM=1 allnoconfig; make LLVM=1 bzImage
make LLVM=1 defconfig; make LLVM=1 bzImage
make LLVM=1 allmodconfig; make LLVM=1 bzImage
make LLVM=1 allyesconfig; make LLVM=1 bzImage

make LLVM=1 ARCH=i386 allnoconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 defconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 allmodconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 allyesconfig; make LLVM=1 ARCH=i386 bzImage

The i386 ones had a failure in lib/math/test_mul_u64_u64_div_u64.c:156:9 for linux-next/master
so I rebased my patches on v6.17 and tested and they all built successfully.



