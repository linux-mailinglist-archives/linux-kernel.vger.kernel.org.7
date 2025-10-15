Return-Path: <linux-kernel+bounces-854798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA2BDF6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C251A4269C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4A305954;
	Wed, 15 Oct 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUDIA8wt"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5733054C2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542628; cv=none; b=ReYhPd29mbTGSTJaLnlxfBFjTXttUqf48VF20nIp3sXqJDUydx9S0lRqZro0koV9gQEFax7IbV+EE/8mH/kuCTPdGm9U03FX9ePMUcHb1S6wuvVyO1axuM40xokjLJHFXhIMUN5yvTVQ+xpuN/0t4n4zZxAIYja+PvfzdRzwJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542628; c=relaxed/simple;
	bh=W+H56aOPbolPmKRStRwB5QPH/LtPDKOBRBsosmOXFp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKrfbYI0enU00I/k5Cjm/iJz8wORW/kd1MEYlkBHU0VuYcPiTM/9woROvv4IRhkAcj3iDDe3Xv0j3jzciUp5lwQIimr8x6cqRNSGO4UDQkiin0DKKp16PzVISi2fx/VBH245MfslHVZ59dCp1rYQ11nDKxn0OHDLFaTrZPrlR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUDIA8wt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33082aed31dso6994522a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760542626; x=1761147426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnBAgCmbYNml3zpTyyPbm6K/u2+pZyuZXQIZmUzghcw=;
        b=OUDIA8wt8uJOq2gaAXwISyyq+H5P/vhhBv3sKZLmuZrPLLxjXkJXOsj5ZbuaApLE47
         UceNTSuU703T4TZ38pylpaPhWqtuAAzdJ/m76KvbrFxvsnvOXN8M6UIdtEXkjqSFAk0+
         if8N7+xUgq4L6ECnuIOZq7Rl5P0dGRbGF3mFce0G+bsxGorpcTVQojOmnCBNfIRRdDSg
         j2EW5dteOkyBRYUch0KnhzSuNAKbY+ImBwrwG533O2JxTE5et4ibnyhhOIoLohyZn8Lj
         mxyAU9npH+zF5SYaRJWzBlM8e7GX1ueY8towGWt9uPqJMTOplC9tXigFySaVzV6OSSZ9
         CXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760542626; x=1761147426;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnBAgCmbYNml3zpTyyPbm6K/u2+pZyuZXQIZmUzghcw=;
        b=mHQ9fkevK3wTQeiMhDLE7Ceb31vujhaWRqewmt9IZuXWLxaMekcvRecRTQELUjHul8
         Wu1Myo2AgH/7qwx74tOcS15cLZPTA+GRGtSHh1MpNpBmzQxKxPJFJOJYJWn8UU37E30b
         KGEU5P/7D5Gg5cVSWIbPBfzRX08Z7kq3JjwN1NOblOPUcKBM32v4my2bksbhT4hlCKGE
         jmWKahhAWSAO2zyqdDmNV0rJdo9kpFB17VPNzYSj72AWFEjtGv16tephJPwF5/Oc9CdK
         oLdIM9kqRrmV3FdMAsoM97OGFpZ05lb68vlsfUsaE/l+vwXazx//38AJkB8otLXLCYQB
         4ECg==
X-Forwarded-Encrypted: i=1; AJvYcCXIzvo1RQnYaF6zZDX5WZsBLALFEtAYmCaMm4Y60nyXR1WkoyQSLcBY9ED84++Ma2n/bkjmIN81NjAAGWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXq4apw4550rdK1yzCxLY74iuj0BO433HLXbbzThHYpXztAlA3
	SEs9x08nnEKHf5LUbmm+RHF4/1CJK/ORk2dd+agtI9I0w2WL8rUgj0dc
X-Gm-Gg: ASbGncv+sJ0HtyABBAYIxt0+O9/e7keOzQI/mK0Xntf7haa7E1scPQioNhrpbGxSBOI
	d+UPoIeEubINEe+asR7sXkKiT0vt/M+ipIMY8FQ/bAxsJDovA59n4W//LiZF88i2RIL2hy+9R8D
	9wL1WTGSHoa3Ne+DjFvO0l8Oj8HdMP6/vhHF9IvV3mT+BE3UXAMkD2AsO8qVTaUqb7Bfa2zx/Y2
	nM8foODyOOjPdznwG/TGY24E0J3m3iGrm+7Hlbz0dkvDFxAb4g4YR9UPczJyMCKgon0MucstULi
	tQMGYW3XucUWBjO7zxnaf9rlJ1xUH09eyiX85pq7KMDswOrGaYdFgzEqC82xzs33XDvF3NnXxs6
	TcuS+A15incirCxVAhToYp1AM0cYkZM2pBRN+qsT8Dtk5d2egZONPTSw57j/lF4qF5xNJ1WYQVh
	X2Z3ddGw55mluABR4t
X-Google-Smtp-Source: AGHT+IEJjooXXaZhfIzd8Ul2LkbtfQbQZORtByVAe67pEeQe57Gz2lveZjTzB8fnkfh/VdT1hhQLNg==
X-Received: by 2002:a17:90b:1e0a:b0:32b:aee1:18d5 with SMTP id 98e67ed59e1d1-33b5138e670mr33927500a91.29.1760542625939;
        Wed, 15 Oct 2025 08:37:05 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b0ed20sm20427756a91.23.2025.10.15.08.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 08:37:05 -0700 (PDT)
Message-ID: <192bc74d-90d8-45ae-a324-6c29ccae2a06@gmail.com>
Date: Wed, 15 Oct 2025 21:06:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gpuvm: Fix kernel-doc warning for
 drm_gpuvm_map_req.map
To: bbrezillon@kernel.org, himal.prasad.ghimiray@intel.com, dakr@kernel.org,
 matt.coster@imgtec.com, robin.clark@oss.qualcomm.com,
 matthew.brost@intel.com, aliceryhl@google.com,
 thomas.hellstrom@linux.intel.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, simona@ffwll.ch, skhan@linuxfoundation.org,
 khalid@kernel.org, david.hunter.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20251015113656.21447-1-spyjetfayed@gmail.com>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <20251015113656.21447-1-spyjetfayed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/15/25 6:56 PM, Matt Coster wrote:
 > On 15/10/2025 12:31, Ankan Biswas wrote:
 >> The kernel-doc for struct drm_gpuvm_map_req.map was added as '@op_map'
 >> instead of '@map', leading to this warning during htmldocs build:
 >>
 >> WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not 
described in 'drm_gpuvm_map_req'
 >>
 >> Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
 >> Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
 >> Signed-off-by: Ankan Biswas<spyjetfayed@gmail.com>
 > Hi Ankan,
 >
 > Thanks for the fix! Is there a public report from Stephen that you can
 > link to with a Closes: tag after the Reported-by: tag (see [1])?

Hi Matt

Thanks for pointing that out, I have added the Closes tag for v3.
And resent it.

 >
 > Otherwise, this looks good to me and I'll be happy to R-b and take it
 > via drm-misc-fixes.


On 10/15/25 7:09 PM, Danilo Krummrich wrote:
 > On 10/15/25 1:31 PM, Ankan Biswas wrote:
 >> The kernel-doc for struct drm_gpuvm_map_req.map was added as '@op_map'
 >> instead of '@map', leading to this warning during htmldocs build:
 >>
 >> WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not 
described in 'drm_gpuvm_map_req'
 >>
 >> Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
 >> Reported-by: Stephen Rothwell<sfr@canb.auug.org.au>
 > Please add a Closes: tag, checkpatch.pl should warn about this.
 >
 > Thanks,
 > Danilo

Hi Danilo,

My bad, I did not use checkpatch.pl before sending, I didn't know
it also caught missing tags. Thanks for mentioning it.


Best Regards,
Ankan Biswas

