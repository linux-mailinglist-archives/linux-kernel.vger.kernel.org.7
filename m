Return-Path: <linux-kernel+bounces-814834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15BAB5591F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6B43AD786
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0127A47C;
	Fri, 12 Sep 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwyCdPw2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62957257820
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715914; cv=none; b=Ya4Egf8vWhK425gBvyz1M70mksplkLhymnUqIZJO2kA9pU9IhIf/aBCRIBWnmzBmqJbvX/Xf+cOgZDeybPzyukQWDOPk1513475otuHyu5zGpPofNVb6r/uaNBu/zVsv1igDuzlAu8/91RBIBLSGGVXW7Eoxee7ScxN6e8d9cXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715914; c=relaxed/simple;
	bh=iTr7M893E4gTqL49aZVHGGZS32qlPZ3IW8d9Y0OSJ2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceDWafwolv6coFFIwaKODZkK9tN2qCk0H+mu+5eRQLdffAI/dhKX+uudcjojKInSf3RoPov/uwlvLt4jrHi6l2pG7qH7aVVfY508rS/s6WnugrPrMR8/JXLfLD8Ohjk9rhErwWEzY+wvDnAN/oFnJPvbBe3i2LrGbPPA4gTPdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwyCdPw2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256e75eacso2237678b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715913; x=1758320713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KLKlGBJI1d0fx9t2uSJ4mzy0rd5NfzB4VUuG4EkoD8=;
        b=iwyCdPw2AR0kWzu9CltuNd4ZRhbIMADpxB2LlNzCMaXf+i85MtPzztjUB0Yz6PA9Re
         7UsEiAC/AdanZ3JNj90V0KMFJCeqI6y8txmzPlKhG2AA9NhCiydKp2TPiWNcfCSckWLH
         XYjGYN9j4Lv2zMmxNHP/lhV6JQ/nXAly+IEGXSq9LjQr5NWLyXaDvrg8uxtTuN/6rTtJ
         oq/UJvqGHqx2XrXqmRs6J0y5UxTNDANBzQIvDNCdqrLmt/H5WtQwqI99g+YQ0h++9tuX
         nNbK1sxBiOK8q4ZaqMbEMsJ0yu7RB6a47mC3cSOzZPyItMjSoAmzzDRfmxUEYrOvUcNK
         dzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715913; x=1758320713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KLKlGBJI1d0fx9t2uSJ4mzy0rd5NfzB4VUuG4EkoD8=;
        b=OK2H50gNT5OS9O25ZGGajQuUMRd8PcCeZlw9r28GGVSrQxYzJU8kMiYrrHGRJ+dUKD
         U8UwmWav2eGMfA1MzKYYtRugsnD+BF4km973pWl6zCCPZkOlfsMullCa9CwNRTpKStGd
         +C0+UwkDVmPp3mEKhFLFLcO4Tc1CaxNQAbRCAjU713KeerPVLQ2XHZb5VupW2xzL2+Ks
         9ouKgVPl9wG0TabttLoY5rckmQlbtz66UnW6Yjdd99UlndDJgk+V/1wY3fKC+HGJo03t
         I6NR1Vles/TOPjfJr6iomaQZVlq0TnCjlW7sx7Fc4vObBaw9FCu9RzKlH+g3kwzJRD3B
         75BA==
X-Gm-Message-State: AOJu0YzEPzS0XW4W2jhvwNlWDLANdPULE5jvkf0Wr4E7cBTw1Qv7vuG5
	00NpK4LOp+kd6Aqs14JXRi1KOkkvGvpAs6GmzvP7iajcf/JOkfMBzg1Z
X-Gm-Gg: ASbGncsYDR7G+S3v5xUQ8cWsx5b9aM0BlomNuU7XnNqaix8+npgalnBPBgYdDtXdebz
	IpcMsySPcGW49J4Irzv472JTv6HuZSL3msQyt+baXtoYtgm+0v3u2UKpKKGAxPXyefBdb0Fenqw
	oICK1weAb4NQRVgwAwTHJ+cI8MQufoQnz+1RwtmTd/zqlTTIWb0GLW7Tz3+uC2DYmp7xXpKOisX
	pDiY/I/lDTbvoQiaw9Xw2qEzlwNDaHUteGgWfyXgbtZEMFYpki50O5NawVcwdTON/7DbygMtanm
	G069m03BF9iC8SZRxgRsUONZtGY5Anww2TUgWeYSnj114NGkuqWvEFwai9jcwe+X5r5V3vOiJba
	UxNPXDcoTptMbeMHaPjvosdBONqMtV7/OCsMkDTt+nSJW
X-Google-Smtp-Source: AGHT+IHurQvXunsL/HJ9vmn0CKdkJYzOpZYBsq2mAMEb4zKVK5+W5oEbdRBLo7URkB3G7O+IBF1fVw==
X-Received: by 2002:a17:903:2410:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-25d24e9df3dmr43777705ad.22.1757715912450;
        Fri, 12 Sep 2025 15:25:12 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a5c0sm58194845ad.71.2025.09.12.15.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 15:25:11 -0700 (PDT)
Message-ID: <0680f2fa-e583-4b7d-a1ff-9fcd4c5a8269@gmail.com>
Date: Sat, 13 Sep 2025 05:25:06 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm: Add directive to format code in comment"
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Garcia <rampxxxx@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250912130649.27623-2-bagasdotme@gmail.com>
 <e0252635-4dc4-483a-911a-fee5a36c19c3@kernel.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e0252635-4dc4-483a-911a-fee5a36c19c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/25 04:27, Danilo Krummrich wrote:
> On 9/12/25 3:06 PM, Bagas Sanjaya wrote:
>> Commit 6cc44e9618f03f ("drm: Add directive to format code in comment")
>> fixes original Sphinx indentation warning as introduced in
>> 471920ce25d50b ("drm/gpuvm: Add locking helpers"), by means of using
>> code-block:: directive. It semantically conflicts with earlier
>> bb324f85f72284 ("drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
>> usage in literal code block") that did the same using double colon
>> syntax instead. These duplicated literal code block directives causes
>> the original warnings not being fixed.
>>
>> Revert 6cc44e9618f03f to keep things rolling without these warnings.
>>
>> Fixes: 6cc44e9618f0 ("drm: Add directive to format code in comment")
>> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Need me to pick this one up? Otherwise,
> 

Of course!

-- 
An old man doll... just what I always wanted! - Clara

